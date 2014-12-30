1                        J E S 2  J O B  L O G  --  S Y S T E M  P R O D  --  N O D E  N I U             
0 
 14.41.02 JOB04026 ---- THURSDAY,  20 JAN 2005 ----
 14.41.02 JOB04026  $HASPU01 JOB PARMS - TIME=(0,5),LINES=5,CARDS=100,TAPES=0,ROOM=199
 14.41.02 JOB04026  $HASP373 Z030199A STARTED - INIT 14   - CLASS M - SYS PROD
 14.41.02 JOB04026  ACF9CCCD USERID Z030199  IS ASSIGNED TO THIS JOB - Z030199A
 14.41.02 JOB04026  IEF403I Z030199A - STARTED - TIME=14.41.02
 14.41.03 JOB04026  AMS000I: STEP END  Z030199A.ASSISTV   RC=  0000    CPU= 00:00:00.02    PGM=ASSISTV
 14.41.03 JOB04026  IEF404I Z030199A - ENDED - TIME=14.41.03
 14.41.03 JOB04026  AMS000I: JOB  END  Z030199A  Brandon Twee          CPU= 00:00:00.02
 14.41.03 JOB04026  $HASP395 Z030199A ENDED
0------ JES2 JOB STATISTICS ------                                                                                                   
-  20 JAN 2005 JOB EXECUTION DATE                                                                                                    
-          252 CARDS READ                                                                                                            
-          656 SYSOUT PRINT RECORDS                                                                                                  
-            0 SYSOUT PUNCH RECORDS                                                                                                  
-           54 SYSOUT SPOOL KBYTES                                                                                                   
-         0.00 MINUTES EXECUTION TIME                                                                                                
 !! END OF JES SPOOL FILE !!
        1 //Z030199A JOB ,'Brandon Tweed',REGION=2M,                              JOB04026
          //             MSGCLASS=X                                                       
          /*JOBPARM ROOM=199,L=5                                                          
          //* $ACFJ219 ACF2 ACTIVE NIU                                                ACF2
        2 //ASSISTV EXEC PGM=ASSISTV,PARM='P=100,PX=50,R=5000,RX=3000,L=60',              
          // REGION=512K                                                                  
          //*                                                                             
          //* THE PARMS ARE SUGGESTED FROM PAST EXPERIENCE WITH ASSISTV,                  
          //* BUT SEE THE NOTE BELOW ON HOW THESE PARMS MAY BE SELECTED                   
          //* AND THEIR VALUE(S).                                                         
          //*                                                                             
        3 //STEPLIB DD DSN=USER1.ASSIST.LOADLIB,DISP=SHR                                  
          //*                                                                             
          //* FOLLOWING ARE ASSISTV SIMULATED DEVICES                                     
          //*                                                                             
        4 //VIRTRDR1 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00C'              
        5 //VIRTRDR2 DD DUMMY THIS WOULD BE INPUT ( DD * ) FOR READER X'00D'              
          //* VIRTPRT1 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00E'                 
          //* VIRTPRT2 DD SYSOUT=*,DCB=RECFM=FM OUTPUT FOR PRINTER X'00F'                 
          //*                                                                             
          //* FOLLOWING ARE 'STANDARD' DATA SETS                                          
          //*                                                                             
        6 //FT06F001 DD SYSOUT=* PRINTOUT FROM THE ASSEMBLY, TRACE, ETC.                  
        7 //SYSPRINT DD SYSOUT=*                                                          
        8 //SYSLIB DD DSN=SYS1.MACLIB,DISP=SHR                                            
        9 // DD DSN=SYS2.MACLIB,DISP=SHR                                                  
       10 // DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR                                      
       11 //SYSIN DD *                                                                    
          //*                                                                             
       12 //FT05F001 DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM1111),DISP=SHR                    
          //*                                                                             
          //* ABOVE IS ONE 'PARM' CARD THAT IS READ IN BY NIP PRIOR TO THE                
          //* LOADING OF THE TEST PROGRAM.                                                
          //*                                                                             
       13 // DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD7),DISP=SHR                             
          //*                                                                             
          //* ABOVE IS THE OBJECT MODULE OF THE USER PROGRAM THAT IS TO BE                
          //* LOADED BY THE USE OF SVC 8.                                                 
          //*                                                                             
       14 // DD DSN=SYS1.MACLIB(BCS),DISP=SHR                                             
          //*                                                                             
          //* ABOVE IS THE INPUT DATA THAT IS TO BE READ BY USER PROGRAM                  
          //* 'OBJMOD7' USING OBJMOD7-S CALLS TO SVC 0.                                   
       15 //                                                                              
 !! END OF JES SPOOL FILE !!
 IEF236I ALLOC. FOR Z030199A ASSISTV
 IEF237I 050E ALLOCATED TO STEPLIB
 IEF237I DMY  ALLOCATED TO VIRTRDR1
 IEF237I DMY  ALLOCATED TO VIRTRDR2
 IEF237I JES2 ALLOCATED TO FT06F001
 IEF237I JES2 ALLOCATED TO SYSPRINT
 IEF237I 0502 ALLOCATED TO SYSLIB
 IEF237I 0517 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I JES2 ALLOCATED TO SYSIN
 IEF237I 0512 ALLOCATED TO FT05F001
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0502 ALLOCATED TO 
 IEF142I Z030199A ASSISTV - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   USER1.ASSIST.LOADLIB                         KEPT          
 IEF285I   VOL SER NOS= ACA302.                            
 IEF285I   Z030199.Z030199A.JOB04026.D0000102.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB04026.D0000103.?         SYSOUT        
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   SYS2.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYS304.                            
 IEF285I   T90RPR1.CS468PUB.MACLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   Z030199.Z030199A.JOB04026.D0000101.?         SYSIN         
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     ASSISTV     START TIME  14:41:02.77   VIRT SYS  USED     248K   PAGE INS              0  STEP CPU      00:00:00.02 *
 * PGM NAME      ASSISTV     STOP  TIME 14:41:03.14    VIRT CORE USED     600K   PAGE OUTS             0  JOB  CPU      00:00:00.02 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:00.37    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.00 *
 * PERF. GROUP         0     SERV UNITS         163    TRANS ACT TIME  00:00:00.13                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS             120     SRB UNITS               9     I/O UNITS              34        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  STEPLIB       50E         13  SYSLIB        502          0  SYSLIB   + 1  517          2  SYSLIB   + 2  512          6          *
 *  FT05F001      512          0  FT05F001 + 1  512          0  FT05F001 + 2  502          0                                        *
 *                                                                                                                                  *
 * EXCP TOTAL              21  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/ASSISTV /START 2005020.1441
 IEF374I STEP/ASSISTV /STOP  2005020.1441 CPU    0MIN 00.02SEC SRB    0MIN 00.00SEC VIRT   600K SYS   248K EXT      32K SYS    9308K
 ************************************************************************************************************************************
 *                                                  JOB TERMINATION STATISTICS                                                      *
 *                                                                                                                                  *
 *  JOB NAME    Z030199A  JOB04026                              CPU TIME  00:00:00.02            SRB TIME            00:00:00.00    *
 *                                                                                                                                  *
 *  PROGRAMMER  Brandon Tweed                                   INIT DATE 01/20/05   05.020      INITIATION TIME     14:41:02.77    *
 *                                                                                                                                  *
 *  SYSTEM ID   O2B4                                            TERM DATE 01/20/05   05.020      TERMINATION TIME    14:41:03.15    *
 *                                                                                                                                  *
 *  CLASS       M         PERF. GROUP      0                    SERV UNIT        163             ELAPSED TIME        00:00:00.38    *
 *                                                                                                                                  *
 *  MAIN STORAGE UNITS           0     CPU UNITS             120     SRB UNITS               9     I/O UNITS              34        *
 *                                                                                                                                  *
 *  JOB LOG Z030199A 05020 14:41:02.67                          MVS REL   SP6.1.0                                                   *
 *                                                                                                                                  *
 *  ACCTG DATA 0135040675,Z03    0199,T,Z03    ,TWEED BRANDON DAVID                              COMPLETION STATUS   C0000          *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF375I  JOB/Z030199A/START 2005020.1441
 IEF376I  JOB/Z030199A/STOP  2005020.1441 CPU    0MIN 00.02SEC SRB    0MIN 00.00SEC
 !! END OF JES SPOOL FILE !!
1***  ASSIST V2.0-05/15/82  INS=SDFP7/X=BGHO, CHECK=T(1-1/X1-1)R(2-50/X1-25K), OPTS=D(1/6144)M(F)P(40-100/X20-25)VX FROM PENN ST*NIU 
 P=100,PX=50,R=5000,RX=3000,L=60                                                                                                     
0       Brandon Tweed SOS 1-4                                                                                   PAGE    1            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                       2 **********************************************************************                      
                                       3 * Brandon Tweed                                                                             
                                       4 * CSCI 468                                                                                  
                                       5 * Assignment 1 (IPL steps 1-4)                                                              
                                       6 * Due W2L2                                                                                  
                                       7 *                                                                                           
                                       8 **********************************************************************                      
                                      10 *SYSLIB LOADERX,DSECTS,EQUREGS,EXIT,LOUNTR                                                  
                                     288          DSECTS                       BRING IN DSECTS FOR USE                               
                                     289+*CSCI 468  SOS V6.125 01/21/2000  DSECTS MACRO   PAGE 1 OF 3                                
                                     290+*  CSCI 468  SOS  =====> DSECT-S <==== 12TH VERSION (V6.12)=========                        
                                     291+*     MOD-S  RPR-9/21/87, 9/22/87, 2/14/89, 2/9/90, 4/4/90, 4/20/90                         
                                     292+*                11/9/90=V6.9, 4/7/94=V6.10, 11/06/96=V6.11                                 
                                     293+*                09/24/99=V6.12 09/13/01=V6.13                                              
 000000                              294+IOB      DSECT                                                                              
                                     295+* IOB MUST BE FULLWORD ALIGNED, PREFERABLY 32*N ALIGNED        V6.11                        
 000000                              296+IOBIDENT DS    CL4'IOB ' IOB IS IDENT/DOC.  LAST BYTE RESERVED V6.11                        
 000003                              297+IOBRESV1 EQU   IOBIDENT+3  4TH BYTE = RESERVED (NOT BLANK!)    V6.11                        
 000004                              298+IOBDEVAD DS   XL2'0000' => XPRNT/XREAD. X'000N' => CCWS - DEVICE 'N'                        
 000006                              299+IOBOPCDE DS    X'02' = READ   X'01' = WRITE                    V6.11                        
 000007                              300+IOBRESV2 DS    C            RESERVED                           V6.11                        
 000008                              301+IOBUFADD DS    A(0) ADDRESS BUFFER TO READ/WRITE IN RIGHT 3    V6.11                        
 00000C                              302+IOBUFLEN DS    H'0' LENGTH OF BUFFER TO READ/WRITE             V6.11                        
 00000E                              303+IOBRESV3 DS    H            RESERVED                           V6.11                        
                                     304+* ONLY 16 BYTES (FIRST 4 FULL WORDS) USED AT PRESENT           V6.12                        
 000010                              305+IOBACHPG DS    A(0) ADDRESS OF CHANNEL PROGRAM                 V6.11                        
 000014                              306+IOBAECB  DS    A(0) ADDRESS OF ECB                             V6.11                        
 000018                              307+IOBCSW   DS    2F   CHANNEL STATUS WORD                        V6.11                        
                                     308+*IOBADCB  DS    A(0) ADDRESS OF DCB NOT PRESENTLY USED         V6.11                        
 000020                              309+IOBRESV4 DS    4A(0)        RESERVED                           V6.11                        
 000030                              310+IOBLNGTH EQU   *-IOB     LENGTH OF THE IOB  (X'30')            V6.11                        
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              312+RQE      DSECT                                                                              
 000000                              313+RQEIDENT DS    CL4'RQE ' DOCUMENTATION                                                      
 000004                              314+RQEIOB   DS    A(0) ADDRESS OF IOB THAT GENERATED THIS RQE                                  
 000008                              315+RQEUCB   DS    A(0)      ADD. OF UCB WHEN IN USE.                                           
 00000C                              316+RQETCB   DS    A(0)      ADD. OF USERS TCB                                                  
 000010                              317+RQERB    DS    A(0)      ADD. OF RB IN TCB ISSUING I/O REQUEST                              
 000014                              318+RQENRQE  DS    A(0) ADD NEXT RQE IN UCB WAIT QUE. / 0 IF THIS=LAST                          
 000018                              319+RQEIOECB DS    A(0)      ECB FOR WAIT/POST OF THIS RQE       V6.10                          
 00001C                              320+         DS    A(0)      RESERVED                            V6.10                          
 000020                              321+RQELNTH  EQU   *-RQE     LENGTH OF RQE  (X'20')                                             
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              323+CVT      DSECT                                                                              
 000000                              324+CVTTCBP  DS    A (IEATCBP)  POINTER TO 'TCB WORDS'                                          
 000004                              325+CVTSVCTA DS    A (SVCTABLE) POINTER TO THE SVCTABLE                                         
 000008                              326+CVTHEAD  DS    A (0) ADDRESS OF FIRST TCB IN TCB CHAIN                                      
 00000C                              327+CVTUCBS  DS    A (0) ADDRESS OF FIRST UCB IN UCB CHAIN                                      
 000010                              328+         DS    A (0)    RESERVED (WAS CVTRQEHD)              V6.10                          
 000014                              329+CVTLEVLF DS    A (LEVELFLG)  FOR V6.4 AND FUTURE 'LEVEL'    V6.10                           
1       Brandon Tweed SOS 1-4                                                                                   PAGE    2            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000018                              330+CVTC100H DS    A (CB100HDR) ADDRESS OF THE CB-HEADER         V6.10                          
 00001C                              331+CVT0DS   DS    A (DISPATCH) ADDRESS OF THE DISPATCHER                                       
 000020                              332+CVTBGNIO DS    A (BEGINIO) ADD. OF THE BEGIN I/O ROUTINE IN IOSUP.                          
 000024                              333+CVTCHAP  DS    A (CHAP)   ADD. OF THE CHAP ROUTINE                                          
 000028                              334+CVTSUB1  DS    A (SUB1) ADD. OF SUBROUTINE GROUP 1 IN 'LPA' V6.10                           
 00002C                              335+CVTSUB2  DS    A (SUB2) ADD. OF SUBROUTINE GROUP 2 IN 'LPA' V6.10                           
 000030                              336+CVTBRABN DS    A (BRABEND) ADD. BRANCH-ABEND ROUTINE   V6.5                                 
 000034                              337+CVTTYP1F DS    A (TYP1FLAG)                                                                 
 000038                              338+CVTRQENQ DS    A (RQEENQ)  ADD. OF ROUT. TO ENQ RQE-S ON UCB-S                              
 00003C                              339+CVTPARHD DS    A (0) A OF PARTITION-S 'HEADER'               V6.9                           
 000040                              340+CVTMSECB DS    A (0) A OF MASTER SCHEDULER ECB               V6.9                           
 000044                              341+CVTMSINI DS    A (0) A OF MSTR. SCH. INITILIZATION ROUT.     V6.9                           
 000048                              342+CVTMSWLO DS    A (0) A OF MSTR. SCH. WAIT LOOP (SVC 1)       V6.9                           
 00004C                              343+CVTMSDAT DS    A (0) A OF MSTR. SCH. DATA AREA               V6.9                           
 000050 0A03                         344+CVTEXIT  SVC   3                                                                            
 000052 07FE                         345+CVTBRET  BCR   15,14                                                                        
 000054                              346+CVTSSVRB DS    A (0) ADDR. OF ENTRY IN SVC-FLIH TO SCH. SVRB   V6.11                        
                                     347+* CVTSFR14 REPLACED BY CVTSSVRB .......................  IN    V6.11                        
                                     348+*CVTSFR14 DS A (0) ADDR. OF R14 AFTER BALR R14,R6 IN SVCFLIH V6.83                          
 000058                              349+CVTMZ00  DS    A (0) ADD. OF HIGHEST 'MACHINE' BYTE. RPR-9/22/87                            
 00005C                              350+CVTIDENT DS    CL4'CVT ' DOCUMENTATION                                                      
 000060                              351+CVTLNTH  EQU   *-CVT     LENGTH OF THE CVT  (X'60')                                         
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              353+IEATCBP  DSECT                                                                              
 000000                              354+PSATNEW  DS    A (0) ADDRESS OF NEXT TCB TO BE DISPATCHED                                   
 000004                              355+PSATOLD  DS    A (TCB1) ADDRESS OF CURRENTLY DISPATCHED TCB                                 
 000008                              356+PSAANEW  DS    A (0)   RESERVED                                                             
 00000C                              357+PSAAOLD  DS    A (0)   RESERVED                                                             
 000010                              358+IEATLNTH EQU   *-IEATCBP LENGTH OF THE TCB-WORDS  (X'10')                                   
                                     359+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 1 OF 3                                 
                                     360+*CSCI 468  SOS V6.10 4/7/94  DSECTS MACRO   PAGE 2 OF 3                                     
 000000                              361+PQESECT  DSECT                                                                              
 000000                              362+PQEFFBQE DS    A (0) PTR TO FIRST FBQE OR IF NONE TO PQE                                    
 000004                              363+PQEBFBQE DS    A (0) PTR TO LAST FBQE OR IF NONE, TO PQE                                    
 000008                              364+PQEFPQE  DS    A (0) ADDR. NEXT PQE OR ZERO                                                 
 00000C                              365+PQEBPQE  DS    A (0) ADDR. PREVIOUS PQE OR ZERO                                             
 000010                              366+PQETCB   DS    A (0) ADDR. TCB FOR JOB STEP TO WHICH SPACE BELONGS                          
 000014                              367+PQESIZE  DS    A (0) SIZE OF REGION DESCRIBED BY THIS PQE                                   
 000018                              368+PQEREGN  DS    A (0) ADD. FIRST BYTE OF REGION DESC. BY THIS PQE                            
 00001C                              369+         DS    A (0) RESERVED                                                               
 000020                              370+PQELNTH  EQU   *-PQESECT LENGTH OF THE PQE  (X'20')                                         
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              372+TCB      DSECT                                                                              
 000000                              373+TCBRB    DS    A(0)     ADD OF RB (OR ZERO IF NONE)                                         
 000004                              374+TCBPIE   DS    A (0) ADD. OF PIE (MVT) OR SCA (MVS) RPR-9/22/87                             
 000008                              375+TCBTNAME DS    CL8'TCB NAME' ('DEB' & 'TIOT' HERE IN REAL)  V6.83                           
 000010                              376+TCBPNAME DS    CL8'PGM NAME' NAME OF PROGRAM BEING EXECUTED  V6.9                           
                                     377+*TCBNAME EQU TCBTNAME PRIOR TO REMOVING 'TCBNAME'  V6.83  *IN V6.10                         
 000018                              378+TCBTSSIO DS    A(0)  TIME (FROM X'50') SIO LAST STARTED FOR THIS TCB                        
 00001C                              379+TCBPFK   DS    X'CF'     C = KEY OF THIS TCB, F = B'1111'B    V6.9                          
 00001D                              380+TCBFLGS  DS    5X'00' FLGS 4+5: X'0000', DISPATCH.: X'FFFF' NOT-SO                          
 000022                              381+TCBLMP   DS    X'00' LIMIT PRIORITY OF THIS TCB                                             
 000023                              382+TCBDSP   DS    X'00' DISPATCHING PRIORITY OF THIS TCB.                                      
1       Brandon Tweed SOS 1-4                                                                                   PAGE    3            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000024                              383+TCBTWAIT DS    A(0)  SUM. I/O WAIT TIME ACCUM. -- THIS TCB   V6.10                          
                                     384+*                    SIO=0 TO I/O INTERRUPT                  V6.10                          
 000028                              385+TCBUNCH  DS    A(0) LOCATION FOR C'UNCH' INDICATOR          V6.101                          
 00002C                              386+TCBIDENT DS    CL4'TCB ' DOCUMENTATION                                                      
 000030                              387+TCBGRS   DS    16F'-5' SAVE AREA FOR REGS.                                                  
 000070                              388+         DS    A(0) RESERVED                                 V6.9                           
 000074                              389+TCBTCB   DS    A(0)   ADD OF NEXT TCB IN CHAIN (OR ZERO IF END)                             
 000078                              390+TCBDMSCA DS    A(0) LOCATION USED FOR DUMMY SCA              V6.9                           
 00007C                              391+         DS    A(0) RESERVED                                 V6.9                           
 000080                              392+TCBAPIE  DS    A(0) ADDR. OF PIE AREA IN TASKS REGION        V6.9                           
 000084                              393+TCBAPARM DS    A(0) ADDR. OF 'PARM' AREA IN TASKS REGION     V6.9                           
 000088                              394+TCBFSA   DS    A(0)  ADD OF FIRST SAVE AREA (18F) FOR USE OF PROG.                          
 00008C                              395+TCBAWORK DS    A(0)  ADD OF WORK AREA IN THIS TCB-S 'REGION'                                
 000090                              396+TCBRSTAR DS    A(0)  ADDRESS OF START OF REGION USED BY THIS TCB                            
 000094                              397+TCBRSIZE DS    A(0)  SIZE (BYTES) OF REGION USED BY THIS TCB                                
 000098                              398+TCBDPQE  DS    A(0) POINTER TO THE DUMMY PQE                 V6.83                          
 00009C                              399+TCBMSS   DS    A(0) POINTER TO THE QUEUE OF SPQE-S           V6.83                          
 0000A0                              400+TCBTDISP DS    A(0)  TIME (FROM X'50') THIS TCB LAST DISPAT.  V6.9                          
 0000A4                              401+TCBTWALS DS    A(0) START TIMER VALUE 'WALL CLOCK'            V6.9                          
                                     402+*TCBTWASL EQU TCBTWALS EQUATE TO HANDLE RPR TYPEO V6.9    *IN V6.10                         
 0000A8                              403+TCBTWALA DS    A(0) ACCUMULATED 'WALL CLOCK' TIME             V6.9                          
 0000AC                              404+TCBTCPUP DS    A(0) ACCUM. 'TASK' CPU TIME (PROBLEM STATE)    V6.9                          
                                     405+*TCBTCPU EQU TCBTCPUP OLD 'TCBTCPU' REMOVED IN FUT.V6.9   *IN V6.10                         
 0000B0                              406+TCBTCPUS DS    A(0) ACCUM. 'TASK' CPU TIME (SUPERVISOR ST.)   V6.9                          
 0000B4                              407+TCBTSYS  DS    A(0) ACCUM. 'SYSTEM' CPU TIME                  V6.9                          
 0000B8                              408+TCBTATQE DS    A(0) ADDRESS OF TIMER QUEUE ELEMENT            V6.9                          
 0000BC                              409+TCBTSLIC DS    A(0) ADDRESS OF TIME SLICE PARAMETERS          V6.9                          
 0000C0                              410+TCBIOCNT DS    A(0) I/O COUNTS ON C-D-E-F (1 BYTE EACH)      V6.10                          
 0000C4                              411+TCBTMRA1 DS    A(0) 'TIME' RATIO NUMBER 1                    V6.10                          
 0000C8                              412+TCBTMRA2 DS    A(0) 'TIME' RATIO NUMBER 2                    V6.10                          
 0000CC                              413+         DS    4A(0) RESERVED                                V6.10                          
 0000DC                              414+TCBBACK  DS    A(0) BACKWARD (REV. OF TCBTCB) TCB CHA. POINT. V6.9                          
 0000E0                              415+TCBFRS   DS    4D   STORAGE FOR FOUR FLOATING POINT REGS.    V6.83                          
 000100                              416+TCBLNTH  EQU   *-TCB     LENGTH OF THE TCB  (X'100')         V6.83                          
                                     417+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 2 OF 3                                 
                                     418+*CSCI 468  SOS V6.10 4/7/94  DSECTS MACRO   PAGE 3 OF 3                                     
 000000                              419+RB       DSECT                                                                              
 000000                              420+RBTYPE   DS    CL4'SVRB' DOCUMENTATION: SVRB OR PRB OR OTHER                                
 000004                              421+RBTCB    DS    A         ADD. OF THE TCB FOR THIS TASK                                      
 000008                              422+RBFLGS03 DS    4X        3X RESERVED                                                        
 00000B                              423+RBFLGS3  EQU   RBFLGS03+3   1... .... BIT=1 INDICATES RBLINK IS TCB                         
 00000C                              424+RBCDE    DS    A         RESERVED                                                           
 00000C                              425+RBUNCH   EQU   RBCDE     LOCATION FOR C'UNCH' INDICATOR IN RB  V6.12                        
 000010                              426+RBOPSW   DS    XL8       RESUME PSW FOR THIS TASK                                           
 000018                              427+RBPGNQ   DS    A         RESERVED                                                           
 00001C                              428+RBLINK   DS    A(0) POINTER TO PREV. RB ON THE CHAIN (LAST 3 BYTES)                         
                                     429+*                        OR TCB WHEN THIS IS LAST RB ON THE CHAIN.                          
                                     430+*                        (RBFLGS3 -- BIT 0, SET TO 1 INDICATES TCB)                         
 00001C                              431+RBWCF    EQU   RBLINK    X'00'  COUNT OF EVENTS WAITED FOR                                  
 000020                              432+RBGRSAVE DS    16F       REGISTERS 0-15 WHEN REQUEST ENTERED                                
 000060                              433+RBFRSAVE DS    4D        SAVE AREA FOR FLOATING PT. REGISTERS                               
 000080                              434+RBLNTH   EQU   *-RB      LENGTH OF A REQUEST BLOCK  (X'80')                                 
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              436+UCB      DSECT                                                                              
 000000                              437+UCBIDENT DS    CL3'UCB',X'FF' DOCUMENTATION                                                 
1       Brandon Tweed SOS 1-4                                                                                   PAGE    4            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000004                              438+UCBCHAN  DS    X'0000' DEVICE ADDRESS IN HEX                                                
 000006                              439+UCBFLA   DS    X'00' = FREE, X'FF' = BUSY                                                   
 000007                              440+UCBFLB   DS    X'00'   RESERVED                                                             
 000008                              441+UCBUCB   DS    A(0)    ADD. NEXT UCB ON CHAIN OR 0 IF THIS = LAST.                          
 00000C                              442+UCBNAME  DS    CL4'NAME' DEVICE ADDRESS IN EBCDIC                                           
 000010                              443+UCBCURQE DS    A(0)     ADDRESS OF RQE CURRENTLY BEING PROCESSED                            
 000014                              444+UCBWARQE DS    A(0) ADD. FIRST RQE IN WAIT QUEUE, / 0 IF NONE THERE                         
 000018                              445+UCBIOSTR DS    A(0)   ADDRESS OF DEVICE'S I/O START ROUTINE                                 
 00001C                              446+         DS    A(0)   RESERVED                                                              
 000020                              447+UCBLNTH  EQU   *-UCBIDENT LENGTH OF UCB  (X'20')                                            
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              449+MSDA     DSECT                                                                              
 000000 D4E2C4C1                     450+MSDAID   DC    C'MSDA' EBCDIC IDENTIFIER                      V6.13                         
 000004 00000000                     451+MSDAMECB DC    A(0)    MAS. SCH. ECB (ADD. IN CVTMSECB)       V6.13                         
 000008 00000000                     452+MSDAMAXI DC    A(0)    MAX. NUMBER OF INITIATORS TO RUN       V6.13                         
 00000C 00000000                     453+MSDACURI DC    A(0)    CURRENT NUM. OF INITIATORS ACTIVE      V6.13                         
 000010 00000000                     454+MSDAFLAD DC    A(0)    LOAD ADDRESS FOR NEXT USER PROGRAM     V6.13                         
 000014 00                           455+MSDAFKEY DC    X'00'   KEY+FETCH FOR SSK+PSW: NEXT USER PGM.  V6.13                         
 000015 00                           456+MSDAFPAD DC    X'00'   PAD CHAR. FOR NEXT 4K USER REGION      V6.13                         
 000016 0000                         457+         DC    H'0'    RESERVED                               V6.13                         
 000018 0000000000000000             458+         DC    2A(0)   RESERVED                               V6.13                         
 000020 0000000000000000             459+MSDAFFLO DC    D'0'    1ST FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000028 0000000000000000             460+MSDAFFL2 DC    D'0'    2ND FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000030 0000000000000000             461+MSDAFFL4 DC    D'0'    3RD FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000038 0000000000000000             462+MSDAFFL6 DC    D'0'    4TH FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000040                              463+MSDALNTH EQU   *-MSDAID LEN. OF M-SCH. DATA AREA (X'40')      V6.13                         
                                     464+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 3 OF 3                                 
1       Brandon Tweed SOS 1-4                                                                                   PAGE    5            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     466 *                                                                                           
                                     467 **********************************************************************                      
                                     468 * START OF FIRST 4K OF STORAGE                                                              
                                     469 **********************************************************************                      
                                     470 *                                                                                           
 000000                              471 FIRST4K  CSECT                        START OF FIRST4K                                      
 000000                              472          USING FIRST4K,0              ESTABLISH FIRST4K ADDR                                
 000000 0119011901190119             473          DC    2048X'0119'            FILL 1ST WITH 'QUICK STOP'                            
 000000                              474          ORG   FIRST4K                GO BACK TO START OF 1ST 4K                            
 000000 010401190F003000             475          DC    X'010401190F',AL3(IPLPGM) DEFINE IPLPSW                                      
 000010                              476          ORG   FIRST4K+X'10'          GO TO LOCATION FOR @(CVT)                             
 000010 00002800                     477 CVT#1    DC    A(MYCVT)               ADDRESS OF MYCVT                                      
                                     478 *                                                                                           
                                     479 *********************************************                                               
                                     480 * OLD PSWs                                                                                  
                                     481 *********************************************                                               
                                     482 *                                                                                           
 000018                              483          ORG   FIRST4K+X'18'          GO TO LOCATION FOR OLDPSWs                            
 000018 0000000000000000             484 OPSWEX   DC    D'0'                   OLD EXT INT PSW                                       
 000020 0000000000000000             485 OPSWSVC  DC    D'0'                   OLD SVC PSW                                           
 000028 0000000000000000             486 OPSWPC   DC    D'0'                   OLD PC PSW                                            
 000030 0000000000000000             487 OPSWMC   DC    D'0'                   OLD MC PSW                                            
 000038 0000000000000000             488 OPSWIO   DC    D'0'                   OLD I/O PSW                                           
                                     489 *                                                                                           
 00004C                              490          ORG   FIRST4K+X'4C'          GO TO LOCATION FOR CVT#2                              
 00004C 00002800                     491 CVT#2    DC    A(MYCVT)               ADDRESS OF MYCVT                                      
 000050 00000000                     492 CLOCK    DC    F'0'                   ASSEMBLE CLOCK AS VALUE ZERO                          
                                     493 *                                                                                           
                                     494 ********************************************                                                
                                     495 * NEW PSWs                                                                                  
                                     496 ********************************************                                                
                                     497 *                                                                                           
 000058                              498          ORG   FIRST4K+X'58'               LOCATION FOR NEW PSWS                            
 000058 010601190F004000             499 NPSWEX   DC    X'010601190F',AL3(EXFLIH)   NEW PSW EXTERNAL                                 
 000060 010401190F004002             500 NPSWSVC  DC    X'010401190F',AL3(SVCFLIH)  NEW PSW SVC                                      
 000068 010401190F003020             501 NPSWPC   DC    X'010401190F',AL3(AFTERLOP) NEW PSW PC                                       
 000070 010401190F004006             502 NPSWMC   DC    X'010401190F',AL3(MCFLIH)   NEW PSW MACHINE CHECK                            
 000078 010401190F004008             503 NPSWIO   DC    X'010401190F',AL3(IOFLIH)   NEW PSW I/O                                      
                                     504 *                                                                                           
 0000A0                              505          ORG   FIRST4K+X'A0'          LOCATION FOR LOWPSW                                   
 0000A0 0000000000000000             506 LOWPSW   DC    D'0'                   FILL LOWPSW WITH ZERO                                 
                                     507 *                                                                                           
 0000B0                              508          ORG   FIRST4K+X'B0'          LOCATION FOR LOWTIME                                  
 0000B0 00000000                     509 LOWTIME  DC    F'0'                   FILL LOWTIME WITH ZERO                                
                                     510 *                                                                                           
 0000BC                              511          ORG   FIRST4K+X'BC'          MOVE TO LOCATION FOR LEVELABN                         
 0000BC 0119                         512 LEVELABN DC    X'0119'                SET VALUE FOR LEVELABN                                
 0000BE E7                           513 LEVELFLG DC    C'X'                   LATER SET TO C'S' IN IPL                              
 0000BF E7                           514 TYP1FLAG DC    C'X'                   LATER SET TO C'0' IN IPL                              
                                     515 *                                                                                           
                                     516 *****************************************                                                   
                                     517 *  SAVE AREAS FOR INTERRUPTS                                                                
                                     518 *****************************************                                                   
                                     519 *                                                                                           
 0000C0 C5E74040C5E74040             520 EXSAVE   DC    16CL4'EX'              SAVE AREA FOR EXTERNAL INTS                           
 000100 E2E54040E2E54040             521 SVCSAVE  DC    16CL4'SV'              SAVE AREA FOR SVC INTERRUPTS                          
 000140 D7C34040D7C34040             522 PCSAVE   DC    16CL4'PC'              SAVE AREA FOR PC INT.                                 
1       Brandon Tweed SOS 1-4                                                                                   PAGE    6            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000180 C9D64040C9D64040             523 IOSAVE   DC    16CL4'IO'              SAVE AREA FOR I/O INTERRUPTS                          
                                     524 *                                                                                           
                                     525 ******************************************                                                  
                                     526 * TCB WORDS, LOUNTR                                                                         
                                     527 ******************************************                                                  
                                     528 *                                                                                           
 000518                              529          ORG   FIRST4K+X'518'         MOVE TO LOCATION FOR TCBWORDS                         
 000518 0000000000000000             530 TCBWORDS DC    4F'0'                  FILL TCBWORDS WITH ZEROS                              
 0007E0                              531          ORG   FIRST4K+X'7E0'         MOVE TO LOCATION FOR LOUNTR                           
 0007E0                              532 LOUNTR   DS    0H                     LABEL FOR START OF LOUNTR                             
                                     533          LOUNTR                       INVOKE LOUNTR MACRO                                   
                                     534+* LOUNTR ==> MUST <== BE LOCATED AT X'7E0'                                                  
 0007E0 F3841000100CDC07             535+ DC X'F3841000100CDC071000070047F01010',C'0123456789ABCDEF' LOUNTR                          
                                     536 ************************************                                                        
                                     537 * SVCTABLE                                                                                  
                                     538 ************************************                                                        
 002000                              539          ORG   FIRST4K+X'2000'        MOVE TO LOCATION FOR SVC TABLE                        
 002000 0000000000000000             540 SVCTABLE DC    16D'0'                 FILL SVC TABLE WITH ZEROS                             
 002400                              541          ORG   FIRST4K+X'2400'        MOVE TO DISPATCHER LOCATION                           
 002400 0119                         542 DISPATCH DC    X'0119'                NOT USING DISPATCHER YET                              
 002800                              543          ORG   FIRST4K+X'2800'        MOVE TO LOCATION FOR THE CVT                          
 002800 0000000000000000             544 MYCVT    DC    96X'0'                 SET UP THE CVT                                        
1       IPL ROUTINE STEPS(1-4) DOC                                                                              PAGE    7            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     546 *                                                                                           
                                     547 **********************************************************************                      
                                     548 * IPLPGM                                                                                    
                                     549 *                                                                                           
                                     550 * INPUT:  NONE                                                                              
                                     551 *                                                                                           
                                     552 * OUTPUT: A MESSAGE THAT STATES THE VALUE SAVED FOR CVTMZ00                                 
                                     553 *                                                                                           
                                     554 * ENTRY CONDITONS: ??                                                                       
                                     555 *                                                                                           
                                     556 * EXIT CONDITIONS: ??                                                                       
                                     557 *                                                                                           
                                     558 * REGISTER USAGE:                                                                           
                                     559 *                                                                                           
                                     560 *    R0 -  ADDRESS OF LOWEST STORAGE AREA IN MEMORY (FOR TRACING)                           
                                     561 *    R1 -  HIGHEST ADDRESS IN THE ASSEMBLY (FOR TRACING)                                    
                                     562 *          ALSO USED BY LOUNTR                                                              
                                     563 *    R2 -  ASSISTV TRACE TYPE CODES                                                         
                                     564 *    R3 -  CVT ADDRESSABILITY                                                               
                                     565 *    R6 -  USED IN PERFORMING LOGICAL COMPARISONS                                           
                                     566 *          (FOR THE SOC5 AND THE ADDRESS OF SOC5 INSTRUCTION)                               
                                     567 *    R7 -  HOLDS STORAGE KEY OF ZERO                                                        
                                     568 *    R8 -  HOLD ADDRESS TO SET STORAGE KEY VALUE                                            
                                     569 *    R12 - USED FOR IPLPGM ADDRESSABILITY                                                   
                                     570 *                                                                                           
                                     571 * LOGIC:                                                                                    
                                     572 *                                                                                           
                                     573 * 1) Set up addressability based upon R12                                                   
                                     574 * 2) Set the clock to X'50' to the value X'7FFFFFF'                                         
                                     575 * 3) Turn on the Assist-V Trace Facility                                                    
                                     576 * 4) 4.1) Set all of the 2K blocks of memory with a protection byte of                      
                                     577 *         X'00'                                                                             
                                     578 *    4.2) Check that a SOC5 caused the program check interrupt                              
                                     579 *    4.3) Make sure address of instruction causing SOC5 is in                               
                                     580 *         old program check PSW                                                             
                                     581 *    4.4) Print the value of CVTMZ00                                                        
                                     582 *                                                                                           
                                     583 **********************************************************************                      
1       IPL ROUTINE CODE                                                                                        PAGE    8            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 003000                              585          ORG   FIRST4K+X'3000'        MOVE TO THE IPL ROUTINE                               
                                     586 *                                                                                           
                                     587 * 1. Set up Addressability based on R12                                                     
                                     588 *                                                                                           
 003000 05C0                         589 IPLPGM   BALR  12,0                   Put ani into R12                                      
 003002 06C0                         590          BCTR  12,0                   Decrement R12 by 1                                    
 003004 06C0                         591          BCTR  12,0                   Decrement again                                       
 003000                              592          USING IPLPGM,12              Now R12 points to start of IPLPGM                     
                                     593 *                                                                                           
                                     594 * 2. Set the Clock (X'50') to X'7FFFFFF'                                                    
                                     595 *                                                                                           
 003006 D203 0050 C07C 00050 0307C   596          MVC   CLOCK(4),TIMEVAL       set value for clock                                   
                                     597 *                                                                                           
                                     598 * 3. Turn on the Assist-V Trace Facility                                                    
                                     599 *                                                                                           
 00300C 9802 C070            03070   600          LM    0,2,R0R1R2             load regs to set trace                                
 003010 0103                         601          XOPC  3                      turn on trace                                         
                                     602 *                                                                                           
                                     603 * 4. Set all of the 2K blocks of memory with a                                              
                                     604 *    protection byte of X'00'                                                               
                                     605 *                                                                                           
 003012 1777                         606          XR    7,7                    R7 will be R1, ZERO IT                                
 003014 1788                         607          XR    8,8                    R8 will be R2, ZERO IT                                
 003016 0878                         608 LOOP     SSK   7,8                    Set Storage Key to 0                                  
 003018 4180 8800            00800   609 POINTHER LA    8,X'800'(,8)           increment RB b 2K                                     
 00301C 47F0 C016            03016   610          B     LOOP                   continue infinite loop                                
 003020 D202 006D C081 0006D 03081   611 AFTERLOP MVC   NPSWPC+5(3),REALPC+1   put @(PCFLIH) into PC New PSW                         
                                     612 *                                                                                           
                                     613 * Check that it was a SOC5 that caused the Program Check                                    
                                     614 *                                                                                           
 003026 9505 002B      0002B         615          CLI   OPSWPC+3,5             See if int code was 5 (FOR SOC5)                      
 00302A 4770 C06C            0306C   616          BNE   IPL0119                If not, stop                                          
                                     617 *                                                                                           
                                     618 * Test if @(POINTHER) in old PC PSW                                                         
                                     619 *                                                                                           
 00302E 4160 C018            03018   620          LA    6,POINTHER             Get @POINTHER                                         
 003032 BD67 002D            0002D   621          CLM   6,7,OPSWPC+5           If inst. addr in PSW POINTHER                         
 003036 4770 C06C            0306C   622          BNE   IPL0119                No, then stop                                         
                                     623 *                                                                                           
 00303A 5830 004C            0004C   624          L     3,76                   Get @CVT                                              
 000000                              625          USING CVT,3                  CVT addressability                                    
 00303E 0680                         626          BCTR  8,0                    Decrease HIGHEST by 1                                 
 003040 5080 3058            00058   627          ST    8,CVTMZ00              Save HIGHEST address                                  
                                     628 *                                                                                           
                                     629 * Print the value of CVTMZ00                                                                
                                     630 *                                                                                           
 003044 D203 C05A 3058 0305A 00058   631          MVC   LSTOR+12(4),CVTMZ00    Put CVTMZ00 into LOUNTR stor                          
 00304A 4510 07E0            007E0   632          BAL   1,LOUNTR               LOUNTR translates CVTMZ00                             
 00304E D340404040404040             633 LSTOR    DC    CL16'L'                Storage for LOUNTR                                    
 00305E D207 C090 C04E 03090 0304E   634          MVC OUTVAL(8),LSTOR          Put value in print line                               
 003064 E020 C084 0014 03084         635          XPRNT MESSAGEO,20            print value of CVTMZ00                                
 00306A 0000                         636          DC H'0'                      CAUSE A SOC1 (PROGRAM EXCEPTION)                      
                                     637 *                                                                                           
 00306C 0119                         638 IPL0119  XOPC  25                     Die if anything goes wrong                            
1       IPL ROUTINE STORAGE AREA                                                                                PAGE    9            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     640 *                                                                                           
                                     641 **********************************************************************                      
                                     642 * IPL PROGRAM STORAGE AREA                                                                  
                                     643 **********************************************************************                      
                                     644 *                                                                                           
 003070 00000000                     645 R0R1R2   DC    F'0'                   SET 'LOWEST' AREA TRACED ZERO                         
 003074 0000400A                     646          DC    A(HIGHEST)             SET 'HIGHEST' AREA TRACED 'TOP'                       
 003078 00E08040                     647          DC    XL4'00E08040'          TRACE CH. 0-1-2, SWAPS, PRIVOPS                       
 00307C 7FFFFFFF                     648 TIMEVAL  DC    X'7FFFFFFF'            VALUE FOR SETTING THE CLOCK                           
 003080 00004004                     649 REALPC   DC    A(PCFLIH)              ACTUAL ADDRESS OF PC FLIH                             
                                     650 *                                                                                           
 003084 40                           651 MESSAGEO DC    C' '                   CC FOR MESSAGEO                                       
 003085 C3E5E3D4E9F0F040             652          DC    CL11'CVTMZ00 is '      FIRST PART OF MESSAGE                                 
 003090 4040404040404040             653 OUTVAL   DC    CL8' '                 CVTMZ00 VALUE ON PRINT LINE                           
                                     654 *                                                                                           
 004000                              655          ORG   FIRST4K+X'4000'        GO TO PLACE FOR FLIHs                                 
 004000 0119                         656 EXFLIH   DC    X'0119'                EXTERNAL FLIH                                         
 004002 0119                         657 SVCFLIH  DC    X'0119'                SVC FLIH                                              
 004004 0119                         658 PCFLIH   DC    X'0119'                PROGRAM CHECK FLIH                                    
 004006 0119                         659 MCFLIH   DC    X'0119'                MACHINE CHECK FLIH                                    
 004008 0119                         660 IOFLIH   DC    X'0119'                I/O FLIH                                              
 00400A C8C9C7C8C5E2E340             661 HIGHEST  DC    CL8'HIGHEST'           HIGHEST address                                       
                                     662          END   FIRST4K                END OF THE 1ST 4K CSECT                               
0***  NO   STATEMENTS FLAGGED -  NO   WARNINGS,  NO   ERRORS                                                                         
 *** DYNAMIC CORE AREA USED:    55200 LOW +    6792 HIGH, LEAVING  456152 FREE BYTES. AVERAGE:       93 BYTES/STMT ***               
0*** CROSS-REFERENCE:  VALUE(HEX) LOCATION REF REF ... (- SHOWS MODIFY) ***                                                          
 AFTERLOP 003020   501   CLOCK    000050  -596   CVT      000000   625   CVTMZ00  000058  -627   631   EXFLIH   004000   499         
 FIRST4K  000000   472   662   HIGHEST  00400A   646   IOFLIH   004008   503   IPLPGM   003000   475   592   IPL0119  00306C   616   
    622   LOOP     003016   610   LOUNTR   0007E0   632   LSTOR    00304E  -631   634   MCFLIH   004006   502   MESSAGEO 003084      
    635   MYCVT    002800   477   491   NPSWPC   000068  -611   OPSWPC   000028   615   621   OUTVAL   003090  -634                  
 PCFLIH   004004   649   POINTHER 003018   620   REALPC   003080   611   R0R1R2   003070   600   SVCFLIH  004002   500               
 TIMEVAL  00307C   596                                                                                                               
 *** ASSEMBLY TIME =    0.012 SECS,    55250 STATEMENTS/SEC ***                                                                      
 *** PROGRAM EXECUTION BEGINNING - ANY OUTPUT BEFORE EXECUTION TIME MESSAGE IS PRODUCED BY USER PROGRAM ***                          
                                                                                                                                     
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 TRACE--> TIME: 00000003  PSW SWAP--CAUSE=PGM INT.  OPSW= 01040005 4F003018; NPSW= 01040119 0F003020                                 
 CVTMZ00 is 000047FF                                                                                                                 
 TRACE--> TIME: 00000007  PSW SWAP--CAUSE=PGM INT.  OPSW= 01040001 4F00306C; NPSW= 01040119 0F004004                                 
0*** ASSIST-V FINAL STATISTICS ***                                                                                                   
 SIMULATED CLOCK TIME=         7 TIMER UNITS                                                                                         
 CPU UTILIZATION:       BUSY    100.0%  SUPER   100.0%  PROBLEM   0.0%                                                               
 CHANNEL UTILIZATION:   CH0       0.0%  CH1       0.0%  CH2       0.0%                                                               
 PROCESSOR OVERLAP:     CPU/CH0   0.0%  CPU/CH1   0.0%  CPU/CH2   0.0%                                                               
 DISK ARM MOVEMENT:     DISK101          0 SEEKS,          0 CYLINDERS CROSSED                                                       
1*** EXECUTION TIME =    0.000 SECS.        56 INSTRUCTIONS EXECUTED -    56000 INSTRUCTIONS/SEC ***                                 
 *** FIRST CARD NOT READ: NO CARDS READ:FILE UNOPENED                                                                                
0*** ASSIST COMPLETION DUMP ***                                                                                                      
0*** PSW AT ABEND 01040119 4F004006       COMPLETION CODE   ASSIST = V01 USER REQUESTED ABEND DUMP                                   
0*** TRACE OF INSTRUCTIONS JUST BEFORE TERMINATION: PSW BITS SHOWN ARE THOSE BEFORE CORRESPONDING INSTRUCTION DECODED ***            
0  IM LOCATION    INSTRUCTION :  IM = PSW BITS 32-39 (ILC,CC,MASK)                                                                   
0  8F  003044     D203 C05A 3058                                                                                                     
0  CF  00304A     4510 07E0                                                                                                          
0  8F  0007E0     F384 1000 100C                                                                                                     
0  CF  0007E6     DC07 1000 0700                                                                                                     
0  CF  0007EC     47F0 1010                                                                                                          
0  8F  00305E     D207 C090 C04E                                                                                                     
0  CF  003064     E020 C084 0014                                                                                                     
0  CF  00306A     0000                                                                                                               
0  4F  00306C     PSW SWAP -- PGM                                                                                                    
0  0F  004004     0119            <-- LAST INSTRUCTION DONE - PROBABLE CAUSE OF TERMINATION                                          
0*** TRACE OF LAST 10 BRANCH INSTRUCTIONS EXECUTED ***                                                                               
0  IM LOCATION    INSTRUCTION :  IM = PSW BITS 32-39 (ILC,CC,MASK)                                                                   
   8F  00301C     47F0 C016                                                                                                          
   8F  00301C     47F0 C016                                                                                                          
   8F  00301C     47F0 C016                                                                                                          
   8F  00301C     47F0 C016                                                                                                          
   8F  00301C     47F0 C016                                                                                                          
   8F  00301C     47F0 C016                                                                                                          
   4F  003018     PSW SWAP -- PGM                                                                                                    
   CF  00304A     4510 07E0                                                                                                          
   CF  0007EC     47F0 1010                                                                                                          
   4F  00306C     PSW SWAP -- PGM                                                                                                    
0 REGS 0-7      00000000    8F00304E    00E08040    00002800    F6F6F6F6    F6F6F6F6    00003018    00000000                         
  REGS 8-15     000047FF    F6F6F6F6    F6F6F6F6    F6F6F6F6    4F003000    F6F6F6F6    F6F6F6F6    F6F6F6F6                         
0 FLTR 0-6      F6F6F6F6F6F6F6F6        F6F6F6F6F6F6F6F6        F6F6F6F6F6F6F6F6        F6F6F6F6F6F6F6F6                             
0*** USER STORAGE ***                                                                                                                
0                             CORE ADDRESSES SPECIFIED-     000000 TO 0047FF                                                         
 000000   01040119 0F003000 01190119 01190119    00002800 01190119 00000000 00000000   *................................*            
 000020   00000000 00000000 01040001 4F00306C    00000000 00000000 00000000 00000000   *................................*            
 000040   01190119 01190119 01190119 00002800    7FFFFFF8 01190119 01060119 0F004000   *...................8.......... .*            
 000060   01040119 0F004002 01040119 0F004004    01040119 0F004006 01040119 0F004008   *...... ....... ....... ....... .*            
 000080   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
 0000A0   00000000 00000000 01190119 01190119    00000000 01190119 01190119 0119E7E7   *..............................XX*            
 0000C0   C5E74040 C5E74040 C5E74040 C5E74040    C5E74040 C5E74040 C5E74040 C5E74040   *EX  EX  EX  EX  EX  EX  EX  EX  *            
1  LINES    0000E0-0000E0    SAME AS ABOVE                                                                                           
 000100   E2E54040 E2E54040 E2E54040 E2E54040    E2E54040 E2E54040 E2E54040 E2E54040   *SV  SV  SV  SV  SV  SV  SV  SV  *            
   LINES    000120-000120    SAME AS ABOVE                                                                                           
 000140   D7C34040 D7C34040 D7C34040 D7C34040    D7C34040 D7C34040 D7C34040 D7C34040   *PC  PC  PC  PC  PC  PC  PC  PC  *            
   LINES    000160-000160    SAME AS ABOVE                                                                                           
 000180   C9D64040 C9D64040 C9D64040 C9D64040    C9D64040 C9D64040 C9D64040 C9D64040   *IO  IO  IO  IO  IO  IO  IO  IO  *            
   LINES    0001A0-0001A0    SAME AS ABOVE                                                                                           
 0001C0   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    0001E0-0004E0    SAME AS ABOVE                                                                                           
 000500   01190119 01190119 01190119 01190119    01190119 01190119 00000000 00000000   *................................*            
 000520   00000000 00000000 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
 000540   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    000560-0007C0    SAME AS ABOVE                                                                                           
 0007E0   F3841000 100CDC07 10000700 47F01010    F0F1F2F3 F4F5F6F7 F8F9C1C2 C3C4C5C6   *3............0..0123456789ABCDEF*            
 000800   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    000820-000FE0    SAME AS ABOVE                                                                                           
 001000   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    001020-001FE0    SAME AS ABOVE                                                                                           
 002000   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    002020-002060    SAME AS ABOVE                                                                                           
 002080   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0020A0-0023E0    SAME AS ABOVE                                                                                           
 002400   0119F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *..777777777777777777777777777777*            
 002420   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    002440-0027E0    SAME AS ABOVE                                                                                           
 002800   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    002820-002820    SAME AS ABOVE                                                                                           
 002840   00000000 00000000 00000000 00000000    00000000 00000000 000047FF 00000000   *................................*            
 002860   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    002880-002FE0    SAME AS ABOVE                                                                                           
 003000   05C006C0 06C0D203 0050C07C 9802C070    01031777 17880878 41808800 47F0C016   *......K......................0..*            
 003020   D202006D C0819505 002B4770 C06C4160    C018BD67 002D4770 C06C5830 004C0680   *K...............................*            
 003040   50803058 D203C05A 30584510 07E0F0F0    F0F0F4F7 C6C62D40 40400000 47FFD207   *....K.........000047FF.   ....K.*            
 003060   C090C04E E020C084 00140000 0119F7F7    00000000 0000400A 00E08040 7FFFFFFF   *..............77...... .... ....*            
 003080   00004004 40C3E5E3 D4E9F0F0 4089A240    F0F0F0F0 F4F7C6C6 F7F7F7F7 F7F7F7F7   *.. . CVTMZ00 .. 000047FF77777777*            
 0030A0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0030C0-003FE0    SAME AS ABOVE                                                                                           
 004000   01190119 01190119 0119C8C9 C7C8C5E2    E340F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *..........HIGHEST 77777777777777*            
 004020   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    004040-0047E0    SAME AS ABOVE                                                                                           
0                                                                                                                                    
 !! END OF JES SPOOL FILE !!
