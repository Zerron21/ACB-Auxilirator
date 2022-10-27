# ACB-Auxilirator
A poorly written script that automates creating the needed .acb and .awb files needed in Aemulus Mod Manager for music modding.

## Dependencies
* An unmodified copy of BGM.awb & BGM.acb and AcbEditor.exe from [SonicAudioTools](https://github.com/blueskythlikesclouds/SonicAudioTools/releases), 
Both are included in the [PS4 Template Mod](https://gamebanana.com/mods/408773) BGM mod availabe on [GameBanana](https://gamebanana.com/).

## Configuration
Settings are handled from within the **config.bat** file, below is a list of acceptable default settings.
```batchfile
:: Set the platform the mod is made for, Currently only "Nintendo Switch" & "PS4" are supported.
:: If empty, will default to PS4.
set PLATFORM="PS4"

:: Set the name of the template mod's folder, this is used to create the bgm files.
set TEMPLATE_MOD="Papers Please Game Over BGM"

:: Set the AcbEditor.exe filepath.
:: Leave empty to use the default filepath: "Documents\SonicAudioTools\AcbEditor.exe"
set EDITOR_PATH=""

:: Set the bgm.acb & bgm.awb directory path.
:: Leave empty to use the default directory: "Documents\BGM\$GAME"
:: You can use the $GAME value to specify a subfolder incase multiple bgm files are stored.
set BGM_PATH=""

:: Set the "sound" folder location relative to the script, $SOUND_PATH="sound" for aemulus.
:: This will be searched for a BGM folder that contains the audio files, e.g. %sound%\bgm\audio.adx.
:: No need to include BASE for 2022 releases since it'll be add automatically based on PLATFORM.
set SOUND_PATH="sound"

:: Creates an "Ignore.aem" file that prevents aemulus from copying loose files into the mod output.
:: Warning, this will wipe out the entire file so if you want to specify the files manually, set it to "false".
set CREATE_IGNORE="true"

:: Removes the remaining .adx files to free up space after the .awb file repacks.
:: Default is "false" for safety, use at your own risk since you can delete them manually anyways.
set DELETE_LOOSE_FILES="false"
```
