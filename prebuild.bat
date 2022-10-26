@echo off
title Building AWB file.

:Config_Check
:: Check for the configuration file and apply it.
set config_file="config.bat"
if not exist %config_file% goto Config_Check_fail
call %config_file%

:: Correct variables format.
set PLATFORM=%PLATFORM:"=%
set SOUND_PATH=%SOUND_PATH:"=%

:: Apply default paths.
if %EDITOR_PATH% == "" set EDITOR_PATH="..\%PLATFORM% BGM\Dependencies\SonicAudioTools\AcbEditor.exe"
if %BGM_PATH% == "" set BGM_PATH="..\%PLATFORM% BGM"

:: Check for PS4 mod format to adujust %SOUND_PATH%.
if "%PLATFORM%" == "PS4" (set SOUND_PATH=%SOUND_PATH%) else (set SOUND_PATH=BASE\%SOUND_PATH%)

:: Checking if the BGM file is already compiled.
if exist %SOUND_PATH%\bgm.awb goto :eof

:: Check for errors.
set AVAILABLE_PLATFORMS=PS4 "Nintendo Switch"
for %%p in (%AVAILABLE_PLATFORMS%) do if %%p == %PLATFORM% set PROGRESS=true
if (%PROGRESS% == false) goto Config_Check_fail 
if not exist %EDITOR_PATH% goto Config_Check_fail
if not exist %BGM_PATH%\bgm.acb goto Config_Check_fail
if not exist %BGM_PATH%\bgm.awb goto Config_Check_fail
if not exist %SOUND_PATH%\bgm goto Config_Check_fail

:: Check for audio format.
if "%PLATFORM%" == "Nintendo Switch" (set AUDIO_FORMAT=hca) else (set AUDIO_FORMAT=adx)

:: Check if ignore.aem needs to be generated.
if %CREATE_IGNORE% == "true" goto Create_Ignore_file
goto AWB_Build

:Create_Ignore_file
break > Ignore.aem
for /f %%G in ('dir %SOUND_PATH%\bgm /A:-D /B') do echo %SOUND_PATH%\bgm\%%G >> Ignore.aem
echo msgbox.vbs >> Ignore.aem
echo config.bat >> Ignore.aem
echo prebuild.bat >> Ignore.aem
goto AWB_Build

:AWB_Build
:: Renames the BGM files to prevent overwrites.
rename %BGM_PATH%\bgm.acb bgm_original.acb
rename %BGM_PATH%\bgm.awb bgm_original.awb

:: Creates a copy of the BGM files for editing.
copy /b %BGM_PATH%\bgm_original.acb %BGM_PATH%\bgm.acb
copy /b %BGM_PATH%\bgm_original.awb %BGM_PATH%\bgm.awb

:: Runs ACBEditor.exe with BGM.acb
start /w /min "" %EDITOR_PATH% %BGM_PATH%\bgm.acb

:: Mass copy all audio files to the unpacked BGM directory.
robocopy %SOUND_PATH%\bgm %BGM_PATH%\bgm *.%AUDIO_FORMAT%

:: Runs ACBEditor.exe with the modified BGM directory
start /w /min "" %EDITOR_PATH% %BGM_PATH%\bgm

:: Move modified BGM files back into the sound directory.
move %BGM_PATH%\bgm.acb %SOUND_PATH%
move %BGM_PATH%\bgm.awb %SOUND_PATH%

:: Delete the leftover BGM directory.
rmdir /s /q %BGM_PATH%\bgm

:: Rename the original BGM files back.
rename %BGM_PATH%\bgm_original.acb bgm.acb
rename %BGM_PATH%\bgm_original.awb bgm.awb

if %DELETE_LOOSE_FILES% == "true" goto Delete_Remains
goto :eof

:Delete_Remains
erase "%SOUND_PATH%\bgm\*.%AUDIO_FORMAT%"
goto :eof

:Config_Check_fail
cls
if not exist %EDITOR_PATH% echo Make sure AcbEditor.exe is set in the config file!
if not exist %BGM_PATH%\bgm.acb echo Make sure bgm.acb is set in the config file!
if not exist %BGM_PATH%\bgm.awb echo Make sure the bgm.awb is in the same location as bgm.acb!
if not exist %SOUND_PATH%\bgm echo Make sure the 'sound' folder is set in the config file! and that bgm subfolder contains the .%AUDIO_FORMAT% files!

::Launch the dreaded error message.
for /f %%G in ('cscript /nologo msgbox.vbs') do if %%G == 4 goto Config_Check
