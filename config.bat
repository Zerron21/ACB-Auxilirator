:: Set the AcbEditor.exe filepath.
:: Leave empty to use the default filepath: "Documents\SonicAudioTools\AcbEditor.exe"
set EDITOR_PATH=""

:: Set the bgm.acb & bgm.awb directory path.
:: Leave empty to use the default directory: "Documents\BGM\$GAME"
:: You can use the $GAME value to specify a subfolder incase multiple bgm files are stored.
set BGM_PATH=""

:: Optional, Set the name of the subfolder containing the game specific bgm files.
:: If empty, $BGM_PATH will use the "Documents\BGM" as the files location.
set GAME="Persona5Royal"

:: Set the "sound" folder location relative to the script, usually $SOUND_PATH="sound" for aemulus.
set SOUND_PATH="sound"

:: Creates an "Ignore.aem" file that prevents aemulus from copying loose files into the mod output.
:: Warning, this will wipe out the entire file so if you want to specify the files manually, set it to "false".
set CREATE_IGNORE="true"

:: Removes the remaining .adx files to free up space after the .awb file repacks.
:: Default is "false", if you want to set it to "true" make sure you have a way to obtain the files back as a backup.
set DELETE_LOOSE_FILES="false"