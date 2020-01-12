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
REM  TODO:: TO SIMPIFILY BELOW STRUCTURE

for /f "skip=1 tokens=* delims=" %%a in (getPCinfo.ifo) do (

	for /f "skip=1 tokens=* delims=" %%b in ('%%a') do (
		@echo(%%b) >> getPCinfo.txt
	)
)

for /f "usebackq tokens=* delims=" %%a in ("getPCinfo.txt") do (echo(%%a)>>~.txt
move /y  ~.txt "getPCinfo.txt"






REM REM Get Serial number
REM set "output="
REM for /f "skip=1 delims=" %%a in ('wmic bios get serialnumber') do (
    REM for /f "delims=" %%b in ("%%a") do if not defined output set "output=%%~nb"
REM )

REM @echo Serial number	%output% >> PC-info.txt


REM REM Get Serial number
REM set "output="
REM for /f "skip=1 delims=" %%a in ('wmic csproduct get name') do (
    REM for /f "delims=" %%b in ("%%a") do if not defined output set "output=%%~nb"
REM )

REM @echo Product name	%output% >> PC-info.txt

REM REM execute a batch with administrator rights
REM REM runas /noprofile /user:mymachine\administrator yourbatchfile.bat


REM REM Get window Product key (Need administrator right)
REM set "OUTPUT=(`wmic path softwarelicensingservice get OA3xOriginalProductKey /value`)"
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set "OUTPUT=(`wmic bios get serialnumber /value`)"
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set "OUTPUT=('\"wmic cpu get name,ProcessorId /value\"')"
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic memphysical get MaxCapacity /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic diskdrive get Model^,size /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic csproduct get Vendor^,Name^,UUID /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic os get caption, serialnumber /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic computersystem get domain,name /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set "OUTPUT=(`wmic DISKDRIVE get InterfaceType,Name,Size,Status /value`)"
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM REM Get Network adapters and their MAC addresses
REM set OUTPUT=(`wmic nic where 'PNPDeviceID like "%%%%%PCI%%%%%%"' get Name,MACAddress /value`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set "OUTPUT=(`WMIC NICCONFIG where 'IPEnabled=True and TcpipNetbiosOptions!=null and TcpipNetbiosOptions!=2' get description,dnshostname,ipaddress,DefaultIPGateway,DNSServerSearchOrder,DHCPServer,macaddress /format:list`)"
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM set OUTPUT=(`wmic USERACCOUNT get Caption,Name,PasswordRequired,Status`)
REM CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM REM Get harddisk serial number   
REM wmic path win32_physicalmedia get SerialNumber

REM wmic RDACCOUNT list full



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

