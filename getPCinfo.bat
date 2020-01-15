@echo off


setlocal EnableDelayedExpansion

chcp 65001

@echo "."
@echo "====================================="
@echo "  This batch is not written well!!!  "
@echo "====================================="
@echo "."

@echo %DATE% %TIME% > getPCinfo.txt


@echo PC information> PC-info.txt

REM  TODO:: FEATURE_0001

for /f "skip=1 tokens=* delims=" %%a in (getPCinfo.ifo) do (

	for /f "skip=1 tokens=* delims=" %%b in ('%%a') do (
		@echo(%%b) >> getPCinfo.txt
	)
)

for /f "usebackq tokens=* delims=" %%a in ("getPCinfo.txt") do (echo(%%a)>>~.txt
move /y  ~.txt "getPCinfo.txt"



chcp 1252

GOTO :END


rem =======================================================
rem Write data to file
rem %~1 : %LIST%           %~2 : %FILE%
rem
:WriteListOutput

Setlocal enableDelayedExpansion

set "LIST=%~1"
set "FILE=%~2"
@echo %LIST%
@echo %FILE%

for /f "usebackq tokens=* delims=" %%a in  %LIST%  do (
	@echo(%%a) >> %FILE%
)





:WriteOutput_END
EXIT /B 0

:WriteOutput_ERROR
EXIT /B 1

:END

