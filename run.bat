@echo off
setlocal enableextensions enabledelayedexpansion

:: Globals
set SCRIPTDIR=%~dp0

:: Command line arguments
if "%1" == "" (
	goto :usage
) else if "%1" == "-d" (
	goto :dita
) else if "%1" == "-dd" (
	goto :debugdita
)
goto :eof

:: Subroutines

:usage
echo usage: run [ -d ^| -dd ] [ ^<jobrole^> ]
echo where:
echo -d          DITA PDF build of resume
echo -dd         DITA PDF build of resume, with debug output to run.log
echo ^<jobrole^>   The role to order by
echo             ^(In this original sample, it's dev, ia, or wrt^)
goto :eof

:dita
shift
if not "%1" == "" set ROLEFLAG=-Dargs.jobrole=%1;set OF=--outputFile.base=resume_%1
dita -i src\resume.dita -f resume -t temp --clean.temp=no %ROLEFLAG% %OF%
goto :eof

:debugdita
shift
if not "%1" == "" set ROLEFLAG=-Dargs.jobrole=%1;set OF=--outputFile.base=resume_%1
dita -i src\resume.dita -f resume -t temp --clean.temp=no --debug=yes -l run.log %ROLEFLAG% %OF%
goto :eof


