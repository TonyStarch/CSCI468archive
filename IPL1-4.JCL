//Z030199A JOB ,'Brandon Tweed',REGION=2M
/*JOBPARM ROOM=199,L=5
//ASSISTV EXEC PGM=ASSISTV,PARM='P=100,PX=50,R=5000,RX=3000,L=60',
// REGION=512K
//*
//* THE PARMS ARE SUGGESTED FROM PAST EXPERIENCE WITH ASSISTV,
//* BUT SEE THE NOTE BELOW ON HOW THESE PARMS MAY BE SELECTED
//* AND THEIR VALUE(S).
//*
//STEPLIB DD DSN=USER1.ASSIST.LOADLIB,DISP=SHR
//*
//* FOLLOWING ARE ASSISTV SIMULATED DEVICES
//*
//VIRTRDR1 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00C'
//VIRTRDR2 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00D'
//* VIRTPRT1 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00E'
//* VIRTPRT2 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00F'
//*
//* FOLLOWING ARE 'STANDARD' DATA SETS
//*
//FT06F001 DD SYSOUT=* PRINTOUT FROM THE ASSEMBLY, TRACE, ETC.
//SYSPRINT DD SYSOUT=*
//SYSLIB DD DSN=SYS1.MACLIB,DISP=SHR
// DD DSN=SYS2.MACLIB,DISP=SHR
// DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR
//SYSIN DD *
         TITLE 'Brandon Tweed SOS 1-4'
**********************************************************************
* Brandon Tweed
* CSCI 468
* Assignment 1 (IPL steps 1-4)
* Due W2L2
*
* This implements IPL steps 1-4 as described on the assignment sheet.
*
**********************************************************************
         PRINT GEN
*SYSLIB LOADERX,DSECTS,EQUREGS,EXIT,LOUNTR
         DSECTS                       BRING IN DSECTS FOR USE
         EJECT          
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
         ORG   FIRST4K+X'2400'        MOVE TO DISPATCHER LOCATION
DISPATCH DC    X'0119'                NOT USING DISPATCHER YET
         ORG   FIRST4K+X'2800'        MOVE TO LOCATION FOR THE CVT
MYCVT    DC    96X'0'                 SET UP THE CVT
         TITLE 'IPL ROUTINE STEPS(1-4) DOC' 
*
**********************************************************************
* IPLPGM
*
* INPUT:  NONE
*
* OUTPUT: A MESSAGE THAT STATES THE VALUE SAVED FOR CVTMZ00
*
* ENTRY CONDITONS: ??
*
* EXIT CONDITIONS: ??
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
POINTHER LA    8,X'800'(,8)           increment RB b 2K
         B     LOOP                   continue infinite loop
AFTERLOP MVC   NPSWPC+5(3),REALPC+1   put @(PCFLIH) into PC New PSW
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
SOC1     DC    H'0'                   CAUSE A SOC1 (PROGRAM EXCEPTION)   
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
*
         ORG   FIRST4K+X'4000'        GO TO PLACE FOR FLIHs         
EXFLIH   DC    X'0119'                EXTERNAL FLIH
SVCFLIH  DC    X'0119'                SVC FLIH
PCFLIH   DC    X'0119'                PROGRAM CHECK FLIH
MCFLIH   DC    X'0119'                MACHINE CHECK FLIH
IOFLIH   DC    X'0119'                I/O FLIH
HIGHEST  DC    CL8'HIGHEST'           HIGHEST address
         END   FIRST4K                END OF THE 1ST 4K CSECT
/*
//*
//FT05F001 DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM1111),DISP=SHR
//*
//* ABOVE IS ONE 'PARM' CARD THAT IS READ IN BY NIP PRIOR TO THE
//* LOADING OF THE TEST PROGRAM.
//*
// DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD7),DISP=SHR
//*
//* ABOVE IS THE OBJECT MODULE OF THE USER PROGRAM THAT IS TO BE
//* LOADED BY THE USE OF SVC 8.
//*
// DD DSN=SYS1.MACLIB(BCS),DISP=SHR
//*
//* ABOVE IS THE INPUT DATA THAT IS TO BE READ BY USER PROGRAM
//* 'OBJMOD7' USING OBJMOD7-S CALLS TO SVC 0.
//
