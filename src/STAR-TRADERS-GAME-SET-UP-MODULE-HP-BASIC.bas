10 COM S[12,15],T[12,12],T$[72],B[3,12]
20 COM W,D9,K9,X9,D1,X1,P9,T9,S9,Y9,H
30 COM Y1,R9,G9,Q,M[6,3],C[6,3]
35 COM S1,T1,R
40 REM *** STAR TRADERS ***
50 REM <<<GAME SET-UP MODULE>>>
60 REM S IS THE STAR SYSTEM INFO ARRAY
70 REM T IS THE TRADING SHIP INFO ARRAY
80 REM T$ IS THE TRADING SHIP NAME STRING
90 REM M AND C DETERMINE A STAR'S PRODUCTIVITY/MONTH
92 REM   PROD/MO. = S(7,J) * M(I,R1)  +  C(I,R1)
94 REM   WHERE J IS THE STAR ID #,I THE MERCHANDISE #,
96 REM   AND R1 IS THE DEVELOPMENT CLASS OF THE STAR
100 REM B CONTAINS THE BANK ACCOUNTS
110 REM A$ IS THE STANDARD INPUT BUFFER
120 DIM A$[6]
130 REM R9 IS THE SPEED OF A SHIP IN LIGHT-YEARS PER DAY
140 REM D9 IS THE MINIMUM  DISTANCE ALLOWED BETWEEN STARS
150 REM Q IS THE PROBABILITY OF A DELAY
160 REM K9 IS THE MAX NUMBER OF BIDDING ROUNDS
170 REM W IS THE MAX WEIGHT OF A TRADING SHIP
180 REM X9 CONTROLS THE PROFIT MARGIN; HIGH X9 LIMITS THE %
190 REM G9 IS THE STELLAR DEVELOPMENT INCREMENT 1<=G9<=5
195 REM R=1 IF THIS IS A RESTART
200 LET R9=2/7
210 LET D9=15
220 LET Q=.1
230 LET K9=3
240 LET W=30
250 LET X9=36
260 LET G9=1.25
265 LET R=0
270 REM D1 IS THE DAY OF THIS YEAR (1<=D1<=360)
280 REM Y1 IS THIS YEAR
290 LET D1=1
300 LET Y1=2070
302 REM SET UP ECONOMETRICS MODEL
304 RESTORE 2410
306 MAT READ M,C
310 REM *** BLOCK #1
320 PRINT "INSTRUCTIONS (TYPE 'Y' OR 'N' PLEASE)";
330 INPUT A$
340 IF A$[1,1]="N" THEN 590
350 PRINT 
360 PRINT "     THE DATE IS JAN 1, 2070 AND INTERSTELLAR FLIGHT"
370 PRINT "HAS EXISTED FOR 70 YEARS.  THERE ARE SEVERAL STAR"
380 PRINT "SYSTEMS THAT HAVE BEEN COLONIZED.  SOME ARE ONLY"
390 PRINT "FRONTIER SYSTEMS, OTHERS ARE OLDER AND MORE DEVELOPED."
400 PRINT 
410 PRINT "     EACH OF YOU IS THE CAPTAIN OF TWO INTERSTELLAR"
420 PRINT "TRADING SHIPS.  YOU WILL TRAVEL FROM STAR SYSTEM TO"
430 PRINT "STAR SYSTEM, BUYING AND SELLING MERCHANDISE.  IF YOU"
440 PRINT "DRIVE A GOOD BARGAIN YOU CAN MAKE LARGE PROFITS."
450 PRINT 
460 PRINT "     AS TIME GOES ON, EACH STAR SYSTEM WILL SLOWLY"
470 PRINT "GROW, AND ITS NEEDS WILL CHANGE.  A STAR SYSTEM THAT"
480 PRINT "HOW IS SELLING MUCH URANIUM AND RAW METALS CHEAPLY"
490 PRINT "MAY NOT HAVE ENOUGH FOR EXPORT IN A FEW YEARS."
500 PRINT 
510 PRINT "     YOUR SHIPS CAN TRAVEL ABOUT TWO LIGHTYEARS IN A"
520 PRINT "WEEK AND CAN CARRY UP TO";W;" TONS OF CARGO.  ONLY"
530 PRINT "CLASS I AND CLASS II STAR SYSTEMS HAVE BANKS ON THEM."
540 PRINT "THEY PAY 5% INTEREST AND ANY MONEY YOU DEPOSIT ON ONE"
550 PRINT "PLANET IS AVAILABLE ON ANOTHER - PROVIDED THERE'S A LOCAL"
560 PRINT "BANK."
570 PRINT 
580 REM *** BLOCK #2
590 PRINT "HAVE ALL PLAYERS PLAYED BEFORE";
600 INPUT A$
605 PRINT 
610 IF A$[1,1]="Y" THEN 630
620 GOTO 660
630 PRINT "DO YOU WANT TO SET UP YOUR OWN GAME";
640 INPUT A$
645 PRINT 
650 IF A$[1,1]="Y" THEN 760
660 PRINT "HOW MANY PLAYERS";
670 INPUT P9
675 PRINT 
680 GOTO P9-1 OF 710,710,710
690 PRINT "2,3, OR 4 CAN PLAY"
700 GOTO 660
710 T9=2*P9
720 S9=3*P9+1
730 Y9=Y1+5
740 GOTO 1350
750 REM *** BLOCK #3
760 PRINT "IS THIS A RESTART";
770 INPUT A$
775 PRINT 
780 IF A$[1,1]="N" THEN 940
790 PRINT "LOAD THE TAPE INTO THE TAPE READER.  WHEN I TYPE A '?'"
800 PRINT "YOU CAN FLIP THE SWITCH TO 'START' WHENEVER YOU'RE READY"
810 PRINT 
820 INPUT T$
830 INPUT W,D9,K9,X9,D1,Y1
835 INPUT P9,T9,S9,Y9,T1,S1
840 FOR J=1 TO S9
845 FOR I=1 TO 9 STEP 4
850 INPUT S[I,J],S[I+1,J],S[I+2,J],S[I+3,J]
855 NEXT I
860 NEXT J
870 FOR J=1 TO T9
875 FOR I=1 TO 9 STEP 4
880 INPUT T[I,J],T[I+1,J],T[I+2,J],T[I+3,J]
885 NEXT I
890 NEXT J
900 FOR I=1 TO P9
910 INPUT B[1,I],B[2,I],B[3,I]
920 NEXT I
925 R=1
930 CHAIN "$TRADES"
940 PRINT "HOW MANY PLAYERS";
950 INPUT P9
955 PRINT 
960 IF P9 >= 2 AND P9 <= 12 THEN 990
970 PRINT "2,3,4, ... ,12 CAN PLAY"
980 GOTO 940
990 PRINT "HOW MANY SHIPS PER PLAYER";
1000 INPUT X
1005 PRINT 
1010 IF X<1 THEN 990
1020 T9=P9*X
1030 IF T9 <= 12 THEN 1070
1040 PRINT "I CAN'T KEEP TRACK OF MORE THAN 12 SHIPS;"
1050 PRINT P9;" PLAYERS TIMES";X;" SHIPS MAKES";T9
1060 GOTO 990
1070 PRINT "HOW MANY STAR SYSTEMS";
1080 INPUT S9
1085 PRINT 
1090 IF S9 >= 4 AND S9 <= 13 THEN 1120
1100 PRINT "FROM 4 TO 13 STARS"
1110 GOTO 1070
1120 PRINT "ENTER THE LENGTH OF GAME IN YEARS";
1130 INPUT X
1135 PRINT 
1140 IF X >= 1 AND INT(X)=X THEN 1170
1150 PRINT "CHOOSE A POSITIVE INTEGER"
1160 GOTO 1130
1170 Y9=Y1+X
1180 PRINT "WHAT'S THE MAX CARGOE TONNAGE(USUALLY 30)";
1190 INPUT W
1195 PRINT 
1200 IF W<25 THEN 1180
1210 PRINT "WHAT'S THE MINIMUM DISTANCE BETWEEN STARS(USUALLY 15)";
1220 INPUT D9
1225 PRINT 
1230 IF D9 <= 25 AND D9 >= 10 THEN 1260
1240 PRINT "MIN SPACING 10, MAX 25"
1250 GOTO 1210
1260 PRINT "HOW MANY BIDS OR OFFERS(USUALLY 3)";
1270 INPUT K9
1275 PRINT 
1280 IF K9<1 THEN 1260
1290 PRINT "SET THE PROFIT MARGIN(1,2,3,4 OR 5)...THE HIGHER"
1300 PRINT "THE NUMBER, THE LOWER THE PROFIT % ... USUALLY SET TO 2"
1310 PRINT "...YOUR NUMBER";
1320 INPUT X9
1330 X9=18*(ABS(X9) MIN 5)
1340 REM *** BLOCK #4.1
1350 S[11,1]=S[12,1]=0
1360 S[7,1]=15
1370 REM *** BLOCK #4.2
1380 H=1
1390 S1=2
1400 GOSUB 1920
1410 S1=3
1420 GOSUB 1920
1430 S1=4
1440 GOSUB 2010
1450 FOR S1=5 TO S9
1460 GOSUB S1-3*INT((S1-1)/3) OF 1920,2010,2060
1470 NEXT S1
1480 REM *** BLOCK #4.3
1490 FOR S1=1 TO S9
1500 FOR J=1 TO 6
1510 S[J,S1]=0
1520 NEXT J
1530 IF S1>1 THEN 1560
1540 I=1
1550 GOTO 1600
1560 I=4*INT(14*RND(0))+5
1570 FOR J=2 TO S1-1
1580 IF I=S[8,J] THEN 1560
1590 NEXT J
1600 S[8,S1]=I
1610 S[9,S1]=270
1620 S[10,S1]=Y1-1
1630 NEXT S1
1640 REM *** BLOCK #4.4
1650 T1=L=1
1655 PRINT 
1657 PRINT 
1660 PRINT "CAPTAINS, NAME YOUR SHIPS (UP TO 6 LETTERS/BLANKS/NUMBERS)"
1670 FOR I=1 TO T9/P9
1680 PRINT 
1690 FOR P1=1 TO P9
1700 T[1,T1]=T[2,T1]=T[6,T1]=0
1710 T[3,T1]=15
1720 T[4,T1]=T[5,T1]=10
1730 T[7,T1]=25
1740 T[9,T1]=D1
1750 T[10,T1]=Y1
1760 T[11,T1]=5000
1770 PRINT "   CAPTAIN";P1;"WHAT DO YOU CHRISTEN YOUR SHIP #";I;
1780 INPUT T$[L,L+5]
1790 T1=T1+1
1800 L=L+6
1810 NEXT P1
1820 NEXT I
1830 REM *** BLOCK #4.5
1840 FOR B1=1 TO P9
1850 B[1,B1]=0
1860 B[2,B1]=D1
1870 B[3,B1]=Y1
1880 NEXT B1
1890 CHAIN "$TRADES"
1900 REM *** GOSUBS FOLLOW ***
1910 REM <FRONTIER> GOSUB
1920 X=(RND(0)-.5)*100
1930 Y=50*RND(0)
1940 IF (ABS(X)<25) AND (Y<25) THEN 1920
1950 F=1
1960 GOSUB 2190
1970 IF F=0 THEN 1920
1980 S[7,S1]=0
1990 RETURN
2000 REM *** <UNDERDEVELOPED> GOSUB
2010 E=100
2020 GOSUB 2110
2030 S[7,S1]=5
2040 RETURN
2050 REM *** <DEVELOPED> GOSUB
2060 E=50
2070 GOSUB 2110
2080 S[7,S1]=10
2090 RETURN
2100 REM *** <GENERATE CO-ORDS> GOSUB
2110 X=(RND(0)-.5)*E
2120 Y=RND(0)*E/2
2130 F=1
2140 GOSUB 2190
2150 IF F=0 THEN 2110
2160 RETURN
2170 REM *** <TEST STAR CO-ORDS> GOSUB
2180 REM FIRST CONVERT CO-ORDS TO NEXT HALF-BOARD
2190 GOTO H OF 2300,2260,2240,2200
2200 Z=X
2210 X=-Y
2220 Y=Z
2230 GOTO 2300
2240 Y=-Y
2250 GOTO 2300
2260 Z=X
2270 X=Y
2280 Y=Z
2290 REM SECOND, TEST PROXIMITY
2300 FOR J=1 TO S1-1
2310 IF SQR((X-S[11,J])^2+(Y-S[12,J])^2) >= D9 THEN 2340
2320 F=0
2330 RETURN
2340 NEXT J
2350 REM FINALLY, ENTER CO-ORDS AND INCREMENT HALF-BOARD CTR
2360 S[11,S1]=INT(X)
2370 S[12,S1]=INT(Y)
2380 H=1+(H <= 3)*H
2390 RETURN
2400 REM *** DATA FOR ECONOMETRIC MODEL FOLLOWS ***
2410 REM MODEL #1
2420 DATA -0.025,-0.05,-0.025,0,-0.025,-0.025,0,.1,.1,-0.025,.1,0,.1,.2,.1,.1,-0.025,0
2430 DATA 1,1.5,.5,.75,.75,.75,-0.25,-0.25,-0.25,0,-0.5,.5,0,-0.5
2440 DATA 0,.5,1.5,0
2450 END