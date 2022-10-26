# ACB-Auxilirator
A poorly written script that automates creating the needed .acb and .awb files needed in Aemulus Mod Manager for music modding.

## Dependencies
* AcbEditor.exe from [SonicAudioTools](https://github.com/blueskythlikesclouds/SonicAudioTools/releases).
* bgm.acb & bgm.awb from the game's [ps4R.cpk](https://shrinefox.com/guides/2020/09/30/modding-persona-5-royal-on-ps4/).

- **AcbEditor.exe** should be placed in "...\Documents\SonicAudioTools\AcbEditor.exe"
- **bgm.acb** & **bgm.awb** should be placed in "...\Documents\bgm\\**$GAME**"

The **$GAME** subfolder is optional, but it can be specified in the config file to separate bgm files by game.

## Configuration
Settings are handled from within the **config.bat** file, below is a list of acceptable default settings.

```batchfile
:: Set the platform the mod is made for, Currently only "Nintendo Switch" & "PS4" are supported.
:: If empty the script will throw an error.
set PLATFORM="Nintendo Switch"

:: Set the AcbEditor.exe filepath.
:: Leave empty to use the default filepath: "Documents\SonicAudioTools\AcbEditor.exe"
set EDITOR_PATH=""

:: Set the bgm.acb & bgm.awb directory path.
:: Leave empty to use the default directory: "Documents\BGM\$GAME"
:: You can use the $GAME value to specify a subfolder incase multiple bgm files are stored.
set BGM_PATH=""

:: Optional, Set the name of the subfolder containing the game specific bgm files.
:: If empty, $BGM_PATH will use the "Documents\BGM" as the files location.
:: set GAME="Persona5Royal"

:: Set the "sound" folder location relative to the script, $SOUND_PATH="sound" for aemulus.
:: This will be searched for a BGM folder that contains the audio files, e.g. %sound%\bgm\audio.adx.
:: No need to include BASE for 2022 releases since it'll be add automatically based on PLATFORM.
set SOUND_PATH="sound"

:: Creates an "Ignore.aem" file that prevents aemulus from copying loose files into the mod output.
:: Warning, this will wipe out the entire file so if you want to specify the files manually, set it to "false".
set CREATE_IGNORE="true"

:: Removes the remaining .adx files to free up space after the .awb file repacks.
:: Default is "false", if you want to set it to "true" make sure you have a way to obtain the files back as a backup.
set DELETE_LOOSE_FILES="false"
```
