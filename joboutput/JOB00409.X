1                        J E S 2  J O B  L O G  --  S Y S T E M  P R O D  --  N O D E  N I U             
0 
 16.48.57 JOB00409 ---- TUESDAY,   03 MAY 2005 ----
 16.48.57 JOB00409  $HASPU01 JOB PARMS - TIME=(0,5),LINES=10,CARDS=100,TAPES=0,ROOM=199
 16.48.57 JOB00409  $HASP373 Z030199A STARTED - INIT 14   - CLASS M - SYS PROD
 16.48.57 JOB00409  ACF9CCCD USERID Z030199  IS ASSIGNED TO THIS JOB - Z030199A
 16.48.57 JOB00409  IEF403I Z030199A - STARTED - TIME=16.48.57
 16.48.57 JOB00409  AMS000I: STEP END  Z030199A.ASM       RC=  0000    CPU= 00:00:00.03    PGM=ASMA90
 16.48.57 JOB00409  AMS000I: STEP END  Z030199A.STEP2     RC=  0000    CPU= 00:00:00.03    PGM=IEBCOPY
 16.48.58 JOB00409  AMS000I: STEP END  Z030199A.ASSISTV   RC=  0000    CPU= 00:00:00.38    PGM=ASSISTV
 16.48.58 JOB00409  IEF404I Z030199A - ENDED - TIME=16.48.58
 16.48.58 JOB00409  AMS000I: JOB  END  Z030199A  Brandon Twee          CPU= 00:00:00.44
 16.48.58 JOB00409  $HASP395 Z030199A ENDED
0------ JES2 JOB STATISTICS ------                                                                                                   
-  03 MAY 2005 JOB EXECUTION DATE                                                                                                    
-        3,157 CARDS READ                                                                                                            
-        5,040 SYSOUT PRINT RECORDS                                                                                                  
-            0 SYSOUT PUNCH RECORDS                                                                                                  
-          459 SYSOUT SPOOL KBYTES                                                                                                   
-         0.02 MINUTES EXECUTION TIME                                                                                                
 !! END OF JES SPOOL FILE !!
        1 //Z030199A JOB ,'Brandon Tweed',REGION=2M,                              JOB00409
          //             MSGCLASS=X                                                       
          /*JOBPARM ROOM=199,L=10                                                         
          //* $ACFJ219 ACF2 ACTIVE NIU                                                ACF2
        2 //STEP1 EXEC HLASMC  YOU SHOULD NOT NEED ADDITIONAL SYSLIB!                     
        3 XXHLASMC PROC  CDISP=,                     SYSLIN INITIAL DISP          00001000
          XX             CPARM=,                     PARMS FOR ASSEMBLY STEP      00002000
          XX             CREGION=512K,               REGION FOR ASSEMBLY STEP     00003000
          XX*            LEVEL=SYS2,                                              00004000
          XX             UNIT=VIO,                   SYSLIN UNIT                  00005000
          XX             UTUNIT=VIO,                 SYSUT1 UNIT                  00006000
          XX             UTSPACE='(CYL,(1,1))' ,     SYSUT1 SPACE ALLOCATION      00007000
          XX*            VERSION=V120                HIGH LEVEL ASSMBLR VERSION   00008000
          XX*                                                                     00009000
          XX***   HLASMC                                                          00010000
          XX*                                                                     00011000
          XX* THIS PROCEDURE RUNS THE HIGH LEVEL ASSEMBLER AND CAN BE USED        00012000
          XX* TO ASSEMBLE PROGRAMS.                                               00013000
          XX*                                                                     00014000
        4 XXASM      EXEC PGM=ASMA90,PARM='&CPARM',REGION=&CREGION                00015000
          XX*STEPLIB  DD  DSN=&LEVEL..HLA.&VERSION..LOADLIB,DISP=SHR              00016000
          IEFC653I SUBSTITUTION JCL - PGM=ASMA90,PARM='',REGION=512K
        5 XXSYSLIB   DD  DSN=SYS1.MACLIB,DISP=SHR                                 00017000
        6 XX         DD  DSN=SYS2.MACLIB,DISP=SHR                                 00018000
        7 XXSYSUT1   DD  DSN=&&SYSUT1,SPACE=&UTSPACE,UNIT=&UTUNIT,                00019000
          XX             DCB=BUFNO=1                                              00020000
          IEFC653I SUBSTITUTION JCL - DSN=&&SYSUT1,SPACE=(CYL,(1,1)),UNIT=VIO,DCB=BUFNO=1
        8 XXSYSPRINT DD  SYSOUT=*,DCB=BUFNO=1                                     00021000
        9 XXSYSPUNCH DD  SYSOUT=B,DCB=BUFNO=1                                     00022000
       10 XXSYSTERM  DD  SYSOUT=*,DCB=BUFNO=1                                     00023000
       11 //ASM.SYSLIN DD DSN=&&O(SVC8),SPACE=(6160,(1,1,1)),  NO X IN COL 72             
          //*456789A123456                        CARD COLUMNS                            
          //             DCB=(LRECL=80,RECFM=FB) 'DCB' =MUST= BEGIN IN COL 16             
          X/SYSLIN   DD  DSN=&&OBJSET,SPACE=(3040,(40,40),,,ROUND),UNIT=&UNIT,    00024000
          X/             DISP=(&CDISP,PASS,DELETE),                               00025000
          X/             DCB=(BLKSIZE=3040,LRECL=80,RECFM=FBS,BUFNO=1)            00026000
          //*ASM.SYSLIB DD                                                                
          //*           DD                                                                
          //*           DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR ASK IF NEEDED             
          IEFC653I SUBSTITUTION JCL - DSN=&&OBJSET,SPACE=(3040,(40,40),,,ROUND),UNIT=VIO,DISP=(,PASS,DELETE),
          DCB=(BLKSIZE=3040,LRECL=80,RECFM=FBS,BUFNO=1)
       12 //ASM.SYSIN DD *                                                                
       13 //STEP2 EXEC PGM=IEBCOPY                                                        
       14 //SYSPRINT DD SYSOUT=*                                                          
       15 //OLD DD DSN=&&O,DISP=(OLD,PASS)                                                
       16 //NEW DD DSN=&&OO,DISP=(NEW,PASS),SPACE=(6160,(1,1,1))                          
       17 //SYSIN DD *                                                                    
       18 //ASSISTV EXEC PGM=ASSISTV,                                                     
          // PARM='P=100,PX=50,R=5000,RX=3000,L=60,XREF=0',                               
          // REGION=512K                                                                  
       19 //STEPLIB DD DSN=USER1.ASSIST.LOADLIB,DISP=SHR                                  
          /*                                                                              
          //* X'00C' is VIRTRDR1 -- PARMS                                                 
       20 //VIRTRDR1 DD DSN=&&O(SVC8),DISP=(OLD,DELETE)                                   
       21 //         DD DSN=&&OO(SVC8),DISP=(OLD,DELETE)                                  
       22 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM1111),DISP=SHR                    
       23 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD8I),DISP=SHR                    
       24 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM2222),DISP=SHR                    
       25 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD9I),DISP=SHR                    
       26 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM3333),DISP=SHR                    
       27 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD8I),DISP=SHR                    
       28 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM4444),DISP=SHR                    
       29 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMODNI),DISP=SHR                    
       30 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(PARM7777),DISP=SHR                    
       31 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD9I),DISP=SHR                    
       32 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
          //*                                                                             
          //* X'00D' is VIRTRDR2 -- USER PROGRAM INPUT                                    
       33 //VIRTRDR2 DD DSN=SYS1.MACLIB(CHECK),DISP=SHR                                   
       34 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
       35 //         DD DSN=SYS1.MACLIB(EOV),DISP=SHR                                     
       36 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
       37 //         DD DSN=SYS1.MACLIB(NOTE),DISP=SHR                                    
       38 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
       39 //         DD DSN=SYS1.MACLIB(ERASE),DISP=SHR                                   
       40 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
       41 //         DD DSN=SYS1.MACLIB(EXCP),DISP=SHR                                    
       42 //         DD DSN=T90RPR1.CS468PUB.OBJLIB(ALLNINES),DISP=SHR                    
          //*                                                                             
       43 //FT06F001 DD SYSOUT=* PRINTOUT FROM THE ASSEMBLY, TRACE, ETC.                  
       44 //SYSPRINT DD SYSOUT=*                                                          
       45 //SYSLIB DD DSN=SYS1.MACLIB,DISP=SHR                                            
       46 // DD DSN=SYS2.MACLIB,DISP=SHR                                                  
       47 // DD DSN=T90RPR1.CS468PUB.MACLIB,DISP=SHR                                      
       48 //SYSIN DD *                                                                    
          //*                                                                             
       49 //FT05F001 DD DUMMY                                                             
          //*         DD DSN=&&O(SVC8),DISP=(OLD,DELETE)                                  
          //*         DD DSN=&&OO(SVC8),DISP=(OLD,DELETE)                                 
          //*         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD8I),DISP=SHR                   
          //*         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD9I),DISP=SHR                   
          //*         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD8I),DISP=SHR                   
          //*         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMODNI),DISP=SHR                   
          //*         DD DSN=T90RPR1.CS468PUB.OBJLIB(OBJMOD9I),DISP=SHR                   
       50 //VIRTPRT1 DD SYSOUT=*,DCB=(BLKSIZE=133,RECFM=FM,BUFNO=1) PRT 000E              
          //*                                                                             
       51 //VIRTPRT2 DD SYSOUT=*,DCB=(BLKSIZE=133,RECFM=FM,BUFNO=1) PRT 000F              
       52 //                                                                              
 !! END OF JES SPOOL FILE !!
  STMT NO. MESSAGE
         2 IEFC001I PROCEDURE HLASMC WAS EXPANDED USING SYSTEM LIBRARY SYS2.PROCLIB
 IEF236I ALLOC. FOR Z030199A ASM STEP1
 IEF237I 0500 ALLOCATED TO SYSLIB
 IEF237I 0517 ALLOCATED TO 
 IGD101I SMS ALLOCATED TO DDNAME (SYSUT1  )
         DSN (SYS05123.T164857.RA000.Z030199A.SYSUT1.H01  )
         STORCLAS (TEMPSTOR) MGMTCLAS (        ) DATACLAS (        )
         VOL SER NOS= TMP301                                                                
 IEF237I JES2 ALLOCATED TO SYSPRINT
 IEF237I JES2 ALLOCATED TO SYSPUNCH
 IEF237I JES2 ALLOCATED TO SYSTERM
 IGD101I SMS ALLOCATED TO DDNAME (SYSLIN  )
         DSN (SYS05123.T164857.RA000.Z030199A.O.H01       )
         STORCLAS (TEMPSTOR) MGMTCLAS (        ) DATACLAS (        )
         VOL SER NOS= TMP303                                                                
 IEF237I JES2 ALLOCATED TO SYSIN
 IEF142I Z030199A ASM STEP1 - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   SYS2.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYS304.                            
 IGD105I SYS05123.T164857.RA000.Z030199A.SYSUT1.H01   DELETED,   DDNAME=SYSUT1  
 IEF285I   Z030199.Z030199A.JOB00409.D0000104.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB00409.D0000105.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB00409.D0000106.?         SYSOUT        
 IGD106I SYS05123.T164857.RA000.Z030199A.O.H01        PASSED,    DDNAME=SYSLIN  
 IEF285I   Z030199.Z030199A.JOB00409.D0000101.?         SYSIN         
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     ASM         START TIME  16:48:57.14   VIRT SYS  USED     280K   PAGE INS              0  STEP CPU      00:00:00.03 *
 * PGM NAME      ASMA90      STOP  TIME 16:48:57.32    VIRT CORE USED   2,048K   PAGE OUTS             0  JOB  CPU      00:00:00.03 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:00.18    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.00 *
 * PERF. GROUP         0     SERV UNITS         174    TRANS ACT TIME  00:00:00.07                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS             153     SRB UNITS               4     I/O UNITS              17        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  SYSLIB        500          0  SYSLIB   + 1  517          0  SYSUT1        518          0  SYSLIN        520          1          *
 *                                                                                                                                  *
 *                                                                                                                                  *
 * EXCP TOTAL               1  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/ASM     /START 2005123.1648
 IEF374I STEP/ASM     /STOP  2005123.1648 CPU    0MIN 00.03SEC SRB    0MIN 00.00SEC VIRT  2048K SYS   280K EXT     432K SYS    9344K
 IEF236I ALLOC. FOR Z030199A STEP2
 IEF237I JES2 ALLOCATED TO SYSPRINT
 IGD103I SMS ALLOCATED TO DDNAME OLD
 IGD101I SMS ALLOCATED TO DDNAME (NEW     )
         DSN (SYS05123.T164857.RA000.Z030199A.OO.H01      )
         STORCLAS (TEMPSTOR) MGMTCLAS (        ) DATACLAS (        )
         VOL SER NOS= TMP301                                                                
 IEF237I JES2 ALLOCATED TO SYSIN
 IEF142I Z030199A STEP2 - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   Z030199.Z030199A.JOB00409.D0000107.?         SYSOUT        
 IGD106I SYS05123.T164857.RA000.Z030199A.O.H01        PASSED,    DDNAME=OLD     
 IGD106I SYS05123.T164857.RA000.Z030199A.OO.H01       PASSED,    DDNAME=NEW     
 IEF285I   Z030199.Z030199A.JOB00409.D0000102.?         SYSIN         
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     STEP2       START TIME  16:48:57.33   VIRT SYS  USED     260K   PAGE INS              0  STEP CPU      00:00:00.03 *
 * PGM NAME      IEBCOPY     STOP  TIME 16:48:57.40    VIRT CORE USED   1,164K   PAGE OUTS             0  JOB  CPU      00:00:00.06 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:00.07    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.00 *
 * PERF. GROUP         0     SERV UNITS         157    TRANS ACT TIME  00:00:00.04                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS             140     SRB UNITS               5     I/O UNITS              12        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  OLD           520          2  NEW           518          3                                                                      *
 *                                                                                                                                  *
 * EXCP TOTAL               5  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/STEP2   /START 2005123.1648
 IEF374I STEP/STEP2   /STOP  2005123.1648 CPU    0MIN 00.03SEC SRB    0MIN 00.00SEC VIRT  1164K SYS   260K EXT      20K SYS    9336K
 IEF236I ALLOC. FOR Z030199A ASSISTV
 IEF237I 050E ALLOCATED TO STEPLIB
 IGD103I SMS ALLOCATED TO DDNAME VIRTRDR1
 IGD103I SMS ALLOCATED TO DDNAME
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0500 ALLOCATED TO VIRTRDR2
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0500 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0500 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0500 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I 0500 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I JES2 ALLOCATED TO FT06F001
 IEF237I JES2 ALLOCATED TO SYSPRINT
 IEF237I 0500 ALLOCATED TO SYSLIB
 IEF237I 0517 ALLOCATED TO 
 IEF237I 0512 ALLOCATED TO 
 IEF237I JES2 ALLOCATED TO SYSIN
 IEF237I DMY  ALLOCATED TO FT05F001
 IEF237I JES2 ALLOCATED TO VIRTPRT1
 IEF237I JES2 ALLOCATED TO VIRTPRT2
 IEF142I Z030199A ASSISTV - STEP WAS EXECUTED - COND CODE 0000
 IEF285I   USER1.ASSIST.LOADLIB                         KEPT          
 IEF285I   VOL SER NOS= ACA302.                            
 IGD105I SYS05123.T164857.RA000.Z030199A.O.H01        DELETED,   DDNAME=VIRTRDR1
 IGD105I SYS05123.T164857.RA000.Z030199A.OO.H01       DELETED,   DDNAME=        
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   T90RPR1.CS468PUB.OBJLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   Z030199.Z030199A.JOB00409.D0000108.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB00409.D0000109.?         SYSOUT        
 IEF285I   SYS1.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYSRES.                            
 IEF285I   SYS2.MACLIB                                  KEPT          
 IEF285I   VOL SER NOS= SYS304.                            
 IEF285I   T90RPR1.CS468PUB.MACLIB                      KEPT          
 IEF285I   VOL SER NOS= ACA301.                            
 IEF285I   Z030199.Z030199A.JOB00409.D0000103.?         SYSIN         
 IEF285I   Z030199.Z030199A.JOB00409.D0000110.?         SYSOUT        
 IEF285I   Z030199.Z030199A.JOB00409.D0000111.?         SYSOUT        
 ************************************************************************************************************************************
 *                                                  STEP TERMINATION STATISTICS                                                     *
 *                                                                                                                                  *
 * STEP NAME     ASSISTV     START TIME  16:48:57.41   VIRT SYS  USED     280K   PAGE INS              0  STEP CPU      00:00:00.38 *
 * PGM NAME      ASSISTV     STOP  TIME 16:48:58.45    VIRT CORE USED     648K   PAGE OUTS             0  JOB  CPU      00:00:00.44 *
 * DISPATCH PRTY   0         ELAP. TIME 00:00:01.04    NUMBER SWAPS           0  NUMBER PAGES          0  SRB TIME      00:00:00.01 *
 * PERF. GROUP         0     SERV UNITS       2,321    TRANS ACT TIME  00:00:00.88                        COMPLETION CODE      0000 *
 *  MAIN STORAGE UNITS           0     CPU UNITS           2,076     SRB UNITS              61     I/O UNITS             184        *
 ************************************************************************************************************************************
 *                                                   EXCP STATISTICS                                                                *
 *                                                                                                                                  *
 *  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT  DDNAME   CC# UNIT EXCP COUNT          *
 *  STEPLIB       50E         13  VIRTRDR1      520          2  VIRTRDR1 + 1  518          2  VIRTRDR1 + 2  512          2          *
 *  VIRTRDR1 + 3  512          2  VIRTRDR1 + 4  512          2  VIRTRDR1 + 5  512          2  VIRTRDR1 + 6  512          2          *
 *  VIRTRDR1 + 7  512          2  VIRTRDR1 + 8  512          2  VIRTRDR1 + 9  512          3  VIRTRDR1 +10  512          2          *
 *  VIRTRDR1 +11  512          2  VIRTRDR1 +12  512          2  VIRTRDR2      500          2  VIRTRDR2 + 1  512          2          *
 *  VIRTRDR2 + 2  500          2  VIRTRDR2 + 3  512          2  VIRTRDR2 + 4  500          2  VIRTRDR2 + 5  512          2          *
 *  VIRTRDR2 + 6  500          2  VIRTRDR2 + 7  512          2  VIRTRDR2 + 8  500          2  VIRTRDR2 + 9  512          2          *
 *  SYSLIB        500          0  SYSLIB   + 1  517          2  SYSLIB   + 2  512         10                                        *
 *                                                                                                                                  *
 * EXCP TOTAL              72  VIO PAGE INS          0       VIO PAGE OUTS          0       PAGES SWAPPED IN          0             *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF373I STEP/ASSISTV /START 2005123.1648
 IEF374I STEP/ASSISTV /STOP  2005123.1648 CPU    0MIN 00.38SEC SRB    0MIN 00.01SEC VIRT   648K SYS   280K EXT      32K SYS    9448K
 ************************************************************************************************************************************
 *                                                  JOB TERMINATION STATISTICS                                                      *
 *                                                                                                                                  *
 *  JOB NAME    Z030199A  JOB00409                              CPU TIME  00:00:00.44            SRB TIME            00:00:00.01    *
 *                                                                                                                                  *
 *  PROGRAMMER  Brandon Tweed                                   INIT DATE 05/03/05   05.123      INITIATION TIME     16:48:57.14    *
 *                                                                                                                                  *
 *  SYSTEM ID   O2B4                                            TERM DATE 05/03/05   05.123      TERMINATION TIME    16:48:58.46    *
 *                                                                                                                                  *
 *  CLASS       M         PERF. GROUP      0                    SERV UNIT      2,652             ELAPSED TIME        00:00:01.32    *
 *                                                                                                                                  *
 *  MAIN STORAGE UNITS           0     CPU UNITS           2,369     SRB UNITS              70     I/O UNITS             213        *
 *                                                                                                                                  *
 *  JOB LOG Z030199A 05123 16:48:56.93                          MVS REL   SP6.1.0                                                   *
 *                                                                                                                                  *
 *  ACCTG DATA 0135040675,Z03    0199,T,Z03    ,TWEED BRANDON DAVID                              COMPLETION STATUS   C0000          *
 *                                                                                                                                  *
 ************************************************************************************************************************************
 IEF375I  JOB/Z030199A/START 2005123.1648
 IEF376I  JOB/Z030199A/STOP  2005123.1648 CPU    0MIN 00.44SEC SRB    0MIN 00.01SEC
 !! END OF JES SPOOL FILE !!
¤                                                                                                                                    
                                         High Level Assembler Option Summary                   (PTF UQ57391)   Page    1            
                                                                                            HLASM R4.0  2005/05/03 16.48            
  No Overriding ASMAOPT Parameters                                                                                                  
  No Overriding Parameters                                                                                                          
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
    ESD                                                                                                                             
  NOEXIT                                                                                                                            
    FLAG(0,ALIGN,CONT,NOIMPLEN,NOPAGE0,PUSH,RECORD,NOSUBSTR,USING0)                                                                 
  NOFOLD                                                                                                                            
  NOGOFF                                                                                                                            
  NOINFO                                                                                                                            
    LANGUAGE(EN)                                                                                                                    
  NOLIBMAC                                                                                                                          
    LINECOUNT(60)                                                                                                                   
    LIST(121)                                                                                                                       
    MXREF(SOURCE)                                                                                                                   
    OBJECT                                                                                                                          
    OPTABLE(UNI,NOLIST)                                                                                                             
  NOPCONTROL                                                                                                                        
  NOPESTOP                                                                                                                          
  NOPROFILE                                                                                                                         
  NORA2                                                                                                                             
  NORENT                                                                                                                            
    RLD                                                                                                                             
    RXREF                                                                                                                           
    SIZE(MAX)                                                                                                                       
    SYSPARM()                                                                                                                       
  NOTERM                                                                                                                            
  NOTEST                                                                                                                            
    THREAD                                                                                                                          
  NOTRANSLATE                                                                                                                       
    USING(NOLIMIT,MAP,WARN(15))                                                                                                     
    XREF(SHORT,UNREFS)                                                                                                              
                                                                                                                                    
  No Overriding DD Names                                                                                                            
¤                                                                                                                                    
                                              External Symbol Dictionary                                       Page    2            
Symbol   Type   Id     Address  Length     LD ID  Flags Alias-of                            HLASM R4.0  2005/05/03 16.48            
SVC8      SD 00000001 00010000 0000026A             00                                                                              
¤                                                                                                                                    
                                                                                                               Page    3            
  Active Usings: None                                                                                                               
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/03 16.48            
                                      1 **********************************************************************                      
                                      2 * SVC 8                                                                                     
                                      3 *                                                                                           
                                      4 * On Entry   R0 = Address where program is to be loaded, or, if                             
                                      5 *                 R0 = -1, indicates program is to be loaded at                             
                                      6 *                 address contained in OM records.  (RF = 0).                               
                                      7 *            R1 = Length of memory available for loading the OM at                          
                                      8 *                 the designated address.                                                   
                                      9 *                                                                                           
                                     10 * On Exit:   R15 = 0 if the module was successfully loaded                                  
                                     11 *            R0 = Entry Point Address (EPA) of the loaded module                            
                                     12 *            R1 = Length of the loaded module (from 1st ESD entry)                          
                                     13 *            R15 = 4 if End of File (EOF) encountered while reading                         
                                     14 *            R15 = 8 if length of csect exceeded R1 input size                              
                                     15 *            R15 = 12 if input record was not a valid OM format                             
                                     16 *            R15 = 16 if other categories of error occurred                                 
                                     17 *                                                                                           
                                     18 **********************************************************************                      
010000                10000 0026A    19 SVC8     START X'10000'               Start at hex 10000                                    
                 R:6  10000          20          USING SVC8,6                 Establish addressability on R6                        
010000 5000 6128            10128    21          ST    0,LOAD@                Save the load address                                 
010004 5010 6124            10124    22          ST    1,MAXLEN               Save amt of mem avail for load                        
                                     23 *                                                                                           
                                     24 * Initialize RF=-1                                                                          
                                     25 *                                                                                           
010008 D203 6120 6134 10120 10134    26          MVC   RF(4),RFINIT           Set RF=-1                                             
01000E 4170 6160            10160    27          LA    7,SVC8BUF              Get Buffer address                                    
010012 5070 61E8            101E8    28          ST    7,SVC8BUF@             Save it in the IOB                                    
010016 92D5 6138      10138          29          MVI   TXTFLG,C'N'            Set TXT Flag to Off                                   
                                     30 *                                                                                           
                                     31 * Read the first OM Card                                                                    
                                     32 *                                                                                           
01001A 45B0 6220            10220    33 DOREAD   BAL   11,IRS                 Call the IRS (scare friends)                          
01001E D502 6161 61B0 10161 101B0    34 CHKESD   CLC   SVC8BUF+1(3),ESDVAL    Check if this is an ESD Card                          
010024 4770 607C            1007C    35          BNE   CHKTXT                 If not ESD, Check if TXT                              
                                     36 *                                                                                           
                                     37 * this is an ESD Card                                                                       
                                     38 *                                                                                           
010028 D503 6120 6134 10120 10134    39          CLC   RF(4),RFINIT           Check relocation factor                               
01002E 4780 603A            1003A    40          BE    FIRSTESD               If this is first ESD, process it                      
010032 45B0 6220            10220    41          BAL   11,IRS                 otherwise read next ESD card                          
010036 47F0 601E            1001E    42          B     CHKESD                 Keep going until ESDs gone                            
01003A 9500 6178      10178          43 FIRSTESD CLI   SVC8BUF+24,X'00'       Check that ESD type is SD                             
01003E 4770 6242            10242    44          BNE   RC16#1                 If not, RC=16, end                                    
                                     45 *                                                                                           
                                     46 * process first ESD record                                                                  
                                     47 *                                                                                           
010042 D202 612D 6179 1012D 10179    48          MVC   CSECT@+1(3),SVC8BUF+25 Get the CSECT Address                                 
010048 D202 6131 617D 10131 1017D    49          MVC   CSECTL+1(3),SVC8BUF+29 Get the CSECT Length                                  
01004E D503 6124 6130 10124 10130    50          CLC   MAXLEN(4),CSECTL       See if Max length < CSECTL                            
010054 4740 6264            10264    51          BL    RC8                    If so, Return Code 8                                  
010058 D503 6128 6134 10128 10134    52          CLC   LOAD@(4),RFINIT        Check Load@ = -1                                      
01005E 4780 6072            10072    53          BE    SETRF0                 If so, set RF=0                                       
                                     54 *                                                                                           
i                                     55 * Otherwise, calculate the RF                                                               
                                                                                                               Page    4            
  Active Usings: SVC8(X'1000'),R6                                                                                                   
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/03 16.48            
                                     56 *                                                                                           
010062 5870 6128            10128    57          L     7,LOAD@                Get load address                                      
010066 5B70 612C            1012C    58          S     7,CSECT@               RF = LOAD@ - CSECT@                                   
01006A 5070 6120            10120    59          ST    7,RF                   Save the Relocation Factor                            
01006E 47F0 601A            1001A    60          B     DOREAD                 Process next OM Record                                
010072 D703 6120 6120 10120 10120    62 SETRF0   XC    RF(4),RF               Set Relocation factor to zero                         
010078 47F0 601A            1001A    63          B     DOREAD                 Process next OM Record                                
                                     64 *                                                                                           
                                     65 * Process a TXT OM Record                                                                   
                                     66 *                                                                                           
01007C D503 6120 6134 10120 10134    67 CHKTXT   CLC   RF(4),RFINIT           Check if RF Not yet set                               
010082 4780 6248            10248    68          BE    RC16#2                 If not, Set RC=16                                     
010086 D502 6161 61B3 10161 101B3    69          CLC   SVC8BUF+1(3),TXTVAL    Check if this is a TXT Card                           
01008C 4770 60B6            100B6    70          BNE   CHKRLD                 If not TXT, Check if RLD                              
010090 92E8 6138      10138          71          MVI   TXTFLG,C'Y'            Indicate TXT Card Read                                
010094 1777                          72          XR    7,7                    Clear 7 for TXT Length                                
010096 BF73 616A            1016A    73          ICM   7,3,SVC8BUF+10         Get Length for TXT Card                               
01009A 1277                          74          LTR   7,7                    Check Length = 0                                      
01009C 4780 624E            1024E    75          BZ    RC16#3                 If so, Return Code=16, End                            
0100A0 1788                          76          XR    8,8                    Clear 8 for Rel Address                               
0100A2 BF87 6165            10165    77          ICM   8,7,SVC8BUF+5          Get Relative Address for TXT                          
0100A6 5A80 6120            10120    78          A     8,RF                   Add the RF giving final address                       
0100AA 4470 613A            1013A    79          EX    7,MOVETXT              Now move the TXT card info                            
0100AE 45B0 6220            10220    80          BAL   11,IRS                 Read another record                                   
0100B2 47F0 607C            1007C    81          B     CHKTXT                 Check to see if it's TXT                              
                                     82 *                                                                                           
                                     83 * Process an RLD Record                                                                     
                                     84 *                                                                                           
0100B6 D502 6161 61B6 10161 101B6    85 CHKRLD   CLC   SVC8BUF+1(3),RLDVAL    Check if this is a RLD Card                           
0100BC 4770 60C4            100C4    86          BNE   CHKEND                 If not RLD, Check if END                              
0100C0 47F0 601A            1001A    87          B     DOREAD                 If this is RLD, read next OMR                         
                                     88 *                                                                                           
                                     89 * Process an END Card                                                                       
                                     90 *                                                                                           
0100C4 95E8 6138      10138          91 CHKEND   CLI   TXTFLG,C'Y'            See if at least 1 TXT processed                       
0100C8 4770 6254            10254    92          BNE   RC16#4                 If not, fail with RC=16                               
0100CC D502 6161 61B9 10161 101B9    93          CLC   SVC8BUF+1(3),ENDVAL    Check if this is an END Card                          
0100D2 4770 623C            1023C    94          BNE   RC12#2                 If not any  of these, Set RC=12                       
0100D6 5800 612C            1012C    95          L     0,CSECT@               Get CSECT address                                     
0100DA 5A00 6120            10120    96          A     0,RF                   Add the RF giving EPA                                 
0100DE D502 6165 61BC 10165 101BC    97          CLC   SVC8BUF+5(3),TSTAEPF   Test AOEPF for blanks                                 
0100E4 4780 60F2            100F2    98          BE    B4EXIT                 If blank, exit                                        
0100E8 1700                          99          XR    0,0                    else clear R0 and recalculate                         
0100EA BF07 6165            10165   100          ICM   0,7,SVC8BUF+5          Get AOEPF                                             
0100EE 5A00 6120            10120   101          A     0,RF                   Add RF giving EPA                                     
                                    102 *                                                                                           
                                    103 * Put CSECT Length into R1 and exit                                                         
                                    104 *                                                                                           
0100F2 5810 6130            10130   105 B4EXIT   L     1,CSECTL               Load R1 with CSECT Length                             
0100F6 47F0 625A            1025A   106          B     RC0                    Set RC=0 and exi                                      
                                    107 *********************************************************************                       
                                    108 * SVC 8 STORAGE AREA                                                                        
                                    109 **********************************************************************                      
i0100FA                100FA 10100   110          ORG   SVC8+((*-SVC8+31)/32*32) Align 32n                                           
                                                                                                               Page    5            
  Active Usings: SVC8(X'1000'),R6                                                                                                   
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/03 16.48            
010100 E2E5C3F840E2E3D6             111          DC    CL32'SVC8 STORAGE AREA FOLLOWS'                                              
                                    112 *                                                                                           
010120 FFFFFFFF                     113 RF       DC    F'-1'                  Relocation Factor                                     
010124 00000000                     114 MAXLEN   DC    F'0'                   Module Length                                         
010128 00000000                     115 LOAD@    DC    F'0'                   Module Load address                                   
01012C 00000000                     116 CSECT@   DC    F'0'                   CSECT Address                                         
010130 00000000                     117 CSECTL   DC    F'0'                   CSECT Length                                          
010134 FFFFFFFF                     118 RFINIT   DC    F'-1'                  For Initializing  comparing RF                        
010138 D5                           119 TXTFLG   DC    C'N'                   Flag Indicating TXT Card read                         
010139 00                                                                                                                           
01013A D200 8000 6170 00000 10170   120 MOVETXT  MVC   0(0,8),SVC8BUF+16      Move the TXT Card information                         
                                    121 *                                                                                           
010140                10140 10140   122          ORG   SVC8+((*-SVC8+31)/32*32) Align 32n                                           
010140 E2E5C3F840C9D5D7             123          DC    CL32'SVC8 INPUT BUFFER BELOW'                                                
010160 4040404040404040             124 SVC8BUF  DC    CL80' '                SVC8 Input Buffer                                     
                                    125 *                                                                                           
0101B0 C5E2C4                       126 ESDVAL   DC    CL3'ESD'               For checking ESD OM Card                              
0101B3 E3E7E3                       127 TXTVAL   DC    CL3'TXT'               For checking TXT OM Card                              
0101B6 D9D3C4                       128 RLDVAL   DC    CL3'RLD'               For checking RLD OM Card                              
0101B9 C5D5C4                       129 ENDVAL   DC    CL3'END'               For checking END OM Card                              
0101BC 404040                       130 TSTAEPF  DC    CL3'   '               For checking Addr Ent. Pt.                            
                                    131 *                                                                                           
0101BF                101BF 101C0   132          ORG   SVC8+((*-SVC8+31)/32*32) Align 32n                                           
0101C0 E2E5C3F840D9C5C1             133          DC    CL32'SVC8 READ IOB BELOW'                                                    
0101E0                              134 SVC8RIOB DS    0F                     Start IOB on a fullword                               
0101E0 C9D6C2D9                     135          DC CL4'IOBR'                 IOB IDENTIFICATION                                    
0101E4 000C                         136          DC XL2'000C'                 LOAD FROM DEVICE X'000C'                              
0101E6 02                           137          DC X'02'                     '02' = READ                                           
0101E7 F0                           138          DC C'0'                      RESERVED FOR STUFF                                    
0101E8 00000000                     139 SVC8BUF@ DC F'0'                      A(BUFFER) TO READ                                     
0101EC 0050                         140          DC H'80'                     LENGTH OF BUFFER TO READ/WRITE                        
0101EE 0000                         141          DC H'0'                      RESERVED FOR STUFF                                    
                                    142 *                                                                                           
                                    143 **********************************************************************                      
                                    144 * INTERNAL READ SUBROUTINE FOR SVC 8 (IRS)                                                  
                                    145 **********************************************************************                      
                                    146 *                                                                                           
0101F0                101F0 10200   147          ORG   SVC8+((*-SVC8+31)/32*32) Align 32n                                           
010200 C9D5E3C5D9D5C1D3             148          DC    CL32'INTERNAL READ SUBROUTINE FOLLOWS'                                       
010220 4110 61E0            101E0   149 IRS      LA    1,SVC8RIOB             Get address of Read IOB                               
010224 0A00                         150          SVC   0                      Call SVC 0 to perform the read                        
010226 12FF                         151          LTR   15,15                  Test RC=0                                             
010228 4770 625E            1025E   152          BNZ   RC4                    If RC != 0, Set return code to 4                      
01022C 9502 6160      10160         153          CLI   SVC8BUF,X'02'          Check if this is an OM Card                           
010230 4770 6236            10236   154          BNE   RC12#1                 If it's not, bomb out                                 
010234 07FB                         155          BR    11                     Return from Read Subroutine                           
                                    156 *                                                                                           
                                    157 * First char of Object Record not X'02'                                                     
                                    158 *                                                                                           
010236 41F0 000C            0000C   159 RC12#1   LA    15,12                  Set RC=12                                             
01023A 07FE                         160          BR    14                     Return from SVC 8                                     
                                    161 *                                                                                           
                                    162 * No 'ESD','TXT','RLD','END' in Object Record                                               
                                    163 *                                                                                           
i01023C 41F0 000C            0000C   164 RC12#2   LA    15,12                  Set RC=12                                             
                                                                                                               Page    6            
  Active Usings: SVC8(X'1000'),R6                                                                                                   
  Loc  Object Code    Addr1 Addr2  Stmt   Source Statement                                  HLASM R4.0  2005/05/03 16.48            
010240 07FE                         165          BR    14                     Return from SVC 8                                     
                                    166 *                                                                                           
                                    167 * RC16#1 First ESD entry is not 'SD', i.e., X'00'.                                          
                                    168 *                                                                                           
010242 41F0 0010            00010   169 RC16#1   LA    15,16                  Set RC=16                                             
010246 07FE                         170          BR    14                     Return from SVC 8                                     
                                    171 *                                                                                           
                                    172 * RC16#2 TXT record was not preceded by ESD record,                                         
                                    173 * RF still = -1.                                                                            
                                    174 *                                                                                           
010248 41F0 0010            00010   175 RC16#2   LA    15,16                  Set RC=16                                             
01024C 07FE                         176          BR    14                     Return from SVC 8                                     
                                    177 *                                                                                           
                                    178 * RC16#3 Length of the text in TXT record was zero.                                         
                                    179 *                                                                                           
01024E 41F0 0010            00010   180 RC16#3   LA    15,16                  Set RC=16                                             
010252 07FE                         181          BR    14                     Return from SVC 8                                     
                                    182 *                                                                                           
                                    183 * RC16#4 No TXT records were processed.                                                     
                                    184 *                                                                                           
010254 41F0 0010            00010   185 RC16#4   LA    15,16                  Set RC=16                                             
010258 07FE                         186          BR    14                     Return from SVC 8                                     
01025A 17FF                         187 RC0      XR    15,15                  Set R15=0                                             
01025C 07FE                         188          BR    14                     Return from SVC 8                                     
01025E 41F0 0004            00004   189 RC4      LA    15,4                   Set RC=4 in R15                                       
010262 07FE                         190          BR    14                     Return from SVC 8                                     
010264 41F0 0008            00008   191 RC8      LA    15,8                   Set RC=8 in R15                                       
010268 07FE                         192          BR    14                     Return from SVC 8                                     
010000                              193          END   SVC8                   End of SVC8 module                                    
¤                                                                                                                                    
                               Ordinary Symbol and Literal Cross Reference                                     Page    7            
Symbol   Length   Value     Id    R Type   Defn References                                  HLASM R4.0  2005/05/03 16.48            
B4EXIT        4 000100F2 00000001     I     105   98B                                                                               
CHKEND        4 000100C4 00000001     I      91   86B                                                                               
CHKESD        6 0001001E 00000001     I      34   42B                                                                               
CHKRLD        6 000100B6 00000001     I      85   70B                                                                               
CHKTXT        6 0001007C 00000001     I      67   35B   81B                                                                         
CSECT@        4 0001012C 00000001     F     116   48M   58    95                                                                    
CSECTL        4 00010130 00000001     F     117   49M   50   105                                                                    
DOREAD        4 0001001A 00000001     I      33   60B   63B   87B                                                                   
ENDVAL        3 000101B9 00000001     C     129   93                                                                                
ESDVAL        3 000101B0 00000001     C     126   34                                                                                
FIRSTESD      4 0001003A 00000001     I      43   40B                                                                               
IRS           4 00010220 00000001     I     149   33B   41B   80B                                                                   
LOAD@         4 00010128 00000001     F     115   21M   52    57                                                                    
MAXLEN        4 00010124 00000001     F     114   22M   50                                                                          
MOVETXT       6 0001013A 00000001     I     120   79X                                                                               
RC0           2 0001025A 00000001     I     187  106B                                                                               
RC12#1        4 00010236 00000001     I     159  154B                                                                               
RC12#2        4 0001023C 00000001     I     164   94B                                                                               
RC16#1        4 00010242 00000001     I     169   44B                                                                               
RC16#2        4 00010248 00000001     I     175   68B                                                                               
RC16#3        4 0001024E 00000001     I     180   75B                                                                               
RC16#4        4 00010254 00000001     I     185   92B                                                                               
RC4           4 0001025E 00000001     I     189  152B                                                                               
RC8           4 00010264 00000001     I     191   51B                                                                               
RF            4 00010120 00000001     F     113   26M   39    59M   62M   62    67    78    96   101                                
RFINIT        4 00010134 00000001     F     118   26    39    52    67                                                              
RLDVAL        3 000101B6 00000001     C     128   85                                                                                
SETRF0        6 00010072 00000001     I      62   53B                                                                               
SVC8          1 00010000 00000001     J      19   20U  110   110   122   122   132   132   147   147   193                          
SVC8BUF      80 00010160 00000001     C     124   27    34    43    48    49    69    73    77    85    93    97   100              
                                                 120   153                                                                          
SVC8BUF@      4 000101E8 00000001     F     139   28M                                                                               
SVC8RIOB      4 000101E0 00000001     F     134  149                                                                                
TSTAEPF       3 000101BC 00000001     C     130   97                                                                                
TXTFLG        1 00010138 00000001     C     119   29M   71M   91                                                                    
TXTVAL        3 000101B3 00000001     C     127   69                                                                                
¤                                                                                                                                    
                                                      Using Map                                                Page    8            
                                                                                            HLASM R4.0  2005/05/03 16.48            
  Stmt  -----Location----- Action ----------------Using----------------- Reg Max    Last  Label and Using Text                      
          Count      Id           Type          Value    Range     Id        Disp   Stmt                                            
    20  00010000  00000001 USING  ORDINARY    00010000 00001000 00000001   6 264     154  SVC8,6                                    
¤                                                                                                                                    
                                   General Purpose Register Cross Reference                                    Page    9            
 Register  References (M=modified, B=branch, U=USING, D=DROP, N=index)                      HLASM R4.0  2005/05/03 16.48            
    0(0)      21    95M   96M   99M   99   100M  101M                                                                               
    1(1)      22   105M  149M                                                                                                       
    2(2)    (no references identified)                                                                                              
    3(3)    (no references identified)                                                                                              
    4(4)    (no references identified)                                                                                              
    5(5)    (no references identified)                                                                                              
    6(6)      20U                                                                                                                   
    7(7)      27M   28    57M   58M   59    72M   72    73M   74M   74    79                                                        
    8(8)      76M   76    77M   78M  120                                                                                            
    9(9)    (no references identified)                                                                                              
   10(A)    (no references identified)                                                                                              
   11(B)      33M   41M   80M  155B                                                                                                 
   12(C)    (no references identified)                                                                                              
   13(D)    (no references identified)                                                                                              
   14(E)     160B  165B  170B  176B  181B  186B  188B  190B  192B                                                                   
   15(F)     151M  151   159M  164M  169M  175M  180M  185M  187M  187   189M  191M                                                 
¤                                                                                                                                    
                                  Diagnostic Cross Reference and Assembler Summary                             Page   10            
                                                                                            HLASM R4.0  2005/05/03 16.48            
     No Statements Flagged in this Assembly                                                                                         
HIGH LEVEL ASSEMBLER, 5696-234, RELEASE 4.0, PTF UQ57391                                                                            
SYSTEM: OS/390 02.10.00            JOBNAME: Z030199A    STEPNAME: STEP1      PROCSTEP: ASM                                          
Datasets Allocated for this Assembly                                                                                                
 Con DDname   Dataset Name                                 Volume  Member                                                           
  P1 SYSIN    Z030199.Z030199A.JOB00409.D0000101.?                                                                                  
  L1 SYSLIB   SYS1.MACLIB                                  SYSRES                                                                   
  L2          SYS2.MACLIB                                  SYS304                                                                   
     SYSLIN   SYS05123.T164857.RA000.Z030199A.O.H01        TMP303  SVC8                                                             
     SYSPRINT Z030199.Z030199A.JOB00409.D0000104.?                                                                                  
                                                                                                                                    
   1788K allocated to Buffer Pool,          200K would be required for this to be an In-Storage Assembly                            
    193 Primary Input Records Read            0 Library Records Read                  0 Work File Reads                             
      0 ASMAOPT Records Read                342 Primary Print Records Written         0 Work File Writes                            
     14 Punch Records Written                 0 ADATA Records Written                                                               
Assembly Start Time: 16.48.57 Stop Time: 16.48.57 Processor Time: 00.00.00.0061                                                     
Return Code 000                                                                                                                     
 !! END OF JES SPOOL FILE !!
1                                         IEBCOPY MESSAGES AND CONTROL STATEMENTS                              PAGE     1
-IEB1135I IEBCOPY  FMID HDZ11F0  SERVICE LEVEL UW81747  DATED 20010911 DFSMS 02.10.00 OS/390  02.10.00 HBB7703  CPU 7060 
 IEB1035I Z030199A  STEP2    16:48:56 TUE 03 MAY 2005 PARM=''                                                            
-    COPY INDD=OLD,OUTDD=NEW                                                                                             
0IEB1013I COPYING FROM PDS   INDD=OLD      VOL=TMP303 DSN=SYS05123.T164857.RA000.Z030199A.O.H01                          
 IEB1014I           TO PDS  OUTDD=NEW      VOL=TMP301 DSN=SYS05123.T164857.RA000.Z030199A.OO.H01                         
 IEB1160I OUTPUT DATASET RECFM/LRECL/BLKSIZE COPIED FROM INPUT DATASET                                                   
 IEB167I FOLLOWING MEMBER(S) COPIED FROM INPUT DATA SET REFERENCED BY OLD                                                
 IEB154I SVC8     HAS BEEN SUCCESSFULLY COPIED                                                                           
 IEB1098I 1 OF 1 MEMBERS COPIED FROM INPUT DATA SET REFERENCED BY OLD                                                    
 IEB144I THERE ARE 0 UNUSED TRACKS IN OUTPUT DATA SET REFERENCED BY NEW                                                  
 IEB149I THERE ARE 0 UNUSED DIRECTORY BLOCKS IN OUTPUT DIRECTORY                                                         
 IEB147I END OF JOB - 0 WAS HIGHEST SEVERITY CODE                                                                        
 !! END OF JES SPOOL FILE !!
1***  ASSIST V2.0-05/15/82  INS=SDFP7/X=BGHO, CHECK=T(1-1/X1-1)R(2-50/X1-25K), OPTS=D(1/6144)M(F)P(40-100/X20-25)VX FROM PENN ST*NIU 
 P=100,PX=50,R=5000,RX=3000,L=60,XREF=0                                                                                              
0       Brandon Tweed SOS-Uni                                                                                   PAGE    1            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                       2 **********************************************************************                      
                                       3 * Brandon Tweed                                                                             
                                       4 * CSCI 468 Spring 2005                                                                      
                                       5 * SOS-Multi 2 Assignment                                                                    
                                       6 *                                                                                           
                                       7 **********************************************************************                      
                                       9 *SYSLIB LOADERC,DSECTS,EQUREGS,EXIT,LOUNTR,FRECB100,GETCB100,WAITS                          
                                     314 *SYSLIB EQUCCWS                                                                             
                                     372 **********************************************************************                      
                                     373 * CCW MACRO                                                                                 
                                     374 * When invoked, defines storage for a CCW.                                                  
                                     375 **********************************************************************                      
                                     376          MACRO                                                                              
                                     377 &NAME    CCW  &CMD,&BUF,&FLAG,&LEN                                                          
                                     378 &NAME    DC   0D'0',AL1(&CMD),AL3(&BUF),AL1(&FLAG),X'0',AL2(&LEN)                           
                                     379          MEND                                                                               
                                     380 *                                                                                           
                                     381          EQUCCWS                      EQUATES FOR WORKING WITH CCWs                         
                                     382+*CSCI 468  EQUATES FOR DISK I/O  V6.7 SPRING, 1989   1 OF 1                                 
                                     383+*                                                                                           
                                     384+*                                                                                           
                                     385+**** CCW COMMAND CODE EQUATES FOR DISK I/O ****                                             
                                     386+*                                                                                           
 000008                              387+TIC      EQU   X'08'  TRANSFER IN CHANNEL.                                                  
 000029                              388+SEARKEQ  EQU   X'29'  SEARCH KEY EQUAL.                                                     
 000069                              389+SEARKHE  EQU   X'69'  SEARCH KEY HIGH OR EQUAL.                                             
 00001A                              390+READHA   EQU   X'1A'  READ HOME ADDRESS.                                                    
 000016                              391+READR0   EQU   X'16'  READ RECORD 0.                                                        
 000012                              392+READC    EQU   X'12'  READ COUNT.                                                           
 000006                              393+READDATA EQU   X'06'  READ DATA.                                                            
 00000E                              394+READKD   EQU   X'0E'  READ KEY AND DATA.                                                    
 00001E                              395+READCKD  EQU   X'1E'  READ COUNT, KEY AND DATA.                                             
 000023                              396+SETSECT  EQU   X'23'  SET SECTOR.                                                           
 000022                              397+READSECT EQU   X'22'  READ SECTOR.                                                          
 000031                              398+SEARIDEQ EQU   X'31'  SEARCH IDENTIFIER EQUAL.                                              
                                                                                                                                     
 000004                              400+SENSE    EQU   X'04'  SENSE    V6.5  SPRING, 1987                                           
 000005                              401+WRITEDAT EQU   X'05'  WRITE DATA    V6.5  SPRING, 1987                                      
 00000D                              402+WRITEKD  EQU   X'0D'  WRITE KEY AND DATA    V6.5  SPRING, 1987                              
 00001D                              403+WRITECKD EQU   X'1D'  WRITE COUNT, KEY, AND DATA   V6.5  SP. '87                            
                                                                                                                                     
                                     405+*                                                     V6.7 = SP. '89                        
 000064                              406+READEVCH EQU   X'64'  READ DEVICE CHARACTERISTICS (64 BYTES) SP. '89                        
 00005E                              407+READMCKD EQU   X'5E'  READ MULTIPLE COUNT, KEY, AND DATA     SP. '89                        
 000080                              408+MT       EQU   X'80'  'MULTI-TRACK' USE WITH APPROPRIATE     SP. '89                        
                                     409+*                     OP-CODES AS:   CCW   SEARKHE+MT,B,C,D  SP. '89                        
                                                                                                                                     
 000003                              411+NOOP     EQU   X'03'  NO-OPERATION.                                                         
                                                                                                                                     
                                     413+*                                                                                           
                                     414+**** CCW FLAG EQUATES ****                                                                  
                                     415+*                                                                                           
 000080                              416+CD       EQU   X'80'  CHAIN DATA.                                                           
 000040                              417+CC       EQU   X'40'  CHAIN COMMAND.                                                        
1       Brandon Tweed SOS-Uni                                                                                   PAGE    2            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000020                              418+SLI      EQU   X'20'  SUPPRESS INCORRECT LENGTH INDICATION.                                 
 000010                              419+SKIP     EQU   X'10'  SKIP TRANSFER OF DATA.                                                
                                                                                                                                     
                                     421+*                                                                                           
                                     422+**** CSW FLAG EQUATES ****                                                                  
                                     423+*                                                                                           
                                     424+** UNIT STATUS BYTE **                                                                      
                                     425+*                                                                                           
 000020                              426+CUE      EQU   X'20'  CONTROL UNIT END.                                                     
 000008                              427+CE       EQU   X'08'  CHANNEL END.                                                          
 000004                              428+DE       EQU   X'04'  DEVICE END.                                                           
 000002                              429+UC       EQU   X'02'  UNIT CHECK.                                                           
 000001                              430+UE       EQU   X'01'  UNIT EXCEPTION.                                                       
                                     431+*                                                                                           
                                     432+** CHANNEL STATUS BYTE **                                                                   
                                     433+*                                                                                           
 000040                              434+IL       EQU   X'40'  INCORRECT LENGTH.                                                     
                                                                                                                                     
                                     436 *                                                                                           
                                     437 **** CCW COMMAND CODE EQUATES                                                               
                                     438 *                                                                                           
 000002                              439 READ     EQU   X'02'                                                                        
 000001                              440 WRITEWO  EQU   X'01'                                                                        
 00000B                              441 SPACE1IM EQU   X'0B'                                                                        
 000013                              442 SPACE2IM EQU   X'13'                                                                        
 00001B                              443 SPACE3IM EQU   X'1B'                                                                        
 00008B                              444 SKIPCH1  EQU   X'8B'                                                                        
                                     445 *                                                                                           
                                     446          DSECTS                       BRING IN DSECTS FOR USE                               
                                     447+*CSCI 468  SOS V6.125 01/21/2000  DSECTS MACRO   PAGE 1 OF 3                                
                                     448+*  CSCI 468  SOS  =====> DSECT-S <==== 12TH VERSION (V6.12)=========                        
                                     449+*     MOD-S  RPR-9/21/87, 9/22/87, 2/14/89, 2/9/90, 4/4/90, 4/20/90                         
                                     450+*                11/9/90=V6.9, 4/7/94=V6.10, 11/06/96=V6.11                                 
                                     451+*                09/24/99=V6.12 09/13/01=V6.13                                              
 000000                              452+IOB      DSECT                                                                              
                                     453+* IOB MUST BE FULLWORD ALIGNED, PREFERABLY 32*N ALIGNED        V6.11                        
 000000                              454+IOBIDENT DS    CL4'IOB ' IOB IS IDENT/DOC.  LAST BYTE RESERVED V6.11                        
 000003                              455+IOBRESV1 EQU   IOBIDENT+3  4TH BYTE = RESERVED (NOT BLANK!)    V6.11                        
 000004                              456+IOBDEVAD DS   XL2'0000' => XPRNT/XREAD. X'000N' => CCWS - DEVICE 'N'                        
 000006                              457+IOBOPCDE DS    X'02' = READ   X'01' = WRITE                    V6.11                        
 000007                              458+IOBRESV2 DS    C            RESERVED                           V6.11                        
 000008                              459+IOBUFADD DS    A(0) ADDRESS BUFFER TO READ/WRITE IN RIGHT 3    V6.11                        
 00000C                              460+IOBUFLEN DS    H'0' LENGTH OF BUFFER TO READ/WRITE             V6.11                        
 00000E                              461+IOBRESV3 DS    H            RESERVED                           V6.11                        
                                     462+* ONLY 16 BYTES (FIRST 4 FULL WORDS) USED AT PRESENT           V6.12                        
 000010                              463+IOBACHPG DS    A(0) ADDRESS OF CHANNEL PROGRAM                 V6.11                        
 000014                              464+IOBAECB  DS    A(0) ADDRESS OF ECB                             V6.11                        
 000018                              465+IOBCSW   DS    2F   CHANNEL STATUS WORD                        V6.11                        
                                     466+*IOBADCB  DS    A(0) ADDRESS OF DCB NOT PRESENTLY USED         V6.11                        
 000020                              467+IOBRESV4 DS    4A(0)        RESERVED                           V6.11                        
 000030                              468+IOBLNGTH EQU   *-IOB     LENGTH OF THE IOB  (X'30')            V6.11                        
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              470+RQE      DSECT                                                                              
 000000                              471+RQEIDENT DS    CL4'RQE ' DOCUMENTATION                                                      
 000004                              472+RQEIOB   DS    A(0) ADDRESS OF IOB THAT GENERATED THIS RQE                                  
1       Brandon Tweed SOS-Uni                                                                                   PAGE    3            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000008                              473+RQEUCB   DS    A(0)      ADD. OF UCB WHEN IN USE.                                           
 00000C                              474+RQETCB   DS    A(0)      ADD. OF USERS TCB                                                  
 000010                              475+RQERB    DS    A(0)      ADD. OF RB IN TCB ISSUING I/O REQUEST                              
 000014                              476+RQENRQE  DS    A(0) ADD NEXT RQE IN UCB WAIT QUE. / 0 IF THIS=LAST                          
 000018                              477+RQEIOECB DS    A(0)      ECB FOR WAIT/POST OF THIS RQE       V6.10                          
 00001C                              478+         DS    A(0)      RESERVED                            V6.10                          
 000020                              479+RQELNTH  EQU   *-RQE     LENGTH OF RQE  (X'20')                                             
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              481+CVT      DSECT                                                                              
 000000                              482+CVTTCBP  DS    A (IEATCBP)  POINTER TO 'TCB WORDS'                                          
 000004                              483+CVTSVCTA DS    A (SVCTABLE) POINTER TO THE SVCTABLE                                         
 000008                              484+CVTHEAD  DS    A (0) ADDRESS OF FIRST TCB IN TCB CHAIN                                      
 00000C                              485+CVTUCBS  DS    A (0) ADDRESS OF FIRST UCB IN UCB CHAIN                                      
 000010                              486+         DS    A (0)    RESERVED (WAS CVTRQEHD)              V6.10                          
 000014                              487+CVTLEVLF DS    A (LEVELFLG)  FOR V6.4 AND FUTURE 'LEVEL'    V6.10                           
 000018                              488+CVTC100H DS    A (CB100HDR) ADDRESS OF THE CB-HEADER         V6.10                          
 00001C                              489+CVT0DS   DS    A (DISPATCH) ADDRESS OF THE DISPATCHER                                       
 000020                              490+CVTBGNIO DS    A (BEGINIO) ADD. OF THE BEGIN I/O ROUTINE IN IOSUP.                          
 000024                              491+CVTCHAP  DS    A (CHAP)   ADD. OF THE CHAP ROUTINE                                          
 000028                              492+CVTSUB1  DS    A (SUB1) ADD. OF SUBROUTINE GROUP 1 IN 'LPA' V6.10                           
 00002C                              493+CVTSUB2  DS    A (SUB2) ADD. OF SUBROUTINE GROUP 2 IN 'LPA' V6.10                           
 000030                              494+CVTBRABN DS    A (BRABEND) ADD. BRANCH-ABEND ROUTINE   V6.5                                 
 000034                              495+CVTTYP1F DS    A (TYP1FLAG)                                                                 
 000038                              496+CVTRQENQ DS    A (RQEENQ)  ADD. OF ROUT. TO ENQ RQE-S ON UCB-S                              
 00003C                              497+CVTPARHD DS    A (0) A OF PARTITION-S 'HEADER'               V6.9                           
 000040                              498+CVTMSECB DS    A (0) A OF MASTER SCHEDULER ECB               V6.9                           
 000044                              499+CVTMSINI DS    A (0) A OF MSTR. SCH. INITILIZATION ROUT.     V6.9                           
 000048                              500+CVTMSWLO DS    A (0) A OF MSTR. SCH. WAIT LOOP (SVC 1)       V6.9                           
 00004C                              501+CVTMSDAT DS    A (0) A OF MSTR. SCH. DATA AREA               V6.9                           
 000050 0A03                         502+CVTEXIT  SVC   3                                                                            
 000052 07FE                         503+CVTBRET  BCR   15,14                                                                        
 000054                              504+CVTSSVRB DS    A (0) ADDR. OF ENTRY IN SVC-FLIH TO SCH. SVRB   V6.11                        
                                     505+* CVTSFR14 REPLACED BY CVTSSVRB .......................  IN    V6.11                        
                                     506+*CVTSFR14 DS A (0) ADDR. OF R14 AFTER BALR R14,R6 IN SVCFLIH V6.83                          
 000058                              507+CVTMZ00  DS    A (0) ADD. OF HIGHEST 'MACHINE' BYTE. RPR-9/22/87                            
 00005C                              508+CVTIDENT DS    CL4'CVT ' DOCUMENTATION                                                      
 000060                              509+CVTLNTH  EQU   *-CVT     LENGTH OF THE CVT  (X'60')                                         
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              511+IEATCBP  DSECT                                                                              
 000000                              512+PSATNEW  DS    A (0) ADDRESS OF NEXT TCB TO BE DISPATCHED                                   
 000004                              513+PSATOLD  DS    A (TCB1) ADDRESS OF CURRENTLY DISPATCHED TCB                                 
 000008                              514+PSAANEW  DS    A (0)   RESERVED                                                             
 00000C                              515+PSAAOLD  DS    A (0)   RESERVED                                                             
 000010                              516+IEATLNTH EQU   *-IEATCBP LENGTH OF THE TCB-WORDS  (X'10')                                   
                                     517+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 1 OF 3                                 
                                     518+*CSCI 468  SOS V6.10 4/7/94  DSECTS MACRO   PAGE 2 OF 3                                     
 000000                              519+PQESECT  DSECT                                                                              
 000000                              520+PQEFFBQE DS    A (0) PTR TO FIRST FBQE OR IF NONE TO PQE                                    
 000004                              521+PQEBFBQE DS    A (0) PTR TO LAST FBQE OR IF NONE, TO PQE                                    
 000008                              522+PQEFPQE  DS    A (0) ADDR. NEXT PQE OR ZERO                                                 
 00000C                              523+PQEBPQE  DS    A (0) ADDR. PREVIOUS PQE OR ZERO                                             
 000010                              524+PQETCB   DS    A (0) ADDR. TCB FOR JOB STEP TO WHICH SPACE BELONGS                          
 000014                              525+PQESIZE  DS    A (0) SIZE OF REGION DESCRIBED BY THIS PQE                                   
1       Brandon Tweed SOS-Uni                                                                                   PAGE    4            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000018                              526+PQEREGN  DS    A (0) ADD. FIRST BYTE OF REGION DESC. BY THIS PQE                            
 00001C                              527+         DS    A (0) RESERVED                                                               
 000020                              528+PQELNTH  EQU   *-PQESECT LENGTH OF THE PQE  (X'20')                                         
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              530+TCB      DSECT                                                                              
 000000                              531+TCBRB    DS    A(0)     ADD OF RB (OR ZERO IF NONE)                                         
 000004                              532+TCBPIE   DS    A (0) ADD. OF PIE (MVT) OR SCA (MVS) RPR-9/22/87                             
 000008                              533+TCBTNAME DS    CL8'TCB NAME' ('DEB' & 'TIOT' HERE IN REAL)  V6.83                           
 000010                              534+TCBPNAME DS    CL8'PGM NAME' NAME OF PROGRAM BEING EXECUTED  V6.9                           
                                     535+*TCBNAME EQU TCBTNAME PRIOR TO REMOVING 'TCBNAME'  V6.83  *IN V6.10                         
 000018                              536+TCBTSSIO DS    A(0)  TIME (FROM X'50') SIO LAST STARTED FOR THIS TCB                        
 00001C                              537+TCBPFK   DS    X'CF'     C = KEY OF THIS TCB, F = B'1111'B    V6.9                          
 00001D                              538+TCBFLGS  DS    5X'00' FLGS 4+5: X'0000', DISPATCH.: X'FFFF' NOT-SO                          
 000022                              539+TCBLMP   DS    X'00' LIMIT PRIORITY OF THIS TCB                                             
 000023                              540+TCBDSP   DS    X'00' DISPATCHING PRIORITY OF THIS TCB.                                      
 000024                              541+TCBTWAIT DS    A(0)  SUM. I/O WAIT TIME ACCUM. -- THIS TCB   V6.10                          
                                     542+*                    SIO=0 TO I/O INTERRUPT                  V6.10                          
 000028                              543+TCBUNCH  DS    A(0) LOCATION FOR C'UNCH' INDICATOR          V6.101                          
 00002C                              544+TCBIDENT DS    CL4'TCB ' DOCUMENTATION                                                      
 000030                              545+TCBGRS   DS    16F'-5' SAVE AREA FOR REGS.                                                  
 000070                              546+         DS    A(0) RESERVED                                 V6.9                           
 000074                              547+TCBTCB   DS    A(0)   ADD OF NEXT TCB IN CHAIN (OR ZERO IF END)                             
 000078                              548+TCBDMSCA DS    A(0) LOCATION USED FOR DUMMY SCA              V6.9                           
 00007C                              549+         DS    A(0) RESERVED                                 V6.9                           
 000080                              550+TCBAPIE  DS    A(0) ADDR. OF PIE AREA IN TASKS REGION        V6.9                           
 000084                              551+TCBAPARM DS    A(0) ADDR. OF 'PARM' AREA IN TASKS REGION     V6.9                           
 000088                              552+TCBFSA   DS    A(0)  ADD OF FIRST SAVE AREA (18F) FOR USE OF PROG.                          
 00008C                              553+TCBAWORK DS    A(0)  ADD OF WORK AREA IN THIS TCB-S 'REGION'                                
 000090                              554+TCBRSTAR DS    A(0)  ADDRESS OF START OF REGION USED BY THIS TCB                            
 000094                              555+TCBRSIZE DS    A(0)  SIZE (BYTES) OF REGION USED BY THIS TCB                                
 000098                              556+TCBDPQE  DS    A(0) POINTER TO THE DUMMY PQE                 V6.83                          
 00009C                              557+TCBMSS   DS    A(0) POINTER TO THE QUEUE OF SPQE-S           V6.83                          
 0000A0                              558+TCBTDISP DS    A(0)  TIME (FROM X'50') THIS TCB LAST DISPAT.  V6.9                          
 0000A4                              559+TCBTWALS DS    A(0) START TIMER VALUE 'WALL CLOCK'            V6.9                          
                                     560+*TCBTWASL EQU TCBTWALS EQUATE TO HANDLE RPR TYPEO V6.9    *IN V6.10                         
 0000A8                              561+TCBTWALA DS    A(0) ACCUMULATED 'WALL CLOCK' TIME             V6.9                          
 0000AC                              562+TCBTCPUP DS    A(0) ACCUM. 'TASK' CPU TIME (PROBLEM STATE)    V6.9                          
                                     563+*TCBTCPU EQU TCBTCPUP OLD 'TCBTCPU' REMOVED IN FUT.V6.9   *IN V6.10                         
 0000B0                              564+TCBTCPUS DS    A(0) ACCUM. 'TASK' CPU TIME (SUPERVISOR ST.)   V6.9                          
 0000B4                              565+TCBTSYS  DS    A(0) ACCUM. 'SYSTEM' CPU TIME                  V6.9                          
 0000B8                              566+TCBTATQE DS    A(0) ADDRESS OF TIMER QUEUE ELEMENT            V6.9                          
 0000BC                              567+TCBTSLIC DS    A(0) ADDRESS OF TIME SLICE PARAMETERS          V6.9                          
 0000C0                              568+TCBIOCNT DS    A(0) I/O COUNTS ON C-D-E-F (1 BYTE EACH)      V6.10                          
 0000C4                              569+TCBTMRA1 DS    A(0) 'TIME' RATIO NUMBER 1                    V6.10                          
 0000C8                              570+TCBTMRA2 DS    A(0) 'TIME' RATIO NUMBER 2                    V6.10                          
 0000CC                              571+         DS    4A(0) RESERVED                                V6.10                          
 0000DC                              572+TCBBACK  DS    A(0) BACKWARD (REV. OF TCBTCB) TCB CHA. POINT. V6.9                          
 0000E0                              573+TCBFRS   DS    4D   STORAGE FOR FOUR FLOATING POINT REGS.    V6.83                          
 000100                              574+TCBLNTH  EQU   *-TCB     LENGTH OF THE TCB  (X'100')         V6.83                          
                                     575+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 2 OF 3                                 
                                     576+*CSCI 468  SOS V6.10 4/7/94  DSECTS MACRO   PAGE 3 OF 3                                     
 000000                              577+RB       DSECT                                                                              
 000000                              578+RBTYPE   DS    CL4'SVRB' DOCUMENTATION: SVRB OR PRB OR OTHER                                
 000004                              579+RBTCB    DS    A         ADD. OF THE TCB FOR THIS TASK                                      
 000008                              580+RBFLGS03 DS    4X        3X RESERVED                                                        
1       Brandon Tweed SOS-Uni                                                                                   PAGE    5            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 00000B                              581+RBFLGS3  EQU   RBFLGS03+3   1... .... BIT=1 INDICATES RBLINK IS TCB                         
 00000C                              582+RBCDE    DS    A         RESERVED                                                           
 00000C                              583+RBUNCH   EQU   RBCDE     LOCATION FOR C'UNCH' INDICATOR IN RB  V6.12                        
 000010                              584+RBOPSW   DS    XL8       RESUME PSW FOR THIS TASK                                           
 000018                              585+RBPGNQ   DS    A         RESERVED                                                           
 00001C                              586+RBLINK   DS    A(0) POINTER TO PREV. RB ON THE CHAIN (LAST 3 BYTES)                         
                                     587+*                        OR TCB WHEN THIS IS LAST RB ON THE CHAIN.                          
                                     588+*                        (RBFLGS3 -- BIT 0, SET TO 1 INDICATES TCB)                         
 00001C                              589+RBWCF    EQU   RBLINK    X'00'  COUNT OF EVENTS WAITED FOR                                  
 000020                              590+RBGRSAVE DS    16F       REGISTERS 0-15 WHEN REQUEST ENTERED                                
 000060                              591+RBFRSAVE DS    4D        SAVE AREA FOR FLOATING PT. REGISTERS                               
 000080                              592+RBLNTH   EQU   *-RB      LENGTH OF A REQUEST BLOCK  (X'80')                                 
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              594+UCB      DSECT                                                                              
 000000                              595+UCBIDENT DS    CL3'UCB',X'FF' DOCUMENTATION                                                 
 000004                              596+UCBCHAN  DS    X'0000' DEVICE ADDRESS IN HEX                                                
 000006                              597+UCBFLA   DS    X'00' = FREE, X'FF' = BUSY                                                   
 000007                              598+UCBFLB   DS    X'00'   RESERVED                                                             
 000008                              599+UCBUCB   DS    A(0)    ADD. NEXT UCB ON CHAIN OR 0 IF THIS = LAST.                          
 00000C                              600+UCBNAME  DS    CL4'NAME' DEVICE ADDRESS IN EBCDIC                                           
 000010                              601+UCBCURQE DS    A(0)     ADDRESS OF RQE CURRENTLY BEING PROCESSED                            
 000014                              602+UCBWARQE DS    A(0) ADD. FIRST RQE IN WAIT QUEUE, / 0 IF NONE THERE                         
 000018                              603+UCBIOSTR DS    A(0)   ADDRESS OF DEVICE'S I/O START ROUTINE                                 
 00001C                              604+         DS    A(0)   RESERVED                                                              
 000020                              605+UCBLNTH  EQU   *-UCBIDENT LENGTH OF UCB  (X'20')                                            
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     
 000000                              607+MSDA     DSECT                                                                              
 000000 D4E2C4C1                     608+MSDAID   DC    C'MSDA' EBCDIC IDENTIFIER                      V6.13                         
 000004 00000000                     609+MSDAMECB DC    A(0)    MAS. SCH. ECB (ADD. IN CVTMSECB)       V6.13                         
 000008 00000000                     610+MSDAMAXI DC    A(0)    MAX. NUMBER OF INITIATORS TO RUN       V6.13                         
 00000C 00000000                     611+MSDACURI DC    A(0)    CURRENT NUM. OF INITIATORS ACTIVE      V6.13                         
 000010 00000000                     612+MSDAFLAD DC    A(0)    LOAD ADDRESS FOR NEXT USER PROGRAM     V6.13                         
 000014 00                           613+MSDAFKEY DC    X'00'   KEY+FETCH FOR SSK+PSW: NEXT USER PGM.  V6.13                         
 000015 00                           614+MSDAFPAD DC    X'00'   PAD CHAR. FOR NEXT 4K USER REGION      V6.13                         
 000016 0000                         615+         DC    H'0'    RESERVED                               V6.13                         
 000018 0000000000000000             616+         DC    2A(0)   RESERVED                               V6.13                         
 000020 0000000000000000             617+MSDAFFLO DC    D'0'    1ST FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000028 0000000000000000             618+MSDAFFL2 DC    D'0'    2ND FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000030 0000000000000000             619+MSDAFFL4 DC    D'0'    3RD FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000038 0000000000000000             620+MSDAFFL6 DC    D'0'    4TH FLOAT. NUM. FOR NEXT 4K USER PGM.  V6.13                         
 000040                              621+MSDALNTH EQU   *-MSDAID LEN. OF M-SCH. DATA AREA (X'40')      V6.13                         
                                     622+*CSCI 468  SOS V6.10 4/7/94              END OF PAGE 3 OF 3                                 
                                     623 *                                                                                           
                                     624 **********************************************************************                      
                                     625 * SVC 13 MODIFIED STORAGE                                                                   
                                     626 **********************************************************************                      
                                     627 *                                                                                           
 000000                              628 SVC13S   DSECT                                                                              
 000000 00000000                     629 IOBSVC13 DC    F'0'                   Fullword Alignment                                    
 000000                              630          ORG   IOBSVC13               Go back and redefine                                  
 000000 C9D6C2E6                     631          DC    CL4'IOBW'              IOB IDENTIFICATION                                    
 000004 000F                         632          DC    XL2'000F'              FOR XPRINT                                            
 000006 01                           633          DC    X'01'                  '01' = WRITE                                          
1       Brandon Tweed SOS-Uni                                                                                   PAGE    6            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000007 F0                           634          DC    C'0'                   RESERVED FOR STUFF                                    
 000008 00000000                     635          DC    A(0)                   A(BUFFER) TO WRITE                                    
 00000C 0000                         636          DC    H'0'                   LENGTH OF BUFFER TO READ/WRITE                        
 00000E 0000                         637          DC    H'0'                   RESERVED FOR STUFF                                    
 000010 D340404040404040             638 SVC13WRK DC    CL16'L'                LOUNTR work area                                      
 000020 07F2                         639 RETLNTR  DC    XL2'07F2'              For coming back from LOUNTR                           
 000024 00000000                     640 PARM1    DC    A(0)                   Address of the print line                             
 000028 00000000                     641 PARM2    DC    A(0)                   Address of the halfword length                        
 00002C 00000000                     642 PARM3    DC    A(0)                   Address of IOB                                        
 000030 0000000000000000             643 SASVC13  DC    16F'0'                 Save area for SVC13PRN                                
 000070 0000                         644 PLINEL   DC    H'0'                   Pline length                                          
                                     645 *                                                                                           
 000072 4040404040404040             646 SVC13BUF DC    CL133' '               Line buffer                                           
                                     647 *                                                                                           
 000072                              648          ORG   SVC13BUF               Redefine line buffer                                  
 000072 F0                           649 GPRMSG   DC C'0'                      GPR carriage control                                  
 000073 C7D7D940F060F740             650          DC CL9'GPR 0-7  '            GPR MESSAGES                                          
 00007C 4040404040404040             651          DC 8C' '                     SPACE OUT THE GPRS                                    
 000084 E7E7E7E7E7E7E7E7             652 GPL1STRT DC CL9'XXXXXXXX '            GPR 0                                                 
 00008D E7E7E7E7E7E7E7E7             653          DC CL9'XXXXXXXX '            GPR 1                                                 
 000096 E7E7E7E7E7E7E7E7             654          DC CL9'XXXXXXXX '            GPR 2                                                 
 00009F E7E7E7E7E7E7E7E7             655          DC CL9'XXXXXXXX '            GPR 3                                                 
 0000A8 E7E7E7E7E7E7E7E7             656          DC CL9'XXXXXXXX '            GPR 4                                                 
 0000B1 E7E7E7E7E7E7E7E7             657          DC CL9'XXXXXXXX '            GPR 5                                                 
 0000BA E7E7E7E7E7E7E7E7             658          DC CL9'XXXXXXXX '            GPR 6                                                 
 0000C3 E7E7E7E7E7E7E7E7             659          DC CL9'XXXXXXXX '            GPR 7                                                 
 00005A                              660 GPL1PLEN EQU *-GPRMSG                 length of print line 1                                
                                     661 *                                                                                           
 000072                              662          ORG   SVC13BUF               Redefine line buffer                                  
 000072 F0                           663 FPRPLIN  DC C'0'                      double space                                          
 000073 C6D7D9A240F06BF2             664          DC CL17'FPRs 0,2,4,6:    '   next                                                  
 000084 E7E7E7E7E7E7E7E7             665 FPR0STRT DC CL17'XXXXXXXXXXXXXXXX '   FPR 0                                                 
 000095 E7E7E7E7E7E7E7E7             666          DC CL17'XXXXXXXXXXXXXXXX '   FPR 2                                                 
 0000A6 E7E7E7E7E7E7E7E7             667          DC CL17'XXXXXXXXXXXXXXXX '   FPR 4                                                 
 0000B7 E7E7E7E7E7E7E7E7             668          DC CL17'XXXXXXXXXXXXXXXX '   FPR 6                                                 
 000056                              669 FPRPLLEN EQU *-FPRPLIN                Length of FPR pline                                   
                                     670 *                                                                                           
 000072                              671          ORG   SVC13BUF               Redefine line buffer                                  
 000072 F0                           672 R1MSG    DC C'0'                      Carriage control                                      
 000073 C3D6D5E3C5D5E3E2             673          DC CL16'CONTENTS OF R1: '    R1 Message                                            
 000083 E7E7E7E7E7E7E7E7             674 R1VAL    DC CL8'XXXXXXXX'             R1 Message                                            
 000019                              675 R1MSGLEN EQU *-R1MSG                  R1 Message Length                                     
                                     676 *                                                                                           
 000072                              677          ORG   SVC13BUF               Redefine line buffer                                  
 000072 F0                           678 PSWMSG   DC C'0'                      CARRIAGE CONTROL                                      
 000073 D7E2E640C1E340E3             679          DC CL21'PSW AT TIME OF ERROR:' PSW Message                                         
 000088 404040                       680          DC 3C' '                                                                           
 00008B D7E2E6F140C8C5D9             681 PSWP1    DC CL8'PSW1 HERE'            PSW PART 1                                            
 000093 404040                       682          DC 3C' '                     BLANKS                                                
 000096 D7E2E6F240C8C5D9             683 PSWP2    DC CL8'PSW2 HERE'            PSW PART 2                                            
 00002C                              684 PSWMSGL  EQU *-PSWMSG                 PSW message length                                    
                                     685 *                                                                                           
 000072                              686          ORG   SVC13BUF               Redefine line buffer                                  
 000072 F0                           687 DMSG     DC C'0'                      CARRIAGE CONTROL                                      
 000073 C4C1E3C140C1E340             688          DC CL12'DATA AT PSW '        Data Message                                          
 00007F 4040404040                   689          DC 5C' '                     SPACING                                               
 000084 E7E7E7E7E7E7E7E7             690 DAADDR   DC CL9'XXXXXXXX '            Data area address                                     
1       Brandon Tweed SOS-Uni                                                                                   PAGE    7            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 00008D 60                           691 DMSDASH  DC C'-'                      HYPHEN TO BE INSERTED                                 
 00008E 40                           692          DC C' '                      SPACING                                               
 00008F E7E7E7E7E7E7E7E7             693 DBYTES1  DC CL8'XXXXXXXX'             First 4 data bytes                                    
 000097 4040                         694          DC 2CL1' '                   Data Message                                          
 000099 E7E7E7E7E7E7E7E7             695 DBYTES2  DC CL8'XXXXXXXX'             Second 4 data bytes                                   
 0000A1 4040                         696          DC 2CL1' '                   Data Message                                          
 0000A3 E7E7E7E7E7E7E7E7             697 DBYTES3  DC CL8'XXXXXXXX'             Last 4 data bytes                                     
 0000AB 4040404040404040             698          DC 81C' '                    Rest of print line                                    
 00008A                              699 DMSGL    EQU *-DMSG                   Length of Data Message                                
1       START OF FIRST 4K                                                                                       PAGE    8            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     701 *                                                                                           
                                     702 **********************************************************************                      
                                     703 * START OF FIRST 4K OF STORAGE                                                              
                                     704 **********************************************************************                      
                                     705 *                                                                                           
 000000                              706 FIRST4K  CSECT                        START OF FIRST4K                                      
 000000                              707          USING FIRST4K,0              ESTABLISH FIRST4K ADDR                                
 000000 0119011901190119             708          DC    2048X'0119'            FILL 1ST WITH 'QUICK STOP'                            
 000000                              709          ORG   FIRST4K                GO BACK TO START OF 1ST 4K                            
 000000 010401190F003000             710          DC    X'010401190F',AL3(IPLPGM) DEFINE IPLPSW                                      
 000010                              711          ORG   FIRST4K+X'10'          GO TO LOCATION FOR @(CVT)                             
 000010 00002800                     712 CVT#1    DC    A(MYCVT)               ADDRESS OF MYCVT                                      
                                     713 *                                                                                           
                                     714 *********************************************                                               
                                     715 * OLD PSWs                                                                                  
                                     716 *********************************************                                               
                                     717 *                                                                                           
 000018                              718          ORG   FIRST4K+X'18'          GO TO LOCATION FOR OLDPSWs                            
 000018 0000000000000000             719 OPSWEX   DC    D'0'                   OLD EXT INT PSW                                       
 000020 0000000000000000             720 OPSWSVC  DC    D'0'                   OLD SVC PSW                                           
 000028 0000000000000000             721 OPSWPC   DC    D'0'                   OLD PC PSW                                            
 000030 0000000000000000             722 OPSWMC   DC    D'0'                   OLD MC PSW                                            
 000038 0000000000000000             723 OPSWIO   DC    D'0'                   OLD I/O PSW                                           
 000040 0000000000000000             724 CSW      DC    D'0'                   Channel Status Word                                   
 000048 00000000                     725 CAW      DC    F'0'                   Channel Address Word                                  
 00004C 00002800                     726 CVT#2    DC    A(MYCVT)               ADDRESS OF MYCVT                                      
 000050 00000000                     727 CLOCK    DC    F'0'                   ASSEMBLE CLOCK AS VALUE ZERO                          
                                     728 *                                                                                           
                                     729 ********************************************                                                
                                     730 * NEW PSWs                                                                                  
                                     731 ********************************************                                                
                                     732 *                                                                                           
 000058                              733          ORG   FIRST4K+X'58'               LOCATION FOR NEW PSWS                            
 000058 010601190F004012             734 NPSWEX   DC    X'010601190F',AL3(EXFLIH)   NEW PSW EXTERNAL                                 
 000060 010401190F004014             735 NPSWSVC  DC    X'010401190F',AL3(SVCFLIH)  NEW PSW SVC                                      
 000068 010401190F003022             736 NPSWPC   DC    X'010401190F',AL3(AFTERLOP) NEW PSW PC                                       
 000070 010401190F00429A             737 NPSWMC   DC    X'010401190F',AL3(MCFLIH)   NEW PSW MACHINE CHECK                            
 000078 010401190F00429C             738 NPSWIO   DC    X'010401190F',AL3(IOFLIH)   NEW PSW I/O                                      
                                     739 *                                                                                           
 0000A0                              740          ORG   FIRST4K+X'A0'          LOCATION FOR LOWPSW                                   
 0000A0 0000000000000000             741 LOWPSW   DC    D'0'                   FILL LOWPSW WITH ZERO                                 
                                     742 *                                                                                           
 0000B0                              743          ORG   FIRST4K+X'B0'          LOCATION FOR LOWTIME                                  
 0000B0 00000000                     744 LOWTIME  DC    F'0'                   FILL LOWTIME WITH ZERO                                
                                     745 *                                                                                           
 0000BC                              746          ORG   FIRST4K+X'BC'          MOVE TO LOCATION FOR LEVELABN                         
 0000BC 0119                         747 LEVELABN DC    X'0119'                SET VALUE FOR LEVELABN                                
 0000BE E7                           748 LEVELFLG DC    C'X'                   LATER SET TO C'S' IN IPL                              
 0000BF E7                           749 TYP1FLAG DC    C'X'                   LATER SET TO C'0' IN IPL                              
                                     750 *                                                                                           
                                     751 *****************************************                                                   
                                     752 *  SAVE AREAS FOR INTERRUPTS                                                                
                                     753 *****************************************                                                   
                                     754 *                                                                                           
 0000C0 C5E74040C5E74040             755 EXSAVE   DC    16CL4'EX'              SAVE AREA FOR EXTERNAL INTS                           
 000100 E2E54040E2E54040             756 SVCSAVE  DC    16CL4'SV'              SAVE AREA FOR SVC INTERRUPTS                          
 000140 D7C34040D7C34040             757 PCSAVE   DC    16CL4'PC'              SAVE AREA FOR PC INT.                                 
1       START OF FIRST 4K                                                                                       PAGE    9            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 000180 C9D64040C9D64040             758 IOSAVE   DC    16CL4'IO'              SAVE AREA FOR I/O INTERRUPTS                          
                                     759 *                                                                                           
                                     760 ******************************************                                                  
                                     761 * TCB WORDS, LOUNTR                                                                         
                                     762 ******************************************                                                  
                                     763 *                                                                                           
 000518                              764          ORG   FIRST4K+X'518'         MOVE TO LOCATION FOR TCBWORDS                         
 000518 0000000000000000             765 TCBWORDS DC    4F'0'                  FILL TCBWORDS WITH ZEROS                              
 0007E0                              766          ORG   FIRST4K+X'7E0'         MOVE TO LOCATION FOR LOUNTR                           
 0007E0                              767 LOUNTR   DS    0H                     LABEL FOR START OF LOUNTR                             
                                     768          LOUNTR                       INVOKE LOUNTR MACRO                                   
                                     769+* LOUNTR ==> MUST <== BE LOCATED AT X'7E0'                                                  
 0007E0 F3841000100CDC07             770+ DC X'F3841000100CDC071000070047F01010',C'0123456789ABCDEF' LOUNTR                          
                                     771 *                                                                                           
                                     772 *********************************************************************                       
                                     773 * UCB - UNIT CONTROL BLOCKS                                                                 
                                     774 *********************************************************************                       
                                     775 *                                                                                           
 000800                              776          ORG FIRST4K+X'800'           Go to location for UCBs                               
 000800 0000000000000000             777 STRTUCB  DC    128X'00'               Set them all to zero                                  
 000800                              778          ORG   STRTUCB                Go back and define each UCB                           
 000800 E4C3C2FF                     779 UCB1     DC    CL3'UCB',X'FF'         UCB IDENT                                             
 000804 000C                         780          DC    X'000C'                UCB for device VIRTRDR1                               
 000808                              781          ORG   UCB1+(UCBUCB-UCB)      Go to UCBUCB field                                    
 000808 00000820                     782          DC    A(UCB2)                A(next UCB)                                           
 00080C F0F0F0C3                     783          DC    CL4'000C'              UCBNAME field                                         
 000818                              784          ORG   UCB1+(UCBIOSTR-UCB)    Go to UCBIOSTR field                                  
 000818 000126F0                     785          DC    A(SIOC)                Address of UCB's IO routine                           
 00081C 00000000                     786          DC    A(0)                   Reserved                                              
                                     787 *                                                                                           
 000820 E4C3C2FF                     788 UCB2     DC    CL3'UCB',X'FF'         UCB IDENT                                             
 000824 000D                         789          DC    X'000D'                UCB for device                                        
 000828                              790          ORG   UCB2+(UCBUCB-UCB)      Go to UCBUCB field                                    
 000828 00000840                     791          DC    A(UCB3)                A(next UCB)                                           
 00082C F0F0F0C4                     792          DC    CL4'000D'              UCBNAME field                                         
 000838                              793          ORG   UCB2+(UCBIOSTR-UCB)    Go to UCBIOSTR field                                  
 000838 00012740                     794          DC    A(SIOD)                Address of UCB's IO routine                           
 00083C 00000000                     795          DC    A(0)                   Reserved                                              
                                     796 *                                                                                           
 000840 E4C3C2FF                     797 UCB3     DC    CL3'UCB',X'FF'         UCB IDENT                                             
 000844 000E                         798          DC    X'000E'                UCB for device                                        
 000848                              799          ORG   UCB3+(UCBUCB-UCB)      Go to UCBUCB field                                    
 000848 00000860                     800          DC    A(UCB4)                A(next UCB)                                           
 00084C F0F0F0C5                     801          DC    CL4'000E'              UCBNAME field                                         
 000858                              802          ORG   UCB3+(UCBIOSTR-UCB)    Go to UCBIOSTR field                                  
 000858 00012790                     803          DC    A(SIOE)                Address of UCB's IO routine                           
 00085C 00000000                     804          DC    A(0)                   Reserved                                              
                                     805 *                                                                                           
 000860 E4C3C2FF                     806 UCB4     DC    CL3'UCB',X'FF'         UCB IDENT                                             
 000864 000F                         807          DC    X'000F'                UCB for device                                        
 000868                              808          ORG   UCB4+(UCBUCB-UCB)      Go to UCBUCB field                                    
 000868 00000000                     809          DC    A(0)                   A(0) - Last UCB in chain                              
 00086C F0F0F0C6                     810          DC    CL4'000F'              UCBNAME field                                         
 000878                              811          ORG   UCB4+(UCBIOSTR-UCB)    Go to UCBIOSTR field                                  
 000878 00012858                     812          DC    A(SIOF)                Address of UCB's IO routine                           
 00087C 00000000                     813          DC    A(0)                   Reserved                                              
                                     814 *                                                                                           
1       START OF FIRST 4K                                                                                       PAGE   10            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     815 ************************************                                                        
                                     816 * SVCTABLE                                                                                  
                                     817 ************************************                                                        
                                     818 *                                                                                           
 002000                              819          ORG   FIRST4K+X'2000'        MOVE TO LOCATION FOR SVC TABLE                        
 002000 0000000000000000             820 SVCTABLE DC    16D'0'                 FILL SVC TABLE WITH ZEROS                             
 002000                              821          ORG   SVCTABLE+8*0           GO TO ENTRY FOR SVC 0                                 
 002000 00006000                     822          DC    A(SVC0)                ADDRESS OF SVC 0                                      
 002008                              823          ORG   SVCTABLE+8*1           GO TO ENTRY FOR SVC 1                                 
 002008 00006066                     824          DC    A(SVC1)                ADDRESS OF SVC 1                                      
 002010                              825          ORG   SVCTABLE+8*2           GO TO ENTRY FOR SVC 2                                 
 002010 00006098                     826          DC    A(SVC2)                ADDRESS OF SVC 2                                      
 002018                              827          ORG   SVCTABLE+8*3           GO TO ENTRY FOR SVC 3                                 
 002018 00007000                     828          DC    A(SVC3)                ADDRESS OF SVC 3                                      
 002040                              829          ORG   SVCTABLE+8*8           GO TO ENTRY FOR SVC 8                                 
 002040 00007300                     830          DC    A(SVC8)                ADDRESS OF SVC 8                                      
 002044 80                           831          DC    X'80'                  B'10' indicates type 2 SVC                            
 002068                              832          ORG   SVCTABLE+8*13          GO TO ENTRY FOR SVC 13                                
 002068 00008000                     833          DC    A(SVC13)               ADDRESS OF SVC 13                                     
 00206C C0                           834          DC    X'C0'                  Indicate type 4 SVC                                   
 002070                              835          ORG   SVCTABLE+8*14          GO TO ENTRY FOR SVC 14                                
 002070 000082EA                     836          DC    A(SVC14)               ADDRESS OF SVC 14                                     
 002074 C0                           837          DC    X'C0'                  Type 4 SVC                                            
 002078                              838          ORG   SVCTABLE+8*15          GO TO ENTRY FOR SVC 5                                 
 002078 00002080                     839          DC    A(BR14)                ADDRESS OF "BR14" ROUTINE                             
 002080                              840          ORG   ,                      MOVE IT FORWARD                                       
 002080 1BFF07FE                     841 BR14     DC    X'1BFF07FE'            SR 15,15 AND BR 14                                    
                                     842 *                                                                                           
                                     843 *********************************************************************                       
                                     844 * DISPATCHER                                                                                
                                     845 *                                                                                           
                                     846 * ON ENTRY:                                                                                 
                                     847 *    R3  = A(CVT)                                                                           
                                     848 *    R12 = A(DISPATCH)                                                                      
                                     849 *********************************************************************                       
                                     850 *                                                                                           
 002400                              851          ORG   FIRST4K+X'2400'        MOVE TO DISPATCHER LOCATION                           
 002400                              852          USING DISPATCH,12            DISPATCHER ADDRESSABILITY                             
 000000                              853          USING CVT,3                  CVT ADDRESSABILITY                                    
 002400 5840 3008            00008   854 DISPATCH L     4,CVTHEAD              GET ADDRESS FIRST TCB                                 
 000000                              855          USING TCB,4                  TCB ADDRESSABILITY                                    
 002404 1244                         856 DLOOP    LTR   4,4                    CHECK TCB POINTER NOT NULL                            
 002406 4780 C158            02558   857          BZ    D0119                  IF SO, DIE                                            
 00240A 5850 4000            00000   858          L     5,TCBRB                GET RB ADDRESS                                        
 000000                              859          USING RB,5                   RB ADDRESSABILITY                                     
 00240E 1255                         860          LTR   5,5                    VERIFY RB POINTER NOT NULL                            
 002410 4780 C06E            0246E   861          BZ    ENDJOB                 RB POINTER NULL = END OF JOB                          
 002414 9500 501C      0001C         862          CLI   RBWCF,X'00'            CHECK WAIT COUNT FIELD = 0                            
 002418 4780 C024            02424   863          BE    DODISP                 IF SO, DISPATCH THIS TCB                              
 00241C 5840 4074            00074   864          L     4,TCBTCB               IF NOT, GO TO NEXT TCB                                
 002420 47F0 C004            02404   865          B     DLOOP                  CONTINUE TCB LOOP                                     
                                     866 *                                                                                           
                                     867 * 1) save address of TCB to be dispatched into TCBWORDS+4                                   
                                     868 *                                                                                           
 002424 5040 051C            0051C   869 DODISP   ST    4,TCBWORDS+4           SAVE @ TCB TO BE DISPATCHED                           
                                     870 *                                                                                           
                                     871 * 2) Move PSW to be dispatched from RB to lowcore                                           
1       START OF FIRST 4K                                                                                       PAGE   11            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     872 *                                                                                           
 002428 D207 00A0 5010 000A0 00010   873          MVC   LOWPSW(8),RBOPSW       MOVE PSW TO BE DISPATCHED                             
                                     874 *                                                                                           
                                     875 * Increment dispatch count                                                                  
                                     876 *                                                                                           
 00242E 5870 C21C            0261C   877          L     7,DCOUNT               GET DCOUNT                                            
 002432 4170 7001            00001   878          LA    7,1(,7)                INCREMENT IT                                          
 002436 5070 C21C            0261C   879          ST    7,DCOUNT               SAVE IT                                               
                                     880 *                                                                                           
                                     881 * After so many dispatches, turn off the trace                                              
                                     882 *                                                                                           
 00243A 5970 C220            02620   883          C     7,DMAX                 Check dispatch count > 60                             
 00243E 47D0 C044            02444   884          BNH   LDFPRS                 If so, turn off the trace                             
 002442 0104                         885          XOPC  4                      Turn off the trace                                    
                                     886 *                                                                                           
                                     887 * 3) Load all registers                                                                     
                                     888 *                                                                                           
 002444 6800 40E0            000E0   889 LDFPRS   LD    0,TCBFRS+8*0           LOAD FPR 0                                            
 002448 6820 40E8            000E8   890          LD    2,TCBFRS+8*1           LOAD FPR 2                                            
 00244C 6840 40F0            000F0   891          LD    4,TCBFRS+8*2           LOAD FPR 4                                            
 002450 6860 40F8            000F8   892          LD    6,TCBFRS+8*3           LOAD FPR 6                                            
                                     893 *                                                                                           
                                     894 * Save time of dispatch into TCB before losing addressability                               
                                     895 *                                                                                           
 002454 D203 40A0 0050 000A0 00050   896          MVC   TCBTDISP(4),CLOCK      SAVE TIME OF DISPATCH                                 
 00245A 980F 4030            00030   897          LM    0,15,TCBGRS            LOAD ALL GPRS                                         
                                     898 *                                                                                           
                                     899 * 4) Test/set the LEVELFLG prior to departing for                                           
                                     900 *    THE SEA OF TASK                                                                        
                                     901 *                                                                                           
 00245E 95E2 00BE      000BE         902          CLI   LEVELFLG,C'S'          CHECK LEVELFLG IS 'S'                                 
 002462 4770 00BC            000BC   903          BNE   LEVELABN               ABEND IF NOT                                          
 002466 92E3 00BE      000BE         904          MVI   LEVELFLG,C'T'          SET LEVELFLG TO TASK                                  
                                     905 *                                                                                           
                                     906 * 5) Load the PSW to complete the dispatch                                                  
                                     907 *                                                                                           
 00246A 8200 00A0      000A0         908          LPSW  LOWPSW                 Load PSW to run task                                  
                                     909 *                                                                                           
                                     910 *** BEGINNING OF ENDJOB CODE ****                                                           
                                     911 *                                                                                           
                                     912 * 1) UNCHAIN THE TCB                                                                        
                                     913 *                                                                                           
 00246E 5870 40DC            000DC   914 ENDJOB   L     7,TCBBACK              GET BACKWARD TCB PTR                                  
 002472 5880 4074            00074   915          L     8,TCBTCB               GET FORWARD  TCB PTR                                  
 002476 D203 4028 C1DF 00028 025DF   916          MVC   TCBUNCH(4),UNCH        INDICATE UNCHAINED                                    
 00247C                              917          DROP  4                      DONE WITH CURRENT TCB                                 
                                     918 *                                                                                           
                                     919 * UPDATE FORWARD POINTER OF PREVIOUS TCB                                                    
                                     920 *                                                                                           
 000000                              921          USING TCB,7                  PREV TCB ADDR                                         
 00247C 5080 7074            00074   922          ST    8,TCBTCB               UPDATE FORWARD PTR                                    
 002480                              923          DROP  7                      DONE WITH PREV TCB                                    
                                     924 *                                                                                           
                                     925 * UPDATE BACK PTR OF NEXT TCB                                                               
                                     926 *                                                                                           
 000000                              927          USING TCB,8                  ADDR FOR NEXT TCB                                     
 002480 5070 80DC            000DC   928          ST    7,TCBBACK              UPDATE BACK PTR OF NEXT TCB                           
1       START OF FIRST 4K                                                                                       PAGE   12            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 002484                              929          DROP  8                      DONE WITH "NEXT" TCB                                  
                                     930 *                                                                                           
                                     931 * 2) PRINT "END OF JOB" MESSAGE                                                             
                                     932 *                                                                                           
 000000                              933          USING TCB,4                  REFER TO TCB UNCHAINED                                
 002484 D207 C179 4008 02579 00008   934          MVC   EJTCBN(8),TCBTNAME     GET TCB NAME                                          
 00248A D207 C18C 4010 0258C 00010   935          MVC   EJPGMN(8),TCBPNAME     GET PROGRAM NAME                                      
                                     936 *                                                                                           
 002490 D203 C0A6 40AC 024A6 000AC   937          MVC   EJWRK+12(4),TCBTCPUP   PUT TASK TIME INTO LOUNTR                             
 002496 4510 07E0            007E0   938          BAL   1,LOUNTR               CALL LOUNTR ON TASK TIME                              
 00249A D340404040404040             939 EJWRK    DC    CL16'L'                LOUNTR STORAGE AREA                                   
 0024AA D207 C19E C09A 0259E 0249A   940          MVC   EJTT(8),EJWRK          TASK TIME -> PRINT LINE                               
                                     941 *                                                                                           
 0024B0 D203 C0C6 40B0 024C6 000B0   942          MVC   EJWRK2+12(4),TCBTCPUS  PUT SV Task time into LOUNTR                          
 0024B6 4510 07E0            007E0   943          BAL   1,LOUNTR               CALL LOUNTR TO xLATE SV TASK                          
 0024BA D340404040404040             944 EJWRK2   DC    CL16'L'                STORAGE FOR SV TIME LOUNTR                            
 0024CA D207 C1AE C0BA 025AE 024BA   945          MVC   EJST(8),EJWRK2         Save Super Time to Print Line                         
                                     946 *                                                                                           
 0024D0 D203 C0E6 4024 024E6 00024   947          MVC   EJ4WRK+12(4),TCBTWAIT  Get I/O wait time                                     
 0024D6 4510 07E0            007E0   948          BAL   1,LOUNTR               Use lounter to xlate wait time                        
 0024DA C3C3C3C3C3C3C3C3             949 EJ4WRK   DC    16C'C'                 storage for LOUNTR call                               
 0024EA D207 C1C0 C0DA 025C0 024DA   950          MVC   EJIOW(8),EJ4WRK        Copy xlated wait time to pline                        
                                     951 *                                                                                           
 0024F0 D203 C106 40C0 02506 000C0   952          MVC   EJ5WRK+12(4),TCBIOCNT  Copy I/O counts into LOUNTR buf                       
 0024F6 4510 07E0            007E0   953          BAL   1,LOUNTR               Call LOUNTR to xlate I/O counts                       
 0024FA D9D9D9D9D9D9D9D9             954 EJ5WRK   DC    16C'R'                 storage for LOUNTR call                               
 00250A D207 C1D2 C0FA 025D2 024FA   955          MVC   EJIOCNT(8),EJ5WRK      Put xlated I/O counts on pline                        
 002510 E020 C15A 0085 0255A         956          XPRNT EJMSG2,133             PRINT 2ND END JOB MSG                                 
                                     957 *                                                                                           
                                     958 * Decrement CURI                                                                            
                                     959 *                                                                                           
 002516 5820 304C            0004C   960          L     2,CVTMSDAT             Get @ MSDA from CVT                                   
 000000                              961          USING MSDA,2                 MSDA addressability                                   
 00251A 5890 200C            0000C   962          L     9,MSDACURI             Get the CURI                                          
 00251E 0690                         963          BCTR  9,0                    SUBTRACT ONE                                          
 002520 5090 200C            0000C   964          ST    9,MSDACURI             Store the new CURI                                    
                                     965 *                                                                                           
                                     966 * Perform Branch entry into SVC 2                                                           
                                     967 *                                                                                           
 002524 5860 3004            00004   968          L     6,CVTSVCTA             Get addr. of SVC table                                
 002528 5860 6010            00010   969          L     6,2*8(,6)              Get addr of SVC 2                                     
 00252C 1266                         970          LTR   6,6                    Check address                                         
 00252E 4780 C158            02558   971          BZ    D0119                  If invalid address, die                               
 002532 5800 C1E4            025E4   972          L     0,MECBINIT             Put post code into R0 (bits 2-31)                     
 002536 4110 2004            00004   973          LA    1,MSDAMECB             Get addr. of ECB into R1                              
                                     974 *                                                                                           
 00253A 95F0 00BF      000BF         975          CLI   TYP1FLAG,C'0'          CHECK IF IN TYPE 1 STATE                              
 00253E 4770 00BC            000BC   976          BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP                         
 002542 92F1 00BF      000BF         977          MVI   TYP1FLAG,C'1'          OTHERWISE SWITCH TO NON-TYPE 1                        
                                     978 *                                                                                           
 002546 05E6                         979          BALR 14,6                    Branch into SVC2                                      
                                     980 *                                                                                           
 002548 95F1 00BF      000BF         981          CLI   TYP1FLAG,C'1'          CHECK IF IN TYPE 1 STATE                              
 00254C 4770 00BC            000BC   982          BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP                         
 002550 92F0 00BF      000BF         983          MVI   TYP1FLAG,C'0'          OTHERWISE SWITCH TO NON-TYPE 1                        
                                     984 *                                                                                           
                                     985 * Post completed, Continue the dispatch loop                                                
1       START OF FIRST 4K                                                                                       PAGE   13            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                     986 *                                                                                           
 002554 47F0 C000            02400   987          B     DISPATCH               CONTINUE DISPATCH LOOP                                
 002558                              988          DROP  3,4,5                  DONE WITH CVT, TCB, RB                                
 002558 0119                         989 D0119    XOPC  25                     DIE ON ERROR                                          
                                     990 *                                                                                           
                                     991 ************************************                                                        
                                     992 * DISPATCHER WORKING STORAGE                                                                
                                     993 ************************************                                                        
                                     994 *                                                                                           
 00255A F0                           995 EJMSG2   DC    C'0'                   CARRIAGE CONTROL                                      
 00255B E2D6E240E3C5D9D4             996          DC    CL20'SOS TERMINATING!' TERMINATION MESSAGE                                   
 00256F E3C3C240D5C1D4C5             997          DC    CL10'TCB NAME: '       TCB NAME                                              
 002579 E7E7E7E7E7E7E7E7             998 EJTCBN   DC    CL8'XXXXXXXX'          PUT TCB NAME HERE                                     
 002581 40D7C7D440D5C1D4             999          DC    CL11' PGM NAME: '      PGM NAME                                              
 00258C E7E7E7E7E7E7E7E7            1000 EJPGMN   DC    CL8'XXXXXXXX'          PUT PGM NAME HERE                                     
 002594 40D7D9D6C2D3C5D4            1001          DC    CL10' PROBLEM: '       TASK TIME                                             
 00259E E7E7E7E7E7E7E7E7            1002 EJTT     DC    CL8'XXXXXXXX'          PUT TASK TIME HERE                                    
 0025A6 40E2E4D7C5D97A40            1003          DC    CL8' SUPER: '          SUPERVISOR TIME                                       
 0025AE E7E7E7E7E7E7E7E7            1004 EJST     DC    CL8'XXXXXXXX'          SUPERVISOR TIME HERE                                  
 0025B6 40E3C3C2E3E6C1C9            1005          DC    CL10' TCBTWAIT='       I/O WAIT TIME MESSAGE                                 
 0025C0 E7E7E7E7E7E7E7E7            1006 EJIOW    DC    8C'X'                  INITIAL I/O WAIT TIME VALUE                           
 0025C8 40E3C3C2C9D6C3D5            1007          DC    CL10' TCBIOCNT='       I/O COUNT MESSAGE                                     
 0025D2 E8E8E8E8E8E8E8E8            1008 EJIOCNT  DC    8C'Y'                  INITIAL I/O COUNT VALUE                               
 0025DA 4040404040                  1009          DC    5C' '                  BLANKS FOR PADDING                                    
                                    1010 *                                                                                           
 0025DF E4D5C3C8                    1011 UNCH     DC    CL4'UNCH'              UNCH MESSAGE FOR TCB                                  
 0025E4                             1012          DC    0F'0'                  Align on a fullword                                   
 0025E4 7FC4C9E2                    1013 MECBINIT DC    X'7F',C'DIS'           STUFF FOR RESETTING POST CODE                         
                                    1014 *                                                                                           
 002600                             1015          ORG   FIRST4K+((*-FIRST4K+31)/32*32)      NICE ALIGNMENT                           
 002600 E3D6E3C1D340C4C9            1016          DC    CL28'TOTAL DISPATCH COUNT AT LEFT'  DCOUNT MESSG                             
 00261C 00000000                    1017 DCOUNT   DC    F'0'                   START COUNT AT ZERO                                   
 002620 0000003C                    1018 DMAX     DC    F'60'                  For turning off trace                                 
                                    1019 *                                                                                           
                                    1020 ************************************                                                        
                                    1021 * CVT - COMMUNICATION VECTOR TABLE                                                          
                                    1022 ************************************                                                        
                                    1023 *                                                                                           
 002800                             1024          ORG   FIRST4K+X'2800'        MOVE TO LOCATION FOR THE CVT                          
 002800 0000000000000000            1025 MYCVT    DC    96X'0'                 SET UP THE CVT                                        
 002800                             1026          ORG   MYCVT                  GO BACK AND DEFINE FIELDS                             
 002800 00000518                    1027          DC    A(TCBWORDS)            CVTTCBP                                               
 002804 00002000                    1028          DC    A(SVCTABLE)            CVTSVCTA                                              
 002808 00000000                    1029          DC    A(0)                   CVTHEAD                                               
 00280C 00000800                    1030          DC    A(STRTUCB)             CVTUCBS (address of UCBs)                             
 002818                             1031          ORG   MYCVT+(CVTC100H-CVT)   LOCATION FOR CVTC100H                                 
 002818 000100E0                    1032          DC    A(CB100HDR)            HEADER ADDRESS CB100s (CVT100H)                       
 00281C 00002400                    1033          DC    A(DISPATCH)            (CVT0DS) ADDRESS OF DISPATCHER                        
 002820 0001269A                    1034          DC    A(BEGINIO)             ADDRESS OF BEGINIO ROUTINE                            
 002824 00012690                    1035          DC    A(CHAP)                ADDRESS OF CHANGE PRIORITY                            
 002830                             1036          ORG   MYCVT+(CVTBRABN-CVT)   Go to location for CVTBRABN                           
 002830 00004000                    1037          DC    A(BRABEND)             Addr Branch ABEND Routine                             
 002838                             1038          ORG   MYCVT+(CVTRQENQ-CVT)   Go to location for CVTRQENQ                           
 002838 000125B0                    1039          DC    A(RQEENQ)              address RQE enqueing routine                          
 002840                             1040          ORG   MYCVT+(CVTMSECB-CVT)   LOCATION FOR CVTMSECB                                 
 002840 00012544                    1041          DC    A(LOCMECB)             ADDRESS FOR MSECB                                     
 00284C                             1042          ORG   MYCVT+(CVTMSDAT-CVT)   LOCATION FOR CVTMSDAT                                 
1       START OF FIRST 4K                                                                                       PAGE   14            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 00284C 00012540                    1043          DC    A(MYMSDA)              ADDRESS FOR MYMSDA                                    
 002850 0A03                        1044          SVC   3                      SVC 3                                                 
 002852 07FE                        1045          BCR   15,14                  CVTBRET                                               
 002854 000040CC                    1046          DC    A(NONTYP1)             CVTSSVRB For scheduling SVRB                          
 00285C                             1047          ORG   MYCVT+(CVTIDENT-CVT)   LOCATION FOR IDENT                                    
 00285C C3E5E340                    1048          DC    CL4'CVT '              INSERT THE CVT IDENT                                  
 002860                             1049          ORG   ,                      MOVE ON                                               
1       IPL ROUTINE DOC                                                                                         PAGE   15            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1051 *                                                                                           
                                    1052 **********************************************************************                      
                                    1053 * IPLPGM                                                                                    
                                    1054 *                                                                                           
                                    1055 * INPUT:  NONE                                                                              
                                    1056 *                                                                                           
                                    1057 * OUTPUT: A MESSAGE THAT STATES THE VALUE SAVED FOR CVTMZ00                                 
                                    1058 *                                                                                           
                                    1059 * ENTRY CONDITONS: None                                                                     
                                    1060 *                                                                                           
                                    1061 * EXIT CONDITIONS: System setup as described in IPL handout                                 
                                    1062 *                                                                                           
                                    1063 * REGISTER USAGE:                                                                           
                                    1064 *                                                                                           
                                    1065 *    R0 -  ADDRESS OF LOWEST STORAGE AREA IN MEMORY (FOR TRACING)                           
                                    1066 *    R1 -  HIGHEST ADDRESS IN THE ASSEMBLY (FOR TRACING)                                    
                                    1067 *          ALSO USED BY LOUNTR                                                              
                                    1068 *    R2 -  ASSISTV TRACE TYPE CODES                                                         
                                    1069 *    R3 -  CVT ADDRESSABILITY                                                               
                                    1070 *    R6 -  USED IN PERFORMING LOGICAL COMPARISONS                                           
                                    1071 *          (FOR THE SOC5 AND THE ADDRESS OF SOC5 INSTRUCTION)                               
                                    1072 *    R7 -  HOLDS STORAGE KEY OF ZERO                                                        
                                    1073 *    R8 -  HOLD ADDRESS TO SET STORAGE KEY VALUE                                            
                                    1074 *    R12 - USED FOR IPLPGM ADDRESSABILITY                                                   
                                    1075 *                                                                                           
                                    1076 * LOGIC:                                                                                    
                                    1077 *                                                                                           
                                    1078 * 1) Set up addressability based upon R12                                                   
                                    1079 * 2) Set the clock to X'50' to the value X'7FFFFFF'                                         
                                    1080 * 3) Turn on the Assist-V Trace Facility                                                    
                                    1081 * 4) 4.1) Set all of the 2K blocks of memory with a protection byte of                      
                                    1082 *         X'00'                                                                             
                                    1083 *    4.2) Check that a SOC5 caused the program check interrupt                              
                                    1084 *    4.3) Make sure address of instruction causing SOC5 is in                               
                                    1085 *         old program check PSW                                                             
                                    1086 *    4.4) Print the value of CVTMZ00                                                        
                                    1087 *                                                                                           
                                    1088 **********************************************************************                      
1       IPL ROUTINE CODE                                                                                        PAGE   16            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 003000                             1090          ORG   FIRST4K+X'3000'        MOVE TO THE IPL ROUTINE                               
                                    1091 *                                                                                           
                                    1092 * 1. Set up Addressability based on R12                                                     
                                    1093 *                                                                                           
 003000 05C0                        1094 IPLPGM   BALR  12,0                   Put ani into R12                                      
 003002 06C0                        1095          BCTR  12,0                   Decrement R12 by 1                                    
 003004 06C0                        1096          BCTR  12,0                   Decrement again                                       
 003000                             1097          USING IPLPGM,12              Now R12 points to start of IPLPGM                     
                                    1098 *                                                                                           
                                    1099 * 2. Set the Clock (X'50') to X'7FFFFFF'                                                    
                                    1100 *                                                                                           
 003006 D203 0050 C224 00050 03224  1101          MVC   CLOCK(4),TIMEVAL       set value for clock                                   
                                    1102 *                                                                                           
                                    1103 * 3. Turn on the Assist-V Trace Facility                                                    
                                    1104 *                                                                                           
 00300C 9802 C218            03218  1105          LM    0,2,R0R1R2             load regs to set trace                                
 003010 0103                        1106          XOPC  3                      turn on trace                                         
                                    1107 *                                                                                           
                                    1108 * 4. Set all of the 2K blocks of memory with a                                              
                                    1109 *    protection byte of X'00'                                                               
                                    1110 *                                                                                           
 003012 1777                        1111          XR    7,7                    R7 will be R1, ZERO IT                                
 003014 1788                        1112          XR    8,8                    R8 will be R2, ZERO IT                                
 003016 0878                        1113 LOOP     SSK   7,8                    Set Storage Key to 0                                  
 003018 0104                        1114 POINTHER XOPC  4                      Turn off trace after 1st SSK                          
 00301A 4180 8800            00800  1115          LA    8,X'800'(,8)           increment RB b 2K                                     
 00301E 47F0 C016            03016  1116          B     LOOP                   continue infinite loop                                
 003022 0102                        1117 AFTERLOP XOPC  2                      Turn trace back on                                    
 003024 D202 006D C229 0006D 03229  1118          MVC   NPSWPC+5(3),REALPC+1   put @(PCFLIH) into PC New PSW                         
                                    1119 *                                                                                           
                                    1120 * Check that it was a SOC5 that caused the Program Check                                    
                                    1121 *                                                                                           
 00302A 9505 002B      0002B        1122          CLI   OPSWPC+3,5             See if int code was 5 (FOR SOC5)                      
 00302E 4770 C212            03212  1123          BNE   IPL0119                If not, stop                                          
                                    1124 *                                                                                           
                                    1125 * Test if @(POINTHER) in old PC PSW                                                         
                                    1126 *                                                                                           
 003032 4160 C018            03018  1127          LA    6,POINTHER             Get @POINTHER                                         
 003036 BD67 002D            0002D  1128          CLM   6,7,OPSWPC+5           If inst. addr in PSW POINTHER                         
 00303A 4770 C212            03212  1129          BNE   IPL0119                No, then stop                                         
                                    1130 *                                                                                           
 00303E 5830 004C            0004C  1131          L     3,76                   Get @CVT                                              
 000000                             1132          USING CVT,3                  CVT addressability                                    
 003042 0680                        1133          BCTR  8,0                    Decrease HIGHEST by 1                                 
 003044 5080 3058            00058  1134          ST    8,CVTMZ00              Save HIGHEST address                                  
                                    1135 *                                                                                           
                                    1136 * Print the value of CVTMZ00                                                                
                                    1137 *                                                                                           
 003048 D203 C05E 3058 0305E 00058  1138          MVC   LSTOR+12(4),CVTMZ00    Put CVTMZ00 into LOUNTR stor                          
 00304E 4510 07E0            007E0  1139          BAL   1,LOUNTR               LOUNTR translates CVTMZ00                             
 003052 D340404040404040            1140 LSTOR    DC    CL16'L'                Storage for LOUNTR                                    
 003062 D207 C238 C052 03238 03052  1141          MVC   OUTVAL(8),LSTOR        Put value in print line                               
 003068 E020 C22C 0014 0322C        1142          XPRNT MESSAGEO,20            print value of CVTMZ00                                
                                    1143 *                                                                                           
                                    1144 * 5) Chain the 15 CB100 blocks and establish the CB100 header                               
                                    1145 *                                                                                           
 00306E 58A0 C240            03240  1146          L 10,ADCBPOOL                GET ADDRESS OF POOL                                   
1       IPL ROUTINE CODE                                                                                        PAGE   17            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 003072 4100 001F            0001F  1147          LA 0,CB100#                  GET # OF CB100S                                       
                                    1148 CBATIPL  FRECB100                                                                           
                                    1149+*        FRECB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 003076 58B0 3018            00018  1150+CBATIPL  L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 00307A D203 A000 B000 00000 00000  1151+         MVC   0(4,10),0(11)           Add. next CB into freeing CB.                        
 003080 50AB 0000            00000  1152+         ST    10,0(11)           Point header to just freed CB.                            
 003084 41AA 0100            00100  1153          LA 10,CB100LTH(10)           MOVE TO THE NEXT                                      
 003088 4600 C076            03076  1154          BCT 0,CBATIPL                DECREMENT # OF BLOCKS AND LOOP                        
                                    1155 *                                                                                           
                                    1156 * 6) Get CBs and chain them                                                                 
                                    1157 *                                                                                           
                                    1158 * GET TCB FOR MS/NMI                                                                        
                                    1159 *                                                                                           
                                    1160          GETCB100                                                                           
                                    1161+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 00308C 58B0 3018            00018  1162+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 003090 58AB 0000            00000  1163+         L     10,0(11)           Load Address of next CB.                                  
 003094 12AA                        1164+         LTR   10,10              Make sure a CB is available.                              
 003096 4770 C0B0            030B0  1165+         BNZ   GTCB0005           To MVC if there is a CB.                                  
 00309A 0119                        1166+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 00309C C3C2F1F0F040D7D6            1167+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 0030B0 D203 B000 A000 00000 00000  1168+GTCB0005    MVC 0(4,11),0(10)           Update header.                                      
 0030B6 187A                        1169          LR    7,10                   PUT @ NMS TCB IN 7                                    
 0030B8 5070 3008            00008  1170          ST    7,CVTHEAD              SAVE @ NMS TCB INTO CVTHEAD                           
 000000                             1171          USING TCB,7                  SET UP TCB ADDRESSABILITY                             
 0030BC D7FF 7000 7000 00000 00000  1172          XC    TCB(CB100LTH),TCB      CLEAR CB CONTENTS                                     
 0030C2 D207 7008 C244 00008 03244  1173          MVC   TCBTNAME(8),TCBTNVAL   SET TCBTNAME EXCEPT FOR 'n'                           
 0030C8 92D4 700B      0000B        1174          MVI   TCBTNAME+3,C'M'        BECAUSE THIS IS THE MS/NMI TCB                        
 0030CC D203 702C C24C 0002C 0324C  1175          MVC   TCBIDENT(4),IDENTVAL   SET TCBIDENT                                          
 0030D2 D207 7030 C250 00030 03250  1176          MVC   TCBGRS(8),GRSVAL       SET UP TCBGRS INIT VALUE                              
 0030D8 D237 7038 7030 00038 00030  1177          MVC   TCBGRS+8(56),TCBGRS    REPEAT VALUE                                          
 0030DE D203 7080 C214 00080 03214  1178          MVC   TCBAPIE(4),NIPPIE      Set A(NIPMSPIE) in NIPMS TCB                          
                                    1179 *                                                                                           
                                    1180 * GET RB FOR MS/NMI                                                                         
                                    1181 *                                                                                           
                                    1182          GETCB100                                                                           
                                    1183+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0030E4 58B0 3018            00018  1184+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0030E8 58AB 0000            00000  1185+         L     10,0(11)           Load Address of next CB.                                  
 0030EC 12AA                        1186+         LTR   10,10              Make sure a CB is available.                              
 0030EE 4770 C108            03108  1187+         BNZ   GTCB0006           To MVC if there is a CB.                                  
 0030F2 0119                        1188+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 0030F4 C3C2F1F0F040D7D6            1189+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 003108 D203 B000 A000 00000 00000  1190+GTCB0006    MVC 0(4,11),0(10)           Update header.                                      
                                    1191 * Pause - set the TCBRB field for the MS TCB                                                
 00310E 50A0 7000            00000  1192          ST    10,TCBRB               Set the TCBRB field                                   
 003112 188A                        1193          LR    8,10                   GET @(MS/NMI) RB INTO R8                              
 000000                             1194          USING RB,8                   NOW WORK WITH THE RB                                  
 003114 D7FF 8000 8000 00000 00000  1195          XC    RB(CB100LTH),RB        CLEAR THE RB                                          
 00311A D203 8000 C260 00000 03260  1196          MVC   RBTYPE(4),RBTYPVAL     SET RBTYPE                                            
 003120 5070 8004            00004  1197          ST    7,RBTCB                POINT RBTCB AT TCB FOR MS/NMI                         
 003124 9680 800B      0000B        1198          OI    RBFLGS3,X'80'          SET BIT 0 TO 1 FOR A PRB                              
 003128 D207 8010 C274 00010 03274  1199          MVC   RBOPSW(8),RB0PSW1      PSW FOR NIP/MS RB                                     
 00312E D207 8020 C264 00020 03264  1200          MVC   RBGRSAVE(8),RBGRSAV    SET RBGRSAVE TO INIT VALUE                            
 003134 D237 8028 8020 00028 00020  1201          MVC   RBGRSAVE+8(56),RBGRSAVE REPEAT THIS VALUE                                    
 00313A D207 8060 C26C 00060 0326C  1202          MVC   RBFRSAVE(8),RBFRSAV    SET RBFRSAVE TO INIT VALUE                            
 003140 D217 8068 8060 00068 00060  1203          MVC   RBFRSAVE+8(24),RBFRSAVE REPEAT THE VALUE                                     
1       IPL ROUTINE CODE                                                                                        PAGE   18            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 003146 BE77 801D            0001D  1204          STCM  7,7,RBLINK+1           SET RBLINK FIELD TCB                                  
 00314A                             1205          DROP  8                      Done with this RB for now                             
                                    1206 *                                                                                           
                                    1207 * GET TCB FOR WAIT                                                                          
                                    1208 *                                                                                           
                                    1209          GETCB100                                                                           
                                    1210+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 00314A 58B0 3018            00018  1211+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 00314E 58AB 0000            00000  1212+         L     10,0(11)           Load Address of next CB.                                  
 003152 12AA                        1213+         LTR   10,10              Make sure a CB is available.                              
 003154 4770 C16E            0316E  1214+         BNZ   GTCB0007           To MVC if there is a CB.                                  
 003158 0119                        1215+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 00315A C3C2F1F0F040D7D6            1216+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 00316E D203 B000 A000 00000 00000  1217+GTCB0007    MVC 0(4,11),0(10)           Update header.                                      
 003174 189A                        1218          LR    9,10                   GET @ WAIT TCB INTO R9                                
                                    1219 * Hold it! Update the "Next" field of the NMS TCB                                           
 003176 5090 7074            00074  1220          ST    9,TCBTCB               SAVE @ WAIT TCB IN NMS TCB                            
 00317A                             1221          DROP  7                      Done with NMS TCB                                     
                                    1222 * -Back to setting up the Wait TCB-                                                         
 000000                             1223          USING TCB,9                  SET UP ADDR TO WAIT TCB                               
 00317A D7FF 9000 9000 00000 00000  1224          XC    TCB(CB100LTH),TCB      CLEAR CB CONTENTS                                     
 003180 D207 9008 C244 00008 03244  1225          MVC   TCBTNAME(8),TCBTNVAL   SET TCBTNAME EXCEPT FOR 'n'                           
 003186 92E6 900B      0000B        1226          MVI   TCBTNAME+3,C'W'        BECAUSE THIS IS THE WAIT TCB                          
 00318A D203 902C C24C 0002C 0324C  1227          MVC   TCBIDENT(4),IDENTVAL   SET TCBIDENT                                          
 003190 D207 9030 C250 00030 03250  1228          MVC   TCBGRS(8),GRSVAL       SET UP TCBGRS INIT                                    
 003196 D237 9038 9030 00038 00030  1229          MVC   TCBGRS+8(56),TCBGRS    REPEAT VALUE                                          
 00319C 5070 90DC            000DC  1230          ST    7,TCBBACK              SET TCB BACKWARD PTR TO MS/NMI                        
                                    1231 *                                                                                           
                                    1232 * GET RB FOR WAIT                                                                           
                                    1233 *                                                                                           
                                    1234          GETCB100                                                                           
                                    1235+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0031A0 58B0 3018            00018  1236+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0031A4 58AB 0000            00000  1237+         L     10,0(11)           Load Address of next CB.                                  
 0031A8 12AA                        1238+         LTR   10,10              Make sure a CB is available.                              
 0031AA 4770 C1C4            031C4  1239+         BNZ   GTCB0008           To MVC if there is a CB.                                  
 0031AE 0119                        1240+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 0031B0 C3C2F1F0F040D7D6            1241+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 0031C4 D203 B000 A000 00000 00000  1242+GTCB0008    MVC 0(4,11),0(10)           Update header.                                      
 000000                             1243          USING RB,10                  SET UP WAIT RB ADDRESSABILITY                         
                                    1244 *                                                                                           
                                    1245 * Pause - Set TCBRB in the WaitTCB                                                          
                                    1246 *                                                                                           
 0031CA 50A0 9000            00000  1247          ST    10,TCBRB               Set TCB pointer in Wait TCB                           
 0031CE                             1248          DROP  9                      Done with Wait TCB                                    
 0031CE D7FF A000 A000 00000 00000  1249          XC    RB(CB100LTH),RB        CLEAR CB CONTENTS                                     
 0031D4 D203 A000 C260 00000 03260  1250          MVC   RBTYPE(4),RBTYPVAL     SET RBTYPE                                            
 0031DA 5090 A004            00004  1251          ST    9,RBTCB                POINT RBTCB AT TCB FOR WAIT                           
 0031DE 9680 A00B      0000B        1252          OI    RBFLGS3,X'80'          SET BIT 0 TO 1 FOR A PRB                              
 0031E2 D207 A010 C27C 00010 0327C  1253          MVC   RBOPSW(8),RB0PSW2      PSW FOR WAIT                                          
 0031E8 D207 A020 C264 00020 03264  1254          MVC   RBGRSAVE(8),RBGRSAV    SET RBGRSAVE TO INIT VALUE                            
 0031EE D237 A028 A020 00028 00020  1255          MVC   RBGRSAVE+8(56),RBGRSAVE REPEAT THIS VALUE                                    
 0031F4 D207 A060 C26C 00060 0326C  1256          MVC   RBFRSAVE(8),RBFRSAV    SET RBFRSAVE TO INIT VALUE                            
 0031FA D217 A068 A060 00068 00060  1257          MVC   RBFRSAVE+8(24),RBFRSAVE REPEAT THE VALUE                                     
 003200 BE97 A01D            0001D  1258          STCM  9,7,RBLINK+1           SET RBLINK FIELD TO TCB                               
 003204                             1259          DROP  10                     DONE WITH WAIT RB                                     
                                    1260 *                                                                                           
1       IPL ROUTINE CODE                                                                                        PAGE   19            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1261 * 7) Load address of dispatcher and branch to it                                            
                                    1262 *                                                                                           
 003204 92E2 00BE      000BE        1263          MVI   LEVELFLG,C'S'          LEVELFLG TO 'S' FOR SYSTEM                            
 003208 92F0 00BF      000BF        1264          MVI   TYP1FLAG,C'0'          TYP1FLAG TO 0                                         
 00320C 58C0 301C            0001C  1265          L     12,CVT0DS              GET DISPATCHER ADDRESS                                
 003210 07FC                        1266          BR    12                     BRANCH TO THE DISPATCHER                              
 003212                             1267          DROP  3                      Done with the CVT                                     
                                    1268 *                                                                                           
 003212 0119                        1269 IPL0119  XOPC  25                     Die if anything goes wrong                            
1       IPL ROUTINE STORAGE AREA                                                                                PAGE   20            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1271 *                                                                                           
                                    1272 **********************************************************************                      
                                    1273 * IPL PROGRAM STORAGE AREA                                                                  
                                    1274 **********************************************************************                      
                                    1275 *                                                                                           
 003214 00012384                    1276 NIPPIE   DC    A(NIPMSPIE)            A(PIE) for NIP/MS                                     
 003218 00000000                    1277 R0R1R2   DC    F'0'                   SET 'LOWEST' AREA TRACED ZERO                         
 00321C 00020000                    1278          DC    A(HIGHEST)             SET 'HIGHEST' AREA TRACED 'TOP'                       
 003220 00E08040                    1279          DC    XL4'00E08040'          TRACE CH. 0-1-2, SWAPS, PRIVOPS                       
 003224 7FFFFFFF                    1280 TIMEVAL  DC    X'7FFFFFFF'            VALUE FOR SETTING THE CLOCK                           
 003228 00004154                    1281 REALPC   DC    A(PCFLIH)              ACTUAL ADDRESS OF PC FLIH                             
                                    1282 *                                                                                           
 00322C 40                          1283 MESSAGEO DC    C' '                   CC FOR MESSAGEO                                       
 00322D C3E5E3D4E9F0F040            1284          DC    CL11'CVTMZ00 is '      FIRST PART OF MESSAGE                                 
 003238 4040404040404040            1285 OUTVAL   DC    CL8' '                 CVTMZ00 VALUE ON PRINT LINE                           
 003240 00010100                    1286 ADCBPOOL DC    A(CB100POL)            ADDRESS OF THE CB100 BLOCK POOL                       
 003244 E3C3C29540C2C4E3            1287 TCBTNVAL DC    CL8'TCBn BDT'          For initializing TCBTNAME                             
 00324C E3C3C240                    1288 IDENTVAL DC    CL4'TCB '              For setting up TCBIDENT                               
 003250 E3C3C2C7D9E24040            1289 GRSVAL   DC    CL8'TCBGRS'            For setting up TCBGRS                                 
 003258 E3C3C2C6D9E24040            1290 FRSVAL   DC    CL8'TCBFRS'            For setting up TCBFRS                                 
 003260 40D7D9C2                    1291 RBTYPVAL DC    CL4' PRB'              USED TO SET UP RBTYPE                                 
 003264 D9C2C7D9E2C1E5C5            1292 RBGRSAV  DC    CL8'RBGRSAVE'          USED TO SET UP RBGRSAVE                               
 00326C D9C2C6D9E2C1E5C5            1293 RBFRSAV  DC    CL8'RBFRSAVE'          USED TO SET UP RBFRSAVE                               
                                    1294 *                                                                                           
 003274 FF0401190F012000            1295 RB0PSW1  DC    X'FF0401190F',AL3(NIPMS)    PSW FOR NIP/MS RB                                
 00327C FFE601190F0000BC            1296 RB0PSW2  DC    X'FFE601190F',AL3(LEVELABN) PSW FOR WAIT RB                                  
1       BRABEND AND FLIHS                                                                                       PAGE   21            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 004000                             1298          ORG   FIRST4K+X'4000'        GO TO PLACE FOR FLIHs                                 
                                    1299 ************************************************************                                
                                    1300 * BRABEND routine                                                                           
                                    1301 * On Entry: R3 = A(CVT)                                                                     
                                    1302 ************************************************************                                
 000000                             1303          USING CVT,3                  CVT addr                                              
 004000 5860 3004            00004  1304 BRABEND  L     6,CVTSVCTA             Get @ of SVCTABLE                                     
 004004 5860 6068            00068  1305          L     6,13*8(,6)             Get @ of SVC13                                        
 004008 58F0 3054            00054  1306          L     15,CVTSSVRB            @ of 'Type other' code SVCFLIH                        
 00400C 1266                        1307          LTR   6,6                    Check if address is null                              
 00400E 077F                        1308          BNZR  15                     If ok, Go into Type Other Code                        
 004010 0119                        1309          XOPC  25                     Otherwise meet a painful death                        
 004012                             1310          DROP  3                      Done with CVT                                         
                                    1311 *                                                                                           
 004012 0119                        1312 EXFLIH   DC    X'0119'                EXTERNAL FLIH                                         
                                    1313 *                                                                                           
                                    1314 ********************************************************************                        
                                    1315 * SVC FIRST LEVEL INTERRUPT HANDLER                                                         
                                    1316 *                                                                                           
                                    1317 * LOGIC:                                                                                    
                                    1318 * 1)  SAVE ALL GPRS IN SVCSAVE                                                              
                                    1319 * 2)  ESTABLISH CVT ADDRESSABILITY                                                          
                                    1320 * 3)  ESTABLISH TCB ADDRESSABILITY                                                          
                                    1321 * 4)  MOVE ALL GPRS TO THE TCB                                                              
                                    1322 * 5)  SAVE ALL FPRS INTO THE TCB                                                            
                                    1323 * 6)  GET RB ADDRESS FROM TCB INTO R5                                                       
                                    1324 * 7)  VERIFY RB ADDRESS NOT ZERO                                                            
                                    1325 * 8)  COPY OLD PSW TO INTO THE RB                                                           
                                    1326 * 9)  <PERFORM SVC INT. FUNCTIONS> - SEE BELOW                                              
                                    1327 * 10) BRANCH TO DISPATCHER W/ R3 STILL VALID                                                
                                    1328 *                                                                                           
                                    1329 * STEP 9 IN DETAIL:                                                                         
                                    1330 *                                                                                           
                                    1331 * A) GET THE INTERRUPT CODE FROM THE OLDPSW                                                 
                                    1332 * B) MAKE SURE CODE IS IN RANGE OF SVCTABLE                                                 
                                    1333 * C) IF SVC IS TYPE 1 THEN                                                                  
                                    1334 * D)    TEST AND SET FLAG TO INDICATE 'TYPE 1'                                              
                                    1335 * E)    GO TO SVC ROUTINE                                                                   
                                    1336 * F)    TEST AND RESET FLAG TO INDICATE NOT TYPE 1                                          
                                    1337 * E)    STORE REGS 0,1,15 IN TCBGRS AREA                                                    
                                    1338 * F) ENDIF                                                                                  
                                    1339 *                                                                                           
                                    1340 * REGISTER USAGE:                                                                           
                                    1341 *                                                                                           
                                    1342 * R0,R1,R13,R15 - Used by SVC, shouldn't be altered                                         
                                    1343 * R3 - CVT ADDRESSABILITY                                                                   
                                    1344 * R4 - TCB ADDRESSABILITY                                                                   
                                    1345 * R5 - RB ADDRESSABILITY                                                                    
                                    1346 * R6 - A(SVC ROUTINE TO CALL)                                                               
                                    1347 * R7 - INTERRUPT CODE FROM OLD PSW                                                          
                                    1348 * R8 -  USED IN CALCULATING TCBTCPUP and TCBTCPUS                                           
                                    1349 *       A(SVCTABLE)                                                                         
                                    1350 * R12 - SVCFLIH ADDRESSABILITY                                                              
                                    1351 * R14 - RETURN ADDRESS FROM SVC ROUTINE                                                     
                                    1352 *                                                                                           
                                    1353 *********************************************************************                       
1       SVCFLIH CODE                                                                                            PAGE   22            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1355 *                                                                                           
                                    1356 * Move clock to a lowcore location                                                          
                                    1357 *                                                                                           
 004014 D203 00B0 0050 000B0 00050  1358 SVCFLIH  MVC   LOWTIME(4),CLOCK       GET VALUE OF CLOCK INTO LOWTIME                       
 00401A 95E3 00BE      000BE        1359          CLI   LEVELFLG,C'T'          CHECK IF IN TASK STATE                                
 00401E 4770 00BC            000BC  1360          BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP                         
 004022 92E2 00BE      000BE        1361          MVI   LEVELFLG,C'S'          OTHERWISE SWITCH TO SYSTEM STATE                      
                                    1362 *                                                                                           
                                    1363 * Save all GPRs in SVCSAVE                                                                  
                                    1364 *                                                                                           
 004026 900F 0100            00100  1365          STM   0,15,SVCSAVE           SAVE GPRS IN PROPER SAVE AREA                         
                                    1366 *                                                                                           
                                    1367 * Establish CVT addressability                                                              
                                    1368 *                                                                                           
 00402A 5830 004C            0004C  1369          L     3,76                   GET @ OF THE CVT                                      
 000000                             1370          USING CVT,3                  ESTABLISH CVT ADDRESSABILITY                          
                                    1371 *                                                                                           
                                    1372 * Establish TCB addressability                                                              
                                    1373 *                                                                                           
 00402E 5840 051C            0051C  1374          L     4,TCBWORDS+4           GET @ CURRENTLY DISPATCHED TCB                        
 000000                             1375          USING TCB,4                  ESTABLISH TCB ADDRESSABILITY                          
                                    1376 *                                                                                           
                                    1377 * MOVE ALL GPRS TO THE TCB                                                                  
                                    1378 *                                                                                           
 004032 D23F 4030 0100 00030 00100  1379          MVC   TCBGRS(16*4),SVCSAVE   MOVE GPRS INTO THE TCB                                
                                    1380 *                                                                                           
                                    1381 * SAVE ALL FPRS INTO THE TCB                                                                
                                    1382 *                                                                                           
 004038 6000 40E0            000E0  1383          STD   0,TCBFRS               STORE FPR 0                                           
 00403C 6020 40E8            000E8  1384          STD   2,TCBFRS+8             STORE FPR 2                                           
 004040 6040 40F0            000F0  1385          STD   4,TCBFRS+16            STORE FPR 4                                           
 004044 6060 40F8            000F8  1386          STD   6,TCBFRS+24            STORE FPR 6                                           
                                    1387 *                                                                                           
                                    1388 * Establish Routine Addressability so we can access                                         
                                    1389 * SVCF0119                                                                                  
                                    1390 *                                                                                           
 004048 05C0                        1391          BALR  12,0                   GET ADDRESS NEXT INSTRUCTION                          
 00404A                             1392          USING *,12                   ESTABLISH SVCFLIH ADDRESSABILITY                      
                                    1393 *                                                                                           
                                    1394 * Establish RB addressability                                                               
                                    1395 *                                                                                           
 00404A 5850 4000            00000  1396          L     5,TCBRB                GET @ OF CURRENTLY DISPATCHED RB                      
 000000                             1397          USING RB,5                   ESTABLISH RB ADDRESSABILITY                           
                                    1398 *                                                                                           
                                    1399 * Verify RB address not null                                                                
                                    1400 *                                                                                           
 00404E 1255                        1401          LTR   5,5                    TEST R5                                               
 004050 4780 C0FA            04144  1402          BZ    SVCF0119               IF IT IS, DIE!!!                                      
                                    1403 *                                                                                           
                                    1404 * COPY OLD PSW TO INTO THE RB                                                               
                                    1405 *                                                                                           
 004054 D207 5010 0020 00010 00020  1406          MVC   RBOPSW(8),OPSWSVC      MOVE OLD PSW INTO THE RB                              
                                    1407 *                                                                                           
                                    1408 * Calculate accumulated task time                                                           
                                    1409 *                                                                                           
 00405A 5880 40A0            000A0  1410          L     8,TCBTDISP             GET TIME OF DISPATCH                                  
 00405E 5B80 00B0            000B0  1411          S     8,LOWTIME              SUBTRACT THE CURRENT TIME                             
1       SVCFLIH CODE                                                                                            PAGE   23            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1412 *                                                                                           
                                    1413 * Test to see if PSW was in supervisor or problem state                                     
                                    1414 *                                                                                           
 004062 9101 0021      00021        1415          TM    OPSWSVC+1,X'01'        Check if PSW in SV State                              
 004066 4780 C02C            04076  1416          BZ    SVTIME                 If in SV state, ad SV time                            
 00406A 5A80 40AC            000AC  1417          A     8,TCBTCPUP             ADD ACCUMULATED TASK CPU                              
 00406E 5080 40AC            000AC  1418          ST    8,TCBTCPUP             SAVE ACCUMULATED TASK TIME                            
 004072 47F0 C034            0407E  1419          B     STEP9A                 Move on to STEP9A                                     
 004076 5A80 40B0            000B0  1420 SVTIME   A     8,TCBTCPUS             Add accum. SV TIME                                    
 00407A 5080 40B0            000B0  1421          ST    8,TCBTCPUS             Update the SV TIME in TCB                             
                                    1422 *                                                                                           
                                    1423 * <PERFORM SVC INTERRUPT FUNCTIONS>                                                         
                                    1424 *                                                                                           
                                    1425 * A) GET THE INTERRUPT CODE FROM THE OLDPSW                                                 
                                    1426 *                                                                                           
 00407E 950F 0023      00023        1427 STEP9A   CLI   OPSWSVC+3,X'0F'        Check interrupt code ? 15                             
 004082 4720 C0FA            04144  1428          BH    SVCF0119               If > 15, die                                          
 004086 4870 0022            00022  1429          LH    7,OPSWSVC+2            GET INTERRUPT CODE INTO R7                            
                                    1430 *                                                                                           
                                    1431 * B) MAKE SURE CODE IS IN RANGE OF SVCTABLE                                                 
                                    1432 *                                                                                           
 00408A 8970 0003            00003  1433          SLL   7,3                    MULTIPLY INT CODE * DISPLACEMENT                      
 00408E 5A70 3004            00004  1434          A     7,CVTSVCTA             Add displacement to start                             
 004092 5860 7000            00000  1435          L     6,0(,7)                GET @ OF SVC ROUTINE                                  
 004096 1266                        1436          LTR   6,6                    Check if address null                                 
 004098 4780 C0FA            04144  1437          BZ    SVCF0119               IF IT'S ZERO, DIE                                     
                                    1438 *                                                                                           
                                    1439 * IF SVC IS TYPE 1 THEN                                                                     
                                    1440 *                                                                                           
 00409C 91C0 7004      00004        1441          TM    4(7),X'C0'             if this is a Type 1 SVC                               
 0040A0 4770 C082            040CC  1442          BNZ   NONTYP1                if not type 1, do differently                         
                                    1443 *                                                                                           
                                    1444 * TEST AND SET FLAG TO INDICATE 'TYPE 1'                                                    
                                    1445 *                                                                                           
 0040A4 95F0 00BF      000BF        1446          CLI   TYP1FLAG,C'0'          CHECK THE TYPE 1 FLAG                                 
 0040A8 4770 C0FA            04144  1447          BNE   SVCF0119               IF IT'S NOT C'0', DUMP                                
 0040AC 92F1 00BF      000BF        1448          MVI   TYP1FLAG,C'1'          SET THE TYPE 1 FLAG TO '1'                            
                                    1449 *                                                                                           
                                    1450 * GO TO SVC ROUTINE                                                                         
                                    1451 *                                                                                           
 0040B0 05E6                        1452          BALR  14,6                   GO TO THE SVC ROUTINE                                 
                                    1453 *                                                                                           
                                    1454 * TEST AND RESET FLAG TO INDICATE NOT TYPE 1                                                
                                    1455 *                                                                                           
 0040B2 95F1 00BF      000BF        1456          CLI   TYP1FLAG,C'1'          CHECK THE TYPE 1 FLAG                                 
 0040B6 4770 C0FA            04144  1457          BNE   SVCF0119               IF IT'S NOT '1', DUMP                                 
 0040BA 92F0 00BF      000BF        1458          MVI   TYP1FLAG,C'0'          SET IT TO '0'                                         
                                    1459 *                                                                                           
                                    1460 * STORE REGS 0,1,15 IN TCBGRS AREA                                                          
                                    1461 *                                                                                           
 0040BE 9001 4030            00030  1462          STM   0,1,TCBGRS             SAVE R0 AND R1 IN TCBGRS                              
 0040C2 50F0 406C            0006C  1463          ST    15,TCBGRS+15*4         SAVE R15 IN TCBGRS                                    
                                    1464 *                                                                                           
                                    1465 * Branch back to the Dispatcher                                                             
                                    1466 *                                                                                           
 0040C6 58C0 301C            0001C  1467          L     12,CVT0DS              Get @ of the Dispatcher                               
 0040CA 07FC                        1468          BR    12                     Branch back to it                                     
1       SVCFLIH CODE                                                                                            PAGE   24            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1469 *                                                                                           
                                    1470 ********************************************************************                        
                                    1471 * CODE FOR NON-TYPE 1 SVCs                                                                  
                                    1472 ********************************************************************                        
                                    1473 *                                                                                           
 0040CC 05C0                        1474 NONTYP1  BALR  12,0                   ESTABLISH ADDR ON 12                                  
 0040CE                             1475          USING *,12                   ESTABLISH ADDR ON 12                                  
                                    1476 *                                                                                           
                                    1477 *    Schedule a new SVRB                                                                    
                                    1478 *                                                                                           
                                    1479 * Get an SVRB from the CB pool and clear it                                                 
                                    1480 *                                                                                           
                                    1481          GETCB100                                                                           
                                    1482+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0040CE 58B0 3018            00018  1483+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0040D2 58AB 0000            00000  1484+         L     10,0(11)           Load Address of next CB.                                  
 0040D6 12AA                        1485+         LTR   10,10              Make sure a CB is available.                              
 0040D8 4770 C024            040F2  1486+         BNZ   GTCB0009           To MVC if there is a CB.                                  
 0040DC 0119                        1487+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 0040DE C3C2F1F0F040D7D6            1488+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 0040F2 D203 B000 A000 00000 00000  1489+GTCB0009    MVC 0(4,11),0(10)           Update header.                                      
 0040F8 D7FF A000 A000 00000 00000  1490          XC    0(CB100LTH,10),0(10)   Clear the SVRB                                        
 0040FE 185A                        1491          LR    5,10                   Base addressability on SVRB                           
                                    1492 *                                                                                           
                                    1493 * Copy saved registers from the TCB                                                         
                                    1494 *                                                                                           
 004100 D23F 5020 4030 00020 00030  1495          MVC   RBGRSAVE(16*4),TCBGRS  Copy GPRs to SVRB                                     
 004106 D21F 5060 40E0 00060 000E0  1496          MVC   RBFRSAVE(8*4),TCBFRS   Copy FPRs to SVRB                                     
                                    1497 *                                                                                           
                                    1498 * Format as an SVRB: RBTYPE = C'SVRB', RBFLGS3 = X'00'                                      
                                    1499 *                                                                                           
 00410C D203 5000 C080 00000 0414E  1500          MVC   RBTYPE,SVRBTYPE        Set RBTYPE='SVRB'                                     
 004112 9200 500B      0000B        1501          MVI   RBFLGS3,X'00'          Set RBFLGS3=X'00'                                     
                                    1502 *                                                                                           
                                    1503 * Put A(TCB) into SVRB RBTCB                                                                
                                    1504 *                                                                                           
 004116 5040 5004            00004  1505          ST    4,RBTCB                Put A(TCB) into SVRB                                  
                                    1506 *                                                                                           
                                    1507 * SVRB RBLINK <- TCBRB                                                                      
                                    1508 *                                                                                           
 00411A D202 501D 4001 0001D 00001  1509          MVC   RBLINK+1(3),TCBRB+1    Set up pointer to TCB in SVRB                         
                                    1510 *                                                                                           
                                    1511 * TCBRB <- A(SVRB)                                                                          
                                    1512 *                                                                                           
 004120 5050 4000            00000  1513          ST 5,TCBRB                   TCBRB gets A(SVRB)                                    
                                    1514 *                                                                                           
                                    1515 *    Get the A(CVTEXIT) into R14                                                            
                                    1516 *                                                                                           
 004124 41E0 3050            00050  1517          LA 14,CVTEXIT                Get @ CVTEXIT into R14                                
                                    1518 *                                                                                           
                                    1519 *    Store Regs 3,4,5,6,14 in the TCBGRS save areas                                         
                                    1520 *                                                                                           
 004128 5010 4034            00034  1521          ST    1,TCBGRS+4             Save R1 for PC Int. Processing                        
 00412C 9036 403C            0003C  1522          STM   3,6,TCBGRS+4*3         Save regs 3,4,5,6 in TCBGRS                           
 004130 50E0 4068            00068  1523          ST    14,TCBGRS+4*14         and R14                                               
                                    1524 *                                                                                           
                                    1525 *   Create a PSW in the SVRB with instruction address taken from                            
1       SVCFLIH CODE                                                                                            PAGE   25            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1526 *   R6, supervisor state, Key 0, interrupts enabled                                         
                                    1527 *                                                                                           
 004134 BE67 C07D            0414B  1528          STCM  6,7,SVRBPSW+5          Save a(SVC routine) into PSW                          
 004138 D207 5010 C078 00010 04146  1529          MVC   RBOPSW(8),SVRBPSW      Create the PSW                                        
                                    1530 *                                                                                           
                                    1531 *   Branch back to the dispatcher                                                           
                                    1532 *                                                                                           
 00413E 58C0 301C            0001C  1533          L     12,CVT0DS              GET @ OF THE DISPATCHER                               
 004142 07FC                        1534          BR    12                     BRANCH BACK TO THE DISPATCHER                         
                                    1535 *                                                                                           
 004144 0119                        1536 SVCF0119 XOPC  25                     DIE IF SOMETHING GOES BAD                             
                                    1537 *                                                                                           
                                    1538 ***************************                                                                 
                                    1539 * SVCFLIH storage                                                                           
                                    1540 ***************************                                                                 
                                    1541 *                                                                                           
 004146 FF0400000F                  1542 SVRBPSW  DC    XL5'FF0400000F'        1st part SVRB PSW                                     
 00414B 000000                      1543          DC    AL3(0)                 Address part of SVRB PSW                              
 00414E E2E5D9C2                    1544 SVRBTYPE DC    CL4'SVRB'              For initializing RBTYPE                               
                                    1545 *                                                                                           
                                    1546 ***************************                                                                 
                                    1547 * END OF SVCFLIH                                                                            
                                    1548 ***************************                                                                 
                                    1549 *                                                                                           
                                    1550 **********************************************************************                      
                                    1551 *                                                                                           
                                    1552 * PCFLIH (PROGRAM CHECK FIRST LEVEL INTERRUPT HANDLER)                                      
                                    1553 *                                                                                           
                                    1554 * Entry Conditions:                                                                         
                                    1555 * Exit Conditions:                                                                          
                                    1556 *                                                                                           
                                    1557 * REGISTER USE:                                                                             
                                    1558 * R3  = A(CVT)                                                                              
                                    1559 * R4  = A(TCB)                                                                              
                                    1560 * R5  = A(RB)                                                                               
                                    1561 * R8  = Calculating Task Times                                                              
                                    1562 * R12 = PCFLIH ADDRESSABILITY                                                               
                                    1563 *                                                                                           
                                    1564 **********************************************************************                      
 004152 0A03                        1565          SVC   3                      MERCIFUL "PORTIA" SVC 3                               
 004154 9101 0029      00029        1566 PCFLIH   TM    OPSWPC+1,X'01'         Check to see if in Sup. State                         
 004158 4780 00BC            000BC  1567          BZ    LEVELABN               If so, die!!                                          
 00415C D203 00B0 0050 000B0 00050  1568          MVC   LOWTIME(4),CLOCK       GET VALUE OF CLOCK INTO LOWTIME                       
 004162 95E3 00BE      000BE        1569          CLI   LEVELFLG,C'T'          Check if in Task                                      
 004166 4770 00BC            000BC  1570          BNE   LEVELABN               If not, die!!                                         
 00416A 92E2 00BE      000BE        1571          MVI   LEVELFLG,C'S'          Put into System                                       
                                    1572 *                                                                                           
                                    1573 * Save all GPRs in PCSAVE                                                                   
                                    1574 *                                                                                           
 00416E 900F 0140            00140  1575          STM   0,15,PCSAVE            SAVE GPRS IN PC AREA                                  
                                    1576 *                                                                                           
                                    1577 * Establish CVT addressability                                                              
                                    1578 *                                                                                           
 004172 5830 004C            0004C  1579          L     3,76                   GET @ OF THE CVT                                      
 000000                             1580          USING CVT,3                  ESTABLISH CVT ADDRESSABILITY                          
                                    1581 *                                                                                           
                                    1582 * Establish TCB addressability                                                              
1       SVCFLIH CODE                                                                                            PAGE   26            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1583 *                                                                                           
 004176 5840 051C            0051C  1584          L     4,TCBWORDS+4           GET @ CURRENTLY DISPATCHED TCB                        
 000000                             1585          USING TCB,4                  ESTABLISH TCB ADDRESSABILITY                          
                                    1586 *                                                                                           
                                    1587 * MOVE ALL GPRS TO THE TCB                                                                  
                                    1588 *                                                                                           
 00417A D23F 4030 0140 00030 00140  1589          MVC   TCBGRS(16*4),PCSAVE    MOVE GPRS INTO THE TCB                                
                                    1590 *                                                                                           
                                    1591 * SAVE ALL FPRS INTO THE TCB                                                                
                                    1592 *                                                                                           
 004180 6000 40E0            000E0  1593          STD   0,TCBFRS               STORE FPR 0                                           
 004184 6020 40E8            000E8  1594          STD   2,TCBFRS+8             STORE FPR 2                                           
 004188 6040 40F0            000F0  1595          STD   4,TCBFRS+16            STORE FPR 4                                           
 00418C 6060 40F8            000F8  1596          STD   6,TCBFRS+24            STORE FPR 6                                           
                                    1597 *                                                                                           
                                    1598 * Establish PCFLIH Addressability                                                           
                                    1599 *                                                                                           
 004190 05C0                        1600          BALR  12,0                   GET ADDRESS NEXT INSTRUCTION                          
 004192                             1601          USING *,12                   ESTABLISH PCFLIH ADDRESSABILITY                       
                                    1602 *                                                                                           
                                    1603 * Establish RB addressability                                                               
                                    1604 *                                                                                           
 004192 5850 4000            00000  1605          L     5,TCBRB                GET @ OF CURRENTLY DISPATCHED RB                      
 004196 1255                        1606          LTR   5,5                    TEST RB ADDRESS                                       
 004198 4780 C0FE            04290  1607          BZ    PC0119                 IF IT IS NULL, DIE!!!                                 
 000000                             1608          USING RB,5                   RB ADDRESSABILITY                                     
                                    1609 *                                                                                           
                                    1610 * COPY OLD PSW TO INTO THE RB                                                               
                                    1611 *                                                                                           
 00419C D207 5010 0028 00010 00028  1612          MVC   RBOPSW(8),OPSWPC       MOVE OLD PSW INTO THE RB                              
                                    1613 *                                                                                           
                                    1614 * Calculate accumulated task time                                                           
                                    1615 *                                                                                           
 0041A2 5880 40A0            000A0  1616          L     8,TCBTDISP             GET TIME OF DISPATCH                                  
 0041A6 5B80 00B0            000B0  1617          S     8,LOWTIME              SUBTRACT THE CURRENT TIME                             
                                    1618 *                                                                                           
                                    1619 * Add accumulated task time and store in TCBTCPUP                                           
                                    1620 *                                                                                           
 0041AA 5A80 40AC            000AC  1621          A     8,TCBTCPUP             ADD ACCUMULATED TASK CPU                              
 0041AE 5080 40AC            000AC  1622          ST    8,TCBTCPUP             SAVE ACCUMULATED TASK TIME                            
                                    1623 *                                                                                           
                                    1624 **********************************************************************                      
                                    1625 * Now Check if a SPIE exists                                                                
                                    1626 * REGISTER USAGE:                                                                           
                                    1627 * 8  - A(SCA) from TCBPIE                                                                   
                                    1628 * 9  - A(PIE) from TCBAPIE                                                                  
                                    1629 * 10 - A(SCA) from A(TCBMSCDA)                                                              
                                    1630 * 11 - A(PIE) from SCA                                                                      
                                    1631 * 7 - A(PICA) from PIE                                                                      
                                    1632 **********************************************************************                      
 0041B2 5880 4004            00004  1633          L     8,TCBPIE               Get TCBPIE                                            
 0041B6 1288                        1634          LTR   8,8                    If TCBPIE=0                                           
 0041B8 4780 C0EE            04280  1635          BZ    NOSPIE                 No SPIE Exists                                        
 0041BC 41A0 4078            00078  1636          LA    10,TCBDMSCA            Get A(SCA)                                            
 0041C0 1788                        1637          XR    8,8                    Clear 8                                               
 0041C2 BF87 4005            00005  1638          ICM   8,X'7',TCBPIE+1        Get A(SCA) from TCBPIE                                
 0041C6 198A                        1639          CR    8,10                   Check if A(SCA) was in TCBPIE                         
1       SVCFLIH CODE                                                                                            PAGE   27            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0041C8 4770 C0EE            04280  1640          BNE   NOSPIE                 If not, no SPIE exists                                
 0041CC 9180 8000      00000        1641          TM    0(8),X'80'             See if InEx bit of SCA is 1                           
 0041D0 4710 C0EE            04280  1642          BO    NOSPIE                 If it is, no SPIE                                     
                                    1643 * Test if SCA+0 = 0, if so ABEND ???                                                        
                                    1644 *         TM    0(8),X'FF'             See if SCA+0 is zero                                 
                                    1645 *         BZ    NOSPIE                 If it is, no SPIE                                    
                                    1646 *                                                                                           
 0041D4 5890 4080            00080  1647          L     9,TCBAPIE              Get A(PIE) in task region                             
 0041D8 17BB                        1648          XR    11,11                  Clear 11                                              
 0041DA BFB7 8001            00001  1649          ICM   11,X'7',1(8)           Get A(PIE) in SCA                                     
 0041DE 199B                        1650          CR    9,11                   See if A(PIE) in SCA was TCBAPIE                      
 0041E0 4770 C0EE            04280  1651          BNE   NOSPIE                 If not, no SPIE                                       
                                    1652 * Test if PIE+0 = 0, if so ABEND ???                                                        
                                    1653 *         TM    0(9),X'FF'             If PIE+0 was zero                                    
                                    1654 *         BZ    NOSPIE                 no spie exists                                       
                                    1655 *                                                                                           
 0041E4 9180 9000      00000        1656          TM    0(9),X'80'             If bit 0 of PIE was 1                                 
 0041E8 4710 C0EE            04280  1657          BO    NOSPIE                 ABEND                                                 
 0041EC 1777                        1658          XR    7,7                    Clear 7                                               
 0041EE BF77 B001            00001  1659          ICM   7,X'7',1(11)           Get A(PICA) from PIE+1                                
 0041F2 1277                        1660          LTR   7,7                    See if it's zero                                      
 0041F4 4780 C0EE            04280  1661          BZ    NOSPIE                 If it is, no spie!                                    
                                    1662 *         CR    7,1                    SEE IF PIE CONTAINED ADDR PICA                       
                                    1663 *         XOPC  25                                                                          
                                    1664 *         BNE   NOSPIE                 IF NOT, NO SPIE                                      
 0041F8 5080 C0E2            04274  1665          ST    8,ASCA                 Save address of SCA                                   
 0041FC 50B0 C0E6            04278  1666          ST    11,APIE                Save address of PIE                                   
 004200 1788                        1667          XR    8,8                    Clear 8                                               
 004202 BF87 7001            00001  1668          ICM   8,X'7',1(7)            Get A(EXIT) routine                                   
 004206 1288                        1669          LTR   8,8                    Check that it's not zero                              
 004208 4780 C0EE            04280  1670          BZ    NOSPIE                 If it's zero, abend                                   
 00420C 5080 C0EA            0427C  1671          ST    8,AEXIT                Save address of the EXIT                              
 004210 17BB                        1672          XR    11,11                  Clear 11                                              
 004212 BFBC 7004            00004  1673          ICM   11,X'C',4(7)           Get S0C choices                                       
 004216 12BB                        1674          LTR   11,11                  Test for zero                                         
 004218 4780 C0EE            04280  1675          BZ    NOSPIE                 If S0C choices are zero, ABEND                        
                                    1676 *                                                                                           
                                    1677 * Determine that the occurring S0C is one of the type                                       
                                    1678 * Specified by the SPIE                                                                     
                                    1679 *                                                                                           
 00421C 1788                        1680          XR    8,8                    Clear 8                                               
 00421E BF83 5012            00012  1681          ICM   8,X'3',RBOPSW+2        Get the S0C code from PSW                             
 004222 89B0 8000            00000  1682          SLL   11,0(8)                Move S0C bit to leftmost pos                          
 004226 12BB                        1683          LTR   11,11                  Check if result was negative                          
 004228 47B0 C0EE            04280  1684          BNM   NOSPIE                 If bit was 1, result negative                         
                                    1685 *                                                                                           
                                    1686 * Move contents of registers 14 through 2 from TCBGRS into                                  
                                    1687 * PIE+12 and move the PSW from RBOPSW into PIE+4                                            
                                    1688 *                                                                                           
 00422C 5880 C0E6            04278  1689          L     8,APIE                 Get A(PIE)                                            
 004230 D207 800C 4068 0000C 00068  1690          MVC   12(2*4,8),TCBGRS+14*4  Save Regs 14,15 to PIE                                
 004236 D20B 8014 4030 00014 00030  1691          MVC   20(3*4,8),TCBGRS       Save Regs 0,1,2 to pie                                
 00423C D207 8004 5010 00004 00010  1692          MVC   4(8,8),RBOPSW          Move the PSW into PIE+4                               
 004242 17BB                        1693          XR    11,11                  Clear 11                                              
 004244 BFB7 006D            0006D  1694          ICM   11,X'7',NPSWPC+5       Get address of PCFLIH                                 
 004248 06B0                        1695          BCTR  11,0                   Step back 1                                           
 00424A 06B0                        1696          BCTR  11,0                   Step back 1                                           
1       SVCFLIH CODE                                                                                            PAGE   28            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 00424C 50B0 4068            00068  1697          ST    11,TCBGRS+14*4         Save A(Portia SVC 3)                                  
 004250 D203 406C C0EA 0006C 0427C  1698          MVC   TCBGRS+15*4(4),AEXIT   Save A(Exit) to TCBGRS                                
 004256 D202 5015 C0EB 00015 0427D  1699          MVC   RBOPSW+5(3),AEXIT+1    Save A(Exit) to RBOPSW+5                              
 00425C D203 4034 C0E6 00034 04278  1700          MVC   TCBGRS+1*4(4),APIE     Put A(PIE) TCBGRS+1*4                                 
 004262 5890 C0E2            04274  1701          L     9,ASCA                 Get A(SCA)                                            
 004266 9680 9000      00000        1702          OI    0(9),X'80'             Set first bit of SCA to 1                             
 00426A 9680 8000      00000        1703          OI    0(8),X'80'             Set first bit of PIE to 1                             
 00426E 58C0 301C            0001C  1704          L     12,CVT0DS              Get A(Dispatcher)                                     
 004272 07FC                        1705          BR    12                     Go back to the dispatcher                             
                                    1706 *                                                                                           
 004274 00000000                    1707 ASCA     DC    A(0)                   Address of the SCA                                    
 004278 00000000                    1708 APIE     DC    A(0)                   Address of the PIE                                    
 00427C 00000000                    1709 AEXIT    DC    A(0)                   Address of the EXIT                                   
                                    1710 **********************************************************************                      
                                    1711 * No SPIE Environment Exists!                                                               
                                    1712 *                                                                                           
                                    1713 * Build R1 contents as X'800Cn000'                                                          
                                    1714 *                                                                                           
 004280 F200 C104 5013 04296 00013  1715 NOSPIE   PACK  PCR1+2(1),RBOPSW+3(1)  Flip the digits                                       
 004286 5810 C102            04294  1716          L     1,PCR1                 Now load into R1                                      
                                    1717 *                                                                                           
                                    1718 * Load address of BRABEND and branch into it                                                
                                    1719 *                                                                                           
 00428A 58F0 3030            00030  1720          L     15,CVTBRABN            Get @ BRABEND routine                                 
 00428E 07FF                        1721          BR    15                     Go into BRABEND                                       
                                    1722 *                                                                                           
 004290 0119                        1723 PC0119   XOPC  25                     TERMINATE IF SOMETHING GOES BAD                       
                                    1724 **********************************************************************                      
                                    1725 * PCFLIH WS                                                                                 
                                    1726 **********************************************************************                      
 004294                             1727          DC    0F'0'                  For alignment                                         
 004294 800C0000                    1728 PCR1     DC    X'800C0000'            Stuff to go into R1                                   
 004298 0000                        1729 PCIC     DC    XL2'0000'              Interrupt Code from PSW                               
 00429A                             1730          DROP  3,4,5,12               Done with all addressability                          
                                    1731 *                                                                                           
                                    1732 *** END PCFLIH ***                                                                          
                                    1733 *                                                                                           
 00429A 0119                        1734 MCFLIH   DC    X'0119'                MACHINE CHECK FLIH                                    
1       I/O FIRST LEVEL INTERRUPT HANDLER                                                                       PAGE   29            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1736 **********************************************************************                      
                                    1737 * IOFLIH                                                                                    
                                    1738 *                                                                                           
                                    1739 * Register usage:                                                                           
                                    1740 * R3  = A(CVT)                                                                              
                                    1741 * R4  = A(TCB)                                                                              
                                    1742 * R5  = A(RB)                                                                               
                                    1743 * R6  = Used to branch into SVC 2                                                           
                                    1744 * R7  = A(UCB)                                                                              
                                    1745 * R8  = Used for calculating task time                                                      
                                    1746 * R9  = A(IOB) from UCB                                                                     
                                    1747 * R10 = Used by FRECB100                                                                    
                                    1748 * R11 = Used by FRECB100/ A(BUFFER) from IOB                                                
                                    1749 * R12 = Routine Addressability                                                              
                                    1750 * R13 = Points to TCB from RQE                                                              
                                    1751 * R14 = Used as return address from SVC 2                                                   
                                    1752 **********************************************************************                      
                                    1753 *                                                                                           
 00429C 95E3 00BE      000BE        1754 IOFLIH   CLI   LEVELFLG,C'T'          CHECK IF IN TASK STATE                                
 0042A0 4770 00BC            000BC  1755          BNE   LEVELABN               IF NOT, SOMETHING WRONG, DUMP                         
 0042A4 92E2 00BE      000BE        1756          MVI   LEVELFLG,C'S'          OTHERWISE SWITCH TO SYSTEM STATE                      
                                    1757 *                                                                                           
                                    1758 * Move clock to a lowcore location                                                          
                                    1759 *                                                                                           
 0042A8 D203 00B0 0050 000B0 00050  1760          MVC   LOWTIME(4),CLOCK       GET VALUE OF CLOCK INTO LOWTIME                       
                                    1761 *                                                                                           
                                    1762 * Save all GPRs in SVCSAVE                                                                  
                                    1763 *                                                                                           
 0042AE 900F 0180            00180  1764          STM   0,15,IOSAVE            SAVE GPRS IN PROPER SAVE AREA                         
                                    1765 *                                                                                           
                                    1766 * Establish CVT addressability                                                              
                                    1767 *                                                                                           
 0042B2 5830 004C            0004C  1768          L     3,76                   GET @ OF THE CVT                                      
 000000                             1769          USING CVT,3                  ESTABLISH CVT ADDRESSABILITY                          
                                    1770 *                                                                                           
                                    1771 * Establish TCB addressability                                                              
                                    1772 *                                                                                           
 0042B6 5840 051C            0051C  1773          L     4,TCBWORDS+4           GET @ CURRENTLY DISPATCHED TCB                        
 000000                             1774          USING TCB,4                  ESTABLISH TCB ADDRESSABILITY                          
                                    1775 *                                                                                           
                                    1776 * MOVE ALL GPRS TO THE TCB                                                                  
                                    1777 *                                                                                           
 0042BA D23F 4030 0180 00030 00180  1778          MVC   TCBGRS(16*4),IOSAVE    MOVE GPRS INTO THE TCB                                
                                    1779 *                                                                                           
                                    1780 * SAVE ALL FPRS INTO THE TCB                                                                
                                    1781 *                                                                                           
 0042C0 6000 40E0            000E0  1782          STD   0,TCBFRS               STORE FPR 0                                           
 0042C4 6020 40E8            000E8  1783          STD   2,TCBFRS+8             STORE FPR 2                                           
 0042C8 6040 40F0            000F0  1784          STD   4,TCBFRS+16            STORE FPR 4                                           
 0042CC 6060 40F8            000F8  1785          STD   6,TCBFRS+24            STORE FPR 6                                           
                                    1786 *                                                                                           
                                    1787 * Establish Routine Addressability                                                          
                                    1788 *                                                                                           
 0042D0 05C0                        1789          BALR  12,0                   GET ADDRESS NEXT INSTRUCTION                          
 0042D2                             1790          USING *,12                   ESTABLISH SVCFLIH ADDRESSABILITY                      
                                    1791 *                                                                                           
                                    1792 * Establish RB addressability                                                               
1       I/O FIRST LEVEL INTERRUPT HANDLER                                                                       PAGE   30            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1793 *                                                                                           
 0042D2 5850 4000            00000  1794          L     5,TCBRB                GET @ OF CURRENTLY DISPATCHED RB                      
 000000                             1795          USING RB,5                   ESTABLISH RB ADDRESSABILITY                           
                                    1796 *                                                                                           
                                    1797 * Verify RB address not null                                                                
                                    1798 *                                                                                           
 0042D6 1255                        1799          LTR  5,5                     TEST R5                                               
 0042D8 4780 C0F0            043C2  1800          BZ   IO0119                  IF IT IS, DIE!!!                                      
                                    1801 *                                                                                           
                                    1802 * COPY OLD PSW TO INTO THE RB                                                               
                                    1803 *                                                                                           
 0042DC D207 5010 0038 00010 00038  1804          MVC   RBOPSW(8),OPSWIO       MOVE OLD PSW INTO THE RB                              
                                    1805 *                                                                                           
                                    1806 * Calculate accumulated task time                                                           
                                    1807 *                                                                                           
 0042E2 5880 40A0            000A0  1808          L     8,TCBTDISP             GET TIME OF DISPATCH                                  
 0042E6 5B80 00B0            000B0  1809          S     8,LOWTIME              SUBTRACT THE CURRENT TIME                             
                                    1810 *                                                                                           
                                    1811 * Add accumulated task time and store in TCBTCPUP                                           
                                    1812 *                                                                                           
 0042EA 5A80 40AC            000AC  1813          A     8,TCBTCPUP             ADD ACCUMULATED TASK CPU                              
 0042EE 5080 40AC            000AC  1814          ST    8,TCBTCPUP             SAVE ACCUMULATED TASK TIME                            
                                    1815 *                                                                                           
                                    1816 * Check the CSW Unit and Channel Status for the                                             
                                    1817 * Occurrence of bad bits                                                                    
                                    1818 *                                                                                           
 0042F2 91D3 0044      00044        1819          TM    X'44',255-CUE-CE-DE    Check UCB if any bad bits                             
 0042F6 4770 C0F0            043C2  1820          BNZ   IO0119                 If yes, DIE                                           
 0042FA 91BF 0045      00045        1821          TM    X'45',255-IL           Check CSB if any bad bits                             
 0042FE 4770 C0F0            043C2  1822          BNZ   IO0119                 If yes, DIE                                           
                                    1823 *                                                                                           
                                    1824 * Check to see if this was device end                                                       
                                    1825 *                                                                                           
 004302 9104 0044      00044        1826          TM    X'44',DE               Test if Device End bit set                            
 004306 4780 C0EA            043BC  1827          BZ    IO2CHAP                If not, go directly to CHAP                           
                                    1828 *                                                                                           
                                    1829 * Find UCB matching device address in OLD I/O PSW                                           
                                    1830 *                                                                                           
 00430A 5870 300C            0000C  1831          L     7,CVTUCBS              Get Address of UCBS                                   
 000000                             1832          USING UCB,7                  UCB Addressability                                    
 00430E D501 003A 7004 0003A 00004  1833 CRUCB    CLC   OPSWIO+2(2),UCBCHAN    determine if this is right UCB                        
 004314 4780 C054            04326  1834          BE    IOUCBFND               If so, found it                                       
 004318 5870 7008            00008  1835          L     7,UCBUCB               If not, move to next UCB                              
 00431C 1277                        1836          LTR   7,7                    Check if at end of list                               
 00431E 4780 C0F0            043C2  1837          BZ    IO0119                 Hit end of UCB chain, DIE                             
 004322 47F0 C03C            0430E  1838          B     CRUCB                  Check if right UCB Again                              
 004326 58A0 7010            00010  1839 IOUCBFND L     10,UCBCURQE            Get A(RQE)                                            
 00432A 12AA                        1840          LTR   10,10                  Check if it's null                                    
 00432C 4780 C0F0            043C2  1841          BZ    IO0119                 If so, DIE                                            
 000000                             1842          USING RQE,10                 Set up RQE Addressability                             
 004330 5890 A004            00004  1843          L     9,RQEIOB               Get @IOB from RQE                                     
 004334 58D0 A00C            0000C  1844          L     13,RQETCB              Get @TCB from RQE                                     
 004338                             1845          DROP  4                      Drop old TCB                                          
 000000                             1846          USING TCB,13                 Work with new TCB                                     
 000000                             1847          USING IOB,9                  IOB Addressability                                    
                                    1848 *                                                                                           
                                    1849 * Calculate amount of I/O wait time                                                         
1       I/O FIRST LEVEL INTERRUPT HANDLER                                                                       PAGE   31            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    1850 *                                                                                           
 004338 5800 D018            00018  1851          L     0,TCBTSSIO             Get I/O start time                                    
 00433C 5B00 00B0            000B0  1852          S     0,LOWTIME              Calculate amount of time waited                       
 004340 5A00 D024            00024  1853          A     0,TCBTWAIT             Add to accumulated wait time                          
 004344 5000 D024            00024  1854          ST    0,TCBTWAIT             Save resulting wait time                              
                                    1855 *                                                                                           
                                    1856 * Perform Branch Entry into SVC2                                                            
                                    1857 *                                                                                           
 004348 BF0F C0F2            043C4  1858          ICM   0,15,IOPOST            Get post code into R0                                 
 00434C 4110 A018            00018  1859          LA    1,RQEIOECB             Get A(ECB) for SVC 2                                  
 004350 5860 3004            00004  1860          L     6,CVTSVCTA             Get address of SVCTABLE                               
 004354 4160 6010            00010  1861          LA    6,2*8(,6)              Go to entry for SVC 2                                 
 004358 5860 6000            00000  1862          L     6,0(,6)                Get A(SVC 2)                                          
 00435C 95F0 00BF      000BF        1863          CLI   TYP1FLAG,C'0'          Test the type 1 flag                                  
 004360 4770 00BC            000BC  1864          BNE   LEVELABN               If not right, LEVELABN                                
 004364 92F1 00BF      000BF        1865          MVI   TYP1FLAG,C'1'          Set the type 1 flag                                   
 004368 05E6                        1866          BALR  14,6                   Branch into SVC 2                                     
 00436A 95F1 00BF      000BF        1867          CLI   TYP1FLAG,C'1'          Check TYP1FLAG                                        
 00436E 4770 00BC            000BC  1868          BNE   LEVELABN               If not right, LEVELABN                                
 004372 92F0 00BF      000BF        1869          MVI   TYP1FLAG,C'0'          Set TYP1FLAG back to zero                             
                                    1870 *                                                                                           
                                    1871 * Mark the UCB for the device as non-busy                                                   
                                    1872 *                                                                                           
 004376 9200 7006      00006        1873          MVI   UCBFLA,X'00'           Mark UCB as Non-Busy                                  
                                    1874 *                                                                                           
                                    1875 * Set the proper return code in R15                                                         
                                    1876 *                                                                                           
 00437A 58B0 9008            00008  1877          L     11,IOBUFADD            Address of Buffer                                     
 00437E 9501 9006      00006        1878          CLI   IOBOPCDE,X'01'         Check if this is WRITE                                
 004382 4780 C0CA            0439C  1879          BE    SETRC0                 If not, set RC for Read                               
 004386 D507 B000 C0F6 00000 043C8  1880          CLC   0(8,11),IO9TEST        Check for 9's indicating EOF                          
 00438C 4770 C0CA            0439C  1881          BNE   SETRC0                 If not, RC=0                                          
 004390 41F0 0004            00004  1882          LA    15,4                   Otherwise, set RC=4                                   
 004394 50F0 D06C            0006C  1883          ST    15,TCBGRS+15*4         Save Return Code                                      
 004398 47F0 C0D0            043A2  1884          B     FREERQE                Move on, free RQE                                     
 00439C D703 D06C D06C 0006C 0006C  1885 SETRC0   XC    TCBGRS+15*4(4),TCBGRS+15*4  Clear R15                                        
 0043A2                             1886          DROP  9                      Done with IOB                                         
                                    1887 *                                                                                           
                                    1888 * Release the CB back into the wild, clear UCBCURQE                                         
                                    1889 *                                                                                           
 0043A2                             1890 FREERQE  DS    0H                     Free the RQE                                          
                                    1891          FRECB100                                                                           
                                    1892+*        FRECB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0043A2 58B0 3018            00018  1893+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0043A6 D203 A000 B000 00000 00000  1894+         MVC   0(4,10),0(11)           Add. next CB into freeing CB.                        
 0043AC 50AB 0000            00000  1895+         ST    10,0(11)           Point header to just freed CB.                            
 0043B0 D703 7010 7010 00010 00010  1896          XC    UCBCURQE(4),UCBCURQE   Clear the UCBCURQE field                              
                                    1897 *                                                                                           
                                    1898 * Branch to the beginning of the BEGINIO routine                                            
                                    1899 *                                                                                           
 0043B6 58C0 3020            00020  1900          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 0043BA 07FC                        1901          BR    12                     Go to BEGINIO                                         
                                    1902 *                                                                                           
                                    1903 * Instead of going to CHAP routine, just go back to the dispatcher                          
                                    1904 *                                                                                           
 0043BC 58C0 3024            00024  1905 IO2CHAP  L     12,CVTCHAP             Get A(CHAP) routine                                   
 0043C0 07FC                        1906          BR    12                     Go to Chap routine                                    
1       I/O FIRST LEVEL INTERRUPT HANDLER                                                                       PAGE   32            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0043C2 0119                        1907 IO0119   XOPC  25                     DIE                                                   
 0043C4                             1908          DROP  3,5,7,10,12,13         Done with base regs                                   
                                    1909 *********************************************************************                       
                                    1910 * IOFLIH STORAGE                                                                            
                                    1911 *********************************************************************                       
 0043C4 7FC9D6E2                    1912 IOPOST   DC    X'7F',C'IOS'           Post Code for SVC 2                                   
 0043C8 F9F9F9F9F9F9F9F9            1913 IO9TEST  DC    8C'9'                  For checking if EOF                                   
                                    1914 *                                                                                           
                                    1915 ****************************************                                                    
                                    1916 * SVC AREA                                                                                  
                                    1917 ****************************************                                                    
                                    1918 *                                                                                           
 006000                             1919         ORG    FIRST4K+X'6000'        GO TO SVC 0                                           
                                    1920 *                                                                                           
                                    1921 ************************************************************                                
                                    1922 * SVC 0                                                                                     
                                    1923 *                                                                                           
                                    1924 * I/O ROUTINE                                                                               
                                    1925 *                                                                                           
                                    1926 * ENTRY CONDITIONS:                                                                         
                                    1927 *   R1  - ADDRESS OF IOB                                                                    
                                    1928 *   R3  - ADDRESS OF THE CVT                                                                
                                    1929 *   R4  - ADDRESS OF THE TCB                                                                
                                    1930 *   R5  - ADDRESS OF THE RB                                                                 
                                    1931 *   R6  - ADDRESS OF THIS ROUTINE                                                           
                                    1932 *   R14 - ADDRESS TO RETURN TO SVCFLIH                                                      
                                    1933 *                                                                                           
                                    1934 * EXIT CONDITIONS:                                                                          
                                    1935 *   R15 = 0 ON SUCCESS                                                                      
                                    1936 *         4 IF EOF ENCOUNTERED                                                              
                                    1937 * LOGIC:                                                                                    
                                    1938 * Logic is embedded within the code                                                         
                                    1939 *                                                                                           
                                    1940 * REGISTER USE:                                                                             
                                    1941 *        R1 - IOB ADDRESSABILITY                                                            
                                    1942 *        R15 - Holds the device address for comparison                                      
                                    1943 *              ADDRESS OF THE BUFFER                                                        
                                    1944 *        R6 - ADDRESSABILITY FOR SVC 0                                                      
                                    1945 *        R0 -                                                                               
                                    1946 *                                                                                           
                                    1947 ************************************************************                                
                                    1948 *                                                                                           
 006000                             1949          USING SVC0,6                 ADDR FOR SVC0                                         
 000000                             1950          USING IOB,1                  IOB ADDRESSABILITY                                    
                                    1951 *                                                                                           
                                    1952 * check if the EBCDIC characters 'IOB' are in the first                                     
                                    1953 * 3 bytes of the IOB                                                                        
                                    1954 *                                                                                           
 006000 D502 1000 605A 00000 0605A  1955 SVC0     CLC   IOBIDENT(3),IOBCHECK   CHECK THE IOBIDENT FIELD                              
 006006 4770 6058            06058  1956          BNE   SVC00119               CHARACTERS NOT 'IOB' THEN DIE!!                       
                                    1957 *                                                                                           
                                    1958 * Check that the device address is X'0000'                                                  
                                    1959 * If not, die a horrible death.                                                             
                                    1960 *                                                                                           
 00600A 48F0 1004            00004  1961          LH    15,IOBDEVAD            GET THE DEVICE ADDRESS                                
 00600E 12FF                        1962          LTR   15,15                  CHECK IF IT WAS ZERO                                  
 006010 4770 604E            0604E  1963          BNZ   GO2RQENQ               GO TO RQEENQ ROUTINE                                  
1       I/O FIRST LEVEL INTERRUPT HANDLER                                                                       PAGE   33            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 006014 5870 1008            00008  1964          L     7,IOBUFADD             GET THE ADDRESS OF THE BUFFER                         
 006018 4880 100C            0000C  1965          LH    8,IOBUFLEN             GET THE LENGTH OF THE BUFFER                          
                                    1966 *                                                                                           
                                    1967 * CHECK IF OPERATION CODE IS X'01', IF IT IS, DO THE WRITE                                  
                                    1968 *                                                                                           
 00601C 9501 1006      00006        1969          CLI   IOBOPCDE,X'01'         SEE IF IOBOPCODE IS X'01'                             
 006020 4780 6044            06044  1970          BE    DOWRITE                IF IT IS, DO THE WRITE                                
                                    1971 *                                                                                           
                                    1972 * CHECK IF OPERATION CODE IS '02', IF IT IS DO THE READ                                     
                                    1973 *                                                                                           
 006024 9502 1006      00006        1974          CLI   IOBOPCDE,X'02'         SEE IF IOBOPCODE IS X'02'                             
 006028 4770 6058            06058  1975          BNE   SVC00119               If it's not, something wrong, die                     
                                    1976 *                                                                                           
                                    1977 * PERFORM THE XREAD                                                                         
                                    1978 *                                                                                           
 00602C E000 7000 8000 00000        1979          XREAD 0(0,7),(8)             READ STUFF INTO THE BUFFER                            
                                    1980 *                                                                                           
                                    1981 * CHECK FOR END OF FILE                                                                     
                                    1982 *                                                                                           
 006032 4740 603E            0603E  1983          BM    EOF                    IF EOF, EXIT WITH RC=4                                
                                    1984 *                                                                                           
                                    1985 * IF NOT EOF, CHECK BUFFER FOR NINES                                                        
                                    1986 *                                                                                           
 006036 D507 7000 605D 00000 0605D  1987          CLC   0(8,7),ALLNINES        SEE IF BUFFER CONTAINS NINES                          
 00603C 077E                        1988          BNER  14                     IF IT DOES, EXIT WITH RC=4                            
                                    1989 *                                                                                           
                                    1990 * OTHERWISE (NOT EOF OR ALL 9'S) SET A 0 RC AND RETURN                                      
                                    1991 *                                                                                           
 00603E 41F0 0004            00004  1992 EOF      LA    15,4                   SET RC=4 IN 15                                        
 006042 07FE                        1993          BR    14                     LEAVE THE SVC WITH RC=0                               
 006044 E020 7000 8000 00000        1994 DOWRITE  XPRNT 0(0,7),(8)             PRINT CONTENTS OF BUFFER                              
 00604A 17FF                        1995          XR    15,15                  SET R15 TO ZERO                                       
 00604C 07FE                        1996          BR    14                     Return                                                
                                    1997 *                                                                                           
 00604E                             1998          DROP  1,6                    Done with addr. for SVC 0                             
 00604E 58C0 004C            0004C  1999 GO2RQENQ L     12,76                  Get @(CVT)                                            
 000000                             2000          USING CVT,12                 CVT Addressability                                    
 006052 58C0 C038            00038  2001          L     12,CVTRQENQ            Get A(RQEENQ) Routine                                 
 006056 07FC                        2002          BR    12                     Go to RQEENQ                                          
 006058                             2003          DROP  12                     Done with CVT                                         
 006058 0119                        2004 SVC00119 XOPC  25                     DIE IF SOMETHING GOES WRONG                           
                                    2005 *                                                                                           
                                    2006 **********************                                                                      
                                    2007 * SVC 0 STORAGE                                                                             
                                    2008 **********************                                                                      
                                    2009 *                                                                                           
 00605A C9D6C2                      2010 IOBCHECK DC CL3'IOB'                  USED TO CHECK IOB                                     
 00605D F9F9F9F9F9F9F9F9            2011 ALLNINES DC CL8'99999999'             NINES TO TEST AGAINST                                 
                                    2012 *                                                                                           
1       SVC 1 DOC                                                                                               PAGE   34            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2014 *                                                                                           
                                    2015 **********************************************************************                      
                                    2016 * SVC 1                                                                                     
                                    2017 *                                                                                           
                                    2018 * ENTRY CONDITIONS:                                                                         
                                    2019 * R3 - A(CVT)                                                                               
                                    2020 * R4 - A(TCB)                                                                               
                                    2021 * R5 - A(RB)                                                                                
                                    2022 * R6 - A(SVC1)                                                                              
                                    2023 *                                                                                           
                                    2024 * EXIT CONDITIONS:                                                                          
                                    2025 * REGISTER VALUES UNCHANGED                                                                 
                                    2026 *                                                                                           
                                    2027 * Wait bit     Post bit                                                                     
                                    2028 * --------     --------                                                                     
                                    2029 *   0             0        Bits set to 1 and 0, A(RB) saved to ECB                          
                                    2030 *                          and RBWCF incremented by one.                                    
                                    2031 *   0             1        Nothing: NO OP                                                   
                                    2032 *   1             0        XOPC 25 (S301)                                                   
                                    2033 *   1             1        Nothing: NO OP                                                   
                                    2034 *                                                                                           
                                    2035 **********************************************************************                      
1       SVC1 CODE                                                                                               PAGE   35            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 006066                             2037          USING SVC1,6                 Establish SVC 1 Addressability                        
 006066 5900 602E            06094  2038 SVC1     C     0,TESTR0               SEE IF R0=1                                           
 00606A 4770 602C            06092  2039          BNE   SVC10119               IF NOT, DIE                                           
 00606E 9140 1000      00000        2040          TM    0(1),X'40'             Check second bit of MECB                              
 006072 071E                        2041          BCR   1,14                   If CC=3 (Second bit=1), return                        
 006074 9180 1000      00000        2042          TM    0(1),X'80'             Check first bit of MECB                               
 006078 4710 602C            06092  2043          BC    1,SVC10119             If CC=3 (First bit=1), Die                            
                                    2044 *                                                                                           
                                    2045 * Only get here when both wait and post bits are zero                                       
                                    2046 *                                                                                           
 00607C 43F0 501C            0001C  2047          IC    15,28(,5)              Get the RBWCF                                         
 006080 41F0 F001            00001  2048          LA    15,1(,15)              and increment it                                      
 006084 42F0 501C            0001C  2049          STC   15,28(,5)              then put it back                                      
 006088 BE57 1001            00001  2050          STCM  5,7,1(1)               Put A(RB) into the ECB                                
 00608C 9680 1000      00000        2051          OI    0(1),X'80'             Turn on first bit of MECB                             
 006090 07FE                        2052          BR    14                     Leave SVC 1 Module                                    
 006092 0119                        2053 SVC10119 XOPC  25                     Bail out in case of S301                              
 006094                             2054          DROP  6                      Done with SVC1                                        
 006094 00000001                    2055 TESTR0   DC    F'1'                   Check if R0=1                                         
                                    2056 *                                                                                           
                                    2057 *** END OF SVC 1 ****                                                                       
                                    2058 *                                                                                           
1       SVC 2                                                                                                   PAGE   36            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2060 *********************************************************************                       
                                    2061 * SVC 2 -- Type 1 -- Post                                                                   
                                    2062 *                                                                                           
                                    2063 * Wait      Post         Operation Performed                                                
                                    2064 * -----     -----        -------------------                                                
                                    2065 * 0         1            No Op                                                              
                                    2066 * 1         1            No Op                                                              
                                    2067 * 1         0            1) Verify RB at ECB+1 has ' PRB' or 'SVRB'                         
                                    2068 *                        2) Decrement the RBWCF                                             
                                    2069 *                        3) Change W-P to '01'                                              
                                    2070 *                        4) Put bits 2-31 of R0 into bits 2-31 of                           
                                    2071 *                           ECB                                                             
                                    2072 * 0         0            Steps 3 and 4 from above                                           
                                    2073 *                                                                                           
                                    2074 * ENTRY CONDITIONS:                                                                         
                                    2075 * R0  - Post code contained in bits 2-31                                                    
                                    2076 * R1  - address of the ECB                                                                  
                                    2077 * R3  - @ the CVT                                                                           
                                    2078 * R4  - @ the TCB                                                                           
                                    2079 * R5  - @ the RB                                                                            
                                    2080 * R6  - @ SVC 2                                                                             
                                    2081 *                                                                                           
                                    2082 * Working Registers:                                                                        
                                    2083 * R0  - Post Code                                                                           
                                    2084 * R1  - A(ECB)                                                                              
                                    2085 * R6  -                                                                                     
                                    2086 * R15 - RB Addressability                                                                   
                                    2087 *********************************************************************                       
                                    2088 *                                                                                           
 006098                             2089          USING SVC2,6                 Establish SVC 2 Addressability                        
 006098 9140 1000      00000        2090 SVC2     TM    0(1),X'40'             Check second bit of MECB                              
 00609C 071E                        2091          BOR   14                     If it was 1, return (NO OP)                           
 00609E 58F1 0000            00000  2092          L     15,0(1)                Get A(RB) from the ECB                                
 000000                             2093          USING RB,15                  Set up RB addressability                              
 0060A2 9180 1000      00000        2094          TM    0(1),X'80'             Check first bit of MECB                               
 0060A6 5001 0000            00000  2095          ST    0,0(1)                 Save the Post Code                                    
 0060AA 4780 602A            060C2  2096          BZ    SETWP                  If it's zero, set W-P, post,ret                       
 0060AE D501 6036 F002 060CE 00002  2097          CLC   SVC2RB(2),RBTYPE+2     See if 'RB' is in RBTYPE                              
 0060B4 4770 6034            060CC  2098          BNE   SVC20119               Die if it's not                                       
 0060B8 4300 F01C            0001C  2099          IC    0,RBWCF                Get RBWCF                                             
 0060BC 0600                        2100          BCTR  0,0                    Decrement it                                          
 0060BE 4200 F01C            0001C  2101          STC   0,RBWCF                Save the new value                                    
 0060C2                             2102          DROP  15                     Done with the RB                                      
 0060C2 9640 1000      00000        2103 SETWP    OI    0(1),X'40'             Set the Post Bit                                      
 0060C6 947F 1000      00000        2104          NI    0(1),X'7F'             Turn off wait bit                                     
 0060CA 07FE                        2105          BR    14                     Leave SVC 2                                           
 0060CC                             2106          DROP  6                      Done with SVC 2                                       
                                    2107 *                                                                                           
 0060CC 0119                        2108 SVC20119 XOPC  25                     Die if there's a problem                              
                                    2109 *                                                                                           
 0060CE D9C2                        2110 SVC2RB   DC    CL2'RB'                For checking the RB                                   
                                    2111 *                                                                                           
                                    2112 ************************                                                                    
                                    2113 * End of SVC2                                                                               
                                    2114 ************************                                                                    
                                    2115 *                                                                                           
                                    2116 *********************************************************************                       
1       SVC 2                                                                                                   PAGE   37            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2117 * SVC 3                                                                                     
                                    2118 *                                                                                           
                                    2119 * ENTRY CONDITIONS                                                                          
                                    2120 * R3  - Points to the CVT                                                                   
                                    2121 * R4  - Points to the Current TCB                                                           
                                    2122 * R5  - Points to the current RB                                                            
                                    2123 * R6  - Used for routine addressability                                                     
                                    2124 * R14 - Exit address to SVC-FLIH                                                            
                                    2125 *                                                                                           
                                    2126 * EXIT CONDITIONS:                                                                          
                                    2127 * Current PRB or SVRB "disconnected" from the TCB                                           
                                    2128 *                                                                                           
                                    2129 *********************************************************************                       
                                    2130 *                                                                                           
 007000                             2131          ORG   FIRST4K+X'7000'        Go to location for SVC 3                              
 007000                             2132          USING SVC3,6                 Establish SVC3 Addressability                         
 000000                             2133          USING CVT,3                  Establish CVT Addressability                          
 000000                             2134          USING TCB,4                  Establich TCB Addressability                          
 000000                             2135          USING RB,5                   Establish RB Addressability                           
                                    2136 *                                                                                           
                                    2137 * Store registers 0,1,15 in the PRB/SVRB save area                                          
                                    2138 *                                                                                           
 007000 D502 0025 006D 00025 0006D  2139 SVC3     CLC   OPSWSVC+5(3),NPSWPC+5  Test for portia entry                                 
 007006 4780 6062            07062  2140          BE    PORTIA                 If it is, do the Portia stuff                         
 00700A 9001 5020            00020  2141          STM   0,1,RBGRSAVE           Save R0,R1 into the RB                                
 00700E 50F0 505C            0005C  2142          ST    15,RBGRSAVE+15*4       Save R15 into the RB                                  
                                    2143 *                                                                                           
                                    2144 * Copy GPRS and FPRs to the TCB                                                             
                                    2145 *                                                                                           
 007012 D23F 4030 5020 00030 00020  2146          MVC   TCBGRS(4*16),RBGRSAVE  Copy GPRs into TCB                                    
 007018 D21F 40E0 5060 000E0 00060  2147          MVC   TCBFRS(8*4),RBFRSAVE   Copy FPRs into TCB                                    
 00701E D202 4001 501D 00001 0001D  2148          MVC   TCBRB+1(3),RBLINK+1    Make TCB point to next RB                             
                                    2149 *                                                                                           
                                    2150 * Check to see if this is a PRB                                                             
                                    2151 *                                                                                           
 007024 BD47 4001            00001  2152          CLM   4,7,TCBRB+1            See if TCBRB->TCB (This is PRB)                       
 007028 4780 6048            07048  2153          BE    TEST2                  This is a PRB, Do PRB Stuff                           
 00702C 9180 500B      0000B        2154          TM    RBFLGS3,X'80'          Make sure this is an SVRB                             
 007030 4770 6096            07096  2155          BNE   SVC30119               If not, die                                           
 007034 18A5                        2156          LR    10,5                   Get a(SVRB) for FRECB100                              
                                    2157 * Free the SVRB                                                                             
                                    2158          FRECB100                                                                           
                                    2159+*        FRECB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 007036 58B0 3018            00018  2160+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 00703A D203 A000 B000 00000 00000  2161+         MVC   0(4,10),0(11)           Add. next CB into freeing CB.                        
 007040 50AB 0000            00000  2162+         ST    10,0(11)           Point header to just freed CB.                            
 007044 47F0 6056            07056  2163          B     SVC3END                Otherwise, go to the end                              
                                    2164 *                                                                                           
                                    2165 * If this is a PRB, zero out the TCBRB field                                                
                                    2166 *                                                                                           
 007048 9180 500B      0000B        2167 TEST2    TM    RBFLGS3,X'80'          Make sure this is a PRB (bit 0=1)                     
 00704C 47E0 6096            07096  2168          BNO   SVC30119               Die if it's not a PRB                                 
 007050 D703 4000 4000 00000 00000  2169          XC    TCBRB(4),TCBRB         Otherwise clear TCBRB                                 
 007056 D203 500C 6098 0000C 07098  2170 SVC3END  MVC   RBCDE(4),SVC3UNCH      Insert an "Unchained" message                         
 00705C 5850 4000            00000  2171          L     5,TCBRB                Get TCBRB into 5                                      
 007060 07FE                        2172          BR    14                     Exit to SVCFLIH                                       
                                    2173 *                                                                                           
1       SVC 2                                                                                                   PAGE   38            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2174 *********************************************************************                       
                                    2175 * PORTIA SVC 3 (Tests for TCBPIE = 0 removed)                                               
                                    2176 * R7 = Address of the SCA (Right 3 bytes)                                                   
                                    2177 * R8 = Address of the PIE                                                                   
                                    2178 *                                                                                           
                                    2179 * Steps:                                                                                    
                                    2180 *                                                                                           
                                    2181 * 1) Get A(SCA)                                                                             
                                    2182 * 2) Verify InEx bit in SCA was 1                                                           
                                    2183 * 3) If not 1, XOPC 25                                                                      
                                    2184 * 4) Set InEx bit in SCA to 0                                                               
                                    2185 * 5) Get A(PIE)                                                                             
                                    2186 * 6) Set InEx bit in PIE to 0                                                               
                                    2187 * 7) Move registers 14,2 from PIE to TCBGRS                                                 
                                    2188 * 8) Move 2nd half of PSW from PIE into RBO PSW                                             
                                    2189 * 9) Load 0,1,15 into "Honest to God" 0,1,15                                                
                                    2190 *                                                                                           
                                    2191 *********************************************************************                       
 007062 BF77 4005            00005  2192 PORTIA   ICM   7,X'7',TCBPIE+1        Get A(SCA)                                            
 007066 9180 7000      00000        2193          TM    0(7),X'80'             Test InEx bit in SCA                                  
 00706A 4780 6096            07096  2194          BZ    SVC30119               If it was not 1, die!!                                
 00706E 947F 7000      00000        2195          NI    0(7),X'7F'             Set bit 0 of SCA to zero                              
 007072 BF87 7001            00001  2196          ICM   8,X'7',1(7)            Get A(PIE) from the SCA                               
 007076 947F 8000      00000        2197          NI    0(8),X'7F'             Set bit 0 of PIE to zero                              
 00707A D207 4068 800C 00068 0000C  2198          MVC   TCBGRS+14*4(8),12(8)   Move 14,15 from PIE to TCBGRS                         
 007080 D20B 4030 8014 00030 00014  2199          MVC   TCBGRS(12),20(8)       Move 0,1,2 from PIE to TCBGRS                         
 007086 D203 5014 8008 00014 00008  2200          MVC   RBOPSW+4(4),8(8)       Move 2nd half of PSW from PIE+8                       
 00708C 9801 4030            00030  2201          LM    0,1,TCBGRS             Restore R0,R1                                         
 007090 58F0 406C            0006C  2202          L     15,TCBGRS+15*4         Restore R15                                           
 007094 07FE                        2203          BR    14                     Return to SVCFLIH                                     
                                    2204 *                                                                                           
 007096 0119                        2205 SVC30119 XOPC  25                     Die here if things go bad                             
                                    2206 *                                                                                           
                                    2207 ************************                                                                    
                                    2208 * SVC3 WORKING STORAGE                                                                      
                                    2209 ************************                                                                    
                                    2210 *                                                                                           
 007098 E4D5C3C8                    2211 SVC3UNCH DC   CL4'UNCH'               For unchaining the RB                                 
 00709C                             2212          DROP 3,4,5,6                 Done with addressability                              
                                    2213 *********************************************************************                       
                                    2214 * END OF SVC 3                                                                              
                                    2215 *********************************************************************                       
 007300                             2216         ORG    FIRST4K+X'7300'        GO TO SVC 8                                           
 007300                             2217 SVC8    DS     0H                     ADDRESS OF SVC 8                                      
                                    2218         LOADERC                                                                             
                                    2219+*                                                                                           
                                    2220+* LOADERC READS USING SVC 0 WITH AN IOB TO READ FROM DEVICE X'000C'                         
                                    2221+*                                                                                           
 007300 4120616441A060C8            2222+ DC X'4120616441A060C805CA95026114477060C2D5026115617C477060C29500612C'                     
 007320 477060C2D202610D            2223+ DC X'477060C2D202610D612DD2026111613105CA950261144770'                                     
 007338 60C2D5026115617C            2224+ DC X'60C2D5026115617C47806030D5026115617F477060C21B77BF77611959006178'                     
 007358 4780606418B01BB7            2225+ DC X'4780606418B01BB747F060661BBB1A7B507061041B991B77'                                     
 007370 BF7761191A7B1B88            2226+ DC X'BF7761191A7B1B88BF83611E1288478060C21A98509061080680448060FE05CA'                     
 007390 95026114477060C2            2227+ DC X'95026114477060C2D5026115617F4780606ED50261156182'                                     
 0073A8 4780608ED5026115            2228+ DC X'4780608ED50261156185477060C29801610445C0618C1BFF07FE41F0000407FE'                     
 0073C8 18120A0012FF4770            2229+ DC X'18120A0012FF477060C213FF07FC011940C5D5C440D6C640'                                     
 0073E0 C6C9D3C540C8C9E3            2230+ DC X'C6C9D3C540C8C9E340C9D540D3D6C1C440E2E5C340606040C2C1C45A5A40D200'                     
1       SVC 2                                                                                                   PAGE   39            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 007400 70006124FFFFFFFF            2231+ DC X'70006124FFFFFFFFFFFFFFFF00FFFFFF00FFFFFF40C2E4C6'                                     
 007418 C6C5D940E4E2C5C4            2232+ DC X'C6C5D940E4E2C5C440C2E840E2E5C340F8404DD3D6C1C45D4040404040404040'                     
 007438 4040404040404040            2233+ DC X'404040404040404040404040404040404040404040404040'                                     
 007450 4040404040404040            2234+ DC X'4040404040404040404040404040404040404040C9D6C2F8000C020000007414'                     
 007470 00500000D3E3D9C7            2235+ DC X'00500000D3E3D9C7FFFFFFFFC5E2C4E3E7E3D9D3C4C5D5C4'                                     
 007488 40404040D5026119            2236+ DC X'40404040D50261196188078CBF0761191A0B07FC'                                             
1       SVC 13                                                                                                  PAGE   40            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2238 **********************************************************************                      
                                    2239 * SVC 13 -- Type 4 -- ABEND                                                                 
                                    2240 *                                                                                           
                                    2241 * Entry:  R1 = Hit 0,1 Flag Byte: Bit 0 in R1 = 1, calls for a Dump.                        
                                    2242 *              Hit 2,3,4 System ABEND Code (three hex. digits)                              
                                    2243 *              Hit 5,6,7 User ABEND Code (trans. to 4 dec. digits)                          
                                    2244 *         R3 - A(CVT)                                                                       
                                    2245 *         R4 - A(TCB)                                                                       
                                    2246 *         R5 - A(RB)                                                                        
                                    2247 *         R6 - A(SVC13)                                                                     
                                    2248 *         R10 - Addressability to RB containing the PSW                                     
                                    2249 *         R13 - A(SVC 13 Save Area)                                                         
                                    2250 * Exit:   None                                                                              
                                    2251 *                                                                                           
                                    2252 * Register Usage:                                                                           
                                    2253 * R1  - Used for LOUNTR calls                                                               
                                    2254 * R2  - Return address from LOUNTR                                                          
                                    2255 * R3,4,5,6 - Same old stuff                                                                 
                                    2256 * R7  -                                                                                     
                                    2257 * R8  -                                                                                     
                                    2258 * R9  -                                                                                     
                                    2259 * R10 -                                                                                     
                                    2260 * R12 - Return address from Print routine                                                   
                                    2261 * R13 - Save aread address for entry to SVC 13 Print Routine                                
                                    2262 * R14 - Return address from SVC 13                                                          
                                    2263 * R15 - Used for branching into print routine                                               
                                    2264 *                                                                                           
                                    2265 *                                                                                           
                                    2266 **********************************************************************                      
                                    2267 *                                                                                           
 008000                             2268          ORG FIRST4K+X'8000'          Start SVC13 at X'8000'                                
 008000                             2269          USING SVC13,6                Establish SVC 13 Addressability                       
 000000                             2270          USING CVT,3                  Establish CVT addressability                          
 000000                             2271          USING RB,5                   Establish RB Addressability                           
                                    2272 SVC13    GETCB100                                                                           
                                    2273+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 008000 58B0 3018            00018  2274+SVC13    L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 008004 58AB 0000            00000  2275+         L     10,0(11)           Load Address of next CB.                                  
 008008 12AA                        2276+         LTR   10,10              Make sure a CB is available.                              
 00800A 4770 6024            08024  2277+         BNZ   GTCB0013           To MVC if there is a CB.                                  
 00800E 0119                        2278+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 008010 C3C2F1F0F040D7D6            2279+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 008024 D203 B000 A000 00000 00000  2280+GTCB0013    MVC 0(4,11),0(10)           Update header.                                      
 00802A 18BA                        2281          LR    11,10                   Get A(CB) into R11                                   
 000000                             2282          USING SVC13S,11               SVC13 storage addressability                         
 00802C D7FF B000 B000 00000 00000  2283          XC    0(CB100LTH,11),0(11)    Clear the CB100                                      
 008032 D201 B020 62AC 00020 082AC  2284          MVC   RETLNTR(2),LNTREND      Put '07F2' after LOUNTR                              
                                    2285 *                                                                                           
                                    2286 * Set up the IOB and the parm list                                                          
                                    2287 *                                                                                           
 008038 D206 B000 62AE 00000 082AE  2288          MVC   IOBSVC13(7),IOBINI     Set up the IOB in storage                             
 00803E 4170 B072            00072  2289          LA    7,SVC13BUF             Get address of line buffer                            
 008042 5070 B024            00024  2290          ST    7,PARM1                Save address of line buffer                           
 008046 4170 0085            00085  2291          LA    7,133                  Get length of line buffer                             
 00804A 5070 B070            00070  2292          ST    7,PLINEL               Save length of line buffer                            
 00804E 4170 B070            00070  2293          LA    7,PLINEL               Get address of length                                 
 008052 5070 B028            00028  2294          ST    7,PARM2                Save A(length) to parm list                           
1       SVC 13                                                                                                  PAGE   41            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 008056 4170 B000            00000  2295          LA    7,IOBSVC13             Get IOB address                                       
 00805A 5070 B02C            0002C  2296          ST    7,PARM3                Save to parm list                                     
                                    2297 *                                                                                           
                                    2298 * Set the contents of R1 print line                                                         
                                    2299 *                                                                                           
 00805E BE1F B01C            0001C  2300          STCM  1,15,SVC13WRK+12       Put R1 in LOUNTR work area                            
 008062 4110 B010            00010  2301          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 008066 4520 07E0            007E0  2302          BAL   2,LOUNTR               Translate it                                          
 00806A 9240 B072      00072        2303          MVI   R1MSG,C' '             Blank first byte                                      
 00806E D283 B073 B072 00073 00072  2304          MVC   R1MSG+1(132),R1MSG     Ripple the byte blanking pline                        
 008074 D20F B072 6278 00072 08278  2305          MVC   R1MSG(16),R1MSG1       Copy title message to print line                      
 00807A D207 B083 B010 00083 00010  2306          MVC   R1VAL(8),SVC13WRK      Put Result on print line                              
                                    2307 *                                                                                           
                                    2308 * Print the R1 print line                                                                   
                                    2309 *                                                                                           
 008080 41D0 B030            00030  2310          LA    13,SASVC13             Save area address                                     
 008084 4110 B024            00024  2311          LA    1,PARM1                Get Parm area address                                 
 008088 41F0 62C0            082C0  2312          LA    15,SVC13PRN            Get address of print routine                          
 00808C 05CF                        2313          BALR  12,15                  Print R1 Message                                      
                                    2314 *                                                                                           
                                    2315 * Put the PSW at ABEND on print line                                                        
                                    2316 *                                                                                           
 00808E 9240 B072      00072        2317          MVI   PSWMSG,C' '            Blank first byte                                      
 008092 D283 B073 B072 00073 00072  2318          MVC   PSWMSG+1(132),PSWMSG   Ripple the blank                                      
 008098 D214 B072 6288 00072 08288  2319          MVC   PSWMSG(21),PSWMSG1     Move in title                                         
 00809E 17AA                        2320          XR    10,10                  clear R10 for insertion                               
 0080A0 BFA7 501D            0001D  2321          ICM   10,7,RBLINK+1          Get A(RB) containing PSW                              
 0080A4                             2322          DROP  5                      Done with the current RB                              
 000000                             2323          USING RB,10                  Refer to RB containing PSW                            
                                    2324 *                                                                                           
 0080A4 4170 0002            00002  2325          LA    7,2                    Do this two times                                     
 0080A8 4180 A010            00010  2326          LA    8,RBOPSW               Get A(the PSW)                                        
 0080AC 4190 B08B            0008B  2327          LA    9,PSWP1                Get place to move PSW part                            
 0080B0 D203 B01C 8000 0001C 00000  2328 PSWLOOP  MVC   SVC13WRK+12(4),0(8)    Get 4 bytes of PSW                                    
 0080B6 4110 B010            00010  2329          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 0080BA 4520 07E0            007E0  2330          BAL   2,LOUNTR               Translate it                                          
 0080BE D207 9000 B010 00000 00010  2331          MVC   0(8,9),SVC13WRK        Move 8 bytes                                          
 0080C4 4190 900B            0000B  2332          LA    9,11(,9)               Move to next part in pline                            
 0080C8 4180 8004            00004  2333          LA    8,4(,8)                Move to next part of PSW                              
 0080CC 4670 60B0            080B0  2334          BCT   7,PSWLOOP              One more time...                                      
                                    2335 *                                                                                           
                                    2336 * Print the PSW Pline                                                                       
                                    2337 *                                                                                           
 0080D0 4110 B024            00024  2338          LA    1,PARM1                Get @ Parm List                                       
 0080D4 05CF                        2339          BALR  12,15                  Print PSW Message                                     
                                    2340 *                                                                                           
                                    2341 * Set up 12 bytes of Data pointed to by the PSW                                             
                                    2342 *                                                                                           
 0080D6 1777                        2343          XR    7,7                    clear R7 for inserting address                        
 0080D8 BF77 A015            00015  2344          ICM   7,7,RBOPSW+5           grab addr. from PSW                                   
 0080DC                             2345          DROP  10                     Done with PRB                                         
                                    2346 *                                                                                           
                                    2347 * Make sure address is in the proper range                                                  
                                    2348 *                                                                                           
 0080DC 9240 B072      00072        2349          MVI   DMSG,C' '              Blank first byte                                      
 0080E0 D283 B073 B072 00073 00072  2350          MVC   DMSG+1(132),DMSG       Ripple the blank clearing pline                       
 0080E6 D20C B072 629E 00072 0829E  2351          MVC   DMSG(13),DATAMSG1      Put data at PSW MSG on pline                          
1       SVC 13                                                                                                  PAGE   42            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0080EC 9260 B08D      0008D        2352          MVI   DMSDASH,C'-'           Insert the hyphen                                     
 0080F0 5B70 62B8            082B8  2353          S     7,SIX                  Step back six bytes                                   
 0080F4 4720 60FC            080FC  2354          BP    HICHECK                If positive, perform check 2                          
 0080F8 4170 0000            00000  2355          LA    7,0                    Otherwise start print address 0                       
 0080FC 1897                        2356 HICHECK  LR    9,7                    Get address into R9                                   
 0080FE 4190 900C            0000C  2357          LA    9,12(,9)               Move to end of printable area                         
 008102 5990 3058            00058  2358          C     9,CVTMZ00              Check not beyond CVTMZ00                              
 008106 47D0 6112            08112  2359          BNH   PRINTBTS               Ok, print the bytes                                   
 00810A 5870 3058            00058  2360          L     7,CVTMZ00              Otherwise, get highest address                        
 00810E 4A70 62BC            082BC  2361          AH    7,NEG12                Subtract 12 bytes                                     
                                    2362 *                                                                                           
 008112 BE7F B01C            0001C  2363 PRINTBTS STCM  7,15,SVC13WRK+12       Put address into LOUNTR                               
 008116 4110 B010            00010  2364          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 00811A 4520 07E0            007E0  2365          BAL   2,LOUNTR               Translate it                                          
 00811E D207 B084 B010 00084 00010  2366          MVC   DAADDR(8),SVC13WRK     Put data area address on pline                        
                                    2367 *                                                                                           
 008124 4190 0003            00003  2368          LA    9,3                    Loop 3 times                                          
 008128 41A0 B08F            0008F  2369          LA    10,DBYTES1             Get starting addr of data bytes                       
 00812C D203 B01C 7000 0001C 00000  2370 GETBLOOP MVC   SVC13WRK+12(4),0(7)    Get bytes at location in R7                           
 008132 4110 B010            00010  2371          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 008136 4520 07E0            007E0  2372          BAL   2,LOUNTR               Translate it                                          
 00813A D207 A000 B010 00000 00010  2373          MVC   0(8,10),SVC13WRK       Move bytes from storage to pline                      
 008140 41A0 A00A            0000A  2374          LA    10,10(,10)             Move to next pos in pline                             
 008144 4170 7004            00004  2375          LA    7,4(,7)                Move to next area in storage                          
 008148 4690 612C            0812C  2376          BCT   9,GETBLOOP             Decrement and loop                                    
                                    2377 *                                                                                           
                                    2378 * Print the 'Data at PSW' Pline                                                             
                                    2379 *                                                                                           
 00814C 4110 B024            00024  2380          LA    1,PARM1                Parm list address                                     
 008150 05CF                        2381          BALR  12,15                  Print DMSG                                            
                                    2382 *                                                                                           
                                    2383 * Set up the General Purpose Registers print line 1                                         
                                    2384 *                                                                                           
 008152 9240 B072      00072        2385          MVI   GPRMSG,C' '            Blank print line                                      
 008156 D283 B073 B072 00073 00072  2386          MVC   GPRMSG+1(132),GPRMSG   Blank print line                                      
 00815C D209 B072 6252 00072 08252  2387          MVC   GPRMSG(10),GPMSG1      Put 'GPRs 0-7' on print line                          
 000000                             2388          USING RB,5                   Addr. on SVRB                                         
 008162 4180 0004            00004  2389          LA    8,4                    Increment of 4                                        
 008166 4190 503C            0003C  2390          LA    9,RBGRSAVE+7*4         Limit Register is R9                                  
 00816A 41A0 B084            00084  2391          LA    10,GPL1STRT            Starting point for 0-7 in pline                       
 00816E 4170 5020            00020  2392          LA    7,RBGRSAVE             Get starting point of GPRS                            
 008172 D203 B01C 7000 0001C 00000  2393 GRSTART  MVC   SVC13WRK+12(4),0(7)    Get Reg value into LOUNTR area                        
 008178 4110 B010            00010  2394          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 00817C 4520 07E0            007E0  2395          BAL   2,LOUNTR               Translate it                                          
 008180 D207 A000 B010 00000 00010  2396          MVC   0(8,10),SVC13WRK       Put translated reg in storage                         
 008186 41A0 A009            00009  2397          LA    10,9(,10)              Move to next reg in pline                             
 00818A 8778 6172            08172  2398          BXLE  7,8,GRSTART            Increment and loop                                    
                                    2399 *                                                                                           
                                    2400 * Print first line of GPRs                                                                  
                                    2401 *                                                                                           
 00818E 4110 B024            00024  2402          LA    1,PARM1                Get parm list address                                 
 008192 05CF                        2403          BALR  12,15                  Print the message                                     
                                    2404 *                                                                                           
                                    2405 * Set up the second line of GPRs                                                            
                                    2406 *                                                                                           
 008194 9240 B072      00072        2407          MVI   GPRMSG,C' '            Blank print line                                      
 008198 D283 B073 B072 00073 00072  2408          MVC   GPRMSG+1(132),GPRMSG   Blank print line                                      
1       SVC 13                                                                                                  PAGE   43            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 00819E D209 B072 625C 00072 0825C  2409          MVC   GPRMSG(10),GPMSG2      Put 'GPRs 8-15' on print line                         
 0081A4 4180 0004            00004  2410          LA    8,4                    Increment of 4                                        
 0081A8 4190 505C            0005C  2411          LA    9,RBGRSAVE+15*4        Limit Register is R9                                  
 0081AC 41A0 B084            00084  2412          LA    10,GPL1STRT            Starting point for 0-7 in pline                       
 0081B0 4170 5040            00040  2413          LA    7,RBGRSAVE+8*4         Get start of GPRS in RB                               
 0081B4 D203 B01C 7000 0001C 00000  2414 GR2START MVC   SVC13WRK+12(4),0(7)    Get Reg value into LOUNTR area                        
 0081BA 4110 B010            00010  2415          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 0081BE 4520 07E0            007E0  2416          BAL   2,LOUNTR               Translate it                                          
 0081C2 D207 A000 B010 00000 00010  2417          MVC   0(8,10),SVC13WRK       Put translated reg in storage                         
 0081C8 41A0 A009            00009  2418          LA    10,9(,10)              Move to next reg in pline                             
 0081CC 8778 61B4            081B4  2419          BXLE  7,8,GR2START           Increment and loop                                    
                                    2420 *                                                                                           
                                    2421 * Print the second line of GPRs                                                             
                                    2422 *                                                                                           
 0081D0 4110 B024            00024  2423          LA    1,PARM1                Get @Parm list                                        
 0081D4 D209 B072 625C 00072 0825C  2424          MVC   GPRMSG(10),GPMSG2      Put 'GPRs 8-15' on pline                              
 0081DA 05CF                        2425          BALR  12,15                  Print the message                                     
                                    2426 *                                                                                           
                                    2427 * Set up the Floating Point Registers on pline                                              
                                    2428 *                                                                                           
 0081DC 9240 B072      00072        2429          MVI   FPRPLIN,C' '           Clear the FPR Pline                                   
 0081E0 D283 B073 B072 00073 00072  2430          MVC   FPRPLIN+1(132),FPRPLIN Clear the FPR Pline                                   
 0081E6 D211 B072 6266 00072 08266  2431          MVC   FPRPLIN(18),FPRMSG     Put FPR message on pline                              
                                    2432 *                                                                                           
 0081EC 4180 0004            00004  2433          LA    8,4                    Increment of 4                                        
 0081F0 4190 5078            00078  2434          LA    9,RBFRSAVE+3*8         Limit Register R9                                     
 0081F4 41A0 B084            00084  2435          LA    10,FPR0STRT            Place to store regs on pline                          
 0081F8 4170 5060            00060  2436          LA    7,RBFRSAVE             Get starting point of FPRs                            
 0081FC D203 B01C 7000 0001C 00000  2437 FPRSTART MVC   SVC13WRK+12(4),0(7)    Get part of an FPR into LOUNTR                        
 008202 4110 B010            00010  2438          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 008206 4520 07E0            007E0  2439          BAL   2,LOUNTR               Translate it                                          
 00820A D207 A000 B010 00000 00010  2440          MVC   0(8,10),SVC13WRK       Move translated stuff                                 
 008210 41A0 A008            00008  2441          LA    10,8(,10)              Move to next FPR on pline                             
 008214 4178 7000            00000  2442          LA    7,0(8,7)               Increment R7 by 4                                     
 008218 D203 B01C 7000 0001C 00000  2443          MVC   SVC13WRK+12(4),0(7)    Get 2nd part of FPR into LOUNTR                       
 00821E 4110 B010            00010  2444          LA    1,SVC13WRK             Get @ LOUNTR work area                                
 008222 4520 07E0            007E0  2445          BAL   2,LOUNTR               Translate part 2                                      
 008226 D207 A000 B010 00000 00010  2446          MVC   0(8,10),SVC13WRK       Move translated stuff                                 
 00822C 41A0 A00A            0000A  2447          LA    10,10(,10)             Move to next FPR on pline                             
 008230 8778 61FC            081FC  2448          BXLE  7,8,FPRSTART           Increment and Loop                                    
                                    2449 *                                                                                           
                                    2450 *   Print the FPR pline                                                                     
                                    2451 *                                                                                           
 008234 4110 B024            00024  2452          LA    1,PARM1                Get parm list address                                 
 008238 05CF                        2453          BALR  12,15                  Print the line                                        
                                    2454 *                                                                                           
                                    2455 * Chain through all RBs pointing their PSWs at CVTEXIT                                      
                                    2456 *                                                                                           
 00823A 4170 3050            00050  2457          LA    7,CVTEXIT              Get address of SVC Exit                               
 00823E BE77 5015            00015  2458 RBLOOP1  STCM  7,7,RBOPSW+5           Save it into the RB                                   
 008242 BF57 501D            0001D  2459          ICM   5,7,RBLINK+1           Move to next RB                                       
 008246 1954                        2460          CR    5,4                    Check for end of RB chain                             
 008248 4780 6250            08250  2461          BE    SVC13END               If it is, end SVC 13                                  
 00824C 47F0 623E            0823E  2462          B     RBLOOP1                If not encountered, continue                          
 008250 07FE                        2463 SVC13END BR    14                     END OF SVC 13                                         
 008252                             2464          DROP 3,5,6,11                Done with routine addressability                      
                                    2465 **********************************************************************                      
1       SVC 13                                                                                                  PAGE   44            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2466 * SVC 13 NON-MODIFIED STORAGE                                                               
                                    2467 **********************************************************************                      
                                    2468 *                                                                                           
 008252 F0C7D7D940F060F7            2469 GPMSG1   DC CL10'0GPR 0-7  '          GPR 0-7 MESSAGES                                      
 00825C F0C7D7D940F860F1            2470 GPMSG2   DC CL10'0GPR 8-15 '          GPR 8-15 MESSAGES                                     
 008266 F0C6D7D9A240F06B            2471 FPRMSG   DC CL18'0FPRs 0,2,4,6:    '  FPR 0,2,4,6 MESSAGE                                   
 008278 F0C3D6D5E3C5D5E3            2472 R1MSG1   DC CL16'0CONTENTS OF R1: '      R1 Message                                         
 008288 F0D7E2E640C1E340            2473 PSWMSG1  DC CL21'0PSW AT TIME OF ERROR ' PSW Message                                        
 00829D 60                          2474 PSWDASH  DC C'-'                      Dash for PSW Message                                  
 00829E F0C4C1E3C140C1E3            2475 DATAMSG1 DC CL13'0DATA AT PSW:'       Data Message                                          
 0082AC 07F2                        2476 LNTREND  BR 2                         Return from LOUNTR                                    
 0082AE C9D6C2E6                    2477 IOBINI   DC CL4'IOBW'                 For definiing IOB                                     
 0082B2 000F                        2478          DC XL2'000F'                 For defining IOB                                      
 0082B4 01                          2479          DC X'01'                     For defining IOB                                      
                                    2480 *                                                                                           
 0082B8 00000006                    2481 SIX      DC F'6'                      Value of 6                                            
 0082BC FFFFFFF4                    2482 NEG12    DC F'-12'                    Value of -12                                          
                                    2483 *                                                                                           
                                    2484 *********************************************************************                       
                                    2485 * SVC 13 PRINT ROUTINE                                                                      
                                    2486 *                                                                                           
                                    2487 * ON ENTRY:                                                                                 
                                    2488 *                                                                                           
                                    2489 * R1  - A(PARAMETER LIST)                                                                   
                                    2490 *          0(R1) = A(print buffer)                                                          
                                    2491 *          4(R1) = A(halfword buffer length)                                                
                                    2492 *          8(R1) = A(IOB)                                                                   
                                    2493 * R12 - Address to return to                                                                
                                    2494 * R13 - Address of 16F Save area                                                            
                                    2495 * R15 - Routine Base register, A(SVC13PRN)                                                  
                                    2496 *                                                                                           
                                    2497 * REGISTER USAGE:                                                                           
                                    2498 *                                                                                           
                                    2499 * R1  - PARAMETER LIST ON ENTRY                                                             
                                    2500 *       ADDRESS OF IOB FOR SVC 0                                                            
                                    2501 * R12 - Return address                                                                      
                                    2502 *                                                                                           
                                    2503 **********************************************************************                      
                                    2504 *                                                                                           
 0082C0                             2505          USING SVC13PRN,15            Use R15 as base reg                                   
 0082C0 900F D000            00000  2506 SVC13PRN STM   0,15,0(13)             Save registers for return                             
 0082C4 9846 1000            00000  2507          LM    4,6,0(1)               Get Buffer address                                    
 0082C8 4850 5000            00000  2508          LH    5,0(,5)                Get halfword length                                   
 0082CC 5040 6008            00008  2509          ST    4,8(,6)                Save buff @ to IOB                                    
 0082D0 4050 600C            0000C  2510          STH   5,12(,6)               Save buff len to IOB                                  
 0082D4 1816                        2511          LR    1,6                    Get IOB address for SVC 0                             
 0082D6 0104                        2512          XOPC  4                      Turn off trace                                        
 0082D8 0A00                        2513          SVC   0                      Call SVC 0 to print                                   
 0082DA 0102                        2514          XOPC  2                      Turn on trace                                         
 0082DC 12FF                        2515          LTR   15,15                  Check return code                                     
 0082DE 4770 F028            082E8  2516          BNZ   PRN0119                Die if it's not zero                                  
 0082E2 980F D000            00000  2517          LM    0,15,0(13)             Restore registers                                     
 0082E6 07FC                        2518          BR    12                     Leave SVC13PRN                                        
 0082E8 0119                        2519 PRN0119  XOPC  25                     Die if RC != 0                                        
 0082EA                             2520          DROP  15                     End of routine addressability                         
1       SVC 13                                                                                                  PAGE   45            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2522 *                                                                                           
                                    2523 **********************************************************************                      
                                    2524 * SVC 14 - Type 3 (SPIE -- Specify Program Interrupt Exit)                                  
                                    2525 * On Entry:                                                                                 
                                    2526 * R1  = A(PICA)                                                                             
                                    2527 * R3  = A(CVT)                                                                              
                                    2528 * R4  = A(TCB)                                                                              
                                    2529 * R5  = A(RB)                                                                               
                                    2530 * R6  = A(SVC14)                                                                            
                                    2531 * R14 = Exit Address                                                                        
                                    2532 *                                                                                           
                                    2533 * On Exit:                                                                                  
                                    2534 * R1 = A(previous PICA) or 0 if no previous PICA                                            
                                    2535 *                                                                                           
                                    2536 * Working Registers:                                                                        
                                    2537 * R7 - Used for testing A(EXIT)                                                             
                                    2538 * R8 - Used for testing SOC1-SOCF flags                                                     
                                    2539 * R9 - Holds TCBPIE                                                                         
                                    2540 * R10 - Test TCBDMSCA in CREATE                                                             
                                    2541 * R11 - Address of the PIE                                                                  
                                    2542 **********************************************************************                      
                                    2543 *                                                                                           
 0082EA                             2544          USING  SVC14,6               Establish SVC14 Addressability                        
 000000                             2545          USING  TCB,4                 Establish TCB Addressability                          
 000000                             2546          USING  RB,5                  Establish RB Addressability                           
 0082EA 1211                        2547 SVC14    LTR    1,1                   Check for A(PICA) in R1                               
 0082EC 4780 60C0            083AA  2548          BZ     CORI                  If none, cancel/ignore SPIE                           
 0082F0 1777                        2549          XR     7,7                   Clear R7 for testing                                  
 0082F2 BF77 1001            00001  2550          ICM    7,7,1(1)              Get A(EXIT)                                           
 0082F6 1277                        2551          LTR    7,7                   Check if it's zero                                    
 0082F8 4780 60C0            083AA  2552          BZ     CORI                  If it is, cancel/ignore the SPIE                      
 0082FC 9180 1004      00004        2553          TM     4(1),X'80'            Check first bit in PICA Flags                         
 008300 4770 60FE            083E8  2554          BNZ    SVCE0119              If it is set, die                                     
 008304 1788                        2555          XR     8,8                   Clear 8                                               
 008306 BF83 1004            00004  2556          ICM    8,3,4(1)              Get Flags for SOC1-SOCF in PICA                       
 00830A 1288                        2557          LTR    8,8                   Check if it's zero                                    
 00830C 4780 60C0            083AA  2558          BZ     CORI                  If it is, cancel/ignore the SPIE                      
                                    2559 *                                                                                           
                                    2560 * Otherwise, create or modify a SPIE                                                        
                                    2561 * First check if TCBPIE = 0 (First step going through chain)                                
                                    2562 *                                                                                           
 008310 5890 4004            00004  2563          L      9,TCBPIE              Get TCBPIE field                                      
 008314 1299                        2564          LTR    9,9                   Check if it's zero                                    
 008316 4780 6084            0836E  2565          BZ     CREATE                If it's not, cancel SPIE                              
                                    2566 **********************************************************************                      
                                    2567 * MODIFY THE EXISTING SPIE                                                                  
                                    2568 *                                                                                           
                                    2569 * 1) Check TCBPIE is non-zero. If not, die. <taken care of above >                          
                                    2570 * 2) Check TCBPIE contains address of SCA.  < ignored >                                     
                                    2571 * 3) Check SCA is non-zero.                                                                 
                                    2572 * 4) Check SCA contains address of the PIE.                                                 
                                    2573 * 5) Check SCA bit 0 is 0.                                                                  
                                    2574 * 6) Check that PIE is non-zero.                                                            
                                    2575 * 7) Check that PIE contains address of the PICA                                            
                                    2576 * 8) Check that bit 0 of the PIE is zero                                                    
                                    2577 * 9) Save address of old PICA                                                               
                                    2578 * 10) Save address of new PICA to PIE+1                                                     
1       SVC 13                                                                                                  PAGE   46            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2579 * 11) Put program mask from new PICA into PRB PSW                                           
                                    2580 *                                                                                           
                                    2581 * R9  - Address taken from TCBPIE (address of SCA)                                          
                                    2582 * R10 - Address of the SCA                                                                  
                                    2583 * R11 - A(PIE) from TCBAPIE                                                                 
                                    2584 * R12 - A(PICA) from the PIE                                                                
                                    2585 *                                                                                           
                                    2586 *********************************************************************                       
 00831A 58A0 4078            00078  2587 MODIFY   L     10,TCBDMSCA            Get SCA                                               
 00831E 12AA                        2588          LTR   10,10                  Test if it's zero                                     
 008320 4780 60FE            083E8  2589          BZ    SVCE0119               If it is, die!!                                       
 008324 1799                        2590          XR    9,9                    Clear 9                                               
 008326 BF97 4005            00005  2591          ICM   9,X'7',TCBPIE+1        Get A(SCA) from TCBPIE                                
 00832A 41A0 4078            00078  2592          LA    10,TCBDMSCA            Get address of SCA                                    
 00832E 199A                        2593          CR    9,10                   Comp A(SCA) to addr frm TCBPIE                        
 008330 4770 60FE            083E8  2594          BNE   SVCE0119               Not equal? Then Die!!                                 
 008334 9180 A000      00000        2595          TM    0(10),X'80'            Check bit 0 of the SCA                                
 008338 4770 60FE            083E8  2596          BNZ   SVCE0119               If it's not a zero, then die!!                        
 00833C 58B0 4080            00080  2597          L     11,TCBAPIE             Get A(PIE)                                            
 008340 D51F 6100 B000 083EA 00000  2598          CLC   PIETEST(32),0(11)      Check PIE=0                                           
 008346 4780 60FE            083E8  2599          BE    SVCE0119               If PIE=0 then die                                     
 00834A 9180 B000      00000        2600          TM    0(11),X'80'            If bit 1 Pie set                                      
 00834E 4770 60FE            083E8  2601          BNZ   SVCE0119               Then Die                                              
                                    2602 *                                                                                           
                                    2603 * Start of Modification                                                                     
                                    2604 *                                                                                           
 008352 17CC                        2605          XR    12,12                  Clear R12                                             
 008354 BFC7 B001            00001  2606          ICM   12,X'7',1(11)          Get address of PICA from PIE                          
 008358 BE17 B001            00001  2607          STCM  1,X'7',1(11)           Save addr of new PICA to PIE+1                        
 00835C 9200 B000      00000        2608          MVI   0(11),X'00'            Set PIE+0 to zero                                     
 008360 58A0 501C            0001C  2609          L     10,RBLINK              Get A(PRB)                                            
 008364                             2610          DROP  5                      Stop working with SVRB                                
 000000                             2611          USING RB,10                  Work with PRB                                         
 008364 D100 A014 1000 00014 00000  2612          MVN   RBOPSW+4(1),0(1)       Set program mask from new PICA                        
 00836A                             2613          DROP  10                     Done with PRB                                         
 000000                             2614          USING RB,5                   work wth SVRB again                                   
 00836A 181C                        2615          LR    1,12                   Set R1 to address of old PICA                         
 00836C 07FE                        2616          BR    14                     Exit SVC 14                                           
                                    2617 *                                                                                           
                                    2618 *********************************************************************                       
                                    2619 * CREATE THE SPIE ENVIRONMENT                                                               
                                    2620 * Entry:                                                                                    
                                    2621 * R1 = A(PICA)                                                                              
                                    2622 * R9 = Zero because TCBPIE does not exist                                                   
                                    2623 *                                                                                           
                                    2624 * Working:                                                                                  
                                    2625 * R10                                                                                       
                                    2626 * R11 - Address of the PIE                                                                  
                                    2627 *                                                                                           
                                    2628 *                                                                                           
                                    2629 * 1) Check if TCBDMSCA is zero. If not, XOPC 25                                             
                                    2630 * 2) Put address of SCA into TCBPIE+1                                                       
                                    2631 * 3) Put address of the PIE into SCA+1                                                      
                                    2632 * 4) Put address of PICA into PIE+1                                                         
                                    2633 * 5) Save current program mask to TCBPIE+0                                                  
                                    2634 * 6) Put new program mask from PICA+0 into RBOPSW                                           
                                    2635 *                                                                                           
1       SVC 13                                                                                                  PAGE   47            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2636 *********************************************************************                       
 00836E 58A0 4078            00078  2637 CREATE   L     10,TCBDMSCA            get TCBDMSCA                                          
 008372 12AA                        2638          LTR   10,10                  See if it's zero                                      
 008374 4770 60FE            083E8  2639          BNZ   SVCE0119               If not, die                                           
 008378 41A0 4078            00078  2640          LA    10,TCBDMSCA            get A(TCBDMSCA)                                       
 00837C BEA7 4005            00005  2641          STCM  10,X'7',TCBPIE+1       Put A(SCA) into TCBPIE+1                              
 008380 D202 A001 4081 00001 00081  2642          MVC   1(3,10),TCBAPIE+1      Put A(PIE) into SCA+1                                 
 008386 9200 A000      00000        2643          MVI   0(10),X'00'            Set SCA+0 to X'00'                                    
 00838A 58B0 4080            00080  2644          L     11,TCBAPIE             Get address of the PIE                                
 00838E BE17 B001            00001  2645          STCM  1,X'7',1(11)           Save address of PICA into PIE+1                       
 008392 9200 B000      00000        2646          MVI   0(11),X'00'            Set PIE+0 to X'00'                                    
 008396 58A0 501C            0001C  2647          L     10,RBLINK              Get A(PRB)                                            
 00839A                             2648          DROP  5                      Leave SVRB alone                                      
 000000                             2649          USING RB,10                  Work with the PRB                                     
 00839A D100 4004 A014 00004 00014  2650          MVN   TCBPIE(1),RBOPSW+4     Save current program mask                             
 0083A0 D100 A014 1000 00014 00000  2651          MVN   RBOPSW+4(1),0(1)       Set new program mask                                  
 0083A6                             2652          DROP  10                     Done with PRB                                         
 0083A6 1711                        2653          XR    1,1                    Set RC=0 for no prev SPIE                             
 0083A8 07FE                        2654          BR    14                     Return from SVC 14                                    
                                    2655 **********************************************************************                      
                                    2656 * CANCEL/IGNORE SPIE ENVIRONMENT                                                            
                                    2657 **********************************************************************                      
 0083AA 5890 4004            00004  2658 CORI     L     9,TCBPIE               Get TCBPIE                                            
 0083AE 1299                        2659          LTR   9,9                    Check if TCBPIE=0                                     
 0083B0 4770 60CE            083B8  2660          BNZ   CANCEL                 If not, cancel the SPIE env                           
 0083B4 1711                        2661          XR    1,1                    Set R1 to 0                                           
 0083B6 07FE                        2662          BR    14                     Return from SVC 14                                    
                                    2663 *                                                                                           
                                    2664 **********************************************************************                      
                                    2665 * CANCEL THE SPIE ENVIRONMENT                                                               
                                    2666 *                                                                                           
                                    2667 * Entry:                                                                                    
                                    2668 * R9 points to the SCA                                                                      
                                    2669 *                                                                                           
                                    2670 * 1) Set the saved PSW mask to the PRB PSW                                                  
                                    2671 * 2) Get A(SCA) from TCBPIE and set TCBPIE to zero                                          
                                    2672 * 3) Get A(PIE) from the SCA and clear the SCA                                              
                                    2673 * 4) Save address of the PICA and zero first 4 bytes of the PIE                             
                                    2674 * 5) Put address of the PICA into R1 for return from SVC 14                                 
                                    2675 *********************************************************************                       
                                    2676 *                                                                                           
 000000                             2677          USING RB,5                   Work with SVRB                                        
 0083B8 1799                        2678 CANCEL   XR    9,9                    Clear R9                                              
 0083BA BF97 4005            00005  2679          ICM   9,X'7',TCBPIE+1        Get A(SCA)                                            
 0083BE 58B0 501C            0001C  2680          L     11,RBLINK              Get A(PRB)                                            
 0083C2                             2681          DROP  5                      Done with SVRB                                        
 000000                             2682          USING RB,11                  Update PRB                                            
 0083C2 D100 B014 4004 00014 00004  2683          MVN   RBOPSW+4(1),TCBPIE+0   Move saved PSW Mask                                   
 0083C8                             2684          DROP  11                     Done with PRB                                         
 0083C8 D703 4004 4004 00004 00004  2685          XC    TCBPIE(4),TCBPIE       Clear TCBPIE to zero                                  
 0083CE BFA7 9001            00001  2686          ICM   10,X'7',1(9)           Get A(PIE) from SCA                                   
 0083D2 D703 9000 9000 00000 00000  2687          XC    0(4,9),0(9)            Clear the SCA                                         
 0083D8 17CC                        2688          XR    12,12                  Clear 12                                              
 0083DA BFC7 A001            00001  2689          ICM   12,X'7',1(10)          Get A(PICA)                                           
 0083DE D703 A000 A000 00000 00000  2690          XC    0(4,10),0(10)          Clear first 4 bytes of PIE                            
 0083E4 181C                        2691          LR    1,12                   Put A(Old PICA) into R1                               
 0083E6 07FE                        2692          BR    14                     Exit SVC14                                            
1       SVC 13                                                                                                  PAGE   48            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0083E8 0119                        2693 SVCE0119 XOPC  25                     Die if something goes bad                             
 0083EA                             2694          DROP  4,6                    Done with TCB, SVC Addr                               
                                    2695 ***************************************************************                             
                                    2696 * SVC 14 WORKING STORAGE                                                                    
                                    2697 ***************************************************************                             
 0083EA 0000000000000000            2698 PIETEST DC     32XL1'00'     For testing PIE=0                                              
                                    2699 *                                                                                           
                                    2700 ****************************************                                                    
                                    2701 * CONTROL BLOCKS OBTAINED DYNAMICALLY                                                       
                                    2702 ****************************************                                                    
                                    2703 *                                                                                           
 0100E0                             2704          ORG   FIRST4K+X'100E0'       MOVE TO LOCATION FOR CB100s                           
 000100                             2705 CB100LTH EQU   X'100'                 LENGTH OF THE CONTROL BLOCKS                          
 00001F                             2706 CB100#   EQU   31                     NUMBER OF CB100 BLOCKS                                
 0100E0 00000000                    2707 CB100HDR DC    A(0)                   NULL PTR                                              
 0100E4 E3C8C540C3C2F1F0            2708          DC    CL28'THE CB100 POOL FOLLOWS THIS'  DEFINE CB100HDR                           
 010100 F1F2F3F460C2D9C1            2709 CB100POL DC   (CB100#)CL(CB100LTH)'1234-BRANDON TWEED-UNUSED CB' INIT                       
 012000                             2710          ORG   ,                      MOVE ON                                               
                                    2711 *                                                                                           
                                    2712 ****************************************                                                    
                                    2713 * NIP/MS (MASTER SCHEDULER)                                                                 
                                    2714 *                                                                                           
                                    2715 * REGISTERS:                                                                                
                                    2716 *  3 - CVT ADDRESSABILITY                                                                   
                                    2717 *  8 - MSDA ADDRESSABILITY                                                                  
                                    2718 * 12 - NIP/MS ADDRESSABILITY                                                                
                                    2719 *                                                                                           
                                    2720 ****************************************                                                    
                                    2721 *                                                                                           
 012000                             2722          ORG   FIRST4K+X'12000'       MOVE TO LOCATION FOR NIP/MS                           
 012000 05C0                        2723 NIPMS    BALR  12,0                   SET UP ADDRESSABILITY                                 
 012002 06C0                        2724          BCTR  12,0                   BACK ONE                                              
 012004 06C0                        2725          BCTR  12,0                   BACK ONE                                              
 012000                             2726          USING NIPMS,12               ESTABLISH NIPMS ADDR                                  
 012006 5830 004C            0004C  2727          L     3,76                   GET A(CVT)                                            
 000000                             2728          USING CVT,3                  ADDR FOR CVT                                          
                                    2729 *                                                                                           
                                    2730 * Do test of SVC 8                                                                          
                                    2731 * Uses regs 7,8,9,10,0,1                                                                    
                                    2732 * 9 - looping                                                                               
                                    2733 * 7 - Address of Loader                                                                     
                                    2734 * 8 - Increment value of X'400'                                                             
                                    2735 *                                                                                           
 01200A 1777                        2736          XR    7,7           Clear 7                                                        
 01200C 1788                        2737          XR    8,8           Clear 8                                                        
 01200E 4190 0002            00002  2738          LA    9,2           Loop once                                                      
 012012 5870 C380            12380  2739          L     7,SVC8STRT    Get SVC8 New Load point                                        
 012016 4180 0400            00400  2740          LA    8,X'400'      X'400' bytes available space                                   
 01201A 1807                        2741 TST8     LR    0,7           Get loading point                                              
 01201C 1818                        2742          LR    1,8           Get available space                                            
 01201E 0104                        2743          XOPC  4             Turn off trace                                                 
 012020 0A08                        2744          SVC   8             Call SVC 8 to load the loader                                  
 012022 0102                        2745          XOPC  2             Turn on trace                                                  
 012024 12FF                        2746          LTR   15,15         Check return code                                              
 012026 4770 C372            12372  2747          BNZ   SVC8FAIL      If failed, bomb out                                            
                                    2748 * Update SVC Table                                                                          
 01202A 58A0 3004            00004  2749          L     10,CVTSVCTA   Get A(SVCTABLE)                                                
1       SVC 13                                                                                                  PAGE   49            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 01202E 5070 A040            00040  2750          ST    7,64(,10)     Save New A(SVC8) into SVCTABLE                                 
 012032 4178 7000            00000  2751          LA    7,0(8,7)      Increment load address by X'400'                               
 012036 4690 C01A            1201A  2752          BCT   9,TST8        Test one more time                                             
                                    2753 *                                                                                           
                                    2754 * Done testing loader                                                                       
                                    2755 *                                                                                           
 01203A 4180 C540            12540  2756          LA    8,MYMSDA               GET ADDDRESS OF MSDA                                  
 000000                             2757          USING MSDA,8                 ADDR FOR MSDA                                         
 01203E 4100 0001            00001  2758 MSWAITLP LA    0,1                    Set R0 for first SVC 1                                
 012042 4110 8004            00004  2759          LA    1,MSDAMECB             GET A(MECB)                                           
 012046 0A01                        2760          SVC   1                      CALL 'WAIT'                                           
 012048 D503 8004 C3E1 00004 123E1  2761          CLC   MSDAMECB(4),X7FDIS     COMPARE MECB WITH X'7F',C'DIS'                        
 01204E 4770 C370            12370  2762          BNE   MS0119                 IF NOT CORRECT, DIE                                   
 012052 D503 800C 8008 0000C 00008  2763 CURVSMAX CLC   MSDACURI(4),MSDAMAXI   COMPARE CURI TO MAXI                                  
 012058 47B0 C366            12366  2764          BNL   DOMSWAIT               IF CURI <= MAXI, WAIT                                 
 01205C 4110 C580            12580  2765          LA    1,IOBREAD              GET A(IOBREAD) FOR READ                               
 012060 95E8 C3E7      123E7        2766          CLI   ISEOF,C'Y'             Check if EOF Happened already                         
 012064 4780 C074            12074  2767          BE    CHKCURI                If so, check the CURI                                 
 012068 0A00                        2768          SVC   0                      READ THE PARM CARD                                    
 01206A 12FF                        2769          LTR   15,15                  If R15 = 0, Good to go                                
 01206C 4780 C082            12082  2770          BZ    RUNJOB                 READ WAS SUCCESSFUL, RUN JOB                          
 012070 92E8 C3E7      123E7        2771          MVI   ISEOF,C'Y'             If not successful, set EOF flag                       
 012074 5800 800C            0000C  2772 CHKCURI  L     0,MSDACURI             GET CURI                                              
 012078 1200                        2773          LTR   0,0                    IF VALUE IS ZERO                                      
 01207A 4780 C370            12370  2774          BZ    MS0119                 NO MORE JOBS, DIE                                     
 01207E 47F0 C366            12366  2775          B     DOMSWAIT               IF NOT, WAIT                                          
                                    2776 *                                                                                           
                                    2777 *** START OF "RUN JOB" CODE                                                                 
                                    2778 *                                                                                           
                                    2779 * 1) Obtain address of region where program is to be run                                    
                                    2780 *                                                                                           
 012082 5840 8010            00010  2781 RUNJOB   L     4,MSDAFLAD             Get @ REGION                                          
                                    2782 *                                                                                           
                                    2783 * 2) Get pad character and set 4096 bytes of region                                         
                                    2784 *                                                                                           
 012086 5850 C490            12490  2785          L     5,FOURK                GET 4K                                                
 01208A 4370 8015            00015  2786          IC    7,MSDAFPAD             INSERT PAD BYTE                                       
 01208E 8970 0018            00018  2787          SLL   7,24                   SHIFT PAD BYTE IN REG                                 
 012092 0E46                        2788          MVCL  4,6                    FILL USER REGION                                      
                                    2789 *                                                                                           
                                    2790 * 3) obtain key and fetch protect and perform 2 SSKs                                        
                                    2791 *                                                                                           
 012094 5840 8010            00010  2792          L     4,MSDAFLAD             GET @ USER REGION                                     
 012098 4390 8014            00014  2793          IC    9,MSDAFKEY             GET KEY                                               
 01209C 0894                        2794          SSK   9,4                    SET KEY FOR REGION                                    
 01209E 4140 4800            00800  2795          LA    4,2048(,4)             MOVE TO NEXT 2K                                       
 0120A2 0894                        2796          SSK   9,4                    SET KEY FOR 2ND PART                                  
                                    2797 *                                                                                           
                                    2798 * Set up PIE before the user region                                                         
                                    2799 *                                                                                           
 0120A4 4140 0FE0            00FE0  2800          LA    4,4096-32              GO TO START OF PIE                                    
 0120A8 5A40 8010            00010  2801          A     4,MSDAFLAD             RESOLVE DISPLACEMENT                                  
 0120AC 5040 C49C            1249C  2802          ST    4,PIEPTR               SAVE ADDR OF PIE FOR L8R                              
 0120B0 D203 4000 C3D4 00000 123D4  2803          MVC   0(4,4),PIE             PUT "PIE" INT USR REGION                              
 0120B6 D21B 4004 4000 00004 00000  2804          MVC   4(28,4),0(4)           RIPPLE THE PIE                                        
                                    2805 *                                                                                           
                                    2806 * Parse parameter and move it into the user region                                          
1       SVC 13                                                                                                  PAGE   50            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    2807 *                                                                                           
                                    2808 * R4 = Start of PIE                                                                         
                                    2809 * R5 = A(BUFFER)/Address for start of actual parm                                           
                                    2810 * R6 = A(End of Parm Buffer)                                                                
                                    2811 * R7 = Points to end of actual parm                                                         
                                    2812 *                                                                                           
 0120BC 4150 C440            12440  2813          LA    5,BUFFER               Get start of buffer                                   
 0120C0 4160 5050            00050  2814          LA    6,80(,5)               Get @ end of buffer                                   
 0120C4 D505 5000 C3E8 00000 123E8  2815 PRMLOOP  CLC   0(6,5),PRMSRCH         See if encountered ',PARM='                           
 0120CA 4780 C0DC            120DC  2816          BE    PRMFOUND               If so, go to PRMFOUND                                 
 0120CE 1956                        2817          CR    5,6                    If end of buffer encountered                          
 0120D0 4780 C120            12120  2818          BE    NOPRMFND               Done, no parm found                                   
 0120D4 4150 5001            00001  2819          LA    5,1(,5)                Move to next byte in parm field                       
 0120D8 47F0 C0C4            120C4  2820          B     PRMLOOP                Continue checking for parm                            
                                    2821 *                                                                                           
 0120DC 4150 5006            00006  2822 PRMFOUND LA    5,6(,5)                Move to start of actual parm                          
 0120E0 1956                        2823          CR    5,6                    If past end of buffer                                 
 0120E2 4720 C120            12120  2824          BH    NOPRMFND               Done, no valid parm                                   
 0120E6 9540 5000      00000        2825          CLI   0(5),C' '              If first parm char is a blank                         
 0120EA 4780 C120            12120  2826          BE    NOPRMFND               Parm length is zero                                   
 0120EE 957D 5000      00000        2827          CLI   0(5),X'7D'             If first parm char is apostrophe                      
 0120F2 4780 C0FE            120FE  2828          BE    PRMQUOTE               handle param in single quotes                         
 0120F6 9240 C40A      1240A        2829          MVI   PRMDLM,C' '            otherwise parm delim is space                         
 0120FA 47F0 C106            12106  2830          B     DOPARM                 DO PARSING                                            
 0120FE 927D C40A      1240A        2831 PRMQUOTE MVI   PRMDLM,X'7D'           apostrophe is delimiter                               
 012102 4150 5001            00001  2832          LA    5,1(,5)                Step into the parameter                               
                                    2833 *                                                                                           
                                    2834 * DO PARSING AND SEARCHING FOR PARM                                                         
                                    2835 *                                                                                           
 012106 1875                        2836 DOPARM   LR    7,5                    Start with beginning of param                         
 012108 D500 7000 C40A 00000 1240A  2837 PRMLOOP3 CLC   0(1,7),PRMDLM          Check for ending space                                
 01210E 4780 C12A            1212A  2838          BE    PRMDONE                if encountered, done parsing                          
 012112 4170 7001            00001  2839          LA    7,1(,7)                Move forward in the buffer                            
 012116 1976                        2840          CR    7,6                    Check to see if past end                              
 012118 4720 C120            12120  2841          BH    NOPRMFND               If so, treat as if no parm                            
 01211C 47F0 C108            12108  2842          B     PRMLOOP3               Otherwise, Continue searching                         
                                    2843 *                                                                                           
                                    2844 * IF NO PARM DETECTED, DO THIS                                                              
                                    2845 *                                                                                           
 012120 1777                        2846 NOPRMFND XR    7,7                    Clear R7                                              
 012122 BE73 C408            12408  2847          STCM  7,3,PRMLEN             Set parm length to zero                               
 012126 47F0 C14A            1214A  2848          B     SULEN                  No parm, set up length                                
                                    2849 *                                                                                           
 01212A 1B75                        2850 PRMDONE  SR    7,5                    Calculate length of PARM                              
 01212C BE73 C408            12408  2851          STCM  7,3,PRMLEN             Save the length for use                               
                                    2852 *                                                                                           
                                    2853 * Test to see if parm length was even                                                       
                                    2854 *                                                                                           
 012130 9101 C409      12409        2855 BLDPARM  TM    PRMLEN+1,X'01'         See if PRMLEN was even                                
 012134 4780 C13E            1213E  2856          BZ    CPYPARM                If it was, no need to pad                             
                                    2857 *                                                                                           
                                    2858 * Pads the parameter with a byte of X'00'                                                   
                                    2859 *                                                                                           
 012138 0640                        2860 PADPARM  BCTR  4,0                    Step back a byte                                      
 01213A 9200 4000      00000        2861          MVI   0(4),X'00'             Set up pad byte of zero                               
                                    2862 *                                                                                           
 01213E 1B47                        2863 CPYPARM  SR    4,7                    Step back PARMLEN # of bytes                          
1       SVC 13                                                                                                  PAGE   51            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 012140 5040 C3F8            123F8  2864          ST    4,PARMPTR              Save @ of parm start                                  
 012144 0670                        2865          BCTR  7,0                    Length code is L - 1                                  
 012146 4470 C3EE            123EE  2866          EX    7,COPYPRM              Copy parm into the User Region                        
                                    2867 *                                                                                           
                                    2868 * Now set up the length field                                                               
                                    2869 *                                                                                           
 01214A 5B40 C404            12404  2870 SULEN    S     4,PSZLEN               Move to address for pointer                           
 01214E 5040 C3FC            123FC  2871          ST    4,PLENPTR              Save @ of parm length field                           
 012152 9103 C3FF      123FF        2872          TM    PLENPTR+3,X'03'        Check if address div by 4                             
 012156 D201 4000 C408 00000 12408  2873          MVC   0(2,4),PRMLEN          Copy PRMLEN to current position                       
 01215C 4780 C16A            1216A  2874          BZ    BLDPTR                 If SO, no pad, build pointer                          
 012160 0640                        2875          BCTR  4,0                    Move back 1 byte                                      
 012162 0640                        2876          BCTR  4,0                    Move back 1 more byte                                 
 012164 D701 4000 4000 00000 00000  2877          XC    0(2,4),0(4)            CLear bytes (insert padding)                          
                                    2878 *                                                                                           
                                    2879 * Just copies PRMLEN w/out inserting padding                                                
                                    2880 *                                                                                           
 01216A 5B40 C400            12400  2881 BLDPTR   S     4,PTRLEN               Step back the length of pointer                       
 01216E 9280 4000      00000        2882          MVI   0(4),X'80'             Set first byte to X'80'                               
 012172 D202 4001 C3FD 00001 123FD  2883          MVC   1(3,4),PLENPTR+1       Set pointer to the length                             
 012178 5040 C3F8            123F8  2884          ST    4,PARMPTR              Save @ of ptr field into PARMPTR                      
                                    2885 *                                                                                           
                                    2886 * 5) Set up an 18F save area and set the 2nd FW to zero                                     
                                    2887 *    Save the address of this SA                                                            
                                    2888 *                                                                                           
 01217C 5B40 C494            12494  2889          S     4,SAVLEN               MOVE BACK 72 BYTES                                    
 012180 5040 C4A4            124A4  2890          ST    4,SAPTR                SAVE POINTER TO SA                                    
 012184 D703 4004 4004 00004 00004  2891          XC    4(4,4),4(4)            CLEAR 2ND FULLWORD                                    
                                    2892 *                                                                                           
                                    2893 * 6) Load the user's program into the 4K region                                             
                                    2894 *                                                                                           
 01218A 5800 8010            00010  2895          L     0,MSDAFLAD             GET @ LOAD LOCATION                                   
 01218E 1B40                        2896          SR    4,0                    CALC AVAILABLE SPACE                                  
 012190 1814                        2897          LR    1,4                    SET R1 = AVAILABLE SPACE                              
 012192 0102                        2898 SVC8OFF  XOPC  2                      DOES NOTHING 1ST TIME THRU                            
 012194 0A08                        2899          SVC   8                      CALL THE LOADER                                       
 012196 9204 C193      12193        2900          MVI   SVC8OFF+1,X'04'        Turn off trace 2nd time                               
 01219A 0102                        2901          XOPC  2                      MAKE SURE TRACE ON FOR REST                           
 01219C 12FF                        2902          LTR   15,15                  CHECK RETURN CODE                                     
 01219E 4770 C370            12370  2903          BNZ   MS0119                 IF NOT ZERO, DIE                                      
 0121A2 5000 C498            12498  2904          ST    0,EPAPTR               SAVE ENTRY POINT ADDRESS                              
 0121A6 5010 C4A0            124A0  2905          ST    1,MODLEN               SAVE MODULE LENGTH                                    
                                    2906 *                                                                                           
                                    2907 * 7) OBTAIN AND CONFIGURE TCB AND RB                                                        
                                    2908 *                                                                                           
                                    2909         GETCB100                                                                            
                                    2910+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0121AA 58B0 3018            00018  2911+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0121AE 58AB 0000            00000  2912+         L     10,0(11)           Load Address of next CB.                                  
 0121B2 12AA                        2913+         LTR   10,10              Make sure a CB is available.                              
 0121B4 4770 C1CE            121CE  2914+         BNZ   GTCB0014           To MVC if there is a CB.                                  
 0121B8 0119                        2915+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 0121BA C3C2F1F0F040D7D6            2916+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 0121CE D203 B000 A000 00000 00000  2917+GTCB0014    MVC 0(4,11),0(10)           Update header.                                      
 0121D4 189A                        2918         LR     9,10                   GET A(TCB) into R9                                    
 000000                             2919         USING  TCB,9                  TCB ADDR                                              
 0121D6 D7FF 9000 9000 00000 00000  2920         XC     TCB(CB100LTH),TCB      CLEAR THE TCB                                         
1       SVC 13                                                                                                  PAGE   52            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0121DC D207 9008 C3A4 00008 123A4  2921         MVC    TCBTNAME(8),TNAME      SET TCBTNAME                                          
 0121E2 92F1 900B      0000B        2922         MVI    TCBTNAME+3,C'1'        SET # FOR TCBTNAME                                    
 0121E6 D203 902C C3AC 0002C 123AC  2923         MVC    TCBIDENT(4),TIDENT     SET TCBIDENT                                          
 0121EC 43A0 C3D8            123D8  2924         IC     10,IDNTNUM             GET NUM FOR TCBIDENT                                  
 0121F0 42A0 900B            0000B  2925         STC    10,TCBTNAME+3          SAVE IDENT CHARACTER                                  
 0121F4 41A0 A001            00001  2926         LA     10,1(,10)              INCREMENT IDENT NUM                                   
 0121F8 42A0 C3D8            123D8  2927         STC    10,IDNTNUM             SAVE UPDATED IDENT NUM                                
 0121FC D207 9030 C3B0 00030 123B0  2928         MVC    TCBGRS(8),TGRS         SET TCBGRS                                            
 012202 D237 9038 C3B0 00038 123B0  2929         MVC    TCBGRS+8(56),TGRS      RIPPLE TCBGRS                                         
 012208 D207 90E0 C3B8 000E0 123B8  2930         MVC    TCBFRS(8),TFRS         SET TCBFRS                                            
 01220E D217 90E8 C3B8 000E8 123B8  2931         MVC    TCBFRS+8(24),TFRS      RIPPLE TCBFRS                                         
 012214 D203 9034 C3F8 00034 123F8  2932         MVC    TCBGRS+1*4(4),PARMPTR  SET R1= PARM POINTER                                  
 01221A D203 9064 C4A4 00064 124A4  2933         MVC    TCBGRS+13*4(4),SAPTR   SET R13 = SAVE AREA                                   
 012220 D203 906C C498 0006C 12498  2934         MVC    TCBGRS+15*4(4),EPAPTR  SET R15 = EPA                                         
 012226 D203 9080 C49C 00080 1249C  2935         MVC    TCBAPIE(4),PIEPTR      SET TCBAPIE -> PIE IN TCB                             
 01222C 41B0 3050            00050  2936         LA     11,CVTEXIT             GET A(CVTEXIT)                                        
 012230 50B0 9068            00068  2937         ST     11,TCBGRS+4*14         SAVE A(CVTEXIT)                                       
 012234 D203 9084 C3F8 00084 123F8  2938         MVC    TCBAPARM(4),PARMPTR    SET UP A(PARM) IN TCB                                 
 01223A D203 9088 C4A4 00088 124A4  2939         MVC    TCBFSA(4),SAPTR        SET UP SAVE AREA PTR IN TCB                           
 012240 5810 C498            12498  2940         L      1,EPAPTR               GET EPA                                               
 012244 D207 9010 1005 00010 00005  2941         MVC    TCBPNAME(8),5(1)       GET PROGRAM NAME FROM EPA+5                           
                                    2942 *                                                                                           
                                    2943 * GET THE RB AND CONFIGURE IT                                                               
                                    2944 *                                                                                           
                                    2945         GETCB100                                                                            
                                    2946+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 01224A 58B0 3018            00018  2947+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 01224E 58AB 0000            00000  2948+         L     10,0(11)           Load Address of next CB.                                  
 012252 12AA                        2949+         LTR   10,10              Make sure a CB is available.                              
 012254 4770 C26E            1226E  2950+         BNZ   GTCB0015           To MVC if there is a CB.                                  
 012258 0119                        2951+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 01225A C3C2F1F0F040D7D6            2952+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 01226E D203 B000 A000 00000 00000  2953+GTCB0015    MVC 0(4,11),0(10)           Update header.                                      
 000000                             2954         USING  RB,10                  ESTABLISH RB ADDR                                     
 012274 D7FF A000 A000 00000 00000  2955         XC     RB(CB100LTH),RB        CLEAR THE RB                                          
 01227A 5090 A004            00004  2956         ST     9,RBTCB                SET RBTCB TO POINT TO TCB                             
 01227E 50A0 9000            00000  2957         ST     10,TCBRB               SET UP TCBRB TO POINT TO RB                           
 012282 D203 A000 C3C0 00000 123C0  2958         MVC    RBTYPE(4),RTYPE        SET RBTYPE                                            
 012288 9680 A00B      0000B        2959         OI     RBFLGS3,X'80'          SET BIT 0 TO 1 (PRB)                                  
 01228C D300 C3DA 8014 123DA 00014  2960         MVZ    NEWPSW+1(1),MSDAFKEY   LEFT HIT OF KEY INTO PSW                              
 012292 5810 C498            12498  2961         L      1,EPAPTR               GET EPA                                               
 012296 BE17 C3DE            123DE  2962         STCM   1,7,NEWPSW+5           SET ADDRESS IN PSW                                    
 01229A D207 A010 C3D9 00010 123D9  2963         MVC    RBOPSW(8),NEWPSW       PUT NEW PSW IN PRB                                    
 0122A0 D207 A020 C3C4 00020 123C4  2964         MVC    RBGRSAVE(8),RGRS       INIT RB GRS                                           
 0122A6 D237 A028 C3C4 00028 123C4  2965         MVC    RBGRSAVE+8(56),RGRS    RIPPLE INIT VALUE                                     
 0122AC D207 A060 C3CC 00060 123CC  2966         MVC    RBFRSAVE(8),RFRS       INIT RB FRS                                           
 0122B2 D217 A068 C3CC 00068 123CC  2967         MVC    RBFRSAVE+8(24),RFRS    RIPPLE INIT VALUE                                     
 0122B8 BE97 A01D            0001D  2968         STCM   9,7,RBLINK+1           POINT RBLINK TO TCB                                   
 0122BC                             2969         DROP   9,10                   DONE WITH TCB & PRB FOR NOW                           
                                    2970 *                                                                                           
                                    2971 * 8) BUILD A JOB START MESSAGE AND PRINT IT OUT                                             
                                    2972 *                                                                                           
 0122BC D203 C2D2 C498 122D2 12498  2973          MVC   LACALL+12(4),EPAPTR    MOVE LOAD ADDRESS INTO LOUNTR                         
 0122C2 4510 07E0            007E0  2974          BAL   1,LOUNTR               CALL LOUNTR                                           
 0122C6 D340404040404040            2975 LACALL   DC    CL16'L'                LOUNTR STORAGE                                        
 0122D6 D207 C4C1 C2C6 124C1 122C6  2976          MVC   JSLAOUT(8),LACALL      GET LOAD ADDRESS TO PLINE                             
 0122DC D203 C2F2 C4A0 122F2 124A0  2977          MVC   LACALL2+12(4),MODLEN   PUT MODULE LENGTH INTO LOUNTR                         
1       SVC 13                                                                                                  PAGE   53            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 0122E2 4510 07E0            007E0  2978          BAL   1,LOUNTR               CALL LOUNTR                                           
 0122E6 D340404040404040            2979 LACALL2  DC    CL16'L'                STORAGE FOR SECOND LOUNTR                             
 0122F6 D207 C4DA C2E6 124DA 122E6  2980          MVC   JSPLOUT(8),LACALL2     GET PRINTABLE MODULE LENGTH                           
 0122FC 5840 C498            12498  2981          L     4,EPAPTR               GET EPA                                               
 012300 D207 C4F4 4005 124F4 00005  2982          MVC   JSPNAME(8),5(4)        GET PROGRAM NAME FROM EPA+5                           
 000000                             2983          USING TCB,9                  ADDRESS TCB                                           
 012306 D207 C507 9008 12507 00008  2984          MVC   JSTCBN(8),TCBTNAME     GET TCB NAME ONTO PRINT LINE                          
 01230C                             2985          DROP  9                      DONE WITH TCB                                         
 01230C 4110 C5A0            125A0  2986          LA    1,IOBWRITE             GET @ IOB FOR JOB START                               
 012310 0A00                        2987          SVC   0                      PRINT THE JOB START MESSAGE                           
                                    2988 *                                                                                           
                                    2989 * 9) UPDATE VALUES IN THE MSDA                                                              
                                    2990 *                                                                                           
 012312 5840 C490            12490  2991          L     4,FOURK                GET 4K                                                
 012316 5A40 8010            00010  2992          A     4,MSDAFLAD             ADD 4K TO USER REGION START                           
 01231A 5040 8010            00010  2993          ST    4,MSDAFLAD             SAVE UPDATED REGION START                             
 01231E 4140 0001            00001  2994          LA    4,1                    FOR ADDING TO PAD                                     
 012322 5A40 800C            0000C  2995          A     4,MSDACURI             INCREMENT CURI BY 1                                   
 012326 5040 800C            0000C  2996          ST    4,MSDACURI             SAVE UPDATED CURI VALUE                               
 01232A 4350 8015            00015  2997          IC    5,MSDAFPAD             GET PAD VALUE                                         
 01232E 4150 5001            00001  2998          LA    5,1(,5)                INCREMENT PAD CHARACTER                               
 012332 4250 8015            00015  2999          STC   5,MSDAFPAD             SAVE UPDATED PAD CHARACTER                            
 012336 4350 8014            00014  3000          IC    5,MSDAFKEY             GET KEY VALUE                                         
 01233A 4150 5010            00010  3001          LA    5,16(,5)               INCREMENT BY X'10'                                    
 01233E 4250 8014            00014  3002          STC   5,MSDAFKEY             SAVE UPDATED KEY VALUE                                
                                    3003 *                                                                                           
                                    3004 * 10) chain user's TCB into the chain following NIP/MS TCB                                  
                                    3005 *                                                                                           
 012342 8000 C3E5      123E5        3006 SSMDIS   SSM   DISABLE                DISABLE INTERRUPTS                                    
 000000                             3007          USING TCB,9                  ESTABLISH TCB ADDRESSABILITY                          
 012346 58A0 3008            00008  3008          L     10,CVTHEAD             GET START TCB CHAIN                                   
 01234A 50A0 90DC            000DC  3009          ST    10,TCBBACK             SAVE BACKWARD POINTER                                 
 01234E                             3010          DROP  9                      DONE WITH NEW TCB                                     
 000000                             3011          USING TCB,10                 DEAL WITH MS TCB                                      
 01234E 58B0 A074            00074  3012          L     11,TCBTCB              GET MSTCB FORWARD POINTER                             
 012352 5090 A074            00074  3013          ST    9,TCBTCB               ST MSTCB FORWARD POINTER TO NEW                       
 012356                             3014          DROP  10                     DONE WITH MS TCB                                      
 000000                             3015          USING TCB,9                  ESTABLISH NEW TCB ADDR                                
 012356 50B0 9074            00074  3016          ST    11,TCBTCB              UPDATE NEW TCB FORWARD POINTER                        
 01235A                             3017          DROP  9                      DONE WITH NEW TCB                                     
 000000                             3018          USING TCB,11                 ADDRESSABILITY TO LAST TCB                            
 01235A 5090 B0DC            000DC  3019          ST    9,TCBBACK              UPDATE BACKWARD POINTER                               
 01235E                             3020          DROP  11                     DONE WITH LAST TCB                                    
 01235E 8000 C3E6      123E6        3021 SSMENA   SSM   ENABLE                 ENABLE INTERRUPTS AGAIN                               
                                    3022 *                                                                                           
                                    3023 * 11) BRANCH TO CURVSMAX                                                                    
                                    3024 *                                                                                           
 012362 47F0 C052            12052  3025          B     CURVSMAX               RETURN TO CURVSMAX                                    
 012366 D703 C544 C544 12544 12544  3026 DOMSWAIT XC    LOCMECB(4),LOCMECB     CLEAR MECB                                            
 01236C 47F0 C03E            1203E  3027          B     MSWAITLP               GO BACK TO MS WAIT LOOP                               
 012370 0119                        3028 MS0119   XOPC  25                     MASTER SCHEDULER BAIL POINT                           
 012372 0119                        3029 SVC8FAIL DC    X'0119'                If Testing SVC8 fails, bomb out                       
 012374                             3030          DROP  3,8,12                 DONE WITH CVT,MSDA,MSNIP                              
                                    3031 ********************************************************************                        
                                    3032 * MS/NIP WORKING STORAGE                                                                    
                                    3033 ********************************************************************                        
                                    3034 *                                                                                           
1       SVC 13                                                                                                  PAGE   54            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 012380                             3035          ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT                                 
 012380 00007800                    3036 SVC8STRT DC    A(X'7800')             First time, Load at X'7800'                           
 012384 D7C9C540D7C9C540            3037 NIPMSPIE DC    0F'0',8CL4'PIE'        PIE FOR NIPMS                                         
 0123A4 E3C3C29540C2C4E3            3038 TNAME    DC    CL8'TCBn BDT'          NEW TCB NAME VALUE                                    
 0123AC E3C3C240                    3039 TIDENT   DC    CL4'TCB '              NEW TCB IDENT                                         
 0123B0 E3C3C2C7D9E24040            3040 TGRS     DC    CL8'TCBGRS'            NEW TCB GRS INIT VALUE                                
 0123B8 E3C3C2C6D9E24040            3041 TFRS     DC    CL8'TCBFRS'            NEW TCB FRS INIT VALUE                                
 0123C0 40D7D9C2                    3042 RTYPE    DC    CL4' PRB'              NEW RB RBTYPE VALUE                                   
 0123C4 D9C2C7D9E2C1E5C5            3043 RGRS     DC    CL8'RBGRSAVE'          RB GRS INIT VALUE                                     
 0123CC D9C2C6D9E2C1E5C5            3044 RFRS     DC    CL8'RBFRSAVE'          RB FRS INIT VALUE                                     
 0123D4 D7C9C540                    3045 PIE      DC    CL4'PIE '              PIE INIT VALUE                                        
 0123D8 F1                          3046 IDNTNUM  DC    C'1'                   FOR INITIALIZING TCBIDENT                             
 0123D9 FF0501190F                  3047 NEWPSW   DC    XL5'FF0501190F'        FIRST PART OF PSW                                     
 0123DE 000000                      3048          DC    AL3(0)                 ADDRESS PART OF PSW                                   
 0123E1 7FC4C9E2                    3049 X7FDIS   DC    X'7F',C'DIS'           FOR CHECKING MECB                                     
 0123E5 01                          3050 DISABLE  DC    X'01'                  DISABLE INTERRUPTS                                    
 0123E6 FF                          3051 ENABLE   DC    X'FF'                  ENABLE INTERRUPTS                                     
 0123E7 D5                          3052 ISEOF    DC    C'N'                   EOF FLAG FOR JOB READER                               
                                    3053 *                                                                                           
                                    3054 * PARM PARSING STUFF                                                                        
                                    3055 *                                                                                           
 0123E8 6BD7C1D9D47E                3056 PRMSRCH  DC    CL6',PARM='            PARM search string                                    
 0123EE D200 4000 5000 00000 00000  3057 COPYPRM  MVC   0(0,4),0(5)            Copy buffer contents                                  
 0123F4 00000058                    3058 PARMLEN  DC    F'88'                  88 BYTES FOR PARM                                     
 0123F8 00000000                    3059 PARMPTR  DC    A(0)                   POINTER TO PARM AREA                                  
 0123FC 00000000                    3060 PLENPTR  DC    A(0)                   POINTER TO PARM LENGTH                                
 012400 00000004                    3061 PTRLEN   DC    F'4'                   POINTER IS 4 BYTES LONG                               
 012404 00000002                    3062 PSZLEN   DC    F'2'                   Size of the parm length field                         
 012408 0000                        3063 PRMLEN   DC    AL2(0)                 PARM length calculated                                
 01240A 40                          3064 PRMDLM   DC    C' '                   Parm delimiter detected                               
                                    3065 *                                                                                           
 012420                             3066          ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT                                 
 012420 C2E4C6C6C5D940D3            3067          DC    CL32'BUFFER LIES BELOW' LABEL THE DUMP                                       
 012440 E9E9E9E9E9E9E9E9            3068 BUFFER   DC    80C'Z'                 READ BUFFER                                           
                                    3069 *                                                                                           
 012490 00001000                    3070 FOURK    DC    F'4096'                FOUR K                                                
 012494 00000048                    3071 SAVLEN   DC    F'72'                  72 BYTE SAVE AREA                                     
 012498 00000000                    3072 EPAPTR   DC    A(0)                   ENTRY POINT ADDRESS                                   
 01249C 00000000                    3073 PIEPTR   DC    A(0)                   PTR TO USER'S PIE                                     
 0124A0 00000000                    3074 MODLEN   DC    F'0'                   MODULE LENGTH                                         
 0124A4 00000000                    3075 SAPTR    DC    A(0)                   SAVE AREA POINTER                                     
                                    3076 *                                                                                           
 0124A8 40                          3077 JSMESSG  DC    C' '                   SINGLE SPACE                                          
 0124A9 D6E240D6C640C2D9            3078          DC    CL20'OS OF BRANDON TWEED ' JOB START MESSAGE                                 
 0124BD D3C17A40                    3079          DC    CL4'LA: '              LOAD ADDRESS                                          
 0124C1 E7E7E7E7E7E7E7E7            3080 JSLAOUT  DC    CL8'XXXXXXXX'          JOB START LOAD ADDRESS                                
 0124C9 40D7D9D6C7D9C1D4            3081          DC    CL17' PROGRAM LENGTH: ' JOB START MESSAGE                                    
 0124DA E7E7E7E7E7E7E7E7            3082 JSPLOUT  DC    CL8'XXXXXXXX'          JOB START PROGRAM LENGTH                              
 0124E2 40C2E8E3C5E24B40            3083          DC    CL8' BYTES. '          JOB START MESSAGE                                     
 0124EA D7C7D440D5C1D4C5            3084          DC    CL10'PGM NAME: '       JOB START MESSAGE                                     
 0124F4 E7E7E7E7E7E7E7E7            3085 JSPNAME  DC    CL8'XXXXXXXX'          PROGRAM NAME                                          
 0124FC 40E3C3C240D5C1D4            3086          DC    CL11' TCB NAME: '      JOB START MESSAGE                                     
 012507 E7E7E7E7E7E7E7E7            3087 JSTCBN   DC    CL8'XXXXXXXX'          TCB NAME GOES HERE                                    
 01250F 4040404040404040            3088          DC    33C' '                 FILLER FOR JSMESSG                                    
                                    3089 *                                                                                           
                                    3090 *********************************************************************                       
                                    3091 * MSDA (MASTER SCHEDULER RESIDENT DATA AREA)                                                
1       SVC 13                                                                                                  PAGE   55            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    3092 *********************************************************************                       
                                    3093 *                                                                                           
 012540                             3094          ORG   FIRST4K+((*-FIRST4K+31)/32*32) NICE ALIGNMENT                                
 012540 D4E2C4C1                    3095 MYMSDA   DC    CL4'MSDA'              IDENT FOR MSDA                                        
 012544 7FC4C9E2                    3096 LOCMECB  DC    X'7F',C'DIS'           MECB                                                  
 012548 00000005                    3097 LOCMAXI  DC    F'5'                   MAX # INITIATORS                                      
 01254C 00000000                    3098 LOCCURI  DC    F'0'                   # INITIATORS RUNNING                                  
 012550 0000A000                    3099          DC    XL4'A000'             LOAD ADDRESS NEXT USER PGM                             
 012554 D8                          3100 KEY      DC    X'D8'                  KEY 5 FETCH PROTECT ON                                
 012555 C4                          3101          DC    C'D'                   PAD CHARACTER                                         
 012560                             3102          ORG   MYMSDA+(MSDAFFLO-MSDA) GO TO LOCATION FOR MSDAFFL0                           
 012560 4110000000000000            3103          DC    D'1,-2,+3,-4'          DEFINE MSDAFFL0-MSDAFFL6                              
                                    3104 *                                                                                           
                                    3105 ** END OF MSDA **                                                                           
                                    3106 *                                                                                           
                                    3107 *                                                                                           
                                    3108 ***************************                                                                 
                                    3109 * IOB - INPUT/OUTPUT BLOCKS                                                                 
                                    3110 ***************************                                                                 
                                    3111 *                                                                                           
 012580                             3112          ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT                                 
 012580 C9D6C2D9                    3113 IOBREAD  DC    CL4'IOBR'              IOB IDENTIFICATION                                    
 012584 000C                        3114          DC    XL2'000C'              FOR XREAD                                             
 012586 02                          3115          DC    X'02'                  '02' = READ                                           
 012587 F0                          3116          DC    C'0'                   RESERVED FOR STUFF                                    
 012588 00012440                    3117          DC    A(BUFFER)              A(BUFFER) TO READ                                     
 01258C 0050                        3118          DC    H'80'                  LENGTH OF BUFFER TO READ/WRITE                        
 01258E 0000                        3119          DC    H'0'                   RESERVED FOR STUFF                                    
                                    3120 *                                                                                           
 0125A0                             3121          ORG   FIRST4K+((*-FIRST4K+31)/32*32) 32n ALIGNMENT                                 
 0125A0 C9D6C2E6                    3122 IOBWRITE DC    CL4'IOBW'              IOB IDENTIFICATION                                    
 0125A4 000E                        3123          DC    XL2'000E'              FOR XPRINT                                            
 0125A6 01                          3124          DC    X'01'                  '01' = WRITE                                          
 0125A7 F0                          3125          DC    C'0'                   RESERVED FOR STUFF                                    
 0125A8 000124A8                    3126          DC    A(JSMESSG)             A(BUFFER) TO WRITE                                    
 0125AC 0085                        3127          DC    H'133'                 LENGTH OF BUFFER TO READ/WRITE                        
 0125AE 0000                        3128          DC    H'0'                   RESERVED FOR STUFF                                    
                                    3129 *                                                                                           
                                    3130 *** END OF IOB ***                                                                          
                                    3131 *                                                                                           
                                    3132 *********************************************************************                       
                                    3133 * RQEENQ                                                                                    
                                    3134 *                                                                                           
                                    3135 * Inserts an RQE CB into the Queue.                                                         
                                    3136 * Entry Conditions:                                                                         
                                    3137 * R1 = A(IOB)                                                                               
                                    3138 * R3 = A(CVT)                                                                               
                                    3139 * R4 = A(User's TCB)                                                                        
                                    3140 * R5 = A(User's RB)                                                                         
                                    3141 * R12 = Entry address/addressability                                                        
                                    3142 *                                                                                           
                                    3143 * REGISTER USAGE:                                                                           
                                    3144 * R7  - Points to RQE in list of RQEs                                                       
                                    3145 * R8  - Address of UCB                                                                      
                                    3146 * R9  - not yet used                                                                        
                                    3147 * R10 - Address of CB100 for new RQE                                                        
                                    3148 * R11 - Used by GETCB100                                                                    
1       SVC 13                                                                                                  PAGE   56            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    3149 * R12 - Addressability for Routine                                                          
                                    3150 *                                                                                           
                                    3151 *********************************************************************                       
                                    3152 *                                                                                           
 0125B0                             3153          USING RQEENQ,12              Addressability for RQEENQ                             
 000000                             3154          USING CVT,3                  Addressability for CVT                                
                                    3155 *                                                                                           
                                    3156 * 1) Check that TYP1FLG is '1'                                                              
                                    3157 *                                                                                           
 0125B0 95F1 00BF      000BF        3158 RQEENQ   CLI   TYP1FLAG,C'1'          Verify TYP1FLAG is C'1'                               
 0125B4 4770 00BC            000BC  3159          BNE   LEVELABN               If not, DIE                                           
 0125B8 92F0 00BF      000BF        3160          MVI   TYP1FLAG,C'0'          Set TYP1FLAG to C'0'                                  
                                    3161 *                                                                                           
                                    3162 * 2) Acquire CB100 block and zero it                                                        
                                    3163 *                                                                                           
                                    3164          GETCB100                                                                           
                                    3165+*        GETCB100 &CBREG=10,&WORKREG=11  DEFAULT KEYWORD PARAMETERS                         
 0125BC 58B0 3018            00018  3166+         L     11,CVTC100H        Load Address of CB100HDR from CVT.                        
 0125C0 58AB 0000            00000  3167+         L     10,0(11)           Load Address of next CB.                                  
 0125C4 12AA                        3168+         LTR   10,10              Make sure a CB is available.                              
 0125C6 4770 C030            125E0  3169+         BNZ   GTCB0016           To MVC if there is a CB.                                  
 0125CA 0119                        3170+         DC    X'0119' Hex by RPR 11/12/02 No? Stop and take a dump.                        
 0125CC C3C2F1F0F040D7D6            3171+         DC    C'CB100 POOL IS EMPTY' Label the error.                                      
 0125E0 D203 B000 A000 00000 00000  3172+GTCB0016    MVC 0(4,11),0(10)           Update header.                                      
 0125E6 D7FF A000 A000 00000 00000  3173          XC    0(CB100LTH,10),0(10)   Clear the RQE Block                                   
 000000                             3174          USING RQE,10                 RQE addressability                                    
 0125EC 5010 A004            00004  3175          ST    1,RQEIOB               Save addr. IOB for RQE                                
 0125F0 D203 A000 C0D6 00000 12686  3176          MVC   RQEIDENT(4),RQECHRS    Put RQE Ident chars in                                
 0125F6 5040 A00C            0000C  3177          ST    4,RQETCB               Save address user's TCB                               
 0125FA 5050 A010            00010  3178          ST    5,RQERB                Save address user's RB                                
                                    3179 *                                                                                           
                                    3180 * 3) Find UCB with device address matching one from IOB                                     
                                    3181 *                                                                                           
 000000                             3182          USING IOB,1                  Establish IOB addr                                    
 000000                             3183          USING UCB,8                  Addressability for UCB                                
 0125FE 4180 0800            00800  3184          LA    8,UCB1                 Get @ first UCB                                       
 012602 D501 1004 8004 00004 00004  3185 TSTUCB   CLC   IOBDEVAD(2),UCBCHAN    Check if right UCB found                              
 012608                             3186          DROP  1                      Done with IOB                                         
 012608 4780 C06A            1261A  3187          BE    UCBFND                 If so, then move on                                   
 01260C 5880 8008            00008  3188          L     8,UCBUCB               Get @ next UCB                                        
 012610 1288                        3189          LTR   8,8                    Check if null                                         
 012612 4780 C0D4            12684  3190          BZ    RQE0119                If bad, then die                                      
 012616 47F0 C052            12602  3191          B     TSTUCB                 Check next UCB                                        
 01261A 5080 A008            00008  3192 UCBFND   ST    8,RQEUCB               Save ptr to UCB in RQE                                
                                    3193 *                                                                                           
                                    3194 * 4) Insert RQE into Queue of RQEs                                                          
                                    3195 *                                                                                           
 01261E                             3196          DROP  10                     Done with new RQE                                     
 01261E D503 C0DC 8014 1268C 00014  3197          CLC   RQEZEROS(4),UCBWARQE   Check if head null                                    
 012624 4780 C08E            1263E  3198          BE    HEADINS                If so, insert at head                                 
 012628 5870 8014            00014  3199          L     7,UCBWARQE             If not, get @ first RQE                               
 000000                             3200          USING RQE,7                  Refer to RQE ending list                              
 01262C D503 C0DC 7014 1268C 00014  3201 LOOPRQE  CLC   RQEZEROS(4),RQENRQE    Check if NEXT = 0                                     
 012632 4780 C096            12646  3202          BE    INSRQE                 If so, insert right here                              
 012636 5870 7014            00014  3203          L     7,RQENRQE              Otherwise move to next RQE                            
 01263A 47F0 C07C            1262C  3204          B     LOOPRQE                Loop through next RQE                                 
 01263E 50A0 8014            00014  3205 HEADINS  ST    10,UCBWARQE            Save @ first RQE                                      
1       SVC 13                                                                                                  PAGE   57            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 012642 47F0 C09A            1264A  3206          B     DONEINS                Done inserting                                        
 012646 50A0 7014            00014  3207 INSRQE   ST    10,RQENRQE             Point to new RQE                                      
 01264A                             3208          DROP  7                      Done with ending RQE                                  
                                    3209 *                                                                                           
                                    3210 * 5) After inserting, call SVC 1 to make RB non-dispatchable                                
                                    3211 *                                                                                           
 000000                             3212          USING RQE,10                 Refer to new RQE again                                
 01264A 4100 0001            00001  3213 DONEINS  LA    0,1                    R0=1 ECB                                              
 01264E 4110 A018            00018  3214          LA    1,RQEIOECB             R1=A(RQEIOECB)                                        
 012652 5860 3004            00004  3215          L     6,CVTSVCTA             Get A(SVC Table)                                      
 012656 4160 6008            00008  3216          LA    6,1*8(,6)              Go to entry for SVC 1                                 
 01265A 5860 6000            00000  3217          L     6,0(,6)                Get A(SVC 1)                                          
 01265E 1266                        3218          LTR   6,6                    Check to see if valid                                 
 012660 4780 C0D4            12684  3219          BZ    RQE0119                If not, bomb out                                      
 012664 95F0 00BF      000BF        3220          CLI   TYP1FLAG,C'0'          Check TYP1FLAG is 0                                   
 012668 4770 00BC            000BC  3221          BNE   LEVELABN               If not, something wrong                               
 01266C 92F1 00BF      000BF        3222          MVI   TYP1FLAG,C'1'          Set TYP1FLAG to 1                                     
 012670 05E6                        3223          BALR  14,6                   Branch entry into SVC 1                               
 012672 95F1 00BF      000BF        3224          CLI   TYP1FLAG,C'1'          Check TYP1FLAG is 1                                   
 012676 4770 00BC            000BC  3225          BNE   LEVELABN               If not, something wrong                               
 01267A 92F0 00BF      000BF        3226          MVI   TYP1FLAG,C'0'          Set TYP1FLAG to 0                                     
                                    3227 *                                                                                           
                                    3228 * 6) Complete RQEENQ by branching to the BEGINIO routine                                    
                                    3229 *                                                                                           
 01267E 58C0 3020            00020  3230          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 012682 07FC                        3231          BR    12                     Branch to BEGINIO Routine                             
                                    3232 *                                                                                           
 012684 0119                        3233 RQE0119  XOPC  25                     Die if something bad happens                          
 012686                             3234          DROP  3,8,10,12              Done with all registers                               
                                    3235 *                                                                                           
                                    3236 ******************************                                                              
                                    3237 * RQE Working Storage                                                                       
                                    3238 ******************************                                                              
                                    3239 *                                                                                           
 012686 D9D8C540                    3240 RQECHRS  DC    CL4'RQE '              For initializing RQEIDENT                             
 01268C 00000000                    3241 RQEZEROS DC    F'0'                   For checking RQENRQE                                  
                                    3242 *                                                                                           
                                    3243 **********************************************************************                      
                                    3244 * CHAP - Change priority (not used in this version)                                         
                                    3245 **********************************************************************                      
                                    3246 *                                                                                           
 012690 58C0 004C            0004C  3247 CHAP     L     12,76                  Get A(CVT)                                            
 012694 58C0 C01C            0001C  3248          L     12,X'1C'(,12)          Get CVT0DS ( A(DISPATCHER )                           
 012698 07FC                        3249          BR    12                     Go back to the dispatcher                             
                                    3250 *                                                                                           
                                    3251 *********************************************************************                       
                                    3252 * BEGINIO                                                                                   
                                    3253 *                                                                                           
                                    3254 * Entry Conditions:                                                                         
                                    3255 * R12 - Entry address/ Base Register                                                        
                                    3256 * Register usage:                                                                           
                                    3257 * R3 - A(CVT)                                                                               
                                    3258 * R6 - Used for looping through UCB Chain                                                   
                                    3259 * R7 - Address of RQE to DeQueue                                                            
                                    3260 **********************************************************************                      
                                    3261 *                                                                                           
 01269A                             3262          USING BEGINIO,12             BEGINIO Addressability                                
1       SVC 13                                                                                                  PAGE   58            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 01269A 5830 004C            0004C  3263 BEGINIO  L     3,76                   Get A(CVT)                                            
 000000                             3264          USING CVT,3                  CVT Addressability                                    
 01269E 5860 300C            0000C  3265          L     6,CVTUCBS              Get start @ UCBs                                      
 000000                             3266          USING UCB,6                  Addressability to UCB                                 
                                    3267 *                                                                                           
                                    3268 * Check if UCB is busy                                                                      
                                    3269 *                                                                                           
 0126A2 95FF 6006      00006        3270 BGIOLOP  CLI   UCBFLA,X'FF'           Check UCB busy                                        
 0126A6 4780 C03A            126D4  3271          BE    NEXTUCB                If so, go to next UCB                                 
                                    3272 *                                                                                           
                                    3273 * Check For RQE attached to UCB                                                             
                                    3274 *                                                                                           
 0126AA 5870 6014            00014  3275          L     7,UCBWARQE             Get Addr first RQE                                    
 000000                             3276          USING RQE,7                  RQE Addressability                                    
 0126AE 1277                        3277          LTR   7,7                    Check if it's null                                    
 0126B0 4780 C03A            126D4  3278          BZ    NEXTUCB                If it is, check next UCB                              
                                    3279 *                                                                                           
                                    3280 * If (UCB not busy) AND (RQE attached and waiting)                                          
                                    3281 *                                                                                           
                                    3282 *                                                                                           
                                    3283 * Dequeue the 1st RQE in the UCBWARQE                                                       
                                    3284 *                                                                                           
 0126B4 D203 6014 7014 00014 00014  3285          MVC   UCBWARQE(4),RQENRQE    Remove RQE from chain                                 
 0126BA D203 7014 C052 00014 126EC  3286          MVC   RQENRQE(4),BGIONEG1    Set ptr to -1                                         
 0126C0 D503 6010 C04E 00010 126E8  3287          CLC   UCBCURQE(4),BGIOZERO   Verify UCBCURQE zero                                  
 0126C6 4770 C04A            126E4  3288          BNZ   BGIO0119               If NZ, die                                            
 0126CA 5070 6010            00010  3289          ST    7,UCBCURQE             Put A(first RQE) into UCB                             
 0126CE 58C0 6018            00018  3290          L     12,UCBIOSTR            Get @(SIO Rtn for device)                             
 0126D2 07FC                        3291          BR    12                     Go to SIO Rtn for device                              
                                    3292 *                                                                                           
 0126D4 5860 6008            00008  3293 NEXTUCB  L     6,UCBUCB               Get A(Next UCB)                                       
 0126D8 1266                        3294          LTR   6,6                    Check if last UCB                                     
 0126DA 4770 C008            126A2  3295          BNZ   BGIOLOP                If so, done, go to chap                               
                                    3296 *                                                                                           
                                    3297 * Instead of going to CHAP, go to DISPATCHER                                                
                                    3298 *                                                                                           
 0126DE 58C0 3024            00024  3299 BGIODONE L     12,CVTCHAP             Get A(Chap) Routine                                   
 0126E2 07FC                        3300          BR    12                     Exit to CHAP                                          
 0126E4                             3301          DROP  3,7,12                 Done with registers                                   
 0126E4 0119                        3302 BGIO0119 XOPC  25                     Die here                                              
                                    3303 *********************************                                                           
                                    3304 * BEGINIO Storage                                                                           
                                    3305 *********************************                                                           
 0126E8 00000000                    3306 BGIOZERO DC    F'0'                   For checking UCBCURQE                                 
 0126EC FFFFFFFF                    3307 BGIONEG1 DC    F'-1'                  For updating RQENRQE                                  
1       SIO ROUTINE FOR 000C                                                                                    PAGE   59            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    3309 *********************************************************************                       
                                    3310 * SIOC                                                                                      
                                    3311 *                                                                                           
                                    3312 * Entry Conditions:                                                                         
                                    3313 * R3  = A(CVT)                                                                              
                                    3314 * R6  = A(UCB)                                                                              
                                    3315 * R7  = A(RQE)                                                                              
                                    3316 * R12 = Routine Address                                                                     
                                    3317 *                                                                                           
                                    3318 * Reg Usage:                                                                                
                                    3319 * R4 = A(TCB)                                                                               
                                    3320 * R8 = A(IOB) from RQE                                                                      
                                    3321 * R9 = A(CCW), stored into the CAW+1                                                        
                                    3322 * R10 = Device Address from UCB                                                             
                                    3323 *                                                                                           
                                    3324 * Logic:                                                                                    
                                    3325 * 1) Get address of buffer from IOB and put into CCW                                        
                                    3326 * 2) Set Channel Program address in the CAW at X'48'                                        
                                    3327 * 3) Issue the SIO instruction                                                              
                                    3328 * 4) Test condition code following SIO                                                      
                                    3329 * 5) Set flag in UCB to indicate busy                                                       
                                    3330 * 6) Get value of clock into LOWTIME                                                        
                                    3331 * 7) Store time of SIO into TCB from RQE                                                    
                                    3332 *********************************************************************                       
                                    3333 *                                                                                           
 0126F0                             3334          USING SIOC,12                SIOC Rtn Addressability                               
 000000                             3335          USING RQE,7                  Establish RQE Addr                                    
 000000                             3336          USING UCB,6                  Establish UCB Addr                                    
 000000                             3337          USING CVT,3                  Establish CVT Addr                                    
 0126F0 5880 7004            00004  3338 SIOC     L     8,RQEIOB               Get A(IOB)                                            
 000000                             3339          USING IOB,8                  Addressability to IOB                                 
 0126F4 D202 C049 8009 12739 00009  3340          MVC   CCWC+1(3),IOBUFADD+1   Put Buffer @ into CCW                                 
 0126FA                             3341          DROP  8                      Done with the IOB                                     
 0126FA 4190 C048            12738  3342          LA    9,CCWC                 Get A(Channel Program)                                
 0126FE BE97 0049            00049  3343          STCM  9,7,X'49'              Save Address into CAW                                 
 012702 9200 0048      00048        3344          MVI   X'48',X'00'            Set key in CAW to zero                                
 012706 9C00 000C      0000C        3345          SIO   X'00C'                 Perform the SIO Instruction                           
 01270A 4770 C044            12734  3346          BNZ   SIOC0119               If CC NZ, Die                                         
 01270E 92FF 6006      00006        3347          MVI   UCBFLA,X'FF'           Set flag in UCB to ind. busy                          
 012712 D203 00B0 0050 000B0 00050  3348          MVC   LOWTIME(4),CLOCK       Get clock value into LOWTIME                          
 012718 5840 700C            0000C  3349          L     4,RQETCB               Get A(TCB) requesting IO                              
 000000                             3350          USING TCB,4                  Establish TCB Addressability                          
 01271C D203 4018 00B0 00018 000B0  3351          MVC   TCBTSSIO(4),LOWTIME    Put time of SIO into TCB                              
 012722 BF11 40C0            000C0  3352          ICM   1,1,TCBIOCNT           Get I/O count for device C                            
 012726 4110 1001            00001  3353          LA    1,1(,1)                Increment by one                                      
 01272A BE11 40C0            000C0  3354          STCM  1,1,TCBIOCNT           Save new I/O count                                    
 01272E 58C0 3020            00020  3355          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 012732 07FC                        3356          BR    12                     Go back to BEGINIO                                    
 012734                             3357          DROP  4,6,7,12               Done with Regs                                        
 012734 0119                        3358 SIOC0119 XOPC  25                     Die if something goes wrong                           
                                    3359 *                                                                                           
                                    3360 *********************************************************************                       
                                    3361 * SIOC STORAGE                                                                              
                                    3362 *********************************************************************                       
                                    3363 *                                                                                           
                                    3364 CCWC     CCW   READ,0,0,X'50'                                                               
 012738 0200000000000050            3365+CCWC     DC   0D'0',AL1(READ),AL3(0),AL1(0),X'0',AL2(X'50')                                 
1       SIO ROUTINE FOR 000C                                                                                    PAGE   60            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
                                    3366 *                                                                                           
                                    3367 *********************************************************************                       
                                    3368 * SIOD - Start IO for Device X'00D'                                                         
                                    3369 *                                                                                           
                                    3370 * Entry Conditions:                                                                         
                                    3371 * R3  = A(CVT)                                                                              
                                    3372 * R6  = A(UCB)                                                                              
                                    3373 * R7  = A(RQE)                                                                              
                                    3374 * R12 = Routine Address                                                                     
                                    3375 *                                                                                           
                                    3376 * Reg Usage:                                                                                
                                    3377 * R4 = A(TCB)                                                                               
                                    3378 * R8 = A(IOB) from RQE                                                                      
                                    3379 * R9 = A(CCW), stored into the CAW+1                                                        
                                    3380 * R10 = Device Address from UCB                                                             
                                    3381 *                                                                                           
                                    3382 * Logic:                                                                                    
                                    3383 * 1) Get address of buffer from IOB and put into CCW                                        
                                    3384 * 2) Set Channel Program address in the CAW at X'48'                                        
                                    3385 * 3) Issue the SIO instruction                                                              
                                    3386 * 4) Test condition code following SIO                                                      
                                    3387 * 5) Set flag in UCB to indicate busy                                                       
                                    3388 * 6) Get value of clock into LOWTIME                                                        
                                    3389 * 7) Store time of SIO into TCB from RQE                                                    
                                    3390 *                                                                                           
                                    3391 *********************************************************************                       
 012740                             3392          USING SIOD,12                SIOD Rtn Addressability                               
 000000                             3393          USING RQE,7                  Establish RQE Addr                                    
 000000                             3394          USING UCB,6                  Establish UCB Addr                                    
 000000                             3395          USING CVT,3                  Establish CVT Addr                                    
 012740 5880 7004            00004  3396 SIOD     L     8,RQEIOB               Get A(IOB)                                            
 000000                             3397          USING IOB,8                  Addressability to IOB                                 
 012744 D202 C049 8009 12789 00009  3398          MVC   CCWD+1(3),IOBUFADD+1   Put Buffer @ into CCW                                 
 01274A                             3399          DROP  8                      Done with the IOB                                     
 01274A 4190 C048            12788  3400          LA    9,CCWD                 Get A(Channel Program)                                
 01274E BE97 0049            00049  3401          STCM  9,7,X'49'              Save Address into CAW                                 
 012752 9200 0048      00048        3402          MVI   X'48',X'00'            Set key in CAW to zero                                
 012756 9C00 000D      0000D        3403          SIO   X'00D'                 Perform the SIO Instruction                           
 01275A 4770 C044            12784  3404          BNZ   SIOD0119               If CC NZ, Die                                         
 01275E 92FF 6006      00006        3405          MVI   UCBFLA,X'FF'           Set flag in UCB to ind. busy                          
 012762 D203 00B0 0050 000B0 00050  3406          MVC   LOWTIME(4),CLOCK       Get clock value into LOWTIME                          
 012768 5840 700C            0000C  3407          L     4,RQETCB               Get A(TCB) requesting IO                              
 000000                             3408          USING TCB,4                  Establish TCB Addressability                          
 01276C D203 4018 00B0 00018 000B0  3409          MVC   TCBTSSIO(4),LOWTIME    Put time of SIO into TCB                              
 012772 BF11 40C1            000C1  3410          ICM   1,1,TCBIOCNT+1         Get I/O count for device D                            
 012776 4110 1001            00001  3411          LA    1,1(,1)                Increment by one                                      
 01277A BE11 40C1            000C1  3412          STCM  1,1,TCBIOCNT+1         Save new I/O count                                    
 01277E 58C0 3020            00020  3413          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 012782 07FC                        3414          BR    12                     Go back to BEGINIO                                    
 012784                             3415          DROP  4,6,7,12               Done with Regs                                        
 012784 0119                        3416 SIOD0119 XOPC  25                     Die if something goes wrong                           
                                    3417 *                                                                                           
                                    3418 *********************************************************************                       
                                    3419 * SIOD STORAGE                                                                              
                                    3420 *********************************************************************                       
                                    3421 *                                                                                           
                                    3422 CCWD     CCW   READ,0,0,X'50'                                                               
1       SIO ROUTINE FOR 000C                                                                                    PAGE   61            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 012788 0200000000000050            3423+CCWD     DC   0D'0',AL1(READ),AL3(0),AL1(0),X'0',AL2(X'50')                                 
                                    3424 *********************************************************************                       
                                    3425 * SIOE - Start IO for Device X'00E'                                                         
                                    3426 *                                                                                           
                                    3427 * Entry Conditions:                                                                         
                                    3428 * R3  = A(CVT)                                                                              
                                    3429 * R6  = A(UCB)                                                                              
                                    3430 * R7  = A(RQE)                                                                              
                                    3431 * R12 = Routine Address                                                                     
                                    3432 *                                                                                           
                                    3433 * Register Usage:                                                                           
                                    3434 * R4  = A(TCB) from RQE                                                                     
                                    3435 * R8  = A(IOB) from RQE                                                                     
                                    3436 * R9  = A(Buffer) from IOB                                                                  
                                    3437 * R10 = A(first CCW) saved into CAW                                                         
                                    3438 *********************************************************************                       
 012790                             3439          USING SIOE,12                SIOE Rtn Addressability                               
 000000                             3440          USING RQE,7                  Establish RQE Addr                                    
 000000                             3441          USING UCB,6                  Establish UCB Addr                                    
 000000                             3442          USING CVT,3                  Establish CVT Addr                                    
 012790 5880 7004            00004  3443 SIOE     L     8,RQEIOB               Get A(IOB)                                            
 000000                             3444          USING IOB,8                  Addressability to IOB                                 
 012794 5890 8008            00008  3445          L     9,IOBUFADD             Get A(Buffer) from IOB                                
 012798 95F1 9000      00000        3446          CLI   0(9),C'1'              Check if CC New page                                  
 01279C 4780 C038            127C8  3447          BE    SIOENEWP               If so, new page                                       
 0127A0 9540 9000      00000        3448          CLI   0(9),C' '              Check if CC single space                              
 0127A4 4780 C044            127D4  3449          BE    SIOESS                 If so, single space                                   
 0127A8 95F0 9000      00000        3450          CLI   0(9),C'0'              Check if CC double space                              
 0127AC 4780 C050            127E0  3451          BE    SIOEDS                 If so, double space                                   
 0127B0 9560 9000      00000        3452          CLI   0(9),C'-'              Check if CC triple space                              
 0127B4 4780 C05C            127EC  3453          BE    SIOETS                 If so, triple space                                   
 0127B8 954E 9000      00000        3454          CLI   0(9),C'+'              Check if CC append                                    
 0127BC 4770 C044            127D4  3455          BNE   SIOESS                 If no match single space                              
 0127C0 41A0 C0C0            12850  3456          LA    10,CCWE2               Set address for CAW                                   
 0127C4 47F0 C068            127F8  3457          B     DONEECC                Done with CC,move on                                  
 0127C8 928B C0B8      12848        3458 SIOENEWP MVI   CCWE1,SKIPCH1          Skip to top of page                                   
 0127CC 41A0 C0B8            12848  3459          LA    10,CCWE1               Set address for CAW                                   
 0127D0 47F0 C068            127F8  3460          B     DONEECC                Done with CC, move on                                 
 0127D4 920B C0B8      12848        3461 SIOESS   MVI   CCWE1,SPACE1IM         Space 1 line immediately                              
 0127D8 41A0 C0B8            12848  3462          LA    10,CCWE1               Set address for CAW                                   
 0127DC 47F0 C068            127F8  3463          B     DONEECC                Done with CC, move on                                 
 0127E0 9213 C0B8      12848        3464 SIOEDS   MVI   CCWE1,SPACE2IM         Space 2 lines immediately                             
 0127E4 41A0 C0B8            12848  3465          LA    10,CCWE1               Set address for CAW                                   
 0127E8 47F0 C068            127F8  3466          B     DONEECC                Done with CC, move on                                 
 0127EC 921B C0B8      12848        3467 SIOETS   MVI   CCWE1,SPACE3IM         Space 3 lines immediately                             
 0127F0 41A0 C0B8            12848  3468          LA    10,CCWE1               Set address for CAW                                   
 0127F4 47F0 C068            127F8  3469          B     DONEECC                Done with CC, move on                                 
 0127F8 92C5 9084      00084        3470 DONEECC  MVI   132(9),C'E'            Mark users output with an E                           
 0127FC 5840 700C            0000C  3471          L     4,RQETCB               Get A(TCB) requesting IO                              
 000000                             3472          USING TCB,4                  Establish TCB Addressability                          
 012800 D200 9083 400B 00083 0000B  3473          MVC   131(1,9),TCBTNAME+3    Indicate Which TCB on print-out                       
 012806 4190 9001            00001  3474          LA    9,1(,9)                Set Buffer @ for 2nd CCW                              
 01280A BE97 C0C1            12851  3475          STCM  9,7,CCWE2+1            Save Buffer @ in 2nd CCW                              
 01280E BEA7 0049            00049  3476          STCM  10,7,CAW+1             Save A(Channel Pgm) into CAW                          
 012812 9200 0048      00048        3477          MVI   CAW,X'00'              Set key in CAW                                        
 012816 9C00 000E      0000E        3478          SIO   X'00E'                 Start the I/O                                         
 01281A 4770 C0B0            12840  3479          BNZ   SIOE0119               If CC NZ, bomb and check things                       
1       SIO ROUTINE FOR 000C                                                                                    PAGE   62            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 01281E 92FF 6006      00006        3480          MVI   UCBFLA,X'FF'           Mark UCB as busy                                      
 012822 D203 00B0 0050 000B0 00050  3481          MVC   LOWTIME(4),CLOCK       Get clock value into LOWTIME                          
 012828 D203 4018 00B0 00018 000B0  3482          MVC   TCBTSSIO(4),LOWTIME    Put time of SIO into TCB                              
 01282E BF11 40C2            000C2  3483          ICM   1,1,TCBIOCNT+2         Get I/O count for device D                            
 012832 4110 1001            00001  3484          LA    1,1(,1)                Increment by one                                      
 012836 BE11 40C2            000C2  3485          STCM  1,1,TCBIOCNT+2         Save new I/O count                                    
 01283A 58C0 3020            00020  3486          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 01283E 07FC                        3487          BR    12                     Go back to BEGINIO                                    
 012840 0119                        3488 SIOE0119 XOPC  25                     Die                                                   
 012842                             3489          DROP  3,4,6,7,8,12           Done with registers for SIO                           
                                    3490 *                                                                                           
                                    3491 *********************************************************************                       
                                    3492 * SIOE STORAGE                                                                              
                                    3493 *********************************************************************                       
                                    3494 *                                                                                           
                                    3495 * No spacing determined, no buffer to write from, chain byte,                               
                                    3496 * 1 character                                                                               
                                    3497 *                                                                                           
                                    3498 CCWE1    CCW   0,0,X'40',1                                                                  
 012848 0000000040000001            3499+CCWE1    DC   0D'0',AL1(0),AL3(0),AL1(X'40'),X'0',AL2(1)                                    
                                    3500 *                                                                                           
                                    3501 * Write w/0 spacing, no buffer, no flag, Length of 132 chars                                
                                    3502 *                                                                                           
                                    3503 CCWE2    CCW   WRITEWO,0,0,X'84'                                                            
 012850 0100000000000084            3504+CCWE2    DC   0D'0',AL1(WRITEWO),AL3(0),AL1(0),X'0',AL2(X'84')                              
                                    3505 *                                                                                           
                                    3506 *********************************************************************                       
                                    3507 * SIOF - Start IO for Device X'00F'                                                         
                                    3508 *                                                                                           
                                    3509 * Entry Conditions:                                                                         
                                    3510 * R3  = A(CVT)                                                                              
                                    3511 * R6  = A(UCB)                                                                              
                                    3512 * R7  = A(RQE)                                                                              
                                    3513 * R12 = Routine Address                                                                     
                                    3514 *                                                                                           
                                    3515 * Register Usage:                                                                           
                                    3516 * R4  = A(TCB) from RQE                                                                     
                                    3517 * R8  = A(IOB) from RQE                                                                     
                                    3518 * R9  = A(Buffer) from IOB                                                                  
                                    3519 * R10 = A(first CCW) saved into CAW                                                         
                                    3520 *********************************************************************                       
                                    3521 *                                                                                           
 012858                             3522          USING SIOF,12                SIOF Rtn Addressability                               
 000000                             3523          USING RQE,7                  Establish RQE Addr                                    
 000000                             3524          USING UCB,6                  Establish UCB Addr                                    
 000000                             3525          USING CVT,3                  Establish CVT Addr                                    
 012858 5880 7004            00004  3526 SIOF     L     8,RQEIOB               Get A(IOB)                                            
 000000                             3527          USING IOB,8                  Addressability to IOB                                 
 01285C 5890 8008            00008  3528          L     9,IOBUFADD             Get A(Buffer) from IOB                                
 012860 95F1 9000      00000        3529          CLI   0(9),C'1'              Check if CC New page                                  
 012864 4780 C038            12890  3530          BE    SIOFNEWP               If so, new page                                       
 012868 9540 9000      00000        3531          CLI   0(9),C' '              Check if CC single space                              
 01286C 4780 C044            1289C  3532          BE    SIOFSS                 If so, single space                                   
 012870 95F0 9000      00000        3533          CLI   0(9),C'0'              Check if CC double space                              
 012874 4780 C050            128A8  3534          BE    SIOFDS                 If so, double space                                   
 012878 9560 9000      00000        3535          CLI   0(9),C'-'              Check if CC triple space                              
 01287C 4780 C05C            128B4  3536          BE    SIOFTS                 If so, triple space                                   
1       SIO ROUTINE FOR 000C                                                                                    PAGE   63            
0  LOC  OBJECT CODE    ADDR1 ADDR2  STMT   SOURCE STATEMENT                                                                          
 012880 954E 9000      00000        3537          CLI   0(9),C'+'              Check if CC append                                    
 012884 4770 C044            1289C  3538          BNE   SIOFSS                 If no match-up single space                           
 012888 41A0 C0C0            12918  3539          LA    10,CCWF2               Set address for CAW                                   
 01288C 47F0 C068            128C0  3540          B     DONEFCC                Done with setting CC,move on                          
 012890 928B C0B8      12910        3541 SIOFNEWP MVI   CCWF1,SKIPCH1          Skip to top of page                                   
 012894 41A0 C0B8            12910  3542          LA    10,CCWF1               Set address for CAW                                   
 012898 47F0 C068            128C0  3543          B     DONEFCC                Done with CC, move on                                 
 01289C 920B C0B8      12910        3544 SIOFSS   MVI   CCWF1,SPACE1IM         Space 1 line immediately                              
 0128A0 41A0 C0B8            12910  3545          LA    10,CCWF1               Set address for CAW                                   
 0128A4 47F0 C068            128C0  3546          B     DONEFCC                Done with CC, move on                                 
 0128A8 9213 C0B8      12910        3547 SIOFDS   MVI   CCWF1,SPACE2IM         Space 2 lines immediately                             
 0128AC 41A0 C0B8            12910  3548          LA    10,CCWF1               Set address for CAW                                   
 0128B0 47F0 C068            128C0  3549          B     DONEFCC                Done with CC, move on                                 
 0128B4 921B C0B8      12910        3550 SIOFTS   MVI   CCWF1,SPACE3IM         Space 3 lines immediately                             
 0128B8 41A0 C0B8            12910  3551          LA    10,CCWF1               Set address for CAW                                   
 0128BC 47F0 C068            128C0  3552          B     DONEFCC                Done with CC, move on                                 
 0128C0 92C6 9084      00084        3553 DONEFCC  MVI   132(9),C'F'            Mark users output with F                              
 0128C4 5840 700C            0000C  3554          L     4,RQETCB               Get A(TCB) requesting IO                              
 000000                             3555          USING TCB,4                  Establish TCB Addressability                          
 0128C8 D200 9083 400B 00083 0000B  3556          MVC   131(1,9),TCBTNAME+3    Indicate Which TCB on print-out                       
 0128CE 4190 9001            00001  3557          LA    9,1(,9)                Set Buffer @ for 2nd CCW                              
 0128D2 BE97 C0C1            12919  3558          STCM  9,7,CCWF2+1            Save Buffer @ in 2nd CCW                              
 0128D6 BEA7 0049            00049  3559          STCM  10,7,CAW+1             Save A(Channel Pgm) into CAW                          
 0128DA 9200 0048      00048        3560          MVI   CAW,X'00'              Set key in CAW                                        
 0128DE 9C00 000F      0000F        3561          SIO   X'00F'                 Start the I/O                                         
 0128E2 4770 C0B0            12908  3562          BNZ   SIOF0119               If CC NZ, bomb                                        
 0128E6 92FF 6006      00006        3563          MVI   UCBFLA,X'FF'           Mark UCB as busy                                      
 0128EA D203 00B0 0050 000B0 00050  3564          MVC   LOWTIME(4),CLOCK       Get clock value into LOWTIME                          
 0128F0 D203 4018 00B0 00018 000B0  3565          MVC   TCBTSSIO(4),LOWTIME    Put time of SIO into TCB                              
 0128F6 BF11 40C3            000C3  3566          ICM   1,1,TCBIOCNT+3         Get I/O count for device E                            
 0128FA 4110 1001            00001  3567          LA    1,1(,1)                Increment by one                                      
 0128FE BE11 40C3            000C3  3568          STCM  1,1,TCBIOCNT+3         Save new I/O count                                    
 012902 58C0 3020            00020  3569          L     12,CVTBGNIO            Get A(BEGINIO)                                        
 012906 07FC                        3570          BR    12                     Go back to BEGINIO                                    
 012908 0119                        3571 SIOF0119 XOPC  25                     Die                                                   
 01290A                             3572          DROP  3,4,6,7,8,12           Done with regs for SIO                                
                                    3573 *                                                                                           
                                    3574 *********************************************************************                       
                                    3575 * SIOF STORAGE                                                                              
                                    3576 *********************************************************************                       
                                    3577 *                                                                                           
                                    3578 * No spacing determined, no buffer to write from, chain byte,                               
                                    3579 * 1 character                                                                               
                                    3580 *                                                                                           
                                    3581 CCWF1    CCW   0,0,X'40',1                                                                  
 012910 0000000040000001            3582+CCWF1    DC   0D'0',AL1(0),AL3(0),AL1(X'40'),X'0',AL2(1)                                    
                                    3583 *                                                                                           
                                    3584 * Write w/0 spacing, no buffer, no flag, Length of 132 chars                                
                                    3585 *                                                                                           
                                    3586 CCWF2    CCW   WRITEWO,0,0,X'84'                                                            
 012918 0100000000000084            3587+CCWF2    DC   0D'0',AL1(WRITEWO),AL3(0),AL1(0),X'0',AL2(X'84')                              
                                    3588 *                                                                                           
                                    3589 *******                                                                                     
                                    3590 *                                                                                           
 020000                             3591          ORG   FIRST4K+X'20000'       CREATE ADDRESSABLE SPACE                              
 020000 C8C9C7C8C5E2E340            3592 HIGHEST  DC    CL8'HIGHEST'           HIGHEST address                                       
                                    3593          END   FIRST4K                END OF THE 1ST 4K CSECT                               
1***  NO   STATEMENTS FLAGGED -  NO   WARNINGS,  NO   ERRORS                                                                         
 *** DYNAMIC CORE AREA USED:   225508 LOW +    9844 HIGH, LEAVING  282792 FREE BYTES. AVERAGE:       65 BYTES/STMT ***               
 *** ASSEMBLY TIME =    0.042 SECS,    85571 STATEMENTS/SEC ***                                                                      
 *** PROGRAM EXECUTION BEGINNING - ANY OUTPUT BEFORE EXECUTION TIME MESSAGE IS PRODUCED BY USER PROGRAM ***                          
                                                                                                                                     
 TRACE-->   INSTR ADDR:  003016   INSTR:  0878                                                                                       
 CVTMZ00 is 000207FF                                                                                                                 
 TRACE-->   INSTR ADDR:  00246A   INSTR:  8200 00A0                                                                                  
 TRACE--> TIME: 00069821  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040001 4F012048; NPSW= 01040119 0F004014                                 
 TRACE--> TIME: 0006D49A  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040008 4F012196; NPSW= 01040119 0F004014                                 
 TRACE--> TIME: 000AD56B  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040000 5F012312; NPSW= 01040119 0F004014                                 
 TRACE-->   INSTR ADDR:  012816   INSTR:  9C00 000E                                                                                  
 TRACE--> TIME: 000AD586;  CCW ADDR: 012848;  CCW: 0B 000000 4000 0001                                                               
 TRACE--> TIME: 000AD586;  CCW ADDR: 012850;  CCW: 01 0124A9 0000 0084                                                               
 TRACE--> TIME: 000F4EFB  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040000 5F012312; NPSW= 01040119 0F004014                                 
 TRACE--> TIME: 0013F6A5  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040000 5F012312; NPSW= 01040119 0F004014                                 
 TRACE-->   INSTR ADDR:  012816   INSTR:  9C00 000E                                                                                  
 TRACE--> TIME: 0013F6C0;  CCW ADDR: 012848;  CCW: 0B 000000 4000 0001                                                               
 TRACE--> TIME: 0013F6C0;  CCW ADDR: 012850;  CCW: 01 0124A9 0000 0084                                                               
 TRACE--> TIME: 001E1690  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040000 5F012312; NPSW= 01040119 0F004014                                 
 TRACE--> TIME: 0023D69B  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040000 5F012312; NPSW= 01040119 0F004014                                 
 TRACE--> TIME: 0024D1AF  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040003 4F002852; NPSW= 01040119 0F004014                                 
0SOS TERMINATING!    TCB NAME: TCB4 BDT PGM NAME: OBJMODNI PROBLEM: 00000016 SUPER: 00000098 TCBTWAIT=000423A8 TCBIOCNT=00010008     
 TRACE--> TIME: 00324D76  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040003 4F002852; NPSW= 01040119 0F004014                                 
0SOS TERMINATING!    TCB NAME: TCB2 BDT PGM NAME: SOSPGM09 PROBLEM: 000000C9 SUPER: 00000098 TCBTWAIT=001B1E8B TCBIOCNT=0032003A     
 TRACE--> TIME: 00482B5B  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040003 4F002852; NPSW= 01040119 0F004014                                 
0SOS TERMINATING!    TCB NAME: TCB3 BDT PGM NAME: SOSPGM02 PROBLEM: 00000069 SUPER: 00000099 TCBTWAIT=001CD699 TCBIOCNT=00181A06     
 TRACE--> TIME: 004EF42D  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040003 4F002852; NPSW= 01040119 0F004014                                 
0SOS TERMINATING!    TCB NAME: TCB5 BDT PGM NAME: SOSPGM09 PROBLEM: 000000C6 SUPER: 00000099 TCBTWAIT=001E1D0C TCBIOCNT=0035003D     
 TRACE--> TIME: 0057647E  PSW SWAP--CAUSE=SVC INT.  OPSW= FF040003 4F002852; NPSW= 01040119 0F004014                                 
0SOS TERMINATING!    TCB NAME: TCB1 BDT PGM NAME: SOSPGM02 PROBLEM: 00000147 SUPER: 0000009A TCBTWAIT=003CF322 TCBIOCNT=00525406     
0*** ASSIST-V FINAL STATISTICS ***                                                                                                   
 SIMULATED CLOCK TIME=   5727406 TIMER UNITS                                                                                         
 CPU UTILIZATION:       BUSY      0.6%  SUPER     0.5%  PROBLEM   0.0%                                                               
 CHANNEL UTILIZATION:   CH0      99.9%  CH1       0.0%  CH2       0.0%                                                               
 PROCESSOR OVERLAP:     CPU/CH0   0.5%  CPU/CH1   0.0%  CPU/CH2   0.0%                                                               
 DISK ARM MOVEMENT:     DISK101          0 SEEKS,          0 CYLINDERS CROSSED                                                       
0*** EXECUTION TIME =    0.313 SECS.    257038 INSTRUCTIONS EXECUTED -   821207 INSTRUCTIONS/SEC ***                                 
 *** FIRST CARD NOT READ: NO CARDS READ:FILE UNOPENED                                                                                
0*** ASSIST COMPLETION DUMP ***                                                                                                      
0*** PSW AT ABEND FF040001 4F012372       COMPLETION CODE   ASSIST = V01 USER REQUESTED ABEND DUMP                                   
0*** TRACE OF INSTRUCTIONS JUST BEFORE TERMINATION: PSW BITS SHOWN ARE THOSE BEFORE CORRESPONDING INSTRUCTION DECODED ***            
0  IM LOCATION    INSTRUCTION :  IM = PSW BITS 32-39 (ILC,CC,MASK)                                                                   
0  CF  01204E     4770 C370                                                                                                          
0  8F  012052     D503 800C 8008                                                                                                     
0  DF  012058     47B0 C366                                                                                                          
1  9F  01205C     4110 C580                                                                                                          
0  9F  012060     95E8 C3E7                                                                                                          
0  8F  012064     4780 C074                                                                                                          
0  8F  012074     5800 800C                                                                                                          
0  8F  012078     1200                                                                                                               
0  4F  01207A     4780 C370                                                                                                          
0  8F  012370     0119            <-- LAST INSTRUCTION DONE - PROBABLE CAUSE OF TERMINATION                                          
0*** TRACE OF LAST 10 BRANCH INSTRUCTIONS EXECUTED ***                                                                               
0  IM LOCATION    INSTRUCTION :  IM = PSW BITS 32-39 (ILC,CC,MASK)                                                                   
   CF  0007EC     47F0 1010                                                                                                          
   CF  0024F6     4510 07E0                                                                                                          
   CF  0007EC     47F0 1010                                                                                                          
   8F  002546     05E6                                                                                                               
   9F  0060CA     07FE                                                                                                               
   8F  002554     47F0 C000                                                                                                          
   8F  002418     4780 C024                                                                                                          
   8F  00246A     8200 00A0                                                                                                          
   8F  012064     4780 C074                                                                                                          
   4F  01207A     4780 C370                                                                                                          
0 REGS 0-7      00000000    00012580    E3C3C2C7    00002800    00000004    00012428    00012490    0000000D                         
  REGS 8-15     00012540    00011800    00011F00    00011600    4F012000    D9E24040    E3C3C2C7    00000001                         
0 FLTR 0-6      0000000000000000        0000000000000000        0000000000000000        0000000000000000                             
0*** USER STORAGE ***                                                                                                                
0                             CORE ADDRESSES SPECIFIED-     000000 TO 0207FF                                                         
 000000   01040119 0F003000 01190119 01190119    00002800 01190119 00000000 00000000   *................................*            
 000020   FFD50003 5F002852 FFD50005 5F000001    00000000 00000000 FFE6000F 0F0000BC   *.N.......N...............W......*            
 000040   00012920 0C000000 00012910 00002800    7FA89B51 01190119 01060119 0F004012   *.............................. .*            
 000060   01040119 0F004014 01040119 0F004154    01040119 0F00429A 01040119 0F00429C   *...... .........................*            
 000080   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
 0000A0   FF040001 4F012048 01190119 01190119    7FA89B71 01190119 01190119 0119E3F0   *..............................T0*            
 0000C0   C5E74040 C5E74040 C5E74040 C5E74040    C5E74040 C5E74040 C5E74040 C5E74040   *EX  EX  EX  EX  EX  EX  EX  EX  *            
   LINES    0000E0-0000E0    SAME AS ABOVE                                                                                           
 000100   E3C3C2C7 00010F24 0000A558 0000A68B    E3C3C2C6 0000A57B 0000A57A D9C2C7D9   *TCBG............TCBF........RBGR*            
 000120   6F00A52A 0000A53C FFFFFFFF D7C9C540    0000A53C 8F00A01C 00002850 000082C0   *............PIE ................*            
 000140   E3C3C2C7 0000A558 0000A558 0000A68B    E3C3C2C6 0000A57B 0000A57A D9C2C7D9   *TCBG............TCBF........RBGR*            
 000160   6F00A52A 0000A53C FFFFFFFF D7C9C540    0000A53C 8F00A01C 00002850 00000000   *............PIE ................*            
 000180   E3C3C2C7 D9E24040 E3C3C2C7 D9E24040    E3C3C2C7 D9E24040 E3C3C2C7 D9E24040   *TCBGRS  TCBGRS  TCBGRS  TCBGRS  *            
   LINES    0001A0-0001A0    SAME AS ABOVE                                                                                           
 0001C0   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    0001E0-0004E0    SAME AS ABOVE                                                                                           
 000500   01190119 01190119 01190119 01190119    01190119 01190119 00000000 00011F00   *................................*            
 000520   00000000 00000000 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
 000540   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    000560-0007C0    SAME AS ABOVE                                                                                           
 0007E0   F3841000 100CDC07 10000700 47F01010    F0F1F2F3 F4F5F6F7 F8F9C1C2 C3C4C5C6   *3............0..0123456789ABCDEF*            
 000800   E4C3C2FF 000C0000 00000820 F0F0F0C3    00000000 00000000 000126F0 00000000   *UCB.........000C...........0....*            
 000820   E4C3C2FF 000D0000 00000840 F0F0F0C4    00000000 00000000 00012740 00000000   *UCB........ 000D........... ....*            
 000840   E4C3C2FF 000E0000 00000860 F0F0F0C5    00000000 00000000 00012790 00000000   *UCB.........000E................*            
1000860   E4C3C2FF 000F0000 00000000 F0F0F0C6    00000000 00000000 00012858 00000000   *UCB.........000F................*            
 000880   01190119 01190119 01190119 01190119    01190119 01190119 01190119 01190119   *................................*            
   LINES    0008A0-000FE0    SAME AS ABOVE                                                                                           
 001000   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    001020-001FE0    SAME AS ABOVE                                                                                           
 002000   00006000 00000000 00006066 00000000    00006098 00000000 00007000 00000000   *................................*            
 002020   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 002040   00007C00 80000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 002060   00000000 00000000 00008000 C0000000    000082EA C0000000 00002080 00000000   *................................*            
 002080   1BFF07FE F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *....7777777777777777777777777777*            
 0020A0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0020C0-0023E0    SAME AS ABOVE                                                                                           
 002400   58403008 12444780 C1585850 40001255    4780C06E 9500501C 4780C024 58404074   *. ......A... ................  .*            
 002420   47F0C004 5040051C D20700A0 50105870    C21C4170 70015070 C21C5970 C22047D0   *.0... ..K.......B.......B...B...*            
 002440   C0440104 680040E0 682040E8 684040F0    686040F8 D20340A0 0050980F 403095E2   *...... ... Y.  0.. 8K. ..... ..S*            
 002460   00BE4770 00BC92E3 00BE8200 00A05870    40DC5880 4074D203 4028C1DF 50807074   *.......T........ ... .K. .A.....*            
 002480   507080DC D207C179 4008D207 C18C4010    D203C0A6 40AC4510 07E0F0F0 F0F0F0F1   *....K.A. .K.A. .K... .....000001*            
 0024A0   F4F72D40 40400000 0147D207 C19EC09A    D203C0C6 40B04510 07E0F0F0 F0F0F0F0   *47.   ....K.A...K..F .....000000*            
 0024C0   F9C12D40 40400000 009AD207 C1AEC0BA    D203C0E6 40244510 07E0F0F0 F3C3C6F3   *9A.   ....K.A...K..W .....003CF3*            
 0024E0   F2F22DC3 C3C3003C F322D207 C1C0C0DA    D203C106 40C04510 07E0F0F0 F5F2F5F4   *22.CCC..3.K.A...K.A. .....005254*            
 002500   F0F62DD9 D9D90052 5406D207 C1D2C0FA    E020C15A 00855820 304C5890 200C0690   *06.RRR....K.AK....A.............*            
 002520   5090200C 58603004 58606010 12664780    C1585800 C1E44110 200495F0 00BF4770   *................A...AU.....0....*            
 002540   00BC92F1 00BF05E6 95F100BF 477000BC    92F000BF 47F0C000 0119F0E2 D6E240E3   *...1...W.1.......0...0....0SOS T*            
 002560   C5D9D4C9 D5C1E3C9 D5C75A40 404040E3    C3C240D5 C1D4C57A 40E3C3C2 F140C2C4   *ERMINATING.    TCB NAME. TCB1 BD*            
 002580   E340D7C7 D440D5C1 D4C57A40 E2D6E2D7    C7D4F0F2 40D7D9D6 C2D3C5D4 7A40F0F0   *T PGM NAME. SOSPGM02 PROBLEM. 00*            
 0025A0   F0F0F0F1 F4F740E2 E4D7C5D9 7A40F0F0    F0F0F0F0 F9C140E3 C3C2E3E6 C1C9E37E   *000147 SUPER. 0000009A TCBTWAIT.*            
 0025C0   F0F0F3C3 C6F3F2F2 40E3C3C2 C9D6C3D5    E37EF0F0 F5F2F5F4 F0F64040 404040E4   *003CF322 TCBIOCNT.00525406     U*            
 0025E0   D5C3C8F7 7FC4C9E2 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *NCH7.DIS777777777777777777777777*            
 002600   E3D6E3C1 D340C4C9 E2D7C1E3 C3C840C3    D6E4D5E3 40C1E340 D3C5C6E3 000004E1   *TOTAL DISPATCH COUNT AT LEFT....*            
 002620   0000003C F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *....7777777777777777777777777777*            
 002640   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    002660-0027E0    SAME AS ABOVE                                                                                           
 002800   00000518 00002000 00011F00 00000800    00000000 00000000 000100E0 00002400   *................................*            
 002820   0001269A 00012690 00000000 00000000    00004000 00000000 000125B0 00000000   *.................. .............*            
 002840   00012544 00000000 00000000 00012540    0A0307FE 000040CC 000207FF C3E5E340   *............... ...... .....CVT *            
 002860   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    002880-002FE0    SAME AS ABOVE                                                                                           
 003000   05C006C0 06C0D203 0050C224 9802C218    01031777 17880878 01044180 880047F0   *......K...B...B................0*            
 003020   C0160102 D202006D C2299505 002B4770    C2124160 C018BD67 002D4770 C2125830   *....K...B.......B...........B...*            
 003040   004C0680 50803058 D203C05E 30584510    07E0F0F0 F0F2F0F7 C6C62D40 40400002   *........K.........000207FF.   ..*            
 003060   07FFD207 C238C052 E020C22C 001458A0    C2404100 001F58B0 3018D203 A000B000   *..K.B.....B.....B ........K.....*            
 003080   50AB0000 41AA0100 4600C076 58B03018    58AB0000 12AA4770 C0B00119 C3C2F1F0   *............................CB10*            
 0030A0   F040D7D6 D6D340C9 E240C5D4 D7E3E8F7    D203B000 A000187A 50703008 D7FF7000   *0 POOL IS EMPTY7K...........P...*            
 0030C0   7000D207 7008C244 92D4700B D203702C    C24CD207 7030C250 D2377038 7030D203   *..K...B..M..K...B.K...B.K.....K.*            
 0030E0   7080C214 58B03018 58AB0000 12AA4770    C1080119 C3C2F1F0 F040D7D6 D6D340C9   *..B.............A...CB100 POOL I*            
 003100   E240C5D4 D7E3E8F7 D203B000 A00050A0    7000188A D7FF8000 8000D203 8000C260   *S EMPTY7K...........P.....K...B.*            
 003120   50708004 9680800B D2078010 C274D207    8020C264 D2378028 8020D207 8060C26C   *........K...B.K...B.K.....K...B.*            
 003140   D2178068 8060BE77 801D58B0 301858AB    000012AA 4770C16E 0119C3C2 F1F0F040   *K.....................A...CB100 *            
 003160   D7D6D6D3 40C9E240 C5D4D7E3 E8F7D203    B000A000 189A5090 7074D7FF 90009000   *POOL IS EMPTY7K...........P.....*            
 003180   D2079008 C24492E6 900BD203 902CC24C    D2079030 C250D237 90389030 507090DC   *K...B..W..K...B.K...B.K.........*            
 0031A0   58B03018 58AB0000 12AA4770 C1C40119    C3C2F1F0 F040D7D6 D6D340C9 E240C5D4   *............AD..CB100 POOL IS EM*            
 0031C0   D7E3E8F7 D203B000 A00050A0 9000D7FF    A000A000 D203A000 C2605090 A0049680   *PTY7K.........P.....K...B.......*            
 0031E0   A00BD207 A010C27C D207A020 C264D237    A028A020 D207A060 C26CD217 A068A060   *..K...B.K...B.K.....K...B.K.....*            
 003200   BE97A01D 92E200BE 92F000BF 58C0301C    07FC0119 00012384 00000000 00020000   *.....S...0......................*            
 003220   00E08040 7FFFFFFF 00004154 40C3E5E3    D4E9F0F0 4089A240 F0F0F0F2 F0F7C6C6   *... ........ CVTMZ00 .. 000207FF*            
 003240   00010100 E3C3C295 40C2C4E3 E3C3C240    E3C3C2C7 D9E24040 E3C3C2C6 D9E24040   *....TCB. BDTTCB TCBGRS  TCBFRS  *            
 003260   40D7D9C2 D9C2C7D9 E2C1E5C5 D9C2C6D9    E2C1E5C5 FF040119 0F012000 FFE60119   * PRBRBGRSAVERBFRSAVE.........W..*            
 003280   0F0000BC F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *....7777777777777777777777777777*            
 0032A0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0032C0-003FE0    SAME AS ABOVE                                                                                           
1004000   58603004 58606068 58F03054 1266077F    01190119 D20300B0 005095E3 00BE4770   *.........0..........K......T....*            
 004020   00BC92E2 00BE900F 01005830 004C5840    051CD23F 40300100 600040E0 602040E8   *...S........... ..K. ..... ... Y*            
 004040   604040F0 606040F8 05C05850 40001255    4780C0FA D2075010 00205880 40A05B80   *.  0.. 8.... .......K....... ...*            
 004060   00B09101 00214780 C02C5A80 40AC5080    40AC47F0 C0345A80 40B05080 40B0950F   *............ ... ..0.... ... ...*            
 004080   00234720 C0FA4870 00228970 00035A70    30045860 70001266 4780C0FA 91C07004   *................................*            
 0040A0   4770C082 95F000BF 4770C0FA 92F100BF    05E695F1 00BF4770 C0FA92F0 00BF9001   *.....0.......1...W.1.......0....*            
 0040C0   403050F0 406C58C0 301C07FC 05C058B0    301858AB 000012AA 4770C024 0119C3C2   * ..0 .........................CB*            
 0040E0   F1F0F040 D7D6D6D3 40C9E240 C5D4D7E3    E8F7D203 B000A000 D7FFA000 A000185A   *100 POOL IS EMPTY7K.....P.......*            
 004100   D23F5020 4030D21F 506040E0 D2035000    C0809200 500B5040 5004D202 501D4001   *K... .K... .K.......... ..K... .*            
 004120   50504000 41E03050 50104034 9036403C    50E04068 BE67C07D D2075010 C07858C0   *.. ....... ... ... .....K.......*            
 004140   301C07FC 0119FF04 00000F00 8000E2E5    D9C20A03 91010029 478000BC D20300B0   *..............SVRB..........K...*            
 004160   005095E3 00BE4770 00BC92E2 00BE900F    01405830 004C5840 051CD23F 40300140   *...T.......S..... ..... ..K. .. *            
 004180   600040E0 602040E8 604040F0 606040F8    05C05850 40001255 4780C0FE D2075010   *.. ... Y.  0.. 8.... .......K...*            
 0041A0   00285880 40A05B80 00B05A80 40AC5080    40AC5880 40041288 4780C0EE 41A04078   *.... ....... ... ... ......... .*            
 0041C0   1788BF87 4005198A 4770C0EE 91808000    4710C0EE 58904080 17BBBFB7 8001199B   *.... ................. .........*            
 0041E0   4770C0EE 91809000 4710C0EE 1777BF77    B0011277 4780C0EE 5080C0E2 50B0C0E6   *...........................S...W*            
 004200   1788BF87 70011288 4780C0EE 5080C0EA    17BBBFBC 700412BB 4780C0EE 1788BF83   *................................*            
 004220   501289B0 800012BB 47B0C0EE 5880C0E6    D207800C 4068D20B 80144030 D2078004   *...............WK... .K... .K...*            
 004240   501017BB BFB7006D 06B006B0 50B04068    D203406C C0EAD202 5015C0EB D2034034   *.............. .K. ...K.....K. .*            
 004260   C0E65890 C0E29680 90009680 800058C0    301C07FC 00000000 00000000 00000000   *.W...S..........................*            
 004280   F200C104 50135810 C10258F0 303007FF    0119F7F7 800C5000 00000119 95E300BE   *2.A.....A..0......77.........T..*            
 0042A0   477000BC 92E200BE D20300B0 0050900F    01805830 004C5840 051CD23F 40300180   *.....S..K.............. ..K. ...*            
 0042C0   600040E0 602040E8 604040F0 606040F8    05C05850 40001255 4780C0F0 D2075010   *.. ... Y.  0.. 8.... ......0K...*            
 0042E0   00385880 40A05B80 00B05A80 40AC5080    40AC91D3 00444770 C0F091BF 00454770   *.... ....... ... ..L.....0......*            
 004300   C0F09104 00444780 C0EA5870 300CD501    003A7004 4780C054 58707008 12774780   *.0............N.................*            
 004320   C0F047F0 C03C58A0 701012AA 4780C0F0    5890A004 58D0A00C 5800D018 5B0000B0   *.0.0...........0................*            
 004340   5A00D024 5000D024 BF0FC0F2 4110A018    58603004 41606010 58606000 95F000BF   *...........2.................0..*            
 004360   477000BC 92F100BF 05E695F1 00BF4770    00BC92F0 00BF9200 700658B0 90089501   *.....1...W.1.......0............*            
 004380   90064780 C0CAD507 B000C0F6 4770C0CA    41F00004 50F0D06C 47F0C0D0 D703D06C   *......N....6.....0...0...0..P...*            
 0043A0   D06C58B0 3018D203 A000B000 50AB0000    D7037010 701058C0 302007FC 58C03024   *......K.........P...............*            
 0043C0   07FC0119 7FC9D6E2 F9F9F9F9 F9F9F9F9    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *.....IOS999999997777777777777777*            
 0043E0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    004400-005FE0    SAME AS ABOVE                                                                                           
 006000   D5021000 605A4770 605848F0 100412FF    4770604E 58701008 4880100C 95011006   *N..........0....................*            
 006020   47806044 95021006 47706058 E0007000    80004740 603ED507 7000605D 077E41F0   *................... ..N........0*            
 006040   000407FE E0207000 800017FF 07FE58C0    004C58C0 C03807FC 0119C9D6 C2F9F9F9   *..........................IOB999*            
 006060   F9F9F9F9 F9F75900 602E4770 602C9140    1000071E 91801000 4710602C 43F0501C   *999997......... .............0..*            
 006080   41F0F001 42F0501C BE571001 96801000    07FE0119 00000001 91401000 071E58F1   *.00..0................... .....1*            
 0060A0   00009180 10005001 00004780 602AD501    6036F002 47706034 4300F01C 06004200   *..............N...0.......0.....*            
 0060C0   F01C9640 1000947F 100007FE 0119D9C2    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *0.. ..........RB7777777777777777*            
 0060E0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    006100-006FE0    SAME AS ABOVE                                                                                           
 007000   D5020025 006D4780 60629001 502050F0    505CD23F 40305020 D21F40E0 5060D202   *N..............0..K. ...K. ...K.*            
 007020   4001501D BD474001 47806048 9180500B    47706096 18A558B0 3018D203 A000B000   * ..... ...................K.....*            
 007040   50AB0000 47F06056 9180500B 47E06096    D7034000 4000D203 500C6098 58504000   *.....0..........P. . .K....... .*            
 007060   07FEBF77 40059180 70004780 6096947F    7000BF87 7001947F 8000D207 4068800C   *.... .....................K. ...*            
 007080   D20B4030 8014D203 50148008 98014030    58F0406C 07FE0119 E4D5C3C8 F7F7F7F7   *K. ...K....... ..0 .....UNCH7777*            
 0070A0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0070C0-0072E0    SAME AS ABOVE                                                                                           
 007300   41206164 41A060C8 05CA9502 61144770    60C2D502 6115617C 477060C2 9500612C   *.......H.........BN........B....*            
 007320   477060C2 D202610D 612DD202 61116131    05CA9502 61144770 60C2D502 6115617C   *...BK.....K..............BN.....*            
 007340   47806030 D5026115 617F4770 60C21B77    BF776119 59006178 47806064 18B01BB7   *....N........B..................*            
 007360   47F06066 1BBB1A7B 50706104 1B991B77    BF776119 1A7B1B88 BF83611E 12884780   *.0..............................*            
 007380   60C21A98 50906108 06804480 60FE05CA    95026114 477060C2 D5026115 617F4780   *.B.....................BN.......*            
 0073A0   606ED502 61156182 4780608E D5026115    61854770 60C29801 610445C0 618C1BFF   *..N.........N........B..........*            
 0073C0   07FE41F0 000407FE 18120A00 12FF4770    60C213FF 07FC0119 40C5D5C4 40D6C640   *...0.............B...... END OF *            
 0073E0   C6C9D3C5 40C8C9E3 40C9D540 D3D6C1C4    40E2E5C3 40606040 C2C1C45A 5A40D200   *FILE HIT IN LOAD SVC .. BAD.. K.*            
 007400   70006124 00007800 00000253 00010000    0000026A 02C5D5C4 40010000 40404040   *.....................END ...    *            
 007420   40400001 40404040 40404040 40404040    40404040 F1F5F6F9 F6F2F3F4 F0F040F0   *  ..                1569623400 0*            
 007440   F1F0F4F0 F5F1F2F3 40404040 40404040    40404040 40404040 40404040 F0F0F0F0   *10405123                    0000*            
1007460   F0F0F1F4 C9D6C2F8 000C0200 00007414    00500000 D3E3D9C7 FFFFFFFF C5E2C4E3   *0014IOB8............LTRG....ESDT*            
 007480   E7E3D9D3 C4C5D5C4 40404040 D5026119    6188078C BF076119 1A0B07FC F7F7F7F7   *XTRLDEND    N...............7777*            
 0074A0   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    0074C0-0077E0    SAME AS ABOVE                                                                                           
 007800   50006128 50106124 D2036120 61344170    61605070 61E892D5 613845B0 6220D502   *........K............Y.N......N.*            
 007820   616161B0 4770607C D5036120 61344780    603A45B0 622047F0 601E9500 61784770   *........N..............0........*            
 007840   6242D202 612D6179 D2026131 617DD503    61246130 47406264 D5036128 61344780   *..K.....K.....N...... ..N.......*            
 007860   60725870 61285B70 612C5070 612047F0    601AD703 61206120 47F0601A D5036120   *...............0..P......0..N...*            
 007880   61344780 6248D502 616161B3 477060B6    92E86138 1777BF73 616A1277 4780624E   *......N..........Y..............*            
 0078A0   1788BF87 61655A80 61204470 613A45B0    622047F0 607CD502 616161B6 477060C4   *...................0..N........D*            
 0078C0   47F0601A 95E86138 47706254 D5026161    61B94770 623C5800 612C5A00 6120D502   *.0...Y......N.................N.*            
 0078E0   616561BC 478060F2 1700BF07 61655A00    61205810 613047F0 625AF7F7 F7F7F7F7   *.......2...............0..777777*            
 007900   E2E5C3F8 40E2E3D6 D9C1C7C5 40C1D9C5    C140C6D6 D3D3D6E6 E2404040 40404040   *SVC8 STORAGE AREA FOLLOWS       *            
 007920   FFFF7C00 00000400 00007C00 00010000    0000026A FFFFFFFF E800D200 80006170   *........................Y.K.....*            
 007940   E2E5C3F8 40C9D5D7 E4E340C2 E4C6C6C5    D940C2C5 D3D6E640 40404040 40404040   *SVC8 INPUT BUFFER BELOW         *            
 007960   02C5D5C4 40010000 40404040 40400001    40404040 40404040 40404040 40404040   *.END ...      ..                *            
 007980   F1F5F6F9 F6F2F3F4 F0F040F0 F1F0F4F0    F5F1F2F3 40404040 40404040 40404040   *1569623400 010405123            *            
 0079A0   40404040 40404040 F0F0F0F0 F0F0F1F4    C5E2C4E3 E7E3D9D3 C4C5D5C4 404040F7   *        00000014ESDTXTRLDEND   7*            
 0079C0   E2E5C3F8 40D9C5C1 C440C9D6 C240C2C5    D3D6E640 40404040 40404040 40404040   *SVC8 READ IOB BELOW             *            
 0079E0   C9D6C2D9 000C02F0 00007960 00500000    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *IOBR...0........7777777777777777*            
 007A00   C9D5E3C5 D9D5C1D3 40D9C5C1 C440E2E4    C2D9D6E4 E3C9D5C5 40C6D6D3 D3D6E6E2   *INTERNAL READ SUBROUTINE FOLLOWS*            
 007A20   411061E0 0A0012FF 4770625E 95026160    47706236 07FB41F0 000C07FE 41F0000C   *.......................0.....0..*            
 007A40   07FE41F0 001007FE 41F00010 07FE41F0    001007FE 41F00010 07FE17FF 07FE41F0   *...0.....0.....0.....0.........0*            
 007A60   000407FE 41F00008 07FEF7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *.....0....7777777777777777777777*            
 007A80   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    007AA0-007BE0    SAME AS ABOVE                                                                                           
 007C00   50006128 50106124 D2036120 61344170    61605070 61E892D5 613845B0 6220D502   *........K............Y.N......N.*            
 007C20   616161B0 4770607C D5036120 61344780    603A45B0 622047F0 601E9500 61784770   *........N..............0........*            
 007C40   6242D202 612D6179 D2026131 617DD503    61246130 47406264 D5036128 61344780   *..K.....K.....N...... ..N.......*            
 007C60   60725870 61285B70 612C5070 612047F0    601AD703 61206120 47F0601A D5036120   *...............0..P......0..N...*            
 007C80   61344780 6248D502 616161B3 477060B6    92E86138 1777BF73 616A1277 4780624E   *......N..........Y..............*            
 007CA0   1788BF87 61655A80 61204470 613A45B0    622047F0 607CD502 616161B6 477060C4   *...................0..N........D*            
 007CC0   47F0601A 95E86138 47706254 D5026161    61B94770 623C5800 612C5A00 6120D502   *.0...Y......N.................N.*            
 007CE0   616561BC 478060F2 1700BF07 61655A00    61205810 613047F0 625A40F7 F7F7F7F7   *.......2...............0.. 77777*            
 007D00   E2E5C3F8 40E2E3D6 D9C1C7C5 40C1D9C5    C140C6D6 D3D3D6E6 E2404040 40404040   *SVC8 STORAGE AREA FOLLOWS       *            
 007D20   00004000 00000F84 0000E000 0000A000    00000710 FFFFFFFF E800D200 80006170   *.. .....................Y.K.....*            
 007D40   E2E5C3F8 40C9D5D7 E4E340C2 E4C6C6C5    D940C2C5 D3D6E640 40404040 40404040   *SVC8 INPUT BUFFER BELOW         *            
 007D60   02C5D5C4 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *.END                            *            
 007D80   F1F5F6F6 F8F9F6F2 F0F140F0 F2F0F1F8    F6F0F4F5 40C4F9D9 40404040 40404040   *1566896201 020186045 D9R        *            
 007DA0   40404040 40404040 F0F0F0F0 F0F0F1F7    C5E2C4E3 E7E3D9D3 C4C5D5C4 40404040   *        00000017ESDTXTRLDEND    *            
 007DC0   E2E5C3F8 40D9C5C1 C440C9D6 C240C2C5    D3D6E640 40404040 40404040 40404040   *SVC8 READ IOB BELOW             *            
 007DE0   C9D6C2D9 000C02F0 00007D60 00500000    40F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *IOBR...0........ 777777777777777*            
 007E00   C9D5E3C5 D9D5C1D3 40D9C5C1 C440E2E4    C2D9D6E4 E3C9D5C5 40C6D6D3 D3D6E6E2   *INTERNAL READ SUBROUTINE FOLLOWS*            
 007E20   411061E0 0A0012FF 4770625E 95026160    47706236 07FB41F0 000C07FE 41F0000C   *.......................0.....0..*            
 007E40   07FE41F0 001007FE 41F00010 07FE41F0    001007FE 41F00010 07FE17FF 07FE41F0   *...0.....0.....0.....0.........0*            
 007E60   000407FE 41F00008 07FE40F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *.....0.... 777777777777777777777*            
 007E80   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    007EA0-007FE0    SAME AS ABOVE                                                                                           
 008000   58B03018 58AB0000 12AA4770 60240119    C3C2F1F0 F040D7D6 D6D340C9 E240C5D4   *................CB100 POOL IS EM*            
 008020   D7E3E8F7 D203B000 A00018BA D7FFB000    B000D201 B02062AC D206B000 62AE4170   *PTY7K.......P.....K.....K.......*            
 008040   B0725070 B0244170 00855070 B0704170    B0705070 B0284170 B0005070 B02CBE1F   *................................*            
 008060   B01C4110 B0104520 07E09240 B072D283    B073B072 D20FB072 6278D207 B083B010   *........... ..K.....K.....K.....*            
 008080   41D0B030 4110B024 41F062C0 05CF9240    B072D283 B073B072 D214B072 628817AA   *.........0..... ..K.....K.......*            
 0080A0   BFA7501D 41700002 4180A010 4190B08B    D203B01C 80004110 B0104520 07E0D207   *................K.............K.*            
 0080C0   9000B010 4190900B 41808004 467060B0    4110B024 05CF1777 BF77A015 9240B072   *............................. ..*            
 0080E0   D283B073 B072D20C B072629E 9260B08D    5B7062B8 472060FC 41700000 18974190   *K.....K.........................*            
 008100   900C5990 305847D0 61125870 30584A70    62BCBE7F B01C4110 B0104520 07E0D207   *..............................K.*            
 008120   B084B010 41900003 41A0B08F D203B01C    70004110 B0104520 07E0D207 A000B010   *............K.............K.....*            
 008140   41A0A00A 41707004 4690612C 4110B024    05CF9240 B072D283 B073B072 D209B072   *................... ..K.....K...*            
 008160   62524180 00044190 503C41A0 B0844170    5020D203 B01C7000 4110B010 452007E0   *..................K.............*            
1008180   D207A000 B01041A0 A0098778 61724110    B02405CF 9240B072 D283B073 B072D209   *K.................... ..K.....K.*            
 0081A0   B072625C 41800004 4190505C 41A0B084    41705040 D203B01C 70004110 B0104520   *................... K...........*            
 0081C0   07E0D207 A000B010 41A0A009 877861B4    4110B024 D209B072 625C05CF 9240B072   *..K.................K........ ..*            
 0081E0   D283B073 B072D211 B0726266 41800004    41905078 41A0B084 41705060 D203B01C   *K.....K.....................K...*            
 008200   70004110 B0104520 07E0D207 A000B010    41A0A008 41787000 D203B01C 70004110   *..........K.............K.......*            
 008220   B0104520 07E0D207 A000B010 41A0A00A    877861FC 4110B024 05CF4170 3050BE77   *......K.........................*            
 008240   5015BF57 501D1954 47806250 47F0623E    07FEF0C7 D7D940F0 60F74040 F0C7D7D9   *.............0....0GPR 0.7  0GPR*            
 008260   40F860F1 F540F0C6 D7D9A240 F06BF26B    F46BF67A 40404040 F0C3D6D5 E3C5D5E3   * 8.15 0FPR. 0.2.4.6.    0CONTENT*            
 008280   E240D6C6 40D9F17A F0D7E2E6 40C1E340    E3C9D4C5 40D6C640 C5D9D9D6 D960F0C4   *S OF R1.0PSW AT TIME OF ERROR.0D*            
 0082A0   C1E3C140 C1E340D7 E2E67AF7 07F2C9D6    C2E6000F 01F7F7F7 00000006 FFFFFFF4   *ATA AT PSW.7.2IOBW...777.......4*            
 0082C0   900FD000 98461000 48505000 50406008    4050600C 18160104 0A000102 12FF4770   *............. .. ...............*            
 0082E0   F028980F D00007FC 01191211 478060C0    1777BF77 10011277 478060C0 91801004   *0...............................*            
 008300   477060FE 1788BF83 10041288 478060C0    58904004 12994780 608458A0 407812AA   *.................. ......... ...*            
 008320   478060FE 1799BF97 400541A0 4078199A    477060FE 9180A000 477060FE 58B04080   *........ ... ................. .*            
 008340   D51F6100 B0004780 60FE9180 B0004770    60FE17CC BFC7B001 BE17B001 9200B000   *N....................G..........*            
 008360   58A0501C D100A014 1000181C 07FE58A0    407812AA 477060FE 41A04078 BEA74005   *....J........... ......... ... .*            
 008380   D202A001 40819200 A00058B0 4080BE17    B0019200 B00058A0 501CD100 4004A014   *K... ....... .............J. ...*            
 0083A0   D100A014 10001711 07FE5890 40041299    477060CE 171107FE 1799BF97 400558B0   *J........... ............... ...*            
 0083C0   501CD100 B0144004 D7034004 4004BFA7    9001D703 90009000 17CCBFC7 A001D703   *..J... .P. . .....P........G..P.*            
 0083E0   A000A000 181C07FE 01190000 00000000    00000000 00000000 00000000 00000000   *................................*            
 008400   00000000 00000000 0000F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *..........7777777777777777777777*            
 008420   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    008440-009FE0    SAME AS ABOVE                                                                                           
 00A000   47F0F028 09E2D6E2 D7C7D4F0 F24090EC    D00C0700 50D0F020 45D0F064 00000000   *.00..SOSPGM02 ........0...0.....*            
 00A020   0000AF8C 00000000 41C0F53C 50C0F550    4160F57A 5060F574 41506001 BE5FF56B   *..........5...5...5...5.......5.*            
 00A040   47F0F00E 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *.00.............................*            
 00A060   00000000 58F0D004 50DF0008 4120D53C    D2032000 D5E4D201 2004D5E8 D2082005   *.....0........N.K...NUK...NYK...*            
 00A080   D5551812 5890D534 05894130 D5EA5030    20081812 0589D208 2005D54C 18120589   *N.....N.....N.........K...N.....*            
 00A0A0   12FF4770 D4FCD208 2005D555 18120589    47F0D07A 40C4C4C4 C4C4C4C4 C4C4C4C4   *....M.K...N......0.. DDDDDDDDDDD*            
 00A0C0   C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4    C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4   *DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*            
   LINES    00A0E0-00A4E0    SAME AS ABOVE                                                                                           
 00A500   C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4    C4C4C4C4 C4C4C4C4 4130D66F D2082005   *DDDDDDDDDDDDDDDDDDDDDDDD..O.K...*            
 00A520   D5555030 20081812 058941A0 000113AA    07FA58DD 000498EC D00C07FE 0A0007F8   *N..............................8*            
 00A540   40C4C4C4 C4C4C4C4 C4C4C4C4 C4C40000    0000A53C 40C4C4C4 C9D6C240 000E01EE   * DDDDDDDDDDDDD...... DDDIOB ....*            
 00A560   0000A68B 00854040 0D02DD00 00A57B00    500E01EE 0000A57A 008560F9 F9F9F9F9   *......  ...................99999*            
 00A580   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9   *99999999999999999999999999999999*            
 00A5A0   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F940   *9999999999999999999999999999999 *            
 00A5C0   40404040 40404040 4040404C 5C5C5C40    C2C1C3D2 40E3C8C5 D9C540C9 E240E3C8   *           .... BACK THERE IS TH*            
 00A5E0   C540C3C1 D9C460E2 40C5D5C4 5A4B4B4B    4B4B4B4B 4B4B4B40 40404040 40F1C540   *E CARD.S END...........      1E *            
 00A600   C9D6C240 0000F140 C6D6D940 D7C7D460    F240E3C8 C540C6C9 D9E2E340 D3C9D5C5   *IOB ..1 FOR PGM.2 THE FIRST LINE*            
 00A620   40C9E240 E3C8C9E2 4B4B4B4B 4B4B4040    40404040 40404040 40404040 40404040   * IS THIS......                  *            
 00A640   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00A660-00A660    SAME AS ABOVE                                                                                           
 00A680   40404040 40404040 40F1C540 C9D540D7    C7D460F2 40E3C8C9 E240D6C3 C3E4D9E2   *         1E IN PGM.2 THIS OCCURS*            
 00A6A0   40E6C8C5 D540C5D6 C640C9E2 40C8C9E3    40404040 40404040 40404040 40404040   * WHEN EOF IS HIT                *            
 00A6C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00A6E0-00A6E0    SAME AS ABOVE                                                                                           
 00A700   40404040 40404040 40404040 4040F1C5    40C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4   *              1E DDDDDDDDDDDDDDD*            
 00A720   C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4    C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4   *DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*            
   LINES    00A740-00AF60    SAME AS ABOVE                                                                                           
 00AF80   C4C4C4C4 C4C4C4C4 C4C4C4C4 C4C4C4C4    00000000 8F00A01C 00002850 0000A000   *DDDDDDDDDDDDDDDD................*            
 00AFA0   E3C3C2C7 0000AFD4 E3C3C2C7 D9E24040    E3C3C2C6 0000A57B 0000A57A D9C2C7D9   *TCBG...MTCBGRS  TCBF........RBGR*            
 00AFC0   E2C1E5C5 D9C2C6D9 E2C1E5C5 D7C9C540    0000A53C 8000AFD8 0006F1F1 F1F1F1F1   *SAVERBFRSAVEPIE .......Q..111111*            
 00AFE0   D7C9C540 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *PIE PIE PIE PIE PIE PIE PIE PIE *            
 00B000   47F0F028 09E2D6E2 D7C7D4F0 F94090EC    D00C0700 50D0F020 45D0F064 00000000   *.00..SOSPGM09 ........0...0.....*            
 00B020   0000BF90 00000000 41C0F53C 50C0F550    4160F57A 5060F574 41506001 BE5FF56B   *..........5...5...5...5.......5.*            
 00B040   47F0F00E 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *.00.............................*            
 00B060   00000000 58F0D004 50DF0008 4120D53C    D2032000 D5E4D201 2004D5E8 D2082005   *.....0........N.K...NUK...NYK...*            
 00B080   D5551812 5890D534 05894130 D5EA5030    20081812 0589D208 2005D54C 18120589   *N.....N.....N.........K...N.....*            
 00B0A0   12FF4770 D4FCD208 2005D555 18120589    47F0D07A 40C5C5C5 C5C5C5C5 C5C5C5C5   *....M.K...N......0.. EEEEEEEEEEE*            
100B0C0   C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5    C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5   *EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE*            
   LINES    00B0E0-00B4E0    SAME AS ABOVE                                                                                           
 00B500   C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5    C5C5C5C5 C5C5C5C5 4130D66F D2082005   *EEEEEEEEEEEEEEEEEEEEEEEE..O.K...*            
 00B520   D5555030 20081812 05890560 BF1F6006    0A0D8065 432198EC D00C07FE 0A0007F8   *N..............................8*            
 00B540   40C5C5C5 C5C5C5C5 C5C5C5C5 C5C50000    0000B53C 40C5C5C5 C9D6C240 000F01FF   * EEEEEEEEEEEEE...... EEEIOB ....*            
 00B560   0000B68B 00854040 0D02DD00 00B57B00    500F01FF 0000B57A 008560F9 F9F9F9F9   *......  ...................99999*            
 00B580   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9   *99999999999999999999999999999999*            
 00B5A0   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F940   *9999999999999999999999999999999 *            
 00B5C0   40404040 40404040 4040404C 5C5C5C40    C2C1C3D2 40E3C8C5 D9C540C9 E240E3C8   *           .... BACK THERE IS TH*            
 00B5E0   C540C3C1 D9C460E2 40C5D5C4 5A4B4B4B    4B4B4B4B 4B4B4B40 40404040 40F2C640   *E CARD.S END...........      2F *            
 00B600   C9D6C240 0000F140 C6D6D940 D7C7D460    F240E3C8 C540C6C9 D9E2E340 D3C9D5C5   *IOB ..1 FOR PGM.2 THE FIRST LINE*            
 00B620   40C9E240 E3C8C9E2 4B4B4B4B 4B4B4040    40404040 40404040 40404040 40404040   * IS THIS......                  *            
 00B640   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00B660-00B660    SAME AS ABOVE                                                                                           
 00B680   40404040 40404040 40F2C640 C9D540D7    C7D460F2 40E3C8C9 E240D6C3 C3E4D9E2   *         2F IN PGM.2 THIS OCCURS*            
 00B6A0   40E6C8C5 D540C5D6 C640C9E2 40C8C9E3    40404040 40404040 40404040 40404040   * WHEN EOF IS HIT                *            
 00B6C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00B6E0-00B6E0    SAME AS ABOVE                                                                                           
 00B700   40404040 40404040 40404040 4040F2C6    40C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5   *              2F EEEEEEEEEEEEEEE*            
 00B720   C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5    C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5   *EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE*            
   LINES    00B740-00BF60    SAME AS ABOVE                                                                                           
 00BF80   C5C5C5C5 C5C5C5C5 C5C5C5C5 C5C5C5C5    C5C5C5C5 00000000 8F00B01C 00002850   *EEEEEEEEEEEEEEEEEEEE............*            
 00BFA0   0000B000 E3C3C2C7 0000BFD8 E3C3C2C7    D9E24040 E3C3C2C6 0000B57B 0000B57A   *....TCBG...QTCBGRS  TCBF........*            
 00BFC0   D9C2C7D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 0000B53C 8000BFDE 00000000   *RBGRSAVERBFRSAVEPIE ............*            
 00BFE0   D7C9C540 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *PIE PIE PIE PIE PIE PIE PIE PIE *            
 00C000   47F0F028 09E2D6E2 D7C7D4F0 F24090EC    D00C0700 50D0F020 45D0F064 00000000   *.00..SOSPGM02 ........0...0.....*            
 00C020   0000CF88 00000000 41C0F53C 50C0F550    4160F57A 5060F574 41506001 BE5FF56B   *..........5...5...5...5.......5.*            
 00C040   47F0F00E 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *.00.............................*            
 00C060   00000000 58F0D004 50DF0008 4120D53C    D2032000 D5E4D201 2004D5E8 D2082005   *.....0........N.K...NUK...NYK...*            
 00C080   D5551812 5890D534 05894130 D5EA5030    20081812 0589D208 2005D54C 18120589   *N.....N.....N.........K...N.....*            
 00C0A0   12FF4770 D4FCD208 2005D555 18120589    47F0D07A 40C6C6C6 C6C6C6C6 C6C6C6C6   *....M.K...N......0.. FFFFFFFFFFF*            
 00C0C0   C6C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6    C6C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6   *FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF*            
   LINES    00C0E0-00C4E0    SAME AS ABOVE                                                                                           
 00C500   C6C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6    C6C6C6C6 C6C6C6C6 4130D66F D2082005   *FFFFFFFFFFFFFFFFFFFFFFFF..O.K...*            
 00C520   D5555030 20081812 058941A0 000113AA    07FA58DD 000498EC D00C07FE 0A0007F8   *N..............................8*            
 00C540   40C6C6C6 C6C6C6C6 C6C6C6C6 C6C60000    0000C53C 40C6C6C6 C9D6C240 000E01EE   * FFFFFFFFFFFFF....E. FFFIOB ....*            
 00C560   0000C68B 00854040 0D02DD00 00C57B00    500E01EE 0000C57A 008560F9 F9F9F9F9   *..F...  .....E........E....99999*            
 00C580   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9   *99999999999999999999999999999999*            
 00C5A0   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F940   *9999999999999999999999999999999 *            
 00C5C0   40404040 40404040 4040404C 5C5C5C40    C2C1C3D2 40E3C8C5 D9C540C9 E240E3C8   *           .... BACK THERE IS TH*            
 00C5E0   C540C3C1 D9C460E2 40C5D5C4 5A4B4B4B    4B4B4B4B 4B4B4B40 40404040 40F3C540   *E CARD.S END...........      3E *            
 00C600   C9D6C240 0000F140 C6D6D940 D7C7D460    F240E3C8 C540C6C9 D9E2E340 D3C9D5C5   *IOB ..1 FOR PGM.2 THE FIRST LINE*            
 00C620   40C9E240 E3C8C9E2 4B4B4B4B 4B4B4040    40404040 40404040 40404040 40404040   * IS THIS......                  *            
 00C640   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00C660-00C660    SAME AS ABOVE                                                                                           
 00C680   40404040 40404040 40F3C540 C9D540D7    C7D460F2 40E3C8C9 E240D6C3 C3E4D9E2   *         3E IN PGM.2 THIS OCCURS*            
 00C6A0   40E6C8C5 D540C5D6 C640C9E2 40C8C9E3    40404040 40404040 40404040 40404040   * WHEN EOF IS HIT                *            
 00C6C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00C6E0-00C6E0    SAME AS ABOVE                                                                                           
 00C700   40404040 40404040 40404040 4040F3C5    40C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6   *              3E FFFFFFFFFFFFFFF*            
 00C720   C6C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6    C6C6C6C6 C6C6C6C6 C6C6C6C6 C6C6C6C6   *FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF*            
   LINES    00C740-00CF60    SAME AS ABOVE                                                                                           
 00CF80   C6C6C6C6 C6C6C6C6 C6C6C6C6 00000000    8F00C01C 00002850 0000C000 E3C3C2C7   *FFFFFFFFFFFF................TCBG*            
 00CFA0   0000CFD0 E3C3C2C7 D9E24040 E3C3C2C6    0000C57B 0000C57A D9C2C7D9 E2C1E5C5   *....TCBGRS  TCBF..E...E.RBGRSAVE*            
 00CFC0   D9C2C6D9 E2C1E5C5 D7C9C540 0000C53C    8000CFD4 0009D7C1 D9D440F2 F3F4F500   *RBFRSAVEPIE ..E....M..PARM 2345.*            
 00CFE0   D7C9C540 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *PIE PIE PIE PIE PIE PIE PIE PIE *            
 00D000   47F0F010 08E4D5D4 D6C7D3C9 C3404040    90ECD00C 18CF41E0 C06050E0 D00850D0   *.00..UNMOGLIC   ................*            
 00D020   E00418DE 5840C0A8 4120C0F0 4130C0AC    F1332000 30004120 20034130 30044640   *..... .....0....1.............. *            
 00D040   C0309240 20004120 C0F04130 0085E020    20003000 D784C0F0 C0F04400 C05A0119   *... .....0..........P..0.0......*            
 00D060   FFFFFFFD FFFFFFFD FFFFFFFD FFFFFFFD    FFFFFFFD FFFFFFFD FFFFFFFD FFFFFFFD   *................................*            
1  LINES    00D080-00D080    SAME AS ABOVE                                                                                           
 00D0A0   FFFFFFFD FFFFFFFD 00000011 060E6D90    0D6D5C70 040C5D50 0E3D9E80 04060600   *................................*            
 00D0C0   040E2F00 0C3F3400 0D6C3C30 0E4D9E20    040C6D60 0D3D3D60 0E6C9D50 0C740E30   *................................*            
 00D0E0   0C8C9E20 040D4C50 0E2E2C10 0C7C55A0    E7E7E7E7 E7E7E7E7 E7E7E7E7 E7E7E7E7   *................XXXXXXXXXXXXXXXX*            
 00D100   E7E7E7E7 E7E7E7E7 E7E7E7E7 E7E7E7E7    E7E7E7E7 E7E7E7E7 E7E74040 40404040   *XXXXXXXXXXXXXXXXXXXXXXXXXX      *            
 00D120   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00D140-00D140    SAME AS ABOVE                                                                                           
 00D160   40404040 40404040 40404040 40404040    40404040 4040C7C7 47F0F010 08D6C2D1   *                      GG.00..OBJ*            
 00D180   D4D6C4D5 C9404040 90ECD00C 18CF41E0    C48450E0 D00850D0 E00418DE 6800C420   *MODNI   ........D.............D.*            
 00D1A0   6820C428 6840C430 6860C438 45B0C10A    92F0C285 417000A0 45B0C118 47F0C04C   *..D.. D...D...A..0B.......A..0..*            
 00D1C0   47F0C056 45B0C10A 4670C040 011945B0    C10A47F0 C05E6000 C4406020 C4486040   *.0....A.... ....A..0....D ..D.. *            
 00D1E0   C4506060 C458D51F C420C440 45E0C396    47F0C0E4 0000AFA8 0000AEA8 5830004C   *D...D.N.D.D ..C..0.U............*            
 00D200   58403000 58404004 58504000 58705004    41707000 19744770 C396D507 4088C07C   *. ...  ... .............C.N. ...*            
 00D220   4770C396 0000DFA8 587D0004 41707000    0000DF80 5970C0B8 4770C396 D5037018   *..C.......................C.N...*            
 00D240   C0AC4770 C39659C0 70104770 C3965880    7018D517 80000060 4770C396 5810C1D8   *....C.......C.....N.......C...AQ*            
 00D260   1B221B33 41400010 5023C138 1E214130    30044640 C0F0900F C178980F C1380988   *..... ....A........ .0..A...A...*            
 00D280   01194110 C1B80A00 12FF45E0 C39607FB    4110C1C8 0A0012FF 078B41E0 000419EF   *....A.......C.....AH............*            
 00D2A0   4780C12E 0119D284 C285C200 47F0B004    00000000 11111111 22222222 33333333   *..A...K.B.B..0..................*            
 00D2C0   44444444 55555555 66666666 77777777    88888888 99999999 AAAAAAAA BBBBBBBB   *................................*            
 00D2E0   CCCCCCCC DDDDDDDD EEEEEEEE FFFFFFFF    E3C3C2C7 11111111 11111110 00000040   *................TCBG........... *            
 00D300   00000000 D9E24040 40D7D9C2 000000A0    E2C1E5C5 D9C2C6D9 E2C1E5C5 8F00D1D2   *....RS   PRB....SAVERBFRSAVE..JK*            
 00D320   0000D178 0000D5FC 8F00D1F0 00000000    C9D6C2E6 000F01FF 0000D3FD 0085E6E6   *..J...N...J0....IOBW......L...WW*            
 00D340   C9D6C2D9 000D02DD 0000D3FE 0050D9D9    11111111 0000DFE8 8000DFEE 0000000F   *IOBR......L...RR.......Y........*            
 00D360   C2D6E4E2 E3D9D6D7 C8C5C4D6 D5C9C300    0000DFA0 0000DEA0 F2606060 606040D6   *BOUSTROPHEDONIC.........2..... O*            
 00D380   D26B40C5 D6C640C8 C1E240C2 C5C5D540    C5D5C3D6 E4D5E3C5 D9C5C45A 40606060   *K. EOF HAS BEEN ENCOUNTERED. ...*            
 00D3A0   60604040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *..                              *            
 00D3C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
 00D3E0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40F26060   *                             2..*            
 00D400   60606040 D6D26B40 C5D6C640 C8C1E240    C2C5C5D5 40C5D5C3 D6E4D5E3 C5D9C5C4   *... OK. EOF HAS BEEN ENCOUNTERED*            
 00D420   5A406060 60606040 40404040 40404040    40404040 40404040 40404040 40404040   *. .....                         *            
 00D440   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00D460-00D460    SAME AS ABOVE                                                                                           
 00D480   F4C64170 000A8970 000C4170 71A84110    10001917 45E0C396 D57F7000 C46045E0   *4F....................C.N...D...*            
 00D4A0   C3965830 004C5840 40005840 40045880    40884180 800041D0 D000198D 45E0C396   *C......  ..  ... .............C.*            
 00D4C0   5880408C 41808000 5890C478 198945E0    C396BD17 C1DC45E0 C396D517 1000C1E0   *.. .......D.....C...A...C.N...A.*            
 00D4E0   45E0C396 5820D004 BD27C1F9 45E0C396    5830004C 58403000 58404004 BD274089   *..C.......A9..C...... ...  ... .*            
 00D500   45E0C396 D502408D C1FC45E0 C396078E    50E0C47C F384C637 C47C9240 C63FD407   *..C.N. .A...C.....D.3.F.D.. F.M.*            
 00D520   C637C4CC DC07C637 C4D45840 C5B44120    C6004130 C5B845B0 C4084120 C6004130   *F.D...F.DM. E...F...E...D...F...*            
 00D540   0085E020 20003000 9240C600 D283C601    C6005840 C4E44120 C52C4130 C4E845B0   *......... F.K.F.F.. DU..E...DY..*            
 00D560   C4084120 C52C4130 0085E020 20003000    9240C52C D283C52D C52C4400 C4020119   *D...E............ E.K.E.E...D...*            
 00D580   F1332000 30004120 20034130 30044640    C4089240 200007FB 3E50DF15 A4ACF313   *1.............. D.. ..........3.*            
 00D5A0   BB986AEB 3C6BC489 4A14FB92 12000000    C4870000 00000000 3E50DF15 A4ACF313   *......D.........D.............3.*            
 00D5C0   BB986AEB 3C6BC489 4A14FB92 12000000    C4870000 00000000 8000DF80 0000000F   *......D.........D...............*            
 00D5E0   C2D6E4E2 E3D9D6D7 C8C5C4D6 D5C9C300    0000DE58 FFFFFFFF FFFFFFFF FFFFFFF8   *BOUSTROPHEDONIC................8*            
 00D600   0000DF80 FFFFFFF8 FFFFFFF8 FFFFFFF8    FFFFFFF8 FFFFFFF8 FFFFFFF8 FFFFFFF8   *.......8...8...8...8...8...8...8*            
 00D620   FFFFFFF8 FFFFFFF8 FFFFFFF8 FFFFFFF8    FFFFFFF8 FFFFFFF8 FFFFFFF8 FFFFFFF8   *...8...8...8...8...8...8...8...8*            
 00D640   FFFFFFF8 0F0F0F0F 0F0F0F0F F0F1F2F3    F4F5F6F7 F8F9C1C2 C3C4C5C6 00000011   *...8........0123456789ABCDEF....*            
 00D660   060C3D60 0D4D7C10 0D9C5400 0C5D9D90    0D6D9400 06060400 0E2F0C30 0F340D60   *................................*            
 00D680   0C3C3E40 0D9E2400 0C1C6E30 0C5D9400    0E3C8C90 0E240D40 0C5E2E20 0C1C7C50   *... ................... ........*            
 00D6A0   05A40400 E7E7E7E7 E7E7E7E7 E7E7E7E7    E7E7E7E7 E7E7E7E7 E7E7E7E7 E7E7E7E7   *....XXXXXXXXXXXXXXXXXXXXXXXXXXXX*            
 00D6C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00D6E0-00D700    SAME AS ABOVE                                                                                           
 00D720   40404040 40404040 40000000 00000012    060E3C80 0C540C30 0D6D5E30 0C5D5E30   *         .......................*            
 00D740   0E240D60 0C640D90 0F1F4400 0E6C8C50    0D540C30 0D6D4D70 0C1D9C50 040C6C10   *................................*            
 00D760   0C9D3E40 0D9C5400 0D6C3C30 0E4D9C50    0C440C90 0E240400 E7E7E7E7 E7E7E7E7   *... ....................XXXXXXXX*            
 00D780   E7E7E7E7 E7E7E7E7 E7E7E7E7 E7E7E7E7    E7E7E7E7 E7E7E7E7 E7E7E7E7 E7E7E7E7   *XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX*            
 00D7A0   E7E7E7E7 E7E7E7E7 E7404040 404040E7    E7E7E7E7 E7E7E740 40404040 40404040   *XXXXXXXXX      XXXXXXXX         *            
 00D7C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
 00D7E0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 4040C7C7   *                              GG*            
 00D800   C7C7C7C7 C7C7C7C7 C7C7C7C7 C7C7C7C7    C7C7C7C7 C7C7C7C7 C7C7C7C7 C7C7C7C7   *GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG*            
1  LINES    00D820-00DF60    SAME AS ABOVE                                                                                           
 00DF80   C7C7C7C7 00000000 0000D5FC 00002850    0000D178 E3C3C2C7 0000DFC8 E3C3C2C7   *GGGG......N.......J.TCBG...HTCBG*            
 00DFA0   D9E24040 E3C3C2C6 D9E24040 40D7D9C2    D9C2C7D9 E2C1E5C5 D9C2C6D9 E2C1E5C5   *RS  TCBFRS   PRBRBGRSAVERBFRSAVE*            
 00DFC0   D7C9C540 F5FFF501 8000DFCE 0000000F    C2D6E4E2 E3D9D6D7 C8C5C4D6 D5C9C300   *PIE 5.5.........BOUSTROPHEDONIC.*            
 00DFE0   D7C9C540 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *PIE PIE PIE PIE PIE PIE PIE PIE *            
 00E000   47F0F028 09E2D6E2 D7C7D4F0 F94090EC    D00C0700 50D0F020 45D0F064 00000000   *.00..SOSPGM09 ........0...0.....*            
 00E020   0000EF84 00000000 41C0F53C 50C0F550    4160F57A 5060F574 41506001 BE5FF56B   *..........5...5...5...5.......5.*            
 00E040   47F0F00E 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *.00.............................*            
 00E060   00000000 58F0D004 50DF0008 4120D53C    D2032000 D5E4D201 2004D5E8 D2082005   *.....0........N.K...NUK...NYK...*            
 00E080   D5551812 5890D534 05894130 D5EA5030    20081812 0589D208 2005D54C 18120589   *N.....N.....N.........K...N.....*            
 00E0A0   12FF4770 D4FCD208 2005D555 18120589    47F0D07A 40C8C8C8 C8C8C8C8 C8C8C8C8   *....M.K...N......0.. HHHHHHHHHHH*            
 00E0C0   C8C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8    C8C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8   *HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH*            
   LINES    00E0E0-00E4E0    SAME AS ABOVE                                                                                           
 00E500   C8C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8    C8C8C8C8 C8C8C8C8 4130D66F D2082005   *HHHHHHHHHHHHHHHHHHHHHHHH..O.K...*            
 00E520   D5555030 20081812 05890560 BF1F6006    0A0D8065 432198EC D00C07FE 0A0007F8   *N..............................8*            
 00E540   40C8C8C8 C8C8C8C8 C8C8C8C8 C8C80000    0000E53C 40C8C8C8 C9D6C240 000F01FF   * HHHHHHHHHHHHH....V. HHHIOB ....*            
 00E560   0000E68B 00854040 0D02DD00 00E57B00    500F01FF 0000E57A 008560F9 F9F9F9F9   *..W...  .....V........V....99999*            
 00E580   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9   *99999999999999999999999999999999*            
 00E5A0   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F940   *9999999999999999999999999999999 *            
 00E5C0   40404040 40404040 4040404C 5C5C5C40    C2C1C3D2 40E3C8C5 D9C540C9 E240E3C8   *           .... BACK THERE IS TH*            
 00E5E0   C540C3C1 D9C460E2 40C5D5C4 5A4B4B4B    4B4B4B4B 4B4B4B40 40404040 40F5C640   *E CARD.S END...........      5F *            
 00E600   C9D6C240 0000F140 C6D6D940 D7C7D460    F240E3C8 C540C6C9 D9E2E340 D3C9D5C5   *IOB ..1 FOR PGM.2 THE FIRST LINE*            
 00E620   40C9E240 E3C8C9E2 4B4B4B4B 4B4B4040    40404040 40404040 40404040 40404040   * IS THIS......                  *            
 00E640   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00E660-00E660    SAME AS ABOVE                                                                                           
 00E680   40404040 40404040 40F5C640 C9D540D7    C7D460F2 40E3C8C9 E240D6C3 C3E4D9E2   *         5F IN PGM.2 THIS OCCURS*            
 00E6A0   40E6C8C5 D540C5D6 C640C9E2 40C8C9E3    40404040 40404040 40404040 40404040   * WHEN EOF IS HIT                *            
 00E6C0   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    00E6E0-00E6E0    SAME AS ABOVE                                                                                           
 00E700   40404040 40404040 40404040 4040F5C6    40C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8   *              5F HHHHHHHHHHHHHHH*            
 00E720   C8C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8    C8C8C8C8 C8C8C8C8 C8C8C8C8 C8C8C8C8   *HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH*            
   LINES    00E740-00EF60    SAME AS ABOVE                                                                                           
 00EF80   C8C8C8C8 C8C8C8C8 00000000 8F00E01C    00002850 0000E000 E3C3C2C7 0000EFCC   *HHHHHHHH................TCBG....*            
 00EFA0   E3C3C2C7 D9E24040 E3C3C2C6 0000E57B    0000E57A D9C2C7D9 E2C1E5C5 D9C2C6D9   *TCBGRS  TCBF..V...V.RBGRSAVERBFR*            
 00EFC0   E2C1E5C5 D7C9C540 0000E53C 8000EFD0    000EF7F7 F7F76BF8 F8F8F86B F9F9F9F9   *SAVEPIE ..V.......7777.8888.9999*            
 00EFE0   D7C9C540 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *PIE PIE PIE PIE PIE PIE PIE PIE *            
 00F000   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    00F020-0100C0    SAME AS ABOVE                                                                                           
 0100E0   00010D00 E3C8C540 C3C2F1F0 F040D7D6    D6D340C6 D6D3D3D6 E6E240E3 C8C9E240   *....THE CB100 POOL FOLLOWS THIS *            
 010100   00000000 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010120   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010140-0101E0    SAME AS ABOVE                                                                                           
 010200   00010100 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010220   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010240-0102E0    SAME AS ABOVE                                                                                           
 010300   00010200 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010320   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010340-0103E0    SAME AS ABOVE                                                                                           
 010400   00010300 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010420   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010440-0104E0    SAME AS ABOVE                                                                                           
 010500   00010400 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010520   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010540-0105E0    SAME AS ABOVE                                                                                           
 010600   00010500 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010620   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010640-0106E0    SAME AS ABOVE                                                                                           
 010700   00010600 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010720   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010740-0107E0    SAME AS ABOVE                                                                                           
1010800   00010700 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010820   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010840-0108E0    SAME AS ABOVE                                                                                           
 010900   00010800 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010920   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010940-0109E0    SAME AS ABOVE                                                                                           
 010A00   00010900 60C2D9C1 D5C4D6D5 40E3E6C5    C5C460E4 D5E4E2C5 C440C3C2 40404040   *.....BRANDON TWEED.UNUSED CB    *            
 010A20   40404040 40404040 40404040 40404040    40404040 40404040 40404040 40404040   *                                *            
   LINES    010A40-010AE0    SAME AS ABOVE                                                                                           
 010B00   C9D6C2E6 000F0100 00010B72 00000000    C4F9C3F2 C3F6C4F9 70000000 D9C2C6D9   *IOBW............D9C2C6D9....RBFR*            
 010B20   07F20000 00010B72 00010B70 00010B00    E3C3C2C7 00010B24 8F008226 00002800   *.2..............TCBG............*            
 010B40   00011900 00010C00 00008000 00010C80    00000004 00010C78 00010BCC 00010B00   *................................*            
 010B60   4F00823A 00010B30 00002850 000082C0    0000F0C6 D7D9A240 F06BF26B F46BF67A   *..................0FPR. 0.2.4.6.*            
 010B80   40404040 C5F3C3F3 C3F2C3F6 C4F9C5F2    F4F0F4F0 4040C5F3 C3F3C3F2 C3F6C4F9   *    E3C3C2C6D9E24040  E3C3C2C6D9*            
 010BA0   C5F2F4F0 F4F04040 F4F0C4F7 C4F9C3F2    C4F9C3F2 C3F7C4F9 4040C5F2 C3F1C5F5   *E24040  40D7D9C2D9C2C7D9  E2C1E5*            
 010BC0   C3F5C4F9 C3F2C3F6 C4F94040 40404040    40404040 40404040 40404040 40404040   *C5D9C2C6D9                      *            
 010BE0   40404040 40404040 40404040 40404040    40404040 40F2C600 00000000 00000000   *                     2F.........*            
 010C00   00010A00 00010F00 00000860 00011B00    00010D00 FFFFFFFF 7FC9D6E2 00000000   *.........................IOS....*            
 010C20   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    010C40-010CE0    SAME AS ABOVE                                                                                           
 010D00   00010C00 00011B00 00000000 E4D5C3C8    FF040003 4F002852 00000000 00011A00   *............UNCH................*            
 010D20   E3C3C2C7 00010F24 0000A558 0000A68B    E3C3C2C6 0000A57B 0000A57A D9C2C7D9   *TCBG............TCBF........RBGR*            
 010D40   6F00A52A 0000A53C FFFFFFFF D7C9C540    0000A53C 8F00A01C 00002850 000082C0   *............PIE ................*            
 010D60   E3C3C2C6 D9E24040 E3C3C2C6 D9E24040    40D7D9C2 D9C2C7D9 E2C1E5C5 D9C2C6D9   *TCBFRS  TCBFRS   PRBRBGRSAVERBFR*            
 010D80   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    010DA0-010DE0    SAME AS ABOVE                                                                                           
 010E00   C9D6C2E6 000F0100 00010E72 00000000    F0F0F0F0 F0F0F0F0 70000000 00000000   *IOBW............00000000........*            
 010E20   07F20000 00010E72 00010E70 00010E00    00000000 00010E24 8F008226 00002800   *.2..............................*            
 010E40   00011300 00011200 00008000 00011280    00000004 00011278 00010ECC 00010E00   *................................*            
 010E60   4F00823A 00010E30 00002850 000082C0    0000F0C6 D7D9A240 F06BF26B F46BF67A   *..................0FPR. 0.2.4.6.*            
 010E80   40404040 F3C5F5F0 C4C6F1F5 C1F4C1C3    C6F3F1F3 4040C2C2 F9F8F6C1 C5C2F3C3   *    3E50DF15A4ACF313  BB986AEB3C*            
 010EA0   F6C2C3F4 F8F94040 F4C1F1F4 C6C2F9F2    F1F2F0F0 F0F0F0F0 4040C3F4 F8F7F0F0   *6BC489  4A14FB9212000000  C48700*            
 010EC0   F0F0F0F0 F0F0F0F0 F0F04040 40404040    40404040 40404040 40404040 40404040   *0000000000                      *            
 010EE0   40404040 40404040 40404040 40404040    40404040 40F4C600 00000000 00000000   *                     4F.........*            
 010F00   C9D6C2E6 000F0100 00010F72 00000000    C4F9C3F2 C3F6C4F9 70000000 D9C2C6D9   *IOBW............D9C2C6D9....RBFR*            
 010F20   07F20000 00010F72 00010F70 00010F00    E3C3C2C7 00010F24 8F008226 00002800   *.2..............TCBG............*            
 010F40   00011B00 00010D00 00008000 00010D80    00000004 00010D78 00010FCC 00010F00   *................................*            
 010F60   4F00823A 00010F30 00002850 000082C0    0000F0C6 D7D9A240 F06BF26B F46BF67A   *..................0FPR. 0.2.4.6.*            
 010F80   40404040 C5F3C3F3 C3F2C3F6 C4F9C5F2    F4F0F4F0 4040C5F3 C3F3C3F2 C3F6C4F9   *    E3C3C2C6D9E24040  E3C3C2C6D9*            
 010FA0   C5F2F4F0 F4F04040 F4F0C4F7 C4F9C3F2    C4F9C3F2 C3F7C4F9 4040C5F2 C3F1C5F5   *E24040  40D7D9C2D9C2C7D9  E2C1E5*            
 010FC0   C3F5C4F9 C3F2C3F6 C4F94040 40404040    40404040 40404040 40404040 40404040   *C5D9C2C6D9                      *            
 010FE0   40404040 40404040 40404040 40404040    40404040 40F1C600 00000000 00000000   *                     1F.........*            
 011000   40D7D9C2 00011800 00000080 E4D5C3C8    FF150003 5F002852 00000000 00011800   * PRB........UNCH................*            
 011020   E3C3C2C7 00011224 D9C2C7D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D7C9C540 F6FF1501   *TCBG....RBGRSAVERBFRSAVEPIE 6...*            
 011040   190F00E0 007FC4C9 E201FFD5 6BD7C1D9    D47ED200 40005000 00000058 000082C0   *......DIS..N.PARM.K. ...........*            
 011060   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F6FF1501 190F00E0 007FC4C9   *RBFRSAVERBFRSAVEPIE 6.........DI*            
 011080   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    0110A0-0110E0    SAME AS ABOVE                                                                                           
 011100   40D7D9C2 00011300 00000080 E4D5C3C8    FF050003 7F002852 00000000 00011300   * PRB........UNCH................*            
 011120   00000000 00010E24 D9C2C7D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D7C9C540 F5FF0501   *........RBGRSAVERBFRSAVEPIE 5...*            
 011140   190F00D1 787FC4C9 E201FFD5 6BD7C1D9    D47ED200 40005000 00000058 000082C0   *...J..DIS..N.PARM.K. ...........*            
 011160   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F5FF0501 190F00D1 787FC4C9   *RBFRSAVERBFRSAVEPIE 5......J..DI*            
 011180   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    0111A0-0111E0    SAME AS ABOVE                                                                                           
 011200   C9D6C2E6 000F0100 00011272 00000000    C4F9C3F2 C3F6C4F9 70000000 D9C2C6D9   *IOBW............D9C2C6D9....RBFR*            
 011220   07F20000 00011272 00011270 00011200    E3C3C2C7 00011224 8F008226 00002800   *.2..............TCBG............*            
 011240   00011800 00010F00 00008000 00010F80    00000004 00010F78 000112CC 00011200   *................................*            
 011260   4F00823A 00011230 00002850 000082C0    0000F0C6 D7D9A240 F06BF26B F46BF67A   *..................0FPR. 0.2.4.6.*            
 011280   40404040 C5F3C3F3 C3F2C3F6 C4F9C5F2    F4F0F4F0 4040C5F3 C3F3C3F2 C3F6C4F9   *    E3C3C2C6D9E24040  E3C3C2C6D9*            
 0112A0   C5F2F4F0 F4F04040 F4F0C4F7 C4F9C3F2    C4F9C3F2 C3F7C4F9 4040C5F2 C3F1C5F5   *E24040  40D7D9C2D9C2C7D9  E2C1E5*            
10112C0   C3F5C4F9 C3F2C3F6 C4F94040 40404040    40404040 40404040 40404040 40404040   *C5D9C2C6D9                      *            
 0112E0   40404040 40404040 40404040 40404040    40404040 40F5C600 00000000 00000000   *                     5F.........*            
 011300   00000000 00000000 E3C3C2F4 40C2C4E3    D6C2D1D4 D6C4D5C9 7FDB6D82 00000000   *........TCB4 BDTOBJMODNI........*            
 011320   00000000 000423A8 E4D5C3C8 E3C3C240    00000000 00010E24 D9C2C7D9 E2C1E5C5   *........UNCHTCB ........RBGRSAVE*            
 011340   D9C2C6D9 E2C1E5C5 D7C9C540 F5FF0501    190F00D1 787FC4C9 E201FFD5 6BD7C1D9   *RBFRSAVEPIE 5......J..DIS..N.PAR*            
 011360   D47ED200 40005000 00000058 000082C0    00000000 00011600 00000000 00000000   *M.K. ...........................*            
 011380   0000DFE0 0000DFC8 0000DF80 00000000    00000000 00000000 00000000 00000000   *.......H........................*            
 0113A0   7FDB2E41 00000000 00000000 00000016    00000098 00000000 00000000 00000000   *................................*            
 0113C0   00010008 00000000 00000000 00000000    00000000 00000000 00000000 00011F00   *................................*            
 0113E0   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F5FF0501 190F00D1 787FC4C9   *RBFRSAVERBFRSAVEPIE 5......J..DI*            
 011400   40D7D9C2 00011600 00000080 E4D5C3C8    FFF50003 5F002852 00000000 00011600   * PRB........UNCH.5..............*            
 011420   E3C3C2C7 00011524 D9C2C7D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D7C9C540 F4FFF501   *TCBG....RBGRSAVERBFRSAVEPIE 4.5.*            
 011440   190F00C0 007FC4C9 E201FFD5 6BD7C1D9    D47ED200 40005000 00000058 000082C0   *......DIS..N.PARM.K. ...........*            
 011460   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F4FFF501 190F00C0 007FC4C9   *RBFRSAVERBFRSAVEPIE 4.5.......DI*            
 011480   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    0114A0-0114E0    SAME AS ABOVE                                                                                           
 011500   C9D6C2E6 000F0100 00011572 00000000    C4F9C3F2 C3F6C4F9 70000000 D9C2C6D9   *IOBW............D9C2C6D9....RBFR*            
 011520   07F20000 00011572 00011570 00011500    E3C3C2C7 00011524 8F008226 00002800   *.2..............TCBG............*            
 011540   00011600 00011200 00008000 00011280    00000004 00011278 000115CC 00011500   *................................*            
 011560   4F00823A 00011530 00002850 000082C0    0000F0C6 D7D9A240 F06BF26B F46BF67A   *..................0FPR. 0.2.4.6.*            
 011580   40404040 C5F3C3F3 C3F2C3F6 C4F9C5F2    F4F0F4F0 4040C5F3 C3F3C3F2 C3F6C4F9   *    E3C3C2C6D9E24040  E3C3C2C6D9*            
 0115A0   C5F2F4F0 F4F04040 F4F0C4F7 C4F9C3F2    C4F9C3F2 C3F7C4F9 4040C5F2 C3F1C5F5   *E24040  40D7D9C2D9C2C7D9  E2C1E5*            
 0115C0   C3F5C4F9 C3F2C3F6 C4F94040 40404040    40404040 40404040 40404040 40404040   *C5D9C2C6D9                      *            
 0115E0   40404040 40404040 40404040 40404040    40404040 40F3C600 00000000 00000000   *                     3F.........*            
 011600   00000000 00000000 E3C3C2F3 40C2C4E3    E2D6E2D7 C7D4F0F2 7FB889CC 00000000   *........TCB3 BDTSOSPGM02........*            
 011620   00000000 001CD699 E4D5C3C8 E3C3C240    E3C3C2C7 00011524 D9C2C7D9 E2C1E5C5   *......O.UNCHTCB TCBG....RBGRSAVE*            
 011640   D9C2C6D9 E2C1E5C5 D7C9C540 F4FFF501    190F00C0 007FC4C9 E201FFD5 6BD7C1D9   *RBFRSAVEPIE 4.5.......DIS..N.PAR*            
 011660   D47ED200 40005000 00000058 000082C0    00000000 00011B00 00000000 00000000   *M.K. ...........................*            
 011680   0000CFE0 0000CFD0 0000CF88 00000000    00000000 00000000 00000000 00000000   *................................*            
 0116A0   7FB7D495 00000000 00000000 00000069    00000099 00000000 00000000 00000000   *..M.............................*            
 0116C0   00181A06 00000000 00000000 00000000    00000000 00000000 00000000 00011800   *................................*            
 0116E0   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F4FFF501 190F00C0 007FC4C9   *RBFRSAVERBFRSAVEPIE 4.5.......DI*            
 011700   40D7D9C2 00011900 00000080 E4D5C3C8    FFE50003 5F002852 00000000 00011900   * PRB........UNCH.V..............*            
 011720   E3C3C2C7 00010B24 D9C2C7D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D7C9C540 F3FFE501   *TCBG....RBGRSAVERBFRSAVEPIE 3.V.*            
 011740   190F00B0 007FC4C9 E201FFD5 6BD7C1D9    D47ED200 40005000 00000058 000082C0   *......DIS..N.PARM.K. ...........*            
 011760   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F3FFE501 190F00B0 007FC4C9   *RBFRSAVERBFRSAVEPIE 3.V.......DI*            
 011780   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    0117A0-0117E0    SAME AS ABOVE                                                                                           
 011800   00000000 00000000 E3C3C2F5 40C2C4E3    E2D6E2D7 C7D4F0F9 7FB14AFD 00000000   *........TCB5 BDTSOSPGM09........*            
 011820   00000000 001E1D0C E4D5C3C8 E3C3C240    E3C3C2C7 00011224 D9C2C7D9 E2C1E5C5   *........UNCHTCB TCBG....RBGRSAVE*            
 011840   D9C2C6D9 E2C1E5C5 D7C9C540 F6FF1501    190F00E0 007FC4C9 E201FFD5 6BD7C1D9   *RBFRSAVEPIE 6.........DIS..N.PAR*            
 011860   D47ED200 40005000 00000058 000082C0    00000000 00011B00 00000000 00000000   *M.K. ...........................*            
 011880   0000EFE0 0000EFCC 0000EF84 00000000    00000000 00000000 00000000 00000000   *................................*            
 0118A0   7FB10BC4 00000000 00000000 000000C6    00000099 00000000 00000000 00000000   *...D...........F................*            
 0118C0   0035003D 00000000 00000000 00000000    00000000 00000000 00000000 00011F00   *................................*            
 0118E0   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F6FF1501 190F00E0 007FC4C9   *RBFRSAVERBFRSAVEPIE 6.........DI*            
 011900   00000000 00000000 E3C3C2F2 40C2C4E3    E2D6E2D7 C7D4F0F9 7FCDF1BC 00000000   *........TCB2 BDTSOSPGM09..1.....*            
 011920   00000000 001B1E8B E4D5C3C8 E3C3C240    E3C3C2C7 00010B24 D9C2C7D9 E2C1E5C5   *........UNCHTCB TCBG....RBGRSAVE*            
 011940   D9C2C6D9 E2C1E5C5 D7C9C540 F3FFE501    190F00B0 007FC4C9 E201FFD5 6BD7C1D9   *RBFRSAVEPIE 3.V.......DIS..N.PAR*            
 011960   D47ED200 40005000 00000058 000082C0    00000000 00011B00 00000000 00000000   *M.K. ...........................*            
 011980   0000BFE0 0000BFD8 0000BF90 00000000    00000000 00000000 00000000 00000000   *.......Q........................*            
 0119A0   7FCDB27A 00000000 00000000 000000C9    00000098 00000000 00000000 00000000   *...............I................*            
 0119C0   0032003A 00000000 00000000 00000000    00000000 00000000 00000000 00011600   *................................*            
 0119E0   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F3FFE501 190F00B0 007FC4C9   *RBFRSAVERBFRSAVEPIE 3.V.......DI*            
 011A00   40D7D9C2 00011B00 00000080 E4D5C3C8    FFD50003 5F002852 00000000 00011B00   * PRB........UNCH.N..............*            
 011A20   E3C3C2C7 00010F24 D9C2C7D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D7C9C540 F2FFD501   *TCBG....RBGRSAVERBFRSAVEPIE 2.N.*            
 011A40   190F00A0 007FC4C9 E201FFD5 6BD7C1D9    D47ED200 40005000 00000058 000082C0   *......DIS..N.PARM.K. ...........*            
 011A60   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F2FFD501 190F00A0 007FC4C9   *RBFRSAVERBFRSAVEPIE 2.N.......DI*            
 011A80   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    011AA0-011AE0    SAME AS ABOVE                                                                                           
1011B00   00000000 00000000 E3C3C2F1 40C2C4E3    E2D6E2D7 C7D4F0F2 7FA8DAAD 00000000   *........TCB1 BDTSOSPGM02........*            
 011B20   00000000 003CF322 E4D5C3C8 E3C3C240    E3C3C2C7 00010F24 D9C2C7D9 E2C1E5C5   *......3.UNCHTCB TCBG....RBGRSAVE*            
 011B40   D9C2C6D9 E2C1E5C5 D7C9C540 F2FFD501    190F00A0 007FC4C9 E201FFD5 6BD7C1D9   *RBFRSAVEPIE 2.N.......DIS..N.PAR*            
 011B60   D47ED200 40005000 00000058 000082C0    00000000 00011D00 00000000 00000000   *M.K. ...........................*            
 011B80   0000AFE0 0000AFD4 0000AF8C 00000000    00000000 00000000 00000000 00000000   *.......M........................*            
 011BA0   7FA89B72 00000000 00000000 00000147    0000009A 00000000 00000000 00000000   *................................*            
 011BC0   00525406 00000000 00000000 00000000    00000000 00000000 00000000 00011F00   *................................*            
 011BE0   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D7C9C540 F2FFD501 190F00A0 007FC4C9   *RBFRSAVERBFRSAVEPIE 2.N.......DI*            
 011C00   40D7D9C2 00011D00 00000080 00000000    FFE6000F 0F0000BC 00000000 00011D00   * PRB.............W..............*            
 011C20   D9C2C7D9 E2C1E5C5 D9C2C7D9 E2C1E5C5    D9C2C7D9 E2C1E5C5 D9C2C7D9 E2C1E5C5   *RBGRSAVERBGRSAVERBGRSAVERBGRSAVE*            
   LINES    011C40-011C40    SAME AS ABOVE                                                                                           
 011C60   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5   *RBFRSAVERBFRSAVERBFRSAVERBFRSAVE*            
 011C80   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    011CA0-011CE0    SAME AS ABOVE                                                                                           
 011D00   00011C00 00000000 E3C3C2E6 40C2C4E3    00000000 00000000 00000000 00000000   *........TCBW BDT................*            
 011D20   00000000 00000000 00000000 E3C3C240    E3C3C2C7 D9E24040 E3C3C2C7 D9E24040   *............TCB TCBGRS  TCBGRS  *            
 011D40   E3C3C2C7 D9E24040 E3C3C2C7 D9E24040    E3C3C2C7 D9E24040 E3C3C2C7 D9E24040   *TCBGRS  TCBGRS  TCBGRS  TCBGRS  *            
 011D60   E3C3C2C7 D9E24040 E3C3C2C7 D9E24040    00000000 00000000 00000000 00000000   *TCBGRS  TCBGRS  ................*            
 011D80   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 011DA0   7FA8DAA6 00000000 00000000 0056DE31    00000000 00000000 00000000 00000000   *................................*            
 011DC0   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00011F00   *................................*            
 011DE0   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 011E00   40D7D9C2 00011F00 00000080 00000000    FF040001 4F012048 00000000 00011F00   * PRB............................*            
 011E20   D9C2C7D9 E2C1E5C5 D9C2C7D9 E2C1E5C5    D9C2C7D9 E2C1E5C5 D9C2C7D9 E2C1E5C5   *RBGRSAVERBGRSAVERBGRSAVERBGRSAVE*            
   LINES    011E40-011E40    SAME AS ABOVE                                                                                           
 011E60   D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5    D9C2C6D9 E2C1E5C5 D9C2C6D9 E2C1E5C5   *RBFRSAVERBFRSAVERBFRSAVERBFRSAVE*            
 011E80   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
   LINES    011EA0-011EE0    SAME AS ABOVE                                                                                           
 011F00   00011E00 00000000 E3C3C2D4 40C2C4E3    00000000 00000000 7FDAB31B 00000000   *........TCBM BDT................*            
 011F20   00000000 0022BDCA 00000000 E3C3C240    00000001 00012544 E3C3C2C7 00002800   *............TCB ........TCBG....*            
 011F40   00000004 00012428 00012490 0000000D    00012540 00011800 00011F00 00011600   *................... ............*            
 011F60   4F012000 D9E24040 E3C3C2C7 00000001    00000000 00011D00 00000000 00000000   *....RS  TCBG....................*            
 011F80   00012384 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 011FA0   7FA89B53 00000000 00000000 00000007    0000048B 00000000 00000000 00000000   *................................*            
 011FC0   8F000500 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 011FE0   00000000 00000000 00000000 00000000    00000000 00000000 00000000 00000000   *................................*            
 012000   05C006C0 06C05830 004C1777 17884190    00025870 C3804180 04001807 18180104   *....................C...........*            
 012020   0A080102 12FF4770 C37258A0 30045070    A0404178 70004690 C01A4180 C5404100   *........C........ ..........E ..*            
 012040   00014110 80040A01 D5038004 C3E14770    C370D503 800C8008 47B0C366 4110C580   *........N...C...C.N.......C...E.*            
 012060   95E8C3E7 4780C074 0A0012FF 4780C082    92E8C3E7 5800800C 12004780 C37047F0   *.YCX.............YCX........C..0*            
 012080   C3665840 80105850 C4904370 80158970    00180E46 58408010 43908014 08944140   *C.. ....D............ ......... *            
 0120A0   48000894 41400FE0 5A408010 5040C49C    D2034000 C3D4D21B 40044000 4150C440   *..... ... ... D.K. .CMK. . ...D *            
 0120C0   41605050 D5055000 C3E84780 C0DC1956    4780C120 41505001 47F0C0C4 41505006   *....N...CY........A......0.D....*            
 0120E0   19564720 C1209540 50004780 C120957D    50004780 C0FE9240 C40A47F0 C106927D   *....A.. ....A.......... D..0A...*            
 012100   C40A4150 50011875 D5007000 C40A4780    C12A4170 70011976 4720C120 47F0C108   *D.......N...D...A.........A..0A.*            
 012120   1777BE73 C40847F0 C14A1B75 BE73C408    9101C409 4780C13E 06409200 40001B47   *....D..0A.....D...D...A.. .. ...*            
 012140   5040C3F8 06704470 C3EE5B40 C4045040    C3FC9103 C3FFD201 4000C408 4780C16A   *. C8....C.. D.. C...C.K. .D...A.*            
 012160   06400640 D7014000 40005B40 C4009280    4000D202 4001C3FD 5040C3F8 5B40C494   *. . P. . .. D... .K. .C.. C8. D.*            
 012180   5040C4A4 D7034004 40045800 80101B40    18140104 0A089204 C1930102 12FF4770   *. D.P. . ...... ........A.......*            
 0121A0   C3705000 C4985010 C4A058B0 301858AB    000012AA 4770C1CE 0119C3C2 F1F0F040   *C...D...D.............A...CB100 *            
 0121C0   D7D6D6D3 40C9E240 C5D4D7E3 E8F7D203    B000A000 189AD7FF 90009000 D2079008   *POOL IS EMPTY7K.......P.....K...*            
 0121E0   C3A492F1 900BD203 902CC3AC 43A0C3D8    42A0900B 41A0A001 42A0C3D8 D2079030   *C..1..K...C...CQ..........CQK...*            
 012200   C3B0D237 9038C3B0 D20790E0 C3B8D217    90E8C3B8 D2039034 C3F8D203 9064C4A4   *C.K...C.K...C.K..YC.K...C8K...D.*            
 012220   D203906C C498D203 9080C49C 41B03050    50B09068 D2039084 C3F8D203 9088C4A4   *K...D.K...D.........K...C8K...D.*            
 012240   5810C498 D2079010 100558B0 301858AB    000012AA 4770C26E 0119C3C2 F1F0F040   *..D.K.................B...CB100 *            
 012260   D7D6D6D3 40C9E240 C5D4D7E3 E8F7D203    B000A000 D7FFA000 A0005090 A00450A0   *POOL IS EMPTY7K.....P...........*            
 012280   9000D203 A000C3C0 9680A00B D300C3DA    80145810 C498BE17 C3DED207 A010C3D9   *..K...C.....L.C.....D...C.K...CR*            
 0122A0   D207A020 C3C4D237 A028C3C4 D207A060    C3CCD217 A068C3CC BE97A01D D203C2D2   *K...CDK...CDK...C.K...C.....K.BK*            
 0122C0   C4984510 07E0F0F0 F0F0C5F0 F0F02D40    40400000 E000D207 C4C1C2C6 D203C2F2   *D.....0000E000.   ....K.DABFK.B2*            
 0122E0   C4A04510 07E0F0F0 F0F0F0F7 F1F02D40    40400000 0710D207 C4DAC2E6 5840C498   *D.....00000710.   ....K.D.BW. D.*            
1012300   D207C4F4 4005D207 C5079008 4110C5A0    0A005840 C4905A40 80105040 80104140   *K.D4 .K.E.....E.... D.. ... ... *            
 012320   00015A40 800C5040 800C4350 80154150    50014250 80154350 80144150 50104250   *... ... ........................*            
 012340   80148000 C3E558A0 300850A0 90DC58B0    A0745090 A07450B0 90745090 B0DC8000   *....CV..........................*            
 012360   C3E647F0 C052D703 C544C544 47F0C03E    01190119 F7F7F7F7 F7F7F7F7 F7F7F7F7   *CW.0..P.E.E..0......777777777777*            
 012380   00007800 D7C9C540 D7C9C540 D7C9C540    D7C9C540 D7C9C540 D7C9C540 D7C9C540   *....PIE PIE PIE PIE PIE PIE PIE *            
 0123A0   D7C9C540 E3C3C295 40C2C4E3 E3C3C240    E3C3C2C7 D9E24040 E3C3C2C6 D9E24040   *PIE TCB. BDTTCB TCBGRS  TCBFRS  *            
 0123C0   40D7D9C2 D9C2C7D9 E2C1E5C5 D9C2C6D9    E2C1E5C5 D7C9C540 F6FF1501 190F00E0   * PRBRBGRSAVERBFRSAVEPIE 6.......*            
 0123E0   007FC4C9 E201FFE8 6BD7C1D9 D47ED200    40005000 00000058 0000EFCC 0000EFD0   *..DIS..Y.PARM.K. ...............*            
 012400   00000004 00000002 000E7DF7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *...........777777777777777777777*            
 012420   C2E4C6C6 C5D940D3 C9C5E240 C2C5D3D6    E6404040 40404040 40404040 40404040   *BUFFER LIES BELOW               *            
 012440   F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9    F9F9F9F9 F9F9F9F9 F9F9F9F9 F9F9F9F9   *99999999999999999999999999999999*            
   LINES    012460-012460    SAME AS ABOVE                                                                                           
 012480   F9F9F9F9 40404040 40404040 40404040    00001000 00000048 0000E000 0000EFE0   *9999            ................*            
 0124A0   00000710 0000EF84 40D6E240 D6C640C2    D9C1D5C4 D6D540E3 E6C5C5C4 40D3C17A   *........ OS OF BRANDON TWEED LA.*            
 0124C0   40F0F0F0 F0C5F0F0 F040D7D9 D6C7D9C1    D440D3C5 D5C7E3C8 7A40F0F0 F0F0F0F7   * 0000E000 PROGRAM LENGTH. 000007*            
 0124E0   F1F040C2 E8E3C5E2 4B40D7C7 D440D5C1    D4C57A40 E2D6E2D7 C7D4F0F9 40E3C3C2   *10 BYTES. PGM NAME. SOSPGM09 TCB*            
 012500   40D5C1D4 C57A40E3 C3C2F540 C2C4E340    40404040 40404040 40404040 40404040   * NAME. TCB5 BDT                 *            
 012520   40404040 40404040 404040D4 C5404040    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *           ME   7777777777777777*            
 012540   D4E2C4C1 7FC4C9E2 00000005 00000000    0000F000 28C9F7F7 F7F7F7F7 F7F7F7F7   *MSDA.DIS..........0..I7777777777*            
 012560   41100000 00000000 C1200000 00000000    41300000 00000000 C1400000 00000000   *........A...............A ......*            
 012580   C9D6C2D9 000C02F0 00012440 00500000    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *IOBR...0... ....7777777777777777*            
 0125A0   C9D6C2E6 000E01F0 000124A8 00850000    95F100BF 477000BC 92F000BF 58B03018   *IOBW...0.........1.......0......*            
 0125C0   58AB0000 12AA4770 C0300119 C3C2F1F0    F040D7D6 D6D340C9 E240C5D4 D7E3E8F7   *............CB100 POOL IS EMPTY7*            
 0125E0   D203B000 A000D7FF A000A000 5010A004    D203A000 C0D65040 A00C5050 A0104180   *K.....P.........K....O. ........*            
 012600   0800D501 10048004 4780C06A 58808008    12884780 C0D447F0 C0525080 A008D503   *..N..................M.0......N.*            
 012620   C0DC8014 4780C08E 58708014 D503C0DC    70144780 C0965870 701447F0 C07C50A0   *............N..............0....*            
 012640   801447F0 C09A50A0 70144100 00014110    A0185860 30044160 60085860 60001266   *...0............................*            
 012660   4780C0D4 95F000BF 477000BC 92F100BF    05E695F1 00BF4770 00BC92F0 00BF58C0   *...M.0.......1...W.1.......0....*            
 012680   302007FC 0119D9D8 C540F7F7 00000000    58C0004C 58C0C01C 07FC5830 004C5860   *......RQE 77....................*            
 0126A0   300C95FF 60064780 C03A5870 60141277    4780C03A D2036014 7014D203 7014C052   *....................K.....K.....*            
 0126C0   D5036010 C04E4770 C04A5070 601058C0    601807FC 58606008 12664770 C00858C0   *N...............................*            
 0126E0   302407FC 0119F7F7 00000000 FFFFFFFF    58807004 D202C049 80094190 C048BE97   *......77............K...........*            
 012700   00499200 00489C00 000C4770 C04492FF    6006D203 00B00050 5840700C D2034018   *..................K...... ..K. .*            
 012720   00B0BF11 40C04110 1001BE11 40C058C0    302007FC 0119F7F7 02012440 00000050   *.... ....... .........77... ....*            
 012740   58807004 D202C049 80094190 C048BE97    00499200 00489C00 000D4770 C04492FF   *....K...........................*            
 012760   6006D203 00B00050 5840700C D2034018    00B0BF11 40C14110 1001BE11 40C158C0   *..K...... ..K. ..... A...... A..*            
 012780   302007FC 0119F7F7 0200A57B 00000050    58807004 58908008 95F19000 4780C038   *......77.................1......*            
 0127A0   95409000 4780C044 95F09000 4780C050    95609000 4780C05C 954E9000 4770C044   *. .......0......................*            
 0127C0   41A0C0C0 47F0C068 928BC0B8 41A0C0B8    47F0C068 920BC0B8 41A0C0B8 47F0C068   *.....0...........0...........0..*            
 0127E0   9213C0B8 41A0C0B8 47F0C068 921BC0B8    41A0C0B8 47F0C068 92C59084 5840700C   *.........0...........0...E... ..*            
 012800   D2009083 400B4190 9001BE97 C0C1BEA7    00499200 00489C00 000E4770 C0B092FF   *K... ........A..................*            
 012820   6006D203 00B00050 D2034018 00B0BF11    40C24110 1001BE11 40C258C0 302007FC   *..K.....K. ..... B...... B......*            
 012840   0119F7F7 F7F7F7F7 0B000000 40000001    0100A68C 00000084 58807004 58908008   *..777777.... ...................*            
 012860   95F19000 4780C038 95409000 4780C044    95F09000 4780C050 95609000 4780C05C   *.1....... .......0..............*            
 012880   954E9000 4770C044 41A0C0C0 47F0C068    928BC0B8 41A0C0B8 47F0C068 920BC0B8   *.............0...........0......*            
 0128A0   41A0C0B8 47F0C068 9213C0B8 41A0C0B8    47F0C068 921BC0B8 41A0C0B8 47F0C068   *.....0...........0...........0..*            
 0128C0   92C69084 5840700C D2009083 400B4190    9001BE97 C0C1BEA7 00499200 00489C00   *.F... ..K... ........A..........*            
 0128E0   000F4770 C0B092FF 6006D203 00B00050    D2034018 00B0BF11 40C34110 1001BE11   *..........K.....K. ..... C......*            
 012900   40C358C0 302007FC 0119F7F7 F7F7F7F7    13000000 40000001 01010F73 00000084   * C........777777.... ...........*            
 012920   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    012940-01FFE0    SAME AS ABOVE                                                                                           
 020000   C8C9C7C8 C5E2E340 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *HIGHEST 777777777777777777777777*            
 020020   F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7    F7F7F7F7 F7F7F7F7 F7F7F7F7 F7F7F7F7   *77777777777777777777777777777777*            
   LINES    020040-0207E0    SAME AS ABOVE                                                                                           
0                                                                                                                                    
 !! END OF JES SPOOL FILE !!
                                                                                                                                    
OS OF BRANDON TWEED LA: 0000A000 PROGRAM LENGTH: 00000710 BYTES. PGM NAME: SOSPGM02 TCB NAME: TCB1 BDT                            ME
                                                                                                                                    
 IN PGM-2 WE PUT THIS IN THE READ BUFFER                                        <*** BACK THERE IS THE CARD-S END!..........      1E
¤                                                                                                                                    
 FOR PGM-2 THE FIRST LINE IS THIS......                                                                                           1E
                                                                                                                                    
*/*                                                                  */ 00005000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*PROPRIETARY V3 STATEMENT                                          */ 00010000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*LICENSED MATERIALS - PROPERTY OF IBM                              */ 00015000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*"RESTRICTED MATERIALS OF IBM"                                     */ 00020000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*5695-DF1                                                          */ 00025000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*(C) COPYRIGHT 1992  IBM CORP.                                     */ 00030000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*END PROPRIETARY V3 STATEMENT                                      */ 00037500<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*/*                                                                  */ 00045000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
OS OF BRANDON TWEED LA: 0000B000 PROGRAM LENGTH: 00000710 BYTES. PGM NAME: SOSPGM09 TCB NAME: TCB2 BDT                            ME
                                                                                                                                    
*%/*                                                               @L1A 00047500<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MACRO                                                          00050000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*       CHANGE LEVEL = 11                                              00150000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*$L1=XXXXXXX,JDZ1110,930930,SJPLMET: PL/X SUPPORT                 @L1A 00199900<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&RPL' NE '').JES                                       00250000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&DSORG' EQ '').A1                                      00350000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&DSORG' EQ 'ALL').A3                                   00450000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AGO   .A3                                                      00550000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
&NAME    IHBINNRA &DECB                                                 00650000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
OS OF BRANDON TWEED LA: 0000C000 PROGRAM LENGTH: 00000710 BYTES. PGM NAME: SOSPGM02 TCB NAME: TCB3 BDT                            ME
                                                                                                                                    
         SR    15,15                                               @01A 00733300<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
 IN PGM-2 WE PUT THIS IN THE READ BUFFER                                        <*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         BALR  14,15                    LINK TO CHECK ROUTINE           00800000<*** BACK THERE IS THE CARD-S END!..........      1E
¤                                                                                                                                    
 FOR PGM-2 THE FIRST LINE IS THIS......                                                                                           3E
                                                                                                                                    
.A2      ANOP                                                           00900000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         L     15,76(0,14)              LOAD CHECK RTN ADDR FOR ISAM    01050000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.A3      ANOP                                                           01200000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         L     14,8(0,1)                PICK UP DCB ADDR                01300000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         TM    26(14),X'80'             CHECK ISAM                      01400000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         SR    15,15                                               @01A 01475000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         BALR  14,15                    LINK TO CHECK ROUTINE ADDR      01550000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.E1      IHBERMAC 7                     DECB OPERAND MISSING            01650000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.JES     ANOP                                                           01750000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&RPL'(1,1) EQ '(').RPLR                                01850000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
OS OF BRANDON TWEED LA: 0000D178 PROGRAM LENGTH: 00000175 BYTES. PGM NAME: OBJMODNI TCB NAME: TCB4 BDT                            ME
                                                                                                                                    
* */ CHECK: MACRO KEYS(1:1(DECB_ADDR,DECB_NAME),SYNAD_NAME,    /*@L1A*/ 02600000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*   ANS('? '||MACLABEL||' CHECKP '||MACKEYS||';') RESCAN SKIP; /*@L1A*/ 02700000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
OS OF BRANDON TWEED LA: 0000E000 PROGRAM LENGTH: 00000710 BYTES. PGM NAME: SOSPGM09 TCB NAME: TCB5 BDT                            ME
                                                                                                                                    
.*                                                                    * 00023600<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                    * 00025400<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.*LICENSED MATERIALS - PROPERTY OF IBM                                  00026800<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*END PROPRIETARY V3 STATEMENT                                          00029900<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.*CHANGE ACTIVITY - AS FOLLOWS:                                       * 00034300<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                    * 00040000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.BRANCH1 ANOP                                                      @SSA 00064500<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AGO   .BRANCH3                                            @SSA 00070500<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         AGO   .BRANCH3                                            @SSA 00076500<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEXIT                                                          00120000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         MEND                                                           00160000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MACRO                                                          00020000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.* $MAC(NOTE):                                                          00028800<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*LICENSED MATERIALS - PROPERTY OF IBM                                  00034400<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.*5695-DF1                                                              00040000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*END PROPRIETARY V3 STATEMENT                                          00045600<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.*                                                                      00051900<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                      00054100<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.* $L1=31BIT,JDZ1110,,SJPLRK:  INVOCABLE IN 31-BIT MODE           @L1A  00056400<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.* $L3=NOTEDECB,HDZ11B0,940426,SJPLCC: SUPPORT DECB KEYWORD       @L3A  00057300<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         AIF   ('&DCB' EQ '').ERR                                       00060000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&TYPE' NE 'REL').NOTREL                           @H1A 00090000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         ICM   15,7,85(1)                        NOTE  RTN ADDRESS @L1C 00110000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         BALR  14,15                             LINK TO NOTE  ROUTINE  00120000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.DECBNT  BAS   14,8(,15)                         LINK TO NOTE RTN  @L3A 00140800<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.NOTREL  AIF   ('&TYPE' NE 'ABS').ERR1                             @H1A 00142500<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         SLR   0,0                      INDICATES NOTE MACRO       @H1A 00145000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         SVC   109                      SUPERVISOR CALL            @H1A 00150000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
.ERR1    MNOTE 8,'INVALID PARAMETER FOR TYPE'                 @H1A      00155000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEXIT                                                     @H1A 00157500<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
         MEXIT                                                     @L3A 00159100<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEND                                                           00180000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
*                   0:1(CU_BLOCKID_NAME,CU_BLOCKID_ADDR),      /*@L2A*/ 00280000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
*                   0:1(BLOCKID_TYPE,ABS_BLOCK,REL_BLOCK),     /*@L2A*/ 00380000<*** BACK THERE IS THE CARD-S END!..........      3E
                                                                                                                                    
* ANS('? '||MACLABEL||' NOTEP '||MACKEYS||';') RESCAN SKIP;    /*@L2A*/ 00480000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
IN PGM-2 THIS OCCURS WHEN EOF IS HIT                                                                                              3E
                                                                                                                                    
&NAME    ERASE   &RPL=                                                  06000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.* /*    MACCOMP Y-2 SC1DE/SJD61                                     */ 06100000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.* /*                                                                */ 06200000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                      06250000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                             @WA04075 06350000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*PROPRIETARY V3 STATEMENT                                     @WA04075 06400000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*"RESTRICTED MATERIALS OF IBM"                                @WA04075 06500000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*5695-DF1                                                     @WA04075 06550000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*END PROPRIETARY V3 STATEMENT                                 @WA04075 06650000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                      06750000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                      06850000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*  CHANGE ACTIVITY:                                                    06900000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*  PREVENT COPYRIGHT FROM SHOWING WHEN MACRO IS INVOKED       @WA04075 07000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&RPL' NE '').OKY                                       09000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEXIT                                                          15000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
&NAME    DS    0H                                                       21000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         LA    1,&RPL                   LOAD RPL ADDR                   27000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.RPLR    AIF   ('&RPL' EQ '(1)').AREG   IF RPL=(1),SKIP LR INSTRUCTION  33000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.AREG    LA    0,X'05'                  INDICATE ERASE IN REG           39000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         L     15,8(15)                 LOAD AM/0 INTERFACE RTN ADDR    45000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEND                                                           51000000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MACRO                                                          00050000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
&NAME    EXCP  &IOB                                                     00100000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.********************************************************************** 00105000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                    * 00110000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*   COPYRIGHT -                                                      * 00115000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*     5740-XC6                                                       * 00120000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*     THIS MACRO IS "RESTRICTED MATERIALS OF IBM"                    * 00125000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*     (C) COPYRIGHT IBM CORP. 1982                                   * 00130000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*     LICENSED MATERIALS - PROPERTY OF IBM                           * 00135000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.*                                                                    * 00140000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.********************************************************************** 00145000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         AIF   ('&IOB' EQ '').E1                                        00150000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
&NAME    IHBINNRA &IOB                      LOAD REG 1                  00200000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         SVC   0                                 ISSUE SVC FOR EXCP     00250000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEXIT                                                          00300000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
.E1      IHBERMAC 01,039                    IOB MISSING                 00350000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
         MEND                                                           00400000<*** BACK THERE IS THE CARD-S END!..........      1E
                                                                                                                                    
IN PGM-2 THIS OCCURS WHEN EOF IS HIT                                                                                              1E
 !! END OF JES SPOOL FILE !!
                                                                                                                                    
 IN PGM-2 WE PUT THIS IN THE READ BUFFER                                        <*** BACK THERE IS THE CARD-S END!..........      2F
¤                                                                                                                                    
 FOR PGM-2 THE FIRST LINE IS THIS......                                                                                           2F
                                                                                                                                    
&NAME    CHECK &DECB,&DSORG=,&RPL=                                      00100000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*$01=OY46548,HDP3330,901204,SJPLCC:  BDAM DATA ABOVE THE LINE     @01A 00183300<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*                                                                      00216600<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         AIF   ('&DECB' EQ '').E1                                       00300000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         AIF   ('&DSORG' EQ 'IS').A2                                    00400000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         IHBERMAC 180,DSORG,ALL                                         00500000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.A1      ANOP                                                           00600000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         L     14,8(0,1)                PICK UP DCB ADDR                00700000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         ICM   15,B'0111',53(14)        LOAD CHECK ROUTINE ADDR    @01C 00766600<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         MEXIT                                                          00850000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
&NAME    IHBINNRA &DECB                                                 00950000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         L     14,8(0,1)                PICK UP DCB ADDR                01000000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         BALR  14,15                    LINK TO CHECK ROUT ADDR         01100000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         MEXIT                                                          01150000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
&NAME    IHBINNRA &DECB                                                 01250000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         L     15,76(0,14)              LOAD CHECK RTN ADDR FOR ISAM    01350000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         BO    *+10                                                @01C 01437500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         ICM   15,B'0111',53(14)        LOAD CHECK ROUTINE         @01C 01512500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         MEXIT                                                          01600000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         MEXIT                                                          01700000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
&NAME    DS    0H                                                       01800000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         LA    1,&RPL                   LOAD RPL ADDR                   01900000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         AGO   .AREG                                                    01950000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.RPLR    LR    1,&RPL(1)                LOAD RPL ADDR VIA REG           02000000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.AREG    LA    0,X'02'                  INDICATE CHECK IN REGISTER      02050000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         L     15,24(1)                 LOAD ACB ADDR FROM RPL          02100000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         L     15,8(15)                 LOAD JES INTERFACE MOD ADDR     02400000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         BALR  14,15                    BRANCH TO INTERFACE ROUTINE     02450000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         MEND                                                           02550000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
*          EODAD_NAME);                                        /*@L1A*/ 02650000<*** BACK THERE IS THE CARD-S END!..........      2F
¤                                                                                                                                    
----- THIS SHOULD BE AT THE TOP OF PAGE -----                                   <=== THAT IS THE CARD IMAGE ========OBJMODNI=     4F
                                                                                                                                    
* %END CHECK;                                                  /*@L1A*/ 02750000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
----- OK, EOF HAS BEEN ENCOUNTERED! -----                                                                                         4F
                                                                                                                                    
CONTENTS OF R1: 800C2000                                                                                                          4F
                                                                                                                                    
         MACRO                                                          00020000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
PSW AT TIME OF ERROR    FF050002   7F00D280                                                                                       4F
                                                                                                                                    
&NAME    EOV   &PARA,&MODE=24                                      @01M 00020900<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
DATA AT PSW:     0000D27A - 980FC138  09880119  4110C1B8                                                                          4F
                                                                                                                                    
.*                                                                    * 00021800<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
GPR 0-7          00000000 11111111 22222222 33333333 44444444 55555555 66666666 77777777                                          4F
                                                                                                                                    
.*EOV MACRO                                                           * 00022700<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
GPR 8-15         88888888 99999999 AAAAAAAA BBBBBBBB CCCCCCCC DDDDDDDD EEEEEEEE FFFFFFFF                                          4F
                                                                                                                                    
FPRs 0,2,4,6:    3E50DF15A4ACF313  BB986AEB3C6BC489  4A14FB9212000000  C487000000000000                                           4F
                                                                                                                                    
.*$MAC(EOV):                                                          * 00024500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
 IN PGM-2 WE PUT THIS IN THE READ BUFFER                                        <*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*PROPRIETARY V3 STATEMENT                                              00026100<*** BACK THERE IS THE CARD-S END!..........      2F
¤                                                                                                                                    
 FOR PGM-2 THE FIRST LINE IS THIS......                                                                                           5F
                                                                                                                                    
.*"RESTRICTED MATERIALS OF IBM"                                         00027500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*5695-DF1                                                              00028200<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*(C) COPYRIGHT 1987  IBM CORP.                                         00028900<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*                                                                 @SSA 00031000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.* STATUS = MVS/XA DFP RELEASE 2.3                                    * 00032100<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*                                                                    * 00033200<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*                                                                    * 00035400<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.*$SS=ACB31BIT,HDP2230,,STLSS: O/C/E SUPPORT OF 31-BIT VSAM        @SSA 00036500<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*$01=OY06337,HDP2230,,NSDRJV: MSGIFO087 - MACRO NOT EXPANDABLE    @01A 00037600<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         AIF   ('&PARA' EQ '').E1                                       00060000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AIF   (T'&MODE EQ 'O' OR '&MODE' EQ '24').BRANCH2         @SSA 00061500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         AIF   ('&MODE' NE '31').E2                                @SSA 00063000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AIF   ('&PARA'(1,1) EQ '(').REGA                          @SSA 00066000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
&NAME    LA    15,&PARA              LOAD ACB/AMB ADDR IN REG 15   @SSA 00067500<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         SR    1,1                   MOVE ZERO TO REG 1            @SSA 00069000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.REGA    ANOP                                                      @SSA 00072000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
&NAME    LR    15,&PARA(1)           LOAD ACB/AMB ADDR IN REG 15   @SSA 00073500<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
         SR    1,1                   MOVE ZERO TO REG 1            @SSA 00075000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.BRANCH2 ANOP                                                      @SSA 00078000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
&NAME    IHBINNRA &PARA                                                 00080000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.BRANCH3 SVC   55                                ISSUE EOV SVC     @SSC 00100000<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.E1      IHBERMAC 06                                                    00140000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         MEXIT                                                     @SSA 00146600<*** BACK THERE IS THE CARD-S END!..........      2F
                                                                                                                                    
.E2      IGGERMAC 201                       INVALID MODE OPERAND   @SSA 00153200<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
IN PGM-2 THIS OCCURS WHEN EOF IS HIT                                                                                              2F
                                                                                                                                    
*%/*   START OF PL/X COMMENT ENDING ON %MACRO STATEMENT          @L2A   00010000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
CONTENTS OF R1: 80654321                                                                                                          2F
                                                                                                                                    
PSW AT TIME OF ERROR    FFE5000D   5F00B532                                                                                       2F
                                                                                                                                    
&NAME    NOTE  &DCB,&TYPE=REL,&DECB=                              @L3C  00024400<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
DATA AT PSW:     0000B52C - BF1F6006  0A0D8065  432198EC                                                                          2F
                                                                                                                                    
GPR 0-7          E3C3C2C7 80654321 0000B558 0000B68B E3C3C2C6 0000B57B 6F00B52C D9C2C7D9                                          2F
                                                                                                                                    
.*PROPRIETARY V3 STATEMENT                                              00031600<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
GPR 8-15         6F00B52A 0000B53C E2C1E5C5 D7C9C540 0000B53C 8F00B01C 00002850 00000000                                          2F
                                                                                                                                    
FPRs 0,2,4,6:    E3C3C2C6D9E24040  E3C3C2C6D9E24040  40D7D9C2D9C2C7D9  E2C1E5C5D9C2C6D9                                           2F
                                                                                                                                    
.*"RESTRICTED MATERIALS OF IBM"                                         00037200<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*(C) COPYRIGHT 1994  IBM CORP.                                         00042800<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.* STATUS =  DFSMS/MVS VERSION 1 RELEASE 2.0                      @L3C  00048800<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.* CHANGE ACTIVITY =                                                    00053000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.* $H1=3480,JDP1111,,STLPKH:  3480 SUPPORT                           *  00055200<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.* $L2=PLX  ,JDZ1110,930930,SJPLMET: PL/X SUPPORT                 @L2A  00057000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*                                                                      00057600<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
&NAME    IHBINNRA &DCB,&DECB                                       @L3C 00075000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         SLR   15,15                             CLEAR REGISTER    @L1A 00100000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AIF   ('&DECB' NE '').DECBNT                              @L3A 00115000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         MEXIT                                                          00140000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         MEXIT                                                     @L3A 00141600<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AIF   ('&DECB' NE '').ERR2                                @L3A 00143700<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         LA    15,32                    ROUTER CODE                @H1A 00147500<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         MEXIT                                                     @H1A 00152500<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.ERR2    MNOTE 8,'DECB KEYWORD NOT VALID WITH TYPE=ABS'            @L3A 00158300<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.ERR     IHBERMAC 6                                                     00160000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
**/ NOTE: MACRO KEYS(1:1(DCB_NAME,DCB_ADDR),                   /*@L2A*/ 00230000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
*                   1:1(BLOCKID_NAME,BLOCKID_ADDR),            /*@L2A*/ 00330000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
*                       RETCODE,RSNCODE);                      /*@L2A*/ 00430000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
* %END NOTE;                                                   /*@L2A*/ 00530000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         MACRO                                                          03000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
CONTENTS OF R1: 800C5000                                                                                                          3F
                                                                                                                                    
.* /*                                                                */ 06050000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
PSW AT TIME OF ERROR    FFF50005   5F000001                                                                                       3F
                                                                                                                                    
.* /*    MACSTAT Y-2 73103/Y02113                                    */ 06150000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
DATA AT PSW:     00000000 - 01040119  0F003000  01190119                                                                          3F
                                                                                                                                    
.*  COPYRIGHT = NONE.                                          @WA04075 06300000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
GPR 0-7          E3C3C2C7 0000C558 0000C558 0000C68B E3C3C2C6 0000C57B 0000C57A D9C2C7D9                                          3F
                                                                                                                                    
.*LICENSED MATERIALS - PROPERTY OF IBM                         @WA04075 06450000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
GPR 8-15         6F00C52A 0000C53C FFFFFFFF D7C9C540 0000C53C 8F00C01C 00002850 00000000                                          3F
                                                                                                                                    
.*(C) COPYRIGHT 1992  IBM CORP.                                @WA04075 06600000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
FPRs 0,2,4,6:    E3C3C2C6D9E24040  E3C3C2C6D9E24040  40D7D9C2D9C2C7D9  E2C1E5C5D9C2C6D9                                           3F
                                                                                                                                    
.*  STATUS = DFSMS/MVS RELEASE 1.2.0                                    06800000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*                                                                      06950000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.*                                                                      07050000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         IHBERMAC 24                                                    12000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
.OKY     ANOP                                                           18000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AIF   ('&RPL'(1,1) EQ '(').RPLR                                24000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         AGO   .AREG                                                    30000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         LR    1,&RPL(1)                LOAD RPL ADDR IN REG.1          36000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         L     15,24(1)                 LOAD ACB ADDR FROM RPL          42000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
         BALR  14,15                    LINK TO INTERFACE ROUTINE       48000000<*** BACK THERE IS THE CARD-S END!..........      5F
                                                                                                                                    
IN PGM-2 THIS OCCURS WHEN EOF IS HIT                                                                                              5F
                                                                                                                                    
CONTENTS OF R1: 80654321                                                                                                          5F
                                                                                                                                    
PSW AT TIME OF ERROR    FF15000D   5F00E532                                                                                       5F
                                                                                                                                    
DATA AT PSW:     0000E52C - BF1F6006  0A0D8065  432198EC                                                                          5F
                                                                                                                                    
GPR 0-7          E3C3C2C7 80654321 0000E558 0000E68B E3C3C2C6 0000E57B 6F00E52C D9C2C7D9                                          5F
                                                                                                                                    
GPR 8-15         6F00E52A 0000E53C E2C1E5C5 D7C9C540 0000E53C 8F00E01C 00002850 00000000                                          5F
                                                                                                                                    
FPRs 0,2,4,6:    E3C3C2C6D9E24040  E3C3C2C6D9E24040  40D7D9C2D9C2C7D9  E2C1E5C5D9C2C6D9                                           5F
                                                                                                                                    
CONTENTS OF R1: 800C5000                                                                                                          1F
                                                                                                                                    
PSW AT TIME OF ERROR    FFD50005   5F000001                                                                                       1F
                                                                                                                                    
DATA AT PSW:     00000000 - 01040119  0F003000  01190119                                                                          1F
                                                                                                                                    
GPR 0-7          E3C3C2C7 0000A558 0000A558 0000A68B E3C3C2C6 0000A57B 0000A57A D9C2C7D9                                          1F
                                                                                                                                    
GPR 8-15         6F00A52A 0000A53C FFFFFFFF D7C9C540 0000A53C 8F00A01C 00002850 00000000                                          1F
                                                                                                                                    
FPRs 0,2,4,6:    E3C3C2C6D9E24040  E3C3C2C6D9E24040  40D7D9C2D9C2C7D9  E2C1E5C5D9C2C6D9                                           1F
 !! END OF JES SPOOL FILE !!
