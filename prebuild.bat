:: Variable settings, Change FINALIZE to 0 to keep loose audio files after the BGM file is compiled.
:: Make sure loose audio files are in a folder named "AUDIO" inside of the usual .acb location.
set EDITOR_PATH=.\.derp\SonicAudioTools\AcbEditor.exe
set /A FINALIZE=0

for %%t in (.\..) do set GAME="%%~nt"
set GAME=%GAME:"=%

if exist .\sound\adx2\bgm (set BGM_PATH=sound\adx2\bgm& goto Origin_Setting)
if exist .\BASE (set BGM_PATH=BASE\SOUND& goto Origin_Setting) else set BGM_PATH=SOUND

:Origin_Setting
set BGM_ORIGIN=..\..\..\Original\%GAME%\%BGM_PATH%

:: Necessity check & error exits.
if exist .\%BGM_PATH%\*BGM.ACB if exist .\%BGM_PATH%\*BGM*.AWB exit

:: Create BGM copies, unpack them, replace tracks from BGM folder, repack and rename appropriately.
for %%F in ("%BGM_ORIGIN%\*BGM*.A?B") do copy "%%F" .\%BGM_PATH%\*%%~xF
for %%B in (".\%BGM_PATH%\*.ACB") do start /W /MIN %EDITOR_PATH% %%B & set BGM_NAME=%%~nB

copy .\%BGM_PATH%\audio\?????_streaming.??? .\%BGM_PATH%\%BGM_NAME%\?????_streaming.???
start /W /MIN %EDITOR_PATH% ".\%BGM_PATH%\%BGM_NAME%"
del /Q .\%BGM_PATH%\%BGM_NAME% && rmdir .\%BGM_PATH%\%BGM_NAME%
if %FINALIZE% NEQ 1 exit

:: Finalize and delete unnecessary files, cannot be undone.
del /Q .\.derp\SonicAudioTools && rmdir .\.derp\SonicAudioTools && rmdir .\.derp
del /Q .\%BGM_PATH%\AUDIO && rmdir .\%BGM_PATH%\AUDIO && del /Q Ignore.aem