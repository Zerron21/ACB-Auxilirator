@echo off
:Initial_check
title Building AWB file.
if exist sound\bgm.awb goto Initial_check_fail
goto Config_Check

:Config_Check
set config_file="config.bat"
if not exist %config_file% goto Config_Check_fail
call %config_file%

if %EDITOR_PATH% == "" set EDITOR_PATH="%UserProfile%\Documents\SonicAudioTools\AcbEditor.exe"

set GAME=%GAME:"=%
if %BGM_PATH% == "" set BGM_PATH="%UserProfile%\Documents\BGM\%GAME%"

if not exist %EDITOR_PATH% goto Config_Check_fail
if not exist %BGM_PATH%\bgm.acb goto Config_Check_fail
if not exist %BGM_PATH%\bgm.awb goto Config_Check_fail
if not exist %SOUND_PATH%\bgm goto Config_Check_fail
if %CREATE_IGNORE% == "true" goto Ignore_Creation
goto AWB_Build

:Ignore_Creation
set SOUND_PATH=%SOUND_PATH:"=%
break > Ignore.aem
for /f %%G in ('dir %SOUND_PATH%\bgm /A:-D /B') do echo %SOUND_PATH%\bgm\%%G >> Ignore.aem
goto AWB_Build

:AWB_Build
rename %BGM_PATH%\bgm.acb bgm_original.acb
rename %BGM_PATH%\bgm.awb bgm_original.awb

copy /b %BGM_PATH%\bgm_original.acb %BGM_PATH%\bgm.acb
copy /b %BGM_PATH%\bgm_original.awb %BGM_PATH%\bgm.awb

start /w "" %EDITOR_PATH% %BGM_PATH%\bgm.acb

robocopy %SOUND_PATH%\bgm %BGM_PATH%\bgm *.adx

start /w "" %EDITOR_PATH% %BGM_PATH%\bgm
move %BGM_PATH%\bgm.acb %SOUND_PATH%
move %BGM_PATH%\bgm.awb %SOUND_PATH%

rmdir /s /q %BGM_PATH%\bgm
rename %BGM_PATH%\bgm_original.acb bgm.acb
rename %BGM_PATH%\bgm_original.awb bgm.awb

if %DELETE_LOOSE_FILES% == "true" goto Delete_Remains
goto eof

:Delete_Remains
erase "%SOUND_PATH%\bgm\*.adx"
goto eof

:Config_Check_fail
cls
if not exist %EDITOR_PATH% echo Make sure AcbEditor.exe is set in the config file!
if not exist %BGM_PATH%\bgm.acb echo Make sure bgm.acb is set in the config file!
if not exist %BGM_PATH%\bgm.awb echo Make sure the bgm.awb is in the same location as bgm.acb!
if not exist %SOUND_PATH%\bgm echo Make sure the 'sound' folder is set in the config file! and that bgm subfolder contains the .adx files!
pause
start msgbox.vbs
goto eof

:Initial_check_fail
echo Nothing needs to be done!
goto eof