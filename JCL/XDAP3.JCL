//Z030199A JOB ,'Brandon Tweed',REGION=2M
/*JOBPARM ROOM=199,L=5
//STEP1 EXEC HLASMCG,CPARM='NOESD,NOMXREF,NORLD,NOUSING,NOXREF',
//      LPARM='NOMAP,NOPRINT',
//      GPARM='STOW,ABEND,STIMER,CLOSE,BLDL'
//ASM.SYSLIB DD
//           DD
//           DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR
//SYSIN DD *
         EQUCCWS
**********************************************************************
* CCW MACRO
* When invoked, defines storage for a CCW.
**********************************************************************
         MACRO
&NAME    CCW  &CMD,&BUF,&FLAG,&LEN
&NAME    DC   0D'0',AL1(&CMD),AL3(&BUF),AL1(&FLAG),X'0',AL2(&LEN)
         MEND         
*
         PRINT NOGEN
         DCBD  DSORG=(BS,PO,PS)
         PRINT GEN
*********************************************************************
* XDAP
* Date: 12/02/2004 
* Brandon Tweed
* Instructor: Rannie
* TA: Dash
*
* Register usage:
* R7,R8 - Used for progression through parms.
*********************************************************************
SPXD     CSECT                         Start of SPAM
         STM   14,12,12(13)            Entry Linkage
         LR    12,15                   Entry Linkage
         USING SPXD,12                 Entry Linkage
         LA    14,SPXDSAV              Entry Linkage
         ST    13,4(,14)               Entry Linkage
         ST    14,8(,13)               Entry Linkage
         LR    13,14                   Entry Linkage
br         ST    1,PARM@                 Save address of parms
*
* Set Timer
*
         STIMER REAL,TIMEXIT,DINTVL=INTERVAL
*
* OPEN all DCBs
*
         OPEN  (Q,INPUT,X,INPUT,S,OUTPUT)
         LTR   15,15                   Test Return Code
         BNZ   DCBPROB                 If RC!=0 ABEND
         TM    Q+X'30',X'10'           Test Q DCB for open
         BZ    DCBPROB                 If not open, ABEND
         TM    X+X'30',X'10'           Test B DCB for open
         BZ    DCBPROB                 If not open, ABEND
         TM    S+X'30',X'10'           Test S DCB for open
         BZ    DCBPROB                 If not open, ABEND
*
* Locate and print the JCL parms using SNAP
* Postcondition:
* R8 = @ End of parm data
* R7 = @ Start of Parm data
*
         XR    7,7                     Clear 7 (ptr to start data)
         XR    8,8                     Clear 8 (ptr to end data)
         ICM   7,X'7',PARM@+1          Get @ the PARM area
         ICM   7,X'7',1(7)             Get @ halfword len
         LH    8,0(,7)                 Get length of PARM
         LA    7,2(,7)                 Get @ actual PARM data
         AR    8,7                     Calculate End of Parm
*
* Print out information about JCL parms
*
         MVC   LINEOUT(50),MSG542      Move XXXI Message to PL
         BAL   11,WRITELN              Write header for the SNAP
         SNAP  DCB=S,STORAGE=((7),(8)) Dump JCL parms
         LTR   15,15                   Check if RC=0
         BAL   14,BNZ#7BDT             If it wasn't SNABEND
*
* Set up the parm loop
* R7 = Current position in Parm
* R8 = End of Parms
*
OUTRLOP  CR    7,8                     Check for end of PARM
         BNL   FINALQ                  No parms? End program
         LA    6,PARMN                 Get @place to store parm
         MVI   PARMN,X'40'             Initialize first space
         MVC   PARMN+1(7),PARMN        "Ripple" the blank
*
* Get a single parm from list
*
PARMLOP  CR    7,8                     Check for end of PARM
         BNL   EOPARM                  yes? goto end of parm
         CLI   0(7),C','               Check for end of a single parm
         BE    EOPARM                  yes -> handle end of parm
         MVC   0(1,6),0(7)             Copy a character of the parm
         LA    7,1(,7)                 Advance in parm list
         LA    6,1(,6)                 Advance in PARMN
         B     PARMLOP                 Continue until parm processed
*
* Put name into the BLDL table and check if member
* exists
*
EOPARM   MVC   BLDLTAB+4(8),PARMN      Put PARM into BLDL table
         BLDL  X,BLDLTAB               Build BLDL table for 1 entry
         LTR   15,15                   Check RC=0 from BLDL
         BNZ   BLDLPROB                If not OK, abend
         MVC   STTTRK(4),BLDLTAB+12    Get TTRK from BLDLTable
*
* Snap the BLDL table and the XDAP DCB
*
         MVC   LINEOUT(50),MSG534      Set up the print line
         BAL   11,WRITELN              Print the print line
         SNAP  DCB=S,STORAGE=(BLDLTAB,Q)  Q marks end of BPAM DCB (B)
         LTR   15,15                   Check RC=0 from SNAP
         BAL   14,BNZ#7BDT             If Not Zero, SNABEND
*
* Print the name of the member
*
         MVC   LINEOUT(50),MSG535      Set up print line
         MVC   LINEOUT+50(8),PARMN     Put member name on print line
         BAL   11,WRITELN              Print the line         
*
* Perform the TTRK to MBBCCHHR conversion on the stored TTRK
* First time, processes first track
* Also used to repeatedly do conversions when needed
*
NXTTRACK STM   0,15,MUMSAVE            Save regs from being altered
         L     15,76                   Get @CVT
         L     15,X'1C'(,15)           Get @conversion rtn
         ICM   0,15,STTTRK             Get TTRK -> R0
         L     1,X+X'2C'               Get A(DEB)
         LA    2,MBBCCHHR              Get @mumble
         LR    6,12                    Save R12 (may be altered)
         BALR  14,15                   BRANCH TO DO CONVERSION
         LR    12,6                    Restore 12 for addressability
         LTR   15,15                   Check return code
         BNZ   CONVFAIL                IF NZ then ABEND
         MVC   ANECB+X'24'(8),MBBCCHHR Move mumble to IOB+X'20'
         L     6,ANECB+X'28'           Get 2nd half of mumble
         AHI   6,-1                    Decrease R by 1
         ST    6,ANECB+X'28'           Put 2nd half back
         LM    0,15,MUMSAVE            Restore regs altered
*
* Beginning of physical read (XDAP) loop
*
DOREAD   DS    0H                      Do physical read (XDAP)
CLEAR    XC    ANECB(4),ANECB          Clear the ECB
STARTIO  XDAP  ANECB,MF=E              Perform the read
NOWWAIT  WAIT  ECB=ANECB               Wait until read is done
*        BAL   11,CNVRTN               Convert S# and R# for pline
         TM    ANECB+X'10',255-CE-CUE-DE-UE-UC  CHECK 4 BAD BITS
         BNZ   BADBITS                 If so, ABEND
         TM    ANECB+X'11',255-IL      Check for incorrect length
         BNZ   ILBIT                   If so, ABEND
         CLI   ANECB,X'7F'             Test W-P
         BE    CHKCSW                  If '7F' check CSW and move on
         CLI   ANECB,X'41'             Check W-P
         BNE   POSTBAD                 If not X'41' Die
         TM    ANECB+16,X'01'          Test for unit exception
         BO    BSEOF                   If unit exception bit, EOF
         TM    ANECB+16,X'02'          Test for unit check
         BZ    CHKCSW                  If not, check CSW
CHKCSW   DS    0H                      Check CSW (channel program OK)
         LA    5,MYCOUNT               Get @ after last CCW (@MYCOUNT)
         C     5,ANECB+12              Compare two addresses
         BNE   CSWNE                   If not equal, ABEND
*
* Now test if R in mumble from IOB is greater than
* R in the count field of the next record read in by CCW5.
*
         CLC   ANECB+X'2B'(1),MYCOUNT+4  Compare R in mumble vs 8 byte
         BNH   RPLUS1                    If Rm > R8b, new track
         CLI   MYCOUNT+4,X'01'           Check Rs
         BE    EOT                     If the same, then track change
         B     RSNE                    If not, something wrong, die
RPLUS1   L     6,ANECB+X'28'           Get 2nd half of mumble
         AHI   6,1                     Increment R by 1
         ST    6,ANECB+X'28'           Save 2nd half mumble   
         CLC   BUFFER+9(5),ISMACRO     Do the check
         BNE   NOPAGE                  If not 'MACRO' no new page
         MVI   MSG531,C'1'             Set CC for new page
NOPAGE   LH    5,MYCOUNT+6             Get max block size
         LA    6,80                    Get Logical Rec Size
         LA    4,BUFFER                Get address XDAP buffer
CORELOOP MVC   BSBUFF(80),0(4)         Copy 80 bytes from Big buffer
         GET   Q,QSBUFF                Do QSAM read
         B     GOON2                   If not EOF, continue
         B     QSEOF                   If QSAM EOF, do EOF stuff           
GOON2    CLC   QSBUFF(80),BSBUFF       Compare buffer contents
         BAL   14,BNE#7BDT             If not Same, SNABEND
         BAL   11,CNVRTN               Call conversion routine
         MVC   LINEOUT(50),MSG531      Copy MSG531 to print line
         MVC   LINEOUT+38(2),PLS       Put Sector # on print line
         MVC   LINEOUT+44(2),PLR       Put Record # on print line
         MVC   LINEOUT+50(80),BSBUFF   Copy buffer contents to pline
         BAL   11,WRITELN              Call print routine
         MVI   MSG531,C' '             Insert single space
         LA    4,0(6,4)                Move forward in buffer
         SR    5,6                     Decrement # bytes                 
         LTR   5,5                     More records?
         BP    CORELOOP                Yes, loop again. 
*
* At this point the physical buffer is exhausted, read next block
*
         MVI   MSG531,C'0'             D.S. between physical records
         B     DOREAD                  Hit this point? READ another one
*
* Loop, grap new parm, read another member
*
NXTPRM   AHI   7,1                     Move past ',' in parm list
         B     OUTRLOP                 Redo the whole shebang
**********************************************************************
* THIS DOES THE FINAL QSAM READ
**********************************************************************
FINALQ   GET   Q,QSBUFF                Get another QSAM logical record
         B     QSPROB                  Not EOF? QSAM problem
         B     QSEOF                   EOF, handle QSAM EOF
**********************************************************************
* END OF TRACK PROCESSING (EOT)
*
* Do *NOT* modify registers 7 or 8!
*
* Accounts for a change of track
**********************************************************************
EOT      DS    0H                      END OF TRACK PROCESSING
         XR    6,6                     Zero register 6
         ICM   6,3,STTTRK              Get saved TTRK
         LA    6,1(,6)                 TT = TT + 1
         STCM  6,3,STTTRK              Save incremented TTRK
         XR    6,6                     Zero R6
         LHI   6,1                     Set R6 to 1
         STC   6,STTTRK+2              Set R to 1
         MVI   SECTOR,X'00'            Set sector to X'00'
         MVI   MSG531,C'-'             Set CC for new track
         B     NXTTRACK                Now process updated TTRK
*
* ABENDs for problems encountered in testing
*
DCBPROB  ABEND 897,DUMP      Problem opening DCBs, DUMP
QSPROB   ABEND 897,DUMP      Dump if QSAM doesn't hit EOF
BLDLPROB BALR  14,0          abbreviate dumps for BLDL problem
         B     SNABEND       call SNABEND routine
         ABEND 897,DUMP      Dump if BLDL screwed up
GENABN   ABEND 987,DUMP      Die a horrible death
TIMEXIT  ABEND 798,DUMP      Timer Exit Routine Induces Dump
BADBITS  BALR  14,0          Die if bad bits
         B     SNABEND
ILBIT    BALR  14,0          Die if Incorrect length
         B     SNABEND
POSTBAD  BALR  14,0          Die if post code not 7F or 41
         B     SNABEND
CSWNE    BALR  14,0          CCW @ and CSW @ not equal
         B     SNABEND
RSNE     BALR  14,0          Die if Rs not equal or R1 > R2
         B     SNABEND
CONVFAIL BALR  14,0          Die if mumble conversion failed
         B     SNABEND
*
* R14 Error Tracking Stubs
*
BNE#7BDT EQU   BNZ#7BDT      BNE and BNZ are the same
BNZ#7BDT BNZ   SNABEND       Go to SNABEND Routine if zero
         BR    14            Otherwise Go back
*
* BSAM End of File routine
*
BSEOF    MVC   LINEOUT(50),MSG533      Move message 533I to PL
         BAL   11,WRITELN              Print the message
         B     NXTPRM                  End of BSAM means end of QSAM
*
* QSAM End of File routine
*
QSEOF    MVC   LINEOUT(50),MSG532      Move QS EOF message to PL
         BAL   11,WRITELN              Print the message
         MVC   LINEOUT(50),MSG539      Move message 539I to PL
         BAL   11,WRITELN              Print the message
         B     SNABEND                 End of QSAM = done, end pgm 
*
* If member not found in PDS, print error message
* and move to next parm
*
MNOTFND  MVC   LINEOUT(50),MSG540      Move 'not found' msg to pl
         MVC   LINEOUT+50(8),BLDLTAB+4 Put member name on PL
         BAL   11,WRITELN              Print the message
         B     NXTPRM                  Process next parm
*
* EOF Routines for DCBs
*
QEODAD   B     4(,14)        Return to following instruction
*
*********************************************************************
* SPXD WORKING STORAGE
*********************************************************************
*
RECSIZE  DC    H'0080'       Record size of 80
BLKSIZE  DC    H'3200'       Size of the physical block
SECTOR   DC    X'FF'         Sector information
MUMSAVE  DC    16F'0'        Save area for MUMBLE conversion rtn
MBBCCHHR DC    D'0'          Place for storing the mumble
STTTRK   DC    F'0'          STORED TTRK FROM BLDL
PLS      DC    XL2'0'        Sector # for print line
PLR      DC    XL2'0'        Record # for print line
ISMACRO  DC    CL5'MACRO'    For checking if new MACRO
PARM@    DC    F'0'          Address of incoming PARMs
PARMCARD DC    CL80' '       Incoming PARMs for program (copy)
PARMN    DC    CL8' '        Info on parm card between commas
VAL32    DC    F'32'         For subtracting
INTERVAL DC    D'0'          Double word for time Interval
         ORG   INTERVAL      Redefine INTERVAL
         DC    ZL8'00010000' HHMMSSth (1 minute)
SPXDSAV  DC    18F'-1'       Spam Save Area    
*
XDAPMF#L XDAP  ANECB,RI,X,,,(),,SECTOR,MF=L
*
* Appended CCWs follow
*********************************************************************
         ORG   *-8           Redefine starting with 3rd CCW
*
CCW3     CCW   X'1E',MYCOUNT,X'80',8   Redefined CCW3
CCW4     CCW   0,BUFFER,X'60',3200     Appended CCW4
CCW5     CCW   X'22',SECTOR,0,1        Appended CCW5
*
MYCOUNT  DC    D'0'          My 8 byte count field
         EJECT
*********************************************************************
* WRITELN - WRITE THE HEADER
*
* Since W DCB is no longer being used, prints out using XPRNT
*********************************************************************
*
WRITELN  DS   0H                       WRITELN routine start
         XPRNT LINEOUT,133             Print the damned output
         MVI   LINEOUT,X'40'           Set CC for line buffer
         MVC   LINEOUT+1(132),LINEOUT  Blank the line buffer
         BR    11                      Return from write routine
*
LINEOUT  DC    CL133' '                Output buffer (for printing)
*
*********************************************************************
* CNVRTN
* Routine for converting Rec # and Sect # to display format and
* putting them on the print line
*
* Precondition: SECTOR Contains a Sector #
*               Record number is in ANECB+X'2B' 
*               (most recently used MBBCCHHR)
*
*********************************************************************
*
CNVRTN   UNPK  TMPUNPK(3),ANECB+X'2B'(2) Unpack R
         MVC   PLR(2),TMPUNPK          Move it to print line
         TR    PLR(2),TRANSL           Translate to make printable
         UNPK  TMPUNPK2(3),SECTOR(2)   Unpack Sector #
         MVC   PLS(2),TMPUNPK2         Move it to print line
         TR    PLS(2),TRANSL           Translate to make printable
         BR    11                      Return to hell
**********************************************************************
* CNVRTN WORKING STORAGE
**********************************************************************
TRANSL   DC    256C' '                 256 bytes of wastes space
         ORG   TRANSL+X'F0'            Go to first position in table
         DC    C'0123456789ABCDEF'     wasted space actually used
TMPUNPK  DC    XL3'000000'             For unpacking stuff
TMPUNPK2 DC    XL3'000000'             2nd place for unpacking
         EJECT
*********************************************************************
* SNABEND ROUTINE
*
* Save all the registers
* Do an XSNAP of the XDAP program
* Terminate program via SVC 3
*
*********************************************************************
*
         ORG   SPXD+((*-SPXD+31)/32*32) Al		ign 32n
SNABEND  STM   0,15,SNABSAVE      Save all registers
         SNAP  DCB=S,STORAGE=(SPXD,SPXDEND),PDATA=(PSW,REGS,SA),       X
               SDATA=(DM,IO)
         LTR   15,15              Test SNAP RC
         BNZ   ABN4095            If not zero, dump
         SVC   3                  Else, terminate using SVC 3
ABN4095  ABEND 4095,DUMP          ABEND inside SNABEND
*
*********************************************************************
* SNABEND WORKING STORAGE
*********************************************************************
*
SNABSAVE DC    16F'-88'      Save area for SNABEND
         DC    CL32'SNABSAVE SAVE AREA ABOVE'  Label SNABSAVE
*
*********************************************************************
* Output Messages
*********************************************************************
*
MSG531   DC    CL50'-XDAP BDT531I The XDAP record is:  S#:   R#:      '
MSG532   DC    CL50'-XDAP BDT532I EOF Encountered on QSAM file.       '
MSG533   DC    CL50'-XDAP BDT533I EOF Encountered on SPAM file.       '
MSG534   DC    CL50'-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:    '
MSG535   DC    CL50'-XDAP BDT535I Member name used in FIND/BLDL is:   '
MSG538   DC    CL50'-XDAP BDT538I SNAP dump of PARMs for subpool 0:   '
MSG539   DC    CL50'-XDAP BDT539I Pgm complete, SNAP dump follows:    '
MSG540   DC    CL50'-XDAP BDT540I Non-existing FIND name is:          '
MSG541   DC    CL50'-XDAP BDT541I SNAP of Lowmem, CVT, SVCFLIH, TCB:  '
MSG542   DC    CL50'-XDAP BDT542I GPARM given for pgm:'
MSG543   DC    CL50'-XDAP BDT542I Not defined'
MSG544   DC    CL50'-XDAP BDT544I Not defined'
MSG545   DC    CL50'-XDAP BDT545I Not defined'
*
*********************************************************************
* A BLDL Table set up to accommodate
* 1 Entry in the list ( H'1' )
* Length of 60 bytes for each entry ( H'60' )
* 60 bytes allocated for:
* NAME   - 8 bytes
* TTRKZC - 6 bytes
* 46 bytes of 'User Space'
*********************************************************************
*
         ORG   SPXD+((*-SPXD+31)/32*32)     Align 32n
BLDLTAB  DC    H'1',H'60',CL60'0'           Table for BLDL
*
*********************************************************************
* DCBs 
*
* X - DCB for use with XDAP
* Q - DCB for use with QSAM
* W - output DCB
*
*********************************************************************
*
X        DCB   DSORG=PO,MACRF=E,DDNAME=LIBFILE
Q        DCB   DSORG=PS,MACRF=GM,EODAD=QEODAD,DDNAME=SEQFILE,BUFNO=3
W        DCB   DSORG=PS,MACRF=W,BLKSIZE=133,LRECL=133,RECFM=FA,        X
               DDNAME=OUT2
S        DCB DSORG=PS,MACRF=W,BLKSIZE=882,RECFM=VBA,LRECL=125,         X
               DDNAME=OUT2 
* 
* Buffers for Logical Reads
*
BSBUFF   DC    CL80' '       Buffer for BSAM Logical READ
QSBUFF   DC    CL80' '       Buffer for QSAM Logical READ
*
* Big Buffer for XDAP
*
BUFFER   DC    3200C' '      Define 3200 byte buffer
SPXDEND  DC    CL32'END OF SPXD'  Mark end of SPAM
         END   SPXD          End of SPAM
/*
//GO.LIBFILE DD DSN=T90RPR1.CS468PUB.PDS6,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS8,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS5,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS9,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS7,DISP=SHR
//*
//GO.SEQFILE DD DSN=T90RPR1.CS468PUB.PDS9(STOW),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS8(ABEND),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS5(STIMER),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS7(CLOSE),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS6(BLDL),DISP=SHR
//*
//GO.OUT2 DD SYSOUT=*
//GO.SYSUDUMP DD SYSOUT=*
//
