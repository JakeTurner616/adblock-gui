@echo off &title Ad block 
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -ArgumentList "%cd%" -verb runas >NUL 2>&1
    exit /b
)
:create a unique file in %temp% pass to env varible %uid%
: check if uid exists if so, skip by goto :uidset
if exist %temp%\uid.txt goto :uidset else :
echo backing up hosts file before proceeding            
copy /v %WINDIR%\system32\drivers\etc\hosts %temp%\hosts
echo creating uid to mark script as ran.
echo >> %temp%\uid.txt
SET uid=%temp%\uid.txt


:uidset






:gui_dialog_1
set first_choices=Ad block,Finish&set title=Simple GUI choices #1
:: Show gui dialog 1=Title 2=choices 3=outputvariable
call :choice "Ad block" "%first_choices%" CHOICE
:: Quit if no choice selected
if not defined CHOICE exit/b
echo: >nul && set WINDOW='true'
if not defined CHOICE exit/b
:: Print choices
echo Choice1: %CHOICE% & echo.
:: Continue to dialog_2


:gui_dialog_2
:: Process results from dialog_1
if "%CHOICE%"=="Ad block" set next_choices=Backup hosts file,Basic adblock list + adguardDNS,Performance adblock list,Export hosts file,Import hosts file,Revert hosts file from backup,Back&set title=Ad block 
if "%CHOICE%"=="Finish"   call :"Finish"  &goto Done no suboption
:: Show gui dialog 1=Title 2=choices 3=outputvariable
call :choice "%title%" "%next_choices%" CHOICE
:: Quit if no choice selected
if not defined CHOICE color 0c &echo  ERROR! No choice selected.. &timeout /t 20 &color 07 &exit/b
:: Print choices
echo Choice2: %CHOICE% & echo.
:: Back to dialog_1
if "%CHOICE%"=="Back" goto gui_dialog_1

:: Process final choice
call :"%CHOICE%" 


:Done

::verify that the hosts file makes sense
:verify
type %WINDIR%\system32\drivers\etc\hosts | find /i "127.0.0.1 localhost" | find /i "127.0.0.1 localhost" >nul && goto :exit
powershell (New-Object -ComObject Wscript.Shell).Popup("""Error in hosts file, press ok to revert to a backup""",0,"""Error in hosts file""",0x30) 1>nul && timeout 3 >nul && copy /v %temp%\hosts %WINDIR%\system32\drivers\etc\hosts >nul
(echo file makes sense, exiting.)
timeout 3 >nul
exit/b
:: Choice code
:"Option4"
echo running code for %0
rem do stuff here
exit/b
:"Finish"
echo running code for %0
rem do stuff here
goto :Done
:"Basic adblock list + adguardDNS"
echo running code for %0


curl https://raw.githubusercontent.com/d3ward/toolz/master/src/d3host.txt > C:\Windows\system32\drivers\etc\hosts

::set adguard dns
SETLOCAL EnableDelayedExpansion
SET adapterName=
FOR /F "tokens=* delims=:" %%a IN ('IPCONFIG ^| FIND /I "ETHERNET ADAPTER"') DO (
SET adapterName=%%a
REM Removes "Ethernet adapter" from the front of the adapter name
SET adapterName=!adapterName:~17!
REM Removes the colon from the end of the adapter name
SET adapterName=!adapterName:~0,-1!
netsh interface ipv4 set dns name="!adapterName!" static 45.90.28.171 primary
netsh interface ipv4 add dns name="!adapterName!" 45.90.30.171 index=2
)



ipconfig /flushdns



goto :gui_dialog_2
:"Performance adblock list"
echo running code for %0
SET NEWLINE=^& echo.

FIND /C /I "adchoice.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 adchoice.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "adclick.g.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 adclick.g.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "googleads.g.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 googleads.g.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "feedads.g.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 feedads.g.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "3lift.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 3lift.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "amazon-adsystem.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 amazon-adsystem.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "clicktrack.pubmatic.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 clicktrack.pubmatic.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ads.yieldmo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ads.yieldmo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "cat.da.us.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 cat.da.us.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "sync-criteo.ads.yieldmo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 sync-criteo.ads.yieldmo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "www2.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 www2.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "widget.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 widget.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "rtax.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 rtax.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "dis.eu.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 dis.eu.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "rdi.eu.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 rdi.eu.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "gum.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 gum.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "us.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 us.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ads.us.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ads.us.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "widget.da.us.criteo.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 widget.da.us.criteo.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "criteo.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 criteo.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "us.criteo.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 us.criteo.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "da.us.criteo.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 da.us.criteo.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "cm.g.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 cm.g.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "innovid.com.akadns.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 innovid.com.akadns.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ag.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ag.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "dts.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 dts.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "rtr.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 rtr.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s-a.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s-a.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s-files.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s-files.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s-static.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s-static.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s-video.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s-video.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "service.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 service.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "static.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 static.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "pgttdinnovidna5267443539015.s.moatpixel.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 pgttdinnovidna5267443539015.s.moatpixel.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "thetradedeskinnovidmaster582779829774.s.moatpixel.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 thetradedeskinnovidmaster582779829774.s.moatpixel.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "cdn.innovid.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 cdn.innovid.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "innovid.com.akadns.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 innovid.com.akadns.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ag.innovid.com.akadns.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ag.innovid.com.akadns.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "aws-oreg-cali-virg.ag.innovid.com.akadns.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 aws-oreg-cali-virg.ag.innovid.com.akadns.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "s-static.innovid.com.edgekey.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 s-static.innovid.com.edgekey.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "c.admob.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 c.admob.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "code.adtlgc.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 code.adtlgc.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ip-geo.appspot.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ip-geo.appspot.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "nojsstats.appspot.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 nojsstats.appspot.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ad-ace.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ad-ace.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ad.bg.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 ad.bg.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "fls.au.doubleclick.net" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 fls.au.doubleclick.net>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "www.doubleclickbygoogle.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 www.doubleclickbygoogle.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "video-stats.video.google.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 video-stats.video.google.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "4.afs.googleadservices.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 4.afs.googleadservices.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "partner.googleadservices.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 partner.googleadservices.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "www.googletagservices.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 www.googletagservices.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "www.linksalpha.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^0.0.0.0 www.linksalpha.com>>%WINDIR%\System32\drivers\etc\hosts
goto :gui_dialog_2
:"Export hosts file"
echo running code for %0


setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder to export to.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I" 

setlocal enabledelayedexpansion
if %cd%==%WINDIR%\system32 goto :gui_dialog_2
cd !folder! & copy /v %temp%\hosts hosts
endlocal
goto :gui_dialog_2
exit /b
:"Import hosts file"



set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"

for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
::check for empty selction
IF "%file%"=="" goto :gui_dialog_2
copy /v %file% %WINDIR%\system32\drivers\etc\hosts
goto :gui_dialog_2
:"Revert hosts file from backup"
echo running code for %0
copy /v %temp%\hosts C:\Windows\system32\drivers\etc\hosts
goto :gui_dialog_2
exit/b
:"Back"
echo running code for %0
goto :gui_dialog_2
exit/b
:"Backup hosts file"
echo running code for %0
echo backing up hosts file to C:\Temp\hosts
copy /v C:\Windows\system32\drivers\etc\hosts %temp%\hosts
goto :gui_dialog_2
:"Suboption 3 3"
echo running code for %0
rem do stuff here
exit/b
:"Suboption 3 4"
echo running code for %0
rem do stuff here
exit/b

::---------------------------------------------------------------------------------------------------------------------------------
:choice 
rem 1=title 2=options 3=output_variable                                          example: call :choice Choose "op1,op2,op3" result 
setlocal & set "c=about:<title>%~1</title><head><script language='javascript'>window.moveTo(-200,-200);window.resizeTo(100,500);" 
set "c=%c% </script><hta:application icon='C:\Users\jaked\Documents\favicon.ico' innerborder='no' sysmenu='yes' scroll='no'><style>body{background-color:#17141F;}"
set "c=%c% br{font-size:14px;vertical-align:-4px;} .button{background-color:#7D5BBE;border:2px solid #392E5C; color:white;"
set "c=%c% padding:4px 4px;text-align:center;text-decoration:none;display:inline-block;font-size:16px;cursor:pointer;"
set "c=%c% width:100%%;display:block;}</style></head><script language='javascript'>function choice(){"
set "c=%c% var opt=document.getElementById('options').value.split(','); var btn=document.getElementById('buttons');"
set "c=%c% for (o in opt){var b=document.createElement('button');b.className='button';b.onclick=function(){
set "c=%c% close(new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(this.value));};"
set "c=%c% b.appendChild(document.createTextNode(opt[o]));btn.appendChild(b);btn.appendChild(document.createElement('br'));};"
set "c=%c% btn.appendChild(document.createElement('br'));var r=window.parent.screen;"
set "c=%c% window.moveTo(r.availWidth/3,r.availHeight/6);window.resizeTo(r.availWidth/3,document.body.scrollHeight);}</script>"
set "c=%c% <body onload='choice()'><div id='buttons'/><input type='hidden' name='options' value='%~2'></body>"
for /f "usebackq tokens=* delims=" %%# in (`mshta "%c%"`) do set "choice_var=%%#"
endlocal & set "%~3=%choice_var%" & exit/b &rem snippet by AveYo released under MIT License

::--------------------------------------------------------------------------------------------------------------------------------
:exit
(echo file makes sense, exiting.)
exit/b