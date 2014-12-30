//Z030199A JOB ,'Brandon Tweed',REGION=2M
/*JOBPARM ROOM=199,L=5
//STEP1 EXEC HLASMC  YOU SHOULD NOT NEED ADDITIONAL SYSLIB!
//*ASM.SYSLIB DD
//*           DD
//*           DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR ASK IF NEEDED
//ASM.SYSLIN DD DSN=&&O(SVC8),SPACE=(6160,(1,1,1)),  NO X IN COL 72
//*456789A123456                        CARD COLUMNS
//             DCB=(LRECL=80,RECFM=FB) 'DCB' =MUST= BEGIN IN COL 16
//ASM.SYSIN DD *
**********************************************************************
* SVC 8
*
* On Entry   R0 = Address where program is to be loaded, or, if
*                 R0 = -1, indicates program is to be loaded at
*                 address contained in OM records.  (RF = 0).
*            R1 = Length of memory available for loading the OM at
*                 the designated address.
*
* On Exit:   R15 = 0 if the module was successfully loaded
*            R0 = Entry Point Address (EPA) of the loaded module
*            R1 = Length of the loaded module (from 1st ESD entry)
*            R15 = 4 if End of File (EOF) encountered while reading
*            R15 = 8 if length of csect exceeded R1 input size
*            R15 = 12 if input record was not a valid OM format
*            R15 = 16 if other categories of error occurred
*
**********************************************************************
SVC8     START X'10000'               Start at hex 10000
         USING SVC8,6                 Establish addressability on R6
*         DC    XL2'0119'     XOPC 25
         ST    0,LOAD@                Save the load address
         ST    1,MAXLEN               Save amt of mem avail for load
*
* Initialize RF=-1
*
         MVC   RF(4),RFINIT           Set RF=-1
         LA    7,SVC8BUF              Get Buffer address
         ST    7,SVC8BUF@             Save it in the IOB
         MVI   TXTFLG,C'N'            Set TXT Flag to Off
*
* Read the first OM Card
*
DOREAD   BAL   11,IRS                 Call the IRS (scare friends)
CHKESD   CLC   SVC8BUF+1(3),ESDVAL    Check if this is an ESD Card
         BNE   CHKTXT                 If not ESD, Check if TXT 
*
* this is an ESD Card
*
         CLC   RF(4),RFINIT           Check relocation factor
         BE    FIRSTESD               If this is first ESD, process it
         BAL   11,IRS                 otherwise read next ESD card
         B     CHKESD                 Keep going until ESDs gone
FIRSTESD CLI   SVC8BUF+24,X'00'       Check that ESD type is SD
         BNE   RC16#1                 If not, RC=16, end
*
* process first ESD record
*
         MVC   CSECT@+1(3),SVC8BUF+25 Get the CSECT Address
         MVC   CSECTL+1(3),SVC8BUF+29 Get the CSECT Length
         CLC   MAXLEN(4),CSECTL       See if Max length < CSECTL
         BL    RC8                    If so, Return Code 8
         CLC   LOAD@(4),RFINIT        Check Load@ = -1
         BE    SETRF0                 If so, set RF=0
*
* Otherwise, calculate the RF
*
         L     7,LOAD@                Get load address
         S     7,CSECT@               RF = LOAD@ - CSECT@
         ST    7,RF                   Save the Relocation Factor
         B     DOREAD                 Process next OM Record
         
SETRF0   XC    RF(4),RF               Set Relocation factor to zero
         B     DOREAD                 Process next OM Record
*
* Process a TXT OM Record
*
CHKTXT   CLC   RF(4),RFINIT           Check if RF Not yet set
         BE    RC16#2                 If not, Set RC=16
         CLC   SVC8BUF+1(3),TXTVAL    Check if this is a TXT Card
         BNE   CHKRLD                 If not TXT, Check if RLD
         MVI   TXTFLG,C'Y'            Indicate TXT Card Read
         XR    7,7                    Clear 7 for TXT Length
         ICM   7,3,SVC8BUF+10         Get Length for TXT Card
         LTR   7,7                    Check Length = 0
         BZ    RC16#3                 If so, Return Code=16, End
         XR    8,8                    Clear 8 for Rel Address
         ICM   8,7,SVC8BUF+5          Get Relative Address for TXT
         A     8,RF                   Add the RF giving final address
         EX    7,MOVETXT              Now move the TXT card info
         BAL   11,IRS                 Read another record
         B     CHKTXT                 Check to see if it's TXT
*
* Process an RLD Record
*
CHKRLD   CLC   SVC8BUF+1(3),RLDVAL    Check if this is a RLD Card
         BNE   CHKEND                 If not RLD, Check if END
         B     DOREAD                 If this is RLD, read next OMR
*
* Process an END Card
*
CHKEND   CLI   TXTFLG,C'Y'            See if at least 1 TXT processed
         BNE   RC16#4                 If not, fail with RC=16
         CLC   SVC8BUF+1(3),ENDVAL    Check if this is an END Card
         BNE   RC12#2                 If not any  of these, Set RC=12
         L     0,CSECT@               Get CSECT address
         A     0,RF                   Add the RF giving EPA
         CLC   SVC8BUF+5(3),TSTAEPF   Test AOEPF for blanks
         BE    B4EXIT                 If blank, exit
         XR    0,0                    else clear R0 and recalculate
         ICM   0,7,SVC8BUF+5          Get AOEPF
         A     0,RF                   Add RF giving EPA
*
* Put CSECT Length into R1 and exit
*
B4EXIT   L     1,CSECTL               Load R1 with CSECT Length
         B     RC0                    Set RC=0 and exi
*********************************************************************
* SVC 8 STORAGE AREA
**********************************************************************
         ORG   SVC8+((*-SVC8+31)/32*32) Align 32n
         DC    CL32'SVC8 STORAGE AREA FOLLOWS'
*
RF       DC    F'-1'                  Relocation Factor
MAXLEN   DC    F'0'                   Module Length
LOAD@    DC    F'0'                   Module Load address
CSECT@   DC    F'0'                   CSECT Address
CSECTL   DC    F'0'                   CSECT Length
RFINIT   DC    F'-1'                  For Initializing  comparing RF
TXTFLG   DC    C'N'                   Flag Indicating TXT Card read
MOVETXT  MVC   0(0,8),SVC8BUF+16      Move the TXT Card information
*
         ORG   SVC8+((*-SVC8+31)/32*32) Align 32n
         DC    CL32'SVC8 INPUT BUFFER BELOW'
SVC8BUF  DC    CL80' '                SVC8 Input Buffer
*
ESDVAL   DC    CL3'ESD'               For checking ESD OM Card
TXTVAL   DC    CL3'TXT'               For checking TXT OM Card
RLDVAL   DC    CL3'RLD'               For checking RLD OM Card
ENDVAL   DC    CL3'END'               For checking END OM Card
TSTAEPF  DC    CL3'   '               For checking Addr Ent. Pt.
*
         ORG   SVC8+((*-SVC8+31)/32*32) Align 32n
         DC    CL32'SVC8 READ IOB BELOW'
SVC8RIOB DS    0F                     Start IOB on a fullword
         DC CL4'IOBR'                 IOB IDENTIFICATION
         DC XL2'0000'                 FOR XREAD
         DC X'02'                     '02' = READ
         DC C'0'                      RESERVED FOR STUFF
SVC8BUF@ DC F'0'                      A(BUFFER) TO READ
         DC H'80'                     LENGTH OF BUFFER TO READ/WRITE
         DC H'0'                      RESERVED FOR STUFF
*
**********************************************************************
* INTERNAL READ SUBROUTINE FOR SVC 8 (IRS)
**********************************************************************
*
         ORG   SVC8+((*-SVC8+31)/32*32) Align 32n
         DC    CL32'INTERNAL READ SUBROUTINE FOLLOWS'
IRS      LA    1,SVC8RIOB             Get address of Read IOB
         SVC   0                      Call SVC 0 to perform the read
         LTR   15,15                  Test RC=0
         BNZ   RC4                    If RC != 0, Set return code to 4
         CLI   SVC8BUF,X'02'          Check if this is an OM Card
         BNE   RC12#1                 If it's not, bomb out
         BR    11                     Return from Read Subroutine
*      
* First char of Object Record not X'02'
*
RC12#1   LA    15,12                  Set RC=12
         BR    14                     Return from SVC 8
*
* No 'ESD','TXT','RLD','END' in Object Record
*
RC12#2   LA    15,12                  Set RC=12
         BR    14                     Return from SVC 8
*
* RC16#1 First ESD entry is not 'SD', i.e., X'00'.
*
RC16#1   LA    15,16                  Set RC=16
         BR    14                     Return from SVC 8
*
* RC16#2 TXT record was not preceded by ESD record,
* RF still = -1.
*
RC16#2   LA    15,16                  Set RC=16
         BR    14                     Return from SVC 8
*
* RC16#3 Length of the text in TXT record was zero.
*
RC16#3   LA    15,16                  Set RC=16
         BR    14                     Return from SVC 8
*
* RC16#4 No TXT records were processed.
*
RC16#4   LA    15,16                  Set RC=16
         BR    14                     Return from SVC 8 
RC0      XR    15,15                  Set R15=0
         BR    14                     Return from SVC 8
RC4      LA    15,4                   Set RC=4 in R15
         BR    14                     Return from SVC 8
RC8      LA    15,8                   Set RC=8 in R15
         BR    14                     Return from SVC 8
         END   SVC8                   End of SVC8 module
/*
//STEP2 EXEC PGM=IEBCOPY
//SYSPRINT DD SYSOUT=*
//OLD DD DSN=&&O,DISP=(OLD,PASS)
//NEW DD DSN=&&OO,DISP=(NEW,PASS),SPACE=(6160,(1,1,1))
//SYSIN DD *
    COPY INDD=OLD,OUTDD=NEW
/*
//STEP3 EXEC PGM=AMBLIST
//SYSLIB DD DSN=&&O(SVC8),DISP=(OLD,PASS)
//SYSPRINT DD SYSOUT=*
//SYSIN DD *
  LISTOBJ
/*
//STEP4 EXEC PGM=IEBPTPCH
//SYSPRINT DD   SYSOUT=*
//SYSUT1 DD DSN=&&O(SVC8),DISP=(OLD,PASS)
//SYSUT2 DD   SYSOUT=*
//SYSIN DD *
  PRINT TOTCONV=XE
/*
//ASSISTV EXEC PGM=ASSISTV,
// PARM='P=100,PX=50,R=5000,RX=3000,L=60,XREF=0',
// REGION=512K
//STEPLIB DD DSN=USER1.ASSIST.LOADLIB,DISP=SHR
//VIRTRDR1 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00C'
//VIRTRDR2 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00D'
//* VIRTPRT1 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00E'
//* VIRTPRT2 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00F'
//FT06F001 DD SYSOUT=* PRINTOUT FROM THE ASSEMBLY, TRACE, ETC.
//SYSPRINT DD SYSOUT=*
//SYSLIB DD DSN=SYS1.MACLIB,DISP=SHR
// DD DSN=SYS2.MACLIB,DISP=SHR
// DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR
//SYSIN DD *
         TITLE 'Brandon Tweed SOS-LL'
**********************************************************************
* Brandon Tweed
* CSCI 468 Spring 2005
* Loader Lite 3-28-2005
*
* Program does the following:
* Loads my loader using Rannie's SVC 8
* Uses my loader to load my loader again
* Uses the new copy of my loader to load OBJMOD7
* Runs OBJMOD7 
*
**********************************************************************
         PRINT GEN
*SYSLIB LOADER,DSECTS,EQUREGS,EXIT,LOUNTR,FRECB100,GETCB100,WAITS
         DSECTS                       BRING IN DSECTS FOR USE
         TITLE 'START OF FIRST 4K'          
*
**********************************************************************
* START OF FIRST 4K OF STORAGE
**********************************************************************
*
FIRST4K  CSECT                        START OF FIRST4K
         USING FIRST4K,0              ESTABLISH FIRST4K ADDR
         DC    2048X'0119'            FILL 1ST WITH 'QUICK STOP'
         ORG   FIRST4K                GO BACK TO START OF 1ST 4K
         DC    X'010401190F',AL3(IPLPGM) DEFINE IPLPSW
         ORG   FIRST4K+X'10'          GO TO LOCATION FOR @(CVT)
CVT#1    DC    A(MYCVT)               ADDRESS OF MYCVT
*
*********************************************
* OLD PSWs
*********************************************
*
         ORG   FIRST4K+X'18'          GO TO LOCATION FOR OLDPSWs
OPSWEX   DC    D'0'                   OLD EXT INT PSW
OPSWSVC  DC    D'0'                   OLD SVC PSW
OPSWPC   DC    D'0'                   OLD PC PSW 
OPSWMC   DC    D'0'                   OLD MC PSW 
OPSWIO   DC    D'0'                   OLD I/O PSW
*
         ORG   FIRST4K+X'4C'          GO TO LOCATION FOR CVT#2
CVT#2    DC    A(MYCVT)               ADDRESS OF MYCVT
CLOCK    DC    F'0'                   ASSEMBLE CLOCK AS VALUE ZERO
*
********************************************
* NEW PSWs
********************************************
*
         ORG   FIRST4K+X'58'               LOCATION FOR NEW PSWS
NPSWEX   DC    X'010601190F',AL3(EXFLIH)   NEW PSW EXTERNAL
NPSWSVC  DC    X'010401190F',AL3(SVCFLIH)  NEW PSW SVC
NPSWPC   DC    X'010401190F',AL3(AFTERLOP) NEW PSW PC
NPSWMC   DC    X'010401190F',AL3(MCFLIH)   NEW PSW MACHINE CHECK
NPSWIO   DC    X'010401190F',AL3(IOFLIH)   NEW PSW I/O
*
         ORG   FIRST4K+X'A0'          LOCATION FOR LOWPSW
LOWPSW   DC    D'0'                   FILL LOWPSW WITH ZERO
*
         ORG   FIRST4K+X'B0'          LOCATION FOR LOWTIME
LOWTIME  DC    F'0'                   FILL LOWTIME WITH ZERO
*
         ORG   FIRST4K+X'BC'          MOVE TO LOCATION FOR LEVELABN
LEVELABN DC    X'0119'                SET VALUE FOR LEVELABN
LEVELFLG DC    C'X'                   LATER SET TO C'S' IN IPL
TYP1FLAG DC    C'X'                   LATER SET TO C'0' IN IPL
*
*****************************************
*  SAVE AREAS FOR INTERRUPTS
*****************************************
*
EXSAVE   DC    16CL4'EX'              SAVE AREA FOR EXTERNAL INTS
SVCSAVE  DC    16CL4'SV'              SAVE AREA FOR SVC INTERRUPTS
PCSAVE   DC    16CL4'PC'              SAVE AREA FOR PC INT.
IOSAVE   DC    16CL4'IO'              SAVE AREA FOR I/O INTERRUPTS
*
******************************************
* TCB WORDS, LOUNTR
******************************************
*
         ORG   FIRST4K+X'518'         MOVE TO LOCATION FOR TCBWORDS
TCBWORDS DC    4F'0'                  FILL TCBWORDS WITH ZEROS         
         ORG   FIRST4K+X'7E0'         MOVE TO LOCATION FOR LOUNTR
LOUNTR   DS    0H                     LABEL FOR START OF LOUNTR
         LOUNTR                       INVOKE LOUNTR MACRO
*
************************************
* SVCTABLE
************************************
*
         ORG   FIRST4K+X'2000'        MOVE TO LOCATION FOR SVC TABLE
SVCTABLE DC    16D'0'                 FILL SVC TABLE WITH ZEROS
         ORG   SVCTABLE+8*0           GO TO ENTRY FOR SVC 0
         DC    A(SVC0)                ADDRESS OF SVC 0
         ORG   SVCTABLE+8*1           GO TO ENTRY FOR SVC 1
         DC    A(SVC1)                ADDRESS OF SVC 1
         ORG   SVCTABLE+8*2           GO TO ENTRY FOR SVC 2
         DC    A(SVC2)                ADDRESS OF SVC 2
         ORG   SVCTABLE+8*3           GO TO ENTRY FOR SVC 3
         DC    A(SVC3)                ADDRESS OF SVC 3
         ORG   SVCTABLE+8*8           GO TO ENTRY FOR SVC 8
         DC    A(SVC8)                ADDRESS OF SVC 8
         DC    X'80'                  B'10' indicates type 2 SVC
         ORG   SVCTABLE+8*13          GO TO ENTRY FOR SVC 13
         DC    A(SVC13)               ADDRESS OF SVC 13
         DC    X'C0'                  Indicate type 4 SVC
         ORG   SVCTABLE+8*14          GO TO ENTRY FOR SVC 14
         DC    A(SVC14)               ADDRESS OF SVC 14
         DC    X'C0'                  Type 4 SVC
         ORG   SVCTABLE+8*15          GO TO ENTRY FOR SVC 5
         DC    A(BR14)                ADDRESS OF "BR14" ROUTINE
         ORG   ,                      MOVE IT FORWARD
BR14     DC    X'1BFF07FE'            SR 15,15 AND BR 14
*
*********************************************************************
* DISPATCHER
*
* ON ENTRY:
*    R3  = A(CVT)
*    R12 = A(DISPATCH)
*********************************************************************
*
         ORG   FIRST4K+X'2400'        MOVE TO DISPATCHER LOCATION
         USING DISPATCH,12            DISPATCHER ADDRESSABILITY
         USING CVT,3                  CVT ADDRESSABILITY
DISPATCH L     4,CVTHEAD              GET ADDRESS FIRST TCB
         USING TCB,4                  TCB ADDRESSABILITY
DLOOP    LTR   4,4                    CHECK TCB POINTER NOT NULL
         BZ    D0119                  IF SO, DIE
         L     5,TCBRB                GET RB ADDRESS
         USING RB,5                   RB ADDRESSABILITY
         LTR   5,5                    VERIFY RB POINTER NOT NULL
         BZ    ENDJOB                 RB POINTER NULL = END OF JOB
         CLI   RBWCF,X'00'            CHECK WAIT COUNT FIELD = 0
         BE    DODISP                 IF SO, DISPATCH THIS TCB
         L     4,TCBTCB               IF NOT, GO TO NEXT TCB
         B     DLOOP                  CONTINUE TCB LOOP
*
* 1) save address of TCB to be dispatched into TCBWORDS+4
*
DODISP   ST    4,TCBWORDS+4           SAVE @ TCB TO BE DISPATCHED
*
* 2) Move PSW to be dispatched from RB to lowcore
*
         MVC   LOWPSW(8),RBOPSW       MOVE PSW TO BE DISPATCHED
*
* Increment dispatch count
*
         L     7,DCOUNT               GET DCOUNT
         LA    7,1(,7)                INCREMENT IT
         ST    7,DCOUNT               SAVE IT
*
* 3) Load all registers
*
         LD    0,TCBFRS+8*0           LOAD FPR 0
         LD    2,TCBFRS+8*1           LOAD FPR 2
         LD    4,TCBFRS+8*2           LOAD FPR 4
         LD    6,TCBFRS+8*3           LOAD FPR 6
*
* Save time of dispatch into TCB before losing addressability
* 
         MVC   TCBTDISP(4),CLOCK      SAVE TIME OF DISPATCH
         LM    0,15,TCBGRS            LOAD ALL GPRS
*
* 4) Test/set the LEVELFLG prior to departing for
*    THE SEA OF TASK
*
         CLI   LEVELFLG,C'S'          CHECK LEVELFLG IS 'S'
         BNE   LEVELABN               ABEND IF NOT
         MVI   LEVELFLG,C'T'          SET LEVELFLG TO TASK
*
* 5) Load the PSW to complete the dispatch
*
         LPSW  LOWPSW                 Load PSW to run task
*
*** BEGINNING OF ENDJOB CODE ****
*
* 1) UNCHAIN THE TCB
*
ENDJOB   L     7,TCBBACK              GET BACKWARD TCB PTR
         L     8,TCBTCB               GET FORWARD  TCB PTR
         MVC   TCBUNCH(4),UNCH        INDICATE UNCHAINED
         DROP  4                      DONE WITH CURRENT TCB
*
* UPDATE FORWARD POINTER OF PREVIOUS TCB
*
         USING TCB,7                  PREV TCB ADDR
         ST    8,TCBTCB               UPDATE FORWARD PTR
         DROP  7                      DONE WITH PREV TCB
*
* UPDATE BACK PTR OF NEXT TCB
*
         USING TCB,8                  ADDR FOR NEXT TCB
         ST    7,TCBBACK              UPDATE BACK PTR OF NEXT TCB
         DROP  8                      DONE WITH "NEXT" TCB
*
* 2) PRINT "END OF JOB" MESSAGE
*
         USING TCB,4                  REFER TO TCB UNCHAINED
         MVC   EJTCBN(8),TCBTNAME     GET TCB NAME
         MVC   EJPGMN(8),TCBPNAME     GET PROGRAM NAME
*
         MVC   EJWRK+12(4),TCBTCPUP   PUT TASK TIME INTO LOUNTR
         BAL   1,LOUNTR               CALL LOUNTR ON TASK TIME
EJWRK    DC    CL16'L'                LOUNTR STORAGE AREA
         MVC   EJTT(8),EJWRK          TASK TIME -> PRINT LINE
*
         MVC   EJWRK2+12(4),TCBTCPUS  PUT SV Task time into LOUNTR
         BAL   1,LOUNTR               CALL LOUNTR TO xLATE SV TASK
EJWRK2   DC    CL16'L'                STORAGE FOR SV TIME LOUNTR
         MVC   EJST(8),EJWRK2         Save Super Time to Print Line
*
         XPRNT EJMSG2,133             PRINT 2ND END JOB MSG
*
* Decrement CURI
*
         L     2,CVTMSDAT             Get @ MSDA from CVT
         USING MSDA,2                 MSDA addressability 
         L     9,MSDACURI             Get the CURI
         BCTR  9,0                    SUBTRACT ONE
         ST    9,MSDACURI             Store the new CURI
*
* Perform Branch entry into SVC 2
*
         L     6,CVTSVCTA             Get addr. of SVC table
         L     6,2*8(,6)              Get addr of SVC 2
         LTR   6,6                    Check address
         BZ    D0119                  If invalid address, die
         L     0,MECBINIT             Put post code into R0 (bits 2-31)
         LA    1,MSDAMECB             Get addr. of ECB into R1
*
         CLI   TYP1FLAG,C'0'          CHECK IF IN TYPE 1 STATE
         BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP
         MVI   TYP1FLAG,C'1'          OTHERWISE SWITCH TO NON-TYPE 1 
*
         BALR 14,6                    Branch into SVC2
*
         CLI   TYP1FLAG,C'1'          CHECK IF IN TYPE 1 STATE 
         BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP
         MVI   TYP1FLAG,C'0'          OTHERWISE SWITCH TO NON-TYPE 1
*      
* Post completed, Continue the dispatch loop
*
         B     DISPATCH               CONTINUE DISPATCH LOOP   
         DROP  3,4,5                  DONE WITH CVT, TCB, RB
D0119    XOPC  25                     DIE ON ERROR
*
************************************
* DISPATCHER WORKING STORAGE
************************************
*
EJMSG2   DC    C'0'                   CARRIAGE CONTROL
         DC    CL20'SOS TERMINATING!' TERMINATION MESSAGE
         DC    CL10'TCB NAME: '       TCB NAME
EJTCBN   DC    CL8'XXXXXXXX'          PUT TCB NAME HERE
         DC    CL11' PGM NAME: '      PGM NAME
EJPGMN   DC    CL8'XXXXXXXX'          PUT PGM NAME HERE
         DC    CL12' PROBLEM: '          TASK TIME
EJTT     DC    CL8'XXXXXXXX'          PUT TASK TIME HERE
         DC    CL12' SUPER: '         SUPERVISOR TIME
EJST     DC    CL8'XXXXXXXX'          SUPERVISOR TIME HERE
         DC    35C' '                 FILLER
*
UNCH     DC    CL4'UNCH'              UNCH MESSAGE FOR TCB
         DC    0F'0'                  Align on a fullword
MECBINIT DC    X'7F',C'DIS'           STUFF FOR RESETTING POST CODE
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32)      NICE ALIGNMENT
         DC    CL28'TOTAL DISPATCH COUNT AT LEFT'  DCOUNT MESSG
DCOUNT   DC    F'0'                   START COUNT AT ZERO
*
************************************
* CVT - COMMUNICATION VECTOR TABLE
************************************
*
         ORG   FIRST4K+X'2800'        MOVE TO LOCATION FOR THE CVT
MYCVT    DC    96X'0'                 SET UP THE CVT
         ORG   MYCVT                  GO BACK AND DEFINE FIELDS
         DC    A(TCBWORDS)            CVTTCBP
         DC    A(SVCTABLE)            CVTSVCTA
         ORG   MYCVT+(CVTC100H-CVT)   LOCATION FOR CVTC100H
         DC    A(CB100HDR)            HEADER ADDRESS CB100s (CVT100H)
         DC    A(DISPATCH)            (CVT0DS) ADDRESS OF DISPATCHER
         ORG   MYCVT+(CVTBRABN-CVT)   Go to location for CVTBRABN
         DC    A(BRABEND)             Addr Branch ABEND Routine
         ORG   MYCVT+(CVTMSECB-CVT)   LOCATION FOR CVTMSECB
         DC    A(LOCMECB)             ADDRESS FOR MSECB
         ORG   MYCVT+(CVTMSDAT-CVT)   LOCATION FOR CVTMSDAT
         DC    A(MYMSDA)              ADDRESS FOR MYMSDA
         SVC   3                      SVC 3
         BCR   15,14                  CVTBRET
         DC    A(NONTYP1)             CVTSSVRB For scheduling SVRB
         ORG   MYCVT+(CVTIDENT-CVT)   LOCATION FOR IDENT
         DC    CL4'CVT '              INSERT THE CVT IDENT
         ORG   ,                      MOVE ON
         TITLE 'IPL ROUTINE DOC' 
*
**********************************************************************
* IPLPGM
*
* INPUT:  NONE
*
* OUTPUT: A MESSAGE THAT STATES THE VALUE SAVED FOR CVTMZ00
*
* ENTRY CONDITONS: None
*
* EXIT CONDITIONS: System setup as described in IPL handout
*
* REGISTER USAGE:
*
*    R0 -  ADDRESS OF LOWEST STORAGE AREA IN MEMORY (FOR TRACING)
*    R1 -  HIGHEST ADDRESS IN THE ASSEMBLY (FOR TRACING)
*          ALSO USED BY LOUNTR
*    R2 -  ASSISTV TRACE TYPE CODES
*    R3 -  CVT ADDRESSABILITY
*    R6 -  USED IN PERFORMING LOGICAL COMPARISONS
*          (FOR THE SOC5 AND THE ADDRESS OF SOC5 INSTRUCTION)
*    R7 -  HOLDS STORAGE KEY OF ZERO
*    R8 -  HOLD ADDRESS TO SET STORAGE KEY VALUE
*    R12 - USED FOR IPLPGM ADDRESSABILITY
*
* LOGIC:
*
* 1) Set up addressability based upon R12
* 2) Set the clock to X'50' to the value X'7FFFFFF'
* 3) Turn on the Assist-V Trace Facility
* 4) 4.1) Set all of the 2K blocks of memory with a protection byte of
*         X'00'
*    4.2) Check that a SOC5 caused the program check interrupt
*    4.3) Make sure address of instruction causing SOC5 is in 
*         old program check PSW
*    4.4) Print the value of CVTMZ00
*
**********************************************************************
         TITLE 'IPL ROUTINE CODE'
         ORG   FIRST4K+X'3000'        MOVE TO THE IPL ROUTINE
* 
* 1. Set up Addressability based on R12
*
IPLPGM   BALR  12,0                   Put ani into R12
         BCTR  12,0                   Decrement R12 by 1
         BCTR  12,0                   Decrement again
         USING IPLPGM,12              Now R12 points to start of IPLPGM
*
* 2. Set the Clock (X'50') to X'7FFFFFF'
*
         MVC   CLOCK(4),TIMEVAL       set value for clock
*
* 3. Turn on the Assist-V Trace Facility
*
         LM    0,2,R0R1R2             load regs to set trace
         XOPC  3                      turn on trace 
*
* 4. Set all of the 2K blocks of memory with a
*    protection byte of X'00'
*
         XR    7,7                    R7 will be R1, ZERO IT
         XR    8,8                    R8 will be R2, ZERO IT
LOOP     SSK   7,8                    Set Storage Key to 0
POINTHER XOPC  4                      Turn off trace after 1st SSK
         LA    8,X'800'(,8)           increment RB b 2K
         B     LOOP                   continue infinite loop
AFTERLOP XOPC  2                      Turn trace back on
         MVC   NPSWPC+5(3),REALPC+1   put @(PCFLIH) into PC New PSW
*
* Check that it was a SOC5 that caused the Program Check
*
         CLI   OPSWPC+3,5             See if int code was 5 (FOR SOC5)
         BNE   IPL0119                If not, stop
*
* Test if @(POINTHER) in old PC PSW
*
         LA    6,POINTHER             Get @POINTHER
         CLM   6,7,OPSWPC+5           If inst. addr in PSW POINTHER
         BNE   IPL0119                No, then stop
*
         L     3,76                   Get @CVT
         USING CVT,3                  CVT addressability
         BCTR  8,0                    Decrease HIGHEST by 1
         ST    8,CVTMZ00              Save HIGHEST address
*
* Print the value of CVTMZ00
*
         MVC   LSTOR+12(4),CVTMZ00    Put CVTMZ00 into LOUNTR stor
         BAL   1,LOUNTR               LOUNTR translates CVTMZ00
LSTOR    DC    CL16'L'                Storage for LOUNTR
         MVC   OUTVAL(8),LSTOR        Put value in print line
         XPRNT MESSAGEO,20            print value of CVTMZ00
*
* 5) Chain the 15 CB100 blocks and establish the CB100 header
*
         L 10,ADCBPOOL                GET ADDRESS OF POOL
         LA 0,CB100#                  GET # OF CB100S
CBATIPL  FRECB100            
         LA 10,CB100LTH(10)           MOVE TO THE NEXT 
         BCT 0,CBATIPL                DECREMENT # OF BLOCKS AND LOOP
*
* 6) Get CBs and chain them
*
* GET TCB FOR MS/NMI
*
         GETCB100
         LR    7,10                   PUT @ NMS TCB IN 7
         ST    7,CVTHEAD              SAVE @ NMS TCB INTO CVTHEAD
         USING TCB,7                  SET UP TCB ADDRESSABILITY
         XC    TCB(CB100LTH),TCB      CLEAR CB CONTENTS
         MVC   TCBTNAME(8),TCBTNVAL   SET TCBTNAME EXCEPT FOR 'n'
         MVI   TCBTNAME+3,C'M'        BECAUSE THIS IS THE MS/NMI TCB
         MVC   TCBIDENT(4),IDENTVAL   SET TCBIDENT 
         MVC   TCBGRS(8),GRSVAL       SET UP TCBGRS INIT VALUE
         MVC   TCBGRS+8(56),TCBGRS    REPEAT VALUE
         MVC   TCBAPIE(4),NIPPIE      Set A(NIPMSPIE) in NIPMS TCB
*
* GET RB FOR MS/NMI
*
         GETCB100 
* Pause - set the TCBRB field for the MS TCB
         ST    10,TCBRB               Set the TCBRB field
         LR    8,10                   GET @(MS/NMI) RB INTO R8                
         USING RB,8                   NOW WORK WITH THE RB
         XC    RB(CB100LTH),RB        CLEAR THE RB
         MVC   RBTYPE(4),RBTYPVAL     SET RBTYPE
         ST    7,RBTCB                POINT RBTCB AT TCB FOR MS/NMI
         OI    RBFLGS3,X'80'          SET BIT 0 TO 1 FOR A PRB
         MVC   RBOPSW(8),RB0PSW1      PSW FOR NIP/MS RB
         MVC   RBGRSAVE(8),RBGRSAV    SET RBGRSAVE TO INIT VALUE
         MVC   RBGRSAVE+8(56),RBGRSAVE REPEAT THIS VALUE
         MVC   RBFRSAVE(8),RBFRSAV    SET RBFRSAVE TO INIT VALUE
         MVC   RBFRSAVE+8(24),RBFRSAVE REPEAT THE VALUE
         STCM  7,7,RBLINK+1           SET RBLINK FIELD TCB
         DROP  8                      Done with this RB for now
*
* GET TCB FOR WAIT
*
         GETCB100
         LR    9,10                   GET @ WAIT TCB INTO R9
* Hold it! Update the "Next" field of the NMS TCB
         ST    9,TCBTCB               SAVE @ WAIT TCB IN NMS TCB
         DROP  7                      Done with NMS TCB 
* -Back to setting up the Wait TCB-
         USING TCB,9                  SET UP ADDR TO WAIT TCB
         XC    TCB(CB100LTH),TCB      CLEAR CB CONTENTS
         MVC   TCBTNAME(8),TCBTNVAL   SET TCBTNAME EXCEPT FOR 'n'
         MVI   TCBTNAME+3,C'W'        BECAUSE THIS IS THE WAIT TCB
         MVC   TCBIDENT(4),IDENTVAL   SET TCBIDENT
         MVC   TCBGRS(8),GRSVAL       SET UP TCBGRS INIT
         MVC   TCBGRS+8(56),TCBGRS    REPEAT VALUE
         ST    7,TCBBACK              SET TCB BACKWARD PTR TO MS/NMI     
*
* GET RB FOR WAIT
* 
         GETCB100
         USING RB,10                  SET UP WAIT RB ADDRESSABILITY
*
* Pause - Set TCBRB in the WaitTCB
*
         ST    10,TCBRB               Set TCB pointer in Wait TCB
         DROP  9                      Done with Wait TCB
         XC    RB(CB100LTH),RB        CLEAR CB CONTENTS
         MVC   RBTYPE(4),RBTYPVAL     SET RBTYPE
         ST    9,RBTCB                POINT RBTCB AT TCB FOR WAIT
         OI    RBFLGS3,X'80'          SET BIT 0 TO 1 FOR A PRB
         MVC   RBOPSW(8),RB0PSW2      PSW FOR WAIT
         MVC   RBGRSAVE(8),RBGRSAV    SET RBGRSAVE TO INIT VALUE
         MVC   RBGRSAVE+8(56),RBGRSAVE REPEAT THIS VALUE
         MVC   RBFRSAVE(8),RBFRSAV    SET RBFRSAVE TO INIT VALUE
         MVC   RBFRSAVE+8(24),RBFRSAVE REPEAT THE VALUE
         STCM  9,7,RBLINK+1           SET RBLINK FIELD TO TCB
         DROP  10                     DONE WITH WAIT RB
*
* 7) Load address of dispatcher and branch to it
*
         MVI   LEVELFLG,C'S'          LEVELFLG TO 'S' FOR SYSTEM
         MVI   TYP1FLAG,C'0'          TYP1FLAG TO 0
         L     12,CVT0DS              GET DISPATCHER ADDRESS
         BR    12                     BRANCH TO THE DISPATCHER
         DROP  3                      Done with the CVT
*
IPL0119  XOPC  25                     Die if anything goes wrong
         TITLE 'IPL ROUTINE STORAGE AREA'
*
**********************************************************************
* IPL PROGRAM STORAGE AREA
**********************************************************************
*
NIPPIE   DC    A(NIPMSPIE)            A(PIE) for NIP/MS
R0R1R2   DC    F'0'                   SET 'LOWEST' AREA TRACED ZERO
         DC    A(HIGHEST)             SET 'HIGHEST' AREA TRACED 'TOP'
         DC    XL4'00E08040'          TRACE CH. 0-1-2, SWAPS, PRIVOPS
TIMEVAL  DC    X'7FFFFFFF'            VALUE FOR SETTING THE CLOCK
REALPC   DC    A(PCFLIH)              ACTUAL ADDRESS OF PC FLIH
*
MESSAGEO DC    C' '                   CC FOR MESSAGEO
         DC    CL11'CVTMZ00 is '      FIRST PART OF MESSAGE
OUTVAL   DC    CL8' '                 CVTMZ00 VALUE ON PRINT LINE
ADCBPOOL DC    A(CB100POL)            ADDRESS OF THE CB100 BLOCK POOL
TCBTNVAL DC    CL8'TCBn BDT'          For initializing TCBTNAME
IDENTVAL DC    CL4'TCB '              For setting up TCBIDENT
GRSVAL   DC    CL8'TCBGRS'            For setting up TCBGRS
FRSVAL   DC    CL8'TCBFRS'            For setting up TCBFRS
RBTYPVAL DC    CL4' PRB'              USED TO SET UP RBTYPE
RBGRSAV  DC    CL8'RBGRSAVE'          USED TO SET UP RBGRSAVE
RBFRSAV  DC    CL8'RBFRSAVE'          USED TO SET UP RBFRSAVE
*
RB0PSW1  DC    X'FF0401190F',AL3(NIPMS)    PSW FOR NIP/MS RB
RB0PSW2  DC    X'FFE601190F',AL3(LEVELABN) PSW FOR WAIT RB
         TITLE 'BRABEND AND FLIHS'
         ORG   FIRST4K+X'4000'        GO TO PLACE FOR FLIHs     
************************************************************
* BRABEND routine
* On Entry: R3 = A(CVT)
************************************************************
         USING CVT,3                  CVT addr
BRABEND  L     6,CVTSVCTA             Get @ of SVCTABLE
         L     6,13*8(,6)             Get @ of SVC13
         L     15,CVTSSVRB            @ of 'Type other' code SVCFLIH
         LTR   6,6                    Check if address is null
         BNZR  15                     If ok, Go into Type Other Code
         XOPC  25                     Otherwise meet a painful death
         DROP  3                      Done with CVT
*
EXFLIH   DC    X'0119'                EXTERNAL FLIH
*
********************************************************************
* SVC FIRST LEVEL INTERRUPT HANDLER
*
* LOGIC:
* 1)  SAVE ALL GPRS IN SVCSAVE
* 2)  ESTABLISH CVT ADDRESSABILITY
* 3)  ESTABLISH TCB ADDRESSABILITY
* 4)  MOVE ALL GPRS TO THE TCB
* 5)  SAVE ALL FPRS INTO THE TCB
* 6)  GET RB ADDRESS FROM TCB INTO R5
* 7)  VERIFY RB ADDRESS NOT ZERO
* 8)  COPY OLD PSW TO INTO THE RB
* 9)  <PERFORM SVC INT. FUNCTIONS> - SEE BELOW
* 10) BRANCH TO DISPATCHER W/ R3 STILL VALID
* 
* STEP 9 IN DETAIL:
*
* A) GET THE INTERRUPT CODE FROM THE OLDPSW
* B) MAKE SURE CODE IS IN RANGE OF SVCTABLE
* C) IF SVC IS TYPE 1 THEN
* D)    TEST AND SET FLAG TO INDICATE 'TYPE 1'
* E)    GO TO SVC ROUTINE
* F)    TEST AND RESET FLAG TO INDICATE NOT TYPE 1
* E)    STORE REGS 0,1,15 IN TCBGRS AREA
* F) ENDIF
*
* REGISTER USAGE:
*
* R0,R1,R13,R15 - Used by SVC, shouldn't be altered
* R3 - CVT ADDRESSABILITY
* R4 - TCB ADDRESSABILITY
* R5 - RB ADDRESSABILITY
* R6 - A(SVC ROUTINE TO CALL)
* R7 - INTERRUPT CODE FROM OLD PSW
* R8 -  USED IN CALCULATING TCBTCPUP and TCBTCPUS
*       A(SVCTABLE)
* R12 - SVCFLIH ADDRESSABILITY
* R14 - RETURN ADDRESS FROM SVC ROUTINE
*
*********************************************************************
         TITLE 'SVCFLIH CODE'
*
* Move clock to a lowcore location
*
SVCFLIH  MVC   LOWTIME(4),CLOCK       GET VALUE OF CLOCK INTO LOWTIME
         CLI   LEVELFLG,C'T'          CHECK IF IN TASK STATE
         BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP
         MVI   LEVELFLG,C'S'          OTHERWISE SWITCH TO SYSTEM STATE
*
* Save all GPRs in SVCSAVE
*
         STM   0,15,SVCSAVE           SAVE GPRS IN PROPER SAVE AREA
*
* Establish CVT addressability
*
         L     3,76                   GET @ OF THE CVT
         USING CVT,3                  ESTABLISH CVT ADDRESSABILITY
*
* Establish TCB addressability
*
         L     4,TCBWORDS+4           GET @ CURRENTLY DISPATCHED TCB
         USING TCB,4                  ESTABLISH TCB ADDRESSABILITY
*
* MOVE ALL GPRS TO THE TCB         
*
         MVC   TCBGRS(16*4),SVCSAVE   MOVE GPRS INTO THE TCB
*
* SAVE ALL FPRS INTO THE TCB
*
         STD   0,TCBFRS               STORE FPR 0
         STD   2,TCBFRS+8             STORE FPR 2
         STD   4,TCBFRS+16            STORE FPR 4
         STD   6,TCBFRS+24            STORE FPR 6
*
* Establish Routine Addressability so we can access
* SVCF0119
*
         BALR  12,0                   GET ADDRESS NEXT INSTRUCTION
         USING *,12                   ESTABLISH SVCFLIH ADDRESSABILITY
*
* Establish RB addressability
*
         L     5,TCBRB                GET @ OF CURRENTLY DISPATCHED RB
         USING RB,5                   ESTABLISH RB ADDRESSABILITY
*
* Verify RB address not null
*
         LTR   5,5                    TEST R5
         BZ    SVCF0119               IF IT IS, DIE!!!         
*
* COPY OLD PSW TO INTO THE RB
*
         MVC   RBOPSW(8),OPSWSVC      MOVE OLD PSW INTO THE RB
*
* Calculate accumulated task time
*
         L     8,TCBTDISP             GET TIME OF DISPATCH
         S     8,LOWTIME              SUBTRACT THE CURRENT TIME
*
* Test to see if PSW was in supervisor or problem state
*
         TM    OPSWSVC+1,X'01'        Check if PSW in SV State
         BZ    SVTIME                 If in SV state, ad SV time
         A     8,TCBTCPUP             ADD ACCUMULATED TASK CPU         
         ST    8,TCBTCPUP             SAVE ACCUMULATED TASK TIME
         B     STEP9A                 Move on to STEP9A
SVTIME   A     8,TCBTCPUS             Add accum. SV TIME
         ST    8,TCBTCPUS             Update the SV TIME in TCB
*
* <PERFORM SVC INTERRUPT FUNCTIONS>
*
* A) GET THE INTERRUPT CODE FROM THE OLDPSW
*
STEP9A   CLI   OPSWSVC+3,X'0F'        Check interrupt code ? 15
         BH    SVCF0119               If > 15, die
         LH    7,OPSWSVC+2            GET INTERRUPT CODE INTO R7
*
* B) MAKE SURE CODE IS IN RANGE OF SVCTABLE
*
         SLL   7,3                    MULTIPLY INT CODE * DISPLACEMENT
         A     7,CVTSVCTA             Add displacement to start
         L     6,0(,7)                GET @ OF SVC ROUTINE
         LTR   6,6                    Check if address null
         BZ    SVCF0119               IF IT'S ZERO, DIE
*
* IF SVC IS TYPE 1 THEN
*
         TM    4(7),X'C0'             if this is a Type 1 SVC
         BNZ   NONTYP1                if not type 1, do differently
*        
* TEST AND SET FLAG TO INDICATE 'TYPE 1'
*
         CLI   TYP1FLAG,C'0'          CHECK THE TYPE 1 FLAG
         BNE   SVCF0119               IF IT'S NOT C'0', DUMP
         MVI   TYP1FLAG,C'1'          SET THE TYPE 1 FLAG TO '1'
*
* GO TO SVC ROUTINE
*
         BALR  14,6                   GO TO THE SVC ROUTINE
*
* TEST AND RESET FLAG TO INDICATE NOT TYPE 1
*
         CLI   TYP1FLAG,C'1'          CHECK THE TYPE 1 FLAG
         BNE   SVCF0119               IF IT'S NOT '1', DUMP
         MVI   TYP1FLAG,C'0'          SET IT TO '0'
*
* STORE REGS 0,1,15 IN TCBGRS AREA
*
         STM   0,1,TCBGRS             SAVE R0 AND R1 IN TCBGRS
         ST    15,TCBGRS+15*4         SAVE R15 IN TCBGRS
*
* Branch back to the Dispatcher
*         
         L     12,CVT0DS              Get @ of the Dispatcher
         BR    12                     Branch back to it
*
********************************************************************
* CODE FOR NON-TYPE 1 SVCs
********************************************************************
*
NONTYP1  BALR  12,0                   ESTABLISH ADDR ON 12
         USING *,12                   ESTABLISH ADDR ON 12
*
*    Schedule a new SVRB
*
* Get an SVRB from the CB pool and clear it
*
         GETCB100
         XC    0(CB100LTH,10),0(10)   Clear the SVRB
         LR    5,10                   Base addressability on SVRB
*
* Copy saved registers from the TCB
*
         MVC   RBGRSAVE(16*4),TCBGRS  Copy GPRs to SVRB
         MVC   RBFRSAVE(8*4),TCBFRS   Copy FPRs to SVRB
*
* Format as an SVRB: RBTYPE = C'SVRB', RBFLGS3 = X'00'
*
         MVC   RBTYPE,SVRBTYPE        Set RBTYPE='SVRB'
         MVI   RBFLGS3,X'00'          Set RBFLGS3=X'00'
*
* Put A(TCB) into SVRB RBTCB
*
         ST    4,RBTCB                Put A(TCB) into SVRB
*
* SVRB RBLINK <- TCBRB
*
         MVC   RBLINK+1(3),TCBRB+1    Set up pointer to TCB in SVRB
*
* TCBRB <- A(SVRB)
*
         ST 5,TCBRB                   TCBRB gets A(SVRB)
*
*    Get the A(CVTEXIT) into R14
*
         LA 14,CVTEXIT                Get @ CVTEXIT into R14
*
*    Store Regs 3,4,5,6,14 in the TCBGRS save areas
*   
         ST    1,TCBGRS+4             Save R1 for PC Int. Processing 
         STM   3,6,TCBGRS+4*3         Save regs 3,4,5,6 in TCBGRS
         ST    14,TCBGRS+4*14         and R14
*
*   Create a PSW in the SVRB with instruction address taken from
*   R6, supervisor state, Key 0, interrupts enabled
*
         STCM  6,7,SVRBPSW+5          Save a(SVC routine) into PSW        
         MVC   RBOPSW(8),SVRBPSW      Create the PSW
*
*   Branch back to the dispatcher
*        
         L     12,CVT0DS              GET @ OF THE DISPATCHER
         BR    12                     BRANCH BACK TO THE DISPATCHER
*
SVCF0119 XOPC  25                     DIE IF SOMETHING GOES BAD
*
***************************
* SVCFLIH storage
***************************
*
SVRBPSW  DC    XL5'FF0400000F'        1st part SVRB PSW
         DC    AL3(0)                 Address part of SVRB PSW
SVRBTYPE DC    CL4'SVRB'              For initializing RBTYPE
*
***************************
* END OF SVCFLIH
***************************
*
**********************************************************************
* 
* PCFLIH (PROGRAM CHECK FIRST LEVEL INTERRUPT HANDLER)
*
* Entry Conditions:
* Exit Conditions:
*
* REGISTER USE:
* R3  = A(CVT)
* R4  = A(TCB)
* R5  = A(RB)
* R8  = Calculating Task Times
* R12 = PCFLIH ADDRESSABILITY
*
**********************************************************************
         SVC   3                      MERCIFUL "PORTIA" SVC 3
PCFLIH   TM    OPSWPC+1,X'01'         Check to see if in Sup. State
         BZ    LEVELABN               If so, die!!
         MVC   LOWTIME(4),CLOCK       GET VALUE OF CLOCK INTO LOWTIME
         CLI   LEVELFLG,C'T'          Check if in Task
         BNE   LEVELABN               If not, die!!
         MVI   LEVELFLG,C'S'          Put into System
*
* Save all GPRs in PCSAVE
*
         STM   0,15,PCSAVE            SAVE GPRS IN PC AREA
*
* Establish CVT addressability
*
         L     3,76                   GET @ OF THE CVT
         USING CVT,3                  ESTABLISH CVT ADDRESSABILITY
*
* Establish TCB addressability
*
         L     4,TCBWORDS+4           GET @ CURRENTLY DISPATCHED TCB
         USING TCB,4                  ESTABLISH TCB ADDRESSABILITY
*
* MOVE ALL GPRS TO THE TCB         
*
         MVC   TCBGRS(16*4),PCSAVE    MOVE GPRS INTO THE TCB
*
* SAVE ALL FPRS INTO THE TCB
*
         STD   0,TCBFRS               STORE FPR 0
         STD   2,TCBFRS+8             STORE FPR 2
         STD   4,TCBFRS+16            STORE FPR 4
         STD   6,TCBFRS+24            STORE FPR 6
*
* Establish PCFLIH Addressability
*
         BALR  12,0                   GET ADDRESS NEXT INSTRUCTION
         USING *,12                   ESTABLISH PCFLIH ADDRESSABILITY
*
* Establish RB addressability
*
         L     5,TCBRB                GET @ OF CURRENTLY DISPATCHED RB
         LTR   5,5                    TEST RB ADDRESS
         BZ    PC0119                 IF IT IS NULL, DIE!!!
         USING RB,5                   RB ADDRESSABILITY
*
* COPY OLD PSW TO INTO THE RB
*
         MVC   RBOPSW(8),OPSWPC       MOVE OLD PSW INTO THE RB
*
* Calculate accumulated task time
*
         L     8,TCBTDISP             GET TIME OF DISPATCH
         S     8,LOWTIME              SUBTRACT THE CURRENT TIME
*
* Add accumulated task time and store in TCBTCPUP
*
         A     8,TCBTCPUP             ADD ACCUMULATED TASK CPU         
         ST    8,TCBTCPUP             SAVE ACCUMULATED TASK TIME
*
**********************************************************************
* Now Check if a SPIE exists
* REGISTER USAGE:
* 8  - A(SCA) from TCBPIE
* 9  - A(PIE) from TCBAPIE
* 10 - A(SCA) from A(TCBMSCDA)
* 11 - A(PIE) from SCA
* 7 - A(PICA) from PIE
**********************************************************************
         L     8,TCBPIE               Get TCBPIE
         LTR   8,8                    If TCBPIE=0
         BZ    NOSPIE                 No SPIE Exists
         LA    10,TCBDMSCA            Get A(SCA)
         XR    8,8                    Clear 8
         ICM   8,X'7',TCBPIE+1        Get A(SCA) from TCBPIE
         CR    8,10                   Check if A(SCA) was in TCBPIE
         BNE   NOSPIE                 If not, no SPIE exists
         TM    0(8),X'80'             See if InEx bit of SCA is 1
         BO    NOSPIE                 If it is, no SPIE
* Test if SCA+0 = 0, if so ABEND ???
*         TM    0(8),X'FF'             See if SCA+0 is zero
*         BZ    NOSPIE                 If it is, no SPIE
*
         L     9,TCBAPIE              Get A(PIE) in task region
         XR    11,11                  Clear 11
         ICM   11,X'7',1(8)           Get A(PIE) in SCA
         CR    9,11                   See if A(PIE) in SCA was TCBAPIE
         BNE   NOSPIE                 If not, no SPIE
* Test if PIE+0 = 0, if so ABEND ??? 
*         TM    0(9),X'FF'             If PIE+0 was zero
*         BZ    NOSPIE                 no spie exists
*
         TM    0(9),X'80'             If bit 0 of PIE was 1
         BO    NOSPIE                 ABEND
         XR    7,7                    Clear 7
         ICM   7,X'7',1(11)           Get A(PICA) from PIE+1
         LTR   7,7                    See if it's zero
         BZ    NOSPIE                 If it is, no spie!
*         CR    7,1                    SEE IF PIE CONTAINED ADDR PICA
*         XOPC  25
*         BNE   NOSPIE                 IF NOT, NO SPIE
         ST    8,ASCA                 Save address of SCA
         ST    11,APIE                Save address of PIE
         XR    8,8                    Clear 8
         ICM   8,X'7',1(7)            Get A(EXIT) routine
         LTR   8,8                    Check that it's not zero
         BZ    NOSPIE                 If it's zero, abend
         ST    8,AEXIT                Save address of the EXIT
         XR    11,11                  Clear 11
         ICM   11,X'C',4(7)           Get S0C choices
         LTR   11,11                  Test for zero
         BZ    NOSPIE                 If S0C choices are zero, ABEND
*
* Determine that the occurring S0C is one of the type
* Specified by the SPIE
*
         XR    8,8                    Clear 8
         ICM   8,X'3',RBOPSW+2        Get the S0C code from PSW
         SLL   11,0(8)                Move S0C bit to leftmost pos
         LTR   11,11                  Check if result was negative
         BNM   NOSPIE                 If bit was 1, result negative
*
* Move contents of registers 14 through 2 from TCBGRS into
* PIE+12 and move the PSW from RBOPSW into PIE+4
*
         L     8,APIE                 Get A(PIE)
         MVC   12(2*4,8),TCBGRS+14*4  Save Regs 14,15 to PIE 
         MVC   20(3*4,8),TCBGRS       Save Regs 0,1,2 to pie
         MVC   4(8,8),RBOPSW          Move the PSW into PIE+4
         XR    11,11                  Clear 11
         ICM   11,X'7',NPSWPC+5       Get address of PCFLIH
         BCTR  11,0                   Step back 1
         BCTR  11,0                   Step back 1
         ST    11,TCBGRS+14*4         Save A(Portia SVC 3)
         MVC   TCBGRS+15*4(4),AEXIT   Save A(Exit) to TCBGRS
         MVC   RBOPSW+5(3),AEXIT+1    Save A(Exit) to RBOPSW+5
         MVC   TCBGRS+1*4(4),APIE     Put A(PIE) TCBGRS+1*4
         L     9,ASCA                 Get A(SCA)
         OI    0(9),X'80'             Set first bit of SCA to 1
         OI    0(8),X'80'             Set first bit of PIE to 1
         L     12,CVT0DS              Get A(Dispatcher)
         BR    12                     Go back to the dispatcher  
*       
ASCA     DC    A(0)                   Address of the SCA
APIE     DC    A(0)                   Address of the PIE
AEXIT    DC    A(0)                   Address of the EXIT          
**********************************************************************
* No SPIE Environment Exists!
*
* Build R1 contents as X'800Cn000'
*
NOSPIE   PACK  PCR1+2(1),RBOPSW+3(1)  Flip the digits
         L     1,PCR1                 Now load into R1
*
* Load address of BRABEND and branch into it
*
         L     15,CVTBRABN            Get @ BRABEND routine
         BR    15                     Go into BRABEND
*
PC0119   XOPC  25                     TERMINATE IF SOMETHING GOES BAD
**********************************************************************
* PCFLIH WS
**********************************************************************
         DC    0F'0'                  For alignment
PCR1     DC    X'800C0000'            Stuff to go into R1
PCIC     DC    XL2'0000'              Interrupt Code from PSW
         DROP  3,4,5,12               Done with all addressability
*
*** END PCFLIH ***
*
MCFLIH   DC    X'0119'                MACHINE CHECK FLIH
IOFLIH   DC    X'0119'                I/O FLIH
*
****************************************
* SVC AREA
****************************************
*
        ORG    FIRST4K+X'6000'        GO TO SVC 0
*
************************************************************
* SVC 0
* 
* I/O ROUTINE
*
* ENTRY CONDITIONS:
*   R1  - ADDRESS OF IOB
*   R3  - ADDRESS OF THE CVT
*   R4  - ADDRESS OF THE TCB
*   R5  - ADDRESS OF THE RB
*   R6  - ADDRESS OF THIS ROUTINE
*   R14 - ADDRESS TO RETURN TO SVCFLIH 
*
* EXIT CONDITIONS:
*   R15 = 0 ON SUCCESS
*         4 IF EOF ENCOUNTERED
* LOGIC:
* Logic is embedded within the code
*           
* REGISTER USE:
*        R1 - IOB ADDRESSABILITY
*        R15 - Holds the device address for comparison
*              ADDRESS OF THE BUFFER
*        R6 - ADDRESSABILITY FOR SVC 0
*        R0 -      
*
************************************************************
*
         USING SVC0,6                 ADDR FOR SVC0
         USING IOB,1                  IOB ADDRESSABILITY
*
* check if the EBCDIC characters 'IOB' are in the first
* 3 bytes of the IOB
*
SVC0     CLC   IOBIDENT(3),IOBCHECK   CHECK THE IOBIDENT FIELD
         BNE   SVC00119               CHARACTERS NOT 'IOB' THEN DIE!!
*
* Check that the device address is X'0000'
* If not, die a horrible death.
*
         LH    15,IOBDEVAD            GET THE DEVICE ADDRESS
         LTR   15,15                  CHECK IF IT WAS ZERO
         BNZ   SVC00119               IF NOT X'0000', DIE!!!!
         L     7,IOBUFADD             GET THE ADDRESS OF THE BUFFER
         LH    8,IOBUFLEN             GET THE LENGTH OF THE BUFFER
*
* CHECK IF OPERATION CODE IS X'01', IF IT IS, DO THE WRITE
*
         CLI   IOBOPCDE,X'01'         SEE IF IOBOPCODE IS X'01'
         BE    DOWRITE                IF IT IS, DO THE WRITE
*
* CHECK IF OPERATION CODE IS '02', IF IT IS DO THE READ
*
         CLI   IOBOPCDE,X'02'         SEE IF IOBOPCODE IS X'02'
         BNE   SVC00119               If it's not, something wrong, die
*
* PERFORM THE XREAD
* 
         XREAD 0(0,7),(8)             READ STUFF INTO THE BUFFER
*
* CHECK FOR END OF FILE
*
         BM    EOF                    IF EOF, EXIT WITH RC=4
*
* IF NOT EOF, CHECK BUFFER FOR NINES
*
         CLC   0(8,7),ALLNINES        SEE IF BUFFER CONTAINS NINES
         BNER  14                     IF IT DOES, EXIT WITH RC=4
*
* OTHERWISE (NOT EOF OR ALL 9'S) SET A 0 RC AND RETURN
*
EOF      LA    15,4                   SET RC=4 IN 15
         BR    14                     LEAVE THE SVC WITH RC=0
DOWRITE  XPRNT 0(0,7),(8)             PRINT CONTENTS OF BUFFER
         XR    15,15                  SET R15 TO ZERO
         BR    14                     Return
*
         DROP  1,6                    Done with addr. for SVC 0
SVC00119 XOPC  25                     DIE IF SOMETHING GOES WRONG
*
**********************
* SVC 0 STORAGE
**********************
*
IOBCHECK DC CL3'IOB'                  USED TO CHECK IOB
ALLNINES DC CL8'99999999'             NINES TO TEST AGAINST      
*        
         TITLE 'SVC 1 DOC'
*
**********************************************************************
* SVC 1
*
* ENTRY CONDITIONS:
* R3 - A(CVT)
* R4 - A(TCB)
* R5 - A(RB)
* R6 - A(SVC1)
*
* EXIT CONDITIONS:
* REGISTER VALUES UNCHANGED
* 
* Wait bit     Post bit
* --------     --------
*   0             0        Bits set to 1 and 0, A(RB) saved to ECB
*                          and RBWCF incremented by one.
*   0             1        Nothing: NO OP
*   1             0        XOPC 25 (S301)
*   1             1        Nothing: NO OP
*
**********************************************************************
         TITLE 'SVC1 CODE'            Title the SVC1 Code
         USING SVC1,6                 Establish SVC 1 Addressability
SVC1     C     0,TESTR0               SEE IF R0=1
         BNE   SVC10119               IF NOT, DIE
         TM    0(1),X'40'             Check second bit of MECB
         BCR   1,14                   If CC=3 (Second bit=1), return
         TM    0(1),X'80'             Check first bit of MECB
         BC    1,SVC10119             If CC=3 (First bit=1), Die
*
* Only get here when both wait and post bits are zero
* 
         IC    15,28(,5)              Get the RBWCF
         LA    15,1(,15)              and increment it
         STC   15,28(,5)              then put it back
         STCM  5,7,1(1)               Put A(RB) into the ECB
         OI    0(1),X'80'             Turn on first bit of MECB
         BR    14                     Leave SVC 1 Module
SVC10119 XOPC  25                     Bail out in case of S301
         DROP  6                      Done with SVC1
TESTR0   DC    F'1'                   Check if R0=1
*
*** END OF SVC 1 ****
*
         TITLE 'SVC 2'
*********************************************************************
* SVC 2 -- Type 1 -- Post
*
* Wait      Post         Operation Performed
* -----     -----        -------------------
* 0         1            No Op
* 1         1            No Op
* 1         0            1) Verify RB at ECB+1 has ' PRB' or 'SVRB'
*                        2) Decrement the RBWCF
*                        3) Change W-P to '01'
*                        4) Put bits 2-31 of R0 into bits 2-31 of 
*                           ECB
* 0         0            Steps 3 and 4 from above
*
* ENTRY CONDITIONS:
* R0  - Post code contained in bits 2-31
* R1  - address of the ECB
* R3  - @ the CVT
* R4  - @ the TCB
* R5  - @ the RB
* R6  - @ SVC 2
*
* Working Registers:
* R0  - Post Code
* R1  - A(ECB)
* R6  - 
* R15 - RB Addressability
*********************************************************************
*
         USING SVC2,6                 Establish SVC 2 Addressability
SVC2     TM    0(1),X'40'             Check second bit of MECB
         BOR   14                     If it was 1, return (NO OP)
         L     15,0(1)                Get A(RB) from the ECB
         USING RB,15                  Set up RB addressability
         TM    0(1),X'80'             Check first bit of MECB
         ST    0,0(1)                 Save the Post Code
         BZ    SETWP                  If it's zero, set W-P, post,ret
         CLC   SVC2RB(2),RBTYPE+2     See if 'RB' is in RBTYPE
         BNE   SVC20119               Die if it's not
         IC    0,RBWCF                Get RBWCF
         BCTR  0,0                    Decrement it
         STC   0,RBWCF                Save the new value
         DROP  15                     Done with the RB          
SETWP    OI    0(1),X'40'             Set the Post Bit
         NI    0(1),X'7F'             Turn off wait bit
         BR    14                     Leave SVC 2
         DROP  6                      Done with SVC 2
*
SVC20119 XOPC  25                     Die if there's a problem
*
SVC2RB   DC    CL2'RB'                For checking the RB
*
************************
* End of SVC2
************************
*
*********************************************************************
* SVC 3
*
* ENTRY CONDITIONS
* R3  - Points to the CVT
* R4  - Points to the Current TCB
* R5  - Points to the current RB
* R6  - Used for routine addressability
* R14 - Exit address to SVC-FLIH
*
* EXIT CONDITIONS:
* Current PRB or SVRB "disconnected" from the TCB
*
*********************************************************************
*
         ORG   FIRST4K+X'7000'        Go to location for SVC 3 
         USING SVC3,6                 Establish SVC3 Addressability
         USING CVT,3                  Establish CVT Addressability
         USING TCB,4                  Establich TCB Addressability
         USING RB,5                   Establish RB Addressability
*
* Store registers 0,1,15 in the PRB/SVRB save area
*
SVC3     CLC   OPSWSVC+5(3),NPSWPC+5  Test for portia entry
         BE    PORTIA                 If it is, do the Portia stuff
         STM   0,1,RBGRSAVE           Save R0,R1 into the RB    
         ST    15,RBGRSAVE+15*4       Save R15 into the RB   
*
* Copy GPRS and FPRs to the TCB
*
         MVC   TCBGRS(4*16),RBGRSAVE  Copy GPRs into TCB        
         MVC   TCBFRS(8*4),RBFRSAVE   Copy FPRs into TCB        
         MVC   TCBRB+1(3),RBLINK+1    Make TCB point to next RB   
*
* Check to see if this is a PRB
*
         CLM   4,7,TCBRB+1            See if TCBRB->TCB (This is PRB)
         BE    TEST2                  This is a PRB, Do PRB Stuff    
         TM    RBFLGS3,X'80'          Make sure this is an SVRB      
         BNE   SVC30119               If not, die                    
         B     SVC3END                Otherwise, go to the end       
*
* If this is a PRB, zero out the TCBRB field
*
TEST2    TM    RBFLGS3,X'80'          Make sure this is a PRB (bit 0=1)
         BNO   SVC30119               Die if it's not a PRB
         XC    TCBRB(4),TCBRB         Otherwise clear TCBRB         
SVC3END  MVC   RBCDE(4),SVC3UNCH      Insert an "Unchained" message
         L     5,TCBRB                Get TCBRB into 5 
         BR    14                     Exit to SVCFLIH
*
*********************************************************************
* PORTIA SVC 3 (Tests for TCBPIE = 0 removed)
* R7 = Address of the SCA (Right 3 bytes)
* R8 = Address of the PIE
*
* Steps:
*
* 1) Get A(SCA)
* 2) Verify InEx bit in SCA was 1
* 3) If not 1, XOPC 25
* 4) Set InEx bit in SCA to 0
* 5) Get A(PIE)
* 6) Set InEx bit in PIE to 0
* 7) Move registers 14,2 from PIE to TCBGRS
* 8) Move 2nd half of PSW from PIE into RBO PSW
* 9) Load 0,1,15 into "Honest to God" 0,1,15
*
*********************************************************************
PORTIA   ICM   7,X'7',TCBPIE+1        Get A(SCA)
         TM    0(7),X'80'             Test InEx bit in SCA
         BZ    SVC30119               If it was not 1, die!!
         NI    0(7),X'7F'             Set bit 0 of SCA to zero
         ICM   8,X'7',1(7)            Get A(PIE) from the SCA
         NI    0(8),X'7F'             Set bit 0 of PIE to zero
         MVC   TCBGRS+14*4(8),12(8)   Move 14,15 from PIE to TCBGRS
         MVC   TCBGRS(12),20(8)       Move 0,1,2 from PIE to TCBGRS
         MVC   RBOPSW+4(4),8(8)       Move 2nd half of PSW from PIE+8
         LM    0,1,TCBGRS             Restore R0,R1
         L     15,TCBGRS+15*4         Restore R15
         BR    14                     Return to SVCFLIH
*
SVC30119 XOPC  25                     Die here if things go bad
*
************************
* SVC3 WORKING STORAGE
************************
*
SVC3UNCH DC   CL4'UNCH'               For unchaining the RB
         DROP 3,4,5,6                 Done with addressability
*********************************************************************
* END OF SVC 3
*********************************************************************
        ORG    FIRST4K+X'7300'        GO TO SVC 8
SVC8    DS     0H                     ADDRESS OF SVC 8
        LOADER
        TITLE 'SVC 13'
**********************************************************************
* SVC 13 -- Type 4 -- ABEND
*
* Entry:  R1 = Hit 0,1 Flag Byte: Bit 0 in R1 = 1, calls for a Dump.
*              Hit 2,3,4 System ABEND Code (three hex. digits)
*              Hit 5,6,7 User ABEND Code (trans. to 4 dec. digits)
*         R3 - A(CVT)
*         R4 - A(TCB)
*         R5 - A(RB)
*         R6 - A(SVC13)
*         R10 - Addressability to RB containing the PSW
*         R13 - A(SVC 13 Save Area)
* Exit:   None
*
* Register Usage:
* R1  - Used for LOUNTR calls
* R2  - Return address from LOUNTR
* R3,4,5,6 - Same old stuff
* R7  - 
* R8  -
* R9  -
* R10 -
* R12 - Return address from Print routine
* R13 - Save aread address for entry to SVC 13 Print Routine
* R14 - Return address from SVC 13
* R15 - Used for branching into print routine
*
*
**********************************************************************
*
         ORG FIRST4K+X'8000'          Start SVC13 at X'8000'
         USING SVC13,6                Establish SVC 13 Addressability
         USING CVT,3                  Establish CVT addressability
         USING RB,5                   Establish RB Addressability    
*
* Set the contents of R1 print line
*
SVC13    STCM  1,15,SVC13WRK+12       Put R1 in LOUNTR work area
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   R1VAL(8),SVC13WRK      Put Result on print line
         MVC   SVC13BUF(133),R1MSG    COPY MESSAGE TO PLINE
*
* Print the R1 print line
*
         LA    13,SASVC13             Save area address
         LA    1,PARM1                Get Parm area address
         LA    15,SVC13PRN            Get address of print routine
         BALR  12,15                  Print R1 Message
*
* Put the PSW at ABEND on print line
*
         XR    10,10                  clear R10 for insertion
         ICM   10,7,RBLINK+1          Get A(RB) containing PSW
         DROP  5                      Done with the current RB
         USING RB,10                  Refer to RB containing PSW
*
         LA    7,2                    Do this two times
         LA    8,RBOPSW               Get A(the PSW)
         LA    9,PSWP1                Get place to move PSW part
PSWLOOP  MVC   SVC13WRK+12(4),0(8)    Get 4 bytes of PSW
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   0(8,9),SVC13WRK        Move 8 bytes
         LA    9,9(,9)                Move to next part in pline
         LA    8,4(,8)                Move to next part of PSW
         BCT   7,PSWLOOP              One more time...
*
* Print the PSW Pline
*
         MVC   SVC13BUF(133),PSWMSG   MOVE MESSAGE TO BUFFER
         LA    1,PARM1                Get @ Parm List
         BALR  12,15                  Print PSW Message
*
* Set up 12 bytes of Data pointed to by the PSW
*
         XR    7,7                    clear R7 for inserting address
         ICM   7,7,RBOPSW+5           grab addr. from PSW
         DROP  10                     Done with PRB
*
* Make sure address is in the proper range
*
         S     7,SIX                  Step back six bytes
         BP    HICHECK                If positive, perform check 2
         LA    7,0                    Otherwise start printing at 0
HICHECK  LR    9,7                    Get address into R9
         LA    9,12(,9)               Move to end of printable area
         C     9,CVTMZ00              Check not beyond CVTMZ00
         BNH   PRINTBTS               Ok, print the bytes
         L     7,CVTMZ00              Otherwise, get highest address
         AH    7,NEG12                Subtract 12 bytes
*
PRINTBTS STCM  7,15,SVC13WRK+12       Put address into LOUNTR
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   DAADDR(8),SVC13WRK     Put data area address on pline
*
         LA    9,3                    Loop 3 times
         LA    10,DBYTES1             Get starting addr of data bytes
GETBLOOP MVC   SVC13WRK+12(4),0(7)    Get bytes at location in R7
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   0(8,10),SVC13WRK       Move bytes from storage to pline
         LA    10,10(,10)             Move to next pos in pline
         LA    7,4(,7)                Move to next area in storage
         BCT   9,GETBLOOP             Decrement and loop
*
* Print the 'Data at PSW' Pline
*
         LA    1,PARM1                Parm list address
         MVC   SVC13BUF(133),DMSG     move message to buffer
         BALR  12,15                  Print DMSG
*
* Set up the General Purpose Registers print line 1
*
         USING RB,5                   Addr. on SVRB
         LA    8,4                    Increment of 4
         LA    9,RBGRSAVE+7*4         Limit Register is R9
         LA    10,GPL1STRT            Starting point for 0-7 in pline
         LA    7,RBGRSAVE             Get starting point of GPRS
GRSTART  MVC   SVC13WRK+12(4),0(7)    Get Reg value into LOUNTR area
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   0(8,10),SVC13WRK       Put translated reg in storage
         LA    10,9(,10)              Move to next reg in pline
         BXLE  7,8,GRSTART            Increment and loop
*
* Print first line of GPRs
*
         LA    1,PARM1                Get parm list address
         MVC   SVC13BUF(133),GPRMSG   COPY MESSAGE TO PRINT LINE
         BALR  12,15                  Print the message
*
* Set up the second line of GPRs
*
         MVI   SVC13BUF,C' '            Blank print line
         MVC   SVC13BUF+1(132),SVC13BUF Blank print line
         LA    8,4                    Increment of 4
         LA    9,RBGRSAVE+15*4        Limit Register is R9
         LA    10,GPL1STRT            Starting point for 0-7 in pline
         LA    7,RBGRSAVE+8*4         Get start of GPRS in RB
GR2START MVC   SVC13WRK+12(4),0(7)    Get Reg value into LOUNTR area
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   0(8,10),SVC13WRK       Put translated reg in storage
         LA    10,9(,10)              Move to next reg in pline
         BXLE  7,8,GR2START           Increment and loop
*
* Print the second line of GPRs
*
         LA    1,PARM1                Get @Parm list
         MVC   GPRMSG(10),GPMSG2      Put 'GPRs 8-15' on pline
         MVC   SVC13BUF(133),GPRMSG   COPY LINE TO BUFFER
         BALR  12,15                  Print the message
*
* Set up the Floating Point Registers on pline
*
*
         LA    8,4                    Increment of 4
         LA    9,RBFRSAVE+3*8         Limit Register R9
         LA    10,FPR0STRT            Place to store regs on pline
         LA    7,RBFRSAVE             Get starting point of FPRs
FPRSTART MVC   SVC13WRK+12(4),0(7)    Get part of an FPR into LOUNTR
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate it
         MVC   0(8,10),SVC13WRK       Move translated stuff
         LA    10,8(,10)              Move to next FPR on pline
         LA    7,0(8,7)               Increment R7 by 4
         MVC   SVC13WRK+12(4),0(7)    Get 2nd part of FPR into LOUNTR
         LA    1,SVC13WRK             Get @ LOUNTR work area
         BAL   2,LOUNTR               Translate part 2
         MVC   0(8,10),SVC13WRK       Move translated stuff
         LA    10,10(,10)             Move to next FPR on pline
         BXLE  7,8,FPRSTART           Increment and Loop
*
*   Print the FPR pline
*        
         LA    1,PARM1                Get parm list address 
         MVC   SVC13BUF(133),FPRPLIN  COPY FPRs to buffer
         BALR  12,15                  Print the line
*
* Chain through all RBs pointing their PSWs at CVTEXIT
*
         LA    7,CVTEXIT              Get address of CVT Exit
RBLOOP1  STCM  7,7,RBOPSW+5           Save it into the RB
         ICM   5,7,RBLINK+1           Move to next RB
         CR    5,4                    Check for end of RB chain
         BE    SVC13END               If it is, end SVC 13
         B     RBLOOP1                If not encountered, continue
SVC13END BR    14                     END OF SVC 13
         DROP  3,5,6                  Done with addressability
**********************************************************************
* SVC 13 NON-MODIFIED STORAGE
**********************************************************************
*
GPMSG1   DC    CL10'0GPR 0-7  '             GPR 0-7 MESSAGES
GPMSG2   DC    CL10'0GPR 8-15 '             GPR 8-15 MESSAGES
FPRMSG   DC    CL18'0FPRs 0,2,4,6:    '     FPR 0,2,4,6 MESSAGE
R1MSG1   DC    CL16'0CONTENTS OF R1: '      R1 Message
PSWMSG1  DC    CL23'0PSW AT TIME OF ERROR: ' PSW Message
DATAMSG1 DC    CL13'0DATA AT PSW '          Data Message
HYPHEN   DC    CL3' - '                     HYPHEN
LNTREND  BR    2                            Return from LOUNTR
IOBINI   DC    CL4'IOBW'                    For definiing IOB
         DC    XL2'0000'                    For defining IOB
         DC    X'01'                        For defining IOB
*
SIX      DC    F'6'                   Value of 6
NEG12    DC    F'-12'                 Value of -12
*
**********************************************************************
* SVC 13 MODIFIED STORAGE
**********************************************************************
*  
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT
         DC    CL32'IOB FOR SVC 13 FOLLOWS' LABEL SVC 13 IOB
IOBSVC13 DC    F'0'                   Fullword Alignment
         ORG   IOBSVC13               Go back and redefine
         DC    CL4'IOBW'              IOB IDENTIFICATION
         DC    XL2'0000'              FOR XPRINT
         DC    X'01'                  '01' = WRITE
         DC    C'0'                   RESERVED FOR STUFF
         DC    A(SVC13BUF)            A(BUFFER) TO WRITE, RIGHT 3 
         DC    H'133'                 LENGTH OF BUFFER TO READ/WRITE
         DC    H'0'                   RESERVED FOR STUFF
*
SVC13WRK DC    CL16'L'                LOUNTR work area
RETLNTR  DC    XL2'07F2'              For coming back from LOUNTR
*
PARM1    DC    A(SVC13BUF)            Address of the print line
PARM2    DC    A(PLINEL)              Address of the halfword length
PARM3    DC    A(IOBSVC13)            Address of IOB
*
SASVC13  DC    16F'0'                 Save area for SVC13PRN
PLINEL   DC    H'133'                 Pline length
*
SVC13BUF DC    CL133' '               Line buffer
*
GPRMSG   DC    C'0'                   GPR carriage control
         DC    CL9'GPR 0-7  '         GPR MESSAGES
         DC    8CL1' '                FILLER SPACE
GPL1STRT DC    CL9'XXXXXXXX '         GPR 0
         DC    CL9'XXXXXXXX '         GPR 1
         DC    CL9'XXXXXXXX '         GPR 2
         DC    CL9'XXXXXXXX '         GPR 3
         DC    CL9'XXXXXXXX '         GPR 4
         DC    CL9'XXXXXXXX '         GPR 5
         DC    CL9'XXXXXXXX '         GPR 6
         DC    CL9'XXXXXXXX '         GPR 7
         DC    43C' '                 rest of print line
GPL1PLEN EQU   *-GPRMSG               length of print line 1
*
FPRPLIN  DC    C'0'                   double space
         DC    CL17'FPRs 0,2,4,6:    ' next
FPR0STRT DC    CL18'XXXXXXXXXXXXXXXX  ' FPR 0
         DC    CL18'XXXXXXXXXXXXXXXX  ' FPR 2
         DC    CL18'XXXXXXXXXXXXXXXX  ' FPR 4
         DC    CL18'XXXXXXXXXXXXXXXX  ' FPR 6
         DC    43C' '                 rest of print line
FPRPLLEN EQU   *-FPRPLIN              Length of FPR pline
*
R1MSG    DC    C'0'                   Carriage control
         DC    CL16'CONTENTS OF R1: ' R1 Message
R1VAL    DC    CL8'XXXXXXXX'          R1 Message
         DC    108C' '                rest of print line
R1MSGLEN EQU   *-R1MSG                R1 Message Length
*
PSWMSG   DC    C'0'                   CARRIAGE CONTROL
         DC    CL20'PSW AT TIME OF ERROR' PSW Message
         DC    CL2': '                FOR CLEARER READING
PSWP1    DC    CL8'PSW1 HERE'         PSW PART 1
         DC    CL1' '                 SOME SPACE
PSWP2    DC    CL8'PSW2 HERE'         PSW PART 2
         DC    93C' '                 blanks for pline
PSWMSGL  EQU   *-PSWMSG               PSW message length
*
DMSG     DC    C'0'                   CARRIAGE CONTROL
         DC    CL12'DATA AT PSW '     data Message
DAADDR   DC    CL8'XXXXXXXX'          Data area address
DASH     DC    CL3' - '               Data Message
DBYTES1  DC    CL8'XXXXXXXX'          First 4 data bytes
         DC    2CL1' '                Data Message
DBYTES2  DC    CL8'XXXXXXXX'          Second 4 data bytes
         DC    2CL1' '                Data Message
DBYTES3  DC    CL8'XXXXXXXX'          Last 4 data bytes
         DC    81C' '                 Rest of print line
DMSGL    EQU   *-DMSG                 Length of Data Message  
         ORG   ,                      MOVE IT FORWARD
*********************************************************************
* END OF SVC 13 MODIFIED STORAGE
*********************************************************************
*
*********************************************************************
* SVC 13 PRINT ROUTINE
*
* ON ENTRY:
*
* R1  - A(PARAMETER LIST)
*          0(R1) = A(print buffer)
*          4(R1) = A(halfword buffer length)
*          8(R1) = A(IOB)
* R12 - Address to return to
* R13 - Address of 16F Save area
* R15 - Routine Base register, A(SVC13PRN)
* 
* REGISTER USAGE:
*
* R1  - PARAMETER LIST ON ENTRY
*       ADDRESS OF IOB FOR SVC 0
* R12 - Return address
*
**********************************************************************
*
         USING SVC13PRN,15        Use R15 as base reg
SVC13PRN STM   0,15,0(13)         Save registers for return
         LM    4,6,0(1)           Get Parm Items
         LH    5,0(,5)            Get halfword length
         ST    4,8(,6)            Save buff @ to IOB
         STH   5,12(,6)           Save buff len to IOB
         LR    1,6                Get IOB address for SVC 0
         XOPC  4                  Turn off trace
         SVC   0                  Call SVC 0 to print
         XOPC  2                  Turn on trace
         LTR   15,15              Check return code
         BNZ   PRN0119            Die if it's not zero
         LM    0,15,0(13)         Restore registers
         BR    12                 Leave SVC13PRN
PRN0119  XOPC  25                 Die if RC != 0
         DROP  15                 End of routine addressability
         EJECT
*
**********************************************************************
* SVC 14 - Type 3 (SPIE -- Specify Program Interrupt Exit)
* On Entry:
* R1  = A(PICA)
* R3  = A(CVT)
* R4  = A(TCB)
* R5  = A(RB)
* R6  = A(SVC14)
* R14 = Exit Address
*
* On Exit:
* R1 = A(previous PICA) or 0 if no previous PICA
*
* Working Registers:
* R7 - Used for testing A(EXIT)
* R8 - Used for testing SOC1-SOCF flags
* R9 - Holds TCBPIE
* R10 - Test TCBDMSCA in CREATE
* R11 - Address of the PIE
**********************************************************************
*
         USING  SVC14,6               Establish SVC14 Addressability
         USING  TCB,4                 Establish TCB Addressability
         USING  RB,5                  Establish RB Addressability
SVC14    LTR    1,1                   Check for A(PICA) in R1
         BZ     CORI                  If none, cancel/ignore SPIE
         XR     7,7                   Clear R7 for testing
         ICM    7,7,1(1)              Get A(EXIT)
         LTR    7,7                   Check if it's zero
         BZ     CORI                  If it is, cancel/ignore the SPIE
         TM     4(1),X'80'            Check first bit in PICA Flags
         BNZ    SVCE0119              If it is set, die 
         XR     8,8                   Clear 8
         ICM    8,3,4(1)              Get Flags for SOC1-SOCF in PICA
         LTR    8,8                   Check if it's zero
         BZ     CORI                  If it is, cancel/ignore the SPIE
*
* Otherwise, create or modify a SPIE
* First check if TCBPIE = 0 (First step going through chain)
*
         L      9,TCBPIE              Get TCBPIE field
         LTR    9,9                   Check if it's zero
         BZ     CREATE                If it's not, cancel SPIE
**********************************************************************
* MODIFY THE EXISTING SPIE
*
* 1) Check TCBPIE is non-zero. If not, die. <taken care of above >
* 2) Check TCBPIE contains address of SCA.  < ignored >
* 3) Check SCA is non-zero.
* 4) Check SCA contains address of the PIE.
* 5) Check SCA bit 0 is 0.
* 6) Check that PIE is non-zero. 
* 7) Check that PIE contains address of the PICA
* 8) Check that bit 0 of the PIE is zero
* 9) Save address of old PICA
* 10) Save address of new PICA to PIE+1
* 11) Put program mask from new PICA into PRB PSW
*
* R9  - Address taken from TCBPIE (address of SCA)
* R10 - Address of the SCA
* R11 - A(PIE) from TCBAPIE
* R12 - A(PICA) from the PIE
*
*********************************************************************
MODIFY   L     10,TCBDMSCA            Get SCA
         LTR   10,10                  Test if it's zero
         BZ    SVCE0119               If it is, die!!
         XR    9,9                    Clear 9
         ICM   9,X'7',TCBPIE+1        Get A(SCA) from TCBPIE
         LA    10,TCBDMSCA            Get address of SCA
         CR    9,10                   Comp A(SCA) to addr frm TCBPIE
         BNE   SVCE0119               Not equal? Then Die!!
         TM    0(10),X'80'            Check bit 0 of the SCA
         BNZ   SVCE0119               If it's not a zero, then die!!
         L     11,TCBAPIE             Get A(PIE)
         CLC   PIETEST(32),0(11)      Check PIE=0
         BE    SVCE0119               If PIE=0 then die
         TM    0(11),X'80'            If bit 1 Pie set
         BNZ   SVCE0119               Then Die
*
* Start of Modification
*
         XR    12,12                  Clear R12
         ICM   12,X'7',1(11)          Get address of PICA from PIE
         STCM  1,X'7',1(11)           Save addr of new PICA to PIE+1
         MVI   0(11),X'00'            Set PIE+0 to zero
         L     10,RBLINK              Get A(PRB)
         DROP  5                      Stop working with SVRB
         USING RB,10                  Work with PRB
         MVN   RBOPSW+4(1),0(1)       Set program mask from new PICA
         DROP  10                     Done with PRB
         USING RB,5                   work wth SVRB again
         LR    1,12                   Set R1 to address of old PICA
         BR    14                     Exit SVC 14
*
*********************************************************************
* CREATE THE SPIE ENVIRONMENT
* Entry:
* R1 = A(PICA)
* R9 = Zero because TCBPIE does not exist
*
* Working:
* R10
* R11 - Address of the PIE
* 
*
* 1) Check if TCBDMSCA is zero. If not, XOPC 25
* 2) Put address of SCA into TCBPIE+1
* 3) Put address of the PIE into SCA+1
* 4) Put address of PICA into PIE+1
* 5) Save current program mask to TCBPIE+0
* 6) Put new program mask from PICA+0 into RBOPSW
*
*********************************************************************
CREATE   L     10,TCBDMSCA            get TCBDMSCA
         LTR   10,10                  See if it's zero
         BNZ   SVCE0119               If not, die
         LA    10,TCBDMSCA            get A(TCBDMSCA)
         STCM  10,X'7',TCBPIE+1       Put A(SCA) into TCBPIE+1
         MVC   1(3,10),TCBAPIE+1      Put A(PIE) into SCA+1
         MVI   0(10),X'00'            Set SCA+0 to X'00'
         L     11,TCBAPIE             Get address of the PIE
         STCM  1,X'7',1(11)           Save address of PICA into PIE+1
         MVI   0(11),X'00'            Set PIE+0 to X'00'
         L     10,RBLINK              Get A(PRB)
         DROP  5                      Leave SVRB alone
         USING RB,10                  Work with the PRB
         MVN   TCBPIE(1),RBOPSW+4     Save current program mask
         MVN   RBOPSW+4(1),0(1)       Set new program mask
         DROP  10                     Done with PRB
         XR    1,1                    Set RC=0 for no prev SPIE
         BR    14                     Return from SVC 14
**********************************************************************
* CANCEL/IGNORE SPIE ENVIRONMENT
**********************************************************************
CORI     L     9,TCBPIE               Get TCBPIE
         LTR   9,9                    Check if TCBPIE=0
         BNZ   CANCEL                 If not, cancel the SPIE env
         XR    1,1                    Set R1 to 0
         BR    14                     Return from SVC 14
*
**********************************************************************
* CANCEL THE SPIE ENVIRONMENT
*
* Entry:
* R9 points to the SCA
*
* 1) Set the saved PSW mask to the PRB PSW
* 2) Get A(SCA) from TCBPIE and set TCBPIE to zero
* 3) Get A(PIE) from the SCA and clear the SCA
* 4) Save address of the PICA and zero first 4 bytes of the PIE
* 5) Put address of the PICA into R1 for return from SVC 14
*********************************************************************
*
         USING RB,5                   Work with SVRB
CANCEL   XR    9,9                    Clear R9
         ICM   9,X'7',TCBPIE+1        Get A(SCA)
         L     11,RBLINK              Get A(PRB)
         DROP  5                      Done with SVRB
         USING RB,11                  Update PRB
         MVN   RBOPSW+4(1),TCBPIE+0   Move saved PSW Mask
         DROP  11                     Done with PRB
         XC    TCBPIE(4),TCBPIE       Clear TCBPIE to zero        
         ICM   10,X'7',1(9)           Get A(PIE) from SCA
         XC    0(4,9),0(9)            Clear the SCA
         XR    12,12                  Clear 12
         ICM   12,X'7',1(10)          Get A(PICA)
         XC    0(4,10),0(10)          Clear first 4 bytes of PIE
         LR    1,12                   Put A(Old PICA) into R1
         BR    14                     Exit SVC14
SVCE0119 XOPC  25                     Die if something goes bad
         DROP  4,6                    Done with TCB, SVC Addr
***************************************************************
* SVC 14 WORKING STORAGE
***************************************************************
PIETEST DC     32XL1'00'     For testing PIE=0     
*
****************************************
* CONTROL BLOCKS OBTAINED DYNAMICALLY 
****************************************
*
         ORG   FIRST4K+X'100E0'       MOVE TO LOCATION FOR CB100s
CB100LTH EQU   X'100'                 LENGTH OF THE CONTROL BLOCKS
CB100#   EQU   31                     NUMBER OF CB100 BLOCKS
CB100HDR DC    A(0)                   NULL PTR
         DC    CL28'THE CB100 POOL FOLLOWS THIS'  DEFINE CB100HDR
CB100POL DC   (CB100#)CL(CB100LTH)'1234-BRANDON TWEED-UNUSED CB' INIT
         ORG   ,                      MOVE ON         
*
****************************************
* NIP/MS (MASTER SCHEDULER)
*
* REGISTERS:
*  3 - CVT ADDRESSABILITY
*  8 - MSDA ADDRESSABILITY
* 12 - NIP/MS ADDRESSABILITY
*
****************************************
*
         ORG   FIRST4K+X'12000'       MOVE TO LOCATION FOR NIP/MS
NIPMS    BALR  12,0                   SET UP ADDRESSABILITY
         BCTR  12,0                   BACK ONE
         BCTR  12,0                   BACK ONE
         USING NIPMS,12               ESTABLISH NIPMS ADDR
         L     3,76                   GET A(CVT)
         USING CVT,3                  ADDR FOR CVT
*
* Do test of SVC 8
* Uses regs 7,8,9,10,0,1
* 9 - looping
* 7 - Address of Loader
* 8 - Increment value of X'400'
*
         XR    7,7           Clear 7
         XR    8,8           Clear 8
         LA    9,2           Loop once
         L     7,SVC8STRT    Get SVC8 New Load point
         LA    8,X'400'      X'400' bytes available space
TST8     LR    0,7           Get loading point
         LR    1,8           Get available space
         XOPC  4             Turn off trace
         SVC   8             Call SVC 8 to load the loader
         XOPC  2             Turn on trace
         LTR   15,15         Check return code
         BNZ   SVC8FAIL      If failed, bomb out
* Update SVC Table
         L     10,CVTSVCTA   Get A(SVCTABLE)
         ST    7,64(,10)     Save New A(SVC8) into SVCTABLE         
         LA    7,0(8,7)      Increment load address by X'400'
         BCT   9,TST8        Test one more time
*
* Done testing loader
*      
         LA    8,MYMSDA               GET ADDDRESS OF MSDA
         USING MSDA,8                 ADDR FOR MSDA
MSWAITLP LA    0,1                    Set R0 for first SVC 1
         LA    1,MSDAMECB             GET A(MECB)
         SVC   1                      CALL 'WAIT'
         CLC   MSDAMECB(4),X7FDIS     COMPARE MECB WITH X'7F',C'DIS'
         BNE   MS0119                 IF NOT CORRECT, DIE
CURVSMAX CLC   MSDACURI(4),MSDAMAXI   COMPARE CURI TO MAXI
         BNL   DOMSWAIT               IF CURI <= MAXI, WAIT
         LA    1,IOBREAD              GET A(IOBREAD) FOR READ
         SVC   0                      READ THE PARM CARD
         LTR   15,15                  If R15 = 0, Good to go
         BZ    RUNJOB                 READ WAS SUCCESSFUL, RUN JOB
         L     0,MSDACURI             GET CURI
         LTR   0,0                    IF VALUE IS ZERO
         BZ    MS0119                 NO MORE JOBS, DIE
         B     DOMSWAIT               IF NOT, WAIT
*
*** START OF "RUN JOB" CODE
*
* 1) Obtain address of region where program is to be run
*
RUNJOB   L     4,MSDAFLAD             Get @ REGION
*
* 2) Get pad character and set 4096 bytes of region
*
         L     5,FOURK                GET 4K
         IC    7,MSDAFPAD             INSERT PAD BYTE
         SLL   7,24                   SHIFT PAD BYTE IN REG
         MVCL  4,6                    FILL USER REGION
*
* 3) obtain key and fetch protect and perform 2 SSKs
*
         L     4,MSDAFLAD             GET @ USER REGION
         IC    9,MSDAFKEY             GET KEY 
         SSK   9,4                    SET KEY FOR REGION
         LA    4,2048(,4)             MOVE TO NEXT 2K
         SSK   9,4                    SET KEY FOR 2ND PART
*
* Set up PIE before the user region
*
         LA    4,4096-32              GO TO START OF PIE
         A     4,MSDAFLAD             RESOLVE DISPLACEMENT
         ST    4,PIEPTR               SAVE ADDR OF PIE FOR L8R
         MVC   0(4,4),PIE             PUT "PIE" INT USR REGION
         MVC   4(28,4),0(4)           RIPPLE THE PIE
*
* Parse parameter and move it into the user region
*
* R4 = Start of PIE
* R5 = A(BUFFER)/Address for start of actual parm
* R6 = A(End of Parm Buffer)
* R7 = Points to end of actual parm
*
         LA    5,BUFFER               Get start of buffer
         LA    6,80(,5)               Get @ end of buffer
PRMLOOP  CLC   0(6,5),PRMSRCH         See if encountered ',PARM='
         BE    PRMFOUND               If so, go to PRMFOUND
         CR    5,6                    If end of buffer encountered
         BE    NOPRMFND               Done, no parm found
         LA    5,1(,5)                Move to next byte in parm field
         B     PRMLOOP                Continue checking for parm
*
PRMFOUND LA    5,6(,5)                Move to start of actual parm
         CR    5,6                    If past end of buffer
         BH    NOPRMFND               Done, no valid parm
         CLI   0(5),C' '              If first parm char is a blank
         BE    NOPRMFND               Parm length is zero
         CLI   0(5),X'7D'             If first parm char is apostrophe
         BE    PRMQUOTE               handle param in single quotes
         MVI   PRMDLM,C' '            otherwise parm delim is space
         B     DOPARM                 DO PARSING 
PRMQUOTE MVI   PRMDLM,X'7D'           apostrophe is delimiter
         LA    5,1(,5)                Step into the parameter
*
* DO PARSING AND SEARCHING FOR PARM
*
DOPARM   LR    7,5                    Start with beginning of param
PRMLOOP3 CLC   0(1,7),PRMDLM          Check for ending space
         BE    PRMDONE                if encountered, done parsing
         LA    7,1(,7)                Move forward in the buffer
         CR    7,6                    Check to see if past end 
         BH    NOPRMFND               If so, treat as if no parm
         B     PRMLOOP3               Otherwise, Continue searching
*
* IF NO PARM DETECTED, DO THIS
*
NOPRMFND XR    7,7                    Clear R7
         STCM  7,3,PRMLEN             Set parm length to zero
         B     SULEN                  No parm, set up length
*         
PRMDONE  SR    7,5                    Calculate length of PARM
         STCM  7,3,PRMLEN             Save the length for use
*
* Test to see if parm length was even
*
BLDPARM  TM    PRMLEN+1,X'01'         See if PRMLEN was even
         BZ    CPYPARM                If it was, no need to pad
*
* Pads the parameter with a byte of X'00'      
*
PADPARM  BCTR  4,0                    Step back a byte
         MVI   0(4),X'00'             Set up pad byte of zero
*   
CPYPARM  SR    4,7                    Step back PARMLEN # of bytes
         ST    4,PARMPTR              Save @ of parm start
         BCTR  7,0                    Length code is L - 1
         EX    7,COPYPRM              Copy parm into the User Region
*
* Now set up the length field
*
SULEN    S     4,PSZLEN               Move to address for pointer
         ST    4,PLENPTR              Save @ of parm length field
         TM    PLENPTR+3,X'03'        Check if address div by 4
         MVC   0(2,4),PRMLEN          Copy PRMLEN to current position
         BZ    BLDPTR                 If SO, no pad, build pointer
         BCTR  4,0                    Move back 1 byte
         BCTR  4,0                    Move back 1 more byte
         XC    0(2,4),0(4)            CLear bytes (insert padding)
*
* Just copies PRMLEN w/out inserting padding
*
BLDPTR   S     4,PTRLEN               Step back the length of pointer
         MVI   0(4),X'80'             Set first byte to X'80'
         MVC   1(3,4),PLENPTR+1       Set pointer to the length     
         ST    4,PARMPTR              Save @ of ptr field into PARMPTR
*
* 5) Set up an 18F save area and set the 2nd FW to zero
*    Save the address of this SA
*
         S     4,SAVLEN               MOVE BACK 72 BYTES
         ST    4,SAPTR                SAVE POINTER TO SA
         XC    4(4,4),4(4)            CLEAR 2ND FULLWORD
*
* 6) Load the user's program into the 4K region
*
         L     0,MSDAFLAD             GET @ LOAD LOCATION
         SR    4,0                    CALC AVAILABLE SPACE
         LR    1,4                    SET R1 = AVAILABLE SPACE
SVC8OFF  XOPC  2                      DOES NOTHING 1ST TIME THRU
         SVC   8                      CALL THE LOADER
         MVI   SVC8OFF+1,X'04'        Turn off trace 2nd time
         XOPC  2                      MAKE SURE TRACE ON FOR REST
         LTR   15,15                  CHECK RETURN CODE
         BNZ   MS0119                 IF NOT ZERO, DIE
         ST    0,EPAPTR               SAVE ENTRY POINT ADDRESS
         ST    1,MODLEN               SAVE MODULE LENGTH
*
* 7) OBTAIN AND CONFIGURE TCB AND RB
*
        GETCB100
        LR     9,10                   GET A(TCB) into R9
        USING  TCB,9                  TCB ADDR
        XC     TCB(CB100LTH),TCB      CLEAR THE TCB
        MVC    TCBTNAME(8),TNAME      SET TCBTNAME
        MVI    TCBTNAME+3,C'1'        SET # FOR TCBTNAME
        MVC    TCBIDENT(4),TIDENT     SET TCBIDENT
        IC     10,IDNTNUM             GET NUM FOR TCBIDENT
        STC    10,TCBTNAME+3          SAVE IDENT CHARACTER
        LA     10,1(,10)              INCREMENT IDENT NUM
        STC    10,IDNTNUM             SAVE UPDATED IDENT NUM
        MVC    TCBGRS(8),TGRS         SET TCBGRS
        MVC    TCBGRS+8(56),TGRS      RIPPLE TCBGRS
        MVC    TCBFRS(8),TFRS         SET TCBFRS
        MVC    TCBFRS+8(24),TFRS      RIPPLE TCBFRS
        MVC    TCBGRS+1*4(4),PARMPTR  SET R1= PARM POINTER
        MVC    TCBGRS+13*4(4),SAPTR   SET R13 = SAVE AREA
        MVC    TCBGRS+15*4(4),EPAPTR  SET R15 = EPA
        MVC    TCBAPIE(4),PIEPTR      SET TCBAPIE -> PIE IN TCB 
        LA     11,CVTEXIT             GET A(CVTEXIT)
        ST     11,TCBGRS+4*14         SAVE A(CVTEXIT)
        MVC    TCBAPARM(4),PARMPTR    SET UP A(PARM) IN TCB
        MVC    TCBFSA(4),SAPTR        SET UP SAVE AREA PTR IN TCB
        L      1,EPAPTR               GET EPA
        MVC    TCBPNAME(8),5(1)       GET PROGRAM NAME FROM EPA+5
*
* GET THE RB AND CONFIGURE IT
*
        GETCB100
        USING  RB,10                  ESTABLISH RB ADDR
        XC     RB(CB100LTH),RB        CLEAR THE RB
        ST     9,RBTCB                SET RBTCB TO POINT TO TCB
        ST     10,TCBRB               SET UP TCBRB TO POINT TO RB
        MVC    RBTYPE(4),RTYPE        SET RBTYPE
        OI     RBFLGS3,X'80'          SET BIT 0 TO 1 (PRB)
        MVZ    NEWPSW+1(1),MSDAFKEY   LEFT HIT OF KEY INTO PSW
        L      1,EPAPTR               GET EPA
        STCM   1,7,NEWPSW+5           SET ADDRESS IN PSW
        MVC    RBOPSW(8),NEWPSW       PUT NEW PSW IN PRB
        MVC    RBGRSAVE(8),RGRS       INIT RB GRS
        MVC    RBGRSAVE+8(56),RGRS    RIPPLE INIT VALUE
        MVC    RBFRSAVE(8),RFRS       INIT RB FRS
        MVC    RBFRSAVE+8(24),RFRS    RIPPLE INIT VALUE
        STCM   9,7,RBLINK+1           POINT RBLINK TO TCB
        DROP   9,10                   DONE WITH TCB & PRB FOR NOW
*
* 8) BUILD A JOB START MESSAGE AND PRINT IT OUT
*
         MVC   LACALL+12(4),EPAPTR    MOVE LOAD ADDRESS INTO LOUNTR
         BAL   1,LOUNTR               CALL LOUNTR
LACALL   DC    CL16'L'                LOUNTR STORAGE
         MVC   JSLAOUT(8),LACALL      GET LOAD ADDRESS TO PLINE
         MVC   LACALL2+12(4),MODLEN   PUT MODULE LENGTH INTO LOUNTR
         BAL   1,LOUNTR               CALL LOUNTR
LACALL2  DC    CL16'L'                STORAGE FOR SECOND LOUNTR
         MVC   JSPLOUT(8),LACALL2     GET PRINTABLE MODULE LENGTH
         L     4,EPAPTR               GET EPA
         MVC   JSPNAME(8),5(4)        GET PROGRAM NAME FROM EPA+5
         USING TCB,9                  ADDRESS TCB
         MVC   JSTCBN(8),TCBTNAME     GET TCB NAME ONTO PRINT LINE
         DROP  9                      DONE WITH TCB
         LA    1,IOBWRITE             GET @ IOB FOR JOB START
         SVC   0                      PRINT THE JOB START MESSAGE
*
* 9) UPDATE VALUES IN THE MSDA
*
         L     4,FOURK                GET 4K
         A     4,MSDAFLAD             ADD 4K TO USER REGION START
         ST    4,MSDAFLAD             SAVE UPDATED REGION START
         LA    4,1                    FOR ADDING TO PAD
         A     4,MSDACURI             INCREMENT CURI BY 1
         ST    4,MSDACURI             SAVE UPDATED CURI VALUE
         IC    5,MSDAFPAD             GET PAD VALUE
         LA    5,1(,5)                INCREMENT PAD CHARACTER
         STC   5,MSDAFPAD             SAVE UPDATED PAD CHARACTER
         IC    5,MSDAFKEY             GET KEY VALUE
         LA    5,16(,5)               INCREMENT BY X'10'
         STC   5,MSDAFKEY             SAVE UPDATED KEY VALUE
*
* 10) chain user's TCB into the chain following NIP/MS TCB
*
SSMDIS   DS    0H                     FOR THE FUTURE
         USING TCB,9                  ESTABLISH TCB ADDRESSABILITY
         L     10,CVTHEAD             GET START TCB CHAIN
         ST    10,TCBBACK             SAVE BACKWARD POINTER
         DROP  9                      DONE WITH NEW TCB
         USING TCB,10                 DEAL WITH MS TCB
         L     11,TCBTCB              GET MSTCB FORWARD POINTER
         ST    9,TCBTCB               ST MSTCB FORWARD POINTER TO NEW
         DROP  10                     DONE WITH MS TCB
         USING TCB,9                  ESTABLISH NEW TCB ADDR
         ST    11,TCBTCB              UPDATE NEW TCB FORWARD POINTER
         DROP  9                      DONE WITH NEW TCB
         USING TCB,11                 ADDRESSABILITY TO LAST TCB
         ST    9,TCBBACK              UPDATE BACKWARD POINTER
         DROP  11                     DONE WITH LAST TCB
SSMENA   DS    0H                     FOR THE FUTURE
*
* 11) BRANCH TO CURVSMAX
*
         B     CURVSMAX               RETURN TO CURVSMAX
DOMSWAIT XC    LOCMECB(4),LOCMECB     CLEAR MECB
         B     MSWAITLP               GO BACK TO MS WAIT LOOP
MS0119   XOPC  25                     MASTER SCHEDULER BAIL POINT
SVC8FAIL DC    X'0119'                If Testing SVC8 fails, bomb out
         DROP  3,8,12                 DONE WITH CVT,MSDA,MSNIP    
********************************************************************
* MS/NIP WORKING STORAGE
********************************************************************
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT
SVC8STRT DC    A(X'7800')             First time, Load at X'7800'
NIPMSPIE DC    0F'0',8CL4'PIE'        PIE FOR NIPMS
TNAME    DC    CL8'TCBn BDT'          NEW TCB NAME VALUE
TIDENT   DC    CL4'TCB '              NEW TCB IDENT 
TGRS     DC    CL8'TCBGRS'            NEW TCB GRS INIT VALUE
TFRS     DC    CL8'TCBFRS'            NEW TCB FRS INIT VALUE
RTYPE    DC    CL4' PRB'              NEW RB RBTYPE VALUE 
RGRS     DC    CL8'RBGRSAVE'          RB GRS INIT VALUE
RFRS     DC    CL8'RBFRSAVE'          RB FRS INIT VALUE
PIE      DC    CL4'PIE '              PIE INIT VALUE
IDNTNUM  DC    C'1'                   FOR INITIALIZING TCBIDENT
NEWPSW   DC    XL5'FF0501190F'        FIRST PART OF PSW
         DC    AL3(0)                 ADDRESS PART OF PSW
X7FDIS   DC    X'7F',C'DIS'           FOR CHECKING MECB
*
* PARM PARSING STUFF
*
PRMSRCH  DC    CL6',PARM='            PARM search string 
COPYPRM  MVC   0(0,4),0(5)            Copy buffer contents
PARMLEN  DC    F'88'                  88 BYTES FOR PARM
PARMPTR  DC    A(0)                   POINTER TO PARM AREA
PLENPTR  DC    A(0)                   POINTER TO PARM LENGTH
PTRLEN   DC    F'4'                   POINTER IS 4 BYTES LONG
PSZLEN   DC    F'2'                   Size of the parm length field
PRMLEN   DC    AL2(0)                 PARM length calculated
PRMDLM   DC    C' '                   Parm delimiter detected
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT
         DC    CL32'BUFFER LIES BELOW' LABEL THE DUMP
BUFFER   DC    80C'Z'                 READ BUFFER
*
FOURK    DC    F'4096'                FOUR K
SAVLEN   DC    F'72'                  72 BYTE SAVE AREA
EPAPTR   DC    A(0)                   ENTRY POINT ADDRESS
PIEPTR   DC    A(0)                   PTR TO USER'S PIE
MODLEN   DC    F'0'                   MODULE LENGTH
SAPTR    DC    A(0)                   SAVE AREA POINTER
*
JSMESSG  DC    C' '                   SINGLE SPACE
         DC    CL20'OS OF BRANDON TWEED ' JOB START MESSAGE
         DC    CL4'LA: '              LOAD ADDRESS
JSLAOUT  DC    CL8'XXXXXXXX'          JOB START LOAD ADDRESS
         DC    CL17' PROGRAM LENGTH: ' JOB START MESSAGE
JSPLOUT  DC    CL8'XXXXXXXX'          JOB START PROGRAM LENGTH
         DC    CL8' BYTES. '          JOB START MESSAGE
         DC    CL10'PGM NAME: '       JOB START MESSAGE
JSPNAME  DC    CL8'XXXXXXXX'          PROGRAM NAME 
         DC    CL11' TCB NAME: '      JOB START MESSAGE
JSTCBN   DC    CL8'XXXXXXXX'          TCB NAME GOES HERE
         DC    33C' '                 FILLER FOR JSMESSG
*
*********************************************************************
* MSDA (MASTER SCHEDULER RESIDENT DATA AREA)
*********************************************************************
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) NICE ALIGNMENT
MYMSDA   DC    CL4'MSDA'              IDENT FOR MSDA
LOCMECB  DC    X'7F',C'DIS'           MECB
LOCMAXI  DC    F'1'                   MAX # INITIATORS
LOCCURI  DC    F'0'                   # INITIATORS RUNNING
         DC    XL4'14800'             LOAD ADDRESS NEXT USER PGM
KEY      DC    X'D8'                  KEY 5 FETCH PROTECT ON
         DC    C'D'                   PAD CHARACTER
         ORG   MYMSDA+(MSDAFFLO-MSDA) GO TO LOCATION FOR MSDAFFL0
         DC    D'1,-2,+3,-4'          DEFINE MSDAFFL0-MSDAFFL6
*
** END OF MSDA **
*
*
***************************
* IOB - INPUT/OUTPUT BLOCKS
***************************
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT
IOBREAD  DC    CL4'IOBR'              IOB IDENTIFICATION
         DC    XL2'0000'              FOR XREAD
         DC    X'02'                  '02' = READ
         DC    C'0'                   RESERVED FOR STUFF
         DC    A(BUFFER)              A(BUFFER) TO READ
         DC    H'80'                  LENGTH OF BUFFER TO READ/WRITE
         DC    H'0'                   RESERVED FOR STUFF
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT
IOBWRITE DC    CL4'IOBW'              IOB IDENTIFICATION
         DC    XL2'0000'              FOR XPRINT
         DC    X'01'                  '01' = WRITE
         DC    C'0'                   RESERVED FOR STUFF
         DC    A(JSMESSG)             A(BUFFER) TO WRITE 
         DC    H'133'                 LENGTH OF BUFFER TO READ/WRITE
         DC    H'0'                   RESERVED FOR STUFF
*
*** END OF IOB ***
*
         ORG   FIRST4K+X'20000'       CREATE ADDRESSABLE SPACE
HIGHEST  DC    CL8'HIGHEST'           HIGHEST address
         END   FIRST4K                END OF THE 1ST 4K CSECT
//* Load the loader, use the loader to load itself, then load
//* OBJMODE to test SVC 14
//FT05F001 DD DSN=&&O(SVC8),DISP=(OLD,DELETE)
//         DD DSN=&&OO(SVC8),DISP=(OLD,DELETE)
//         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM4444),DISP=SHR
//         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMODE),DISP=SHR
//         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR
/*