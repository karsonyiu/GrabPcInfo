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

REM Get Serial number
set "output="
for /f "skip=1 delims=" %%a in ('wmic bios get serialnumber') do (
    for /f "delims=" %%b in ("%%a") do if not defined output set "output=%%~nb"
)

@echo Serial number	%output% >> PC-info.txt


REM Get Serial number
set "output="
for /f "skip=1 delims=" %%a in ('wmic csproduct get name') do (
    for /f "delims=" %%b in ("%%a") do if not defined output set "output=%%~nb"
)

@echo Product name	%output% >> PC-info.txt

REM execute a batch with administrator rights
REM runas /noprofile /user:mymachine\administrator yourbatchfile.bat


REM Get window Product key (Need administrator right)
set "OUTPUT=(`wmic path softwarelicensingservice get OA3xOriginalProductKey /value`)"
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set "OUTPUT=(`wmic bios get serialnumber /value`)"
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set "OUTPUT=('\"wmic cpu get name,ProcessorId /value\"')"
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic memphysical get MaxCapacity /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic diskdrive get Model^,size /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic csproduct get Vendor^,Name^,UUID /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic os get caption, serialnumber /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic computersystem get domain,name /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set "OUTPUT=(`wmic DISKDRIVE get InterfaceType,Name,Size,Status /value`)"
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM Get Network adapters and their MAC addresses
set OUTPUT=(`wmic nic where 'PNPDeviceID like "%%%%%PCI%%%%%%"' get Name,MACAddress /value`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set "OUTPUT=(`WMIC NICCONFIG where 'IPEnabled=True and TcpipNetbiosOptions!=null and TcpipNetbiosOptions!=2' get description,dnshostname,ipaddress,DefaultIPGateway,DNSServerSearchOrder,DHCPServer,macaddress /format:list`)"
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

set OUTPUT=(`wmic USERACCOUNT get Caption,Name,PasswordRequired,Status`)
CALL:WriteListOutput "%OUTPUT%" PC-info.txt

REM Get harddisk serial number   
wmic path win32_physicalmedia get SerialNumber

wmic RDACCOUNT list full



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

