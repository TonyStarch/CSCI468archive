1                        J E S 2  J O B  L O G  --  S Y S T E M  P R O D  --  N O D E  N I U             
0 
 14.10.16 JOB07308 ---- MONDAY,    02 MAY 2005 ----
 14.10.16 JOB07308  $HASPU01 JOB PARMS - TIME=(0,5),LINES=5,CARDS=100,TAPES=0,ROOM=199
 14.10.16 JOB07308  IEF677I WARNING MESSAGE(S) FOR JOB Z030199A ISSUED
 14.10.16 JOB07308  $HASP373 Z030199A STARTED - INIT 14   - CLASS M - SYS PROD
 14.10.16 JOB07308  ACF9CCCD USERID Z030199  IS ASSIGNED TO THIS JOB - Z030199A
 14.10.16 JOB07308  IEF403I Z030199A - STARTED - TIME=14.10.16
 14.10.17 JOB07308  AMS000I: STEP END  Z030199A.ASM       RC=  0000    CPU= 00:00:00.19    PGM=ASMA90
 14.10.18 JOB07308  AMS000I: STEP END  Z030199A.GO        RC=  0000    CPU= 00:00:00.08    PGM=LOADER
 14.10.18 JOB07308  IEF404I Z030199A - ENDED - TIME=14.10.18
 14.10.18 JOB07308  AMS000I: JOB  END  Z030199A  Brandon Twee          CPU= 00:00:00.27
 14.10.18 JOB07308  $HASP395 Z030199A ENDED
0------ JES2 JOB STATISTICS ------                                                                                                   
-  02 MAY 2005 JOB EXECUTION DATE                                                                                                    
-          466 CARDS READ                                                                                                            
-        2,103 SYSOUT PRINT RECORDS                                                                                                  
-            0 SYSOUT PUNCH RECORDS                                                                                                  
-          196 SYSOUT SPOOL KBYTES                                                                                                   
-         0.03 MINUTES EXECUTION TIME                                                                                                
 !! END OF JES SPOOL FILE !!
        1 //Z030199A JOB ,'Brandon Tweed',REGION=2M,                              JOB07308
          //             MSGCLASS=X                                                       
          /*JOBPARM ROOM=199,L=5                                                          
          //* $ACFJ219 ACF2 ACTIVE NIU                                                ACF2
        2 //STEP1 EXEC HLASMCG,CPARM='NOESD,NOMXREF,NORLD,NOUSING,NOXREF',                
          //      LPARM='NOMAP,NOPRINT',                                                  
          //      GPARM='STOW,ABEND,STIMER,CLOSE,BLDL'                                    
        3 XXHLASMCG  PROC CDISP=,                                                 00001000
          XX             CPARM=,                                                  00002000
          XX             CREGION=512K,                                            00003000
          XX             GPARM=,                                                  00004000
          XX             GREGION=512K,                                            00005000
          XX             LPARM= ,                                                 00007000
          XX*             LEVEL=SYS2,                                             00007100
          XX*             VERSION=V120                                            00008000
          XX*******************************************************************   00009000
          XX*   PLEASE CALL 3-1802 IF YOU HAVE PROBLEMS WITH THIS PROCEDURE.  *   00010000
          XX*******************************************************************   00011000
        4 XXASM      EXEC PGM=ASMA90,PARM='&CPARM',REGION=&CREGION                00012000
          XX*STEPLIB  DD   DSN=&LEVEL..HLA.&VERSION..LOADLIB,DISP=SHR             00013000
          IEFC653I SUBSTITUTION JCL - PGM=ASMA90,PARM='NOESD,NOMXREF,NORLD,NOUSING,NOXREF',REGION=512K
        5 //ASM.SYSLIB DD                                                                 
          X/SYSLIB   DD   DSN=SYS1.MACLIB,DISP=SHR                                00014000
        6 //           DD                                                                 
          X/         DD   DSN=SYS2.MACLIB,DISP=SHR                                00015000
        7 //           DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR                            
        8 XXSYSLIN   DD   DSN=&&OBJSET,UNIT=PUB,SPACE=(CYL,(1,1)),                00016000
          XX             DISP=(&CDISP,PASS,DELETE)                                00017000
          IEFC653I SUBSTITUTION JCL - DSN=&&OBJSET,UNIT=PUB,SPACE=(CYL,(1,1)),DISP=(,PASS,DELETE)
        9 XXSYSPRINT DD   SYSOUT=*                                                00018000
       10 XXSYSPUNCH DD   SYSOUT=B                                                00019000
       11 XXSYSTERM  DD   SYSOUT=*                                                00020000
       12 XXSYSUT1   DD   DSN=&&SYSUT1,UNIT=PUB,SPACE=(CYL,(10,5))                00021000
       13 //SYSIN DD *                                                                    
       14 XXGO       EXEC PGM=LOADER,PARM='MAP,NORES,&LPARM/&GPARM',              00022000
          XX             COND=(8,LT,ASM),REGION=&GREGION                          00023000
          IEFC653I SUBSTITUTION JCL - PGM=LOADER,PARM='MAP,NORES,NOMAP,NOPRINT/STOW,ABEND,STIMER,CLOSE,BLDL',COND=(8,LT,
          ASM),REGION=512K
       15 XXSYSLIB   DD   DSN=SYS2.CALLIB,DISP=SHR                                00024000
       16 XXSYSLIN   DD   DSN=&&OBJSET,DISP=(OLD,DELETE)                          00025000
       17 XX         DD   DDNAME=SYSIN                                            00026000
       18 XXSYSLOUT  DD   SYSOUT=*                                                00027000
       19 XXSYSTERM  DD   SYSOUT=*                                                00028000
       20 XXXPRNT    DD   SYSOUT=*                                                00029000
          XX*                                                                     00030000
          XX*   A   //GO.XSNAPOUT DD   CARD MAY BE ADDED TO SEPARATE              00031000
          XX*                          XSNAP OUTPUT FROM XPRNT OUTPUT             00032000
          XX*                                                                     00033000
          XX*   END OF HLASMCG PROCEDURE                                          00034000
       21 //GO.LIBFILE DD DSN=T90RPR1.CS468PUB.PDS6,DISP=SHR                              
       22 //           DD DSN=T90RPR1.CS468PUB.PDS8,DISP=SHR                              
       23 //           DD DSN=T90RPR1.CS468PUB.PDS5,DISP=SHR                              
       24 //           DD DSN=T90RPR1.CS468PUB.PDS9,DISP=SHR                              
       25 //           DD DSN=T90RPR1.CS468PUB.PDS7,DISP=SHR                              
          //*                                                                             
       26 //GO.SEQFILE DD DSN=T90RPR1.CS468PUB.PDS9(STOW),DISP=SHR                        
       27 //           DD DSN=T90RPR1.CS468PUB.PDS8(ABEND),DISP=SHR                       
       28 //           DD DSN=T90RPR1.CS468PUB.PDS5(STIMER),DISP=SHR                      
       29 //           DD DSN=T90RPR1.CS468PUB.PDS7(CLOSE),DISP=SHR                       
       30 //           DD DSN=T90RPR1.CS468PUB.PDS6(BLDL),DISP=SHR                        
          //*                                                                             
       31 //GO.OUT2 DD SYSOUT=*                                                           
       32 //GO.SYSUDUMP DD SYSOUT=*                                                       
       33 //                                                                              
 !! END OF JES SPOOL FILE !!
  STMT NO. MESSAGE
         2 IEFC001I PROCEDURE HLASMCG WAS EXPANDED USING SYSTEM LIBRARY SYS2.PROCLIB
        32 IEF686I DDNAME REFERRED TO ON DDNAME KEYWORD IN PRIOR STEP WAS NOT RESOLVED 
 IEF236I ALLOC. FOR Z030199A ASM STEP1
 IEF237I 0500 ALLOCATED TO SYSLIB
 IEF237I 0517 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IGD101I SMS ALLOCATED TO DDNAME (SYSLIN  )
         DSN (SYS05122.T141016.RA000.Z030199A.OBJSET.H01  )
         STORCLAS (TEMPSTOR) MGMTCLAS (        ) DATACLAS (        )
         VOL SER NOS= TMP301                                                                
 IEF237I JES2 ALLOCATED TO SYSPRINT
 IEF237I JES2 ALLOCATED TO SYSPUNCH
 IEF237I JES2 ALLOCATED TO SYSTERM
 IGD101I SMS ALLOCATED TO DDNAME (SYSUT1  )
         DSN (SYS05122.T141016.RA000.Z030199A.SYSUT1.H01  )
         STORCLAS (TEMPSTOR) MGMTCLAS (        ) DATACLAS (        )
         VOL SER NOS= TMP303                                                                
 IEF237I JES2 ALLOCATED TO SYSIN
 IEF142I Z030199A ASM STEP1 - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   SYS2.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYS304.                            
 IEF285I   T90RPR1.CS468PUB.MACLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IGD106I SYS05122.T141016.RA000.Z030199A.OBJSET.H01   PASSED,    DDNAME=SYSLIN  
 IEF285I   Z030199.Z030199A.JOB07308.D0000102.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB07308.D0000103.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB07308.D0000104.?         SYSOUT        
 IGD105I SYS05122.T141016.RA000.Z030199A.SYSUT1.H01   DELETED,   DDNAME=SYSUT1  
 IEF285I   Z030199.Z030199A.JOB07308.D0000101.?         SYSIN         
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     ASM         START TIME  14:10:16.21   VIRT SYS  USED     268K   PAGE INS              0  STEP CPU      00:00:00.19 *
 * PGM NAME      ASMA90      STOP  TIME 14:10:17.57    VIRT CORE USED   2,048K   PAGE OUTS             0  JOB  CPU      00:00:00.19 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:01.36    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.01 *
 * PERF. GROUP         0     SERV UNITS       1,261    TRANS ACT TIME  00:00:01.08                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS           1,065     SRB UNITS              33     I/O UNITS             163        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  SYSLIB        500        124  SYSLIB   + 1  517          4  SYSLIB   + 2  512          2  SYSLIN        518        120          *
 *  SYSUT1        520          0                                                                                                    *
 *                                                                                                                                  *
 * EXCP TOTAL             250  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/ASM     /START 2005122.1410
 IEF374I STEP/ASM     /STOP  2005122.1410 CPU    0MIN 00.19SEC SRB    0MIN 00.01SEC VIRT  2048K SYS   268K EXT     440K SYS    9340K
 IEF236I ALLOC. FOR Z030199A GO STEP1
 IEF237I 0517 ALLOCATED TO SYSLIB
 IGD103I SMS ALLOCATED TO DDNAME SYSLIN
 IEF237I DMY  ALLOCATED TO 
 IEF237I JES2 ALLOCATED TO SYSLOUT
 IEF237I JES2 ALLOCATED TO SYSTERM
 IEF237I JES2 ALLOCATED TO XPRNT
 IEF237I 0512 ALLOCATED TO LIBFILE
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO SEQFILE
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I JES2 ALLOCATED TO OUT2
 IEF237I JES2 ALLOCATED TO SYSUDUMP
 IEF142I Z030199A GO STEP1 - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   SYS2.CALLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYS304.                            
 IGD105I SYS05122.T141016.RA000.Z030199A.OBJSET.H01   DELETED,   DDNAME=SYSLIN  
 IEF285I   Z030199.Z030199A.JOB07308.D0000105.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB07308.D0000106.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB07308.D0000107.?         SYSOUT        
 IEF285I   T90RPR1.CS468PUB.PDS6                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS8                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS5                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS9                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS7                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS9                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS8                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS5                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS7                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.PDS6                        KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   Z030199.Z030199A.JOB07308.D0000108.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB07308.D0000109.?         SYSOUT        
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     GO          START TIME  14:10:17.62   VIRT SYS  USED     284K   PAGE INS              0  STEP CPU      00:00:00.08 *
 * PGM NAME      LOADER      STOP  TIME 14:10:18.31    VIRT CORE USED     228K   PAGE OUTS             0  JOB  CPU      00:00:00.27 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:00.69    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.01 *
 * PERF. GROUP         0     SERV UNITS         681    TRANS ACT TIME  00:00:00.57                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS             459     SRB UNITS              30     I/O UNITS             192        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  SYSLIB        517         11  SYSLIN        518        121  LIBFILE       512         86  LIBFILE  + 1  512          0          *
 *  LIBFILE  + 2  512          0  LIBFILE  + 3  512          0  LIBFILE  + 4  512          0  SEQFILE       512          2          *
 *  SEQFILE  + 1  512          3  SEQFILE  + 2  512         65  SEQFILE  + 3  512          5  SEQFILE  + 4  512         10          *
 *                                                                                                                                  *
 *                                                                                                                                  *
 * EXCP TOTAL             303  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/GO      /START 2005122.1410
 IEF374I STEP/GO      /STOP  2005122.1410 CPU    0MIN 00.08SEC SRB    0MIN 00.01SEC VIRT   228K SYS   284K EXT    1184K SYS    9404K
 ************************************************************************************************************************************
 *                                                  JOB TERMINATION STATISTICS                                                      *
 *                                                                                                                                  *
 *  JOB NAME    Z030199A  JOB07308                              CPU TIME  00:00:00.27            SRB TIME            00:00:00.02    *
 *                                                                                                                                  *
 *  PROGRAMMER  Brandon Tweed                                   INIT DATE 05/02/05   05.122      INITIATION TIME     14:10:16.21    *
 *                                                                                                                                  *
 *  SYSTEM ID   O2B4                                            TERM DATE 05/02/05   05.122      TERMINATION TIME    14:10:18.33    *
 *                                                                                                                                  *
 *  CLASS       M         PERF. GROUP      0                    SERV UNIT      1,942             ELAPSED TIME        00:00:02.12    *
 *                                                                                                                                  *
 *  MAIN STORAGE UNITS           0     CPU UNITS           1,524     SRB UNITS              63     I/O UNITS             355        *
 *                                                                                                                                  *
 *  JOB LOG Z030199A 05122 14:10:16.06                          MVS REL   SP6.1.0                                                   *
 *                                                                                                                                  *
 *  ACCTG DATA 0135040675,Z03    0199,T,Z03    ,TWEED BRANDON DAVID                              COMPLETION STATUS   C0000          *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF375I  JOB/Z030199A/START 2005122.1410
 IEF376I  JOB/Z030199A/STOP  2005122.1410 CPU    0MIN 00.27SEC SRB    0MIN 00.02SEC
 !! END OF JES SPOOL FILE !!
¤                                                                                                                                    
                                         High Level Assembler Option Summary                   (PTF UQ57391)   Page    1            
                                                                                            HLASM R4.0  2005/05/02 14.10            
  No Overriding ASMAOPT Parameters                                                                                                  
  Overriding Parameters-  NOESD,NOMXREF,NORLD,NOUSING,NOXREF                                                                        
  No Process Statements                                                                                                             
                                                                                                                                    
                                                                                                                                    
  Options for this Assembly                                                                                                         
  NOADATA                                                                                                                           
    ALIGN                                                                                                                           
  NOASA                                                                                                                             
    BATCH                                                                                                                           
    CODEPAGE(047C)                                                                                                                  
  NOCOMPAT                                                                                                                          
  NODBCS                                                                                                                            
  NODECK                                                                                                                            
    DXREF                                                                                                                           
3 NOESD                                                                                                                             
  NOEXIT                                                                                                                            
    FLAG(0,ALIGN,CONT,NOIMPLEN,NOPAGE0,PUSH,RECORD,NOSUBSTR,USING0)                                                                 
  NOFOLD                                                                                                                            
  NOGOFF                                                                                                                            
  NOINFO                                                                                                                            
    LANGUAGE(EN)                                                                                                                    
  NOLIBMAC                                                                                                                          
    LINECOUNT(60)                                                                                                                   
    LIST(121)                                                                                                                       
3 NOMXREF                                                                                                                           
    OBJECT                                                                                                                          
    OPTABLE(UNI,NOLIST)                                                                                                             
  NOPCONTROL                                                                                                                        
  NOPESTOP                                                                                                                          
  NOPROFILE                                                                                                                         
  NORA2                                                                                                                             
  NORENT                                                                                                                            
3 NORLD                                                                                                                             
    RXREF                                                                                                                           
    SIZE(MAX)                                                                                                                       
    SYSPARM()                                                                                                                       
  NOTERM                                                                                                                            
  NOTEST                                                                                                                            
    THREAD                                                                                                                          
  NOTRANSLATE                                                                                                                       
3 NOUSING                                                                                                                           
3 NOXREF                                                                                                                            
                                                                                                                                    
  No Overriding DD Names                                                                                                            
¤                                                                                                                                    
                                                                                                               Page    2            
  Active Usings: None                                                                                                               
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                      1          EQUCCWS                                                                            
                                      2+*CSCI 468  EQUATES FOR DISK I/O  V6.7 SPRING, 1989   1 OF 1                                 
                                      3+*                                                                                           
                                      4+*                                                                                           
                                      5+**** CCW COMMAND CODE EQUATES FOR DISK I/O ****                                             
                                      6+*                                                                                           
                      00008           7+TIC      EQU   X'08'  TRANSFER IN CHANNEL.                              01-EQUCC            
                      00029           8+SEARKEQ  EQU   X'29'  SEARCH KEY EQUAL.                                 01-EQUCC            
                      00069           9+SEARKHE  EQU   X'69'  SEARCH KEY HIGH OR EQUAL.                         01-EQUCC            
                      0001A          10+READHA   EQU   X'1A'  READ HOME ADDRESS.                                01-EQUCC            
                      00016          11+READR0   EQU   X'16'  READ RECORD 0.                                    01-EQUCC            
                      00012          12+READC    EQU   X'12'  READ COUNT.                                       01-EQUCC            
                      00006          13+READDATA EQU   X'06'  READ DATA.                                        01-EQUCC            
                      0000E          14+READKD   EQU   X'0E'  READ KEY AND DATA.                                01-EQUCC            
                      0001E          15+READCKD  EQU   X'1E'  READ COUNT, KEY AND DATA.                         01-EQUCC            
                      00023          16+SETSECT  EQU   X'23'  SET SECTOR.                                       01-EQUCC            
                      00022          17+READSECT EQU   X'22'  READ SECTOR.                                      01-EQUCC            
                      00031          18+SEARIDEQ EQU   X'31'  SEARCH IDENTIFIER EQUAL.                          01-EQUCC            
                      00004          20+SENSE    EQU   X'04'  SENSE    V6.5  SPRING, 1987                       01-EQUCC            
                      00005          21+WRITEDAT EQU   X'05'  WRITE DATA    V6.5  SPRING, 1987                  01-EQUCC            
                      0000D          22+WRITEKD  EQU   X'0D'  WRITE KEY AND DATA    V6.5  SPRING, 1987          01-EQUCC            
                      0001D          23+WRITECKD EQU   X'1D'  WRITE COUNT, KEY, AND DATA   V6.5  SP. '87        01-EQUCC            
                                     25+*                                                     V6.7 = SP. '89                        
                      00064          26+READEVCH EQU   X'64'  READ DEVICE CHARACTERISTICS (64 BYTES) SP. '89    01-EQUCC            
                      0005E          27+READMCKD EQU   X'5E'  READ MULTIPLE COUNT, KEY, AND DATA     SP. '89    01-EQUCC            
                      00080          28+MT       EQU   X'80'  'MULTI-TRACK' USE WITH APPROPRIATE     SP. '89    01-EQUCC            
                                     29+*                     OP-CODES AS:   CCW   SEARKHE+MT,B,C,D  SP. '89                        
                      00003          31+NOOP     EQU   X'03'  NO-OPERATION.                                     01-EQUCC            
                                     33+*                                                                                           
                                     34+**** CCW FLAG EQUATES ****                                                                  
                                     35+*                                                                                           
                      00080          36+CD       EQU   X'80'  CHAIN DATA.                                       01-EQUCC            
                      00040          37+CC       EQU   X'40'  CHAIN COMMAND.                                    01-EQUCC            
                      00020          38+SLI      EQU   X'20'  SUPPRESS INCORRECT LENGTH INDICATION.             01-EQUCC            
                      00010          39+SKIP     EQU   X'10'  SKIP TRANSFER OF DATA.                            01-EQUCC            
                                     41+*                                                                                           
                                     42+**** CSW FLAG EQUATES ****                                                                  
                                     43+*                                                                                           
                                     44+** UNIT STATUS BYTE **                                                                      
                                     45+*                                                                                           
                      00020          46+CUE      EQU   X'20'  CONTROL UNIT END.                                 01-EQUCC            
                      00008          47+CE       EQU   X'08'  CHANNEL END.                                      01-EQUCC            
                      00004          48+DE       EQU   X'04'  DEVICE END.                                       01-EQUCC            
                      00002          49+UC       EQU   X'02'  UNIT CHECK.                                       01-EQUCC            
                      00001          50+UE       EQU   X'01'  UNIT EXCEPTION.                                   01-EQUCC            
                                     51+*                                                                                           
                                     52+** CHANNEL STATUS BYTE **                                                                   
                                     53+*                                                                                           
i                      00040          54+IL       EQU   X'40'  INCORRECT LENGTH.                                 01-EQUCC            
                                                                                                               Page    3            
  Active Usings: None                                                                                                               
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                     56 **********************************************************************                      
                                     57 * CCW MACRO                                                                                 
                                     58 * When invoked, defines storage for a CCW.                                                  
                                     59 **********************************************************************                      
                                     60          MACRO                                                                              
                                     61 &NAME    CCW  &CMD,&BUF,&FLAG,&LEN                                                          
                                     62 &NAME    DC   0D'0',AL1(&CMD),AL3(&BUF),AL1(&FLAG),X'0',AL2(&LEN)                           
                                     63          MEND                                                                               
                                     64 *                                                                                           
                                     65          PRINT NOGEN                                                                        
                                     66          DCBD  DSORG=(BS,PO,PS)                                                             
                                     68+*,***  IHB069  DEVD NOT SPECIFIED-ALL ASSUMED                           02-IHBER            
                                    898          PRINT GEN                                                                          
                                    899 *********************************************************************                       
                                    900 * XDAP                                                                                      
                                    901 * Date: 12/02/2004                                                                          
                                    902 * Brandon Tweed                                                                             
                                    903 * Instructor: Rannie                                                                        
                                    904 * TA: Dash                                                                                  
                                    905 *                                                                                           
                                    906 * Register usage:                                                                           
                                    907 * R7,R8 - Used for progression through parms.                                               
                                    908 *********************************************************************                       
000000                00000 018E4   909 SPXD     CSECT                         Start of SPAM                                        
000000 90EC D00C            0000C   910          STM   14,12,12(13)            Entry Linkage                                        
000004 18CF                         911          LR    12,15                   Entry Linkage                                        
                 R:C  00000         912          USING SPXD,12                 Entry Linkage                                        
000006 41E0 C448            00448   913          LA    14,SPXDSAV              Entry Linkage                                        
00000A 50D0 E004            00004   914          ST    13,4(,14)               Entry Linkage                                        
00000E 50E0 D008            00008   915          ST    14,8(,13)               Entry Linkage                                        
000012 18DE                         916          LR    13,14                   Entry Linkage                                        
000014 5010 C3E0            003E0   917 br         ST    1,PARM@                 Save address of parms                              
                                    918 *                                                                                           
                                    919 * Set Timer                                                                                 
                                    920 *                                                                                           
                                    921          STIMER REAL,TIMEXIT,DINTVL=INTERVAL                                                
                                    923+*        MACDATE = 08/19/88                                        @L1C                     
000018 4110 C440            00440   924+         LA    1,INTERVAL                         LOAD ADDR TIME VALUE  01-STIME            
00001C 41F0 C30A            0030A   925+         LA    15,TIMEXIT                         LOAD EXIT ADDRESS     01-STIME            
000020 4100 00B3            000B3   926+         LA    0,179(0,0)                        LOAD FLAG BYTE         01-STIME            
000024 8900 0018            00018   927+         SLL   0,24(0)                           SHIFT TO HI-ORDER BYTE 01-STIME            
000028 0A2F                         928+         SVC   47                                ISSUE STIMER SVC       01-STIME            
                                    929 *                                                                                           
                                    930 * OPEN all DCBs                                                                             
                                    931 *                                                                                           
                                    932          OPEN  (Q,INPUT,X,INPUT,S,OUTPUT)                                                   
00002A 0700                         933+         CNOP  0,4                          ALIGN LIST TO FULLWORD      01-OPEN             
00002C 4510 C03C            0003C   934+         BAL   1,*+16                       LOAD REG1 W/LIST ADDR. @L2A 01-OPEN             
000030 00                           935+         DC    AL1(0)                       OPTION BYTE                 01-OPEN             
000031 000A94                       936+         DC    AL3(Q)                       DCB ADDRESS                 01-OPEN             
000034 00                           937+         DC    AL1(0)                       OPTION BYTE                 01-OPEN             
000035 000A60                       938+         DC    AL3(X)                       DCB ADDRESS                 01-OPEN             
000038 8F                           939+         DC    AL1(143)                     OPTION BYTE                 01-OPEN             
000039 000B4C                       940+         DC    AL3(S)                       DCB ADDRESS                 01-OPEN             
i00003C 0A13                         941+         SVC   19                           ISSUE OPEN SVC              01-OPEN             
                                                                                                               Page    4            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
00003E 12FF                         942          LTR   15,15                   Test Return Code                                     
000040 4770 C2C4            002C4   943          BNZ   DCBPROB                 If RC!=0 ABEND                                       
000044 9110 CAC4      00AC4         944          TM    Q+X'30',X'10'           Test Q DCB for open                                  
000048 4780 C2C4            002C4   945          BZ    DCBPROB                 If not open, ABEND                                   
00004C 9110 CA90      00A90         946          TM    X+X'30',X'10'           Test B DCB for open                                  
000050 4780 C2C4            002C4   947          BZ    DCBPROB                 If not open, ABEND                                   
000054 9110 CB7C      00B7C         948          TM    S+X'30',X'10'           Test S DCB for open                                  
000058 4780 C2C4            002C4   949          BZ    DCBPROB                 If not open, ABEND                                   
                                    950 *                                                                                           
                                    951 * Locate and print the JCL parms using SNAP                                                 
                                    952 * Postcondition:                                                                            
                                    953 * R8 = @ End of parm data                                                                   
                                    954 * R7 = @ Start of Parm data                                                                 
                                    955 *                                                                                           
00005C 1777                         956          XR    7,7                     Clear 7 (ptr to start data)                          
00005E 1788                         957          XR    8,8                     Clear 8 (ptr to end data)                            
000060 BF77 C3E1            003E1   958          ICM   7,X'7',PARM@+1          Get @ the PARM area                                  
000064 BF77 7001            00001   959          ICM   7,X'7',1(7)             Get @ halfword len                                   
000068 4880 7000            00000   960          LH    8,0(,7)                 Get length of PARM                                   
00006C 4170 7002            00002   961          LA    7,2(,7)                 Get @ actual PARM data                               
000070 1A87                         962          AR    8,7                     Calculate End of Parm                                
                                    963 *                                                                                           
                                    964 * Print out information about JCL parms                                                     
                                    965 *                                                                                           
000072 D231 C52A C94A 0052A 0094A   966          MVC   LINEOUT(50),MSG542      Move XXXI Message to PL                              
000078 45B0 C4F8            004F8   967          BAL   11,WRITELN              Write header for the SNAP                            
                                    968          SNAP  DCB=S,STORAGE=((7),(8)) Dump JCL parms                                       
                                    969+* /* MACDATE Y-1 860219 LAST UPDATED 11/01/85 HBB3310                */                     
00007C                              971+         CNOP  0,4                                                      01-SNAP             
00007C 4510 C0A0            000A0   972+         BAL   1,IHB0007           BRANCH AROUND PARAM LIST             01-SNAP             
000080 00                           973+         DC    AL1(0)              ID NUMBER                            01-SNAP             
000081 72                           974+         DC    AL1(114)            OPTION FLAGS                  Y02705 01-SNAP             
000082 80                           975+         DC    AL1(128)            OPTIONS FLAG 2              @G860P1Y 01-SNAP             
000083 00                           976+         DC    AL1(0)              RESERVED                    @G382P12 01-SNAP             
000084 00                           977+         DC    AL1(0)              SDATA FLAGS ONE               Y02705 01-SNAP             
000085 00                           978+         DC    AL1(0)              SDATA FLAGS TWO              G33SPHW 01-SNAP             
000086 00                           979+         DC    AL1(0)              PDATA FLAGS                   Y02705 01-SNAP             
000087 00                           980+         DC    AL1(0)              RESERVED                      Y02705 01-SNAP             
000088 00000B4C                     981+         DC    A(S)                DCB ADDRESS                          01-SNAP             
00008C 00000000                     982+         DC    A(0)                TCB ADDRESS                          01-SNAP             
000090 00000098                     983+         DC    A(*+8)              ADDR OF SNAP-SHOT LIST      @G860P1Y 01-SNAP             
000094 00000000                     984+         DC    A(0)                ADDRESS OF HEADER LIST       G33SPHW 01-SNAP             
000098 00000000                     985+         DC    A(0)                STARTING/ENDING ADDRESS              01-SNAP             
00009C 00000000                     986+         DC    A(0)                STARTING/ENDING ADDRESS              01-SNAP             
0000A0                              987+IHB0007  DS    0H                                                       01-SNAP             
0000A0 5070 1018            00018   988+         ST    (7),24(0,1)         GET STARTING/ENDING ADDRESS          01-SNAP             
0000A4 5080 101C            0001C   989+         ST    (8),28(0,1)         GET STARTING/ENDING ADDRESS          01-SNAP             
0000A8 9680 101C      0001C         990+         OI    28(1),X'80'         SET END OF LIST INDICATOR     Y02705 01-SNAP             
0000AC 0A33                         991+         SVC   51                                                       01-SNAP             
0000AE 12FF                         992          LTR   15,15                   Check if RC=0                                        
0000B0 45E0 C33E            0033E   993          BAL   14,BNZ#7BDT             If it wasn't SNABEND                                 
                                    994 *                                                                                           
                                    995 * Set up the parm loop                                                                      
                                    996 * R7 = Current position in Parm                                                             
i                                    997 * R8 = End of Parms                                                                         
                                                                                                               Page    5            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                    998 *                                                                                           
0000B4 1978                         999 OUTRLOP  CR    7,8                     Check for end of PARM                                
0000B6 47B0 C288            00288  1000          BNL   FINALQ                  No parms? End program                                
0000BA 4160 C434            00434  1001          LA    6,PARMN                 Get @place to store parm                             
0000BE 9240 C434      00434        1002          MVI   PARMN,X'40'             Initialize first space                               
0000C2 D206 C435 C434 00435 00434  1003          MVC   PARMN+1(7),PARMN        "Ripple" the blank                                   
                                   1004 *                                                                                           
                                   1005 * Get a single parm from list                                                               
                                   1006 *                                                                                           
0000C8 1978                        1007 PARMLOP  CR    7,8                     Check for end of PARM                                
0000CA 47B0 C0E8            000E8  1008          BNL   EOPARM                  yes? goto end of parm                                
0000CE 956B 7000      00000        1009          CLI   0(7),C','               Check for end of a single parm                       
0000D2 4780 C0E8            000E8  1010          BE    EOPARM                  yes -> handle end of parm                            
0000D6 D200 6000 7000 00000 00000  1011          MVC   0(1,6),0(7)             Copy a character of the parm                         
0000DC 4170 7001            00001  1012          LA    7,1(,7)                 Advance in parm list                                 
0000E0 4160 6001            00001  1013          LA    6,1(,6)                 Advance in PARMN                                     
0000E4 47F0 C0C8            000C8  1014          B     PARMLOP                 Continue until parm processed                        
                                   1015 *                                                                                           
                                   1016 * Put name into the BLDL table and check if member                                          
                                   1017 * exists                                                                                    
                                   1018 *                                                                                           
0000E8 D207 CA24 C434 00A24 00434  1019 EOPARM   MVC   BLDLTAB+4(8),PARMN      Put PARM into BLDL table                             
                                   1020          BLDL  X,BLDLTAB               Build BLDL table for 1 entry                         
0000EE 4110 CA60            00A60  1022+         LA    1,X                               LOAD PARAMETER REG 1   02-IHBIN            
0000F2 4100 CA20            00A20  1023+         LA    0,BLDLTAB                         LOAD PARAMETER REG 0   02-IHBIN            
0000F6 4111 0000            00000  1024+         LA    1,0(1)                     CLEAR HIGH ORDER BYTE ZA00734 01-BLDL             
0000FA 1FFF                        1025+         SLR   15,15                     FOR NO OPTION             @L0A 01-BLDL             
0000FC 0A12                        1026+         SVC   18                                LINK TO BLDL ROUTINE   01-BLDL             
0000FE 12FF                        1027          LTR   15,15                   Check RC=0 from BLDL                                 
000100 4770 C2E4            002E4  1028          BNZ   BLDLPROB                If not OK, abend                                     
000104 D203 C3D0 CA2C 003D0 00A2C  1029          MVC   STTTRK(4),BLDLTAB+12    Get TTRK from BLDLTable                              
                                   1030 *                                                                                           
                                   1031 * Snap the BLDL table and the XDAP DCB                                                      
                                   1032 *                                                                                           
00010A D231 C52A C81E 0052A 0081E  1033          MVC   LINEOUT(50),MSG534      Set up the print line                                
000110 45B0 C4F8            004F8  1034          BAL   11,WRITELN              Print the print line                                 
                                   1035          SNAP  DCB=S,STORAGE=(BLDLTAB,Q)  Q marks end of BPAM DCB (B)                       
                                   1036+* /* MACDATE Y-1 860219 LAST UPDATED 11/01/85 HBB3310                */                     
000114                             1038+         CNOP  0,4                                                      01-SNAP             
000114 4510 C138            00138  1039+         BAL   1,IHB0011           BRANCH AROUND PARAM LIST             01-SNAP             
000118 00                          1040+         DC    AL1(0)              ID NUMBER                            01-SNAP             
000119 72                          1041+         DC    AL1(114)            OPTION FLAGS                  Y02705 01-SNAP             
00011A 80                          1042+         DC    AL1(128)            OPTIONS FLAG 2              @G860P1Y 01-SNAP             
00011B 00                          1043+         DC    AL1(0)              RESERVED                    @G382P12 01-SNAP             
00011C 00                          1044+         DC    AL1(0)              SDATA FLAGS ONE               Y02705 01-SNAP             
00011D 00                          1045+         DC    AL1(0)              SDATA FLAGS TWO              G33SPHW 01-SNAP             
00011E 00                          1046+         DC    AL1(0)              PDATA FLAGS                   Y02705 01-SNAP             
00011F 00                          1047+         DC    AL1(0)              RESERVED                      Y02705 01-SNAP             
000120 00000B4C                    1048+         DC    A(S)                DCB ADDRESS                          01-SNAP             
000124 00000000                    1049+         DC    A(0)                TCB ADDRESS                          01-SNAP             
000128 00000130                    1050+         DC    A(*+8)              ADDR OF SNAP-SHOT LIST      @G860P1Y 01-SNAP             
00012C 00000000                    1051+         DC    A(0)                ADDRESS OF HEADER LIST       G33SPHW 01-SNAP             
000130 00000A20                    1052+         DC    A(BLDLTAB)          STORAGE ADDRESS                      01-SNAP             
000134 00000A94                    1053+         DC    A(Q)                STORAGE ADDRESS                      01-SNAP             
i000138                             1054+IHB0011  DS    0H                                                       01-SNAP             
                                                                                                               Page    6            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
000138 9680 101C      0001C        1055+         OI    28(1),X'80'         SET END OF LIST INDICATOR     Y02705 01-SNAP             
00013C 0A33                        1056+         SVC   51                                                       01-SNAP             
00013E 12FF                        1057          LTR   15,15                   Check RC=0 from SNAP                                 
000140 45E0 C33E            0033E  1058          BAL   14,BNZ#7BDT             If Not Zero, SNABEND                                 
                                   1059 *                                                                                           
                                   1060 * Print the name of the member                                                              
                                   1061 *                                                                                           
000144 D231 C52A C850 0052A 00850  1062          MVC   LINEOUT(50),MSG535      Set up print line                                    
00014A D207 C55C C434 0055C 00434  1063          MVC   LINEOUT+50(8),PARMN     Put member name on print line                        
000150 45B0 C4F8            004F8  1064          BAL   11,WRITELN              Print the line                                       
                                   1065 *                                                                                           
                                   1066 * Perform the TTRK to MBBCCHHR conversion on the stored TTRK                                
                                   1067 * First time, processes first track                                                         
                                   1068 * Also used to repeatedly do conversions when needed                                        
                                   1069 *                                                                                           
000154 900F C388            00388  1070 NXTTRACK STM   0,15,MUMSAVE            Save regs from being altered                         
000158 58F0 004C            0004C  1071          L     15,76                   Get @CVT                                             
00015C 58F0 F01C            0001C  1072          L     15,X'1C'(,15)           Get @conversion rtn                                  
000160 BF0F C3D0            003D0  1073          ICM   0,15,STTTRK             Get TTRK -> R0                                       
000164 5810 CA8C            00A8C  1074          L     1,X+X'2C'               Get A(DEB)                                           
000168 4120 C3C8            003C8  1075          LA    2,MBBCCHHR              Get @mumble                                          
00016C 186C                        1076          LR    6,12                    Save R12 (may be altered)                            
00016E 05EF                        1077          BALR  14,15                   BRANCH TO DO CONVERSION                              
000170 18C6                        1078          LR    12,6                    Restore 12 for addressability                        
000172 12FF                        1079          LTR   15,15                   Check return code                                    
000174 4770 C338            00338  1080          BNZ   CONVFAIL                IF NZ then ABEND                                     
000178 D207 C4B8 C3C8 004B8 003C8  1081          MVC   ANECB+X'24'(8),MBBCCHHR Move mumble to IOB+X'20'                             
00017E 5860 C4BC            004BC  1082          L     6,ANECB+X'28'           Get 2nd half of mumble                               
000182 A76A FFFF           FFFFFF  1083          AHI   6,-1                    Decrease R by 1                                      
000186 5060 C4BC            004BC  1084          ST    6,ANECB+X'28'           Put 2nd half back                                    
00018A 980F C388            00388  1085          LM    0,15,MUMSAVE            Restore regs altered                                 
                                   1086 *                                                                                           
                                   1087 * Beginning of physical read (XDAP) loop                                                    
                                   1088 *                                                                                           
00018E                             1089 DOREAD   DS    0H                      Do physical read (XDAP)                              
00018E D703 C494 C494 00494 00494  1090 CLEAR    XC    ANECB(4),ANECB          Clear the ECB                                        
                                   1091 STARTIO  XDAP  ANECB,MF=E              Perform the read                                     
000194                             1092+STARTIO  DS    0H                                                       01-XDAP             
000194 4110 C498            00498  1093+         LA    1,ANECB+4                         LOAD IOB ADDRESS       01-XDAP             
000198 9601 1000      00000        1094+         OI    0(1),X'01'                         SVC ISSUE EXCP Y02072 01-XDAP             
00019C 0A00                        1095+         SVC   0                                  EXCP SVC              01-XDAP             
                                   1096 NOWWAIT  WAIT  ECB=ANECB               Wait until read is done                              
                                   1097+*        MACDATE  10/20/88                                         @01C                     
00019E 4100 0001            00001  1099+NOWWAIT  LA    0,1(0,0)                    COUNT OMITTED,1 USED    @L1C 01-WAIT             
0001A2 4110 C494            00494  1101+         LA    1,ANECB                           LOAD PARAMETER REG 1   02-IHBIN            
0001A6 0A01                        1102+         SVC   1                           LINK TO WAIT ROUTINE    @L1C 01-WAIT             
                                   1103 *        BAL   11,CNVRTN               Convert S# and R# for pline                          
0001A8 91D0 C4A4      004A4        1104          TM    ANECB+X'10',255-CE-CUE-DE-UE-UC  CHECK 4 BAD BITS                            
0001AC 4770 C31A            0031A  1105          BNZ   BADBITS                 If so, ABEND                                         
0001B0 91BF C4A5      004A5        1106          TM    ANECB+X'11',255-IL      Check for incorrect length                           
0001B4 4770 C320            00320  1107          BNZ   ILBIT                   If so, ABEND                                         
0001B8 957F C494      00494        1108          CLI   ANECB,X'7F'             Test W-P                                             
0001BC 4780 C1D8            001D8  1109          BE    CHKCSW                  If '7F' check CSW and move on                        
0001C0 9541 C494      00494        1110          CLI   ANECB,X'41'             Check W-P                                            
i0001C4 4770 C326            00326  1111          BNE   POSTBAD                 If not X'41' Die                                     
                                                                                                               Page    7            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
0001C8 9101 C4A4      004A4        1112          TM    ANECB+16,X'01'          Test for unit exception                              
0001CC 4710 C344            00344  1113          BO    BSEOF                   If unit exception bit, EOF                           
0001D0 9102 C4A4      004A4        1114          TM    ANECB+16,X'02'          Test for unit check                                  
0001D4 4780 C1D8            001D8  1115          BZ    CHKCSW                  If not, check CSW                                    
0001D8                             1116 CHKCSW   DS    0H                      Check CSW (channel program OK)                       
0001D8 4150 C4F0            004F0  1117          LA    5,MYCOUNT               Get @ after last CCW (@MYCOUNT)                      
0001DC 5950 C4A0            004A0  1118          C     5,ANECB+12              Compare two addresses                                
0001E0 4770 C32C            0032C  1119          BNE   CSWNE                   If not equal, ABEND                                  
                                   1120 *                                                                                           
                                   1121 * Now test if R in mumble from IOB is greater than                                          
                                   1122 * R in the count field of the next record read in by CCW5.                                  
                                   1123 *                                                                                           
0001E4 D500 C4BF C4F4 004BF 004F4  1124          CLC   ANECB+X'2B'(1),MYCOUNT+4  Compare R in mumble vs 8 byte                      
0001EA 47D0 C1FA            001FA  1125          BNH   RPLUS1                    If Rm > R8b, new track                             
0001EE 9501 C4F4      004F4        1126          CLI   MYCOUNT+4,X'01'           Check Rs                                           
0001F2 4780 C2A0            002A0  1127          BE    EOT                     If the same, then track change                       
0001F6 47F0 C332            00332  1128          B     RSNE                    If not, something wrong, die                         
0001FA 5860 C4BC            004BC  1129 RPLUS1   L     6,ANECB+X'28'           Get 2nd half of mumble                               
0001FE A76A 0001            00001  1130          AHI   6,1                     Increment R by 1                                     
000202 5060 C4BC            004BC  1131          ST    6,ANECB+X'28'           Save 2nd half mumble                                 
000206 D504 CC4D C3D8 00C4D 003D8  1132          CLC   BUFFER+9(5),ISMACRO     Do the check                                         
00020C 4770 C214            00214  1133          BNE   NOPAGE                  If not 'MACRO' no new page                           
000210 92F1 C788      00788        1134          MVI   MSG531,C'1'             Set CC for new page                                  
000214 4850 C4F6            004F6  1135 NOPAGE   LH    5,MYCOUNT+6             Get max block size                                   
000218 4160 0050            00050  1136          LA    6,80                    Get Logical Rec Size                                 
00021C 4140 CC44            00C44  1137          LA    4,BUFFER                Get address XDAP buffer                              
000220 D24F CBA4 4000 00BA4 00000  1138 CORELOOP MVC   BSBUFF(80),0(4)         Copy 80 bytes from Big buffer                        
                                   1139          GET   Q,QSBUFF                Do QSAM read                                         
000226 4110 CA94            00A94  1141+         LA    1,Q                               LOAD PARAMETER REG 1   02-IHBIN            
00022A 4100 CBF4            00BF4  1142+         LA    0,QSBUFF                          LOAD PARAMETER REG 0   02-IHBIN            
00022E 1FFF                        1143+         SLR   15,15                    CLEAR REGISTER             @L1A 01-GET              
000230 BFF7 1031            00031  1144+         ICM   15,7,49(1)               LOAD GET ROUTINE ADDR      @L1C 01-GET              
000234 05EF                        1145+         BALR  14,15                    LINK TO GET ROUTINE             01-GET              
000236 47F0 C23E            0023E  1146          B     GOON2                   If not EOF, continue                                 
00023A 47F0 C352            00352  1147          B     QSEOF                   If QSAM EOF, do EOF stuff                            
00023E D54F CBF4 CBA4 00BF4 00BA4  1148 GOON2    CLC   QSBUFF(80),BSBUFF       Compare buffer contents                              
000244 45E0 C33E            0033E  1149          BAL   14,BNE#7BDT             If not Same, SNABEND                                 
000248 45B0 C5B0            005B0  1150          BAL   11,CNVRTN               Call conversion routine                              
00024C D231 C52A C788 0052A 00788  1151          MVC   LINEOUT(50),MSG531      Copy MSG531 to print line                            
000252 D201 C550 C3D4 00550 003D4  1152          MVC   LINEOUT+38(2),PLS       Put Sector # on print line                           
000258 D201 C556 C3D6 00556 003D6  1153          MVC   LINEOUT+44(2),PLR       Put Record # on print line                           
00025E D24F C55C CBA4 0055C 00BA4  1154          MVC   LINEOUT+50(80),BSBUFF   Copy buffer contents to pline                        
000264 45B0 C4F8            004F8  1155          BAL   11,WRITELN              Call print routine                                   
000268 9240 C788      00788        1156          MVI   MSG531,C' '             Insert single space                                  
00026C 4146 4000            00000  1157          LA    4,0(6,4)                Move forward in buffer                               
000270 1B56                        1158          SR    5,6                     Decrement # bytes                                    
000272 1255                        1159          LTR   5,5                     More records?                                        
000274 4720 C220            00220  1160          BP    CORELOOP                Yes, loop again.                                     
                                   1161 *                                                                                           
                                   1162 * At this point the physical buffer is exhausted, read next block                           
                                   1163 *                                                                                           
000278 92F0 C788      00788        1164          MVI   MSG531,C'0'             D.S. between physical records                        
00027C 47F0 C18E            0018E  1165          B     DOREAD                  Hit this point? READ another one                     
                                   1166 *                                                                                           
i                                   1167 * Loop, grap new parm, read another member                                                  
                                                                                                               Page    8            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                   1168 *                                                                                           
000280 A77A 0001            00001  1169 NXTPRM   AHI   7,1                     Move past ',' in parm list                           
000284 47F0 C0B4            000B4  1170          B     OUTRLOP                 Redo the whole shebang                               
                                   1171 **********************************************************************                      
                                   1172 * THIS DOES THE FINAL QSAM READ                                                             
                                   1173 **********************************************************************                      
                                   1174 FINALQ   GET   Q,QSBUFF                Get another QSAM logical record                      
000288 4110 CA94            00A94  1176+FINALQ   LA    1,Q                               LOAD PARAMETER REG 1   02-IHBIN            
00028C 4100 CBF4            00BF4  1177+         LA    0,QSBUFF                          LOAD PARAMETER REG 0   02-IHBIN            
000290 1FFF                        1178+         SLR   15,15                    CLEAR REGISTER             @L1A 01-GET              
000292 BFF7 1031            00031  1179+         ICM   15,7,49(1)               LOAD GET ROUTINE ADDR      @L1C 01-GET              
000296 05EF                        1180+         BALR  14,15                    LINK TO GET ROUTINE             01-GET              
000298 47F0 C2D4            002D4  1181          B     QSPROB                  Not EOF? QSAM problem                                
00029C 47F0 C352            00352  1182          B     QSEOF                   EOF, handle QSAM EOF                                 
                                   1183 **********************************************************************                      
                                   1184 * END OF TRACK PROCESSING (EOT)                                                             
                                   1185 *                                                                                           
                                   1186 * Do *NOT* modify registers 7 or 8!                                                         
                                   1187 *                                                                                           
                                   1188 * Accounts for a change of track                                                            
                                   1189 **********************************************************************                      
0002A0                             1190 EOT      DS    0H                      END OF TRACK PROCESSING                              
0002A0 1766                        1191          XR    6,6                     Zero register 6                                      
0002A2 BF63 C3D0            003D0  1192          ICM   6,3,STTTRK              Get saved TTRK                                       
0002A6 4160 6001            00001  1193          LA    6,1(,6)                 TT = TT + 1                                          
0002AA BE63 C3D0            003D0  1194          STCM  6,3,STTTRK              Save incremented TTRK                                
0002AE 1766                        1195          XR    6,6                     Zero R6                                              
0002B0 A768 0001            00001  1196          LHI   6,1                     Set R6 to 1                                          
0002B4 4260 C3D2            003D2  1197          STC   6,STTTRK+2              Set R to 1                                           
0002B8 9200 C386      00386        1198          MVI   SECTOR,X'00'            Set sector to X'00'                                  
0002BC 9260 C788      00788        1199          MVI   MSG531,C'-'             Set CC for new track                                 
0002C0 47F0 C154            00154  1200          B     NXTTRACK                Now process updated TTRK                             
                                   1201 *                                                                                           
                                   1202 * ABENDs for problems encountered in testing                                                
                                   1203 *                                                                                           
                                   1204 DCBPROB  ABEND 897,DUMP      Problem opening DCBs, DUMP                                     
0002C4                             1205+DCBPROB  DS    0H                                                       01-ABEND            
0002C4 4110 0381            00381  1208+         LA    1,897                             LOAD PARAMETER REG 1   02-IHBIN            
0002C8 4100 0080            00080  1209+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
0002CC 8900 0018            00018  1210+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
0002D0 1610                        1211+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
0002D2 0A0D                        1212+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
                                   1213 QSPROB   ABEND 897,DUMP      Dump if QSAM doesn't hit EOF                                   
0002D4                             1214+QSPROB   DS    0H                                                       01-ABEND            
0002D4 4110 0381            00381  1217+         LA    1,897                             LOAD PARAMETER REG 1   02-IHBIN            
0002D8 4100 0080            00080  1218+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
0002DC 8900 0018            00018  1219+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
0002E0 1610                        1220+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
0002E2 0A0D                        1221+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
0002E4 05E0                        1222 BLDLPROB BALR  14,0          abbreviate dumps for BLDL problem                              
0002E6 47F0 C6E0            006E0  1223          B     SNABEND       call SNABEND routine                                           
                                   1224          ABEND 897,DUMP      Dump if BLDL screwed up                                        
0002EA                             1225+         DS    0H                                                       01-ABEND            
0002EA 4110 0381            00381  1228+         LA    1,897                             LOAD PARAMETER REG 1   02-IHBIN            
i0002EE 4100 0080            00080  1229+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
                                                                                                               Page    9            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
0002F2 8900 0018            00018  1230+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
0002F6 1610                        1231+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
0002F8 0A0D                        1232+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
                                   1233 GENABN   ABEND 987,DUMP      Die a horrible death                                           
0002FA                             1234+GENABN   DS    0H                                                       01-ABEND            
0002FA 4110 03DB            003DB  1237+         LA    1,987                             LOAD PARAMETER REG 1   02-IHBIN            
0002FE 4100 0080            00080  1238+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
000302 8900 0018            00018  1239+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
000306 1610                        1240+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
000308 0A0D                        1241+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
                                   1242 TIMEXIT  ABEND 798,DUMP      Timer Exit Routine Induces Dump                                
00030A                             1243+TIMEXIT  DS    0H                                                       01-ABEND            
00030A 4110 031E            0031E  1246+         LA    1,798                             LOAD PARAMETER REG 1   02-IHBIN            
00030E 4100 0080            00080  1247+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
000312 8900 0018            00018  1248+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
000316 1610                        1249+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
000318 0A0D                        1250+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
00031A 05E0                        1251 BADBITS  BALR  14,0          Die if bad bits                                                
00031C 47F0 C6E0            006E0  1252          B     SNABEND                                                                      
000320 05E0                        1253 ILBIT    BALR  14,0          Die if Incorrect length                                        
000322 47F0 C6E0            006E0  1254          B     SNABEND                                                                      
000326 05E0                        1255 POSTBAD  BALR  14,0          Die if post code not 7F or 41                                  
000328 47F0 C6E0            006E0  1256          B     SNABEND                                                                      
00032C 05E0                        1257 CSWNE    BALR  14,0          CCW @ and CSW @ not equal                                      
00032E 47F0 C6E0            006E0  1258          B     SNABEND                                                                      
000332 05E0                        1259 RSNE     BALR  14,0          Die if Rs not equal or R1 > R2                                 
000334 47F0 C6E0            006E0  1260          B     SNABEND                                                                      
000338 05E0                        1261 CONVFAIL BALR  14,0          Die if mumble conversion failed                                
00033A 47F0 C6E0            006E0  1262          B     SNABEND                                                                      
                                   1263 *                                                                                           
                                   1264 * R14 Error Tracking Stubs                                                                  
                                   1265 *                                                                                           
                      0033E        1266 BNE#7BDT EQU   BNZ#7BDT      BNE and BNZ are the same                                       
00033E 4770 C6E0            006E0  1267 BNZ#7BDT BNZ   SNABEND       Go to SNABEND Routine if zero                                  
000342 07FE                        1268          BR    14            Otherwise Go back                                              
                                   1269 *                                                                                           
                                   1270 * BSAM End of File routine                                                                  
                                   1271 *                                                                                           
000344 D231 C52A C7EC 0052A 007EC  1272 BSEOF    MVC   LINEOUT(50),MSG533      Move message 533I to PL                              
00034A 45B0 C4F8            004F8  1273          BAL   11,WRITELN              Print the message                                    
00034E 47F0 C280            00280  1274          B     NXTPRM                  End of BSAM means end of QSAM                        
                                   1275 *                                                                                           
                                   1276 * QSAM End of File routine                                                                  
                                   1277 *                                                                                           
000352 D231 C52A C7BA 0052A 007BA  1278 QSEOF    MVC   LINEOUT(50),MSG532      Move QS EOF message to PL                            
000358 45B0 C4F8            004F8  1279          BAL   11,WRITELN              Print the message                                    
00035C D231 C52A C8B4 0052A 008B4  1280          MVC   LINEOUT(50),MSG539      Move message 539I to PL                              
000362 45B0 C4F8            004F8  1281          BAL   11,WRITELN              Print the message                                    
000366 47F0 C6E0            006E0  1282          B     SNABEND                 End of QSAM = done, end pgm                          
                                   1283 *                                                                                           
                                   1284 * If member not found in PDS, print error message                                           
                                   1285 * and move to next parm                                                                     
                                   1286 *                                                                                           
00036A D231 C52A C8E6 0052A 008E6  1287 MNOTFND  MVC   LINEOUT(50),MSG540      Move 'not found' msg to pl                           
i000370 D207 C55C CA24 0055C 00A24  1288          MVC   LINEOUT+50(8),BLDLTAB+4 Put member name on PL                                
                                                                                                               Page   10            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
000376 45B0 C4F8            004F8  1289          BAL   11,WRITELN              Print the message                                    
00037A 47F0 C280            00280  1290          B     NXTPRM                  Process next parm                                    
                                   1291 *                                                                                           
                                   1292 * EOF Routines for DCBs                                                                     
                                   1293 *                                                                                           
00037E 47F0 E004            00004  1294 QEODAD   B     4(,14)        Return to following instruction                                
                                   1295 *                                                                                           
                                   1296 *********************************************************************                       
                                   1297 * SPXD WORKING STORAGE                                                                      
                                   1298 *********************************************************************                       
                                   1299 *                                                                                           
000382 0050                        1300 RECSIZE  DC    H'0080'       Record size of 80                                              
000384 0C80                        1301 BLKSIZE  DC    H'3200'       Size of the physical block                                     
000386 FF                          1302 SECTOR   DC    X'FF'         Sector information                                             
000387 00                                                                                                                           
000388 0000000000000000            1303 MUMSAVE  DC    16F'0'        Save area for MUMBLE conversion rtn                            
0003C8 0000000000000000            1304 MBBCCHHR DC    D'0'          Place for storing the mumble                                   
0003D0 00000000                    1305 STTTRK   DC    F'0'          STORED TTRK FROM BLDL                                          
0003D4 0000                        1306 PLS      DC    XL2'0'        Sector # for print line                                        
0003D6 0000                        1307 PLR      DC    XL2'0'        Record # for print line                                        
0003D8 D4C1C3D9D6                  1308 ISMACRO  DC    CL5'MACRO'    For checking if new MACRO                                      
0003DD 000000                                                                                                                       
0003E0 00000000                    1309 PARM@    DC    F'0'          Address of incoming PARMs                                      
0003E4 4040404040404040            1310 PARMCARD DC    CL80' '       Incoming PARMs for program (copy)                              
000434 4040404040404040            1311 PARMN    DC    CL8' '        Info on parm card between commas                               
00043C 00000020                    1312 VAL32    DC    F'32'         For subtracting                                                
000440 0000000000000000            1313 INTERVAL DC    D'0'          Double word for time Interval                                  
000448                00448 00440  1314          ORG   INTERVAL      Redefine INTERVAL                                              
000440 F0F0F0F1F0F0F0C0            1315          DC    ZL8'00010000' HHMMSSth (1 minute)                                            
000448 FFFFFFFFFFFFFFFF            1316 SPXDSAV  DC    18F'-1'       Spam Save Area                                                 
                                   1317 *                                                                                           
                                   1318 XDAPMF#L XDAP  ANECB,RI,X,,,(),,SECTOR,MF=L                                                 
000490 07000700                    1319+         CNOP  4,8                                                      01-XDAP             
                      00494        1320+XDAPMF#L EQU   *                                                        01-XDAP             
000494 00000000                    1321+ANECB    DC    1F'0'                             EVENT CONTROL BLOCK    01-XDAP             
000498 42                          1322+         DC    X'42'                              IOB START FLAG        01-XDAP             
000499 00000000                    1323+         DC    X'00000000'                                              01-XDAP             
00049D 000494                      1324+         DC    AL3(ANECB)                         ECB ADDRESS           01-XDAP             
0004A0 0000000000000000            1325+         DC    2F'0'                              3RD WORD              01-XDAP             
0004A8 00                          1326+         DC    X'00'                              4TH WORD START        01-XDAP             
0004A9 0004C0                      1327+         DC    AL3(ANECB+44)                     CCW1 ADDRESS           01-XDAP             
0004AC 00                          1328+         DC    X'00'                                                    01-XDAP             
0004AD 000A60                      1329+         DC    AL3(X)                             DCB ADDRESS           01-XDAP             
0004B0 0000000000000000            1330+         DC    2F'0'                              FIFTH DOUBLE WORD     01-XDAP             
0004B8 0000000000000000            1331+IHB0036  DC    2F'0'                              BLKREF FIELD          01-XDAP             
0004C0 2300038640000001            1332+         DC    X'23',AL3(SECTOR),X'40000001'  SET SECTOR        S20201  01-XDAP             
0004C8 31                          1333+IHB0036A DC    X'31'                              SET OPCODE IN CCW-1   01-XDAP             
0004C9 0004BB                      1334+         DC    AL3(IHB0036+3)                     SET UP IOBSEEK+3      01-XDAP             
0004CC 40                          1335+         DC    X'40'                              FLAG BYTE             01-XDAP             
0004CD 00                          1336+         DC    X'00'                                                    01-XDAP             
0004CE 0005                        1337+         DC    H'05'                              SET UP COUNT FIELD    01-XDAP             
0004D0 08                          1338+         DC    X'08'                              CCW2                  01-XDAP             
0004D1 0004C8                      1339+         DC    AL3(IHB0036A)                                            01-XDAP             
0004D4 00000000                    1340+         DC    X'00000000'                        2ND WD IN CCW2        01-XDAP             
i0004D8 0E                          1341+         DC    AL1(14)                           CCW3 OPCODE            01-XDAP             
                                                                                                               Page   11            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
0004D9 000000                      1342+         DC    AL3(0)                                                   01-XDAP             
0004DC 00                          1343+         DC    X'00'                              FLAG BYTE IN CCW3     01-XDAP             
0004DD 00                          1344+         DC    X'00'                                                    01-XDAP             
0004DE 0000                        1345+         DC    X'0000'                           NO LENGTH SPECIFIED    01-XDAP             
                                   1346 *                                                                                           
                                   1347 * Appended CCWs follow                                                                      
                                   1348 *********************************************************************                       
0004E0                004E0 004D8  1349          ORG   *-8           Redefine starting with 3rd CCW                                 
                                   1350 *                                                                                           
                                   1351 CCW3     CCW   X'1E',MYCOUNT,X'80',8   Redefined CCW3                                       
0004D8 1E0004F080000008            1352+CCW3     DC   0D'0',AL1(X'1E'),AL3(MYCOUNT),AL1(X'80'),X'0',AL2(8)      01-00062            
                                   1353 CCW4     CCW   0,BUFFER,X'60',3200     Appended CCW4                                        
0004E0 00000C4460000C80            1354+CCW4     DC   0D'0',AL1(0),AL3(BUFFER),AL1(X'60'),X'0',AL2(3200)        01-00062            
                                   1355 CCW5     CCW   X'22',SECTOR,0,1        Appended CCW5                                        
0004E8 2200038600000001            1356+CCW5     DC   0D'0',AL1(X'22'),AL3(SECTOR),AL1(0),X'0',AL2(1)           01-00062            
                                   1357 *                                                                                           
i0004F0 0000000000000000            1358 MYCOUNT  DC    D'0'          My 8 byte count field                                          
                                                                                                               Page   12            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                   1360 *********************************************************************                       
                                   1361 * WRITELN - WRITE THE HEADER                                                                
                                   1362 *                                                                                           
                                   1363 * Since W DCB is no longer being used, prints out using XPRNT                               
                                   1364 *********************************************************************                       
                                   1365 *                                                                                           
0004F8                             1366 WRITELN  DS   0H                       WRITELN routine start                                
                                   1367          XPRNT LINEOUT,133             Print the damned output                              
0004F8 90E0 C50C            0050C  1369+         STM   14,0,XX0041R+4          SAVE REGS WHICH WILL BE CHANGED  02-XIONR            
0004FC 4100 C52A            0052A  1370+         LA    0,LINEOUT                                                02-XIONR            
000500 58F0 C508            00508  1371+         L     15,XX0041R          GET BRANCH ADDRESS                   02-XIONR            
000504 0700                        1372+         CNOP  2,4                 ADJUST FOR RIGHT ALIGNMENT           02-XIONR            
000506 05EF                        1373+         BALR  14,15               CALL ROUTINE, R14==> CONTROL BLOCK   02-XIONR            
000508 00000000                    1374+XX0041R     DC V(XXXXPRNT)         ROUTINE ADDRESS                      02-XIONR            
00050C                             1375+         DS    3F                  SAVE SPACE FOR REGS 14-0             02-XIONR            
000518 0085                        1376+         DC    AL2(133)            LENGTH OF AREA                       02-XIONR            
00051A 98E0 E004            00004  1377+         LM    14,0,4(14)          RESTORE REGS. CON CODE ALREADY DONE  02-XIONR            
00051E 9240 C52A      0052A        1378          MVI   LINEOUT,X'40'           Set CC for line buffer                               
000522 D283 C52B C52A 0052B 0052A  1379          MVC   LINEOUT+1(132),LINEOUT  Blank the line buffer                                
000528 07FB                        1380          BR    11                      Return from write routine                            
                                   1381 *                                                                                           
00052A 4040404040404040            1382 LINEOUT  DC    CL133' '                Output buffer (for printing)                         
                                   1383 *                                                                                           
                                   1384 *********************************************************************                       
                                   1385 * CNVRTN                                                                                    
                                   1386 * Routine for converting Rec # and Sect # to display format and                             
                                   1387 * putting them on the print line                                                            
                                   1388 *                                                                                           
                                   1389 * Precondition: SECTOR Contains a Sector #                                                  
                                   1390 *               Record number is in ANECB+X'2B'                                             
                                   1391 *               (most recently used MBBCCHHR)                                               
                                   1392 *                                                                                           
                                   1393 *********************************************************************                       
                                   1394 *                                                                                           
0005AF 00                                                                                                                           
0005B0 F321 C6D6 C4BF 006D6 004BF  1395 CNVRTN   UNPK  TMPUNPK(3),ANECB+X'2B'(2) Unpack R                                           
0005B6 D201 C3D6 C6D6 003D6 006D6  1396          MVC   PLR(2),TMPUNPK          Move it to print line                                
0005BC DC01 C3D6 C5D6 003D6 005D6  1397          TR    PLR(2),TRANSL           Translate to make printable                          
0005C2 F321 C6D9 C386 006D9 00386  1398          UNPK  TMPUNPK2(3),SECTOR(2)   Unpack Sector #                                      
0005C8 D201 C3D4 C6D9 003D4 006D9  1399          MVC   PLS(2),TMPUNPK2         Move it to print line                                
0005CE DC01 C3D4 C5D6 003D4 005D6  1400          TR    PLS(2),TRANSL           Translate to make printable                          
0005D4 07FB                        1401          BR    11                      Return to hell                                       
                                   1402 **********************************************************************                      
                                   1403 * CNVRTN WORKING STORAGE                                                                    
                                   1404 **********************************************************************                      
0005D6 4040404040404040            1405 TRANSL   DC    256C' '                 256 bytes of wastes space                            
0006D6                006D6 006C6  1406          ORG   TRANSL+X'F0'            Go to first position in table                        
0006C6 F0F1F2F3F4F5F6F7            1407          DC    C'0123456789ABCDEF'     wasted space actually used                           
0006D6 000000                      1408 TMPUNPK  DC    XL3'000000'             For unpacking stuff                                  
i0006D9 000000                      1409 TMPUNPK2 DC    XL3'000000'             2nd place for unpacking                              
                                                                                                               Page   13            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                   1411 *********************************************************************                       
                                   1412 * SNABEND ROUTINE                                                                           
                                   1413 *                                                                                           
                                   1414 * Save all the registers                                                                    
                                   1415 * Do an XSNAP of the XDAP program                                                           
                                   1416 * Terminate program via SVC 3                                                               
                                   1417 *                                                                                           
                                   1418 *********************************************************************                       
                                   1419 *                                                                                           
0006DC                006DC 006E0  1420          ORG   SPXD+((*-SPXD+31)/32*32) Al		ign 32n                                         
0006E0 900F C728            00728  1421 SNABEND  STM   0,15,SNABSAVE      Save all registers                                        
                                   1422          SNAP  DCB=S,STORAGE=(SPXD,SPXDEND),PDATA=(PSW,REGS,SA),       X                    
                                                       SDATA=(DM,IO)                                                                
                                   1423+* /* MACDATE Y-1 860219 LAST UPDATED 11/01/85 HBB3310                */                     
0006E4                             1425+         CNOP  0,4                                                      01-SNAP             
0006E4 4510 C708            00708  1426+         BAL   1,IHB0042           BRANCH AROUND PARAM LIST             01-SNAP             
0006E8 00                          1427+         DC    AL1(0)              ID NUMBER                            01-SNAP             
0006E9 72                          1428+         DC    AL1(114)            OPTION FLAGS                  Y02705 01-SNAP             
0006EA 80                          1429+         DC    AL1(128)            OPTIONS FLAG 2              @G860P1Y 01-SNAP             
0006EB 00                          1430+         DC    AL1(0)              RESERVED                    @G382P12 01-SNAP             
0006EC 01                          1431+         DC    AL1(1)              SDATA FLAGS ONE               Y02705 01-SNAP             
0006ED 80                          1432+         DC    AL1(128)            SDATA FLAGS TWO              G33SPHW 01-SNAP             
0006EE A4                          1433+         DC    AL1(164)            PDATA FLAGS                   Y02705 01-SNAP             
0006EF 00                          1434+         DC    AL1(0)              RESERVED                      Y02705 01-SNAP             
0006F0 00000B4C                    1435+         DC    A(S)                DCB ADDRESS                          01-SNAP             
0006F4 00000000                    1436+         DC    A(0)                TCB ADDRESS                          01-SNAP             
0006F8 00000700                    1437+         DC    A(*+8)              ADDR OF SNAP-SHOT LIST      @G860P1Y 01-SNAP             
0006FC 00000000                    1438+         DC    A(0)                ADDRESS OF HEADER LIST       G33SPHW 01-SNAP             
000700 00000000                    1439+         DC    A(SPXD)             STORAGE ADDRESS                      01-SNAP             
000704 000018C4                    1440+         DC    A(SPXDEND)          STORAGE ADDRESS                      01-SNAP             
000708                             1441+IHB0042  DS    0H                                                       01-SNAP             
000708 9680 101C      0001C        1442+         OI    28(1),X'80'         SET END OF LIST INDICATOR     Y02705 01-SNAP             
00070C 0A33                        1443+         SVC   51                                                       01-SNAP             
00070E 12FF                        1444          LTR   15,15              Test SNAP RC                                              
000710 4770 C716            00716  1445          BNZ   ABN4095            If not zero, dump                                         
000714 0A03                        1446          SVC   3                  Else, terminate using SVC 3                               
                                   1447 ABN4095  ABEND 4095,DUMP          ABEND inside SNABEND                                      
000716                             1448+ABN4095  DS    0H                                                       01-ABEND            
000716 4110 0FFF            00FFF  1451+         LA    1,4095                            LOAD PARAMETER REG 1   02-IHBIN            
00071A 4100 0080            00080  1452+         LA    0,128(0,0)         DUMP/STEP/DUMPOPTS/REASON    @G860P1F 01-ABEND            
00071E 8900 0018            00018  1453+         SLL   0,24(0)            SHIFT TO HIGH ORDER                   01-ABEND            
000722 1610                        1454+         OR    1,0                OR IN WITH COMPCODE                   01-ABEND            
000724 0A0D                        1455+         SVC   13                 LINK TO ABEND ROUTINE                 01-ABEND            
                                   1456 *                                                                                           
                                   1457 *********************************************************************                       
                                   1458 * SNABEND WORKING STORAGE                                                                   
                                   1459 *********************************************************************                       
                                   1460 *                                                                                           
000726 0000                                                                                                                         
000728 FFFFFFA8FFFFFFA8            1461 SNABSAVE DC    16F'-88'      Save area for SNABEND                                          
000768 E2D5C1C2E2C1E5C5            1462          DC    CL32'SNABSAVE SAVE AREA ABOVE'  Label SNABSAVE                               
                                   1463 *                                                                                           
                                   1464 *********************************************************************                       
                                   1465 * Output Messages                                                                           
i                                   1466 *********************************************************************                       
                                                                                                               Page   14            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
                                   1467 *                                                                                           
000788 60E7C4C1D740C2C4            1468 MSG531   DC    CL50'-XDAP BDT531I The XDAP record is:  S#:   R#:      '                     
0007BA 60E7C4C1D740C2C4            1469 MSG532   DC    CL50'-XDAP BDT532I EOF Encountered on QSAM file.       '                     
0007EC 60E7C4C1D740C2C4            1470 MSG533   DC    CL50'-XDAP BDT533I EOF Encountered on SPAM file.       '                     
00081E 60E7C4C1D740C2C4            1471 MSG534   DC    CL50'-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:    '                     
000850 60E7C4C1D740C2C4            1472 MSG535   DC    CL50'-XDAP BDT535I Member name used in FIND/BLDL is:   '                     
000882 60E7C4C1D740C2C4            1473 MSG538   DC    CL50'-XDAP BDT538I SNAP dump of PARMs for subpool 0:   '                     
0008B4 60E7C4C1D740C2C4            1474 MSG539   DC    CL50'-XDAP BDT539I Pgm complete, SNAP dump follows:    '                     
0008E6 60E7C4C1D740C2C4            1475 MSG540   DC    CL50'-XDAP BDT540I Non-existing FIND name is:          '                     
000918 60E7C4C1D740C2C4            1476 MSG541   DC    CL50'-XDAP BDT541I SNAP of Lowmem, CVT, SVCFLIH, TCB:  '                     
00094A 60E7C4C1D740C2C4            1477 MSG542   DC    CL50'-XDAP BDT542I GPARM given for pgm:'                                     
00097C 60E7C4C1D740C2C4            1478 MSG543   DC    CL50'-XDAP BDT542I Not defined'                                              
0009AE 60E7C4C1D740C2C4            1479 MSG544   DC    CL50'-XDAP BDT544I Not defined'                                              
0009E0 60E7C4C1D740C2C4            1480 MSG545   DC    CL50'-XDAP BDT545I Not defined'                                              
                                   1481 *                                                                                           
                                   1482 *********************************************************************                       
                                   1483 * A BLDL Table set up to accommodate                                                        
                                   1484 * 1 Entry in the list ( H'1' )                                                              
                                   1485 * Length of 60 bytes for each entry ( H'60' )                                               
                                   1486 * 60 bytes allocated for:                                                                   
                                   1487 * NAME   - 8 bytes                                                                          
                                   1488 * TTRKZC - 6 bytes                                                                          
                                   1489 * 46 bytes of 'User Space'                                                                  
                                   1490 *********************************************************************                       
                                   1491 *                                                                                           
000A12                00A12 00A20  1492          ORG   SPXD+((*-SPXD+31)/32*32)     Align 32n                                       
000A20 0001003CF0404040            1493 BLDLTAB  DC    H'1',H'60',CL60'0'           Table for BLDL                                  
                                   1494 *                                                                                           
                                   1495 *********************************************************************                       
                                   1496 * DCBs                                                                                      
                                   1497 *                                                                                           
                                   1498 * X - DCB for use with XDAP                                                                 
                                   1499 * Q - DCB for use with QSAM                                                                 
                                   1500 * W - output DCB                                                                            
                                   1501 *                                                                                           
                                   1502 *********************************************************************                       
                                   1503 *                                                                                           
                                   1504 X        DCB   DSORG=PO,MACRF=E,DDNAME=LIBFILE                                              
                                   1507+*                       DATA CONTROL BLOCK                                                  
                                   1508+*                                                                                           
000A60                             1509+X        DC    0F'0'          ORIGIN ON WORD BOUNDARY                   01-DCB              
                                   1510+*                       DIRECT ACCESS DEVICE INTERFACE                                      
000A60 0000000000000000            1511+         DC    BL16'0'        FDAD, DVTBL                               01-DCB              
000A70 00000000                    1512+         DC    A(0)           KEYLEN, DEVT, TRBAL                       01-DCB              
                                   1513+*                       COMMON ACCESS METHOD INTERFACE                                      
000A74 00                          1514+         DC    AL1(0)         BUFNO, NUMBER OF BUFFERS                  01-DCB              
000A75 000001                      1515+         DC    AL3(1)         BUFCB, BUFFER POOL CONTROL BLOCK          01-DCB              
000A78 0000                        1516+         DC    AL2(0)         BUFL, BUFFER LENGTH                       01-DCB              
000A7A 0200                        1517+         DC    BL2'0000001000000000' DSORG, DATA SET ORGANIZATION       01-DCB              
000A7C 00000001                    1518+         DC    A(1)           IOBAD FOR EXCP OR RESERVED                01-DCB              
                                   1519+*                       FOUNDATION EXTENSION                                                
000A80 00                          1520+         DC    BL1'00000000'  BFTEK, BFALN, DCBE INDICATORS             01-DCB              
000A81 000001                      1521+         DC    AL3(1)         EODAD (END OF DATA ROUTINE ADDRESS)       01-DCB              
i000A84 00                          1522+         DC    BL1'00000000'  RECFM (RECORD FORMAT)                     01-DCB              
                                                                                                               Page   15            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
000A85 000000                      1523+         DC    AL3(0)         EXLST (EXIT LIST ADDRESS)                 01-DCB              
                                   1524+*                       FOUNDATION BLOCK                                                    
000A88 D3C9C2C6C9D3C540            1525+         DC    CL8'LIBFILE'   DDNAME                                    01-DCB              
000A90 02                          1526+         DC    BL1'00000010'  OFLGS (OPEN FLAGS)                        01-DCB              
000A91 00                          1527+         DC    BL1'00000000'  IFLGS (IOS FLAGS)                         01-DCB              
000A92 D008                        1528+         DC    BL2'1101000000001000' MACR (MACRO FORMAT)                01-DCB              
                                   1530 Q        DCB   DSORG=PS,MACRF=GM,EODAD=QEODAD,DDNAME=SEQFILE,BUFNO=3                        
                                   1533+*                       DATA CONTROL BLOCK                                                  
                                   1534+*                                                                                           
000A94                             1535+Q        DC    0F'0'          ORIGIN ON WORD BOUNDARY                   01-DCB              
                                   1536+*                       DIRECT ACCESS DEVICE INTERFACE                                      
000A94 0000000000000000            1537+         DC    BL16'0'        FDAD, DVTBL                               01-DCB              
000AA4 00000000                    1538+         DC    A(0)           KEYLEN, DEVT, TRBAL                       01-DCB              
                                   1539+*                       COMMON ACCESS METHOD INTERFACE                                      
000AA8 03                          1540+         DC    AL1(3)         BUFNO, NUMBER OF BUFFERS                  01-DCB              
000AA9 000001                      1541+         DC    AL3(1)         BUFCB, BUFFER POOL CONTROL BLOCK          01-DCB              
000AAC 0000                        1542+         DC    AL2(0)         BUFL, BUFFER LENGTH                       01-DCB              
000AAE 4000                        1543+         DC    BL2'0100000000000000' DSORG, DATA SET ORGANIZATION       01-DCB              
000AB0 00000001                    1544+         DC    A(1)           IOBAD FOR EXCP OR RESERVED                01-DCB              
                                   1545+*                       FOUNDATION EXTENSION                                                
000AB4 00                          1546+         DC    BL1'00000000'  BFTEK, BFALN, DCBE INDICATORS             01-DCB              
000AB5 00037E                      1547+         DC    AL3(QEODAD)    EODAD (END OF DATA ROUTINE ADDRESS)       01-DCB              
000AB8 00                          1548+         DC    BL1'00000000'  RECFM (RECORD FORMAT)                     01-DCB              
000AB9 000000                      1549+         DC    AL3(0)         EXLST (EXIT LIST ADDRESS)                 01-DCB              
                                   1550+*                       FOUNDATION BLOCK                                                    
000ABC E2C5D8C6C9D3C540            1551+         DC    CL8'SEQFILE'   DDNAME                                    01-DCB              
000AC4 02                          1552+         DC    BL1'00000010'  OFLGS (OPEN FLAGS)                        01-DCB              
000AC5 00                          1553+         DC    BL1'00000000'  IFLGS (IOS FLAGS)                         01-DCB              
000AC6 5000                        1554+         DC    BL2'0101000000000000' MACR (MACRO FORMAT)                01-DCB              
                                   1555+*                       BSAM-BPAM-QSAM INTERFACE                                            
000AC8 00                          1556+         DC    BL1'00000000'  OPTCD, OPTION CODES                       01-DCB              
000AC9 000001                      1557+         DC    AL3(1)         CHECK OR INTERNAL QSAM SYNCHRONIZING RTN. 01-DCB              
000ACC 00000001                    1558+         DC    A(1)           SYNAD, SYNCHRONOUS ERROR RTN. (3 BYTES)   01-DCB              
000AD0 0000                        1559+         DC    H'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000AD2 0000                        1560+         DC    AL2(0)         BLKSIZE, BLOCK SIZE                       01-DCB              
000AD4 00000000                    1561+         DC    F'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000AD8 00000001                    1562+         DC    A(1)           INTERNAL ACCESS METHOD USE                01-DCB              
                                   1563+*                            QSAM INTERFACE                                                 
000ADC 00000001                    1564+         DC    A(1)           EOBAD                                     01-DCB              
000AE0 00000001                    1565+         DC    A(1)           RECAD                                     01-DCB              
000AE4 0000                        1566+         DC    H'0'           QSWS (FLAGS) AND EITHER DIRCT OR BUFOFF   01-DCB              
000AE6 0000                        1567+         DC    AL2(0)         LRECL                                     01-DCB              
000AE8 00                          1568+         DC    BL1'00000000'  EROPT, ERROR OPTION                       01-DCB              
000AE9 000001                      1569+         DC    AL3(1)         CNTRL                                     01-DCB              
000AEC 00000000                    1570+         DC    H'0,0'         RESERVED AND PRECL                        01-DCB              
000AF0 00000001                    1571+         DC    A(1)           EOB, INTERNAL ACCESS METHOD FIELD         01-DCB              
                                   1572 W        DCB   DSORG=PS,MACRF=W,BLKSIZE=133,LRECL=133,RECFM=FA,        X                    
                                                       DDNAME=OUT2                                                                  
                                   1575+*                       DATA CONTROL BLOCK                                                  
                                   1576+*                                                                                           
000AF4                             1577+W        DC    0F'0'          ORIGIN ON WORD BOUNDARY                   01-DCB              
i                                   1578+*                       DIRECT ACCESS DEVICE INTERFACE                                      
                                                                                                               Page   16            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
000AF4 0000000000000000            1579+         DC    BL16'0'        FDAD, DVTBL                               01-DCB              
000B04 00000000                    1580+         DC    A(0)           KEYLEN, DEVT, TRBAL                       01-DCB              
                                   1581+*                       COMMON ACCESS METHOD INTERFACE                                      
000B08 00                          1582+         DC    AL1(0)         BUFNO, NUMBER OF BUFFERS                  01-DCB              
000B09 000001                      1583+         DC    AL3(1)         BUFCB, BUFFER POOL CONTROL BLOCK          01-DCB              
000B0C 0000                        1584+         DC    AL2(0)         BUFL, BUFFER LENGTH                       01-DCB              
000B0E 4000                        1585+         DC    BL2'0100000000000000' DSORG, DATA SET ORGANIZATION       01-DCB              
000B10 00000001                    1586+         DC    A(1)           IOBAD FOR EXCP OR RESERVED                01-DCB              
                                   1587+*                       FOUNDATION EXTENSION                                                
000B14 00                          1588+         DC    BL1'00000000'  BFTEK, BFALN, DCBE INDICATORS             01-DCB              
000B15 000001                      1589+         DC    AL3(1)         EODAD (END OF DATA ROUTINE ADDRESS)       01-DCB              
000B18 84                          1590+         DC    BL1'10000100'  RECFM (RECORD FORMAT)                     01-DCB              
000B19 000000                      1591+         DC    AL3(0)         EXLST (EXIT LIST ADDRESS)                 01-DCB              
                                   1592+*                       FOUNDATION BLOCK                                                    
000B1C D6E4E3F240404040            1593+         DC    CL8'OUT2'      DDNAME                                    01-DCB              
000B24 02                          1594+         DC    BL1'00000010'  OFLGS (OPEN FLAGS)                        01-DCB              
000B25 00                          1595+         DC    BL1'00000000'  IFLGS (IOS FLAGS)                         01-DCB              
000B26 0020                        1596+         DC    BL2'0000000000100000' MACR (MACRO FORMAT)                01-DCB              
                                   1597+*                       BSAM-BPAM-QSAM INTERFACE                                            
000B28 00                          1598+         DC    BL1'00000000'  OPTCD, OPTION CODES                       01-DCB              
000B29 000001                      1599+         DC    AL3(1)         CHECK OR INTERNAL QSAM SYNCHRONIZING RTN. 01-DCB              
000B2C 00000001                    1600+         DC    A(1)           SYNAD, SYNCHRONOUS ERROR RTN. (3 BYTES)   01-DCB              
000B30 0000                        1601+         DC    H'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000B32 0085                        1602+         DC    AL2(133)       BLKSIZE, BLOCK SIZE                       01-DCB              
000B34 00000000                    1603+         DC    F'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000B38 00000001                    1604+         DC    A(1)           INTERNAL ACCESS METHOD USE                01-DCB              
                                   1605+*                         BSAM-BPAM INTERFACE                                               
000B3C 00                          1606+         DC    AL1(0)         NCP, MAX NUM OF OUTSTANDING READ/WRITES   01-DCB              
000B3D 000001                      1607+         DC    AL3(1)         EOBR, INTERNAL ACCESS METHOD USE          01-DCB              
000B40 00000001                    1608+         DC    A(1)           EOBW, INTERNAL ACCESS METHOD USE          01-DCB              
000B44 0000                        1609+         DC    AL1(0,0)       FLAGS AND EITHER DIRCT OR BUFOFF          01-DCB              
000B46 0085                        1610+         DC    AL2(133)       LRECL                                     01-DCB              
000B48 00000001                    1611+         DC    A(1)           CNTRL, NOTE, POINT                        01-DCB              
                                   1613 S        DCB DSORG=PS,MACRF=W,BLKSIZE=882,RECFM=VBA,LRECL=125,         X                    
                                                       DDNAME=OUT2                                                                  
                                   1616+*                       DATA CONTROL BLOCK                                                  
                                   1617+*                                                                                           
000B4C                             1618+S        DC    0F'0'          ORIGIN ON WORD BOUNDARY                   01-DCB              
                                   1619+*                       DIRECT ACCESS DEVICE INTERFACE                                      
000B4C 0000000000000000            1620+         DC    BL16'0'        FDAD, DVTBL                               01-DCB              
000B5C 00000000                    1621+         DC    A(0)           KEYLEN, DEVT, TRBAL                       01-DCB              
                                   1622+*                       COMMON ACCESS METHOD INTERFACE                                      
000B60 00                          1623+         DC    AL1(0)         BUFNO, NUMBER OF BUFFERS                  01-DCB              
000B61 000001                      1624+         DC    AL3(1)         BUFCB, BUFFER POOL CONTROL BLOCK          01-DCB              
000B64 0000                        1625+         DC    AL2(0)         BUFL, BUFFER LENGTH                       01-DCB              
000B66 4000                        1626+         DC    BL2'0100000000000000' DSORG, DATA SET ORGANIZATION       01-DCB              
000B68 00000001                    1627+         DC    A(1)           IOBAD FOR EXCP OR RESERVED                01-DCB              
                                   1628+*                       FOUNDATION EXTENSION                                                
000B6C 00                          1629+         DC    BL1'00000000'  BFTEK, BFALN, DCBE INDICATORS             01-DCB              
000B6D 000001                      1630+         DC    AL3(1)         EODAD (END OF DATA ROUTINE ADDRESS)       01-DCB              
000B70 54                          1631+         DC    BL1'01010100'  RECFM (RECORD FORMAT)                     01-DCB              
000B71 000000                      1632+         DC    AL3(0)         EXLST (EXIT LIST ADDRESS)                 01-DCB              
i                                   1633+*                       FOUNDATION BLOCK                                                    
                                                                                                               Page   17            
  Active Usings: SPXD(X'1000'),R12                                                                                                  
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/02 14.10            
000B74 D6E4E3F240404040            1634+         DC    CL8'OUT2'      DDNAME                                    01-DCB              
000B7C 02                          1635+         DC    BL1'00000010'  OFLGS (OPEN FLAGS)                        01-DCB              
000B7D 00                          1636+         DC    BL1'00000000'  IFLGS (IOS FLAGS)                         01-DCB              
000B7E 0020                        1637+         DC    BL2'0000000000100000' MACR (MACRO FORMAT)                01-DCB              
                                   1638+*                       BSAM-BPAM-QSAM INTERFACE                                            
000B80 00                          1639+         DC    BL1'00000000'  OPTCD, OPTION CODES                       01-DCB              
000B81 000001                      1640+         DC    AL3(1)         CHECK OR INTERNAL QSAM SYNCHRONIZING RTN. 01-DCB              
000B84 00000001                    1641+         DC    A(1)           SYNAD, SYNCHRONOUS ERROR RTN. (3 BYTES)   01-DCB              
000B88 0000                        1642+         DC    H'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000B8A 0372                        1643+         DC    AL2(882)       BLKSIZE, BLOCK SIZE                       01-DCB              
000B8C 00000000                    1644+         DC    F'0'           INTERNAL ACCESS METHOD FLAGS              01-DCB              
000B90 00000001                    1645+         DC    A(1)           INTERNAL ACCESS METHOD USE                01-DCB              
                                   1646+*                         BSAM-BPAM INTERFACE                                               
000B94 00                          1647+         DC    AL1(0)         NCP, MAX NUM OF OUTSTANDING READ/WRITES   01-DCB              
000B95 000001                      1648+         DC    AL3(1)         EOBR, INTERNAL ACCESS METHOD USE          01-DCB              
000B98 00000001                    1649+         DC    A(1)           EOBW, INTERNAL ACCESS METHOD USE          01-DCB              
000B9C 0000                        1650+         DC    AL1(0,0)       FLAGS AND EITHER DIRCT OR BUFOFF          01-DCB              
000B9E 007D                        1651+         DC    AL2(125)       LRECL                                     01-DCB              
000BA0 00000001                    1652+         DC    A(1)           CNTRL, NOTE, POINT                        01-DCB              
                                   1654 *                                                                                           
                                   1655 * Buffers for Logical Reads                                                                 
                                   1656 *                                                                                           
000BA4 4040404040404040            1657 BSBUFF   DC    CL80' '       Buffer for BSAM Logical READ                                   
000BF4 4040404040404040            1658 QSBUFF   DC    CL80' '       Buffer for QSAM Logical READ                                   
                                   1659 *                                                                                           
                                   1660 * Big Buffer for XDAP                                                                       
                                   1661 *                                                                                           
000C44 4040404040404040            1662 BUFFER   DC    3200C' '      Define 3200 byte buffer                                        
0018C4 C5D5C440D6C640E2            1663 SPXDEND  DC    CL32'END OF SPXD'  Mark end of SPAM                                          
000000                             1664          END   SPXD          End of SPAM                                                    
¤                                                                                                                                    
                                                Dsect Cross Reference                                          Page   18            
Dsect     Length      Id       Defn                                                         HLASM R4.0  2005/05/02 14.10            
IHADCB   00000060  FFFFFFFF      71                                                                                                 
¤                                                                                                                                    
                                   General Purpose Register Cross Reference                                    Page   19            
 Register  References (M=modified, B=branch, U=USING, D=DROP, N=index)                      HLASM R4.0  2005/05/02 14.10            
    0(0)     910   926M  927M 1023M 1070  1073M 1085M 1099M 1142M 1177M 1209M 1210M 1211  1218M 1219M 1220  1229M 1230M             
            1231  1238M 1239M 1240  1247M 1248M 1249  1369  1370M 1377M 1421  1452M 1453M 1454                                      
    1(1)     910   917   924M  934M  972M  988   989   990  1022M 1024M 1024N 1039M 1055  1070  1074M 1085M 1093M 1094              
            1101M 1141M 1144  1176M 1179  1208M 1211M 1217M 1220M 1228M 1231M 1237M 1240M 1246M 1249M 1421  1426M 1442              
            1451M 1454M                                                                                                             
    2(2)     910  1070  1075M 1085M 1421                                                                                            
    3(3)     910  1070  1085M 1421                                                                                                  
    4(4)     910  1070  1085M 1137M 1138  1157M 1157  1421                                                                          
    5(5)     910  1070  1085M 1117M 1118  1135M 1158M 1159M 1159  1421                                                              
    6(6)     910  1001M 1011  1013M 1013  1070  1076M 1078  1082M 1083M 1084  1085M 1129M 1130M 1131  1136M 1157N 1158              
            1191M 1191  1192M 1193M 1193  1194  1195M 1195  1196M 1197  1421                                                        
    7(7)     910   956M  956   958M  959M  959   960   961M  961   962   988   999  1007  1009  1011  1012M 1012  1070              
            1085M 1169M 1421                                                                                                        
    8(8)     910   957M  957   960M  962M  989   999  1007  1070  1085M 1421                                                        
    9(9)     910  1070  1085M 1421                                                                                                  
   10(A)     910  1070  1085M 1421                                                                                                  
   11(B)     910   967M 1034M 1064M 1070  1085M 1150M 1155M 1273M 1279M 1281M 1289M 1380B 1401B 1421                                
   12(C)     910   911M  912U 1070  1076  1078M 1085M 1421                                                                          
   13(D)     910   914   915   916M 1070  1085M 1421                                                                                
   14(E)     910   913M  914   915   916   993M 1058M 1070  1077M 1085M 1145M 1149M 1180M 1222M 1251M 1253M 1255M 1257M             
            1259M 1261M 1268B 1294  1369  1373M 1377M 1421                                                                          
   15(F)     910   911   925M  942M  942   992M  992  1025M 1025  1027M 1027  1057M 1057  1070  1071M 1072M 1072  1077B             
            1079M 1079  1085M 1143M 1143  1144M 1145B 1178M 1178  1179M 1180B 1369  1371M 1373B 1377M 1421  1444M 1444              
¤                                                                                                                                    
                                  Diagnostic Cross Reference and Assembler Summary                             Page   20            
                                                                                            HLASM R4.0  2005/05/02 14.10            
     No Statements Flagged in this Assembly                                                                                         
HIGH LEVEL ASSEMBLER, 5696-234, RELEASE 4.0, PTF UQ57391                                                                            
SYSTEM: OS/390 02.10.00            JOBNAME: Z030199A    STEPNAME: STEP1      PROCSTEP: ASM                                          
Datasets Allocated for this Assembly                                                                                                
 Con DDname   Dataset Name                                 Volume  Member                                                           
  P1 SYSIN    Z030199.Z030199A.JOB07308.D0000101.?                                                                                  
  L1 SYSLIB   SYS1.MACLIB                                  SYSRES                                                                   
  L2          SYS2.MACLIB                                  SYS304                                                                   
  L3          T90RPR1.CS468PUB.MACLIB                      ACA301                                                                   
     SYSLIN   SYS05122.T141016.RA000.Z030199A.OBJSET.H01   TMP301                                                                   
     SYSPRINT Z030199.Z030199A.JOB07308.D0000102.?                                                                                  
                                                                                                                                    
   1792K allocated to Buffer Pool,         1017K would be required for this to be an In-Storage Assembly                            
    439 Primary Input Records Read         7781 Library Records Read                  0 Work File Reads                             
      0 ASMAOPT Records Read                948 Primary Print Records Written         0 Work File Writes                            
    120 Punch Records Written                 0 ADATA Records Written                                                               
Assembly Start Time: 14.10.16 Stop Time: 14.10.17 Processor Time: 00.00.00.1691                                                     
Return Code 000                                                                                                                     
 !! END OF JES SPOOL FILE !!
-XDAP BDT542I GPARM given for pgm:                                                                                                   
-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:                                                                                       
-XDAP BDT535I Member name used in FIND/BLDL is:   STOW                                                                               
1XDAP BDT531I The XDAP record is:  S#:38 R#:0C             MACRO                                                          00020000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    &NAME    STOW  &DCB,&AREA,&TYP                                          00040000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AIF   ('&DCB' EQ '').ERR1                                      00060000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .D1      AIF   ('&AREA' EQ '').ERR2                                     00068019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .D2      AIF   ('&TYP' NE '' AND '&TYP' NE 'A' AND '&TYP' NE 'C' AND   *00076020   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C                   '&TYP' NE 'D' AND '&TYP' NE 'R').ERR3                    00084019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AIF   ('&DCB' EQ '' OR '&AREA' EQ '').MEND                     00092019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    &NAME    IHBINNRA &DCB,&AREA                                            00100000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AIF   ('&TYP' EQ '' OR '&TYP' EQ 'A').ISVC                     00120000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AIF   ('&TYP' NE 'R').TSTD                                     00140000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             LCR   1,1                               INDICATE TYPE R        00160000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AGO   .ISVC                                                    00180000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .TSTD    AIF   ('&TYP' NE 'D').TSTC                                     00200000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             LCR   0,0                               INDICATE TYPE D        00220000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AGO   .ISVC                                                    00240000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .TSTC    LCR   1,1                          INDICATE TYPE C             00250020   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             LCR   0,0                                                      00260019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .ISVC    SVC   21                                ISSUE STOW SVC         00270019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             MEXIT                                                          00300000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .ERR1    IHBERMAC 6                                                     00320000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AGO   .D1                                                      00340019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .ERR2    IHBERMAC 13                                                    00360000   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C             AGO   .D2                                                      00370019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .ERR3    IHBERMAC 48,,&TYP                                              00380019   
 XDAP BDT531I The XDAP record is:  S#:38 R#:0C    .MEND    MEND                                                           40380019   
-XDAP BDT533I EOF Encountered on SPAM file.                                                                                          
-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:                                                                                       
-XDAP BDT535I Member name used in FIND/BLDL is:   ABEND                                                                              
1XDAP BDT531I The XDAP record is:  S#:34 R#:07             MACRO                                                          00070002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &NAME    ABEND &CC,&DUMP,&STEP,&USESYS,&DUMPOPT=                        00100002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .*000400,000800,001600-001700,001800-002600,003400-005400               00200002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .*005800-006000,006200,006800-007200,007600-008400,008800               00250002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             LCLA  &CTR                                                     00300002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             LCLB  &B(3)                                                    00350002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &NAME    DS    0H                                                       00400002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&CC' EQ '').E1                                         00450002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &B(1)    SETB  ('&DUMP' EQ 'DUMP')                                      00500002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &B(2)    SETB  ('&STEP' EQ 'STEP')                                      00550002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &B(3)    SETB  ('&DUMPOPT' NE '')                                       00600002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&USESYS' NE 'SYSTEM' AND '&USESYS' NE 'USER' AND '&USEC00610002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07                   SYS' NE '').E4                                           00620002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .TEST0   AIF   ('&DUMP' NE '' AND NOT &B(1)).E2                         00650002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .TEST    AIF   ('&STEP' NE '' AND NOT &B(2)).E3                         00700002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .SETFLGS ANOP                                                           00750002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    &CTR     SETA  128*&B(1)+64*&B(2)+32*&B(3)                              00800002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&CC'(1,1) EQ '(').CONTA                                00900002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   (T'&CC NE 'N').AA                                        00950002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   (&CC GT 4095).AA0                                        01000002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .CONTA   ANOP                                                           01050002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             IHBINNRA &CC             LOAD REG1 WITH COMPCODE               01100002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   (T'&CC EQ 'N' AND '&CC'(1,1) NE '(').CKSYS               01150002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .POSITIO ANOP                                                           01160002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&USESYS' EQ '').FLAGS                                  01170002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             SLL   1,20(0)            SHIFT OFF > 12 BITS                   01200002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&USESYS' NE 'SYSTEM').USER                             01260002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             SRL   1,8(0)             CODE IN SYSTEM POSITION               01300002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AGO   .FLAGS                                                   01350002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .USER    SRL   1,20(0)            SHIFT TO USER POSITION                01360002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AGO   .FLAGS                                                   01370002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .AA0     ANOP                                                           01380002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AIF   ('&USESYS' EQ '').AA1                                    01390002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             MNOTE *,'CC EXCEEDS SPECIFIED LIMITS - LOW 12 BITS USED'       01390402   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             AGO   .AA                                                      01392002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .AA1     MNOTE *,'CC EXCEEDS SPECIFIED LIMITS'                          01394002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07    .AA      CNOP  0,4                                                      01400002   
 XDAP BDT531I The XDAP record is:  S#:34 R#:07             B     *+8                BRANCH AROUND CONSTANTS               01450002   
0XDAP BDT531I The XDAP record is:  S#:42 R#:08             DC    AL4(&CC)                                                 01500002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             L     1,*-4              LOAD REG1 WITH COMPCODE               01550002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             AGO   .POSITIO                                                 01600002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .CKSYS   AIF   ('&USESYS' NE 'SYSTEM').FLAGS                            01650002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             SLL   1,12(0)            CODE IN SYSTEM POSITION               01700002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .FLAGS   AIF   (&CTR EQ 0).SVC                                          01750002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             LA    0,&CTR.(0,0)       PICK UP DUMP/STEP/DUMPOPTS     YM1995 01800002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             SLL   0,24(0)            SHIFT TO HIGH ORDER                   01850002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             OR    1,0                OR IN WITH COMPCODE                   01900002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .DUMPOPT AIF  (NOT &B(3)).SVC                                           01950002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             IHBINNRA ,&DUMPOPT       LOAD REG0                             02000002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .SVC     SVC   13                 LINK TO ABEND ROUTINE                 02050002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             MEXIT                                                          02100002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .E2      IHBERMAC  37,,&DUMP                                            02150002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             AGO   .TEST                                                    02200002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .E3      IHBERMAC  38,,&STEP                                            02250002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             AGO   .SETFLGS                                                 02300002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .E4      IHBERMAC  39,,&USESYS                                          02302002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             AGO   .TEST0                                                   02320002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    .E1      IHBERMAC 28,303                                                02350002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08             MEND                                                           02400002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    **/                                                                     02450002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *  ABEND: /***********************************************************/ 02500002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    */*ABEND: PL/S VERSION OF ABEND MACRO                                */ 02550002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    */********************************************************************/ 02600002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    * MACRO                                                                 02650002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *  KEYS(DUMP,                                                           02700002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *       STEP,                                                           02750002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *       USER,                                                           02800002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *       SYSTEM,                                                         02850002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *       DUMPOPTS);                                                      02900002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *        ANS('?'||MACLABEL||'ABENDP '||MACLIST||MACKEYS||';');          02950002   
 XDAP BDT531I The XDAP record is:  S#:42 R#:08    *%END;                                                                  03000002   
-XDAP BDT533I EOF Encountered on SPAM file.                                                                                          
-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:                                                                                       
-XDAP BDT535I Member name used in FIND/BLDL is:   STIMER                                                                             
1XDAP BDT531I The XDAP record is:  S#:66 R#:24             MACRO                                                          01110002   
0XDAP BDT531I The XDAP record is:  S#:68 R#:25    &NAME    STIMER &TYPE,&EXIT,&DINTVL=,&BINTVL=,&TUINTVL=,&TOD=,&MICVL=,&*02000002   
0XDAP BDT531I The XDAP record is:  S#:6B R#:26                   GMT=,&ERRET=                                             03000002   
0XDAP BDT531I The XDAP record is:  S#:6E R#:27    * /* MACDATE Y-1 72277                                               */ 03050002   
0XDAP BDT531I The XDAP record is:  S#:71 R#:28             LCLB  &B(9)                                                    04000002   
0XDAP BDT531I The XDAP record is:  S#:73 R#:29             LCLA  &SUM                                                     05000002   
0XDAP BDT531I The XDAP record is:  S#:76 R#:2A             AIF   ('&TYPE' EQ '' OR '&DINTVL&BINTVL&TUINTVL&TOD&MICVL&GMT'*06000002   
0XDAP BDT531I The XDAP record is:  S#:79 R#:2B                    EQ '').E2                                               07000002   
0XDAP BDT531I The XDAP record is:  S#:7C R#:2C             AIF   ('&EXIT' NE '' AND '&TYPE' EQ 'WAIT').NMNOTE      A26596 08000002   
0XDAP BDT531I The XDAP record is:  S#:7E R#:2D    &B(1)    SETB  ('&TYPE' EQ 'TASK')                                      09000002   
0XDAP BDT531I The XDAP record is:  S#:81 R#:2E    &B(2)    SETB  ('&TYPE' EQ 'REAL')                                      10000002   
0XDAP BDT531I The XDAP record is:  S#:84 R#:2F    &B(3)    SETB  ('&TYPE' EQ 'WAIT')                                      11000002   
0XDAP BDT531I The XDAP record is:  S#:87 R#:30    &B(4)    SETB  ('&DINTVL' NE '')                                        12000002   
0XDAP BDT531I The XDAP record is:  S#:89 R#:31    &B(5)    SETB  ('&BINTVL' NE '')                                        13000002   
0XDAP BDT531I The XDAP record is:  S#:8C R#:32    &B(6)    SETB  ('&TUINTVL' NE '')                                       14000002   
0XDAP BDT531I The XDAP record is:  S#:8F R#:33    &B(7)    SETB  ('&TOD' NE '')                                           15000002   
0XDAP BDT531I The XDAP record is:  S#:92 R#:34    &B(8)    SETB  ('&MICVL' NE '')                                         16000002   
0XDAP BDT531I The XDAP record is:  S#:94 R#:35    &B(9)    SETB  ('&GMT' NE '')                                           17000002   
0XDAP BDT531I The XDAP record is:  S#:97 R#:36             AIF   (&B(1)+&B(2)+&B(3) NE 1).E1                              18000002   
0XDAP BDT531I The XDAP record is:  S#:9A R#:37             AIF   (&B(1) AND (&B(7) OR &B(9))).E3                          19000002   
0XDAP BDT531I The XDAP record is:  S#:9D R#:38    &NAME    IHBINNRA &DINTVL&BINTVL&TUINTVL&TOD&MICVL&GMT,&EXIT            20000002   
0XDAP BDT531I The XDAP record is:  S#:9F R#:39             AIF   ('&ERRET' EQ '').NORET                                   21000002   
0XDAP BDT531I The XDAP record is:  S#:A2 R#:3A    &SUM     SETA  8                                  RETURN CODE FLAG      22000002   
0XDAP BDT531I The XDAP record is:  S#:A5 R#:3B    .NORET   AIF   ('&EXIT' NE '').CONTA                                    23000002   
0XDAP BDT531I The XDAP record is:  S#:A8 R#:3C             AIF   (&B(1) AND &B(6)).SRSVC                                  24000002   
0XDAP BDT531I The XDAP record is:  S#:AA R#:3D    &SUM     SETA  &SUM+&B(3)+3*&B(2)+16*&B(5)+48*&B(4)+112*&B(7)+32*&B(8)+*25000002   
0XDAP BDT531I The XDAP record is:  S#:AD R#:3E                   96*&B(9)                                                 26000002   
0XDAP BDT531I The XDAP record is:  S#:B0 R#:3F    .LC      LA    0,&SUM.(0,0)                       LOAD FLAG BYTE        27000002   
0XDAP BDT531I The XDAP record is:  S#:B3 R#:40    .ZSHIFT  SLL   0,24(0)                           SHIFT TO HI-ORDER BYTE 28000002   
0XDAP BDT531I The XDAP record is:  S#:B5 R#:41             AGO   .SVC                                                     29000002   
0XDAP BDT531I The XDAP record is:  S#:B8 R#:42    .SRSVC   AIF   (&SUM NE 0).LC                     TEST FOR RC REQUESTED 30000002   
0XDAP BDT531I The XDAP record is:  S#:BB R#:43             SR    0,0                                INDICATE TASK,TUINTVL 31000002   
0XDAP BDT531I The XDAP record is:  S#:BE R#:44             AGO   .SVC                                                     32000002   
0XDAP BDT531I The XDAP record is:  S#:C0 R#:45    .SPZRT   LA    0,48+&SUM.(0,0)                    LOAD FLAG BYTE        33000002   
0XDAP BDT531I The XDAP record is:  S#:C3 R#:46             AGO   .ZSHIFT                                                  34000002   
0XDAP BDT531I The XDAP record is:  S#:C6 R#:47    .CONTA   AIF   (&B(1) AND &B(6)).RETCK                                  35000002   
0XDAP BDT531I The XDAP record is:  S#:C9 R#:48    &SUM     SETA  &SUM+3*&B(2)+16*&B(5)+48*&B(4)+112*&B(7)+32*&B(8)+96*&B(*36000002   
0XDAP BDT531I The XDAP record is:  S#:CB R#:49                   9)                                                       37000002   
0XDAP BDT531I The XDAP record is:  S#:CE R#:4A    .LCEX    LA    14,&SUM.(0,0)                                            38000002   
0XDAP BDT531I The XDAP record is:  S#:D1 R#:4B    .SHIFT   SLL   14,24(0)                          SHIFT TO HI-ORDER BYTE 39000002   
0XDAP BDT531I The XDAP record is:  S#:D4 R#:4C             OR    0,14                              AND PACK WITHEXIT ADDR 40000002   
0XDAP BDT531I The XDAP record is:  S#:D6 R#:4D             AGO   .SVC                                                     41000002   
0XDAP BDT531I The XDAP record is:  S#:D9 R#:4E    .RETCK   AIF   (&SUM NE 0).LCEX                   TEST FOR RC REQUESTED 42000002   
-XDAP BDT531I The XDAP record is:  S#:06 R#:01    .SVC     SVC   47                                ISSUE STIMER SVC       43000002   
0XDAP BDT531I The XDAP record is:  S#:08 R#:02             AIF   ('&ERRET' EQ '').DONE                                    44000002   
0XDAP BDT531I The XDAP record is:  S#:0B R#:03             LTR   15,15                   ANY RETURN CODE                  45000002   
0XDAP BDT531I The XDAP record is:  S#:0E R#:04             AIF   ('&ERRET'(1,1) EQ '(').BCR                               46000002   
0XDAP BDT531I The XDAP record is:  S#:11 R#:05             BNZ   &ERRET                  YES. BR TO USER EXIT             47000002   
0XDAP BDT531I The XDAP record is:  S#:13 R#:06             AGO   .DONE                                                    48000002   
0XDAP BDT531I The XDAP record is:  S#:16 R#:07    .BCR     BCR   7,&ERRET(1)                                              49000002   
0XDAP BDT531I The XDAP record is:  S#:19 R#:08    .DONE    MEXIT                                                          50000002   
0XDAP BDT531I The XDAP record is:  S#:1C R#:09    .SPECRT  LA    14,48+&SUM.(0,0)                   LOAD FLAG BYTE        51000002   
0XDAP BDT531I The XDAP record is:  S#:1E R#:0A             AGO   .SHIFT                                                   52000002   
0XDAP BDT531I The XDAP record is:  S#:21 R#:0B    .NMNOTE  ANOP                                                    A26596 53000002   
0XDAP BDT531I The XDAP record is:  S#:24 R#:0C             MNOTE 12,'WAIT AND EXIT ADDRESS INVALID'                A26596 54000002   
0XDAP BDT531I The XDAP record is:  S#:27 R#:0D             MEXIT                                                          55000002   
0XDAP BDT531I The XDAP record is:  S#:29 R#:0E    .E3      ANOP                                                           56000002   
0XDAP BDT531I The XDAP record is:  S#:2C R#:0F             MNOTE 16,'TASK WITH GMT OR TOD INVALID'                        57000002   
0XDAP BDT531I The XDAP record is:  S#:2F R#:10             MEXIT                                                          58000002   
0XDAP BDT531I The XDAP record is:  S#:32 R#:11    .E1      IHBERMAC 36,,&TYPE,,,0                                         59000002   
0XDAP BDT531I The XDAP record is:  S#:34 R#:12             MEXIT                                                          60000002   
0XDAP BDT531I The XDAP record is:  S#:37 R#:13    .E2      IHBERMAC 01                                                    61000002   
0XDAP BDT531I The XDAP record is:  S#:3A R#:14             MEXIT                                                          62000002   
0XDAP BDT531I The XDAP record is:  S#:3D R#:15             MEND                                                           63000002   
-XDAP BDT533I EOF Encountered on SPAM file.                                                                                          
-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:                                                                                       
-XDAP BDT535I Member name used in FIND/BLDL is:   CLOSE                                                                              
1XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             MACRO                                                          00020000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &CNAME   CLOSE &PAR1,&MF=I,&TYPE=                                A45585 00040021   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             LCLA  &ACTR,&ASUM,&CTR,&CTR1,&LGTH,&NUMBER                     00060000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             LCLB  &MFESW,&MFISW,&MFI2SW,&NULLSW,&B(5)               Y02134 00080002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             LCLC  &PARA                                                    00100000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &NUMBER  SETA  N'&PAR1                                                  00120000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &CTR     SETA  1                                                        00140000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &CTR1    SETA  2                                                        00160000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   (N'&SYSLIST LE 1).TYPE   IF ONLY 1 (PARMLIST)     A45585 00185021   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             IHBERMAC 238                   EXCESSIVE POS. PARMS     A45585 00190021   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .TYPE    AIF   (T'&TYPE NE 'O' AND '&TYPE' NE 'T').ERROR8        A45585 00195021   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&MF' EQ 'L').RTEL                                      00200000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&MF' EQ 'I').TESTI                                     00220000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   (N'&MF LE 1).ERROR3                                      00240000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&MF(1)' NE 'E').ERROR3                                 00260000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &CNAME   IHBINNRA &MF(2)                                                00280000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&PAR1' EQ '').SVCSVC                                   00300002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .LOOPA   AIF   ('&PAR1(&NUMBER)' NE '').LOOPB                           00320002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &NUMBER  SETA  &NUMBER-1                                                00340000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   (&NUMBER EQ 0).SVCSVC                                    00360000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AGO   .LOOPA                                                   00380000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .LOOPB   AIF   ('&PAR1(&CTR)' NE '').TESTCTR                            00400002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &NULLSW  SETB  1                                                        00420002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .TESTCTR AIF   (&CTR EQ &NUMBER).QUITNOW                                00440000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&PAR1(&CTR1)' EQ '').NULLTWO                           00460002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &MFESW   SETB  1                                                        00480000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AGO   .CLRSW                                                   00500000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .ERTRTRN AIF   (&CTR1 EQ &NUMBER).THRUNOW                               00580000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   (&NULLSW).NOFIRST                                        00600000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AIF   ('&PAR1(&CTR)'(1,1) EQ '(').REGISTR                      00620000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             LA    14,&PAR1(&CTR)                    PICK UP DCB ADDRESS    00640000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             ST    14,&ACTR.(1,0)                    STORE INTO LIST        00660000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .NOFIRST MVI   &ACTR.(1),&ASUM                   MOVE IN OPTION BYTE    00680002   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AGO   .INCRMT                                                  00700000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    .REGISTR ANOP                                                           00720000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &LGTH    SETA  K'&PAR1(&CTR)-2                                          00740000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B    &PARA    SETC  '&PAR1(&CTR)'(2,&LGTH)                                   00760000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             ST    &PARA,&ACTR.(1,0)                 STORE DCB ADDR IN LIST 00780000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             MVI   &ACTR.(1),&ASUM                   MOVE IN OPTION BYTE    00800000   
 XDAP BDT531I The XDAP record is:  S#:A3 R#:1B             AGO   .INCRMT                                                  00820000   
0XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .NULLTWO AIF   (&NULLSW).INCRMT                                         00880002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AIF   ('&PAR1(&CTR)'(1,1) EQ '(').REGSTER                      00900002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             IC    14,&ACTR.(1,0)                    SAVE OPTION BYTE       00920000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             LA    0,&PAR1(&CTR)                     PICK UP DCB ADDRESS    00940000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             ST    0,&ACTR.(1,0)                     STORE INTO LIST        00960000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             STC   14,&ACTR.(1,0)                    RESTORE OPTION BYTE    00980000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .INCRMT                                                  01000000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .REGSTER IC    14,&ACTR.(1,0)                    SAVE OPTION BYTE       01020000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &LGTH    SETA  K'&PAR1(&CTR)-2                                          01040000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &PARA    SETC  '&PAR1(&CTR)'(2,&LGTH)                                   01060000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             ST    &PARA,&ACTR.(1,0)                 STORE DCB ADDR IN LIST 01080000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             STC   14,&ACTR.(1,0)                    RESTORE OPTION BYTE    01100000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .INCRMT                                                  01120000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .QUITNOW IC    14,&ACTR.(1,0)                    SAVE OPTION BYTE       01140000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AIF   ('&PAR1(&CTR)'(1,1) EQ '(').REGST                        01160000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             LA    0,&PAR1(&CTR)                     PICK UP DCB ADDRESS    01180000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             ST    0,&ACTR.(1,0)                     STORE INTO LIST        01200000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             STC   14,&ACTR.(1,0)                    RESTORE OPTION BYTE    01220000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .SVCSVC                                                  01240000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .REGST   ANOP                                                           01260000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &LGTH    SETA  K'&PAR1(&CTR)-2                                          01280000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &PARA    SETC  '&PAR1(&CTR)'(2,&LGTH)                                   01300000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             ST    &PARA,&ACTR.(1,0)                 STORE DCB ADDR IN LIST 01320000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             STC   14,&ACTR.(1,0)                    RESTORE OPTION BYTE    01340000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .SVCSVC                                                  01360000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .THRUNOW NI    &ACTR.(1),X'80'                  CLEAR OPTION BITS       01380002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AIF   (&ASUM EQ 0).CONTA                                       01390002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             OI    &ACTR.(1),&ASUM           SET OPTION BITS                01400002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .CONTA   AIF   (&NULLSW).SVCSVC                                         01420002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .QUITNOW                                                 01440000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .INCRMT  ANOP                                                           01460000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &CTR     SETA  &CTR+2                                                   01480000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &CTR1    SETA  &CTR1+2                                                  01500000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &ACTR    SETA  &ACTR+4                                                  01520000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    &NULLSW  SETB  0                                                        01540000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             AGO   .LOOPB                                                   01560000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .SVCSVC  AIF   ('&TYPE' NE 'T').ISSST                                   01572002   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             SVC   23                                ISSUE TCLOSE SVC       01600000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C             MEXIT                                                          01620000   
 XDAP BDT531I The XDAP record is:  S#:B1 R#:1C    .ISSST   SVC   20                                ISSUE CLOSE SVC        01640000   
0XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             MEXIT                                                          01660002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .RTEL    ANOP                                                           01680000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &CNAME   DC    0F'0'             ALIGN LIST TO FULLWORD                 01700002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   ('&PAR1' EQ '').ERROR5                                   01710002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .CLRSW   ANOP                                                           01720000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &ASUM    SETA  0                                                        01740000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   (&CTR1 GT &NUMBER).J                                     01780000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   ('&PAR1(&CTR1)' EQ '').DC1                               01800000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &B(1)    SETB  ('&PAR1(&CTR1)' EQ 'REREAD')                             01820000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &B(2)    SETB  ('&PAR1(&CTR1)' EQ 'LEAVE')                              01840000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &B(3)    SETB  ('&PAR1(&CTR1)' EQ 'DISP')                               01860002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &B(4)    SETB  ('&PAR1(&CTR1)' EQ 'REWIND')                             01870019   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &B(5)    SETB  ('&PAR1(&CTR1)' EQ 'FREE') DYNAMIC UNALLOCATION   Y02134 01872002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   (&B(1)+&B(2)+&B(3)+&B(4)+&B(5) NE 1).ERROR2       Y02134 01880002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   ('&TYPE' NE 'T').CLO0100 TEST FOR TYPE=T          Y02134 01882002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   (&B(3) OR &B(4) OR &B(5)).ERROR2 TYPE=T INVLID OP Y02134 01884002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .CLO0100 ANOP                                                    Y02134 01894002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &ASUM    SETA  16*&B(1)+32*&B(5)+48*&B(2)+64*&B(4)               Y02134 01900002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .DC1     AIF   (&MFESW).ERTRTRN                                         01940000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   (&CTR1 LT &NUMBER).K                                     01960002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .J       ANOP                                                           02040000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &ASUM    SETA  &ASUM+128                                                02080000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .K       AIF   (&MFI2SW).I2ROUT                                         02100002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   (&MFISW).IROUTRN                                         02120000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             DC    AL1(&ASUM)                        OPTION BYTE            02160000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   ('&PAR1(&CTR)' NE '').NOBLANK                            02180002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             DC    AL3(0)                            DCB ADDRESS            02220002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AGO   .NOTLST                                                  02240000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .NOBLANK AIF   ('&PAR1(&CTR)'(1,1) EQ '(').ERROR6                       02280002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             DC    AL3(&PAR1(&CTR))                  DCB ADDRESS            02300002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .NOTLST  AIF   (&CTR1 GE &NUMBER).FINI                                  02320002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &CTR     SETA  &CTR+2                                                   02340000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &CTR1    SETA  &CTR1+2                                                  02360000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AGO   .CLRSW                                                   02380002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .TESTI   CNOP  0,4                               ALIGN LIST TO FULLWORD 02420002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &LGTH    SETA  ((&NUMBER+1)/2)*4+4                                      02440002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &CNAME   BAL   1,*+&LGTH                         LOAD REG1 W/LIST ADDR  02460002   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    &MFISW   SETB  1                                                        02480000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D    .RTEYE   AIF   ('&PAR1(&CTR)' EQ '').ERROR5                             02500000   
 XDAP BDT531I The XDAP record is:  S#:C0 R#:1D             AIF   ('&PAR1(&CTR)'(1,1) NE '(').CLRSW                        02520000   
0XDAP BDT531I The XDAP record is:  S#:CE R#:1E             DC    A(0)                              OPTION AND DCB ADDRESS 02540000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             AGO   .UPCTRS                                                  02560000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .IROUTRN DC    AL1(&ASUM)                        OPTION BYTE            02580000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             DC    AL3(&PAR1(&CTR))                  DCB ADDRESS            02600000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .UPCTRS  AIF   (&CTR1 GE &NUMBER).QUITS                                 02620000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR     SETA  &CTR+2                                                   02640000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR1    SETA  &CTR1+2                                                  02660000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             AGO   .RTEYE                                                   02680000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .QUITS   ANOP                                                           02700000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR     SETA  1                                                        02720000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR1    SETA  2                                                        02740000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ILOOP2  AIF   ('&PAR1(&CTR)'(1,1) NE '(').UPCTR2                       02760000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &LGTH    SETA  K'&PAR1(&CTR)-2                                          02780000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &PARA    SETC  '&PAR1(&CTR)'(2,&LGTH)                                   02800000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             ST    &PARA,&ACTR.(1,0)                 STORE DCB ADDRESS      02820000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &MFI2SW  SETB  1                                                        02840000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             AGO   .CLRSW                                                   02860000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .I2ROUT  AIF   (&ASUM EQ 0).UPCTR2                                      02880000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             MVI   &ACTR.(1),&ASUM                   MOVE IN OPTION BYTE    02900000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .UPCTR2  AIF   (&CTR1 GE &NUMBER).SVCSVC                                02920002   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR     SETA  &CTR+2                                                   02940000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &CTR1    SETA  &CTR1+2                                                  02960000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    &ACTR    SETA  &ACTR+4                                                  02980000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             AGO   .ILOOP2                                                  03000000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ERROR2  IHBERMAC 49,,&PAR1(&CTR1)      INVALID OPTION OPERAND          03020002   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             MEXIT                                                          03040000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ERROR3  IHBERMAC 35,,&MF               INVALID MF OPERAND SPECIFIED    03060002   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             MEXIT                                                          03080000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ERROR5  IHBERMAC 06                    DCB MISSING                     03100002   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             MEXIT                                                          03120000   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ERROR6  IHBERMAC 69                    INVALID REG NOTATION W/MF=L     03140002   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E             MEXIT                                                          03146020   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .ERROR8  IHBERMAC 63,,&TYPE             INVALID TYPE OPERAND     M0626  03156020   
 XDAP BDT531I The XDAP record is:  S#:CE R#:1E    .FINI    MEND                                                           03160000   
-XDAP BDT533I EOF Encountered on SPAM file.                                                                                          
-XDAP BDT534I SNAP BLDLtable/XDAP-DCB follows:                                                                                       
-XDAP BDT535I Member name used in FIND/BLDL is:   BLDL                                                                               
1XDAP BDT531I The XDAP record is:  S#:08 R#:02             MACRO                                                          00020000   
 XDAP BDT531I The XDAP record is:  S#:08 R#:02    &NAME    BLDL  &DCB,&LIST,&DUMMY=                                       00040017   
0XDAP BDT531I The XDAP record is:  S#:0B R#:03    .*      VS2 RELEASE 03 CHANGES/DELETIONS                                00050000   
 XDAP BDT531I The XDAP record is:  S#:0B R#:03    .*A001100-001140                                                ZA00734 00052000   
0XDAP BDT531I The XDAP record is:  S#:0E R#:04             AIF   ('&DCB' EQ '').E1                                        00060000   
 XDAP BDT531I The XDAP record is:  S#:0E R#:04             AIF   ('&LIST' EQ '').E2                                       00080000   
0XDAP BDT531I The XDAP record is:  S#:12 R#:05    &NAME    IHBINNRA &DCB,&LIST              LOAD REG 1 AND REG 0          00100000   
 XDAP BDT531I The XDAP record is:  S#:12 R#:05             LA    1,0(1)                     CLEAR HIGH ORDER BYTE ZA00734 00110000   
0XDAP BDT531I The XDAP record is:  S#:15 R#:06    .*  REGISTER 1 IS MADE POSITIVE SO THE SVC CODE WILL KNOW THIS  ZA00734 00112003   
 XDAP BDT531I The XDAP record is:  S#:15 R#:06    .*  REQUEST IS FROM BLDL AND NOT THE FIND MACRO.                ZA00734 00114003   
0XDAP BDT531I The XDAP record is:  S#:18 R#:07             SVC   18                                LINK TO BLDL ROUTINE   00120000   
 XDAP BDT531I The XDAP record is:  S#:18 R#:07             MEXIT                                                          00140000   
0XDAP BDT531I The XDAP record is:  S#:1B R#:08    .E1      IHBERMAC 6                     DCB ADDR MISSING                00150019   
 XDAP BDT531I The XDAP record is:  S#:1B R#:08             AIF   ('&LIST' EQ '').E2                                       00160019   
0XDAP BDT531I The XDAP record is:  S#:1E R#:09             MEXIT                                                          00180000   
 XDAP BDT531I The XDAP record is:  S#:1E R#:09    .E2      IHBERMAC 34                    LIST ADDR MISSING               05180019   
0XDAP BDT531I The XDAP record is:  S#:21 R#:0A             MEND                                                           40200017   
-XDAP BDT533I EOF Encountered on SPAM file.                                                                                          
-XDAP BDT532I EOF Encountered on QSAM file.                                                                                          
-XDAP BDT539I Pgm complete, SNAP dump follows:                                                                                       
 !! END OF JES SPOOL FILE !!
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  000310AE  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000021980          001CE2E3 D6E66BC1 C2C5D5C4    6BE2E3C9 D4C5D96B C3D3D6E2 C56BC2D3   *    ..STOW,ABEND,STIMER,CLOSE,BL*
 000219A0 C4D3002C                                                                     *DL..                            *
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003113E  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000031A20 0001003C E2E3D6E6 40404040 00000C03    00060001 01000085 273FE2E6 E8D34040   *....STOW    ...........e..SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000                     *..........}...k...}.....        *
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003113E  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000031A20 0001003C C1C2C5D5 C4404040 00010701    00060001 02000086 199FE2E6 E8D34040   *....ABEND   ...........f..SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000                     *..........}...k...}.....        *
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003113E  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000031A20 0001003C E2E3C9D4 C5D94040 00042402    00060001 1E000086 199FE2E6 E8D34040   *....STIMER  ...........f..SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000                     *..........}...k...}.....        *
1JOB Z030199A         STEP GO              TIME 141017   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003113E  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000031A20 0001003C C3D3D6E2 C5404040 00001B04    00060001 04000089 096FE2E6 E8D34040   *....CLOSE   ...........i.?SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000                     *..........}...k...}.....        *
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003113E  ILC  02  INTC  0033                                                       
0-STORAGE                                                                                                                
000031A20 0001003C C2D3C4D3 40404040 00010200    00060001 07000089 198FE2E6 E8D34040   *....BLDL    ...........i..SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000                     *..........}...k...}.....        *
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 STORAGE AREAS.........................                    00000001                                                      
0END OF DUMP                                                                                                             
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                CPUID = 170005177060   PAGE 00000001  
                                                                                                                         
   PSW AT ENTRY TO SNAP    078D1000  0003170E  ILC  02  INTC  0033                                                       
                                                                                                                         
                                                                                                                         
 -DEB--------------------------------------AT LOCATION  009C71C4                                                         
 -----                                                                                                                   
                                                                                                                         
 -24     DEBAVT   00FEB51C 80DF4460 DEBPCIA  00FEB51C DEBCEA   80DF1000 DEBXCEA  00DF1018                                
 -10     PREFIX   00000000 04000015 EXTNSION 009C9928 LENGTH   0E       AMTYPE   20       TBLOF    0005                  
 +0      TCBADR   039D1040 NEXTDEB  109C7030 IRBADR   68000000 PATB     00005100                                         
 +10     USRPG    01000000 RRQ      FF000000 DCBADR   8F031A94 APPADR   049C71A0                                         
 +20     58F39B88 00000084 00020084 00040003                                                                             
 +30     00010001 00000000 00000000 00000050                                                                             
 +40     F3C2C1D8 C1C300E8 00000010                                                                                      
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -DCB-     (QSAM)                           AT LOCATION 00031A94                                                         
 -----                                                                                                                   
                                                                                                                         
 +10     002FE5A2 0303BA78 00004000 00006A40 0203137E 90000000 01445000 C09C71C4                                         
 +30     16CFE038 00CEBD10 0A000001 00090C80 30013030 00006B50 0003C750 0003C750                                         
 +50     00000050 00000000 00000000 00DF6690                                                                             
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -IOB-     (SAM,BPAM-NORMAL SCHEDULING)    AT LOCATION  00006B58                                                         
 -----                                                                                                                   
                                                                                                                         
 -8      20006AB0 00006AB0                                                                                               
 +0      FLAG     0200     SENS     0000     ECBPT    00006B54 CSW      00006B88 0C400C30                                
 +10     START    00000000 DCBPT    00031A94 RESTR    00000000 VARIABLE 00000000                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -IOB-     (SAM,BPAM-NORMAL SCHEDULING)    AT LOCATION  00006AB8                                                         
 -----                                                                                                                   
                                                                                                                         
 -8      21006B00 49000000                                                                                               
 +0      FLAG     0200     SENS     0000     ECBPT    00006AB4 CSW      00006AE8 0D000C80                                
 +10     START    00000000 DCBPT    00031A94 RESTR    00000000 VARIABLE 00000000                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -IOB-     (SAM,BPAM-NORMAL SCHEDULING)    AT LOCATION  00006B08                                                         
 -----                                                                                                                   
                                                                                                                         
 -8      20006B50 00000000                                                                                               
 +0      FLAG     0200     SENS     0000     ECBPT    00006B04 CSW      00006B38 0C400BE0                                
 +10     START    00000000 DCBPT    00031A94 RESTR    00000000 VARIABLE 00000000                                         
                                                                                                                         
                                                                                                                         
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000002   
                                                                                                                         
                                                                                                                         
 -DEB--------------------------------------AT LOCATION  009C7030                                                         
 -----                                                                                                                   
                                                                                                                         
 -8      EXTNSION 009C70B0 LENGTH   11       AMTYPE   81       TBLOF    0008                                             
 +0      TCBADR   009D1040 NEXTDEB  009C7298 IRBADR   089E03F8 PATB     0F000900                                         
 +10     USRPG    00000000 RRQ      00032B50 DCBADR   8F006758 APPADR   00C1379C                                         
 +20     00F390D8 E2E2C9C2 00240000 D1C5E2F2                                                                             
 +30     00000000 00000000 00000000 00000000                                                                             
 +40     00000000 00000000 E2E2D6C2 001C0010                                                                             
 +50     009C7054 00000000 009C7094 00000000                                                                             
 +60     00000000 001C0000 00000000 009C9694                                                                             
 +70     009C7030 009E03F8 00000000 00000000                                                                             
                                                                                                                         
                                                                                                                         
                                                                                                                         
 *** FOR THIS DEB THERE IS NO DCB, THE CONTROL BLOCK POINTED TO BY THE DEB IS AN ACB ***                                 
                                                                                                                         
                                                                                                                         
 -DEB--------------------------------------AT LOCATION  009C7298                                                         
 -----                                                                                                                   
                                                                                                                         
 -8      EXTNSION 009C7318 LENGTH   11       AMTYPE   81       TBLOF    0007                                             
 +0      TCBADR   009D1040 NEXTDEB  009C92AC IRBADR   089E0190 PATB     0F000900                                         
 +10     USRPG    00000000 RRQ      00031B4C DCBADR   8F0068E0 APPADR   00C1379C                                         
 +20     00F390D8 E2E2C9C2 00240000 D1C5E2F2                                                                             
 +30     00000000 00000000 00000000 00000000                                                                             
 +40     00000000 00000000 E2E2D6C2 001C0010                                                                             
 +50     009C72BC 00000000 009C72FC 00000000                                                                             
 +60     00000000 001C0000 00000000 009C7474                                                                             
 +70     009C7298 009E0190 00000000 00000000                                                                             
                                                                                                                         
                                                                                                                         
                                                                                                                         
 *** FOR THIS DEB THERE IS NO DCB, THE CONTROL BLOCK POINTED TO BY THE DEB IS AN ACB ***                                 
                                                                                                                         
                                                                                                                         
 -DEB--------------------------------------AT LOCATION  009C92AC                                                         
 -----                                                                                                                   
                                                                                                                         
 -24     DEBAVT   00FEB51C 00FEB51C DEBPCIA  00FEB51C DEBCEA   00FEB51C DEBXCEA  00FEB51C                                
 -10     PREFIX   00000000 04000015 EXTNSION 009C98D0 LENGTH   17       AMTYPE   02       TBLOF    0006                  
 +0      TCBADR   009D1040 NEXTDEB  04000000 IRBADR   69000000 PATB     00001100                                         
 +10     USRPG    05000000 RRQ      FF000000 DCBADR   8F031A60 APPADR   049C9288                                         
 +20     58F39B88 00000084 00020084 00040003                                                                             
 +30     58F39B88 00000078 000D0078 000E0002                                                                             
 +40     58F39B88 000000B7 000E00B8 00060008                                                                             
 +50     58F39B88 00000073 000D0073 000D0001                                                                             
 +60     58F39B88 00000078 000B0078 000C0002                                                                             
 +70     01020304 00000000 00000000 00000000                                                                             
 +80     00000000 00000000 00000000 00000000                                                                             
 +90     00000000                                                                                                        
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -DCB-     (EXCP W/5 WORD DEVICE INTERFACE) AT LOCATION 00031A60                                                         
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000003   
                                                                                                                         
 -----                                                                                                                   
                                                                                                                         
 +0      00000000 00000000 00000000 00F3203C                                                                             
 +10     002F0000 00000001 00000200 00000001                                                                             
 +20     02000001 90000000 0090D008 009C92AC 1200D008                                                                    
                                                                                                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
 FOR DEB AT LOCATION 009C71C4                                                                                            
 -------------------                                                                                                     
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -UCB-     (DIRECT ACCESS TYPE)            AT LOCATION  00F39B88                                                         
 -----                                                                                                                   
                                                                                                                         
                                                                                                                         
                                                                                                                         
  UCBPRFIX: 00F39B80                                                                                                     
           -0008  LOCK..... 00000000  IOQ...... 00F9BB80                                                                 
                                                                                                                         
  UCBOB: 00F39B88                                                                                                        
           +0000  JBNR..... 01        FL5...... 88        ID....... FF        STAT..... 8C        CHAN..... 0512         
           +0006  FL1...... 00        FLB...... 00        NXUCB.... 00000000  WGT...... 08        NAME..... 512          
           +0010  TBYT1.... 30        TBYT2.... 30        DVCLS.... 20        UNTYP.... 0F        FLC...... 00           
           +0015  EXTP..... F39B60    VTOC..... 002D0100  VOLI..... ACA301    STAB..... 10        DMCT..... 07           
           +0024  SQC...... 00        FL4...... A0        USER..... 000B      BASE..... 00F39988  NEXP..... 025264E8     
                                                                                                                         
  UCBCMXT: 00F39B60                                                                                                      
           +0000  ETI...... 00        STI...... 00        FL6...... 09        ATI...... 40        SNSCT.... 20           
           +0005  FLP1..... AA        STLI..... 00        FL7...... 00        IEXT..... 02531C68  CHPRM.... 00           
           +000D  SATI..... 00        ASID..... 005F      RSV...... 00        WTOID.... 000000    DDT...... 00FCCB9C     
           +0018  CLEXT.... 00F39B28  DCTOF.... 0000      CSFLG.... 00        RSV...... 00                               
                                                                                                                         
  UCBXPX: 02531C68                                                                                                       
           +0000  RSTEM.... 00        MIHKY.... 04        MIHTI.... 00        HOTIO.... 40        IOQF..... 00000000     
           +0008  IOQL..... 00000000  SIDA..... 0001      SCHNO.... 0357      PMCW1.... 289C      MBI...... 00D8         
           +0014  LPM...... F0        RSV...... 00        LPUM..... 10        PIM...... F0        CHPID.... 07101214     
           +001C            FFFFFFFF  LEVEL.... 01        IOSF1.... 08        IOTKY.... 00        MIHFG.... 00           
           +0024  LVMSK.... 00000001                                                                                     
                                                                                                                         
   ACTUAL UCB COMMON SEGMENT ADDRESS 00F39B88                                                                            
                                                                                                                         
   DEVICE IS DYNAMIC                                                                                                     
                                                                                                                         
                                                                                                                         
   BASE UCB OF A PARALLEL ACCESS VOLUME                                                                                  
                                                                                                                         
   BASE UCB HAS BOUND ALIAS UCB 05D2 AT ADDRESS 025266E8                                                                 
                                                                                                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
 FOR DEB AT LOCATION 009C7030                                                                                            
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000004   
                                                                                                                         
 -------------------                                                                                                     
                                                                                                                         
 *** FOR THIS DEB, THERE ARE NO UCBS ***                                                                                 
                                                                                                                         
                                                                                                                         
 FOR DEB AT LOCATION 009C7298                                                                                            
 -------------------                                                                                                     
                                                                                                                         
 *** FOR THIS DEB, THERE ARE NO UCBS ***                                                                                 
                                                                                                                         
                                                                                                                         
 FOR DEB AT LOCATION 009C92AC                                                                                            
 -------------------                                                                                                     
                                                                                                                         
                                                                                                                         
                                                                                                                         
 -UCB-     (DIRECT ACCESS TYPE)            AT LOCATION  00F39B88                                                         
 -----                                                                                                                   
                                                                                                                         
                                                                                                                         
                                                                                                                         
  UCBPRFIX: 00F39B80                                                                                                     
           -0008  LOCK..... 00000000  IOQ...... 00F9BB80                                                                 
                                                                                                                         
  UCBOB: 00F39B88                                                                                                        
           +0000  JBNR..... 01        FL5...... 88        ID....... FF        STAT..... 8C        CHAN..... 0512         
           +0006  FL1...... 00        FLB...... 00        NXUCB.... 00000000  WGT...... 08        NAME..... 512          
           +0010  TBYT1.... 30        TBYT2.... 30        DVCLS.... 20        UNTYP.... 0F        FLC...... 00           
           +0015  EXTP..... F39B60    VTOC..... 002D0100  VOLI..... ACA301    STAB..... 10        DMCT..... 07           
           +0024  SQC...... 00        FL4...... A0        USER..... 000B      BASE..... 00F39988  NEXP..... 025264E8     
                                                                                                                         
  UCBCMXT: 00F39B60                                                                                                      
           +0000  ETI...... 00        STI...... 00        FL6...... 09        ATI...... 40        SNSCT.... 20           
           +0005  FLP1..... AA        STLI..... 00        FL7...... 00        IEXT..... 02531C68  CHPRM.... 00           
           +000D  SATI..... 00        ASID..... 005F      RSV...... 00        WTOID.... 000000    DDT...... 00FCCB9C     
           +0018  CLEXT.... 00F39B28  DCTOF.... 0000      CSFLG.... 00        RSV...... 00                               
                                                                                                                         
  UCBXPX: 02531C68                                                                                                       
           +0000  RSTEM.... 00        MIHKY.... 04        MIHTI.... 00        HOTIO.... 40        IOQF..... 00000000     
           +0008  IOQL..... 00000000  SIDA..... 0001      SCHNO.... 0357      PMCW1.... 289C      MBI...... 00D8         
           +0014  LPM...... F0        RSV...... 00        LPUM..... 10        PIM...... F0        CHPID.... 07101214     
           +001C            FFFFFFFF  LEVEL.... 01        IOSF1.... 08        IOTKY.... 00        MIHFG.... 00           
           +0024  LVMSK.... 00000001                                                                                     
                                                                                                                         
   ACTUAL UCB COMMON SEGMENT ADDRESS 00F39B88                                                                            
                                                                                                                         
   DEVICE IS DYNAMIC                                                                                                     
                                                                                                                         
                                                                                                                         
   BASE UCB OF A PARALLEL ACCESS VOLUME                                                                                  
                                                                                                                         
   BASE UCB HAS BOUND ALIAS UCB 05D2 AT ADDRESS 025266E8                                                                 
                                                                                                                         
                                                                                                                         
                                                                                                                         
                                                                                                                         
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000005   
                                                                                                                         
-SAVE AREA TRACE                                                                                                         
-PROCEEDING FORWARD FROM TCBFSA                                                                                          
0NAME=SPECIALNAME                                                                                                        
      5C5CC7D6                            ***GO            *                                                             
 WAS ENTERED VIA LINK                                                                                                    
 SA   00006B98  WD1 00000000   HSA 00000000   LSA 00031448   RET 80FD16E8   EPA 00031000   R0  00000000                  
                R1  00021980   R2  00021980   R3  0001104F   R4  0001204E   R5  000101F4   R6  80006FE0                  
                R7  0000810C   R8  0000004E   R9  00010368   R10 048D833E   R11 048D733F   R12 848D6340                  
 SA   00031448  WD1 FFFFFFFF   HSA 00006B98   LSA FFFFFFFF   RET FFFFFFFF   EPA FFFFFFFF   R0  50031298                  
                R1  00CFE038   R2  00006AB0   R3  00031A94   R4  00031A94   R5  00006AB0   R6  0003C750                  
                R7  0003C750   R8  00000050   R9  00000030   R10 00CEBD10   R11 00CFE1AA   R12 00CEBD10                  
-INTERRUPT AT 0003170E                                                                                                   
-PROCEEDING BACK VIA REG 13                                                                                              
 SA   00031448  WD1 FFFFFFFF   HSA 00006B98   LSA FFFFFFFF   RET FFFFFFFF   EPA FFFFFFFF   R0  50031298                  
                R1  00CFE038   R2  00006AB0   R3  00031A94   R4  00031A94   R5  00006AB0   R6  0003C750                  
                R7  0003C750   R8  00000050   R9  00000030   R10 00CEBD10   R11 00CFE1AA   R12 00CEBD10                  
0NAME=SPECIALNAME                                                                                                        
      5C5CC7D6                            ***GO            *                                                             
 WAS ENTERED VIA LINK                                                                                                    
 SA   00006B98  WD1 00000000   HSA 00000000   LSA 00031448   RET 80FD16E8   EPA 00031000   R0  00000000                  
                R1  00021980   R2  00021980   R3  0001104F   R4  0001204E   R5  000101F4   R6  80006FE0                  
                R7  0000810C   R8  0000004E   R9  00010368   R10 048D833E   R11 048D733F   R12 848D6340                  
                                                                                                                         
   REGISTERS AT ENTRY TO SNAP                                                                                            
                                                                                                                         
   FLOATING POINT REGISTER VALUES                                                                                        
       FPC  00000000                                                                                                     
       0-3  00000000 00000000    00000000 00000000    00000000 00000000    00000000 00000000                             
       4-7  00000000 00000000    00000000 00000000    00000000 00000000    00000000 00000000                             
       8-11 00000000 00000000    00000000 00000000    00000000 00000000    00000000 00000000                             
      12-15 00000000 00000000    00000000 00000000    00000000 00000000    00000000 00000000                             
                                                                                                                         
   GPR VALUES                                                                                                            
       0-3  00000BF0  900316E8  00021980  0001104F                                                                       
       4-7  00031C94  00000000  00000050  000219A3                                                                       
       8-11 000219A2  00010368  048D833E  90031366                                                                       
      12-15 00031000  00031448  50031298  00000000                                                                       
                                                                                                                         
   ACCESS REGISTER VALUES                                                                                                
       0-3  00000000  00000000  00000000  00000000                                                                       
       4-7  00000000  00000000  00000000  00000000                                                                       
       8-11 00000000  00000000  00000000  00000000                                                                       
      12-15 00000000  00000000  00000000  00000000                                                                       
                                                                                                                         
0-STORAGE                                                                                                                
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000006   
                                                                                                                         
000031000 90ECD00C 18CF41E0 C44850D0 E00450E0    D00818DE 5010C3E0 4110C440 41F0C30A   *..}....\D.&}\.&\}...&.C\..D .0C.*
 00031020 410000B3 89000018 0A2F0700 4510C03C    00031A94 00031A60 8F031B4C 0A1312FF   *....i.........{....m...-...<....*
 00031040 4770C2C4 9110CAC4 4780C2C4 9110CA90    4780C2C4 9110CB7C 4780C2C4 17771788   *..BDj..D..BDj.....BDj..@..BD...h*
 00031060 BF77C3E1 BF777001 48807000 41707002    1A87D231 C52AC94A 45B0C4F8 4510C0A0   *..C..............gK.E.I›..D8..{.*
 00031080 00728000 00000000 00031B4C 00000000    00031098 00000000 00021986 800219A2   *...........<.......q.......f...s*
 000310A0 50701018 5080101C 9680101C 0A3312FF    45E0C33E 197847B0 C2884160 C4349240   *&...&...o........\C.....Bh.-D.k *
 000310C0 C434D206 C435C434 197847B0 C0E8956B    70004780 C0E8D200 60007000 41707001   *D.K.D.D.....{Yn,....{YK.-.......*
 000310E0 41606001 47F0C0C8 D207CA24 C4344110    CA604100 CA204111 00001FFF 0A1212FF   *.--..0{HK...D....-..............*
 00031100 4770C2E4 D203C3D0 CA2CD231 C52AC81E    45B0C4F8 4510C138 00728000 00000000   *..BUK.C}..K.E.H...D8..A.........*
 00031120 00031B4C 00000000 00031130 00000000    00031A20 80031A94 9680101C 0A3312FF   *...<...................mo.......*
 00031140 45E0C33E D231C52A C850D207 C55CC434    45B0C4F8 900FC388 58F0004C 58F0F01C   *.\C.K.E.H&K.E*D...D8..Ch.0.<.00.*
 00031160 BF0FC3D0 5810CA8C 4120C3C8 186C05EF    18C612FF 4770C338 D207C4B8 C3C85860   *..C}......CH.%...F....C.K.D.CH.-*
 00031180 C4BCA76A FFFF5060 C4BC980F C388D703    C494C494 4110C498 96011000 0A004100   *D.x...&-D.q.ChP.DmDm..Dqo.......*
 000311A0 00014110 C4940A01 91D0C4A4 4770C31A    91BFC4A5 4770C320 957FC494 4780C1D8   *....Dm..j}Du..C.j.Dv..C.n"Dm..AQ*
 000311C0 9541C494 4770C326 9101C4A4 4710C344    9102C4A4 4780C1D8 4150C4F0 5950C4A0   *n.Dm..C.j.Du..C.j.Du..AQ.&D0.&D.*
 000311E0 4770C32C D500C4BF C4F447D0 C1FA9501    C4F44780 C2A047F0 C3325860 C4BCA76A   *..C.N.D.D4.}A.n.D4..B..0C..-D.x.*
 00031200 00015060 C4BCD504 CC4DC3D8 4770C214    92F1C788 4850C4F6 41600050 4140CC44   *..&-D.N..(CQ..B.k1Gh.&D6.-.&. ..*
 00031220 D24FCBA4 40004110 CA944100 CBF41FFF    BFF71031 05EF47F0 C23E47F0 C352D54F   *K|.u ....m...4...7.....0B..0C.N|*
 00031240 CBF4CBA4 45E0C33E 45B0C5B0 D231C52A    C788D201 C550C3D4 D201C556 C3D6D24F   *.4.u.\C...E.K.E.GhK.E&CMK.E.COK|*
 00031260 C55CCBA4 45B0C4F8 9240C788 41464000    1B561255 4720C220 92F0C788 47F0C18E   *E*.u..D8k Gh.. .......B.k0Gh.0A.*
 00031280 A77A0001 47F0C0B4 4110CA94 4100CBF4    1FFFBFF7 103105EF 47F0C2D4 47F0C352   *x:...0{....m...4...7.....0BM.0C.*
 000312A0 1766BF63 C3D04160 6001BE63 C3D01766    A7680001 4260C3D2 9200C386 9260C788   *....C}.--...C}..x....-CKk.Cfk-Gh*
 000312C0 47F0C154 41100381 41000080 89000018    16100A0D 41100381 41000080 89000018   *.0A....a....i..........a....i...*
 000312E0 16100A0D 05E047F0 C6E04110 03814100    00808900 00181610 0A0D4110 03DB4100   *.....\.0F\...a....i.............*
 00031300 00808900 00181610 0A0D4110 031E4100    00808900 00181610 0A0D05E0 47F0C6E0   *..i...............i........\.0F\*
 00031320 05E047F0 C6E005E0 47F0C6E0 05E047F0    C6E005E0 47F0C6E0 05E047F0 C6E04770   *.\.0F\.\.0F\.\.0F\.\.0F\.\.0F\..*
 00031340 C6E007FE D231C52A C7EC45B0 C4F847F0    C280D231 C52AC7BA 45B0C4F8 D231C52A   *F\..K.E.G...D8.0B.K.E.G...D8K.E.*
 00031360 C8B445B0 C4F847F0 C6E0D231 C52AC8E6    D207C55C CA2445B0 C4F847F0 C28047F0   *H...D8.0F\K.E.HWK.E*....D8.0B..0*
 00031380 E0040050 0C802100 00000048 7F761028    00021980 0001104F 000326E4 00000000   *\..&........"..........|...U....*
 000313A0 00031438 000219A2 000219A2 00010368    048D833E 80031154 00031000 00031448   *.......s...s......c.............*
 000313C0 80031144 00000000 00000000 84000302    00010200 F2F1F0C1 D4C1C3D9 D6000000   *............d.......210AMACRO...*
 000313E0 00021980 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *....                            *
 00031400 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031420 40404040 40404040 40404040 40404040    40404040 C2D3C4D3 40404040 00000020   *                    BLDL    ....*
 00031440 F0F0F0F1 F0F0F0C0 FFFFFFFF 00006B98    FFFFFFFF FFFFFFFF FFFFFFFF 50031298   *0001000{......,q............&..q*
 00031460 00CFE038 00006AB0 00031A94 00031A94    00006AB0 0003C750 0003C750 00000050   *..\........m...m......G&..G&...&*
 00031480 00000030 00CEBD10 00CFE1AA 00CEBD10    07000700 41000000 47000000 41031494   *...............................m*
 000314A0 000314E8 0D000C80 000314C0 00031A60    00000000 00000000 00000000 8400030A   *...Y.......{...-............d...*
 000314C0 23031386 40000001 310314BB 40000005    080314C8 00000000 1E0314F0 80000008   *...f ....... ......H.......0....*
 000314E0 00031C44 60000C80 22031386 00000001    00840003 0B000000 90E0C50C 4100C52A   *....-......f.....d.......\E...E.*
 00031500 58F0C508 070005EF 000328E8 50031298    00000000 00000BF0 008598E0 E0049240   *.0E........Y&..q.......0.eq\\.k *
 00031520 C52AD283 C52BC52A 07FB4040 40404040    40404040 40404040 40404040 40404040   *E.KcE.E...                      *
 00031540 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
       LINES 00031560-00031580  SAME AS ABOVE                                                                            
 000315A0 40404040 40404040 40404040 40404000    F321C6D6 C4BFD201 C3D6C6D6 DC01C3D6   *               .3.FOD.K.COFO..CO*
 000315C0 C5D6F321 C6D9C386 D201C3D4 C6D9DC01    C3D4C5D6 07FB4040 40404040 40404040   *EO3.FRCfK.CMFR..CMEO..          *
 000315E0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
       LINES 00031600-000316A0  SAME AS ABOVE                                                                            
 000316C0 40404040 4040F0F1 F2F3F4F5 F6F7F8F9    C1C2C3C4 C5C6F0FA 32F2F100 00000000   *      0123456789ABCDEF0..21.....*
 000316E0 900FC728 4510C708 00728000 0180A400    00031B4C 00000000 00031700 00000000   *..G...G.......u....<............*
 00031700 00031000 800328C4 9680101C 0A3312FF    4770C716 0A034110 0FFF4100 00808900   *.......Do.........G...........i.*
 00031720 00181610 0A0D0000 00000BF0 009C7410    00021980 0001104F 00031C94 00000000   *...........0...........|...m....*
 00031740 00000050 000219A3 000219A2 00010368    048D833E 90031366 00031000 00031448   *...&...t...s......c.............*
 00031760 50031298 00000000 E2D5C1C2 E2C1E5C5    40E2C1E5 C540C1D9 C5C140C1 C2D6E5C5   *&..q....SNABSAVE SAVE AREA ABOVE*
 00031780 40404040 40404040 F0E7C4C1 D740C2C4    E3F5F3F1 C940E388 8540E7C4 C1D74099   *        0XDAP BDT531I The XDAP r*
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000007   
                                                                                                                         
 000317A0 85839699 844089A2 7A4040E2 7B7A4040    40D97B7A 40404040 404060E7 C4C1D740   *ecord is:  S#:   R#:      -XDAP *
 000317C0 C2C4E3F5 F3F2C940 C5D6C640 C5958396    A495A385 99858440 969540D8 E2C1D440   *BDT532I EOF Encountered on QSAM *
 000317E0 86899385 4B404040 40404040 60E7C4C1    D740C2C4 E3F5F3F3 C940C5D6 C640C595   *file.       -XDAP BDT533I EOF En*
 00031800 8396A495 A3859985 84409695 40E2D7C1    D4408689 93854B40 40404040 404060E7   *countered on SPAM file.       -X*
 00031820 C4C1D740 C2C4E3F5 F3F4C940 E2D5C1D7    40C2D3C4 D3A38182 938561E7 C4C1D760   *DAP BDT534I SNAP BLDLtable/XDAP-*
 00031840 C4C3C240 86969393 96A6A27A 40404040    60E7C4C1 D740C2C4 E3F5F3F5 C940D485   *DCB follows:    -XDAP BDT535I Me*
 00031860 94828599 40958194 8540A4A2 85844089    9540C6C9 D5C461C2 D3C4D340 89A27A40   *mber name used in FIND/BLDL is: *
 00031880 404060E7 C4C1D740 C2C4E3F5 F3F8C940    E2D5C1D7 4084A494 97409686 40D7C1D9   *  -XDAP BDT538I SNAP dump of PAR*
 000318A0 D4A24086 969940A2 A4829796 969340F0    7A404040 60E7C4C1 D740C2C4 E3F5F3F9   *Ms for subpool 0:   -XDAP BDT539*
 000318C0 C940D787 94408396 94979385 A3856B40    E2D5C1D7 4084A494 97408696 939396A6   *I Pgm complete, SNAP dump follow*
 000318E0 A27A4040 404060E7 C4C1D740 C2C4E3F5    F4F0C940 D5969560 85A789A2 A3899587   *s:    -XDAP BDT540I Non-existing*
 00031900 40C6C9D5 C4409581 94854089 A27A4040    40404040 40404040 60E7C4C1 D740C2C4   * FIND name is:          -XDAP BD*
 00031920 E3F5F4F1 C940E2D5 C1D74096 8640D396    A6948594 6B40C3E5 E36B40E2 E5C3C6D3   *T541I SNAP of Lowmem, CVT, SVCFL*
 00031940 C9C86B40 E3C3C27A 404060E7 C4C1D740    C2C4E3F5 F4F2C940 C7D7C1D9 D4408789   *IH, TCB:  -XDAP BDT542I GPARM gi*
 00031960 A5859540 86969940 9787947A 40404040    40404040 40404040 40404040 60E7C4C1   *ven for pgm:                -XDA*
 00031980 D740C2C4 E3F5F4F2 C940D596 A3408485    86899585 84404040 40404040 40404040   *P BDT542I Not defined           *
 000319A0 40404040 40404040 40404040 404060E7    C4C1D740 C2C4E3F5 F4F4C940 D596A340   *              -XDAP BDT544I Not *
 000319C0 84858689 95858440 40404040 40404040    40404040 40404040 40404040 40404040   *defined                         *
 000319E0 60E7C4C1 D740C2C4 E3F5F4F5 C940D596    A3408485 86899585 84404040 40404040   *-XDAP BDT545I Not defined       *
 00031A00 40404040 40404040 40404040 40404040    40400000 00000000 00000000 00000000   *                  ..............*
 00031A20 0001003C C2D3C4D3 40404040 00010200    00060001 07000089 198FE2E6 E8D34040   *....BLDL    ...........i..SWYL  *
 00031A40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031A60 00000000 00000000 00000000 00F3203C    002F0000 00000001 00000200 00000001   *.............3..................*
 00031A80 02000001 90000000 0090D008 009C92AC    1200D008 00000000 00000000 00840003   *..........}...k...}..........d..*
 00031AA0 0AF3203C 002FE5A2 0303BA78 00004000    00006A40 0203137E 90000000 01445000   *.3....Vs...... .... ...=......&.*
 00031AC0 C09C71C4 16CFE038 00CEBD10 0A000001    00090C80 30013030 00006B50 0003C750   *{..D..\...................,&..G&*
 00031AE0 0003C750 00000050 00000000 00000000    00DF6690 00000000 00000000 00000000   *..G&...&........................*
 00031B00 00000000 00000000 00000001 00004000    00000001 00000001 84000000 D6E4E3F2   *.............. .........d...OUT2*
 00031B20 40404040 02000020 00000001 00000001    00000085 00000000 00000001 00000001   *    ...............e............*
 00031B40 00000001 00000085 00000001 00000000    00000000 00000000 00000000 00000000   *.......e........................*
 00031B60 00000001 00004000 00006A20 02000001    54000000 01580020 009C7298 92E06054   *...... ....................qk\-.*
 00031B80 00E06070 00000001 08000372 00000000    000068C0 00000001 00000001 0000007D   *.\-................{...........'*
 00031BA0 00000001 40404040 40404040 40D4C5D5    C4404040 40404040 40404040 40404040   *....         MEND               *
 00031BC0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031BE0 40404040 40404040 40404040 F4F0F2F0    F0F0F1F7 40404040 40404040 40D4C5D5   *            40200017         MEN*
 00031C00 C4404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *D                               *
 00031C20 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F4F0F2F0   *                            4020*
 00031C40 F0F0F1F7 40404040 40404040 40D4C5D5    C4404040 40404040 40404040 40404040   *0017         MEND               *
 00031C60 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031C80 40404040 40404040 40404040 F4F0F2F0    F0F0F1F7 4BC5F240 40404040 40C9C8C2   *            40200017.E2      IHB*
 00031CA0 C5D9D4C1 C340F3F4 40404040 40404040    40404040 40404040 40404040 D3C9E2E3   *ERMAC 34                    LIST*
 00031CC0 40C1C4C4 D940D4C9 E2E2C9D5 C7404040    40404040 40404040 40404040 F0F5F1F8   * ADDR MISSING               0518*
 00031CE0 F0F0F1F9 4BC9D9D6 E4E3D9D5 40C4C340    404040C1 D3F14D50 C1E2E4D4 5D404040   *0019.IROUTRN DC    AL1(&ASUM)   *
 00031D00 40404040 40404040 40404040 40404040    40404040 40D6D7E3 C9D6D540 C2E8E3C5   *                     OPTION BYTE*
 00031D20 40404040 40404040 40404040 F0F2F5F8    F0F0F0F0 40404040 40404040 40C4C340   *            02580000         DC *
 00031D40 404040C1 D3F34D50 D7C1D9F1 4D50C3E3    D95D5D40 40404040 40404040 40404040   *   AL3(&PAR1(&CTR))             *
 00031D60 40404040 40C4C3C2 40C1C4C4 D9C5E2E2    40404040 40404040 40404040 F0F2F6F0   *     DCB ADDRESS            0260*
 00031D80 F0F0F0F0 4BE4D7C3 E3D9E240 40C1C9C6    4040404D 50C3E3D9 F140C7C5 4050D5E4   *0000.UPCTRS  AIF   (&CTR1 GE &NU*
 00031DA0 D4C2C5D9 5D4BD8E4 C9E3E240 40404040    40404040 40404040 40404040 40404040   *MBER).QUITS                     *
 00031DC0 40404040 40404040 40404040 F0F2F6F2    F0F0F0F0 50C3E3D9 40404040 40E2C5E3   *            02620000&CTR     SET*
 00031DE0 C1404050 C3E3D94E F2404040 40404040    40404040 40404040 40404040 40404040   *A  &CTR+2                       *
 00031E00 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F6F4   *                            0264*
 00031E20 F0F0F0F0 50C3E3D9 F1404040 40E2C5E3    C1404050 C3E3D9F1 4EF24040 40404040   *0000&CTR1    SETA  &CTR1+2      *
 00031E40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031E60 40404040 40404040 40404040 F0F2F6F6    F0F0F0F0 40404040 40404040 40C1C7D6   *            02660000         AGO*
 00031E80 4040404B D9E3C5E8 C5404040 40404040    40404040 40404040 40404040 40404040   *   .RTEYE                       *
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000008   
                                                                                                                         
 00031EA0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F6F8   *                            0268*
 00031EC0 F0F0F0F0 4BD8E4C9 E3E24040 40C1D5D6    D7404040 40404040 40404040 40404040   *0000.QUITS   ANOP               *
 00031EE0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031F00 40404040 40404040 40404040 F0F2F7F0    F0F0F0F0 50C3E3D9 40404040 40E2C5E3   *            02700000&CTR     SET*
 00031F20 C14040F1 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *A  1                            *
 00031F40 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F7F2   *                            0272*
 00031F60 F0F0F0F0 50C3E3D9 F1404040 40E2C5E3    C14040F2 40404040 40404040 40404040   *0000&CTR1    SETA  2            *
 00031F80 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00031FA0 40404040 40404040 40404040 F0F2F7F4    F0F0F0F0 4BC9D3D6 D6D7F240 40C1C9C6   *            02740000.ILOOP2  AIF*
 00031FC0 4040404D 7D50D7C1 D9F14D50 C3E3D95D    7D4DF16B F15D40D5 C5407D4D 7D5D4BE4   *   ('&PAR1(&CTR)'(1,1) NE '(').U*
 00031FE0 D7C3E3D9 F2404040 40404040 40404040    40404040 40404040 40404040 F0F2F7F6   *PCTR2                       0276*
 00032000 F0F0F0F0 50D3C7E3 C8404040 40E2C5E3    C14040D2 7D50D7C1 D9F14D50 C3E3D95D   *0000&LGTH    SETA  K'&PAR1(&CTR)*
 00032020 60F24040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *-2                              *
 00032040 40404040 40404040 40404040 F0F2F7F8    F0F0F0F0 50D7C1D9 C1404040 40E2C5E3   *            02780000&PARA    SET*
 00032060 C340407D 50D7C1D9 F14D50C3 E3D95D7D    4DF26B50 D3C7E3C8 5D404040 40404040   *C  '&PAR1(&CTR)'(2,&LGTH)       *
 00032080 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F8F0   *                            0280*
 000320A0 F0F0F0F0 40404040 40404040 40E2E340    40404050 D7C1D9C1 6B50C1C3 E3D94B4D   *0000         ST    &PARA,&ACTR.(*
 000320C0 F16BF05D 40404040 40404040 40404040    40404040 40E2E3D6 D9C540C4 C3C240C1   *1,0)                 STORE DCB A*
 000320E0 C4C4D9C5 E2E24040 40404040 F0F2F8F2    F0F0F0F0 50D4C6C9 F2E2E640 40E2C5E3   *DDRESS      02820000&MFI2SW  SET*
 00032100 C24040F1 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *B  1                            *
 00032120 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F8F4   *                            0284*
 00032140 F0F0F0F0 40404040 40404040 40C1C7D6    4040404B C3D3D9E2 E6404040 40404040   *0000         AGO   .CLRSW       *
 00032160 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00032180 40404040 40404040 40404040 F0F2F8F6    F0F0F0F0 4BC9F2D9 D6E4E340 40C1C9C6   *            02860000.I2ROUT  AIF*
 000321A0 4040404D 50C1E2E4 D440C5D8 40F05D4B    E4D7C3E3 D9F24040 40404040 40404040   *   (&ASUM EQ 0).UPCTR2          *
 000321C0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F8F8   *                            0288*
 000321E0 F0F0F0F0 40404040 40404040 40D4E5C9    40404050 C1C3E3D9 4B4DF15D 6B50C1E2   *0000         MVI   &ACTR.(1),&AS*
 00032200 E4D44040 40404040 40404040 40404040    40404040 40D4D6E5 C540C9D5 40D6D7E3   *UM                   MOVE IN OPT*
 00032220 C9D6D540 C2E8E3C5 40404040 F0F2F9F0    F0F0F0F0 4BE4D7C3 E3D9F240 40C1C9C6   *ION BYTE    02900000.UPCTR2  AIF*
 00032240 4040404D 50C3E3D9 F140C7C5 4050D5E4    D4C2C5D9 5D4BE2E5 C3E2E5C3 40404040   *   (&CTR1 GE &NUMBER).SVCSVC    *
 00032260 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F9F2   *                            0292*
 00032280 F0F0F0F2 50C3E3D9 40404040 40E2C5E3    C1404050 C3E3D94E F2404040 40404040   *0002&CTR     SETA  &CTR+2       *
 000322A0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 000322C0 40404040 40404040 40404040 F0F2F9F4    F0F0F0F0 50C3E3D9 F1404040 40E2C5E3   *            02940000&CTR1    SET*
 000322E0 C1404050 C3E3D9F1 4EF24040 40404040    40404040 40404040 40404040 40404040   *A  &CTR1+2                      *
 00032300 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F9F6   *                            0296*
 00032320 F0F0F0F0 50C1C3E3 D9404040 40E2C5E3    C1404050 C1C3E3D9 4EF44040 40404040   *0000&ACTR    SETA  &ACTR+4      *
 00032340 40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *
 00032360 40404040 40404040 40404040 F0F2F9F8    F0F0F0F0 40404040 40404040 40C1C7D6   *            02980000         AGO*
 00032380 4040404B C9D3D6D6 D7F24040 40404040    40404040 40404040 40404040 40404040   *   .ILOOP2                      *
 000323A0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F0F0   *                            0300*
 000323C0 F0F0F0F0 4BC5D9D9 D6D9F240 40C9C8C2    C5D9D4C1 C340F4F9 6B6B50D7 C1D9F14D   *0000.ERROR2  IHBERMAC 49,,&PAR1(*
 000323E0 50C3E3D9 F15D4040 40404040 C9D5E5C1    D3C9C440 D6D7E3C9 D6D540D6 D7C5D9C1   *&CTR1)      INVALID OPTION OPERA*
 00032400 D5C44040 40404040 40404040 F0F3F0F2    F0F0F0F2 40404040 40404040 40D4C5E7   *ND          03020002         MEX*
 00032420 C9E34040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *IT                              *
 00032440 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F0F4   *                            0304*
 00032460 F0F0F0F0 4BC5D9D9 D6D9F340 40C9C8C2    C5D9D4C1 C340F3F5 6B6B50D4 C6404040   *0000.ERROR3  IHBERMAC 35,,&MF   *
 00032480 40404040 40404040 40404040 C9D5E5C1    D3C9C440 D4C640D6 D7C5D9C1 D5C440E2   *            INVALID MF OPERAND S*
 000324A0 D7C5C3C9 C6C9C5C4 40404040 F0F3F0F6    F0F0F0F2 40404040 40404040 40D4C5E7   *PECIFIED    03060002         MEX*
 000324C0 C9E34040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *IT                              *
 000324E0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F0F8   *                            0308*
 00032500 F0F0F0F0 4BC5D9D9 D6D9F540 40C9C8C2    C5D9D4C1 C340F0F6 40404040 40404040   *0000.ERROR5  IHBERMAC 06        *
 00032520 40404040 40404040 40404040 C4C3C240    D4C9E2E2 C9D5C740 40404040 40404040   *            DCB MISSING         *
 00032540 40404040 40404040 40404040 F0F3F1F0    F0F0F0F2 40404040 40404040 40D4C5E7   *            03100002         MEX*
 00032560 C9E34040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *IT                              *
 00032580 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F1F2   *                            0312*
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000009   
                                                                                                                         
 000325A0 F0F0F0F0 4BC5D9D9 D6D9F640 40C9C8C2    C5D9D4C1 C340F6F9 40404040 40404040   *0000.ERROR6  IHBERMAC 69        *
 000325C0 40404040 40404040 40404040 C9D5E5C1    D3C9C440 D9C5C740 D5D6E3C1 E3C9D6D5   *            INVALID REG NOTATION*
 000325E0 40E661D4 C67ED340 40404040 F0F3F1F4    F0F0F0F2 40404040 40404040 40D4C5E7   * W/MF=L     03140002         MEX*
 00032600 C9E34040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *IT                              *
 00032620 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F1F4   *                            0314*
 00032640 F6F0F2F0 4BC5D9D9 D6D9F840 40C9C8C2    C5D9D4C1 C340F6F3 6B6B50E3 E8D7C540   *6020.ERROR8  IHBERMAC 63,,&TYPE *
 00032660 40404040 40404040 40404040 C9D5E5C1    D3C9C440 E3E8D7C5 40D6D7C5 D9C1D5C4   *            INVALID TYPE OPERAND*
 00032680 40404040 40D4F0F6 F2F64040 F0F3F1F5    F6F0F2F0 4BC6C9D5 C9404040 40D4C5D5   *     M0626  03156020.FINI    MEN*
 000326A0 C4404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *D                               *
 000326C0 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F3F1F6   *                            0316*
 000326E0 F0F0F0F0 4BE3C5E2 E3C94040 40C3D5D6    D74040F0 6BF44040 40404040 40404040   *0000.TESTI   CNOP  0,4          *
 00032700 40404040 40404040 40404040 40404040    40404040 40C1D3C9 C7D540D3 C9E2E340   *                     ALIGN LIST *
 00032720 E3D640C6 E4D3D3E6 D6D9C440 F0F2F4F2    F0F0F0F2 50D3C7E3 C8404040 40E2C5E3   *TO FULLWORD 02420002&LGTH    SET*
 00032740 C140404D 4D50D5E4 D4C2C5D9 4EF15D61    F25D5CF4 4EF44040 40404040 40404040   *A  ((&NUMBER+1)/2)*4+4          *
 00032760 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F4F4   *                            0244*
 00032780 F0F0F0F2 50C3D5C1 D4C54040 40C2C1D3    404040F1 6B5C4E50 D3C7E3C8 40404040   *0002&CNAME   BAL   1,*+&LGTH    *
 000327A0 40404040 40404040 40404040 40404040    40404040 40D3D6C1 C440D9C5 C7F140E6   *                     LOAD REG1 W*
 000327C0 61D3C9E2 E340C1C4 C4D94040 F0F2F4F6    F0F0F0F2 50D4C6C9 E2E64040 40E2C5E3   */LIST ADDR  02460002&MFISW   SET*
 000327E0 C24040F1 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *B  1                            *
 00032800 40404040 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F4F8   *                            0248*
 00032820 F0F0F0F0 4BD9E3C5 E8C54040 40C1C9C6    4040404D 7D50D7C1 D9F14D50 C3E3D95D   *0000.RTEYE   AIF   ('&PAR1(&CTR)*
 00032840 7D40C5D8 407D7D5D 4BC5D9D9 D6D9F540    40404040 40404040 40404040 40404040   *' EQ '').ERROR5                 *
 00032860 40404040 40404040 40404040 F0F2F5F0    F0F0F0F0 40404040 40404040 40C1C9C6   *            02500000         AIF*
 00032880 4040404D 7D50D7C1 D9F14D50 C3E3D95D    7D4DF16B F15D40D5 C5407D4D 7D5D4BC3   *   ('&PAR1(&CTR)'(1,1) NE '(').C*
 000328A0 D3D9E2E6 40404040 40404040 40404040    40404040 40404040 40404040 F0F2F5F2   *LRSW                        0252*
 000328C0 F0F0F0F0 C5D5C440                                                            *0000END                         *
1JOB Z030199A         STEP GO              TIME 141018   DATE 05122                                      PAGE 00000010   
                                                                                                                         
                              DUMP INDEX                                                                                 
                              ----------                                                                                 
0 DATA AREAS                                               PAGE NUMBER                                                   
 -----------                                               -----------                                                   
0AREAS RELATED TO TCB AT: 009D1040/....                    00000001                                                      
 DATA MANAGEMENT CONTROL BLOCKS........                    00000001                                                      
 IOS CONTROL BLOCKS....................                    00000003                                                      
 PCLINK STACKS / SAVE AREAS............                    00000005                                                      
 REGISTERS.............................                    00000005                                                      
 STORAGE AREAS.........................                    00000005                                                      
0END OF DUMP                                                                                                             
 !! END OF JES SPOOL FILE !!
