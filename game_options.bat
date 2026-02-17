@ECHO OFF
REM  QBFC Project Options Begin
REM  HasVersionInfo: No
REM Companyname: 
REM Productname: 
REM Filedescription: 
REM Copyrights: 
REM Trademarks: 
REM Originalname: 
REM Comments: 
REM Productversion:  0. 0. 0. 0
REM Fileversion:  0. 0. 0. 0
REM Internalname: 
REM ExeType: console
REM Architecture: x64
REM Appicon: 
REM AdministratorManifest: No
REM  QBFC Project Options End
@ECHO ON
@echo off
setlocal enabledelayedexpansion

:menu
cls
echo +============================================+
echo ^|        GAME COLLECTION (13 games)         ^|
echo +============================================+
echo ^|  1.  Snake                                ^|
echo ^|  2.  Guess the Number                     ^|
echo ^|  3.  Doom (text)                          ^|
echo ^|  4.  Tic-Tac-Toe                          ^|
echo ^|  5.  Slot Machine                         ^|
echo ^|  6.  Runner                               ^|
echo ^|  7.  Memory Test                          ^|
echo ^|  8.  Rock-Paper-Scissors                  ^|
echo ^|  9.  Hangman                              ^|
echo ^| 10.  Dice 21                              ^|
echo ^| 11.  Reaction Test                        ^|
echo ^| 12.  Code Breaker                         ^|
echo ^| 13.  Text Quest                           ^|
echo ^|  0.  Exit                                 ^|
echo +============================================+
echo.
set /p choice="Select game (0-13): "

if "%choice%"=="1" goto snake
if "%choice%"=="2" goto guess
if "%choice%"=="3" goto doom
if "%choice%"=="4" goto tictactoe
if "%choice%"=="5" goto slots
if "%choice%"=="6" goto runner
if "%choice%"=="7" goto memory
if "%choice%"=="8" goto rps
if "%choice%"=="9" goto hangman
if "%choice%"=="10" goto dice21
if "%choice%"=="11" goto reaction
if "%choice%"=="12" goto codebreak
if "%choice%"=="13" goto quest
if "%choice%"=="0" exit
goto menu

REM ===============================================
REM GAME 1: SNAKE
REM ===============================================
:snake
cls
echo +=======================================+
echo ^|              SNAKE                   ^|
echo +=======================================+
echo   Controls: W A S D + Enter
echo   Goal: collect food (*)
echo.
pause

set "width=20"
set "height=10"
set "snakeX=10"
set "snakeY=5"
set "foodX=5"
set "foodY=3"
set "score=0"
set "dir=d"
set "length=3"

set "body1X=9"
set "body1Y=5"
set "body2X=8"
set "body2Y=5"

:snakeLoop
cls
echo Score: %score% ^| Length: %length%
echo +--------------------+

for /L %%y in (1,1,%height%) do (
    set "line=|"
    for /L %%x in (1,1,%width%) do (
        set "char= "
        if %%x==%snakeX% if %%y==%snakeY% set "char=@"
        if %%x==%foodX% if %%y==%foodY% set "char=*"
        for /L %%b in (1,1,%length%) do (
            if %%x==!body%%bX! if %%y==!body%%bY! set "char=o"
        )
        set "line=!line!!char!"
    )
    echo !line!^|
)
echo +--------------------+
echo Press W/A/S/D and Enter:

choice /c wasd /n /t 1 /d %dir% >nul
if %errorlevel%==1 set "dir=w"
if %errorlevel%==2 set "dir=a"
if %errorlevel%==3 set "dir=s"
if %errorlevel%==4 set "dir=d"

for /L %%i in (%length%,-1,2) do (
    set /a "prev=%%i-1"
    set "body%%iX=!body!prev!X!"
    set "body%%iY=!body!prev!Y!"
)
set "body1X=%snakeX%"
set "body1Y=%snakeY%"

if "%dir%"=="w" set /a "snakeY-=1"
if "%dir%"=="s" set /a "snakeY+=1"
if "%dir%"=="a" set /a "snakeX-=1"
if "%dir%"=="d" set /a "snakeX+=1"

if %snakeX% lss 1 goto snakeDead
if %snakeX% gtr %width% goto snakeDead
if %snakeY% lss 1 goto snakeDead
if %snakeY% gtr %height% goto snakeDead

if %snakeX%==%foodX% if %snakeY%==%foodY% (
    set /a "score+=10"
    set /a "length+=1"
    set /a "foodX=%random% %% %width% + 1"
    set /a "foodY=%random% %% %height% + 1"
)

goto snakeLoop

:snakeDead
cls
echo +=======================================+
echo ^|            GAME OVER!                ^|
echo ^|          Your score: %score%               ^|
echo +=======================================+
pause
goto menu

REM ===============================================
REM GAME 2: GUESS THE NUMBER
REM ===============================================
:guess
cls
echo +=======================================+
echo ^|         GUESS THE NUMBER             ^|
echo +=======================================+
echo.

set /a "secret=%random% %% 100 + 1"
set "attempts=0"

:guessLoop
set /p "num=Enter number (1-100): "
set /a "attempts+=1"

if %num% lss %secret% (
    echo Higher!
    goto guessLoop
)
if %num% gtr %secret% (
    echo Lower!
    goto guessLoop
)

echo.
echo WIN! Number %secret% guessed in %attempts% attempts!
pause
goto menu

REM ===============================================
REM GAME 3: DOOM
REM ===============================================
:doom
cls
set "hp=100"
set "ammo=30"
set "demons=5"
set "level=1"

:doomLoop
cls
echo +=====================================================+
echo ^|              DOOM: BATCH EDITION                   ^|
echo +=====================================================+
echo   HP: %hp%%%    Ammo: %ammo%    Demons: %demons%    Level: %level%
echo +=====================================================+
echo.
if %demons% gtr 0 (
echo       \^|/     \^|/     \^|/     \^|/     \^|/
echo       [D]     [D]     [D]     [D]     [D]
echo       /^\     /^\     /^\     /^\     /^\
) else (
echo              *** LEVEL COMPLETE! ***
)
echo.
echo                      ^|
echo                     -+-
echo                      A
echo.
echo +=====================================================+
echo   [1] Shoot  [2] Take cover  [3] Medkit  [0] Exit
echo +=====================================================+

set /p "action=Action: "

if "%action%"=="0" goto menu

if "%action%"=="1" (
    if %ammo% leq 0 (
        echo No ammo!
        timeout /t 1 >nul
    ) else if %demons% leq 0 (
        echo No demons!
        timeout /t 1 >nul
    ) else (
        set /a "ammo-=3"
        set /a "hit=%random% %% 100"
        if !hit! lss 70 (
            set /a "demons-=1"
            echo *** HIT! Demon destroyed! ***
        ) else (
            echo ... Miss!
        )
        timeout /t 1 >nul
    )
)

if "%action%"=="2" (
    echo You take cover...
    set /a "dodge=%random% %% 100"
    if !dodge! lss 50 (
        echo Demon missed!
    ) else (
        set /a "hp-=5"
        echo You got hit! -5 HP
    )
    timeout /t 1 >nul
)

if "%action%"=="3" (
    if %hp% geq 100 (
        echo HP already full!
    ) else (
        set /a "hp+=25"
        if !hp! gtr 100 set "hp=100"
        echo +25 HP!
    )
    timeout /t 1 >nul
)

if %demons% gtr 0 (
    set /a "demonHit=%random% %% 100"
    if !demonHit! lss 40 (
        set /a "damage=%random% %% 15 + 5"
        set /a "hp-=!damage!"
        echo Demon attacks! -!damage! HP
        timeout /t 1 >nul
    )
)

if %hp% leq 0 (
    cls
    echo +=======================================+
    echo ^|            YOU DIED!                 ^|
    echo ^|           Level: %level%                   ^|
    echo +=======================================+
    pause
    goto menu
)

if %demons% leq 0 (
    set /a "level+=1"
    set /a "demons=level*3"
    set /a "ammo+=20"
    echo Next level! +20 ammo
    timeout /t 2 >nul
)

goto doomLoop

REM ===============================================
REM GAME 4: TIC-TAC-TOE
REM ===============================================
:tictactoe
set "c1=1" & set "c2=2" & set "c3=3"
set "c4=4" & set "c5=5" & set "c6=6"
set "c7=7" & set "c8=8" & set "c9=9"
set "player=X"

:tttLoop
cls
echo +=======================================+
echo ^|           TIC-TAC-TOE                ^|
echo +=======================================+
echo.
echo      %c1% ^| %c2% ^| %c3%
echo     ---+---+---
echo      %c4% ^| %c5% ^| %c6%
echo     ---+---+---
echo      %c7% ^| %c8% ^| %c9%
echo.
echo Turn: %player%
echo.
set /p "move=Select cell (1-9): "

set "valid=0"
for %%i in (1 2 3 4 5 6 7 8 9) do (
    if "%move%"=="%%i" if "!c%%i!"=="%%i" (
        set "c%%i=%player%"
        set "valid=1"
    )
)

if "%valid%"=="0" (
    echo Invalid move!
    timeout /t 1 >nul
    goto tttLoop
)

call :checkWin
if "%winner%"=="1" (
    cls
    echo Player %player% WINS!
    pause
    goto menu
)

if "%player%"=="X" (set "player=O") else (set "player=X")

set "full=1"
for %%i in (1 2 3 4 5 6 7 8 9) do (
    if "!c%%i!"=="%%i" set "full=0"
)
if "%full%"=="1" (
    echo Draw!
    pause
    goto menu
)

goto tttLoop

:checkWin
set "winner=0"
if "%c1%"=="%c2%" if "%c2%"=="%c3%" set "winner=1"
if "%c4%"=="%c5%" if "%c5%"=="%c6%" set "winner=1"
if "%c7%"=="%c8%" if "%c8%"=="%c9%" set "winner=1"
if "%c1%"=="%c4%" if "%c4%"=="%c7%" set "winner=1"
if "%c2%"=="%c5%" if "%c5%"=="%c8%" set "winner=1"
if "%c3%"=="%c6%" if "%c6%"=="%c9%" set "winner=1"
if "%c1%"=="%c5%" if "%c5%"=="%c9%" set "winner=1"
if "%c3%"=="%c5%" if "%c5%"=="%c7%" set "winner=1"
exit /b

REM ===============================================
REM GAME 5: SLOT MACHINE
REM ===============================================
:slots
set "money=100"

:slotsLoop
cls
echo +=======================================+
echo ^|           SLOT MACHINE               ^|
echo +=======================================+
echo           Balance: $%money%
echo.

if %money% leq 0 (
    echo You're broke!
    pause
    goto menu
)

set /p "bet=Bet ($1-$%money%) or 0 to exit: "
if "%bet%"=="0" goto menu
if %bet% gtr %money% (
    echo Not enough money!
    timeout /t 1 >nul
    goto slotsLoop
)

echo.
echo Spinning...
timeout /t 1 >nul

set /a "s1=%random% %% 7"
set /a "s2=%random% %% 7"
set /a "s3=%random% %% 7"

if %s1%==0 set "sym1=@"
if %s1%==1 set "sym1=#"
if %s1%==2 set "sym1=$"
if %s1%==3 set "sym1=&"
if %s1%==4 set "sym1=*"
if %s1%==5 set "sym1=+"
if %s1%==6 set "sym1=7"

if %s2%==0 set "sym2=@"
if %s2%==1 set "sym2=#"
if %s2%==2 set "sym2=$"
if %s2%==3 set "sym2=&"
if %s2%==4 set "sym2=*"
if %s2%==5 set "sym2=+"
if %s2%==6 set "sym2=7"

if %s3%==0 set "sym3=@"
if %s3%==1 set "sym3=#"
if %s3%==2 set "sym3=$"
if %s3%==3 set "sym3=&"
if %s3%==4 set "sym3=*"
if %s3%==5 set "sym3=+"
if %s3%==6 set "sym3=7"

echo  +-----+-----+-----+
echo  ^|  %sym1%  ^|  %sym2%  ^|  %sym3%  ^|
echo  +-----+-----+-----+
echo.

set /a "money-=%bet%"

if %s1%==%s2% if %s2%==%s3% (
    if %s1%==6 (
        set /a "win=%bet%*10"
        echo *** JACKPOT!!! *** +$!win!
    ) else (
        set /a "win=%bet%*5"
        echo THREE MATCH! +$!win!
    )
    set /a "money+=!win!"
) else if %s1%==%s2% (
    set /a "win=%bet%*2"
    echo Two match! +$!win!
    set /a "money+=!win!"
) else if %s2%==%s3% (
    set /a "win=%bet%*2"
    echo Two match! +$!win!
    set /a "money+=!win!"
) else (
    echo No luck...
)

timeout /t 2 >nul
goto slotsLoop

REM ===============================================
REM GAME 6: RUNNER
REM ===============================================
:runner
cls
echo +=======================================+
echo ^|              RUNNER                  ^|
echo +=======================================+
echo   Press J to jump!
echo   Avoid obstacles [#]
echo.
pause

set "score=0"
set "obstX=25"
set "jumping=0"
set "jumpH=0"

:runnerLoop
cls
set /a "score+=1"

if %jumping%==1 (
    set /a "jumpH+=1"
    if %jumpH% geq 3 set "jumping=2"
)
if %jumping%==2 (
    set /a "jumpH-=1"
    if %jumpH% leq 0 (
        set "jumping=0"
        set "jumpH=0"
    )
)

echo Score: %score%
echo.

if %jumpH% geq 2 (
    echo                        O
    echo      ========================
) else if %jumpH%==1 (
    echo.
    echo                        O=================
) else (
    echo.
    echo      ====================O===
)

set /a "obstX-=3"
if %obstX% leq 0 set /a "obstX=25"

set "line=      "
for /L %%i in (1,1,%obstX%) do set "line=!line! "
echo !line![#]

if %obstX% leq 7 if %obstX% geq 4 if %jumpH%==0 (
    echo.
    echo *** CRASH! *** Score: %score%
    pause
    goto menu
)

choice /c nj /n /t 0 /d n >nul 2>nul
if %errorlevel%==2 if %jumping%==0 set "jumping=1"

goto runnerLoop

REM ===============================================
REM GAME 7: MEMORY TEST
REM ===============================================
:memory
cls
echo +=======================================+
echo ^|           MEMORY TEST                ^|
echo +=======================================+
echo   Remember the number sequence!
echo.
pause

set "level=3"
set "maxLevel=10"

:memoryLevel
cls
echo Level %level%: Remember the numbers!
echo.

set "sequence="
for /L %%i in (1,1,%level%) do (
    set /a "num=!random! %% 10"
    set "sequence=!sequence!!num! "
)

echo    %sequence%
echo.
echo Memorize...
timeout /t %level% >nul

cls
echo Enter numbers with spaces:
set /p "answer="

if "%answer%"=="%sequence:~0,-1%" (
    echo Correct!
    set /a "level+=1"
    if %level% gtr %maxLevel% (
        echo *** YOU BEAT ALL LEVELS! ***
        pause
        goto menu
    )
    timeout /t 1 >nul
    goto memoryLevel
) else (
    echo Wrong!
    echo Was: %sequence%
    echo You reached level %level%
    pause
    goto menu
)

REM ===============================================
REM GAME 8: ROCK-PAPER-SCISSORS
REM ===============================================
:rps
set "pWins=0"
set "cWins=0"

:rpsLoop
cls
echo +=======================================+
echo ^|       ROCK-PAPER-SCISSORS            ^|
echo +=======================================+
echo   You: %pWins%  -  Computer: %cWins%
echo +=======================================+
echo   1. Rock
echo   2. Scissors
echo   3. Paper
echo   0. Exit
echo +=======================================+

set /p "choice=Your choice: "
if "%choice%"=="0" goto menu

set /a "comp=%random% %% 3 + 1"

if %choice%==1 set "pName=Rock"
if %choice%==2 set "pName=Scissors"
if %choice%==3 set "pName=Paper"

if %comp%==1 set "cName=Rock"
if %comp%==2 set "cName=Scissors"
if %comp%==3 set "cName=Paper"

echo.
echo You: %pName%
echo Computer: %cName%
echo.

if %choice%==%comp% (
    echo Draw!
) else if %choice%==1 if %comp%==2 (
    echo You win!
    set /a "pWins+=1"
) else if %choice%==2 if %comp%==3 (
    echo You win!
    set /a "pWins+=1"
) else if %choice%==3 if %comp%==1 (
    echo You win!
    set /a "pWins+=1"
) else (
    echo Computer wins!
    set /a "cWins+=1"
)

timeout /t 2 >nul
goto rpsLoop

REM ===============================================
REM GAME 9: HANGMAN
REM ===============================================
:hangman
set "words=BATCH WINDOW GAME KEYBOARD MONITOR PROGRAM COMPUTER SYSTEM"
set /a "wordNum=%random% %% 8"
set "cnt=0"
for %%w in (%words%) do (
    if !cnt!==%wordNum% set "word=%%w"
    set /a "cnt+=1"
)

set "guessed="
set "errors=0"
set "maxErrors=6"

:hangmanLoop
cls
echo +=======================================+
echo ^|             HANGMAN                  ^|
echo +=======================================+
echo.

echo   +---+
if %errors% geq 1 (echo   ^|   O) else (echo   ^|    )
if %errors% geq 4 (echo   ^|  /^|\) else if %errors% geq 3 (echo   ^|  /^|) else if %errors% geq 2 (echo   ^|   ^|) else (echo   ^|    )
if %errors% geq 6 (echo   ^|  / \) else if %errors% geq 5 (echo   ^|  /) else (echo   ^|    )
echo   ^|
echo  ===

echo.
echo Errors: %errors%/%maxErrors%
echo Used letters: %guessed%
echo.

set "display="
set "complete=1"
for /L %%i in (0,1,15) do (
    set "char=!word:~%%i,1!"
    if defined char (
        echo !guessed! | find /i "!char!" >nul
        if !errorlevel!==0 (
            set "display=!display!!char! "
        ) else (
            set "display=!display!_ "
            set "complete=0"
        )
    )
)
echo Word: %display%
echo.

if %complete%==1 (
    echo YOU WIN! Word: %word%
    pause
    goto menu
)

if %errors% geq %maxErrors% (
    echo YOU LOSE! Word was: %word%
    pause
    goto menu
)

set /p "letter=Enter a letter: "
set "letter=%letter:~0,1%"

echo %guessed% | find /i "%letter%" >nul
if %errorlevel%==0 (
    echo Already used!
    timeout /t 1 >nul
    goto hangmanLoop
)

set "guessed=%guessed%%letter% "

echo %word% | find /i "%letter%" >nul
if %errorlevel%==1 set /a "errors+=1"

goto hangmanLoop

REM ===============================================
REM GAME 10: DICE 21
REM ===============================================
:dice21
cls
echo +=======================================+
echo ^|            DICE - 21                 ^|
echo +=======================================+
echo   Get 21 or close, but not over!
echo.

set "pTotal=0"
set "cTotal=0"

:dice21Player
set /a "dice=%random% %% 6 + 1"
set /a "pTotal+=%dice%"
echo [%dice%] Rolled: %dice%  ^|  Total: %pTotal%

if %pTotal% gtr 21 (
    echo Bust! You lose!
    pause
    goto menu
)

if %pTotal%==21 (
    echo 21! Perfect!
    goto dice21Comp
)

set /p "cont=Roll again? (y/n): "
if /i "%cont%"=="y" goto dice21Player

:dice21Comp
echo.
echo Computer's turn...

:dice21CompLoop
if %cTotal% lss 17 (
    set /a "dice=%random% %% 6 + 1"
    set /a "cTotal+=%dice%"
    echo Computer: %dice%  ^|  Total: %cTotal%
    timeout /t 1 >nul
    goto dice21CompLoop
)

echo.
echo ================================
echo You: %pTotal%  ^|  Computer: %cTotal%
echo ================================

if %cTotal% gtr 21 (
    echo Computer busts! YOU WIN!
) else if %pTotal% gtr %cTotal% (
    echo YOU WIN!
) else if %pTotal% lss %cTotal% (
    echo Computer wins!
) else (
    echo Draw!
)
pause
goto menu

REM ===============================================
REM GAME 11: REACTION TEST
REM ===============================================
:reaction
cls
echo +=======================================+
echo ^|          REACTION TEST               ^|
echo +=======================================+
echo   Press ENTER when you see "GO!"
echo.
echo Get ready...

set /a "wait=%random% %% 5 + 2"
timeout /t %wait% >nul

echo.
echo ########################################
echo ##                                    ##
echo ##    GGGGG   OOOOO   !!!!!           ##
echo ##   G       O     O  !!!!!           ##
echo ##   G  GGG  O     O  !!!!!           ##
echo ##   G    G  O     O                  ##
echo ##    GGGG    OOOOO   !!!!!           ##
echo ##                                    ##
echo ########################################
echo.

set "start=%time%"
pause >nul
set "end=%time%"

echo.
echo You pressed!
echo Start: %start%
echo End: %end%
pause
goto menu

REM ===============================================
REM GAME 12: CODE BREAKER
REM ===============================================
:codebreak
cls
echo +=======================================+
echo ^|          CODE BREAKER                ^|
echo +=======================================+
echo   Guess the 4-digit code (digits 1-6)
echo   [O] = correct position
echo   [o] = wrong position
echo.

set "code="
for /L %%i in (1,1,4) do (
    set /a "d=!random! %% 6 + 1"
    set "code=!code!!d!"
)

set "attempts=0"
set "maxAttempts=10"

:codeLoop
set /a "attempts+=1"
echo Attempt %attempts%/%maxAttempts%
set /p "guess=Enter 4 digits: "

if "%guess%"=="%code%" (
    echo.
    echo *** CRACKED! *** Code: %code%
    echo Attempts: %attempts%
    pause
    goto menu
)

set "bulls=0"
set "cows=0"

for /L %%i in (0,1,3) do (
    set "g=!guess:~%%i,1!"
    set "c=!code:~%%i,1!"
    if "!g!"=="!c!" (
        set /a "bulls+=1"
    ) else (
        echo !code! | find "!g!" >nul
        if !errorlevel!==0 set /a "cows+=1"
    )
)

echo Result:
for /L %%i in (1,1,%bulls%) do <nul set /p "=[O]"
for /L %%i in (1,1,%cows%) do <nul set /p "=[o]"
echo.
echo.

if %attempts% geq %maxAttempts% (
    echo Out of attempts! Code was: %code%
    pause
    goto menu
)

goto codeLoop

REM ===============================================
REM GAME 13: TEXT QUEST
REM ===============================================
:quest
set "hp=100"
set "gold=0"
set "sword=0"
set "key=0"

:questStart
cls
echo +=====================================================+
echo ^|               DUNGEON OF FATE                      ^|
echo +=====================================================+
echo   HP: %hp%%  Gold: %gold%  Sword: %sword%  Key: %key%
echo +=====================================================+
echo.
echo You stand at the entrance to a dark dungeon.
echo Three corridors ahead.
echo.
echo [1] Left corridor (sound of coins)
echo [2] Center corridor (dark and scary)
echo [3] Right corridor (glowing light)
echo [0] Run away (exit)
echo.
set /p "c=Choice: "

if "%c%"=="0" goto menu
if "%c%"=="1" goto questGold
if "%c%"=="2" goto questDanger
if "%c%"=="3" goto questMagic
goto questStart

:questGold
cls
echo *** TREASURE ROOM! ***
echo.
echo You found a chest of gold!
set /a "found=%random% %% 50 + 10"
set /a "gold+=%found%"
echo +%found% gold!
echo.
echo But a guard appears!
echo.
if %sword%==1 (
    echo You fight with your sword and win!
) else (
    echo Without a weapon you barely escape...
    set /a "hp-=20"
    echo -20 HP!
)
pause
goto questStart

:questDanger
cls
echo *** DANGER! ***
echo.
set /a "event=%random% %% 3"
if %event%==0 (
    echo Trap! Arrows!
    set /a "hp-=30"
    echo -30 HP!
) else if %event%==1 (
    echo You found an old sword!
    set "sword=1"
    echo Sword acquired!
) else (
    echo You found a rusty key!
    set "key=1"
    echo Key acquired!
)

if %hp% leq 0 (
    echo.
    echo *** YOU DIED IN THE DUNGEON! ***
    pause
    goto menu
)
pause
goto questStart

:questMagic
cls
echo *** MAGIC ROOM! ***
echo.
if %key%==1 (
    echo The key opens the magic portal!
    echo.
    echo *** YOU WIN! ***
    echo Gold: %gold%
    echo HP: %hp%
    pause
    goto menu
) else (
    echo A locked magic door...
    echo You need a key!
    echo.
    echo You find a healing fountain.
    set /a "hp+=20"
    if %hp% gtr 100 set "hp=100"
    echo +20 HP!
)
pause
goto questStart
