@echo off

::force UTF-8 support
::chcp 65001 2>nul >nul

::----------------------------------------------------::
:: make sure to browse the path to your `node.exe`,   ::
:: show properties, under compatibilities set "ON"    ::
:: the checkbox for run as admin.                     ::
::----------------------------------------------------::


set _NODE=C:\nodejs32\node.exe


::relative path
set _PATH=%~dp0
set _SCPT=_builder.js
set __BLD=build


::to explicit path (long)
set _SCPT="%_PATH%%_SCPT%"
set __BLD="%_PATH%%__BLD%"


::to explicit short path (8.3)
for /f %%a in ("%_NODE%")do (set "_NODE=%%~fsa"  )
for /f %%a in ("%_SCPT%")do (set "_SCPT=%%~fsa"  )
for /f %%a in ("%__BLD%")do (set "__BLD=%%~fsa"  )


::cleanup old build folder.
rmdir "%__BLD%" /s /q      2>nul >nul
echo.
echo DEBUG:  cleanup old build folder.
if exist %__BLD%           goto BUILD_NOCLEAN
if exist %__BLD%\NUL       goto BUILD_NOCLEAN
echo DONE.


::create new empty build folder.
mkdir "%__BLD%"            2>nul >nul
echo.
echo DEBUG:  create new empty build folder.
if not exist %__BLD%       goto BUILD_NOCREATE
if not exist %__BLD%\NUL   goto BUILD_NOCREATE
echo DONE.


echo.
echo DEBUG:  running main script ^("%_SCPT%"^) with NodeJS ^("%_NODE%"^).
echo.
call "%_NODE%" "%_SCPT%"
echo.
echo DONE.


echo.
echo DEBUG:  all done.


goto EXIT


::------------------------------------------------


:BUILD_NOCLEAN
  echo.
  echo ERROR:  could not delete the "%__BLD%" folder, maybe it is used by another program, try run again.
  goto EXIT


:BUILD_NOCREATE
  echo.
  echo ERROR:  could not create the "%__BLD%" folder, try run again.
  goto EXIT


:EXIT
  echo.
  pause

