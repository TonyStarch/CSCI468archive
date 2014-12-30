//Z030199A JOB ,'Brandon Tweed',REGION=2M
/*JOBPARM ROOM=199,L=5
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
         TITLE 'Brandon Tweed SOS-B'
**********************************************************************
* Brandon Tweed
* CSCI 468 Spring 2005
* SOS-B
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
         ORG   SVCTABLE+8*3           GO TO ENTRY FOR SVC 3
         DC    A(SVC3)                ADDRESS OF SVC 3
         ORG   SVCTABLE+8*8           GO TO ENTRY FOR SVC 8
         DC    A(SVC8)                ADDRESS OF SVC 8
         DC    X'80'                  B'10' indicates type 2 SVC
         ORG   SVCTABLE+8*15          GO TO ENTRY FOR SVC 5
         ORG   ,                      MOVE IT FORWARD
         DC    X'1BFF07FE'            SR 15,15 AND BR 14
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
*****************************
* code for SOS-A
*****************************
*
* Update post code
*
         L     2,CVTMSDAT             R6=@MSDA
         USING MSDA,2                 MSDA Addressability 
         MVC   MSDAMECB(4),MECBINIT   Put "Post" code into MECB
*
* Decrement CURI
*
         L     9,MSDACURI             Get the CURI
         BCTR  9,0                    SUBTRACT ONE
         ST    9,MSDACURI             Store the new CURI
*
*   Get the NIPMS TCB and RB and subtract 1 from RBWCF
*
         L     4,CVTHEAD              GET CVTHEAD 
         LTR   4,4                    SEE IF = ZERO
         BZ    D0119                  IF IT IS, TAKE A DUMP
         L     5,TCBRB                PUT  RB POINTED INTO R5
         LTR   5,5                    CHECK IF NULL
         BZ    D0119                  Bail if bad
         IC    7,RBWCF                Load RBWCF into R7
         BCTR  7,0                    Subtract One
         STC   7,RBWCF                Store RBWCF  
***
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
         DC    CL12' TASK: '          TASK TIME
EJTT     DC    CL8'XXXXXXXX'          PUT TASK TIME HERE
         DC    CL12' SUPER: '         SUPERVISOR TIME
EJST     DC    CL8'XXXXXXXX'          SUPERVISOR TIME HERE
         DC    35C' '                 FILLER
*
UNCH     DC    CL4'UNCH'              UNCH MESSAGE FOR TCB
MECBINIT DC    X'7F',C'DIS'           STUFF TO RESET MECB
*
         ORG   FIRST4K+((*-FIRST4K+31)/32*32)   NICE ALIGNMENT
         DC    CL28'TOTAL DISPATCH COUNT AT LEFT'  DCOUNT MESSG
DCOUNT   DC    F'0'                   START COUNT AT ZERO
*
************************************
* CVT - COMMUNICATION VECTOR TABLE
************************************
*
         ORG   FIRST4K+X'2800'        MOVE TO LOCATION FOR THE CVT
MYCVT    DC    96X'0'                 SET UP THE CVT
         ORG   MYCVT                  GO BACK AND BEGIN DEFINING FIELDS
         DC    A(TCBWORDS)            CVTTCBP
         DC    A(SVCTABLE)            CVTSVCTA
         ORG   MYCVT+(CVTC100H-CVT)   LOCATION FOR CVTC100H
         DC    A(CB100HDR)            HEADER ADDRESS CB100s (CVT100H)
         DC    A(DISPATCH)            (CVT0DS) ADDRESS OF DISPATCHER
         ORG   MYCVT+(CVTMSECB-CVT)   LOCATION FOR CVTMSECB
         DC    A(LOCMECB)             ADDRESS FOR MSECB
         ORG   MYCVT+(CVTMSDAT-CVT)   LOCATION FOR CVTMSDAT
         DC    A(MYMSDA)              ADDRESS FOR MYMSDA
         SVC   3                      SVC 3
         BCR   15,14                  CVTBRET
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
*
         ORG   FIRST4K+X'4000'        GO TO PLACE FOR FLIHs         
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
NONTYP1  DS    0H                     CODE FOR NON-TYPE1 SVC
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
         STM   3,6,TCBGRS+4*3         Save regs 3,4,5,6 in TCBGRS
         ST    14,TCBGRS+4*14         and R14
*
*   Create a PSW in the SVRB with instruction address taken from
*   R6, supervisor state, Key 0, interrupts enabled
*
         STCM  6,7,SVRBPSW+5          Save a(SVC routine) into PSW        
*        MVC   SVRBPSW+5(3),TCBGRS+4*6+1 Instruction address from 6
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
PCFLIH   DC    X'0119'                PROGRAM CHECK FLIH
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
         LA    15,4                   Set Return Code
         XREAD 0(0,7),(8)             READ STUFF INTO THE BUFFER
*
* CHECK FOR END OF FILE
*
         BNZR  14                     IF EOF, EXIT WITH RC=4
*
* IF NOT EOF, CHECK BUFFER FOR NINES
*
         CLC   0(8,7),ALLNINES        SEE IF BUFFER CONTAINS NINES
         BER   14                     IF IT DOES, EXIT WITH RC=4
*
* OTHERWISE (NOT EOF OR ALL 9'S) SET A 0 RC AND RETURN
*
         XR    15,15                  SET RC=0 IN 15
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
SVC1     TM    0(1),X'40'             Check second bit of MECB
         BCR   1,14                   If CC=3 (Second bit=1), return
         USING SVC1,6                 Establish SVC 1 Addressability
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
*
*** END OF SVC 1 ****
*
        ORG    FIRST4K+X'7000'        GO TO SVC 3
SVC3    DS     0H                     ADDRESS OF SVC 3
        EXIT
        ORG    FIRST4K+X'7300'        GO TO SVC 8
SVC8    DS     0H                     ADDRESS OF SVC 8
        LOADER
*
****************************************
* CONTROL BLOCKS OBTAINED DYNAMICALLY 
****************************************
*
         ORG   FIRST4K+X'110E0'       MOVE TO LOCATION FOR CB100s
CB100LTH EQU   X'100'                 LENGTH OF THE CONTROL BLOCKS
CB100#   EQU   15                     NUMBER OF CB100 BLOCKS
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
         LA    8,MYMSDA               GET ADDDRESS OF MSDA
         USING MSDA,8                 ADDR FOR MSDA
         L     3,76                   GET A(CVT)
         USING CVT,3                  ADDR FOR CVT
MSWAITLP LA    1,MSDAMECB             GET A(MECB)
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
         DROP  3,8,12                 DONE WITH CVT,MSDA,MSNIP    
*
********************************************************************
* MS/NIP WORKING STORAGE
********************************************************************
*
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
         DC    XL4'15000'             LOAD ADDRESS NEXT USER PGM
KEY      DC    X'B8'                  KEY 5 FETCH PROTECT ON
         DC    C'B'                   PAD CHARACTER
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
         ORG FIRST4K+X'20000'         CREATE ADDRESSABLE SPACE
HIGHEST  DC    CL8'HIGHEST'           HIGHEST address
         END   FIRST4K                END OF THE 1ST 4K CSECT
/*
//* Runs 2 programs, using 2 parm cards
//* 
//FT05F001 DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM1111),DISP=SHR
// DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD7Y),DISP=SHR
// DD DSN=SYS1.MACLIB(FM),DISP=SHR
// DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR
// DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM2222),DISP=SHR
// DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD7),DISP=SHR
// DD DSN=SYS1.MACLIB(DSG),DISP=SHR
// DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR
//
