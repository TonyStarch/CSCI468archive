//Z030199A JOB ,'Brandon Tweed',REGION=2M
/*JOBPARM ROOM=199,L=5
//STEP1 EXEC HLASMCG,CPARM='NOESD,NOMXREF,NORLD,NOUSING,NOXREF',
//      LPARM='NOMAP,NOPRINT',
//      GPARM='ABEND,STIMER,SAM,BLDL,STOW,CLOSE'
//SYSIN DD *
         PRINT NOGEN
         DCBD  DSORG=(BS,PO,PS)
         PRINT GEN
*********************************************************************
* SPAM 
* Date: 4/1/2005
* Instructor: Rannie
* TA: Yeoman
*********************************************************************
SPAM     CSECT                         Start of SPAM
         STM   14,12,12(13)            Entry Linkage
         LR    12,15                   Entry Linkage
         USING SPAM,12                 Entry Linkage
         LA    14,SPAMSAV              Entry Linkage
         ST    13,4(,14)               Entry Linkage
         ST    14,8(,13)               Entry Linkage
         LR    13,14                   Entry Linkage
         ST    1,PARM@                 Save address of parms
         MVC   PARMCARD(80),0(1)       Copy incoming parms
*
* 1) Set Timer
*
         STIMER REAL,TIMEXIT,DINTVL=INTERVAL
*
* 2) OPEN all DCBs
*
         OPEN  (Q,INPUT,B,INPUT,W,OUTPUT,S,OUTPUT)
         LTR   15,15                   Test Return Code
         BNZ   DCBPROB                 If RC!=0 ABEND
         TM    Q+X'30',X'10'           Test Q DCB for open
         BZ    DCBPROB                 If not open, ABEND
         TM    B+X'30',X'10'           Test B DCB for open
         BZ    DCBPROB                 If not open, ABEND
         TM    W+X'30',X'10'           Test W DCB for open
         BZ    DCBPROB                 If not open, ABEND
         TM    S+X'30',X'10'           Test S DCB for open
         BZ    DCBPROB                 If not open, ABEND
*
* 3) Produce CB Dumps
*    (a) low memory from 0 through X'230'
*    (b) CVT using address from X'4C' (dump 32 bytes before CVT)
*    (c) SVC FLIH (address from SVC New PSW)
*    (d) My TCB starting 32 bytes in front for a length of 392 bytes
*
* Reg usage:
* R3 = A(CVT)
* R4 = A(CVT) for retrieving TCB later
* R5 = A(End of CVT)
* R6 = A(SVCFLIH) from SVC New PSW
* R7 = A(SVCFLIH)+256
*
         L     3,76                    Get @CVT
         L     4,16                    Get @CVT
         CR    3,4                     Make sure CVT@s the same
         BNE   CVTPROB                 If not, something wrong
         S     3,VAL32                 32 bytes before @CVT
         LA    5,X'480'(,3)            Find end for dumping CVT
         L     6,X'64'                 Get @SVCFLIH from X'64'
         LA    7,256(,6)               Get @SVCFLIH + 256 
         L     4,0(,4)                 Get @TCBWORDS
         L     4,4(,4)                 Get @(TCB)
         S     4,VAL32                 Step back 32 bytes
         LA    8,392(,4)               Get @ for end of TCB dumping
*
* Print header for the SNAP
*
         MVC   LINEOUT(50),MSG541      Move message to output buffer
         BAL   11,WRITELN              Write output message/header
*
* Set the FPRs to values specified in SPAM handout
*
         LD    0,D248                  Load FPR 0 = +248
         LD    2,DM524                 Load FPR 2 = -524
         LD    4,D760                  Load FPR 4 = +760
         LD    6,DM1027                Load FPR 6 = -1027
*
* Do the SNAP
*
         SNAP  DCB=S,STORAGE=(0,X'230',(3),(5),(6),(7),(4),(8)),       X
               STRHDR=(HDR1,HDR2,HDR3,HDR4)
         LTR   15,15                   Check return code
         BAL   14,BNZ#7BDT             If not zero, blow up
*
* Use SPM to set Program Mask to F without modifying CC
*
         L     7,PMASK                 Get new PM
         SPM   7                       Set mask without changing CC
*
* Locate and print the JCL parms using SNAP
* Postcondition:
* R8 = @ End of parm data
* R7 = @ Start of Parm data
*
         XR    6,6                     Clear 6 (ptr to parm area)
         XR    7,7                     Clear 7 (ptr to start data)
         XR    8,8                     Clear 8 (ptr to end data)
         ICM   6,X'7',PARM@+1          Get @ the PARM area
         ICM   7,X'7',1(6)             Get @ halfword len
         LH    8,0(,7)                 Get length of PARM
         LA    7,2(,7)                 Get @ actual PARM data
         AR    8,7                     Calculate End of Parm
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
         LA    6,PARMN                 Get @ place 2 store parm
         MVI   PARMN,X'40'             Initialize first space
         MVC   PARMN+1(7),PARMN        "Ripple" the blank
*
* Get a single parm from list
*
PARMLOP  CR    7,8                     Check for end of PARM
         BNL   EOPARM                  If it is, goto end of parm
         CLI   0(7),C','               Check if end of a parm
         BE    EOPARM                  If it is, handle end of parm
         MVC   0(1,6),0(7)             Copy a single char of parm
         LA    7,1(,7)                 Advance in parm list
         LA    6,1(,6)                 Advance in PARMN
         B     PARMLOP                 Continue until parm processed
*
* Put name into the BLDL table and check if member
* exists
*
EOPARM   MVC   BLDLTAB+4(8),PARMN      Put PARM into BLDL table
         FIND  B,PARMN,D               See if member exists
         LTR   15,15                   Check RC=0 from FIND
         BNZ   MNOTFND                 If not, member not found
*
* If member exists, build a BLDL table
*
         BLDL  B,BLDLTAB               BLDL table for single entry
         LTR   15,15                   Check RC=0 from BLDL
         BNZ   BLDLPROB                If not OK, abend
*
* Snap the BLDL table and the BPAM DCB
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
* Perform a BSAM physical read
*
DOREAD   READ  DECBA,SF,MF=E           Perform physical read
         CHECK DECBA                   Wait until read confirmed
         B     GOON                    If Not EOF, Go on
         B     BSEOF                   If EOF, handle it
*
* If BSAM physical read went OK, continue and deblock
* logical records
*
GOON     NOTE  B                       Check for Track Change
*
* Check if this is a new MACRO
*
         CLC   BUFFER+9(5),ISMACRO     Do the check
         BNE   NOPAGE                  Not equal, no new page
         MVI   MSG531,C'1'             Set car cntl new page
         STCM  1,12,PRVTRK             Set track for this member
         B     DEBLK                   Do deblocking
NOPAGE   CLM   1,12,PRVTRK             See if we're on same track
         BE    DEBLK                   If so, just deblock
         MVI   MSG531,C'-'             Otherwise triple space output
SETPRV   STCM  1,12,PRVTRK             Set new track value
*
* Deblock physical buffer into records 80 bytes in length    
*
DEBLK    LH    9,B+DCBBLKSI-IHADCB     Get Max Block size
         L     10,DECBA+X'10'          Get A(IOB) from DECB
         LH    11,14(,10)              Residual length -> 11
         SR    9,11                    Calculate # chars read
         ICM   10,X'3',B+DCBLRECL-IHADCB find out LRECL size
         LA    6,BUFFER                Get @ BSAM physical buffer
*
* Fetch a logical record into BSAM Buffer and matching
* record (hopefully) into QSAM buffer
*
FETCHLOG MVC   BSBUFF(80),0(6)         Copy in contents of LREC
         GET   Q,QSBUFF                Do QSAM read
         B     GOON2                   If not EOF, continue
         B     QSEOF                   If QSAM EOF, do EOF stuff
*
* If not QSAM EOF compare results and print if the same
*
GOON2    CLC   QSBUFF(80),BSBUFF       Compare Read results
         BAL   14,BNE#7BDT             If not same, SNABEND
         MVC   LINEOUT(50),MSG531      Set up output message
         MVC   LINEOUT+50(80),BSBUFF   Move buffer contents to output
         BAL   11,WRITELN              Write the line of output
         MVI   MSG531,C' '             Go back to single spacing
*
         LA    6,0(10,6)               Move ptr within BSAM Buffer
         SR    9,10                    Decr. # bytes left to deblock
         BP    FETCHLOG                Fetch another logical record
*
* At this point the physical buffer is exhausted
*
         MVI   MSG531,C'0'             D.S. between physical records
*
* Now do another physical read
*
         B     DOREAD                  Hit this point? READ another one
*
* Loop, grap parm, read another member
*
NXTPRM   AHI   7,1                     Move past ',' in parm list
         B     OUTRLOP                 Redo the whole shebang
*
FINALQ   GET   Q,QSBUFF                Get another QSAM logical record
         B     QSPROB                  Not EOF? QSAM problem
         B     QSEOF                   EOF, handle QSAM EOF
*
* Code for ABENDing if DCB open fails
*
DCBPROB  ABEND 897,DUMP                Problem opening DCBs, DUMP
CVTPROB  ABEND 897,DUMP                CVT addresses don't match
QSPROB   ABEND 897,DUMP                Dump if QSAM doesn't hit EOF
BLDLPROB ABEND 897,DUMP                Dump if BLDL screwed up
*
* R14 Tracking Stubs
*
BNE#7BDT EQU   BNZ#7BDT                BNE and BNZ are the same
BNZ#7BDT BNZ   SNABEND                 Go to SNABEND Routine if zero
         BR    14                      Otherwise Go back
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
*********************************************************************
* SPAM WORKING STORAGE
*********************************************************************
*
HDR1     DC    X'05'                   Length of Low Mem Header
         DC    C'LOMEM'                Low memory label
HDR2     DC    X'03'                   Length of CVT Header
         DC    C'CVT'                  CVT label
HDR3     DC    X'07'                   Length of SVCFLIH Header
         DC    C'SVCFLIH'              SVCFLIH label
HDR4     DC    X'03'                   Length of TCB Header
         DC    C'TCB'                  TCB label
*
PRVTRK   DC    XL2'0000'               Last TTRK processed
ISMACRO  DC    CL5'MACRO'              For checking if new MACRO
PARM@    DC    F'0'                    Address of incoming PARMs
PARMCARD DC    CL80' '                 Incoming PARMs (copy)
PARMN    DC    CL8' '                  Info on parm card between commas
D248     DC    D'+248'                 For FPR 0
DM524    DC    D'-524'                 For FPR 2
D760     DC    D'+760'                 For FPR 4
DM1027   DC    D'-1027'                For FPR 6
PMASK    DC    F'0'                    For the Pgm Mask
         ORG   PMASK                   redefine PMASK
         DC    XL4'0F000000'           For modifying Pgm Mask
VAL32    DC    F'32'                   For subtracting
INTERVAL DC    D'0'                    Double word for time Interval
         ORG   INTERVAL                Redefine INTERVAL
         DC    ZL8'00010000'           HHMMSSth (1 minute)
*
* Use List form of READ Macro
*
         ORG   SPAM+((*-SPAM+31)/32*32) Align 32n
         DC    CL32'DECB FROM READ MACRO BELOW'
*************
* DECBA
*************
         READ  DECBA,SF,B,BUFFER,MF=L  Create DECB for READING
SPAMSAV  DC    18F'-1'                 Spam Save Area
*
* EOF Routines for DCBs
*
BEODAD   B     4(,14)                  Return to following instruction
QEODAD   B     4(,14)                  Return to following instruction
TIMEXIT  ABEND 798,DUMP                Timer Exit Routine Induces Dump
*********************************************************************
* WRITELN - WRITE THE HEADER
*********************************************************************
WRITELN  DS   0H
         WRITE MYWDECB,SF,W,LINEOUT    Perform the Write
         CHECK MYWDECB                 Verify that data was written
         MVI   LINEOUT,X'40'           Set CC for line buffer
         MVC   LINEOUT+1(132),LINEOUT  Blank the line buffer
         BR    11                      Return from write routine
*
LINEOUT  DC    CL133' '                Output buffer (for printing)
*********************************************************************
* SNABEND ROUTINE
* 1) Save all the registers
* 1.5) Move contents of IOB into storage area for a dump
* 2) Issue a SNAP Dump
* 3) If RC=0
* 4)   Terminate program via SVC 3
* 5) Else ABEND 4095,DUMP
*
*********************************************************************
SNABEND  STM   0,15,SNABSAVE           Save all registers
         L     10,DECBA+X'10'          Get @(IOB)
         SH    10,HW8                  Step back 8 bytes
         MVC   IOBSTUFF(64),0(10)      Move in IOB stuff for dump
         SNAP  DCB=S,                                                  X
               STORAGE=(SPAM,SPAMEND),                                 X
               STRHDR=(SNABHDR),                                       X
               PDATA=(PSW,REGS,SA),                                    X
               SDATA=(DM,IO)
         LTR   15,15                   Test SNAP RC
         BNZ   ABN987                  If not zero, dump
         SVC   3                       Else, terminate using SVC 3
ABN987   ABEND 987,DUMP               ABEND inside SNABEND
*********************************************************************
* SNABEND WORKING STORAGE
*********************************************************************
HW8      DC    H'8'                    For printing IOB
SNABHDR  DC    X'13'                   Length of SNABEND header
         DC    C'SNABEND DUMP:'        SNABEND header message
         ORG   SPAM+((*-SPAM+31)/32*32) Align 32n
         DC    CL32'IOBSTUFF FOLLOWS'    Label for IOB contents
IOBSTUFF DC    XL64'0'                 Stuff for dumping the IOB
         ORG   SPAM+((*-SPAM+31)/32*32) Align 32n
         DC    CL32'SNABEND SAVE AREA' label save area
SNABSAVE DC    16F'-88'                Save area for SNABEND
*
*********************************************************************
* Output Messages
*********************************************************************
*
MSG531   DC    CL50'-BS/PAM BDT531I The BPAM record (QSAM OKed) is:   '
MSG532   DC    CL50'-BS/PAM BDT532I EOF Encountered on QSAM file.     '
MSG533   DC    CL50'-BS/PAM BDT533I EOF Encountered on SPAM file.     '
MSG534   DC    CL50'-BS/PAM BDT534I SNAP BLDLtable/BPAM-DCB follows:  '
MSG535   DC    CL50'-BS/PAM BDT535I Member name used in FIND/BLDL is: '
MSG538   DC    CL50'-BS/PAM BDT538I SNAP dump of PARMs for subpool 0: '
MSG539   DC    CL50'-BS/PAM BDT539I Pgm complete, SNAP dump follows:  '
MSG540   DC    CL50'-BS/PAM BDT540I Non-existing FIND name is:        '
MSG541   DC    CL50'-BS/PAM BDT541I SNAP of Lowmem, CVT, SVCFLIH, TCB:'
MSG542   DC    CL50'-BS/PAM BDT542I GPARM given for pgm:'
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
         ORG   SPAM+((*-SPAM+31)/32*32) Align 32n
         DC    CL32'BLDL TABLE FOLLOWS THIS'  LABEL BLDLTABLE
BLDLTAB  DC    H'1',H'60',CL60'0'      Table for BLDL
*********************************************************************
* DCBs 
* B - DCB for use with BPAM Reading
* Q - DCB for use with QSAM Reading
* W - output DCB (write via BSAM)
* S - snap DCB
*********************************************************************
B        DCB   DSORG=PO,MACRF=R,EODAD=BEODAD,DDNAME=LIBFILE,NCP=2
Q        DCB   DSORG=PS,MACRF=GM,EODAD=QEODAD,DDNAME=SEQFILE,BUFNO=3
W        DCB   DSORG=PS,MACRF=W,BLKSIZE=133,LRECL=133,RECFM=FA,        X
               DDNAME=OUT2
S        DCB   DSORG=PS,MACRF=W,BLKSIZE=882,RECFM=VBA,LRECL=125,       X
               DDNAME=OUT2 
BSBUFF   DC    CL80' '                 Buffer for BSAM Logical READ
QSBUFF   DC    CL80' '                 Buffer for QSAM Logical READ
BUFFER   DC    3200C' '                Define 3200 byte buffer
SPAMEND  DC    CL32'END OF SPAM'       Mark end of SPAM
         END   SPAM                    End of SPAM
/*
//GO.LIBFILE DD DSN=T90RPR1.CS468PUB.PDS6,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS8,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS5,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS9,DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS7,DISP=SHR
//*
//GO.SEQFILE DD DSN=T90RPR1.CS468PUB.PDS8(ABEND),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS5(STIMER),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS6(BLDL),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS9(STOW),DISP=SHR
//           DD DSN=T90RPR1.CS468PUB.PDS7(CLOSE),DISP=SHR
//*
//GO.OUT2 DD SYSOUT=*
//GO.SYSUDUMP DD SYSOUT=*
//
