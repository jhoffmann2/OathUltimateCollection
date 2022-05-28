# How to create mods:

## Directory Structure:
This directory is the home base for (likely) all of your code! To create a new module, start by creating a directory here. The name of the directory will be the non-public identifier for your mod. As a general rule, all directory and file names should not contain any spaces. Mods can be dynamically loaded and unloaded at any time so they should be able to work both independently and in conjunction (with a few exceptions) with one another.

## index.json File:
By default your mod will be unloaded and will not show up in the mod selection UI. To change this, you'll modify [index.json](index.json). This file serves two purposes:
1. Provide info to the Main Menu system when generating a menu of mods that the user can toggle
2. Specify the default on/off state of mods

The top level of the index tree is a list of user facing items in the mod selection panel of the main menu UI. these items can take either of the following forms:

### Toggles:
```json lines
// user facing name
"My New Mod": {
        
  // setting type to 'toggle' allows users to turn mods on and off from the menu
  "type": "toggle",
      
  // if this is true, it won't show up in the menu
  "hidden": false,
      
  // if this is true, the mod will be enabled by default (unless you're changing the base game, you probably want this false)
  "value": false,

  // this is the name of the directory you made for your mod
  "mod": "ModDirectoryName"

  // this is displayed when you hover over the toggle in the menu
  "tooltip": "click me!"
}
```


### Radios:
```json lines
// user facing category name for the radio UI
"Pick a cool mod": {
        
  // setting type to 'radio' will make a radio selection between multiple mods in the menu
  // (useful when you have mutually exclusive mods)
  "type": "radio",

  // the default selected mod from the options list.
  "value": "CoolMod1",
      
  // if this is true, it won't show up in the menu (this would be a weird choice for a radio but you do you)
  "hidden": false,

  // this is displayed when you hover over the radio category name in the menu
  "tooltip": "This radio can be used to pick a mod wow!",
      
  // a list of options to choose between in the radio. each option is it's own mod
  "options": [
    {
      // user facing name of the mod
      "name": "Option 1",
          
      // this is the name of the directory you made for your mod
      "mod": "CoolMod1",
          
      // this is displayed when you hover over this option in the menu
      "tooltip": "play with all the cards found in the official base game!"
    },
    {
      // user facing name of the mod
      "name": "Option 1",

      // this is the name of the directory you made for your mod
      "mod": "CoolMod2",

      // this is displayed when you hover over this option in the menu
      "tooltip": "This option will not work. it's just a placeholder for now"
    },
      ...
  ]
}
```
(Note: I used comments in the above code strips to add clarity but json doesn't support comments unfortunately so when you add your mods you can't add comments)

## Global Files:

### Global.lua:
Much like traditional TTS scripting, Global scripts will have exactly one instance per mod and won't be assigned to an object in the game. All Global scripts share the same data inside their ``shared`` variable and will exist for the lifetime of the game unless the mod is unloaded. This is a good place to start for most mods.

### Global.json:
This json has a parallel feature set to [TTS save files](https://kb.tabletopsimulator.com/custom-content/save-file-format/). For this reason You can basically just copy paste a safe file into here and it will load all the supported attributes and ignore the rest. This should make it really easy to take TTS existing content, and quickly turn them into modules for this mod loader

#### Supported Attributes:
- CustomUIAssets
  - This will append to the existing global assets rather than overwrite them
- LuaScriptState 
  - LuaScriptState can be a string or an object. if it's an object, it will be turned into a json string when it's passed to the mod's onLoad function
  - passed to [Global.lua](#globallua)'s ``onLoad`` event function
- XmlUI
  - XmlUI will be ignored if [Global.xml](#globalxml) is defined
- LuaScript
  - LuaScript will be ignored if [Global.lua](#globallua) is defined
- ObjectStates
  - appends to the existing objects
- SnapPoints
  - appends to the existing snap points
- Lighting
  - overwrites existing Lighting setting
- All Object Attributes (passed into [spawnObjectJSON](https://api.tabletopsimulator.com/base/#spawnobjectjson) to spawn the script runner)

#### Planned Support:
- Gravity
  - overwrites existing gravity setting
- PlayArea
  - overwrites existing PlayArea setting
- Table
  - overwrites existing Table setting
- TableURL
  - overwrites existing TableURL setting
- Sky
  - overwrites existing Sky setting
- SkyURL
  - overwrites existing SkyURL setting
- Grid
  - overwrites existing Grid setting
- Hands
  - overwrites existing Hands setting
- Turns
  - overwrites existing Turns setting
- VectorLines
  - appends new vector lines
- DecalPallet
  - appends to the existing decals
- TabStates
  - appends to the existing tab states
- CameraStates
  - appends to the existing camera states
- 

#### Unsupported:
- VersionNumber
- SaveName
- GameMode
- PlayingTime
- Date
- EpochTime
- GameComplexity
- PlayerCounts
- Tags
- Note

### Global.xml:
- This will append to the existing global UI rather than replacing it. all global UI is in screen space rather than positioned relative to an object. 
- unloading the mod will fully remove this mods UI from the global UI
- UI event functions reference the Global.lua script of this mod by default

## Object Tag Files:
One of the coolest features of this mod loader is that you can create scripts that run on all objects that match a specified tag! For example, if you name your script "Car.lua", then whenever an object is tagged with "Car", a new instance of the car script will be constructed and attributed to that object. There is no limit to the number of objects you have simultaneously loading their own instance of a tag script. 

### *\<Tag\>*.lua
- When this mod is loaded, all objects tagged with *\<Tag\>* will run an instance of this script
- While the mod is active:
  - When a new object is created with the tag *\<Tag\>*, it will run an instance of this script
  - When ``Object.AddTag("<Tag>")`` is called, it will run an instance of this script
    - Limitation: unfortunately it has to be tagged by code. This does not work if you tag objects from within TTS
  - When ``Object.SetTags(<list containing <Tag> >)`` is called, it will run an instance of this script
- Limitation: unfortunately it has to be tagged by code. This does not work if you tag objects from within TTS

### *\<Tag\>*.json:
this json shares the exact same properties as [spawnObjectJSON](https://api.tabletopsimulator.com/base/#spawnobjectjson) in the TTS lua API. It is used to specify the object data of the script runner **NOT** the tagged object. Basically every instance of this script is running on a unique (default invisible) object and just 'pretends' like it's running on the tagged object. There's not very many scenarios where you'd want to modify the spawning behavior of a runner but it's here if you need it.

### *\<Tag\>*.xml:
currently this ui will be displayed relative to the runner rather than the tagged object. (Use [*\<Tag\>*.json](#tagjson) to modify the runners spawning position) This behavior may change in the future.