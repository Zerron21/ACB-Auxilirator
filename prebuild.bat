:: Variable settings, Change only the FINALIZE value to 0 if you want to keep the used files for recompilation
set EDITOR_PATH=.\.derp\SonicAudioTools\AcbEditor.exe
set /A FINALIZE=1

:: Platform check.
if exist .\BASE (set BGM_PATH=\BASE\SOUND& set PLATFORM=Switch) else set BGM_PATH=\SOUND& set PLATFORM=PS4
set BGM_ORIGIN=..\..\..\Original\Persona 5 Royal (%PLATFORM%)%BGM_PATH%

:: Necessity check & error exists.
if exist .%BGM_PATH%\BGM.ACB if exist .%BGM_PATH%\BGM.AWB exit
:: if not exist "%BGM_ORIGIN%\BGM.ACB" if not exist "%BGM_ORIGIN%\BGM.AWB" exit

:: Create BGM copies, unpack them, replace tracks from BGM folder, repack and rename appropriately.
for %%F in ("%BGM_ORIGIN%\BGM.A?B") do copy "%%F" .%BGM_PATH%\BESTCITYRUAN%%~xF
start /W /MIN %EDITOR_PATH% ".%BGM_PATH%\BESTCITYRUAN.ACB"
copy .%BGM_PATH%\BGM\00???_streaming.??? .%BGM_PATH%\BESTCITYRUAN\00???_streaming.???
start /W /MIN %EDITOR_PATH% ".%BGM_PATH%\BESTCITYRUAN"
del /Q .%BGM_PATH%\BESTCITYRUAN && rmdir .%BGM_PATH%\BESTCITYRUAN
ren .%BGM_PATH%\BESTCITYRUAN.A?B BGM.A?B
if %FINALIZE% NEQ 1 exit

:: Finalize and delete unnecessary files, cannot be undone.
del /Q .\.derp\SonicAudioTools && rmdir .\.derp\SonicAudioTools && rmdir .\.derp
del /Q .%BGM_PATH%\BGM && rmdir .%BGM_PATH%\BGM && del /Q Ignore.aem