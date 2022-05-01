--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2021
--

function onLoad(save_state)
    print("Global.lua :: OnLoad()")
    
    -- If the mod was just loaded and no one else is seated, start as Blue so the menu and map appear correctly oriented.
    if ((false == Player["Purple"].seated)  and
            (false == Player["Red"].seated)     and
            (false == Player["Brown"].seated)   and
            (false == Player["Blue"].seated)    and
            (false == Player["Yellow"].seated)  and
            (true == Player["White"].seated)) then
        Player["White"].changeColor('Blue')
    end

    OATH_MAJOR_VERSION                   = 3
    OATH_MINOR_VERSION                   = 3
    OATH_PATCH_VERSION                   = 3
    OATH_MOD_VERSION                     = OATH_MAJOR_VERSION .. "." .. OATH_MINOR_VERSION .. "." .. OATH_PATCH_VERSION

    STATUS_SUCCESS                       = 0
    STATUS_FAILURE                       = 1

    MIN_NAME_LENGTH                      = 1
    MAX_NAME_LENGTH                      = 255

    BUTTONS_NONE                         = 0
    BUTTONS_NOT_IN_GAME                  = 1
    BUTTONS_IN_GAME                      = 2

    -- Chronicle info codes.
    CHRONICLE_INFO_CREATE_SAVE           = 0
    CHRONICLE_INFO_COMBINE_ADVISERS      = 1

    -- Currently, the 24th and final site is not used.
    NUM_TOTAL_SITES                      = 23

    NUM_TOTAL_DENIZENS                   = 198

    local tokenPosition = nil

    math.randomseed(os.time())
    -- Throw away a few numbers per the Lua documentation.  The first number may not be random.
    math.random()
    math.random()
    math.random()

    NO_FAQ_TEXT                          = "(no FAQ for this card)"
    RESET_CHRONICLE_STATE_STRING         = "030302000110Empire and Exile0000000123450403FFFFFFFFFFFF0724FFFFFFFFFFFFFFFFFFFF0B19FFFFFFFFFFFFFFFFFFFF000000002007UNKNOWN"
    TUTORIAL_CHRONICLE_STATE_STRING      = "03030200011BThe Chrysanthemum Chronicle1600000123450403FFFF20FFFFFF0724FFE92BFFFFFF19FFFFFF0B19FFFF22FFFFFF2AFFFFFF38061B1E0A292508D62B2DD21C022818D5151D312CD3071AD4050F223013331F340B3512232F320D09210C000E01041410112720262A172E160013E8E7E0DDDCDAEDE6E4EADFE2DEECDBEBE3E1E5002007UNKNOWN"

    dealHeight                           = 4.5

    belowTableDeckGuid                   = "ebc127"
    belowTableFavorGuid                  = "ad4e12"
    belowTableSecretGuid                 = "8314e8"
    mapGuids                             = { "fb146b", "8f599d", "7cf920" }

    -- The game object contains unchanging game data such as card names.
    gameDataObjectGuid                   = "85bbc5"

    siteCardSpawnPositions               = { { -21.38, 1.07,  7.30 },
                                             { -21.39, 1.07,  2.67 },
                                             {  -4.73, 1.07,  7.34 },
                                             {  -4.68, 1.07,  2.67 },
                                             {  -4.69, 1.07, -1.97 },
                                             {  12.26, 1.07,  7.28 },
                                             {  12.26, 1.07,  2.65 },
                                             {  12.28, 1.07, -2.01 } }
    normalCardBaseSpawnPositions         = { { -16.79, 1.07,  7.38 },
                                             { -16.79, 1.07,  2.60 },
                                             {  -0.12, 1.07,  7.38 },
                                             {  -0.12, 1.07,  2.67 },
                                             {  -0.13, 1.07, -2.05 },
                                             {  16.87, 1.07,  7.33 },
                                             {  16.87, 1.07,  2.61 },
                                             {  16.87, 1.07, -2.11 } }
    normalCardXSpawnChange               = { 0.00, 3.05, 6.10 }
    supplyMarkerStartPositions           = { ["Purple"] = { -17.49, 1.06,  20.28 },
                                             ["Red"]    = {  12.91, 0.96,  20.24 },
                                             ["Brown"]  = {  32.28, 1.06,   3.33 },
                                             ["Blue"]   = {  11.92, 1.06, -14.08 },
                                             ["Yellow"] = { -17.44, 1.06, -14.09 },
                                             ["White"]  = { -32.14, 1.06,   5.58 } }
    pawnStartPositions                   = { ["Purple"] = { -25.04, 1.06,  14.64 },
                                             ["Red"]    = {   5.16, 1.06,  14.51 },
                                             ["Brown"]  = {  26.58, 1.06,  10.81 },
                                             ["Blue"]   = {  19.08, 1.06,  -8.41 },
                                             ["Yellow"] = {  -9.88, 1.06,  -8.37 },
                                             ["White"]  = { -26.46, 1.06,  -1.92 } }
    pawnStartYRotations                  = { ["Purple"] = 0.0,
                                             ["Red"]    = 0.0,
                                             ["Brown"]  = 90.0,
                                             ["Blue"]   = 180.0,
                                             ["Yellow"] = 180.0,
                                             ["White"]  = 270.0 }
    handCardSpawnPositions               = { ["Purple"] = { { -13.15, 2.97,  29.83}, { -16.09, 3.07,  29.83}, { -19.03, 3.17,  29.83} },
                                             ["Red"]    = { {  16.38, 2.97,  29.83}, {  13.44, 3.07,  29.83}, {  10.49, 3.17,  29.83} },
                                             ["Brown"]  = { {  47.29, 2.97,   1.90}, {  47.29, 3.07,   4.84}, {  47.29, 3.17,   7.79} },
                                             ["Blue"]   = { {   8.97, 2.97, -29.83}, {  11.91, 3.07, -29.83}, {  14.85, 3.17, -29.83} },
                                             ["Yellow"] = { { -20.08, 2.97, -29.83}, { -17.14, 3.07, -29.83}, { -14.20, 3.17, -29.83} },
                                             ["White"]  = { { -47.40, 2.97,   7.78}, { -47.40, 3.07,   4.84}, { -47.40, 3.17,   1.90} } }
    handCardYRotations                   = { ["Purple"] = 0.0,
                                             ["Red"]    = 0.0,
                                             ["Brown"]  = 90.0,
                                             ["Blue"]   = 180.0,
                                             ["Yellow"] = 180.0,
                                             ["White"]  = 270.0 }
    guiBanditCrownPositions              = { ["Purple"]  = { -450, 70 },
                                             ["Brown"]   = { -240, 20 },
                                             ["Yellow"]  = {  -80, 10 },
                                             ["White"]   = {   70, 25 },
                                             ["Blue"]    = {  236, 40 },
                                             ["Red"]     = {  460, 34 } }
    tutorialAdviserPositions             = { ["Purple"] = { -27.63, 0.97,  17.16 },
                                             ["Red"]    = {   2.77, 0.97,  17.12 },
                                             ["Brown"]  = {   0.00, 0.00,   0.00 },   -- unused in tutorial
                                             ["Blue"]   = {  22.07, 0.97, -10.96 },
                                             ["Yellow"] = {  -7.30, 0.97, -10.95 },
                                             ["White"]  = {   0.00, 0.00,   0.00 } }  -- unused in tutorial
    discardPileSpawnPositions            = { { -14.01, 1.07, 11.14},
                                             {   2.73, 1.07, 11.24},
                                             {  19.64, 1.07, 11.22} }
    playerButtonPositions                = { ["Purple"] = nil,
                                             ["Red"]    = { -43.3, 4.6,   0.6 },
                                             ["Brown"]  = { -64.0, 4.6, -18.8 },
                                             ["Blue"]   = { -42.5, 4.6, -38.0 },
                                             ["Yellow"] = { -12.0, 4.6, -38.0 },
                                             ["White"]  = {   4.3, 4.6, -15.4 } }
    playerButtonColors                   = { ["Purple"] = nil,
                                             ["Red"]    = { 0.80, 0.05, 0.05, 1.00 },
                                             ["Brown"]  = { 0.40, 0.40, 0.40, 1.00 },
                                             ["Blue"]   = { 0.00, 0.68, 1.00, 1.00 },
                                             ["Yellow"] = { 0.94, 0.80, 0.11, 1.00 },
                                             ["White"]  = { 0.63, 0.63, 0.63, 1.00 } }
    favorBagGuid                         = "cfb9e0"
    favorBag                             = nil
    numMarkers                           = 2
    markerGuids                          = { "c1f67a", "a7e6d2" }
    markerPositions                      = { { -20.86, 1.38, -1.83 },
                                             { -17.44, 1.38, -2.09 } }
    diceGuids                            = { "b70c54", "13e33b", "57c9c5", "8ce90c", "297ceb", "863691",                                          -- defense dice
                                             "1f96ec", "e24bff", "3ad8c2", "3d1a23", "94f013", "ca95ce", "7a1759", "199338", "07a097", "607e0c",  -- attack dice
                                             "8e1eb3" }    -- game end die
    dicePositions                        = { { -42.98, 1.46, 17.26 },  -- defense dice
                                             { -41.35, 1.46, 17.26 },
                                             { -39.62, 1.46, 17.26 },
                                             { -43.03, 1.46, 15.57 },
                                             { -41.34, 1.46, 15.57 },
                                             { -39.64, 1.46, 15.57 },
                                             { -42.75, 1.46, 12.32 },  -- attack dice
                                             { -41.12, 1.46, 12.32 },
                                             { -39.39, 1.46, 12.32 },
                                             { -37.60, 1.46, 12.32 },
                                             { -42.80, 1.46, 10.63 },
                                             { -41.11, 1.46, 10.63 },
                                             { -39.41, 1.46, 10.63 },
                                             { -37.62, 1.46, 10.63 },
                                             { -35.82, 1.46, 12.32 },
                                             { -35.82, 1.46, 10.63 },
                                             { -45.29, 1.46, 16.32 } } -- game end die
    favorSpawnPositions                  = { ["Discord"]   = { -3.75, 1.06,  -5.64 },
                                             ["Arcane"]    = { -0.25, 1.06,  -5.64 },
                                             ["Order"]     = {  3.24, 1.06,  -5.64 },
                                             ["Hearth"]    = {  6.75, 1.06,  -5.64 },
                                             ["Beast"]     = {  10.24, 1.06, -5.64 },
                                             ["Nomad"]     = {  13.74, 1.06, -5.64 } }
    oathkeeperTokenGuid                  = "900000"
    oathkeeperStartPosition              = { -41.19,   0.96,  19.28 }
    oathkeeperStartRotation              = {   0.00, 180.00,   0.00 }
    oathkeeperStartScale                 = {   0.69,   1.00,   0.69 }
    dispossessedSpawnPosition            = { -49.50,   0.78, -26.00 }
    worldDeckSpawnPosition               = { -11.57,   1.09,  -4.80 }
    relicDeckSpawnPosition               = { -15.81,   1.18,  -4.79 }
    sideBoardGuid                        = "cc0e33"
    sideBoardPosition                    = { 3.06, 1.47, 50.60 }
    manualFullDecksBagGuid               = "6cc6d7"
    manualWorldDenizensPosition          = {  -4.50,   1.00,  21.70 }
    manualVisionsPosition                = {   1.50,   1.00,  21.70 }
    manualArchivePositions               = { ["Discord"]   = {   7.50,   1.00,  21.70 },
                                             ["Arcane"]    = {  12.50,   1.00,  21.70 },
                                             ["Order"]     = {  17.50,   1.00,  21.70 },
                                             ["Hearth"]    = {  22.50,   1.00,  21.70 },
                                             ["Beast"]     = {  27.50,   1.00,  21.70 },
                                             ["Nomad"]     = {  32.50,   1.00,  21.70 } }
    manualEdificesRuinsPosition          = {  32.50,   1.10,  15.26 }
    manualSitesPosition                  = {  32.50,   1.10,   8.10 }
    manualRelicsPosition                 = {  32.50,   1.10,   0.10 }
    siteCardZoneGuids                    = { "9a3e96", "780752", "a0255b", "2eb56f", "a7195e", "5abb66", "0cc29b", "19e212" }
    mapNormalCardZoneGuids               = { { "ecb381", "7d73a1", "2b4a13" },
                                             { "7d25a7", "cb9070", "f43a64" },
                                             { "d42b02", "0341c6", "15ff0b" },
                                             { "480d7c", "517af5", "f7ecbf" },
                                             { "ca1831", "79834c", "bcfa56" },
                                             { "43fad5", "b397d8", "4caada" },
                                             { "242f8e", "aee07a", "f27196" },
                                             { "7052b5", "6311cc", "17b541" } }
    mapSiteCardZones                     = {}
    mapNormalCardZones                   = { {},
                                             {},
                                             {},
                                             {},
                                             {},
                                             {},
                                             {},
                                             {} }

    worldDeckZoneGuid                    = "b6fea4"
    worldDeckZone                        = nil
    discardZoneGuids                     = { "1f19b3", "89853a", "817e13" }
    discardZones                         = {}

    oathReminderStartPosition            = { -41.16,   0.96, 23.05 }
    oathReminderStartRotation            = {   0.00, 180.00,  0.00 }
    oathReminderTokenGuids               = { ["Supremacy"]    = "56a763",
                                             ["People"]       = "ddc761",
                                             ["Devotion"]     = "375ead",
                                             ["Protection"]   = "03f51a",
                                             ["Conspiracy"]   = nil }
    oathReminderTokens                   = { ["Supremacy"]    = nil,
                                             ["People"]       = nil,
                                             ["Devotion"]     = nil,
                                             ["Protection"]   = nil,
                                             ["Conspiracy"]   = nil }
    oathReminderTokenHidePositions       = { ["Supremacy"]    = { -39.18, (-2.0), 24.68 },
                                             ["People"]       = { -39.18, (-2.5), 24.68 },
                                             ["Devotion"]     = { -39.18, (-3.0), 24.68 },
                                             ["Protection"]   = { -39.18, (-3.5), 24.68 },
                                             ["Conspiracy"]   = nil }

    reliquaryGuid                        = "8c433b"
    reliquary                            = nil
    reliquaryCardPositions               = { { -13.22, 1.07, 23.93 },
                                             { -16.66, 1.07, 23.94 },
                                             { -20.10, 1.07, 23.94 },
                                             { -23.62, 1.07, 23.94 } }
    peoplesFavorGuid                     = "e34fed"
    peoplesFavor                         = nil
    peoplesFavorShowPosition             = { -42.20,   0.97, 35.14 }
    peoplesFavorHidePosition             = {   0.22, (-3.5), 22.37 }
    darkestSecretGuid                    = "651030"
    darkestSecret                        = nil
    darkestSecretShowPosition            = { -50.60,   0.97, 35.14 }
    darkestSecretHidePosition            = {  -6.27, (-3.5), 22.38 }
    chancellorSpecialStartPosition       = { -32.98,   0.96, 28.22 }
    grandScepterStartPosition            = { -32.81,   0.97, 23.04 }
    oathkeeperTokenStartPosition         = { -41.19,   0.96, 19.28 }
    oathkeeperTokenHidePosition          = { -41.19, (-3.5), 19.28 }

    playerBoardGuids                     = { ["Purple"] = "4fe3a3",
                                             ["Red"]    = "26f71b",
                                             ["Brown"]  = "1687d6",
                                             ["Blue"]   = "6ca4ee",
                                             ["Yellow"] = "a7269d",
                                             ["White"]  = "39f190" }
    playerBoards                         = {}
    playerWarbandBagGuids                = { ["Purple"] = "53fa24",
                                             ["Red"]    = "692ddd",
                                             ["Brown"]  = "b2e760",
                                             ["Blue"]   = "0d3f34",
                                             ["Yellow"] = "ebda8c",
                                             ["White"]  = "e89fd4" }
    playerWarbandBags                    = {}
    playerPawnGuids                      = { ["Purple"] = "ba8594",
                                             ["Red"]    = "95b3e4",
                                             ["Brown"]  = "31f795",
                                             ["Blue"]   = "9f1db5",
                                             ["Yellow"] = "b0735a",
                                             ["White"]  = "a8255b" }
    playerPawns                          = {}
    playerSupplyMarkerGuids              = { ["Purple"] = "c91a5e",
                                             ["Red"]    = "c4e76a",
                                             ["Brown"]  = "061daa",
                                             ["Blue"]   = "97cad2",
                                             ["Yellow"] = "41259d",
                                             ["White"]  = "15d787" }
    playerSupplyMarkers                  = {}
    playerAdviserZoneGuids               = { ["Purple"] = { "903e80", "ecb04a", "a2a8b3" },
                                             ["Red"]    = { "1cb9fa", "c2693c", "63d89d" },
                                             ["Brown"]  = { "cf9d4a", "490541", "88d8ef" },
                                             ["Blue"]   = { "542195", "9aa3a6", "aa57ba" },
                                             ["Yellow"] = { "4a8056", "a641b8", "14b48e" },
                                             ["White"]  = { "91f5a7", "6b0631", "bd1c43" } }
    playerAdviserZones                   = { ["Purple"] = {},
                                             ["Red"]    = {},
                                             ["Brown"]  = {},
                                             ["Blue"]   = {},
                                             ["Yellow"] = {},
                                             ["White"]  = {} }
    suitFavorZoneGuids                   = { ["Discord"]   = "0bbd07",
                                             ["Hearth"]    = "1fc5f8",
                                             ["Nomad"]     = "2430d4",
                                             ["Arcane"]    = "2fe4a0",
                                             ["Order"]     = "04cf1c",
                                             ["Beast"]     = "2422e1" }
    suitFavorZones                       = { ["Discord"]   = nil,
                                             ["Hearth"]    = nil,
                                             ["Nomad"]     = nil,
                                             ["Arcane"]    = nil,
                                             ["Order"]     = nil,
                                             ["Beast"]     = nil }
    bigReliquaryZoneGuid                 = "1d11fc"
    bigReliquaryZone                     = nil
    -- Used for Clockwork Prince components.
    clockworkPrinceBagGuid               = "05ca8d"

    -- Since Tabletop Simulator reserves the black color, "Brown" represents the black player mat and pieces.
    playerColors                         = { "Purple", "Red", "Brown", "Blue", "Yellow", "White" }

    -- Codes corresponding to various oaths and the conspiracy card.
    oathCodes                            = { ["Supremacy"]    = 0,
                                             ["People"]       = 1,
                                             ["Devotion"]     = 2,
                                             ["Protection"]   = 3,
                                             ["Conspiracy"]   = 4 }
    oathNamesFromCode                    = { [0] = "Supremacy",
                                             [1] = "People",
                                             [2] = "Devotion",
                                             [3] = "Protection",
                                             [4] = "Conspiracy" }
    fullOathNames                        = { ["Supremacy"]    = "Oath of Supremacy",
                                             ["People"]       = "Oath of the People",
                                             ["Devotion"]     = "Oath of Devotion",
                                             ["Protection"]   = "Oath of Protection",
                                             ["Conspiracy"]   = "Conspiracy" }
    oathDescriptions                     = { ["Supremacy"]    = "Rules the most sites",
                                             ["People"]       = "Holds the People's Favor",
                                             ["Devotion"]     = "Holds the Darkest Secret",
                                             ["Protection"]   = "Holds the most relics",
                                             ["Conspiracy"]   = "Conspiracy" }
    -- Used for oath selection GUI panels.
    selectOathOffsets                    = { ["Supremacy"]    = "-332 -57",
                                             ["People"]       = "-110 -57",
                                             ["Devotion"]     = "110 -57",
                                             ["Protection"]   = "330 -57" }

    -- Codes corresponding to various suits.
    suitCodes                            = { ["Discord"] = 0, ["Hearth"] = 1, ["Nomad"] = 2, ["Arcane"] = 3, ["Order"] = 4, ["Beast"] = 5 }
    -- Suit names are in order of the chronicle rotation.
    suitNames                            = { "Discord", "Arcane", "Order", "Hearth", "Beast", "Nomad" }
    -- Next suit for each suit in the chronicle rotation.
    chronicleNextSuits                   = { ["Discord"]      = "Arcane",
                                             ["Arcane"]       = "Order",
                                             ["Order"]        = "Hearth",
                                             ["Hearth"]       = "Beast",
                                             ["Beast"]        = "Nomad",
                                             ["Nomad"]        = "Discord" }
    bagJSON = {
        Name = "Bag",
        Transform = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.0,
            rotX = 0.0,
            rotY = 0.0,
            rotZ = 0.0,
            scaleX = 1.0,
            scaleY = 1.0,
            scaleZ = 1.0
        },
        Nickname = "",
        Description = "",
        ColorDiffuse = {
            r = 0.0,
            g = 1.0,
            b = 0.0
        },
        Locked = true,
        Grid = false,
        Snap = false,
        Autoraise = true,
        Sticky = false,
        Tooltip = true,
        MaterialIndex = -1,
        MeshIndex = -1,
        LuaScripts = "",
        LuaScriptState = "",
        -- ContainedObjects will be updated with cards before the bag is spawned.
        ContainedObjects = nil,
        -- Note that if there is a conflict, the GUID will automatically be updated when the bag spawns.
        GUID = "777777"
    }

    --
    -- Game state variables.
    --

    if ((nil ~= save_state) and ("" ~= save_state)) then
    initState = JSON.decode(save_state)
    --
    -- Since a save state is being loaded that had data, use it to initialize state variables.
    --

    -- This indicates whether a game is in progress.
    isGameInProgress                     = initState.isGameInProgress
    -- This indicates whether manual control is enabled.
    if (nil ~= initState.isManualControlEnabled) then
    isManualControlEnabled               = initState.isManualControlEnabled
    else
    isManualControlEnabled               = false
    end
    -- This indicates whether the Clockwork Prince is enabled.
    if (nil ~= initState.isClockworkPrinceEnabled) then
    isClockworkPrinceEnabled           = initState.isClockworkPrinceEnabled
    else
    isClockworkPrinceEnabled           = false
    end
    -- This string represents the encoded chronicle state.
    chronicleStateString                 = initState.chronicleStateString
    -- This string represents encoded ingame state, used for midgame saves.
    ingameStateString                    = initState.ingameStateString
    -- This value increases as more games are played in a chronicle.
    curGameCount                         = initState.curGameCount
    -- Name of the current chronicle.
    curChronicleName                     = initState.curChronicleName
    -- Number of players in the current game.  Only valid if the game is in progress.
    curGameNumPlayers                    = initState.curGameNumPlayers
    -- Records whether the dispossessed bag is spawned.
    if (nil ~= initState.isDispossessedSpawned) then
    isDispossessedSpawned              = initState.isDispossessedSpawned
    else
    isDispossessedSpawned              = false
    end
    -- Records the GUID of the dispossessed bag.
    if (nil ~= initState.dispossessedBagGuid) then
    dispossessedBagGuid                = initState.dispossessedBagGuid
    else
    dispossessedBagGuid                = nil
    end
    -- This is a silly name, but it just means the winning color from the previous game.
    if (nil ~= initState.curPreviousWinningColor) then
    curPreviousWinningColor            = initState.curPreviousWinningColor
    else
    curPreviousWinningColor            = "Purple"
    end
    -- This is a silly name, but it just means the winning Steam name from the previous game.
    if (nil ~= initState.curPreviousWinningSteamName) then
    curPreviousWinningSteamName        = initState.curPreviousWinningSteamName
    else
    curPreviousWinningSteamName        = "UNKNOWN"
    end
    -- This tracks the start player status of the current game.
    if (nil ~= initState.curStartPlayerStatus) then
    curStartPlayerStatus               = { ["Purple"] = initState.curStartPlayerStatus["Purple"],
    ["Red"]    = initState.curStartPlayerStatus["Red"],
    ["Brown"]  = initState.curStartPlayerStatus["Brown"],
    ["Blue"]   = initState.curStartPlayerStatus["Blue"],
    ["Yellow"] = initState.curStartPlayerStatus["Yellow"],
    ["White"]  = initState.curStartPlayerStatus["White"] }
    else
    curStartPlayerStatus               = { ["Purple"] = "Chancellor",
    ["Red"]    = "Exile",
    ["Brown"]  = "Exile",
    ["Blue"]   = "Exile",
    ["Yellow"] = "Exile",
    ["White"]  = "Exile" }
    end
    -- This is a silly name, but it just means the previous player active status of last game.
    if (nil ~= initState.curPreviousPlayersActive) then
    curPreviousPlayersActive           = { ["Clock"]  = initState.curPreviousPlayersActive["Clock"],
    ["Purple"] = initState.curPreviousPlayersActive["Purple"],
    ["Red"]    = initState.curPreviousPlayersActive["Red"],
    ["Brown"]  = initState.curPreviousPlayersActive["Brown"],
    ["Blue"]   = initState.curPreviousPlayersActive["Blue"],
    ["Yellow"] = initState.curPreviousPlayersActive["Yellow"],
    ["White"]  = initState.curPreviousPlayersActive["White"] }
    else
    curPreviousPlayersActive           = { ["Clock"]  = false,
    ["Purple"] = true,
    ["Red"]    = true,
    ["Brown"]  = true,
    ["Blue"]   = true,
    ["Yellow"] = true,
    ["White"]  = true }
    end
    -- This is a silly name, but it just means the starting player status of last game.
    if (nil ~= initState.curPreviousPlayerStatus) then
    curPreviousPlayerStatus            = { ["Purple"] = initState.curPreviousPlayerStatus["Purple"],
    ["Red"]    = initState.curPreviousPlayerStatus["Red"],
    ["Brown"]  = initState.curPreviousPlayerStatus["Brown"],
    ["Blue"]   = initState.curPreviousPlayerStatus["Blue"],
    ["Yellow"] = initState.curPreviousPlayerStatus["Yellow"],
    ["White"]  = initState.curPreviousPlayerStatus["White"] }
    else
    curPreviousPlayerStatus            = { ["Purple"] = "Chancellor",
    ["Red"]    = "Exile",
    ["Brown"]  = "Exile",
    ["Blue"]   = "Exile",
    ["Yellow"] = "Exile",
    ["White"]  = "Exile" }
    end
    -- Player status can be { "Chancellor", true } for Purple and { "Citizen" / "Exile", true / false }  for all other colors.
    -- The boolean indicates whether the player is active, and only matters if a game is in progress.
    curPlayerStatus                    = { ["Purple"] = { initState.curPlayerStatus["Purple"][1], initState.curPlayerStatus["Purple"][2] },
    ["Red"]    = { initState.curPlayerStatus["Red"][1], initState.curPlayerStatus["Red"][2] } ,
    ["Brown"]  = { initState.curPlayerStatus["Brown"][1], initState.curPlayerStatus["Brown"][2] },
    ["Blue"]   = { initState.curPlayerStatus["Blue"][1], initState.curPlayerStatus["Blue"][2] },
    ["Yellow"] = { initState.curPlayerStatus["Yellow"][1], initState.curPlayerStatus["Yellow"][2] },
    ["White"]  = { initState.curPlayerStatus["White"][1], initState.curPlayerStatus["White"][2] } }

    curFavorValues = {}
    for curSuitName,curSuitCode in pairs(suitCodes) do
    if (nil ~= initState.curFavorValues) then
    curFavorValues[curSuitName] = initState.curFavorValues[curSuitName]
    else
    curFavorValues[curSuitName] = 0
    end
    end

    curOath                            = initState.curOath

    curSuitOrder                       = { initState.curSuitOrder[1],
    initState.curSuitOrder[2],
    initState.curSuitOrder[3],
    initState.curSuitOrder[4],
    initState.curSuitOrder[5],
    initState.curSuitOrder[6] }

    curMapSites = {}
    curMapNormalCards = {}
    for siteIndex = 1,8 do
    -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
    curMapSites[siteIndex]           = { initState.curMapSites[siteIndex][1], initState.curMapSites[siteIndex][2] }
    curMapNormalCards[siteIndex]     = {}

    -- This structure contains the name of each card and whether that card is flipped.
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex] = { initState.curMapNormalCards[siteIndex][normalCardIndex][1],
    initState.curMapNormalCards[siteIndex][normalCardIndex][2] }
    end
    end

    curWorldDeckCardCount              = initState.curWorldDeckCardCount
    curWorldDeckCards                  = {}
    for cardIndex = 1,curWorldDeckCardCount do
    curWorldDeckCards[cardIndex]     = initState.curWorldDeckCards[cardIndex]
    end

    curDispossessedDeckCardCount       = initState.curDispossessedDeckCardCount
    curDispossessedDeckCards           = {}
    for cardIndex = 1,curDispossessedDeckCardCount do
    curDispossessedDeckCards[cardIndex] = initState.curDispossessedDeckCards[cardIndex]
    end

    curRelicDeckCardCount              = initState.curRelicDeckCardCount
    curRelicDeckCards                  = {}

    if ((nil ~= curRelicDeckCardCount) and
    (curRelicDeckCardCount > 0)    and
    (nil ~= initState.curRelicDeckCards))      then
    for cardIndex = 1,curRelicDeckCardCount do
    curRelicDeckCards[cardIndex]     = initState.curRelicDeckCards[cardIndex]
    end
    else
    curRelicDeckCardCount = 0
    end

    favorBag = getObjectFromGUID(favorBagGuid)
    if (nil == favorBag) then
    printToAll("Error finding favor bag.", {1,0,0})
    end

    --
    -- Variables used while saving.  None of these need loaded from a TTS save state.
    --

    saveStatus                         = STATUS_SUCCESS

    --
    -- Variables used while loading a save string.  None of these need loaded from a TTS save state since they will be overwritten.
    --

    loadStatus                         = STATUS_SUCCESS
    loadGameCount                      = 1
    loadChronicleName                  = "Empire and Exile"
    loadPreviousWinningColor           = "Purple"
    loadPreviousWinningSteamName       = "UNKNOWN"
    loadPreviousPlayersActive          = { ["Clock"]  = false,
    ["Purple"] = true,
    ["Red"]    = true,
    ["Brown"]  = true,
    ["Blue"]   = true,
    ["Yellow"] = true,
    ["White"]  = true }
    loadPreviousPlayerStatus           = { ["Purple"] = "Chancellor",
    ["Red"]    = "Exile",
    ["Brown"]  = "Exile",
    ["Blue"]   = "Exile",
    ["Yellow"] = "Exile",
    ["White"]  = "Exile" }
    loadPlayerStatus                   = { ["Purple"] = { "Chancellor", true },
    ["Red"]    = { "Exile", true },
    ["Brown"]  = { "Exile", true },
    ["Blue"]   = { "Exile", true },
    ["Yellow"] = { "Exile", true },
    ["White"]  = { "Exile", true } }
    loadCurOath                        = "Supremacy"
    loadSuitOrder                      = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }
    loadMapSites                       = { { "NONE", false },
    { "NONE", false },
    { "NONE", false },
    { "NONE", false },
    { "NONE", false },
    { "NONE", false },
    { "NONE", false },
    { "NONE", false } }
    -- This structure contains the name of each card and whether that card is flipped.
    loadMapNormalCards                 = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } },
    { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
    loadWorldDeckInitCardCount         = 0
    loadWorldDeckInitCards             = {}
    loadDispossessedDeckInitCardCount  = 0
    loadDispossessedDeckInitCards      = {}
    loadRelicDeckInitCardCount         = 0
    loadRelicDeckInitCards             = {}

    loadExpectedSpawnCount             = 0
    loadActualSpawnCount               = 0
    loadWaitID                         = nil
    else -- end if ((nil ~= save_state) and ("" ~= save_state))
    --
    -- No save state is available.  Use default variable values.
    --

    Wait.condition(initDefaultGameState, function() return (true == dataIsAvailable) end)
    end

    --
    -- Variables used during setup or utility operations.  None of these need loaded from a TTS save state.
    --

    -- Used to randomize setup.
    randomEnabled                        = false
    -- Used for buttons.
    playerButtonIndices                  = {}
    spawnDispossessedButtonIndex         = 0
    -- Used during chronicle.
    banditCrownFound                     = false
    banditCrownHoldingColor              = nil
    doesWinnerRule                       = { }
    keepSiteStatus                       = { }
    remainingWorldDeck                   = {}
    cardsAddedToWorldDeck                = {}
    -- Used to confirm certain destructive commands.
    pendingEraseType                     = nil
    pendingDataString                    = ""
    renamingChronicle                    = false
    lastHostChatMessage                  = ""
    isCommandConfirmed                   = false
    -- Used during cleanup.
    isChronicleInProgress                = false
    curChronicleInfoCode                 = nil
    pendingWinningColor                  = nil
    winningColor                         = nil
    pendingOath                          = nil
    usedVision                           = false
    wonBySuccession                      = false
    numBuildRepairOptions                = 0
    selectedBuildRepairIndex             = nil
    selectedBuildRepairCardIndex         = nil
    buildRepairOptions                   = { {},
    {},
    {},
    {},
    {},
    {},
    {},
    {} }
    selectedEdificeIndex                 = 1
    edificeOffsets                       = { "0 0",
    "-327 0",
    "-654 0",
    "0 512",
    "-327 512",
    "-654 512" }
    edificeSaveIDs                       = { 198, 200, 202, 204, 206, 208 }
    numPlayerAdvisers                    = { ["Purple"] = 0,
    ["Red"]    = 0,
    ["Brown"]  = 0,
    ["Blue"]   = 0,
    ["Yellow"] = 0,
    ["White"]  = 0 }
    playerAdvisers                       = { ["Purple"] = {},
    ["Red"]    = {},
    ["Brown"]  = {},
    ["Blue"]   = {},
    ["Yellow"] = {},
    ["White"]  = {} }
    playerAdvisersFacedown               = { ["Purple"] = {},
    ["Red"]    = {},
    ["Brown"]  = {},
    ["Blue"]   = {},
    ["Yellow"] = {},
    ["White"]  = {} }
    -- In sequence, elements refer to Cradle, Provinces, and Hinterland.
    discardContents                      = { {}, {}, {} }
    adviserSuitOptions                   = nil
    selectedSuit                         = nil
    mostDispossessedSuit                 = nil
    grantPlayerCitizenship               = {}
    grantCitizenshipLocked               = false
    archiveContentsBySuit                = { ["Discord"] = {},
    ["Arcane"]  = {},
    ["Order"]   = {},
    ["Hearth"]  = {},
    ["Beast"]   = {},
    ["Nomad"]   = {} }
    dispossessedContentsBySuit           = { ["Discord"] = {},
    ["Arcane"]  = {},
    ["Order"]   = {},
    ["Hearth"]  = {},
    ["Beast"]   = {},
    ["Nomad"]   = {} }
    -- Note that these are ordered to match the edifice card sheet.
    edificeIndicesBySuit                 = { ["Discord"] = 4,
    ["Arcane"]  = 5,
    ["Order"]   = 1,
    ["Hearth"]  = 2,
    ["Beast"]   = 3,
    ["Nomad"]   = 6 }

    curOathkeeperToken = getObjectFromGUID(oathkeeperTokenGuid)
    -- Lock if hidden.
    if (nil ~= curOathkeeperToken) then
    tokenPosition = curOathkeeperToken.getPosition()
    if (tokenPosition[2] < 0) then
    curOathkeeperToken.locked = true
    curOathkeeperToken.interactable = false
    curOathkeeperToken.tooltip = false
    end
    else
    printToAll("Error, could not find oathkeeper token.", {1,0,0})
    end

    --
    -- Start getting card FAQ JSON file.
    --

    cardFAQTable = nil
    WebRequest.get("http://tts.ledergames.com/Oath/cardfaq/oath.json?t=" .. os.time(), cardFAQRequestCallback)

    --
    -- Make certain elements uninteractable.
    --

    sideBoard = getObjectFromGUID(sideBoardGuid)
    if (nil ~= sideBoard) then
    sideBoard.locked = true
    sideBoard.interactable = false
    sideBoard.tooltip = false
    else
    printToAll("Error finding sideboard.", {1,0,0})
    end

    manualFullDecksBag = getObjectFromGUID(manualFullDecksBagGuid)
    if (nil ~= manualFullDecksBag) then
    manualFullDecksBag.locked = true
    manualFullDecksBag.interactable = false
    manualFullDecksBag.tooltip = false
    else
    printToAll("Error finding manual full decks bag.", {1,0,0})
    end

    belowTableDeck = getObjectFromGUID(belowTableDeckGuid)
    if (belowTableDeck ~= nil) then
    belowTableDeck.locked = true
    belowTableDeck.interactable = false
    belowTableDeck.tooltip = false
    end

    belowTableFavor = getObjectFromGUID(belowTableFavorGuid)
    if (belowTableFavor ~= nil) then
    belowTableFavor.locked = true
    belowTableFavor.interactable = false
    belowTableFavor.tooltip = false
    end

    belowTableSecret = getObjectFromGUID(belowTableSecretGuid)
    if (belowTableSecret ~= nil) then
    belowTableSecret.locked = true
    belowTableSecret.interactable = false
    belowTableSecret.tooltip = false
    end

    mapPart = getObjectFromGUID(mapGuids[1])
    if (mapPart ~= nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
    end

    mapPart = getObjectFromGUID(mapGuids[2])
    if (mapPart ~= nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
    end

    mapPart = getObjectFromGUID(mapGuids[3])
    if (mapPart ~= nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
    end

    gameDataObject = getObjectFromGUID(gameDataObjectGuid)
    if (gameDataObject ~= nil) then
    gameDataObject.locked = true
    gameDataObject.interactable = false
    gameDataObject.tooltip = false
    --local tempPosition = gameDataObject.getPosition()
    --printToAll("Previous Y position " .. tempPosition.y, {1,1,1})
    --tempPosition.y = 3.05
    --gameDataObject.setPosition(tempPosition)
    end


    -- Get scripting zones.

    for siteIndex = 1,8 do
    mapSiteCardZones[siteIndex] = getObjectFromGUID(siteCardZoneGuids[siteIndex])
    if (nil == mapSiteCardZones[siteIndex]) then
    printToAll("Error loading zone.", {1,0,0})
    end

    for subIndex = 1,3 do
    mapNormalCardZones[siteIndex][subIndex] = getObjectFromGUID(mapNormalCardZoneGuids[siteIndex][subIndex])
    if (nil == mapNormalCardZones[siteIndex][subIndex]) then
    printToAll("Error loading zone.", {1,0,0})
    end
    end
    end

    worldDeckZone = getObjectFromGUID(worldDeckZoneGuid)
    if (nil == worldDeckZone) then
    printToAll("Error loading zone.", {1,0,0})
    end

    for discardPileIndex = 1,3 do
    discardZones[discardPileIndex] = getObjectFromGUID(discardZoneGuids[discardPileIndex])
    if (nil == discardZones[discardPileIndex]) then
    printToAll("Error loading zone.", {1,0,0})
    end
    end

    for loopOathName,loopOathCode in pairs(oathCodes) do
    if (nil ~= oathReminderTokenGuids[loopOathName]) then
    oathReminderTokens[loopOathName] = getObjectFromGUID(oathReminderTokenGuids[loopOathName])

    -- Lock if hidden.
    if (nil ~= oathReminderTokens[loopOathName]) then
    tokenPosition = oathReminderTokens[loopOathName].getPosition()
    if (tokenPosition[2] < 0) then
    oathReminderTokens[loopOathName].locked = true
    oathReminderTokens[loopOathName].interactable = false
    oathReminderTokens[loopOathName].tooltip = false
    end
    else
    printToAll("Error finding oath reminder token.", {1,0,0})
    end
    end
    end

    reliquary = getObjectFromGUID(reliquaryGuid)
    -- Lock if hidden.
    if (nil ~= reliquary) then
    tokenPosition = reliquary.getPosition()
    if (tokenPosition[2] < 0) then
    reliquary.locked = true
    reliquary.interactable = false
    reliquary.tooltip = false
    end
    else
    printToAll("Error finding reliquary.", {1,0,0})
    end

    peoplesFavor = getObjectFromGUID(peoplesFavorGuid)
    -- Lock if hidden.
    if (nil ~= peoplesFavor) then
    tokenPosition = peoplesFavor.getPosition()
    if (tokenPosition[2] < 0) then
    peoplesFavor.locked = true
    peoplesFavor.interactable = false
    peoplesFavor.tooltip = false
    end
    else
    printToAll("Error finding People's Favor.", {1,0,0})
    end

    darkestSecret = getObjectFromGUID(darkestSecretGuid)
    -- Lock if hidden.
    if (nil ~= darkestSecret) then
    tokenPosition = darkestSecret.getPosition()
    if (tokenPosition[2] < 0) then
    darkestSecret.locked = true
    darkestSecret.interactable = false
    darkestSecret.tooltip = false
    end
    else
    printToAll("Error finding Darkest Secret.", {1,0,0})
    end

    for i,curColor in ipairs(playerColors) do
    playerBoards[curColor] = getObjectFromGUID(playerBoardGuids[curColor])
    if (nil == playerBoards[curColor]) then
    printToAll("Error finding player board.", {1,0,0})
    end

    playerWarbandBags[curColor] = getObjectFromGUID(playerWarbandBagGuids[curColor])
    if (nil == playerWarbandBags[curColor]) then
    printToAll("Error finding player warband bag.", {1,0,0})
    end

    playerPawns[curColor] = getObjectFromGUID(playerPawnGuids[curColor])
    if (nil == playerPawns[curColor]) then
    printToAll("Error finding player pawn.", {1,0,0})
    end

    playerSupplyMarkers[curColor] = getObjectFromGUID(playerSupplyMarkerGuids[curColor])
    if (nil == playerSupplyMarkers[curColor]) then
    printToAll("Error finding player pawn.", {1,0,0})
    end

    for subIndex = 1,3 do
    playerAdviserZones[curColor][subIndex] = getObjectFromGUID(playerAdviserZoneGuids[curColor][subIndex])
    if (nil == playerAdviserZones[curColor][subIndex]) then
    printToAll("Error loading zone.", {1,0,0})
    end
    end
    end

    for curSuitName,curSuitCode in pairs(suitCodes) do
    suitFavorZones[curSuitName] = getObjectFromGUID(suitFavorZoneGuids[curSuitName])
    if (nil == suitFavorZones[curSuitName]) then
    printToAll("Error loading zone.", {1,0,0})
    end
    end

    bigReliquaryZone = getObjectFromGUID(bigReliquaryZoneGuid)
    if (nil == bigReliquaryZone) then
    printToAll("Error loading zone.", {1,0,0})
    end


    -- Force hand zones to the correct height, since a TTS bug means that hand zones will keep lowering with load/save cycles.

    for i,curColor in ipairs(playerColors) do
    local handTransform = Player[curColor].getHandTransform()
    handTransform.position.y = 1.05
    Player[curColor].setHandTransform(handTransform)
    end

    -- Mute bags so cleanup is not loud.

    setWarbandBagsMuted(true)

    -- Wait until the data script loads.
    loadingFinished = false
    Wait.condition(finishOnLoad, function() return (true == dataIsAvailable) end)
    -- As a sanity check, in case the wait condition does not trigger for some reason, set a timer.
end

function cardFAQRequestCallback(webRequestInfo)
    local asciiJSON = nil

    if (true == webRequestInfo.is_done) then
        asciiJSON = webRequestInfo.text
        -- Decode Unicode.
        asciiJSON = string.gsub(asciiJSON, '\\u2019', '\'')
        asciiJSON = string.gsub(asciiJSON, '\\u201c', '\\"')
        asciiJSON = string.gsub(asciiJSON, '\\u201d', '\\"')
        asciiJSON = string.gsub(asciiJSON, '\\u2014', '--')
        asciiJSON = string.gsub(asciiJSON, '%$link:', '')
        asciiJSON = string.gsub(asciiJSON, '%$rule:', 'Rule ')
        asciiJSON = string.gsub(asciiJSON, '%$', '')
        cardFAQTable = JSON.decode(asciiJSON)
        if (nil ~= cardFAQTable) then
    printToAll("Downloaded card FAQ data for " .. #cardFAQTable .. " cards.", {0,0.8,0})
    end

    -- Make sure card data is available before continuning.
    Wait.condition(updateCardsWithFAQ, function() return (true == dataIsAvailable) end)
    elseif (true == webRequestInfo.is_error) then
        printToAll("Error downloading card FAQ.", {1,0,0})
        cardFAQJSON = nil
        cardFAQTable = nil
    else
        -- Nothing needs done, still getting card FAQ.
    end
end

-- This function is called once data is available from data.ttslua.
function finishOnLoad()
    if (false == loadingFinished) then
        loadingFinished = true

        -- Print welcome message.
        printToAll("", {1,1,1})
        printToAll("===========================================", {1,1,1})
        printToAll("Welcome to the official Oath mod.", {1,1,1})
        printToAll("", {1,1,1})
        printToAll("Mod version " .. OATH_MOD_VERSION, {1,1,1})
        printToAll("",{1,1,1})
        printToAll("Type \"!help\" in chat for a command list.",{1,1,1})
        printToAll("===========================================", {1,1,1})
        printToAll("", {1,1,1})

        -- Display a message and create general buttons.
        if (true == isGameInProgress) then
            if (false == isManualControlEnabled) then
                printToAll("This save contains the in-progress game #" .. curGameCount .. " of the chronicle \"" .. curChronicleName .. "\".", {0,0.8,0})
            end

            if (true == isClockworkPrinceEnabled) then
                printToAll("The Clockwork Prince is enabled.", {0,0.8,0})
            end

            if (true == isManualControlEnabled) then
                printToAll("Full manual control is enabled.", {0,0.8,0})
            end

            configGeneralButtons(BUTTONS_IN_GAME)
        else
            printToAll("This save is ready for game #" .. curGameCount .. " of the chronicle \"" .. curChronicleName .. "\".", {0,0.8,0})

            configGeneralButtons(BUTTONS_NOT_IN_GAME)
        end
        printToAll("", {1,1,1})
    end -- end if (false == loadingFinished)
end

function onSave()
    local saveDataTable = {}

    saveDataTable.isGameInProgress          = isGameInProgress
    saveDataTable.isManualControlEnabled    = isManualControlEnabled
    saveDataTable.isClockworkPrinceEnabled  = isClockworkPrinceEnabled
    saveDataTable.chronicleStateString      = chronicleStateString
    if ((true == isGameInProgress) and (false == isManualControlEnabled)) then
        scanTable(false)
        saveDataTable.ingameStateString    = generateSaveString()
        if (nil == saveDataTable.ingameStateString) then
            saveDataTable.ingameStateString  = ""
        end
    else
        saveDataTable.ingameStateString  = ""
    end
    saveDataTable.curGameCount           = curGameCount
    saveDataTable.curChronicleName       = curChronicleName
    saveDataTable.curGameNumPlayers      = curGameNumPlayers
    saveDataTable.isDispossessedSpawned  = isDispossessedSpawned
    saveDataTable.dispossessedBagGuid    = dispossessedBagGuid
    saveDataTable.curStartPlayerStatus      = { ["Purple"] = curStartPlayerStatus["Purple"],
                                                ["Red"]    = curStartPlayerStatus["Red"],
                                                ["Brown"]  = curStartPlayerStatus["Brown"],
                                                ["Blue"]   = curStartPlayerStatus["Blue"],
                                                ["Yellow"] = curStartPlayerStatus["Yellow"],
                                                ["White"]  = curStartPlayerStatus["White"] }
    saveDataTable.curPreviousPlayersActive  = { ["Clock"]  = curPreviousPlayersActive["Clock"],
                                                ["Purple"] = curPreviousPlayersActive["Purple"],
                                                ["Red"]    = curPreviousPlayersActive["Red"],
                                                ["Brown"]  = curPreviousPlayersActive["Brown"],
                                                ["Blue"]   = curPreviousPlayersActive["Blue"],
                                                ["Yellow"] = curPreviousPlayersActive["Yellow"],
                                                ["White"]  = curPreviousPlayersActive["White"] }
    saveDataTable.curPreviousPlayerStatus   = { ["Purple"] = curPreviousPlayerStatus["Purple"],
                                                ["Red"]    = curPreviousPlayerStatus["Red"],
                                                ["Brown"]  = curPreviousPlayerStatus["Brown"],
                                                ["Blue"]   = curPreviousPlayerStatus["Blue"],
                                                ["Yellow"] = curPreviousPlayerStatus["Yellow"],
                                                ["White"]  = curPreviousPlayerStatus["White"] }
    saveDataTable.curPlayerStatus        = { ["Purple"] = { curPlayerStatus["Purple"][1], curPlayerStatus["Purple"][2] },
                                             ["Red"]    = { curPlayerStatus["Red"][1], curPlayerStatus["Red"][2] },
                                             ["Brown"]  = { curPlayerStatus["Brown"][1], curPlayerStatus["Brown"][2] },
                                             ["Blue"]   = { curPlayerStatus["Blue"][1], curPlayerStatus["Blue"][2] },
                                             ["Yellow"] = { curPlayerStatus["Yellow"][1], curPlayerStatus["Yellow"][2] },
                                             ["White"]  = { curPlayerStatus["White"][1], curPlayerStatus["White"][2] } }

    saveDataTable.curFavorValues = {}
    for curSuitName,curSuitCode in pairs(suitCodes) do
        saveDataTable.curFavorValues[curSuitName] = curFavorValues[curSuitName]
    end

    saveDataTable.curOath                = curOath

    saveDataTable.curSuitOrder           = { curSuitOrder[1],
                                             curSuitOrder[2],
                                             curSuitOrder[3],
                                             curSuitOrder[4],
                                             curSuitOrder[5],
                                             curSuitOrder[6] }

    saveDataTable.curMapSites = {}
    saveDataTable.curMapNormalCards = {}
    for siteIndex = 1,8 do
        -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
        saveDataTable.curMapSites[siteIndex] = { curMapSites[siteIndex][1], curMapSites[siteIndex][2] }
        saveDataTable.curMapNormalCards[siteIndex]  = {}

        -- This structure contains the name of each card and whether that card is flipped.
        for normalCardIndex = 1,3 do
            saveDataTable.curMapNormalCards[siteIndex][normalCardIndex] = { curMapNormalCards[siteIndex][normalCardIndex][1],
                                                                            curMapNormalCards[siteIndex][normalCardIndex][2] }
        end
    end

    saveDataTable.curWorldDeckCardCount              = curWorldDeckCardCount
    saveDataTable.curWorldDeckCards                  = {}
    for cardIndex = 1,curWorldDeckCardCount do
        saveDataTable.curWorldDeckCards[cardIndex]     = curWorldDeckCards[cardIndex]
    end

    saveDataTable.curDispossessedDeckCardCount       = curDispossessedDeckCardCount
    saveDataTable.curDispossessedDeckCards           = {}
    for cardIndex = 1,curDispossessedDeckCardCount do
        saveDataTable.curDispossessedDeckCards[cardIndex] = curDispossessedDeckCards[cardIndex]
    end

    saveDataTable.curRelicDeckCardCount              = curRelicDeckCardCount
    saveDataTable.curRelicDeckCards                  = {}
    for cardIndex = 1,curRelicDeckCardCount do
        saveDataTable.curRelicDeckCards[cardIndex]     = curRelicDeckCards[cardIndex]
    end

    return JSON.encode(saveDataTable)
end

function onObjectDrop(playerColor, droppedObject)
    -- For performance reasons, only scan if a favor token is dropped.
    if ("Favor" == string.sub(droppedObject.getName(), 1, 5)) then
        -- Reset the name in case it is not in a suit favor zone.  If it is in a zone, this will be overwritten.
        droppedObject.setName("Favor")

        for suitName,curZone in pairs(suitFavorZones) do
            rescanFavorZone(curZone, suitName)
        end
    end
end

function rescanFavorZone(scanZone, suitName)
    local scriptZoneObjects = scanZone.getObjects()
    local newFavorValue = 0

    -- Count favor in the zone.
    for i,curObject in ipairs(scriptZoneObjects) do
        if ("Favor" == string.sub(curObject.getName(), 1, 5)) then
            newFavorValue = (newFavorValue + 1)
        end
    end

    -- Update names for favor in the zone.
    for i,curObject in ipairs(scriptZoneObjects) do
        if ("Favor" == string.sub(curObject.getName(), 1, 5)) then
            curObject.setName("Favor (" .. newFavorValue .. " " .. suitName .. ")")
        end
    end

    curFavorValues[suitName] = newFavorValue
end

-- This function is called once data is available from data.ttslua.
function updateCardsWithFAQ()
    local curQ = nil
    local curA = nil
    local curCardName = nil
    local curFAQText = ""

    for i,curEntry in ipairs(cardFAQTable) do
        curCardName = curEntry.card
        curFAQText = ""

        for i,curFAQ in ipairs(curEntry.faq) do
            curQ = curFAQ.q
            curA = curFAQ.a

            if ((nil ~= curQ) and (nil ~= curA)) then
        curFAQText = (curFAQText .. "Q:  " .. curQ .. "\nA:  " .. curA .. "\n\n")
            end
        end

        -- Translate certain FAQ strings to the corresponding TTS card name.
        if (nil ~= translateNameFromFAQ[curCardName]) then
    curCardName = translateNameFromFAQ[curCardName]
    end

    if (nil ~= cardsTable[curCardName]) then
    if (nil ~= curFAQText) then
    cardsTable[curCardName].faqText = curFAQText
    end
    else
    printToAll("Found FAQ entry for unknown card \"" .. curCardName .. "\".", {1,0,0})
        end
    end
end

function initDefaultGameState()
    -- This indicates whether a game is in progress.
    isGameInProgress                     = false
    -- This indicates whether manual control is enabled.
    isManualControlEnabled               = false
    -- This indicates whether the Clockwork Prince is enabled.
    isClockworkPrinceEnabled             = false
    -- This string represents the encoded chronicle state.
    chronicleStateString                 = RESET_CHRONICLE_STATE_STRING
    -- This string represents encoded ingame state, used for midgame saves.
    ingameStateString                    = ""
    -- This value increases as more games are played in a chronicle.
    curGameCount                         = 1
    -- Name of the current chronicle.
    curChronicleName                     = "Empire and Exile"
    -- Number of players in the current game.  Only valid if the game is in progress.
    curGameNumPlayers                    = 1
    -- Records whether the dispossessed bag is spawned.
    isDispossessedSpawned                = false
    -- Records the GUID of the dispossessed bag.
    dispossessedBagGuid                  = nil
    -- This is a silly name, but it just means the winning color from the previous game.
    curPreviousWinningColor              = "Purple"
    -- This is a silly name, but it just means the winning Steam name from the previous game.
    curPreviousWinningSteamName          = "UNKNOWN"
    -- Player status can be "Chancellor" for Purple and "Citizen" / "Exile" for all other colors.
    curStartPlayerStatus                 = { ["Purple"] = "Chancellor",
                                             ["Red"]    = "Exile",
                                             ["Brown"]  = "Exile",
                                             ["Blue"]   = "Exile",
                                             ["Yellow"] = "Exile",
                                             ["White"]  = "Exile" }
    -- Player active status can be true or false.  The Purple status is always active, and the Clock status is only active if the Clockwork Prince was in play.
    curPreviousPlayersActive             = { ["Clock"]  = false,
                                             ["Purple"] = true,
                                             ["Red"]    = true,
                                             ["Brown"]  = true,
                                             ["Blue"]   = true,
                                             ["Yellow"] = true,
                                             ["White"]  = true }
    -- Player status can be "Chancellor" for Purple and "Citizen" / "Exile" for all other colors.
    curPreviousPlayerStatus              = { ["Purple"] = "Chancellor",
                                             ["Red"]    = "Exile",
                                             ["Brown"]  = "Exile",
                                             ["Blue"]   = "Exile",
                                             ["Yellow"] = "Exile",
                                             ["White"]  = "Exile" }
    -- Player status can be { "Chancellor", true } for Purple and { "Citizen" / "Exile", true / false }  for all other colors.
    -- The boolean indicates whether the player is active, and only matters if a game is in progress.
    curPlayerStatus                      = { ["Purple"] = { "Chancellor", true },
                                             ["Red"]    = { "Exile", true },
                                             ["Brown"]  = { "Exile", true },
                                             ["Blue"]   = { "Exile", true },
                                             ["Yellow"] = { "Exile", true },
                                             ["White"]  = { "Exile", true } }

    curFavorValues = {}
    for curSuitName,curSuitCode in pairs(suitCodes) do
        curFavorValues[curSuitName] = 0
    end

    curOath                              = "Supremacy"

    curSuitOrder                         = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }

    -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
    -- The boolean value indicates whether that card is facedown.
    curMapSites                          = { { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false } }
    -- This structure contains the name of each card and whether that card is facedown.
    curMapNormalCards                    = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
    curDispossessedDeckCardCount         = 0
    curDispossessedDeckCards             = {}

    curWorldDeckCardCount = 0
    curWorldDeckCards = {}
    generateRandomWorldDeck({}, 0, 0)

    curRelicDeckCardCount = 0
    curRelicDeckCards = {}
    generateRandomRelicDeck()

    --
    -- Variables used while saving.  None of these need loaded from a TTS save state.
    --

    saveStatus                           = STATUS_SUCCESS

    --
    -- Variables used while loading a save string.
    --

    loadStatus                           = STATUS_SUCCESS
    loadGameCount                        = 1
    loadChronicleName                    = "Empire and Exile"
    loadPreviousPlayersActive            = { ["Clock"]  = false,
                                             ["Purple"] = true,
                                             ["Red"]    = true,
                                             ["Brown"]  = true,
                                             ["Blue"]   = true,
                                             ["Yellow"] = true,
                                             ["White"]  = true }
    loadPreviousPlayerStatus             = { ["Purple"] = "Chancellor",
                                             ["Red"]    = "Exile",
                                             ["Brown"]  = "Exile",
                                             ["Blue"]   = "Exile",
                                             ["Yellow"] = "Exile",
                                             ["White"]  = "Exile" }
    loadPlayerStatus                     = { ["Purple"] = { "Chancellor", true },
                                             ["Red"]    = { "Exile", true },
                                             ["Brown"]  = { "Exile", true },
                                             ["Blue"]   = { "Exile", true },
                                             ["Yellow"] = { "Exile", true },
                                             ["White"]  = { "Exile", true } }
    loadCurOath                          = "Supremacy"
    loadSuitOrder                        = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }
    loadMapSites                         = { { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false },
                                             { "NONE", false } }
    -- This structure contains the name of each card and whether that card is flipped.
    loadMapNormalCards                   = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                             { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
    loadWorldDeckInitCardCount           = 0
    loadWorldDeckInitCards               = {}
    loadDispossessedDeckInitCardCount    = 0
    loadDispossessedDeckInitCards        = {}
    loadRelicDeckInitCardCount           = 0
    loadRelicDeckInitCards               = {}

    loadExpectedSpawnCount               = 0
    loadActualSpawnCount                 = 0

    if (nil ~= loadWaitID) then
    stop(loadWaitID)
    loadWaitID = nil
    end

    loadWaitID                           = nil
end

function onChat(message, chatPlayer)
    local saveString = nil
    local oathCode = nil
    local spawnCardName = nil
    local displayString = nil

    if ("!help" == string.sub(message, 1, 5)) then
        -- Note that the chat font is not necessarily fixed-width, so alignment is done manually.
        printToColor("", chatPlayer.color, {1,1,1})
        printToColor("Chat commands for all players:", chatPlayer.color, {1,1,1})
        printToColor("!help                                                Print this message.", chatPlayer.color, {1,1,1})
        printToColor("!pilgrimage                                     Spawn 3 random site cards in hand.", chatPlayer.color, {1,1,1})
        printToColor("", chatPlayer.color, {1,1,1})
        printToColor("Chat commands only usable by the host:", chatPlayer.color, {1,1,1})
        printToColor("===========================================", chatPlayer.color, {1,1,1})
        printToColor("!card <Card Name>                        Spawn card in hand.", chatPlayer.color, {1,1,1})
        printToColor("!name                                              Display or change chronicle name.", chatPlayer.color, {1,1,1})
        printToColor("!reset_chronicle                             Fully resets the chronicle.", chatPlayer.color, {1,1,1})
        printToColor("!stats                                               Show chronicle stats.", chatPlayer.color, {1,1,1})

        printToColor("", chatPlayer.color, {1,1,1})
        printToColor("", chatPlayer.color, {1,1,1})
    elseif ("!pilgrimage" == string.sub(message, 1, 11)) then
        runPilgrimageCommand(chatPlayer)
    else
        --
        -- Begin processing other commands.
        --

        -- Only process these commands for the host.
        if (true == chatPlayer.host) then
            -- If the host repeats a command, treat it as confirmation.
            if (message == lastHostChatMessage) then
                isCommandConfirmed = true
                -- Reset the last message so that typing a command 3 times does not count as 2 confirmations.
                lastHostChatMessage = ""
            else
                isCommandConfirmed = false
                -- Save the host chat message for possible future command confirmation.
                lastHostChatMessage = message
            end

            if ("!card" == string.sub(message, 1, 5)) then
                spawnCardName = string.sub(message, 7)
                if (nil ~= cardsTable[spawnCardName]) then
            -- Spawn into the middle of the player's hand zone.
            spawnSingleCard(spawnCardName, false, handCardSpawnPositions[chatPlayer.color][2], handCardYRotations[chatPlayer.color], true)
            else
            printToAll("Unknown card.  Capitalization and spacing matter. ", {1,0,0})
                end
            elseif ("!stats" == string.sub(message, 1, 16)) then
                showStats()
            elseif ("!show_world_deck" == string.sub(message, 1, 16)) then
                displayString = "World deck:\n"
                for i,curCard in ipairs(curWorldDeckCards) do
                    displayString = displayString .. "\n" .. curCard
                end
                showDataString(displayString)
            elseif ("!show_relic_deck" == string.sub(message, 1, 16)) then
                displayString = "Relic deck:\n"
                for i,curCard in ipairs(curRelicDeckCards) do
                    displayString = displayString .. "\n" .. curCard
                end
                showDataString(displayString)
            elseif ("!show_dispossessed" == string.sub(message, 1, 18)) then
                displayString = "Dispossessed cards:\n"
                for i,curCard in ipairs(curDispossessedDeckCards) do
                    displayString = displayString .. "\n" .. curCard
                end
                showDataString(displayString)
            elseif ("!show_pieces" == string.sub(message, 1, 12)) then
                -- Undocumented command that shows game pieces.

                for i,curColor in ipairs(playerColors) do
                    showPieces(curColor)
                end

                showGeneralPieces()
            elseif ("!hide_pieces" == string.sub(message, 1, 12)) then
                -- Undocumented command that hides game pieces.

                for i,curColor in ipairs(playerColors) do
                    hidePieces(curColor)
                end

                hideGeneralPieces()
            elseif ("!name" == string.sub(message, 1, 5)) then
                showChronicleNameDialog()
            elseif ("!finish_load" == string.sub(message, 1, 12)) then
                printToAll("Attempting to manually finish module load process.", {1,1,1})
                finishOnLoad()
            elseif ("!reset_chronicle" == string.sub(message, 1, 16)) then
                if (false == isGameInProgress) then
                    if (false == isChronicleInProgress) then
                        pendingEraseType = "reset"
                        Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
                    else
                        printToAll("Error, please wait until the Chronicle phase is finished.", {1,0,0})
                    end
                else
                    printToAll("Error, please wait until the game is finished.", {1,0,0})
                end
            elseif ("!" == string.sub(message, 1, 1)) then
                printToAll("Error, unknown command.", {1,0,0})
            else
                -- Not a command.  Nothing needs done.
            end
        end -- end if (true == chatPlayer.host)
    end -- end processing other commands
end

function importChronicleButtonClicked(buttonObject, playerColor, altClick)
    pendingDataString = ""
    renamingChronicle = false

    Global.UI.setAttribute("panel_manual_setup_check", "active", false)
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)

    Global.UI.setAttribute("panel_text_description", "text", "Paste from to the clipboard to\nimport a Chronicle state:\n(click, then press Ctrl-V)")
    Global.UI.setAttribute("panel_text_data", "text", displayString)
    Global.UI.setAttribute("ok_panel_text", "active", false)
    Global.UI.setAttribute("cancel_panel_text", "active", true)
    Global.UI.setAttribute("cancel_panel_text", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("confirm_panel_text", "active", true)
    Global.UI.setAttribute("confirm_panel_text", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("panel_text", "active", true)
end

function exportChronicleButtonClicked(buttonObject, playerColor, altClick)
    scanTable(false)
    saveString = generateSaveString()

    Global.UI.setAttribute("panel_manual_setup_check", "active", false)
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)

    if (nil ~= saveString) then
    showExportString(saveString)
    printToAll("Export successful.", {0,0.8,0})
    else
    printToAll("Export failed.", {1,0,0})
    end

    printToAll("", {1,1,1})
end

function manualSetupButtonClicked(buttonObject, playerColor, altClick)
    if (true == Player[playerColor].host) then
        Global.UI.setAttribute("panel_manual_setup_check", "active", true)
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function editChronicleButtonClicked(buttonObject, playerColor, altClick)
    -- TODO IMPLEMENT after 3.3.2 release
    printToAll("Not yet implemented.", {1,0,0}) -- TODO REMOVE
end

-- This function spawns all denizen, vision, archive, edifice/ruin, site, and relic cards.
function spawnAllDecks()
    -- Wait slightly so the message can print after the command.
    Wait.time(function() spawnAllDecksAfterDelay() end, 0.05)
end

function spawnManualFullDecks(chatPlayer)
    -- Reveal the side board.
    sideBoard.setPosition(sideBoardPosition)
    sideBoard.setScale({ 15.00, 1.00, 15.00 })

    -- Move the camera to look at the side board.
    chatPlayer.lookAt({ position = { 3.06, 1.47, 50.60 },
                        pitch = 70 })

    -- Wait slightly so the message can print after the command.
    Wait.time(function() spawnManualFullDecksB(chatPlayer) end, 0.05)
end

function spawnManualFullDecksB(chatPlayer)
    broadcastToAll("Please wait, spawning decks...", {0,0.8,0})
    Wait.time(function() spawnManualFullDecksAfterDelay(chatPlayer) end, 0.30)
end

function spawnManualFullDecksAfterDelay(chatPlayer)
    -- Note that since this is a bag, getData() is needed rather than getObjects().
    local bagObjects = manualFullDecksBag.getData().ContainedObjects
    local spawnParams = {}

    if (nil ~= bagObjects) then
    for i,curObjectData in ipairs(bagObjects) do
    -- Spawn each item underneath the table so it can be moved up instead of flashing white.
    loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
    spawnObjectData({ data = curObjectData,
    position = { curObjectData.Transform.posX, 0.0, curObjectData.Transform.posZ },
    callback_function = function(spawnedObject)
    spawnedObject.locked = true

    Wait.time(function()
    spawnedObject.locked = false
    spawnedObject.setPosition({ curObjectData.Transform.posX, curObjectData.Transform.posY, curObjectData.Transform.posZ })
    spawnedObject.setRotation({ curObjectData.Transform.rotX, curObjectData.Transform.rotY, curObjectData.Transform.rotZ })
    end,
    1.0)

    -- Update the actual spawn count.
    loadActualSpawnCount = (loadActualSpawnCount + 1)
    end
    })
    end
    end

    Wait.condition(spawnManualFullDecksDone, function() return (loadExpectedSpawnCount == loadActualSpawnCount) end)
end

function spawnManualFullDecksDone()
    printToAll("Full manual mode is now enabled.  Chronicle automation will no longer be available.", {0,0.8,0})
end

function spawnAllDecksAfterDelay()
    printToAll("Please wait, spawning decks...", {0,0.8,0})
    Wait.time(function() spawnAllDecksAfterDelayB() end, 0.05)
end

function spawnAllDecksAfterDelayB()
    local spawnStatus = STATUS_SUCCESS
    local spawnParams = {}
    local deckJSON = nil
    local curCardName = nil
    local curCardInfo = nil

    deckJSON = {
        Name = "Deck",
        Transform = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.0,
            rotX = 0.0,
            rotY = 0.0,
            rotZ = 0.0,
            scaleX = 1.00,
            scaleY = 1.00,
            scaleZ = 1.00
        },
        Nickname = "",
        Description = "",
        ColorDiffuse = {
            r = 0.713235259,
            g = 0.713235259,
            b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        SidewaysCard = false,
        HideWhenFaceDown = false,
        CustomDeck = {},
        DeckIDs = {},
        LuaScript = "",
        LuaScriptState = "",
        ContainedObjects = {},
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "800000"
    }

    --
    -- Spawn starting world deck denizens.
    --

    deckJSON.Nickname = "Starting Denizen Cards"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 53,0,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualWorldDenizensPosition[1], (-3.5), manualWorldDenizensPosition[3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualWorldDenizensPosition[1], manualWorldDenizensPosition[2], manualWorldDenizensPosition[3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    --
    -- Spawn visions.
    --

    deckJSON.Nickname = "Visions"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 90.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = true
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 214,210,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualVisionsPosition[1], (-3.5), manualVisionsPosition[3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualVisionsPosition[1], manualVisionsPosition[2], manualVisionsPosition[3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    --
    -- Spawn archive decks.
    --

    deckJSON.Nickname = "Archive:  Arcane"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 77,54,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Arcane"][1], (-3.5), manualArchivePositions["Arcane"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Arcane"][1], manualArchivePositions["Arcane"][2], manualArchivePositions["Arcane"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    deckJSON.Nickname = "Archive:  Discord"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 101,78,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Discord"][1], (-3.5), manualArchivePositions["Discord"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Discord"][1], manualArchivePositions["Discord"][2], manualArchivePositions["Discord"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    deckJSON.Nickname = "Archive:  Order"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 125,102,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Order"][1], (-3.5), manualArchivePositions["Order"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Order"][1], manualArchivePositions["Order"][2], manualArchivePositions["Order"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    deckJSON.Nickname = "Archive:  Hearth"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 149,126,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Hearth"][1], (-3.5), manualArchivePositions["Hearth"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Hearth"][1], manualArchivePositions["Hearth"][2], manualArchivePositions["Hearth"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    deckJSON.Nickname = "Archive:  Nomad"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 173,150,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Nomad"][1], (-3.5), manualArchivePositions["Nomad"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Nomad"][1], manualArchivePositions["Nomad"][2], manualArchivePositions["Nomad"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    deckJSON.Nickname = "Archive:  Beast"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 197,174,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualArchivePositions["Beast"][1], (-3.5), manualArchivePositions["Beast"][3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualArchivePositions["Beast"][1], manualArchivePositions["Beast"][2], manualArchivePositions["Beast"][3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    --
    -- Spawn edifice/ruin cards.
    --

    deckJSON.Nickname = "Edifices / Ruins"
    deckJSON.Transform.scaleX = 1.50
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.50
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 208,198,-2 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualEdificesRuinsPosition[1], (-3.5), manualEdificesRuinsPosition[3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualEdificesRuinsPosition[1], manualEdificesRuinsPosition[2], manualEdificesRuinsPosition[3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    --
    -- Spawn site cards.
    --

    deckJSON.Nickname = "Sites"
    deckJSON.Transform.scaleX = 1.46
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 1.46
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 22,0,-1 do
        curCardName = sitesBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualSitesPosition[1], (-3.5), manualSitesPosition[3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualSitesPosition[1], manualSitesPosition[2], manualSitesPosition[3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    --
    -- Spawn relic cards.
    --

    deckJSON.Nickname = "Relics"
    deckJSON.Transform.scaleX = 0.96
    deckJSON.Transform.scaleY = 1.00
    deckJSON.Transform.scaleZ = 0.96
    deckJSON.Transform.rotX = 0.0
    deckJSON.Transform.rotY = 180.0
    deckJSON.Transform.rotZ = 0.0
    deckJSON.SidewaysCard = false
    deckJSON.ContainedObjects = {}
    deckJSON.DeckIDs = {}

    for cardSaveID = 237,218,-1 do
        curCardName = normalCardsBySaveID[cardSaveID]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    addCardToContainerJSON(deckJSON, curCardName)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. curCardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end

    -- Spawn the deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { manualRelicsPosition[1], (-3.5), manualRelicsPosition[3] }
        spawnParams.rotation = { deckJSON.Transform.rotX, deckJSON.Transform.rotY, deckJSON.Transform.rotZ }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { manualRelicsPosition[1], manualRelicsPosition[2], manualRelicsPosition[3] },
                    true,
                    false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end

    Wait.condition(spawnAllDecksDone, function() return (loadExpectedSpawnCount == loadActualSpawnCount) end)
end

function spawnAllDecksDone()
    printToAll("Decks spawned.", {0,0.8,0})
end

function showStats()
    local displayString = nil
    local cardSuit = nil
    local worldDeckSuitCounts = { ["Discord"] = 0,
                                  ["Arcane"]  = 0,
                                  ["Order"]   = 0,
                                  ["Hearth"]  = 0,
                                  ["Beast"]   = 0,
                                  ["Nomad"]   = 0 }

    -- Note that the current game count represents the game in progress or about to start, and NOT the number of completed games.
    displayString = "Games played on this Chronicle:  " .. (curGameCount - 1) .. "\n\n"
    displayString = displayString .. "Suit counts in the world deck:"

    for i,curCard in ipairs(curWorldDeckCards) do
        cardSuit = cardsTable[curCard].suit
        -- Note that vision cards do not have suits.
        if (nil ~= cardSuit) then
    worldDeckSuitCounts[cardSuit] = (worldDeckSuitCounts[cardSuit] + 1)
        end
    end

    for i,suitCount in pairs(worldDeckSuitCounts) do
        displayString = displayString .. "\n  " .. i .. ":  " .. suitCount
    end

    showDataString(displayString)
end

function showExportString(displayString)
    pendingDataString = ""
    renamingChronicle = false

    Global.UI.setAttribute("panel_text_description", "text", "Copy to the clipboard to\nshare your Chronicle state:\n(click, then press Ctrl-C)")
    Global.UI.setAttribute("panel_text_data", "text", displayString)
    Global.UI.setAttribute("ok_panel_text", "active", true)
    Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("cancel_panel_text", "active", false)
    Global.UI.setAttribute("confirm_panel_text", "active", false)
    Global.UI.setAttribute("panel_text", "active", true)
end

function showDataString(displayString)
    pendingDataString = ""
    renamingChronicle = false

    Global.UI.setAttribute("panel_text_description", "text", "Data:")
    Global.UI.setAttribute("panel_text_data", "text", displayString)
    Global.UI.setAttribute("ok_panel_text", "active", true)
    Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("cancel_panel_text", "active", false)
    Global.UI.setAttribute("confirm_panel_text", "active", false)
    Global.UI.setAttribute("panel_text", "active", true)
end

function showChronicleNameDialog()
    pendingDataString = curChronicleName
    renamingChronicle = true

    Global.UI.setAttribute("panel_text_description", "text", "Chronicle Name:\n(can be edited)")
    Global.UI.setAttribute("panel_text_data", "text", curChronicleName)
    Global.UI.setAttribute("ok_panel_text", "active", true)
    Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("cancel_panel_text", "active", false)
    Global.UI.setAttribute("confirm_panel_text", "active", false)
    Global.UI.setAttribute("panel_text", "active", true)
end

function runPilgrimageCommand(player)
    local availableSites = {}
    local chosenSites = {}
    local removeSiteIndex = 0
    local numAvailableSites = 0
    local siteUsed = false
    local siteName = nil

    -- Make a list of unused sites.
    for siteCode = 0, (NUM_TOTAL_SITES - 1) do
        siteName = sitesBySaveID[siteCode]
        siteUsed = false

        for siteIndex = 1,8 do
            if (siteName == curMapSites[siteIndex][1]) then
                siteUsed = true
                break
            end
        end

        if (false == siteUsed) then
            table.insert(availableSites, siteName)
            numAvailableSites = (numAvailableSites + 1)
        end
    end

    -- Choose 3 random available sites.
    chosenSites = {}
    for spawnCount = 1,3 do
        removeSiteIndex = math.random(1, numAvailableSites)
        table.insert(chosenSites, availableSites[removeSiteIndex])
        table.remove(availableSites, removeSiteIndex)
        numAvailableSites = (numAvailableSites - 1)
    end

    -- Spawn 3 random available sites to the player's hand with a slight delay to allow them to adjust and not stack.
    Wait.time(function() spawnPilgrimageSite(player, chosenSites[1]) end, 0.05)
    Wait.time(function() spawnPilgrimageSite(player, chosenSites[2]) end, 0.25)
    Wait.time(function() spawnPilgrimageSite(player, chosenSites[3]) end, 0.45)
end

function spawnPilgrimageSite(player, siteName)
    spawnSingleCard(siteName,
            false,
            handCardSpawnPositions[player.color][2],
            handCardYRotations[player.color],
            true)
end

function selectWinner(player, value, id)
    local adjustedColor = value

    if ("Brown" == adjustedColor) then
        adjustedColor = "Black"
    end

    if (true == player.host) then
        -- Make sure the selected winner was active in the game.
        if (true == curPlayerStatus[value][2]) then
            pendingWinningColor = value

            Global.UI.setAttribute("panel_select_winner", "active", false)
            Global.UI.setAttribute("winner_selection", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
            Global.UI.setAttribute("panel_confirm_winner", "active", true)
        else
            printToAll("Error, " .. adjustedColor .. " was not playing.", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function cancelSelectWinner(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_select_winner", "active", false)

        configGeneralButtons(BUTTONS_IN_GAME)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function cancelConfirmWinner(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_confirm_winner", "active", false)
        Global.UI.setAttribute("panel_select_winner", "active", true)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmSelectWinner(player, value, id)
    local allObjects = nil
    local cardRotation = nil

    if (true == player.host) then
        Global.UI.setAttribute("panel_confirm_winner", "active", false)

        printToAll("", {1,1,1})
        -- Check the Steam name in case the player disconnected.
        if ((nil ~= Player[pendingWinningColor]) and
    (nil ~= Player[pendingWinningColor].steam_name) and
    ("" ~= Player[pendingWinningColor].steam_name)) then
    printToAll("[" .. Color.fromString(pendingWinningColor):toHex(false) .. "]" .. Player[pendingWinningColor].steam_name .. "[-] is the winning player!", {1,1,1})
    end

    if ("Brown" == pendingWinningColor) then
    printToAll("Winning color:  [000000]Black[-]", {1,1,1})
    else
    printToAll("Winning color:  [" .. Color.fromString(pendingWinningColor):toHex(False) .. "]" .. pendingWinningColor .. "[-]", {1,1,1})
    end

    -- Scan the table while the game is still in progress.  Than, mark the game over.
    scanTable(false)

    printToAll("", {1,1,1})
    isChronicleInProgress = true
    isGameInProgress = false
    curGameCount = (curGameCount + 1)

    -- Resync all player boards with game state.
    for i,curColor in ipairs(playerColors) do
    updateRotationFromPlayerBoard(curColor)
    end

    -- Update the dispossessed if it exists.
    if (true == isDispossessedSpawned) then
    removeDispossessedBag()
    end

        allObjects = getAllObjects()

        -- Check if the Bandit Crown is faceup somewhere.

        banditCrownFound = false
        banditCrownHoldingColor = nil

        for i,curObject in ipairs(allObjects) do
        if ("Card" == curObject.tag) then
        if ("Bandit Crown" == curObject.getName()) then
        -- Only detect the card if it is faceup.
        cardRotation = curObject.getRotation()
        if ((cardRotation[3] < 150) or (cardRotation[3] > 210)) then
        banditCrownFound = true
        break
        end
        end
        end
        end

        if (true == banditCrownFound) then
        -- As a sanity check in case player(s) revealed the Bandit Crown on the map instead of leaving it facedown, check if the Bandit Crown is on the map.
        for siteIndex = 1,8 do
        for normalCardIndex = 1,3 do
        if ("Bandit Crown" == curMapNormalCards[siteIndex][normalCardIndex][1]) then
    banditCrownFound = false
    end
    end
    end
        end

        if (true == banditCrownFound) then
        Global.UI.setAttribute("panel_bandit_crown_check", "active", true)
        else
        -- Prompt the winner to move any relic(s) to the Reliquary before the Chronicle continues.
        Global.UI.setAttribute("panel_move_winner_relics", "active", true)
    printToAll("Please move all relics owned by the winner to the Reliquary, stacking if needed.", {1,1,1})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function banditCrownResult(player, value, id)
    local banditCrownPosition = nil

    if ((true == player.host) or (player.color == winningColor)) then
        if ("confirm" == value) then
            Global.UI.setAttribute("panel_bandit_crown_check", "active", false)

            -- Prompt the winner to move any relic(s) to the Reliquary before the Chronicle continues.
            Global.UI.setAttribute("panel_move_winner_relics", "active", true)
            printToAll("Please move all relics owned by the winner to the Reliquary, stacking if needed.", {1,1,1})
        elseif ("no_one" == value) then
            banditCrownHoldingColor = nil

            Global.UI.setAttribute("bandit_crown_image", "active", false)
            Global.UI.setAttribute("bandit_crown_check_confirm", "active", true)
            -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
            Global.UI.setAttribute("bandit_crown_check_confirm", "textColor", "#FFFFFFFF")
        else
            banditCrownPosition = guiBanditCrownPositions[value]

            if (nil ~= banditCrownPosition) then
        -- Make sure the selected player was active in the game.
        if (true == curPlayerStatus[value][2]) then
        banditCrownHoldingColor = value

        Global.UI.setAttribute("bandit_crown_image", "offsetXY", banditCrownPosition[1] .. " " .. banditCrownPosition[2])
        Global.UI.setAttribute("bandit_crown_image", "active", true)
        Global.UI.setAttribute("bandit_crown_check_confirm", "active", true)
        -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
        Global.UI.setAttribute("bandit_crown_check_confirm", "textColor", "#FFFFFFFF")
        else
        printToAll("Error, that player was not playing.", {1,0,0})
        end
        else
        -- This should never happen.
        printToAll("Error, unsupported bandit crown result.", {1,0,0})
            end
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmDoneMovingWinnerRelics(player, value, id)
    local familyWagonFound = false
    local piedPiperFound = false
    local allObjects = nil
    local curObjectName = nil
    local cardRotation = nil

    if ((true == player.host) or (player.color == winningColor)) then
        Global.UI.setAttribute("panel_move_winner_relics", "active", false)

        allObjects = getAllObjects()

        -- Check if "Family Wagon" or "Pied Piper" is in play and NOT on the world map.  This card allows players to exceed the normal 3-adviser limit.
        for i,curObject in ipairs(allObjects) do
            curObjectName = curObject.getName()

            -- Check only isolated cards.
            if ("Card" == curObject.tag) then
                if (("Family Wagon" == curObjectName) or ("Pied Piper" == curObjectName)) then
                    -- Only detect the card if it is faceup.
                    cardRotation = curObject.getRotation()
                    if ((cardRotation[3] < 150) or (cardRotation[3] > 210)) then
                        if ("Family Wagon" == curObjectName) then
                            familyWagonFound = true
                        end

                        if ("Pied Piper" == curObjectName) then
                            piedPiperFound = true
                        end

                        -- Keep searching until both cards are potentially found.
                    end
                end
            end
        end

        -- If the above card(s) were found, make sure they are not on the map.

        if (true == familyWagonFound) then
            for siteIndex = 1,8 do
                for normalCardIndex = 1,3 do
                    if ("Family Wagon" == curMapNormalCards[siteIndex][normalCardIndex][1]) then
                        familyWagonFound = false
                        break
                    end
                end
            end
        end

        if (true == piedPiperWagonFound) then
            for siteIndex = 1,8 do
                for normalCardIndex = 1,3 do
                    if ("Pied Piper" == curMapNormalCards[siteIndex][normalCardIndex][1]) then
                        piedPiperFound = false
                        break
                    end
                end
            end
        end

        if ((true == familyWagonFound) or (true == piedPiperFound)) then
            showChronicleInfo(CHRONICLE_INFO_COMBINE_ADVISERS,
                    [["Family Wagon" and/or
"Pied Piper" appear to
be in play.  If player(s)
have more than 3 advisers,
please drag them so they
are stacked in their
normal 3 adviser slots.]])
        else
            -- Skip the confirmation dialog.  All advisers should already be in the 3 normal slots.
            confirmDoneAdviserCombine(player, value, id)
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmDoneAdviserCombine(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        -- Scan advisers one more time, in case player(s) moved adviser(s) into the 3 normal slots.
        scanPlayerAdvisers()

        -- If an Exile won, check if they used a vision.  If a Citizen won, they must have won by succession.  Otherwise, move on to the next step.
        if ("Exile" == curPlayerStatus[pendingWinningColor][1]) then
            Global.UI.setAttribute("panel_use_vision_check", "active", true)
        elseif ("Citizen" == curPlayerStatus[pendingWinningColor][1]) then
            -- If a Citizen wins, it must ALWAYS be by succession.
            usedVision = false
            wonBySuccession = true

            -- Since the player won without a Vision, they must choose any Oath except the current one for the next game.
            pendingOath = nil
            Global.UI.setAttribute("mark_chronicle_oath", "active", false)
            Global.UI.setAttribute("banned_chronicle_oath", "offsetXY", selectOathOffsets[curOath])
            Global.UI.setAttribute("panel_choose_oath_except", "active", true)
        else
            -- This simulates clicking no from the vision check dialog.
            visionCheckResult(player, "no", "use_vision_check_no")
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function toggleCitizenshipColor(player, value, id)
    if (false == grantCitizenshipLocked) then
        if ((true == player.host) or (player.color == winningColor)) then
            if (winningColor == value) then
                printToAll("That player won the game and will already become Chancellor.", {1,0,0})
            elseif ("Exile" ~= curPlayerStatus[value][1]) then
        printToAll("That player was a Citizen.", {1,0,0})
        elseif (false == curPlayerStatus[value][2]) then
        printToAll("That player was not playing.", {1,0,0})
        else
        if (false == grantPlayerCitizenship[value]) then
        grantPlayerCitizenship[value] = true
        else
        grantPlayerCitizenship[value] = false
        end

        Global.UI.setAttribute("mark_color_grant_" .. value, "active", grantPlayerCitizenship[value])
            end
        else
            printToAll("Error, only the host or winning player can click that.", {1,0,0})
        end
    else
        printToAll("Click \"Back\" if you want to change the selection.", {1,0,0})
    end -- end if (false == grantCitizenshipLocked)
end

function panelSelectWinnerDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_select_winner", "active", false)
    Global.UI.setAttribute("panel_select_winner", "active", true)
end

function panelChronicleInfoDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_chronicle_info", "active", false)
    Global.UI.setAttribute("panel_chronicle_info", "active", true)
end

function panelChronicleInfoSmallDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_chronicle_info_small", "active", false)
    Global.UI.setAttribute("panel_chronicle_info_small", "active", true)
end

function panelConfirmWinnerDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_confirm_winner", "active", false)
    Global.UI.setAttribute("panel_confirm_winner", "active", true)
end

function panelMoveWinnerRelicsDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_move_winner_relics", "active", false)
    Global.UI.setAttribute("panel_move_winner_relics", "active", true)
end

function panelUseVisionCheckDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_use_vision_check", "active", false)
    Global.UI.setAttribute("panel_use_vision_check", "active", true)
end

function panelBanditCrownCheckDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_bandit_crown_check", "active", false)
    Global.UI.setAttribute("panel_bandit_crown_check", "active", true)
end

function panelChooseOathExceptDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_choose_oath_except", "active", false)
    Global.UI.setAttribute("panel_choose_oath_except", "active", true)
end

function configGeneralButtons(buttonConfig)
    local dispossessedButtonLabel = nil

    gameDataObject.clearButtons()
    spawnDispossessedButtonIndex = 0

    for i,curColor in ipairs(playerColors) do
        playerButtonIndices[curColor] = nil
    end

    if (BUTTONS_NONE == buttonConfig) then
        -- Nothing needs done.
    elseif (BUTTONS_NOT_IN_GAME == buttonConfig) then
        gameDataObject.createButton({
            label="Setup",
            click_function="setupButtonClicked",
            function_owner=self,
            position={ -10.0,   5.0, -33.0 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=700,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        gameDataObject.createButton({
            label="Random\nSetup",
            click_function="randomSetupButtonClicked",
            function_owner=self,
            position={ -23.0,   5.0, -33.0 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=700,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        gameDataObject.createButton({
            label="Tutorial Setup (4-player)",
            click_function="tutorialSetupButtonClicked",
            function_owner=self,
            position={ -16.5,   5.0, -39.5 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=2220,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        gameDataObject.createButton({
            label="Import\nChronicle",
            click_function="importChronicleButtonClicked",
            function_owner=self,
            position={ -36.0,   5.0, -33.0 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=700,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        gameDataObject.createButton({
            label="Export\nChronicle",
            click_function="exportChronicleButtonClicked",
            function_owner=self,
            position={ -50.0,   5.0, -33.0 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=700,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        gameDataObject.createButton({
            label="Manual\nSetup",
            click_function="manualSetupButtonClicked",
            function_owner=self,
            position={ -36.0,   5.0, -39.5 },
            scale=   {   4.0,   4.0,   4.0 },
            rotation={   0.0, 180.0,   0.0 },
            width=700,
            height=500,
            font_size=144,
            color={ 1, 1, 1, 1 }
        })

        -- TODO IMPLEMENT
        --gameDataObject.createButton({
        --  label="Edit\nChronicle",
        --  click_function="editChronicleButtonClicked",
        --  function_owner=self,
        --  position={ -50.0,   5.0, -39.5 },
        --  scale=   {   4.0,   4.0,   4.0 },
        --  rotation={   0.0, 180.0,   0.0 },
        --  width=700,
        --  height=500,
        --  font_size=144,
        --  color={ 1, 1, 1, 1 }
        --})
    elseif (BUTTONS_IN_GAME == buttonConfig) then
        if (false == isManualControlEnabled) then
            gameDataObject.createButton({
                label="Declare\nWinner",
                click_function="declareWinnerButtonClicked",
                function_owner=self,
                position={ 20.0,   5.0,  0.0 },
                scale=   {  4.0,   4.0,  4.0 },
                rotation={  0.0, 180.0,  0.0 },
                width=700,
                height=500,
                font_size=144,
                color={ 1, 1, 1, 1 }
            })
        end

        createPlayerButtons()

        if (false == isManualControlEnabled) then
            -- Create this button last so deleting it does not cause other button indices to change.
            if (true == isDispossessedSpawned) then
                dispossessedButtonLabel = "Remove\nDispossessed"
            else
                dispossessedButtonLabel = "Spawn\nDispossessed"
            end

            gameDataObject.createButton({
                label=dispossessedButtonLabel,
                click_function="spawnDispossessedButtonClicked",
                function_owner=self,
                position={ 19.4,   5.0, -40.0 },
                scale=   {  4.0,   4.0,  4.0 },
                rotation={  0.0, 180.0,  0.0 },
                width=900,
                height=500,
                font_size=144,
                color={ 1, 1, 1, 1 }
            })

            -- With N buttons, the last button index is always (N - 1).
            spawnDispossessedButtonIndex = ((#(gameDataObject.getButtons())) - 1)
        end
    else
        -- This should never happen.
        printToAll("Error, invalid button config " .. buttonConfig, {1,0,0})
    end
end

-- Creates player buttons.
function createPlayerButtons()
    local buttonTable = nil
    local numButtonsCreated = 0
    local nextTableIndex = 1

    for i,curColor in ipairs(playerColors) do
        -- If this color is active in this game, and they are not Purple, create a citizen/exile button for them.
        if (true == curPlayerStatus[curColor][2]) then
            if ("Purple" ~= curColor) then
        if ("Exile" == curPlayerStatus[curColor][1]) then
        gameDataObject.createButton({
        label="Citizen",
        click_function="flipButtonClicked" .. curColor,
        function_owner=self,
        position=playerButtonPositions[curColor],
        scale=   { 2.0, 2.0, 2.0 },
        rotation={ 0.0, handCardYRotations[curColor], 0.0 },
        width=700,
        height=500,
        font_size=180,
        color=playerButtonColors[curColor]
        })

        numButtonsCreated = (numButtonsCreated + 1)
        else
        gameDataObject.createButton({
        label="Exile",
        click_function="flipButtonClicked" .. curColor,
        function_owner=self,
        position=playerButtonPositions[curColor],
        scale=   { 2.0, 2.0, 2.0 },
        rotation={ 0.0, handCardYRotations[curColor],  0.0 },
        width=700,
        height=500,
        font_size=180,
        color=playerButtonColors[curColor]
        })

        numButtonsCreated = (numButtonsCreated + 1)
        end
        end
        end
    end

    -- Get indices of all player buttons.
    buttonTable = gameDataObject.getButtons()

    nextTableIndex = ((#buttonTable - numButtonsCreated) + 1)
    for i,curColor in ipairs(playerColors) do
        if (true == curPlayerStatus[curColor][2]) then
            if ("Purple" ~= curColor) then
        playerButtonIndices[curColor] = buttonTable[nextTableIndex].index
        nextTableIndex = (nextTableIndex + 1)
            end
        end
    end
end

-- The below functions are for a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.

function panelSelectPlayersDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_select_players", "active", false)
    Global.UI.setAttribute("panel_select_players", "active", true)
end

function panelOfferCitizenshipDrag()
    Global.UI.setAttribute("panel_offer_citizenship", "active", false)
    Global.UI.setAttribute("panel_offer_citizenship", "active", true)
end

function panelChooseVisionDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_choose_vision", "active", false)
    Global.UI.setAttribute("panel_choose_vision", "active", true)
end

function panelSelectOathDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_select_oath", "active", false)
    Global.UI.setAttribute("panel_select_oath", "active", true)
end

function panelBuildRepairDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_build_repair", "active", false)
    Global.UI.setAttribute("panel_build_repair", "active", true)
end

function panelBuildRepairCardsDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_build_repair_cards", "active", false)
    Global.UI.setAttribute("panel_build_repair_cards", "active", true)
end

function panelChooseEdificeDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_choose_edifice", "active", false)
    Global.UI.setAttribute("panel_choose_edifice", "active", true)
end

function panelSelectSuitDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_select_suit", "active", false)
    Global.UI.setAttribute("panel_select_suit", "active", true)
end

function panelTextDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_text", "active", false)
    Global.UI.setAttribute("panel_text", "active", true)
end

function panelEraseChronicleCheckDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
end

function panelManualSetupCheckDrag()
    -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
    Global.UI.setAttribute("panel_manual_setup_check", "active", false)
    Global.UI.setAttribute("panel_manual_setup_check", "active", true)
end

function closePanelText(player, value, id)
    local newChronicleNameLength = nil
    local cleanedStringV1 = nil
    local cleanedStringV2 = nil

    if (true == player.host) then
        Global.UI.setAttribute("panel_text", "active", false)

        if ("ok" == value) then
            if (true == renamingChronicle) then
                newChronicleNameLength = string.len(pendingDataString)

                if ((newChronicleNameLength >= MIN_NAME_LENGTH) and
                        (newChronicleNameLength <= MAX_NAME_LENGTH)) then
                    -- Clean up the string by remove any starting and trailing newlines, linefeeds, and/or whitespace.
                    cleanedStringV1 = string.gsub(pendingDataString, "^[%s\n\r]+", "");
                    cleanedStringV2 = string.gsub(cleanedStringV1, "[%s\n\r]+$", "");

                    if (curChronicleName ~= cleanedStringV2) then
                curChronicleName = cleanedStringV2
                printToAll("", {1,1,1})
                printToAll("The course of history has changed.", {1,1,1})
                printToAll("The chronicle is now titled \"" .. curChronicleName .. "\".", {0,0.8,0})
                printToAll("", {1,1,1})
                    end
                else
                    printToAll("Error, chronicle name must be at least 1 character and no more than 255 characters.", {1,0,0})
                end
            end
        elseif ("cancel" == value) then
            -- Nothing needs done.
        elseif ("confirm" == value) then
            -- This is only used for the import case.  Since this erases the chronicle, double check first.
            pendingEraseType = "import"
            Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
        else
            -- This should never happen.
            printToAll("Error, invalid state.", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function panelTextEndEdit(player, value, id)
    pendingDataString = value
end

function eraseChronicleCheckResult(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)

        if ("yes" == value) then
            if ("import" == pendingEraseType) then
                loadFromSaveString(pendingDataString, false)
                cleanTable()

                pendingEraseType = nil
            elseif ("reset" == pendingEraseType) then
                initDefaultGameState()
                loadFromSaveString(chronicleStateString, false)
                cleanTable()

                printToAll("", {1,1,1})
                printToAll("The wheel of time turns again.", {1,1,1})
                printToAll("", {1,1,1})

                pendingEraseType = nil
            elseif ("randomSetup" == pendingEraseType) then
                Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
                randomEnabled = true
                tutorialEnabled = false
                commonSetup()
            elseif ("tutorialSetup" == pendingEraseType) then
                Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
                randomEnabled = false
                tutorialEnabled = true
                commonSetup()
            else
                -- This should never happen.
                printToAll("Error, invalid erase type.", {1,0,0})
            end
        else -- end if ("yes" == value)
            printToAll("Operation cancelled.", {1,1,1})
        end
    else -- end if (true == player.host)
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function manualSetupCheckResult(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_manual_setup_check", "active", false)

        if ("yes" == value) then
            initDefaultGameState()
            isManualControlEnabled = true
            loadFromSaveString(chronicleStateString, false)
            cleanTable()

            spawnManualFullDecks(player)
            commonSetup()
        else -- end if ("yes" == value)
            printToAll("Operation cancelled.", {1,1,1})
        end
    else -- end if (true == player.host)
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function setupButtonClicked(buttonObject, playerColor, altClick)
    if (true == Player[playerColor].host) then
        Global.UI.setAttribute("panel_manual_setup_check", "active", false)
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)

        randomEnabled = false
        tutorialEnabled = false
        commonSetup()
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function randomSetupButtonClicked(buttonObject, playerColor, altClick)
    if (true == Player[playerColor].host) then
        pendingEraseType = "randomSetup"
        Global.UI.setAttribute("panel_manual_setup_check", "active", false)
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function tutorialSetupButtonClicked(buttonObject, playerColor, altClick)
    if (true == Player[playerColor].host) then
        pendingEraseType = "tutorialSetup"
        Global.UI.setAttribute("panel_manual_setup_check", "active", false)
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function declareWinnerButtonClicked(buttonObject, playerColor, altClick)
    if (true == Player[playerColor].host) then
        if (true == areHandsEmpty()) then
            configGeneralButtons(BUTTONS_NONE)

            showChronicleInfo(CHRONICLE_INFO_CREATE_SAVE,
                    [[Please save your game now,
since the Chronicle phase
is about to start.

Use the "Games" button at the top.

Drag this window if you need to.]])
        else
            printToAll("Error, the chronicle cannot begin if anything is in player hand zones!", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function spawnDispossessedButtonClicked(buttonObject, playerColor, altClick)
    local dispossessedUnshuffled = {}
    local dispossessedShuffled = {}
    local removeCardIndex = 1
    local spawnParams = {}

    if (true == Player[playerColor].host) then
        if (false == isDispossessedSpawned) then
            if (0 ~= spawnDispossessedButtonIndex) then
        gameDataObject.editButton({ index = spawnDispossessedButtonIndex, label = "Remove\nDispossessed" })
        end

        -- Create a copy of the dispossessed cards.
        for cardIndex = 1,curDispossessedDeckCardCount do
        dispossessedUnshuffled[cardIndex] = curDispossessedDeckCards[cardIndex]
        end

        -- Create a shuffled list of dispossessed cards.
        for cardIndex = 1,curDispossessedDeckCardCount do
        removeCardIndex = math.random(1, #dispossessedUnshuffled)
        dispossessedShuffled[cardIndex] = dispossessedUnshuffled[removeCardIndex]
        table.remove(dispossessedUnshuffled, removeCardIndex)
        end

        -- Spawn the shuffled dispossessed cards in a bag.
        if (0 == curDispossessedDeckCardCount) then
        bagJSON.ContainedObjects = nil
        else
        bagJSON.ContainedObjects = {}
            for cardIndex = 1,curDispossessedDeckCardCount do
            addCardToContainerJSON(bagJSON, dispossessedShuffled[cardIndex])
            end
            end

            -- Set the bag name and description.
            bagJSON.Nickname = "Dispossessed"
            bagJSON.Description = "Please do not move or delete."
            -- Set the bag transform to match the spawn settings.  Otherwise, the bag seems to sometimes blast cards around as it spawns.
            bagJSON.Transform.posX = dispossessedSpawnPosition[1]
            bagJSON.Transform.posY = dispossessedSpawnPosition[2]
            bagJSON.Transform.posZ = dispossessedSpawnPosition[3]
            bagJSON.Transform.rotX = 0.0
            bagJSON.Transform.rotY = 0.0
            bagJSON.Transform.rotZ = 0.0
            bagJSON.Transform.scaleX = 2.0
            bagJSON.Transform.scaleY = 2.0
            bagJSON.Transform.scaleZ = 2.0
            -- Make the bag use random ordering.
            bagJSON.Bag = { ["Order"] = 2 }
            spawnParams.json = JSON.encode(bagJSON)
            spawnParams.position = { dispossessedSpawnPosition[1], dispossessedSpawnPosition[2], dispossessedSpawnPosition[3] }
            spawnParams.rotation = {   0.00, 0.00,   0.00 }
            spawnParams.scale    = {   2.00, 2.00,   2.00 }
            spawnParams.callback_function = function(spawnedObject)
            dispossessedBagGuid = spawnedObject.guid
        handleSpawnedObject(spawnedObject,
        { dispossessedSpawnPosition[1], dispossessedSpawnPosition[2], dispossessedSpawnPosition[3] },
        false,
        false) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)

        printToAll("", {1,1,1})
        printToAll("Dispossessed bag spawned.  Please do not move or delete it.", {1,1,1})
        printToAll("When finished, click the Removed Dispossessed button.", {1,1,1})
        printToAll("", {1,1,1})

            isDispossessedSpawned = true
        else -- end bag spawning case
            removeDispossessedBag()
        end -- end bag removal case
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function removeDispossessedBag()
    local dispossessedBag = nil
    local bagObjects = nil
    local cardName = nil
    local cardInfo = nil

    if (true == isDispossessedSpawned) then
        if (nil ~= dispossessedBagGuid) then
    if (0 ~= spawnDispossessedButtonIndex) then
    gameDataObject.editButton({ index = spawnDispossessedButtonIndex, label = "Spawn\nDispossessed" })
    end

    dispossessedBag = getObjectFromGUID(dispossessedBagGuid)
    if (nil ~= dispossessedBag) then
    -- Scan the dispossessed bag.
    curDispossessedDeckCardCount = 0
    curDispossessedDeckCards = {}
    -- Note that since this is a bag, getData() is needed rather than getObjects().
    bagObjects = dispossessedBag.getData().ContainedObjects
    if (nil ~= bagObjects) then
    for i,curObject in ipairs(bagObjects) do
    if ("Deck" == curObject.Name) then
    -- Since a deck was encountered, scan it for Denizen cards.
    for i,curCardInDeck in ipairs(curObject.ContainedObjects) do
    cardName = curCardInDeck.Nickname
    cardInfo = cardsTable[cardName]

    if (nil ~= cardInfo) then
    if ("Denizen" == cardInfo.cardtype) then
    table.insert(curDispossessedDeckCards, cardName)
    curDispossessedDeckCardCount = (curDispossessedDeckCardCount + 1)
    else
    printToAll("Warning, found unknown card \"" .. cardName .. "\" in the dispossessed bag.", {1,0,0})
    end
    else
    printToAll("Warning, found unknown card \"" .. cardName .. "\" in the dispossessed bag.", {1,0,0})
    end
    end
    elseif ("Card" == curObject.Name) then
    cardName = curObject.Nickname
    cardInfo = cardsTable[cardName]

    if (nil ~= cardInfo) then
    if ("Denizen" == cardInfo.cardtype) then
    table.insert(curDispossessedDeckCards, cardName)
    curDispossessedDeckCardCount = (curDispossessedDeckCardCount + 1)
    else
    printToAll("Warning, found unknown card \"" .. cardName .. "\" in the dispossessed bag.", {1,0,0})
    end
    else
    printToAll("Warning, found unknown card \"" .. cardName .. "\" in the dispossessed bag.", {1,0,0})
    end
    else
    printToAll("Warning, found unknown object \"" .. curObject.Name .. "\" in the dispossessed bag.", {1,0,0})
    end
    end
    end

    printToAll("The dispossessed deck now has " .. curDispossessedDeckCardCount .. " cards.", {0,0.8,0})

    -- Destroy the dispossessed bag.
    destroyObject(dispossessedBag)
    dispossessedBag = nil
    dispossessedBagGuid = nil

    printToAll("Dispossessed bag removed.", {1,1,1})

    isDispossessedSpawned = false
    else
    printToAll("Error, could not find dispossessed bag.", {1,0,0})
    end
    else
    printToAll("Error, dispossessed bag GUID not known.", {1,0,0})
        end
    else
        printToAll("Error, dispossessed bag was not spawned.", {1,0,0})
    end
end

function addCardToContainerJSON(containerJSON, cardName)
    local spawnStatus = STATUS_SUCCESS
    local cardInfo = cardsTable[cardName]
    local cardType = cardInfo.cardtype
    local cardDescription = nil
    local ttsCardID = cardInfo.ttscardid
    local cardDeckID = string.sub(ttsCardID, 1, -3)
    local isCardSideways = false
    local shouldHideWhenFaceDown = true
    local cardJSON = nil
    local cardTTSDeckInfo = nil

    -- Edifice / ruin cards should not hide the tooltip even when facedown.
    if ("EdificeRuin" == cardType) then
        shouldHideWhenFaceDown = false
    end

    -- Visions are sideways.  Sites, despite their shape, are not sideways on the card sheet.
    if ("Vision" == cardType) then
        isCardSideways = true
    else
        isCardSideways = false
    end

    -- Check for FAQ text.
    if (nil ~= cardInfo.faqText) then
    cardDescription = cardInfo.faqText
    else
    cardDescription = NO_FAQ_TEXT
    end

    cardJSON = {
    Name = "Card",
    Transform = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.0,
    rotX = 0.0,
    rotY = 180.0,
    rotZ = 180.0,
    scaleX = 1.00,
    scaleY = 1.00,
    scaleZ = 1.00
    },
    Nickname = cardName,
    Description = cardDescription,
    ColorDiffuse = {
    r = 0.713235259,
    g = 0.713235259,
    b = 0.713235259
    },
    Locked = false,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    CardID = ttsCardID,
    SidewaysCard = isCardSideways,
    HideWhenFaceDown = shouldHideWhenFaceDown,
    CustomDeck = {},
    LuaScript = "",
    LuaScriptState = "",
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "700000"
    }

    if ("Site" == cardType) then
    cardJSON.Transform.cardScaleX = 1.46
    cardJSON.Transform.cardScaleZ = 1.46
    elseif ("Relic" == cardType) then
    cardJSON.Transform.cardScaleX = 0.96
    cardJSON.Transform.cardScaleZ = 0.96
    else
    cardJSON.Transform.cardScaleX = 1.50
    cardJSON.Transform.cardScaleZ = 1.50
    end

    -- Update CustomDeck data.
    cardTTSDeckInfo = ttsDeckInfo[tonumber(cardDeckID)]
    if (nil ~= cardTTSDeckInfo) then
    if (nil ~= containerJSON.CustomDeck) then
    -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
    cardJSON.CustomDeck = nil

    -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
    table.insert(containerJSON.DeckIDs, cardInfo.ttscardid)

    -- If needed, record the CustomDeck information in the overall deck JSON.
    if (nil == containerJSON.CustomDeck[cardDeckID]) then
    containerJSON.CustomDeck[cardDeckID] = {
    FaceURL = cardTTSDeckInfo.deckimage,
    BackURL = cardTTSDeckInfo.backimage,
    NumWidth = cardTTSDeckInfo.deckwidth,
    NumHeight = cardTTSDeckInfo.deckheight,
    BackIsHidden = true,
    UniqueBack = cardTTSDeckInfo.hasuniqueback
    }
    end
    else
    cardJSON.CustomDeck[cardDeckID] = {
    FaceURL = cardTTSDeckInfo.deckimage,
    BackURL = cardTTSDeckInfo.backimage,
    NumWidth = cardTTSDeckInfo.deckwidth,
    NumHeight = cardTTSDeckInfo.deckheight,
    BackIsHidden = true,
    UniqueBack = cardTTSDeckInfo.hasuniqueback
    }
    end
    else -- end if (nil ~= cardTTSDeckInfo)
    printToAll("Error, did not find deck with ID " .. cardDeckID, {1,0,0})
    spawnStatus = STATUS_FAILURE
    end

    if (STATUS_SUCCESS == spawnStatus) then
    table.insert(containerJSON.ContainedObjects, cardJSON)
    end
end

function flipButtonClickedBrown(buttonObject, playerColor, altClick)
    local buttonPlayerColor = "Brown"

    if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
        curPlayerStatus[buttonPlayerColor][1] = "Citizen"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile" })

        -- Note special case:  TTS "Brown" is Oath "Black".
        printToAll("[000000]Black[-] is now a Citizen.", {1,1,1})
    else
        curPlayerStatus[buttonPlayerColor][1] = "Exile"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

        -- Note special case:  TTS "Brown" is Oath "Black".
        printToAll("[000000]Black[-] is now an Exile.", {1,1,1})
    end
end

function flipButtonClickedYellow(buttonObject, playerColor, altClick)
    local buttonPlayerColor = "Yellow"

    if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
        curPlayerStatus[buttonPlayerColor][1] = "Citizen"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Citizen.", {1,1,1})
    else
        curPlayerStatus[buttonPlayerColor][1] = "Exile"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Exile.", {1,1,1})
    end
end

function flipButtonClickedWhite(buttonObject, playerColor, altClick)
    local buttonPlayerColor = "White"

    if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
        curPlayerStatus[buttonPlayerColor][1] = "Citizen"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Citizen.", {1,1,1})
    else
        curPlayerStatus[buttonPlayerColor][1] = "Exile"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Exile.", {1,1,1})
    end
end

function flipButtonClickedBlue(buttonObject, playerColor, altClick)
    local buttonPlayerColor = "Blue"

    if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
        curPlayerStatus[buttonPlayerColor][1] = "Citizen"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Citizen.", {1,1,1})
    else
        curPlayerStatus[buttonPlayerColor][1] = "Exile"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Exile.", {1,1,1})
    end
end

function flipButtonClickedRed(buttonObject, playerColor, altClick)
    local buttonPlayerColor = "Red"

    if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
        curPlayerStatus[buttonPlayerColor][1] = "Citizen"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Citizen.", {1,1,1})
    else
        curPlayerStatus[buttonPlayerColor][1] = "Exile"
        updatePlayerBoardRotation(buttonPlayerColor)

        gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

        printToAll("[" .. Color.fromString(buttonPlayerColor):toHex(false) .. "]" .. buttonPlayerColor .. "[-] is now a Exile.", {1,1,1})
    end
end

function commonSetup()
    local convertedColor = nil

    configGeneralButtons(BUTTONS_NONE)

    if (true == isManualControlEnabled) then
        -- Set all players as active and Chancellor/Exile.
        for i,curColor in ipairs(playerColors) do
            if ("Purple" == curColor) then
                curPlayerStatus[curColor][1] = "Chancellor"
            else
                curPlayerStatus[curColor][1] = "Exile"
            end
            curPlayerStatus[curColor][2] = true
        end

        -- Finish setup.
        setupLoadedState(true)
    elseif (false == tutorialEnabled) then
        for i,curColor in ipairs(playerColors) do
            if ("Purple" == curColor) then
                -- The Chancellor is always active.
                curPlayerStatus[curColor][2] = true
                Global.UI.setAttribute("mark_color_purple", "active", true)
            else
                curPlayerStatus[curColor][2] = Player[curColor].seated
                Global.UI.setAttribute("mark_color_" .. curColor, "active", Player[curColor].seated)
                Global.UI.setAttribute("status_" .. curColor, "text", "(" .. curPlayerStatus[curColor][1] .. ")")

                if ("Citizen" == curPlayerStatus[curColor][1]) then
                    Global.UI.setAttribute("status_" .. curColor, "color", "#96338AFF")
                else
                    Global.UI.setAttribute("status_" .. curColor, "color", "#FFFFFFFF")
                end
            end
        end

        if ("Brown" == curPreviousWinningColor) then
            convertedColor = "Black"
        else
            convertedColor = curPreviousWinningColor
        end
        printToAll("Winning color from previous game:  [" .. Color.fromString(convertedColor):toHex(false) .. "]" .. convertedColor .. "[-]", {1,1,1})
        printToAll("Winning Steam name from previous game:  [" .. Color.fromString(convertedColor):toHex(false) .. "]" .. curPreviousWinningSteamName .. "[-]", {1,1,1})

        Global.UI.setAttribute("previous_winner_value", "text", convertedColor .. ", " .. curPreviousWinningSteamName)
        Global.UI.setAttribute("previous_winner_value", "color", "#" .. Color.fromString(convertedColor):toHex(true))

        Global.UI.setAttribute("panel_select_players", "active", true)
    else -- end elseif (false == tutorialEnabled)
        -- The tutorial setup always uses the same 4 players.

        curPlayerStatus["Purple"][1] = "Chancellor"
        curPlayerStatus["Red"][1]    = "Exile"
        curPlayerStatus["Brown"][1]  = "Exile"
        curPlayerStatus["Blue"][1]   = "Exile"
        curPlayerStatus["Yellow"][1] = "Exile"
        curPlayerStatus["White"][1]  = "Exile"

        curPlayerStatus["Purple"][2] = true
        curPlayerStatus["Red"][2]    = true
        curPlayerStatus["Brown"][2]  = false
        curPlayerStatus["Blue"][2]   = true
        curPlayerStatus["Yellow"][2] = true
        curPlayerStatus["White"][2]  = false

        -- Load the prebaked tutorial chronicle string.
        cleanTable()
        loadFromSaveString(TUTORIAL_CHRONICLE_STATE_STRING, true)
    end
end

function toggleColor(player, value, id)
    if (true == player.host) then
        if ("Purple" == value) then
            printToAll("The Chancellor demands your respect and is in every game.", {1,0,0})
        else
            if (false == curPlayerStatus[value][2]) then
                curPlayerStatus[value][2] = true
            else
                curPlayerStatus[value][2] = false
            end

            Global.UI.setAttribute("mark_color_" .. value, "active", curPlayerStatus[value][2])
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function areHandsEmpty()
    local retValue = true
    local allHandZones = nil
    local handZoneObjects = nil

    allHandZones = Hands.getHands()

    -- Check all hand zones for at least one object.
    for i,curHandZone in ipairs(allHandZones) do
        handZoneObjects = curHandZone.getObjects()
        if ((#handZoneObjects) > 0) then
            retValue = false
            break
        end
    end

    return retValue
end

function showChronicleInfo(infoCode, infoText)
    curChronicleInfoCode = infoCode

    -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
    if (CHRONICLE_INFO_CREATE_SAVE == curChronicleInfoCode) then
        Global.UI.setAttribute("chronicle_info_text", "text", infoText)
        Global.UI.setAttribute("chronicle_info_text", "color", "#FFFFFF")
        Global.UI.setAttribute("panel_chronicle_info", "active", true)
    elseif (CHRONICLE_INFO_COMBINE_ADVISERS == curChronicleInfoCode) then
        Global.UI.setAttribute("chronicle_info_small_text", "text", infoText)
        Global.UI.setAttribute("chronicle_info_small_text", "color", "#FFFFFF")
        Global.UI.setAttribute("panel_chronicle_info_small", "active", true)
    else
        -- This should never happen.
        printToAll("Invalid chronicle info code.", {1,0,0})
    end
end

function closeChronicleInfo(player, value, id)
    if (true == player.host) then
        -- Attempt to close both panels, which will handle whichever may be open.
        Global.UI.setAttribute("panel_chronicle_info", "active", false)
        Global.UI.setAttribute("panel_chronicle_info_small", "active", false)

        if (CHRONICLE_INFO_CREATE_SAVE == curChronicleInfoCode) then
            if ("done" == value) then
                Global.UI.setAttribute("panel_select_winner", "active", true)
            else
                configGeneralButtons(BUTTONS_IN_GAME)
            end
        elseif (CHRONICLE_INFO_COMBINE_ADVISERS == curChronicleInfoCode) then
            confirmDoneAdviserCombine(player, value, id)
        else
            -- This should never happen.
            printToAll("Invalid chronicle info code.", {1,0,0})
        end

        curChronicleInfoCode = nil
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function cancelSelectPlayers(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_select_players", "active", false)

        configGeneralButtons(BUTTONS_NOT_IN_GAME)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function selectOath(player, value, id)
    if (true == player.host) then
        curGameNumPlayers = 0
        for i,curColor in ipairs(playerColors) do
            if (true == curPlayerStatus[curColor][2]) then
                curGameNumPlayers = (curGameNumPlayers + 1)
            end
        end

        if (curGameNumPlayers > 1) then
            Global.UI.setAttribute("panel_select_players", "active", false)

            if (true == randomEnabled) then
                curOath = oathNamesFromCode[math.random(0, 3)]
            end

            Global.UI.setAttribute("mark_oath", "offsetXY", selectOathOffsets[curOath])
            Global.UI.setAttribute("panel_select_oath", "active", true)
        else -- end if (curGameNumPlayers > 1)
            printToAll("Error, at least one non-Chancellor player must also be selected.", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function changeOath(player, value, id)
    if (true == player.host) then
        curOath = oathNamesFromCode[tonumber(value)]
        Global.UI.setAttribute("mark_oath", "offsetXY", selectOathOffsets[curOath])
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmSelectOath(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_select_oath", "active", false)

        if (true == randomEnabled) then
            randomizeChronicle()
            cleanTable()
            loadFromSaveString(chronicleStateString, true)
        elseif (true == tutorialEnabled) then
            -- Load the prebaked tutorial chronicle string.
            cleanTable()
            loadFromSaveString(TUTORIAL_CHRONICLE_STATE_STRING, true)
        else
            cleanTable()
            setupGame()
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function cancelSelectOath(player, value, id)
    if (true == player.host) then
        Global.UI.setAttribute("panel_select_oath", "active", false)
        Global.UI.setAttribute("panel_select_players", "active", true)
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function randomizeChronicle()
    local availableSites = nil
    local numAvailableSites = 0
    local removeSiteIndex = 0
    local availableDenizens = nil
    local availableDenizenIndex = nil
    local numAvailableDenizens = 0
    local removeDenizenIndex = 0

    printToAll("Randomizing chronicle.", {1,1,1})

    --
    -- Randomize sites.
    --

    -- First, make a list of all site names.
    availableSites = {}
    numAvailableSites = 0
    for siteCode = 0, (NUM_TOTAL_SITES - 1) do
        -- Copy into 1-based array.
        availableSites[siteCode + 1] = sitesBySaveID[siteCode]
        numAvailableSites = (numAvailableSites + 1)
    end
    -- Next, assign random available sites.
    for siteIndex = 1,8 do
        removeSiteIndex = math.random(1, numAvailableSites)
        curMapSites[siteIndex][1] = availableSites[removeSiteIndex]
        table.remove(availableSites, removeSiteIndex)
        numAvailableSites = (numAvailableSites - 1)
    end
    -- Next, reset the facedown status of all sites to default.
    curMapSites[1][2] = false
    curMapSites[2][2] = true
    curMapSites[3][2] = false
    curMapSites[4][2] = true
    curMapSites[5][2] = true
    curMapSites[6][2] = false
    curMapSites[7][2] = true
    curMapSites[8][2] = true

    -- Reset denizen state.
    for siteIndex = 1,8 do
        for normalCardIndex = 1,3 do
            curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"   -- No card.
            curMapNormalCards[siteIndex][normalCardIndex][2] = false    -- NOT flipped.
        end
    end

    --
    -- Randomize world deck.
    --

    -- First, make a list of all denizen card names.
    availableDenizens = {}
    numAvailableDenizens = 0
    availableDenizenIndex = 1
    for denizenCode = 0, (NUM_TOTAL_DENIZENS - 1) do
        -- Copy into 1-based array.
        availableDenizens[availableDenizenIndex] = normalCardsBySaveID[denizenCode]
        availableDenizenIndex = (availableDenizenIndex + 1)
        numAvailableDenizens = (numAvailableDenizens + 1)
    end
    -- Now, generate a randomized world deck using the denizens as card options, and 54 denizens as the number to choose.
    generateRandomWorldDeck(availableDenizens, numAvailableDenizens, 54)
    -- Generate randomized relic deck.
    curRelicDeckCardCount = 0
    curRelicDeckCards = {}
    generateRandomRelicDeck()

    --
    -- Reset dispossessed deck.
    --

    curDispossessedDeckCardCount = 0
    curDispossessedDeckCards = {}

    -- Finally, generate the chronicle state string.
    chronicleStateString = generateSaveString()
end

-- If a game is in progress, scans the table and updates state variables.
function scanTable(alwaysScan)
    local scriptZoneObjects = nil
    local cardName = nil
    local cardInfo = nil
    local siteInfo = nil
    local cardRotation = 0

    -- Only scan the table if a game is in progress, or if the caller requested a scan always be performed.  Otherwise assume the table is up to date.
    if ((true == isGameInProgress) or (true == alwaysScan)) then
        scanPlayerAdvisers()

        -- Scan discard piles.
        for discardZoneIndex = 1,3 do
            discardContents[discardZoneIndex] = {}

            scriptZoneObjects = discardZones[discardZoneIndex].getObjects()
            for i,curObject in ipairs(scriptZoneObjects) do
                if ("Deck" == curObject.tag) then
                    -- Since a deck was encountered, scan it for Denizen or Vision cards.
                    for i,curCardInDeck in ipairs(curObject.getObjects()) do
                        cardName = curCardInDeck.nickname
                        cardInfo = cardsTable[cardName]

                        if (nil ~= cardInfo) then
                    if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
                    table.insert(discardContents[discardZoneIndex], cardName)
                        end
                        end
                    end
                elseif ("Card" == curObject.tag) then
                    cardName = curObject.getName()
                    cardInfo = cardsTable[cardName]

                    if (nil ~= cardInfo) then
                if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
                table.insert(discardContents[discardZoneIndex], cardName)
                    end
                    end
                else
                    -- Nothing needs done.
                end -- end if ("Deck" == curObject.tag)
            end -- end for i,curObject in ipairs(scriptZoneObjects)
        end -- end for discardZoneIndex = 1,3

        -- Scan map sites.
        for siteIndex = 1,8 do
            -- Reset the variables for this site before scanning.
            curMapNormalCards[siteIndex][1][1] = "NONE"     -- No card.
            curMapNormalCards[siteIndex][1][2] = false      -- NOT flipped.
            curMapNormalCards[siteIndex][2][1] = "NONE"     -- No card.
            curMapNormalCards[siteIndex][2][2] = false      -- NOT flipped.
            curMapNormalCards[siteIndex][3][1] = "NONE"     -- No card.
            curMapNormalCards[siteIndex][3][2] = false      -- NOT flipped.

            -- Find site card name.

            scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
            for i,curObject in ipairs(scriptZoneObjects) do
                if ("Card" == curObject.tag) then
                    siteInfo = cardsTable[curObject.getName()]

                    if (nil ~= siteInfo) then
                curMapSites[siteIndex][1] = curObject.getName()

                -- Detect whether the card is flipped.
                cardRotation = curObject.getRotation()
                if ((cardRotation[3] >= 150) and (cardRotation[3] <= 210)) then
                curMapSites[siteIndex][2] = true
                else
                curMapSites[siteIndex][2] = false
                end
                else
                printToAll("Error, invalid site card with name \"" .. curObject.getName() .. "\".", {1,0,0})
                    saveStatus = STATUS_FAILURE
                    end

                    break
                end
            end

            -- Find denizen card names.

            for normalCardIndex = 1,3 do
                scriptZoneObjects = mapNormalCardZones[siteIndex][normalCardIndex].getObjects()
                for i,curObject in ipairs(scriptZoneObjects) do
                    if ("Card" == curObject.tag) then
                        cardName = curObject.getName()
                        cardInfo = cardsTable[cardName]

                        if (nil ~= cardInfo) then
                    curMapNormalCards[siteIndex][normalCardIndex][1] = curObject.getName()

                    -- Detect whether the card is flipped.
                    cardRotation = curObject.getRotation()
                    if ((cardRotation[3] >= 150) and (cardRotation[3] <= 210)) then
                    curMapNormalCards[siteIndex][normalCardIndex][2] = true
                    else
                    curMapNormalCards[siteIndex][normalCardIndex][2] = false
                    end
                    else
                    printToAll("Error, invalid denizen/edifice/ruin/relic card with name \"" .. curObject.getName() .. "\".", {1,0,0})
                        saveStatus = STATUS_FAILURE
                        end

                        break
                    end -- end if ("Card" == curObject.tag)
                end -- end for i,curObject in ipairs(scriptZoneObjects)
            end -- end for normalCardIndex = 1,3
        end -- for siteIndex = 1,8

        -- Get the remaining world deck contents.
        remainingWorldDeck = {}
        scriptZoneObjects = worldDeckZone.getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
            if ("Deck" == curObject.tag) then
                for i,curCardInDeck in ipairs(curObject.getObjects()) do
                    cardName = curCardInDeck.nickname
                    cardInfo = cardsTable[cardName]

                    if (nil ~= cardInfo) then
                if ("Denizen" == cardInfo.cardtype) then
                table.insert(remainingWorldDeck, cardName)
                    end
                    end
                end
            elseif ("Card" == curObject.tag) then
                cardName = curObject.getName()
                cardInfo = cardsTable[cardName]

                if (nil ~= cardInfo) then
            if ("Denizen" == cardInfo.cardtype) then
            table.insert(remainingWorldDeck, cardName)
                end
                end
            else
                -- Nothing needs done.
            end
        end -- end for i,curObject in ipairs(scriptZoneObjects)
    end -- if ((true == isGameInProgress) or (true == alwaysScan))
end

function scanPlayerAdvisers()
    local testRotation = nil

    for i,curColor in ipairs(playerColors) do
        numPlayerAdvisers[curColor] = 0
        playerAdvisers[curColor] = {}
        playerAdvisersFacedown[curColor] = {}

        --
        -- Even though there are 3 adviser slots, scan stacked cards in case Family Wagon was used
        -- and cards were stacked before the Chronicle phase.
        --

        for adviserSlotIndex = 1,3 do
            scriptZoneObjects = playerAdviserZones[curColor][adviserSlotIndex].getObjects()
            for i,curObject in ipairs(scriptZoneObjects) do
                testRotation = curObject.getRotation()

                if ("Deck" == curObject.tag) then

                    -- Since a deck was encountered, scan it for Denizen cards.
                    for i,curCardInDeck in ipairs(curObject.getObjects()) do
                        cardName = curCardInDeck.nickname
                        cardInfo = cardsTable[cardName]

                        if (nil ~= cardInfo) then
                    if ("Denizen" == cardInfo.cardtype) then
                    numPlayerAdvisers[curColor] = (numPlayerAdvisers[curColor] + 1)
                    playerAdvisers[curColor][numPlayerAdvisers[curColor]] = cardName

                    -- Check if the adviser is facedown.
                    if ((testRotation[3] < 150) or (testRotation[3] > 210)) then
                    playerAdvisersFacedown[curColor][numPlayerAdvisers[curColor]] = false
                    else
                    playerAdvisersFacedown[curColor][numPlayerAdvisers[curColor]] = true
                        end
                        end
                        end -- end if (nil ~= cardInfo)
                    end
                elseif ("Card" == curObject.tag) then
                    cardName = curObject.getName()
                    cardInfo = cardsTable[cardName]

                    if (nil ~= cardInfo) then
                if ("Denizen" == cardInfo.cardtype) then
                numPlayerAdvisers[curColor] = (numPlayerAdvisers[curColor] + 1)
                playerAdvisers[curColor][numPlayerAdvisers[curColor]] = cardName

                -- Check if the adviser is facedown.
                if ((testRotation[3] < 150) or (testRotation[3] > 210)) then
                playerAdvisersFacedown[curColor][numPlayerAdvisers[curColor]] = false
                else
                playerAdvisersFacedown[curColor][numPlayerAdvisers[curColor]] = true
                    end
                    end
                    end -- end if (nil ~= cardInfo)
                end -- end if ("Card" == curObject.tag)
            end -- end for i,curObject in ipairs(scriptZoneObjects)
        end -- end for adviserSlotIndex = 1,3
    end -- end for i,curColor in ipairs(playerColors)
end

-- IMPORTANT:  The game end process (winner, suit choice and reordering, exile/citizen status update, new oath)
--             must be finished BEFORE this function is called.
function generateSaveString()
    local basicDataString = nil
    local mapDataString = nil
    local basicDataString = nil
    local worldDeckDataString = nil
    local dispossessedDataString = nil
    local relicDeckDataString = nil
    local previousGameInfoString = nil
    local saveString = nil
    local scriptZoneObjects = nil
    local siteInfo = nil
    local cardInfo = nil
    local cardRotation = 0
    -- Site, normal, normal, normal card save IDs respectively.
    local curSiteSaveIDs = { nil, nil, nil, nil }
    local deckCardID = nil

    -- Set the global save status.
    saveStatus = STATUS_SUCCESS

    --
    -- Generate basic data string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        basicDataString = string.format(
                "%02X%02X%02X%04X%02X%s%02X%02X%02X%01X%01X%01X%01X%01X%01X",
                OATH_MAJOR_VERSION,
                OATH_MINOR_VERSION,
                OATH_PATCH_VERSION,
                curGameCount,
                string.len(curChronicleName),
                curChronicleName,
                generatePreviousActiveStatusByte(),
                generateExileCitizenStatusByte(),
                oathCodes[curOath],
                suitCodes[curSuitOrder[1]],
                suitCodes[curSuitOrder[2]],
                suitCodes[curSuitOrder[3]],
                suitCodes[curSuitOrder[4]],
                suitCodes[curSuitOrder[5]],
                suitCodes[curSuitOrder[6]])
    end -- end if (STATUS_SUCCESS == saveStatus)

    --
    -- Generate map data string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        mapDataString = ""
        for siteIndex = 1,8 do
            -- Add 24 to represent a facedown site if needed.
            if (("NONE" ~= curMapSites[siteIndex][1]) and
        (true == curMapSites[siteIndex][2])) then
        curSiteSaveIDs[1] = (cardsTable[curMapSites[siteIndex][1]].saveid + 24)
        else
        curSiteSaveIDs[1] = cardsTable[curMapSites[siteIndex][1]].saveid
        end

        -- Set save IDs, adjusting if needed for ruins.
        for normalCardIndex = 1,3 do
        cardInfo = cardsTable[curMapNormalCards[siteIndex][normalCardIndex][1]]

        if (nil ~= cardInfo) then
        -- If the card is an edifice/ruin and it is flipped, increment the save ID.
        if (("EdificeRuin" == cardInfo.cardtype) and
        (true == curMapNormalCards[siteIndex][normalCardIndex][2])) then
        curSiteSaveIDs[1 + normalCardIndex] = (cardInfo.saveid + 1)
        else
        curSiteSaveIDs[1 + normalCardIndex] = cardInfo.saveid
        end
        else
        printToAll("Error, invalid normal card with name \"" .. curMapNormalCards[siteIndex][normalCardIndex][1] .. "\".", {1,0,0})
        saveStatus = STATUS_FAILURE
        end
        end

        mapDataString = (mapDataString .. string.format(
        "%02X%02X%02X%02X",
        curSiteSaveIDs[1],
        curSiteSaveIDs[2],
        curSiteSaveIDs[3],
            curSiteSaveIDs[4]))
        end -- end for siteIndex = 1,8
    end -- end if (STATUS_SUCCESS == saveStatus)

    --
    -- Generate world deck data string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        worldDeckDataString = string.format("%02X", curWorldDeckCardCount)
        for cardIndex = 1,curWorldDeckCardCount do
            deckCardID = cardsTable[curWorldDeckCards[cardIndex]].saveid
            worldDeckDataString = (worldDeckDataString .. string.format("%02X", deckCardID))   -- Card ID for denizen card or vision
        end
    end -- end if (STATUS_SUCCESS == saveStatus)

    --
    -- Generate dispossessed data string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        dispossessedDataString = string.format("%02X", curDispossessedDeckCardCount)
        for cardIndex = 1,curDispossessedDeckCardCount do
            deckCardID = cardsTable[curDispossessedDeckCards[cardIndex]].saveid
            dispossessedDataString = (dispossessedDataString .. string.format("%02X", deckCardID))    -- Card ID for denizen card or vision
        end
    end -- end if (STATUS_SUCCESS == saveStatus)

    --
    -- Generate relic deck data string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        relicDeckDataString = string.format("%02X", curRelicDeckCardCount)
        for cardIndex = 1,curRelicDeckCardCount do
            deckCardID = cardsTable[curRelicDeckCards[cardIndex]].saveid
            relicDeckDataString = (relicDeckDataString .. string.format("%02X", deckCardID))   -- Card ID for relic card
        end
    end -- end if (STATUS_SUCCESS == saveStatus)

    --
    -- Generate previous game info string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        -- Trim the Steam name if needed.
        if (string.len(curPreviousWinningSteamName) <= 255) then
            trimmedSteamName = curPreviousWinningSteamName
        else
            trimmedSteamName = string.sub(curPreviousWinningSteamName, 1, 255)
        end

        previousGameInfoString = string.format(
                "%02X%02X%02X%s",
                generatePreviousExileCitizenStatusByte(),
                generatePreviousWinningColorStatusByte(),
                string.len(trimmedSteamName),
                trimmedSteamName)
    end

    --
    -- Generate save string.
    --
    if (STATUS_SUCCESS == saveStatus) then
        saveString = (basicDataString .. mapDataString .. worldDeckDataString .. dispossessedDataString .. relicDeckDataString .. previousGameInfoString)
    end -- end if (STATUS_SUCCESS == saveStatus)

    return saveString
end

function generatePreviousActiveStatusByte()
    local generatedByte = 0x00

    -- The previous game active status byte is generated from most to least significant bits:
    --   0 (unused)
    --   1 == Clockwork Prince (bit set in addition to Chancellor) was active, 0 == was not active
    --   1 == Chancellor (bit always set) was active, 0 == was not active
    --   1 == Brown player (black pieces) was active, 0 == was not active
    --   1 == Yellow player was active, 0 == was not active
    --   1 == White player was active, 0 == was not active
    --   1 == Blue player was active, 0 == was not active
    --   1 == Red player was active, 0 == was not active

    -- Since the Tabletop Simulator version of Lua does not include normal bitwise operators,
    -- bit32.bor() is used for binary OR operations.

    if (true == curPreviousPlayersActive.Clock) then
        generatedByte = bit32.bor(generatedByte, 0x40)
    end

    if (true == curPreviousPlayersActive.Purple) then
        generatedByte = bit32.bor(generatedByte, 0x20)
    end

    if (true == curPreviousPlayersActive.Brown) then
        generatedByte = bit32.bor(generatedByte, 0x10)
    end

    if (true == curPreviousPlayersActive.Yellow) then
        generatedByte = bit32.bor(generatedByte, 0x08)
    end

    if (true == curPreviousPlayersActive.White) then
        generatedByte = bit32.bor(generatedByte, 0x04)
    end

    if (true == curPreviousPlayersActive.Blue) then
        generatedByte = bit32.bor(generatedByte, 0x02)
    end

    if (true == curPreviousPlayersActive.Red) then
        generatedByte = bit32.bor(generatedByte, 0x01)
    end

    return generatedByte
end

function generateExileCitizenStatusByte()
    local generatedByte = 0x00

    -- The exile/citizen status byte is generated from most to least significant bits:
    --   0 (unused)
    --   0 (unused)
    --   0 (unused)
    --   1 == Brown player (black pieces) is Citizen, 0 == Exile
    --   1 == Yellow player is Citizen, 0 == Exile
    --   1 == White player is Citizen, 0 == Exile
    --   1 == Blue player is Citizen, 0 == Exile
    --   1 == Red player is Citizen, 0 == Exile

    -- Since the Tabletop Simulator version of Lua does not include normal bitwise operators,
    -- bit32.bor() is used for binary OR operations.

    if ("Citizen" == (curPlayerStatus.Brown[1])) then
        generatedByte = bit32.bor(generatedByte, 0x10)
    end

    if ("Citizen" == (curPlayerStatus.Yellow[1])) then
        generatedByte = bit32.bor(generatedByte, 0x08)
    end

    if ("Citizen" == (curPlayerStatus.White[1])) then
        generatedByte = bit32.bor(generatedByte, 0x04)
    end

    if ("Citizen" == (curPlayerStatus.Blue[1])) then
        generatedByte = bit32.bor(generatedByte, 0x02)
    end

    if ("Citizen" == (curPlayerStatus.Red[1])) then
        generatedByte = bit32.bor(generatedByte, 0x01)
    end

    return generatedByte
end

function generatePreviousExileCitizenStatusByte()
    local generatedByte = 0x00

    -- The previous starting exile/citizen status byte is generated from most to least significant bits:
    --   0 (unused)
    --   0 (unused)
    --   0 (unused)
    --   1 == Brown player (black pieces) started as Citizen, 0 == Exile
    --   1 == Yellow player started as Citizen, 0 == Exile
    --   1 == White player started as Citizen, 0 == Exile
    --   1 == Blue player started as Citizen, 0 == Exile
    --   1 == Red player started as Citizen, 0 == Exile

    -- Since the Tabletop Simulator version of Lua does not include normal bitwise operators,
    -- bit32.bor() is used for binary OR operations.

    if ("Citizen" == (curPreviousPlayerStatus.Brown)) then
        generatedByte = bit32.bor(generatedByte, 0x10)
    end

    if ("Citizen" == (curPreviousPlayerStatus.Yellow)) then
        generatedByte = bit32.bor(generatedByte, 0x08)
    end

    if ("Citizen" == (curPreviousPlayerStatus.White)) then
        generatedByte = bit32.bor(generatedByte, 0x04)
    end

    if ("Citizen" == (curPreviousPlayerStatus.Blue)) then
        generatedByte = bit32.bor(generatedByte, 0x02)
    end

    if ("Citizen" == (curPreviousPlayerStatus.Red)) then
        generatedByte = bit32.bor(generatedByte, 0x01)
    end

    return generatedByte
end

function generatePreviousWinningColorStatusByte()
    local generatedByte = 0x00

    -- The previous winning color status byte is generated from most to least significant bits:
    --   0 (unused)
    --   0 (unused)
    --   1 == Purple player won
    --   1 == Brown player (black pieces) won
    --   1 == Yellow player won
    --   1 == White player won
    --   1 == Blue player won
    --   1 == Red player won

    -- Since the Tabletop Simulator version of Lua does not include normal bitwise operators,
    -- bit32.bor() is used for binary OR operations.

    if ("Purple" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x20)
    elseif ("Brown" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x10)
    elseif ("Yellow" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x08)
    elseif ("White" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x04)
    elseif ("Blue" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x02)
    elseif ("Red" == curPreviousWinningColor) then
        generatedByte = bit32.bor(generatedByte, 0x01)
    end

    return generatedByte
end

-- This function is used to clean up the table by deleting object(s), moving object(s) to default locations if needed, etc.
function cleanTable()
    local allObjects = nil
    local curObjectName = nil
    local curObjectDescription = nil
    local curObjectColor = nil
    local curObjectPosition = nil
    local curMarker = nil

    --
    -- Delete all decks and cards.  Move all pawns and warbands back to their starting locations and supply bags, respectively.
    --
    -- Also delete all favor and secret tokens other than the hidden unlabeled ones.
    --

    allObjects = getAllObjects()

    for i,curObject in ipairs(allObjects) do
        curObjectName = curObject.getName()

        if (("Deck" == curObject.tag) or ("Card" == curObject.tag)) then
            destroyObject(curObject)
        elseif ("Figurine" == curObject.tag) then
            curObjectDescription = curObject.getDescription()
            if ("Warband" == curObjectName) then
                if ("Black" == curObjectDescription) then
                    curObjectColor = "Brown"
                else
                    curObjectColor = curObjectDescription
                end

                -- Move the warband below the table so the warbands do not flicker as they cleanup.
                curObjectPosition = curObject.getPosition()
                -- Set the warband's rotation to match the starting pawn rotation, and put the warband back in the matching bag.
                curObject.setRotation({ 0.0, pawnStartYRotations[curObjectColor], 0.0 })
                curObject.setPosition({ curObjectPosition[1], (-3.5), curObjectPosition[3] })
                playerWarbandBags[curObjectColor].putObject(curObject)
            elseif ("Pawn" == curObjectName) then
                if ("Black" == curObjectDescription) then
                    curObjectColor = "Brown"
                else
                    curObjectColor = curObjectDescription
                end

                -- Move the pawn back to its starting position.
                curObject.setRotation({ 0.0, pawnStartYRotations[curObjectColor], 0.0 })
                curObject.setPosition(pawnStartPositions[curObjectColor])
            else
                -- Nothing needs done.
            end
        elseif ("Generic" == curObject.tag) then
            if (("Favor" == curObjectName) or
                    ("Favor (" == string.sub(curObject.getName(), 1, 7))) then
                destroyObject(curObject)
            elseif ("Secret" == curObjectName) then
                destroyObject(curObject)
            end
        else
            -- Nothing needs done.
        end
    end

    -- Empty favor bag.
    if (nil ~= favorBag) then
    favorBag.reset()
    end

    -- Reset markers to default locations.
    for markerIndex = 1,numMarkers do
    curMarker = getObjectFromGUID(markerGuids[markerIndex])
    if (nil ~= curMarker) then
    curMarker.setPosition({ markerPositions[markerIndex][1], markerPositions[markerIndex][2], markerPositions[markerIndex][3] })
    curMarker.setRotation({ 0, 0, 0 })
    else
    printToAll("Error finding object.", {1,0,0})
    end
    end

    -- Hide pieces for all players.
    for i,curColor in ipairs(playerColors) do
    hidePieces(curColor)
    end

    -- Hide dice.
    hideDice()
end

function showDice()
    local curDie = nil

    for dieIndex = 1,#diceGuids do
        curDie = getObjectFromGUID(diceGuids[dieIndex])
        if (nil ~= curDie) then
    curDie.setPosition({ dicePositions[dieIndex][1], dicePositions[dieIndex][2], dicePositions[dieIndex][3] })
    if (#diceGuids == dieIndex) then
    curDie.setRotation({ 270, 0, 0 })
    else
    curDie.setRotation({ 90, 0, 0 })
    end

    curDie.locked = false
    curDie.interactable = true
    else
    printToAll("Error finding die.", {1,0,0})
        end
    end
end

function hideDice()
    local curDie = nil

    for dieIndex = 1,#diceGuids do
        curDie = getObjectFromGUID(diceGuids[dieIndex])
        if (nil ~= curDie) then
    curDie.setPosition({ dicePositions[dieIndex][1], (-3.5), dicePositions[dieIndex][3] })
    if (#diceGuids == dieIndex) then
    curDie.setRotation({ 270, 0, 0 })
    else
    curDie.setRotation({ 90, 0, 0 })
    end

    curDie.locked = true
    curDie.interactable = false
    else
    printToAll("Error finding die.", {1,0,0})
        end
    end
end

function setWarbandBagsMuted(muteBags)
    for i,curColor in ipairs(playerColors) do
        playerWarbandBags[curColor].getComponent("AudioSource").set("mute", muteBags)
    end
end

function setupLoadedState(setupGameAfter)
    -- Reset expected and actual spawn count.
    loadExpectedSpawnCount = 0
    loadActualSpawnCount = 0

    --
    -- Copy the load variables into the corresponding game variables.
    --

    curGameCount = loadGameCount
    curChronicleName = loadChronicleName

    curPreviousWinningColor = loadPreviousWinningColor
    curPreviousWinningSteamName = loadPreviousWinningSteamName

    -- Players will be detected in the loop below.
    curGameNumPlayers = 0

    for loopKey,loopValue in pairs(loadPreviousPlayersActive) do
        curPreviousPlayersActive[loopKey] = loopValue
    end

    for loopKey,loopValue in pairs(loadPreviousPlayerStatus) do
        curPreviousPlayerStatus[loopKey] = loopValue
    end

    for loopKey,loopValue in pairs(loadPlayerStatus) do
        curStartPlayerStatus[loopKey] = loopValue[1]
        curPlayerStatus[loopKey][1] = loopValue[1]

        --
        -- Only update active player status if the game is NOT being setup after this.
        --
        -- If setup will run after this, then the current active player status is already correct,
        -- and the loaded status might be incorrect, e.g. the default state.
        --
        if (false == setupGameAfter) then
            curPlayerStatus[loopKey][2] = loopValue[2]
        end

        -- If the player is active, increment the number of players.
        if (true == curPlayerStatus[loopKey][2]) then
            curGameNumPlayers = (curGameNumPlayers + 1)
        end
    end

    curOath = loadCurOath

    for loopIndex,loopValue in ipairs(loadSuitOrder) do
        curSuitOrder[loopIndex] = loopValue
    end

    for loopIndex,loopValue in ipairs(loadMapSites) do
        curMapSites[loopIndex][1] = loopValue[1]
        curMapSites[loopIndex][2] = loopValue[2]
    end

    for loopIndex,loopValue in ipairs(loadMapNormalCards) do
        curMapNormalCards[loopIndex][1][1] = loopValue[1][1]
        curMapNormalCards[loopIndex][1][2] = loopValue[1][2]
        curMapNormalCards[loopIndex][2][1] = loopValue[2][1]
        curMapNormalCards[loopIndex][2][2] = loopValue[2][2]
        curMapNormalCards[loopIndex][3][1] = loopValue[3][1]
        curMapNormalCards[loopIndex][3][2] = loopValue[3][2]
    end

    curWorldDeckCardCount = loadWorldDeckInitCardCount
    curWorldDeckCards = {}
    for cardIndex = 1,curWorldDeckCardCount do
        curWorldDeckCards[cardIndex] = loadWorldDeckInitCards[cardIndex]
    end

    curDispossessedDeckCardCount = loadDispossessedDeckInitCardCount
    curDispossessedDeckCards = {}
    for cardIndex = 1,curDispossessedDeckCardCount do
        curDispossessedDeckCards[cardIndex] = loadDispossessedDeckInitCards[cardIndex]
    end

    curRelicDeckCardCount = loadRelicDeckInitCardCount
    curRelicDeckCards = {}
    for cardIndex = 1,curRelicDeckCardCount do
        curRelicDeckCards[cardIndex] = loadRelicDeckInitCards[cardIndex]
    end

    -- Update player board exile/citizen flipping status.
    for i,curColor in ipairs(playerColors) do
        updatePlayerBoardRotation(curColor)
    end

    if (true == isGameInProgress) then
        -- If a game is in progress, do not spawn anything.  Go directly to the end of the load process.
        finishSetupLoadedState(setupGameAfter)
    else
        -- Briefly wait before spawning the new cards.
        Wait.time(function() continueSetupLoadedState(setupGameAfter) end, 0.05)
    end
end

function continueSetupLoadedState(setupGameAfter)
    finishSetupLoadedState(setupGameAfter)
end

function finishSetupLoadedState(setupGameAfter)
    local convertedColor = nil
    local statusString = nil

    loadWaitID = nil

    if (STATUS_SUCCESS == loadStatus) then
        if (false == isManualControlEnabled) then
            printToAll("Load successful.", {0,0.8,0})
            printToAll("", {1,1,1})
            printToAll("Ready for game #" .. loadGameCount .. " of the chronicle \"" .. loadChronicleName .. "\".", {1,1,1})
            printToAll("The current oath is \"" .. fullOathNames[curOath] .. "\".", {1,1,1})

            printToAll("", {1,1,1})
            printToAll("Starting state from previous game:")
            for i,curColor in ipairs(playerColors) do
                if (true == loadPreviousPlayersActive[curColor]) then
                    if ("Purple" == curColor) then
                        if (true == loadPreviousPlayersActive["Clock"]) then
                            statusString = " (active, Clockwork Prince)"
                        else
                            statusString = " (active, Chancellor)"
                        end
                    else
                        statusString = " (active)"
                    end
                else
                    statusString = " [555555](inactive)[-]"
                end

                if ("Brown" == curColor) then
                    printToAll("   [000000]Black[-]:  " .. loadPreviousPlayerStatus[curColor] .. statusString, {1,1,1})
                else
                    printToAll("   [" .. Color.fromString(curColor):toHex(false) .. "]" .. curColor .. "[-]:  " .. loadPreviousPlayerStatus[curColor] .. statusString, {1,1,1})
                end
            end
            printToAll("", {1,1,1})
            printToAll("Starting state for current game:")
            for i,curColor in ipairs(playerColors) do
                if (true == loadPlayerStatus[curColor][2]) then
                    if ("Brown" == curColor) then
                        printToAll("   [000000]Black[-]:  " .. loadPlayerStatus[curColor][1], {1,1,1})
                    else
                        printToAll("   [" .. Color.fromString(curColor):toHex(false) .. "]" .. curColor .. "[-]:  " .. loadPlayerStatus[curColor][1], {1,1,1})
                    end
                end
            end
            printToAll("", {1,1,1})
            if ("Brown" == loadPreviousWinningColor) then
                convertedColor = "Black"
            else
                convertedColor = loadPreviousWinningColor
            end
            printToAll("Winning color from previous game:  [" .. Color.fromString(convertedColor):toHex(false) .. "]" .. convertedColor .. "[-]", {1,1,1})
            printToAll("Winning Steam name from previous game:  [" .. Color.fromString(convertedColor):toHex(false) .. "]" .. loadPreviousWinningSteamName .. "[-]", {1,1,1})
            printToAll("", {1,1,1})
        end

        if (true == isGameInProgress) then
            configGeneralButtons(BUTTONS_IN_GAME)

            if (false == isManualControlEnabled) then
                printToAll("Game already in progress.  Active players:", {1,1,1})
                for i,curColor in ipairs(playerColors) do
                    if (true == loadPlayerStatus[curColor][2]) then
                        if ("Brown" == curColor) then
                            printToAll("   [000000]Black[-]:  " .. loadPlayerStatus[curColor][1], {1,1,1})
                        else
                            printToAll("   [" .. Color.fromString(curColor):toHex(false) .. "]" .. curColor .. "[-]:  " .. loadPlayerStatus[curColor][1], {1,1,1})
                        end
                    end
                end
            end -- end if (false == isManualControlEnabled)
        else -- end if (true == isGameInProgress)
            configGeneralButtons(BUTTONS_NOT_IN_GAME)
        end

        -- The following can be used for load timing.
        --printToAll("Time:  " .. Time.time, {1,1,1})

        if (true == setupGameAfter) then
            setupGame()
        else
            printToAll("Save your progress using \"Games\" at the top of the screen.", {0,0.8,0})
        end
    end -- end if (STATUS_SUCCESS == loadStatus)

    printToAll("", {1,1,1})
end

function resetOathkeeperToken()
    if (nil ~= curOathkeeperToken) then
    curOathkeeperToken.setPosition({ oathkeeperStartPosition[1], oathkeeperStartPosition[2], oathkeeperStartPosition[3] })
    curOathkeeperToken.setRotation({ oathkeeperStartRotation[1], oathkeeperStartRotation[2], oathkeeperStartRotation[3] })
    curOathkeeperToken.setScale({ oathkeeperStartScale[1], oathkeeperStartScale[2], oathkeeperStartScale[3] })

    if (false == isManualControlEnabled) then
    curOathkeeperToken.setName(fullOathNames[curOath] .. ":  Oathkeeper / Usurper")
    curOathkeeperToken.setDescription(oathDescriptions[curOath])
    else
    curOathkeeperToken.setName("Oathkeeper / Usurper")
    curOathkeeperToken.setDescription("")
    end
    else
    printToAll("Error, oathkeeper token not found.", {1,0,0})
    end
end

function spawnSingleCard(cardName, spawnFacedown, spawnPosition, cardRotY, spawnInHand)
    local spawnStatus = STATUS_SUCCESS
    -- Create a copy of the spawn position to avoid problems with the data changing elsewhere.
    local spawnPositionLocal = { spawnPosition[1], spawnPosition[2], spawnPosition[3] }
    local spawnParams = {}
    local cardJSON = nil
    local cardDeckID = 0
    local cardInfo = cardsTable[cardName]
    local cardDescription = nil
    local ttsCardID = 0
    local cardType = nil
    local cardTTSDeckInfo = nil
    local cardScaleX = 0
    local cardScaleZ = 0
    local internalCardRotZ = 0.0
    local shouldUnlock = false
    local shouldHideWhenFaceDown = true

    if (nil ~= cardInfo) then
    ttsCardID = cardInfo.ttscardid
    cardType = cardInfo.cardtype

    if ("Site" == cardType) then
    cardScaleX = 1.46
    cardScaleZ = 1.46
    shouldUnlock = false
    elseif ("Relic" == cardType) then
    cardScaleX = 0.96
    cardScaleZ = 0.96
    shouldUnlock = true
    elseif ("SuperRelic" == cardType) then
    cardScaleX = 0.96
    cardScaleZ = 0.96
    shouldUnlock = true
    else
    -- Use default scaling for other cards.
    cardScaleX = 1.50
    cardScaleZ = 1.50
    shouldUnlock = true
    end

    -- If spawning a card in the player's hand, always unlock it.
    if (true == spawnInHand) then
    shouldUnlock = true
    end

    -- All cards spawn facedown and will unflip if needed after loading.
    internalCardRotZ = 180.0

    -- Edifice / ruin cards should not hide the tooltip even when facedown.  Same for The Grand Scepter.
    if (("EdificeRuin" == cardType) or ("SuperRelic" == cardType)) then
    shouldHideWhenFaceDown = false
    end

    cardDeckID = string.sub(ttsCardID, 1, -3)

    if (nil ~= cardInfo.faqText) then
    cardDescription = cardInfo.faqText
    else
    cardDescription = NO_FAQ_TEXT
    end

    cardJSON = {
    Name = "Card",
    Transform = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.0,
    rotX = 0.0,
    rotY = cardRotY,
    rotZ = internalCardRotZ,
    scaleX = cardScaleX,
    scaleY = 1.00,
    scaleZ = cardScaleZ
    },
    Nickname = cardName,
    Description = cardDescription,
    ColorDiffuse = {
    r = 0.713235259,
    g = 0.713235259,
    b = 0.713235259
    },
    -- Spawn locked so the card does not fall underneath the table.
    Locked = true,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    CardID = ttsCardID,
    SidewaysCard = false,
    HideWhenFaceDown = shouldHideWhenFaceDown,
    CustomDeck = {},
    LuaScript = "",
    LuaScriptState = "",
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "700000"
    }

    cardTTSDeckInfo = ttsDeckInfo[tonumber(cardDeckID)]
    if (nil ~= cardTTSDeckInfo) then
    cardJSON.CustomDeck[cardDeckID] = {
    FaceURL = cardTTSDeckInfo.deckimage,
    BackURL = cardTTSDeckInfo.backimage,
    NumWidth = cardTTSDeckInfo.deckwidth,
    NumHeight = cardTTSDeckInfo.deckheight,
    BackIsHidden = true,
    UniqueBack = cardTTSDeckInfo.hasuniqueback
    }
    else
    printToAll("Failed to find deck with ID \"" .. cardDeckID .. "\".", {1,0,0})
    spawnStatus = STATUS_FAILURE
    end

    -- Spawn the card underneath the table so it can be mvoed up instead of flashing white.
    if (STATUS_SUCCESS == spawnStatus) then
    spawnParams.json = JSON.encode(cardJSON)
    spawnParams.position = { spawnPositionLocal[1], (-3.5), spawnPositionLocal[3] }
    spawnParams.rotation = { 0, cardRotY, internalCardRotZ }
    spawnParams.callback_function = function(spawnedObject)
    handleSpawnedObject(spawnedObject,
    { spawnPositionLocal[1], spawnPositionLocal[2], spawnPositionLocal[3] },
    shouldUnlock,
    spawnFacedown) end

    -- Update expected spawn count and spawn the object.
    loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
    spawnObjectJSON(spawnParams)
    end
    else -- end if (nil ~= cardInfo)
    if (nil ~= cardName) then
    printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
    else
    printToAll("Cannot spawn card with no name.", {1,0,0})
    end

    spawnStatus = STATUS_FAILURE
    end
end

function handleSpawnedObject(spawnedObject, finalPosition, shouldUnlock, spawnFacedown)
    local curRotation = spawnedObject.getRotation()
    local internalRotationZ = 0.0

    -- Unlock the object if needed.
    if (true == shouldUnlock) then
        spawnedObject.locked = false
    end

    -- Move the object fast without collision.
    spawnedObject.setPositionSmooth(finalPosition, false, true)

    -- Update the rotation in case the object needs to turn faceup.
    if (true == spawnFacedown) then
        internalRotationZ = 180.0
    else
        internalRotationZ = 0.0
    end

    spawnedObject.setRotation({ curRotation[1], curRotation[2], internalRotationZ })

    -- Update the actual spawn count.
    loadActualSpawnCount = (loadActualSpawnCount + 1)
end

function setupGame()
    local availableSites = nil
    local numAvailableSites = 0
    local curSiteName = nil
    local siteCardName = nil
    local siteCardInfo = nil
    local normalCardName = nil
    local normalCardInfo = nil
    local cardSpawnPosition = {}
    local newSiteIndex = nil
    local deckOffset = 0
    local siteRelicCount = 0
    local emptySpaceFound = false

    if (false == isManualControlEnabled) then
        printToAll("Dealing to players:", {1,1,1})
    end

    for i,curColor in ipairs(playerColors) do
        if (true == curPlayerStatus[curColor][2]) then
            resetSupplyCylinder(curColor)
            showPieces(curColor)

            if (false == isManualControlEnabled) then
                if ("Brown" == curColor) then
                    printToAll("  [000000]Black[-]", {1,1,1})
                else
                    printToAll("  [" .. Color.fromString(curColor):toHex(false) .. "]" .. curColor .. "[-]", {1,1,1})
                end
            end
        else
            hidePieces(curColor)
        end
    end

    -- Show general pieces.
    showGeneralPieces()

    -- Update the oathkeeper token in case the oath was changed.
    resetOathkeeperToken()

    if (false == isManualControlEnabled) then
        -- If needed, generate randomized relic deck.  This is done now before relics are dealt.
        if ((1 == curGameCount) and (false == tutorialEnabled)) then
            curRelicDeckCardCount = 0
            curRelicDeckCards = {}
            generateRandomRelicDeck()

            -- This is the first game of a chronicle.  First, make a list of all site names.
            availableSites = {}
            for siteCode = 0, (NUM_TOTAL_SITES - 1) do
                -- Copy into 1-based array.
                availableSites[siteCode + 1] = sitesBySaveID[siteCode]
            end
            numAvailableSites = NUM_TOTAL_SITES
            -- Next, determine which sites are being used and remove them from the available list.
            for siteIndex = 1,8 do
                curSiteName = curMapSites[siteIndex][1]
                if ("NONE" ~= curSiteName) then
            for removeSiteIndex = 1, numAvailableSites do
            if (curSiteName == availableSites[removeSiteIndex]) then
            table.remove(availableSites, removeSiteIndex)
            numAvailableSites = (numAvailableSites - 1)
            break
            end
            end
            end
            end
            -- Now, deal sites to fill the empty slots.
            for siteIndex = 1,8 do
                if ("NONE" == curMapSites[siteIndex][1]) then
                    -- Pick a random site from the available list.
                    newSiteIndex = math.random(1, numAvailableSites)

                    -- Add site card facedown.
                    curMapSites[siteIndex][1] = availableSites[newSiteIndex]
                    curMapSites[siteIndex][2] = true

                    -- Spawn the physical site card facedown.
                    spawnSingleCard(curMapSites[siteIndex][1], true, siteCardSpawnPositions[siteIndex], 180, false)

                    -- Remove the site from the available list.
                    table.remove(availableSites, newSiteIndex)
                    numAvailableSites = (numAvailableSites - 1)
                else
                    -- Spawn the physical site card faceup or facedown depending on the state.
                    spawnSingleCard(curMapSites[siteIndex][1], curMapSites[siteIndex][2], siteCardSpawnPositions[siteIndex], 180, false)

                    -- Spawn any denizen, edifice, ruin, or relic cards at the site.
                    siteRelicCount = 0
                    for normalCardIndex = 1,3 do
                        normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
                        normalCardInfo = cardsTable[normalCardName]

                        if (nil ~= normalCardInfo) then
                    if ("NONE" ~= normalCardInfo.cardtype) then
                    cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
                    cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
                    cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

                    spawnSingleCard(normalCardName, curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)

                    if ("Relic" == normalCardInfo.cardtype) then
                    siteRelicCount = (siteRelicCount + 1)
                    end
                    end -- end if ("NONE" ~= normalCardInfo.cardtype)
                    else -- end if (nil ~= normalCardInfo)
                    printToAll("Error loading card \"" .. normalCardName .. "\"", {1,0,0})
                        loadStatus = STATUS_FAILURE
                        end
                    end -- end looping through normal cards

                    -- Check if the site is faceup.
                    if (false == curMapSites[siteIndex][2]) then
                        -- Since this is the first game, if a faceup site has relic capacity and not enough relics are included, deal some facedown from the relic deck.
                        while (siteRelicCount < cardsTable[curMapSites[siteIndex][1]].relicCount) do
                            emptySpaceFound = false

                            -- Note this goes from 3 down to 1 to deal from right to left.
                            for normalCardIndex = 3,1,-1 do
                                normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
                                normalCardInfo = cardsTable[normalCardName]

                                if (nil ~= normalCardInfo) then
                            if ("NONE" == normalCardInfo.cardtype) then
                            emptySpaceFound = true
                            cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
                            cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
                            cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

                            -- This is an empty slot, so deal a relic facedown.
                            if (curRelicDeckCardCount > 0) then
                            curMapNormalCards[siteIndex][normalCardIndex][1] = curRelicDeckCards[curRelicDeckCardCount]
                            curMapNormalCards[siteIndex][normalCardIndex][2] = true
                            spawnSingleCard(curMapNormalCards[siteIndex][normalCardIndex][1], curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)

                            table.remove(curRelicDeckCards, curRelicDeckCardCount)
                            curRelicDeckCardCount = (curRelicDeckCardCount - 1)
                            else
                            -- This should never happen, but avoids problems with old chronicles that had missing relics.
                            printToAll("Error, ran out of relics while dealing.", {1,0,0})
                            end

                            -- Even if a card was not found, increase the site relic count so the loop finishes.
                            siteRelicCount = (siteRelicCount + 1)
                            break
                                end -- end if ("NONE" == normalCardInfo.cardtype)
                                end -- end if (nil ~= normalCardInfo)
                            end -- end for normalCardIndex = 3,1,-1

                            if (false == emptySpaceFound) then
                                printToAll("Error, no empty space found to deal relic.", {1,0,0})
                                break
                            end
                        end -- end while (siteRelicCount < cardsTable[curMapSites[siteIndex][1]].relicCount)
                    end -- end if (false == curMapSites[siteIndex][2])
                end -- end if ("NONE" == curMapSites[siteIndex][1])
            end -- for siteIndex = 1,8

            if (false == randomEnabled) then
                -- This is the normal case for the first game, so create a randomized default world deck with visions included.
                generateRandomWorldDeck({}, 0, 0)
            else
                -- For random setup, actually DO NOT generate a randomized world deck, since a random world deck was already generated
                -- that specifically has 3 denizens on the bottom which are compatible with the map (not player-only).
                --
                -- Nothing needs done here.
            end
        else -- end if ((1 == curGameCount) and (false == tutorialEnabled)) then
            --
            -- Spawn sites, denizens, edifices, ruins, and relics as needed.
            --

            for siteIndex = 1,8 do
                siteCardName = curMapSites[siteIndex][1]
                siteCardInfo = cardsTable[siteCardName]

                if (nil ~= siteCardInfo) then
            if ("NONE" ~= siteCardInfo.cardtype) then
            -- Spawn the physical site card faceup or facedown depending on the state.
            spawnSingleCard(siteCardName, curMapSites[siteIndex][2], siteCardSpawnPositions[siteIndex], 180, false)

            for normalCardIndex = 1,3 do
            normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            normalCardInfo = cardsTable[normalCardName]

            if (nil ~= normalCardInfo) then
            if ("NONE" ~= normalCardInfo.cardtype) then
            cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
            cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
            cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

            spawnSingleCard(normalCardName, curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)
            end -- end if ("NONE" ~= normalCardInfo.cardtype)
            else -- end if (nil ~= normalCardInfo)
            printToAll("Error loading card \"" .. normalCardName .. "\"", {1,0,0})
            loadStatus = STATUS_FAILURE
            end
            end -- end looping through normal cards
            end -- end if ("NONE" ~= siteCardInfo.cardtype)
            else -- end if (nil ~= siteCardInfo)
            printToAll("Error loading card \"" .. siteCardName .. "\"", {1,0,0})
                loadStatus = STATUS_FAILURE
                end
            end -- end looping through site cards
        end -- end if (STATUS_SUCCESS == loadStatus)

        -- Deck offset is adjusted instead of the world deck data structure so that the world deck is unmodified for chronicle purposes.
        deckOffset = 0

        if (true == randomEnabled) then
            --
            -- If random cards are being used, deal a denizen card from the bottom of the deck to each site with a capacity of at least one.
            --

            for siteIndex = 1,8 do
                -- Reset denizens and relics.
                curMapNormalCards[siteIndex][1][1] = "NONE"    -- No card.
                curMapNormalCards[siteIndex][1][2] = false     -- NOT flipped.

                if (false == curMapSites[siteIndex][2]) then
                    if (curMapSites[siteIndex][1] ~= "NONE") then
                if (cardsTable[curMapSites[siteIndex][1]].capacity > 0) then
                -- Deal a denizen card in the leftmost slot.
                cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[1])
                cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
                cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

                curMapNormalCards[siteIndex][1][1] = curWorldDeckCards[curWorldDeckCardCount - deckOffset]
                deckOffset = (deckOffset + 1)

                spawnSingleCard(curMapNormalCards[siteIndex][1][1], curMapNormalCards[siteIndex][1][2], cardSpawnPosition, 180, false)
                end -- end if (cardsTable[curMapSites[siteIndex][1]].capacity > 0)
                    end -- end if (curMapSites[siteIndex][1] ~= "NONE")
                end -- end if (false == curMapSites[siteIndex][2])
            end -- end for siteIndex = 1,8
        end -- end if (true == randomEnabled)

        if (false == tutorialEnabled) then
            -- Spawn the bottom 3 world deck cards on the discard piles, facedown.
            for discardIndex = 1,3 do
                spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, discardPileSpawnPositions[discardIndex], 90, false)
                deckOffset = (deckOffset + 1)
            end

            -- For each player, deal 3 cards from the bottom of the deck, faceup.
            for i,curColor in ipairs(playerColors) do
                -- Check if the player is active before dealing to them.
                if (true == curPlayerStatus[curColor][2]) then
                    for cardIndex = 1,3 do
                        spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], false, handCardSpawnPositions[curColor][cardIndex], handCardYRotations[curColor], true)
                        deckOffset = (deckOffset + 1)
                    end
                end
            end
        else -- end if (false == tutorialEnabled)
            -- For tutorial mode, dealing will be simulated to spawn all cards directly.
            deckOffset = 0

            -- Each discard structure is ordered bottom to top.
            local cradleDiscards = {}
            local provincesDiscards  = {}
            local hinterlandDiscards = {}
            local curColor = nil

            table.insert(cradleDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(provincesDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(hinterlandDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)

            -- Spawn a facedown adviser for each player, adding the other hand cards for that player to the various discard decks.

            curColor = "Purple"
            spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, tutorialAdviserPositions[curColor], handCardYRotations[curColor], false)
            deckOffset = (deckOffset + 1)
            table.insert(provincesDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(provincesDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)

            curColor = "Red"
            spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, tutorialAdviserPositions[curColor], handCardYRotations[curColor], false)
            deckOffset = (deckOffset + 1)
            table.insert(hinterlandDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(hinterlandDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)

            curColor = "Blue"
            spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, tutorialAdviserPositions[curColor], handCardYRotations[curColor], false)
            deckOffset = (deckOffset + 1)
            table.insert(hinterlandDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(hinterlandDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)

            curColor = "Yellow"
            spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, tutorialAdviserPositions[curColor], handCardYRotations[curColor], false)
            deckOffset = (deckOffset + 1)
            table.insert(cradleDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)
            table.insert(cradleDiscards, curWorldDeckCards[curWorldDeckCardCount - deckOffset])
            deckOffset = (deckOffset + 1)

            -- Spawn discard decks.

            spawnDiscardDeck(cradleDiscards, discardPileSpawnPositions[1])
            spawnDiscardDeck(provincesDiscards, discardPileSpawnPositions[2])
            spawnDiscardDeck(hinterlandDiscards, discardPileSpawnPositions[3])
        end -- end if (false == tutorialEnabled)

        -- Spawn favor tokens.
        spawnFavor()

        -- Spawn world deck with remaining cards.
        spawnWorldDeck(deckOffset)

        -- Deal facedown relics to the reliquary slots.
        for reliquaryIndex = 1,4 do
            if (curRelicDeckCardCount > 0) then
                spawnSingleCard(curRelicDeckCards[curRelicDeckCardCount], true, reliquaryCardPositions[reliquaryIndex], 0, false)

                table.remove(curRelicDeckCards, curRelicDeckCardCount)
                curRelicDeckCardCount = (curRelicDeckCardCount - 1)
            else
                -- This should never happen, but avoids problems with old chronicles that had missing relics.
                printToAll("Error, ran out of relics while dealing.", {1,0,0})
            end
        end

        -- Spawn relic deck with remaining cards.
        spawnRelicDeck()

        -- Mark the game as in progress.
        isGameInProgress = true
        randomEnabled = false

        -- Change the buttons configuration.
        configGeneralButtons(BUTTONS_IN_GAME)

        -- Announce that setup is complete.
        printToAll("This game uses the " .. fullOathNames[curOath], {1,1,1})
        printToAll("SETUP COMPLETE.", {0,0.8,0})

        -- If this is the first game for the chronicle, prompt the user to potentially change the name.
        if (1 == curGameCount) then
            showChronicleNameDialog()
        end
    else -- end if (false == isManualControlEnabled)
        -- Mark the game as in progress.
        isGameInProgress = true
        randomEnabled = false

        -- Spawn favor tokens.
        spawnFavor()

        -- Change the buttons configuration.
        configGeneralButtons(BUTTONS_IN_GAME)

        -- Announce that setup is complete.
        printToAll("", {1,1,1})
        printToAll("SETUP COMPLETE.", {0,0.8,0})
    end
end

function resetSupplyCylinder(playerColor)
    playerSupplyMarkers[playerColor].setPosition({ supplyMarkerStartPositions[playerColor][1], supplyMarkerStartPositions[playerColor][2], supplyMarkerStartPositions[playerColor][3] })
end

function showGeneralPieces()
    local tokenOffset = 0.0

    if (false == isManualControlEnabled) then
        curOathkeeperToken.setPosition({ oathkeeperStartPosition[1], oathkeeperStartPosition[2], oathkeeperStartPosition[3] })
        curOathkeeperToken.locked = false
        curOathkeeperToken.interactable = true
        curOathkeeperToken.tooltip = true

        for loopOathName,loopOathCode in pairs(oathCodes) do
            if (nil ~= oathReminderTokens[loopOathName]) then
        if (curOath == loopOathName) then
        oathReminderTokens[loopOathName].setPosition({ oathReminderStartPosition[1], oathReminderStartPosition[2], oathReminderStartPosition[3] })
        oathReminderTokens[loopOathName].setRotation({ oathReminderStartRotation[1], oathReminderStartRotation[2], oathReminderStartRotation[3] })
        oathReminderTokens[loopOathName].locked = false
        oathReminderTokens[loopOathName].interactable = true
        oathReminderTokens[loopOathName].tooltip = true
        else
        oathReminderTokens[loopOathName].setPosition({ oathReminderTokenHidePositions[loopOathName][1],
        oathReminderTokenHidePositions[loopOathName][2],
        oathReminderTokenHidePositions[loopOathName][3] })
        oathReminderTokens[loopOathName].setRotation({ oathReminderStartRotation[1], oathReminderStartRotation[2], oathReminderStartRotation[3] })
        oathReminderTokens[loopOathName].locked = true
        oathReminderTokens[loopOathName].interactable = false
        oathReminderTokens[loopOathName].tooltip = false
            end
            end
        end
    else -- end if (false == isManualControlEnabled)
        curOathkeeperToken.setPosition({ oathkeeperStartPosition[1], oathkeeperStartPosition[2], oathkeeperStartPosition[3] })
        curOathkeeperToken.locked = false
        curOathkeeperToken.interactable = true
        curOathkeeperToken.tooltip = true

        tokenOffset = 0.0
        for loopOathName,loopOathCode in pairs(oathCodes) do
            if (nil ~= oathReminderTokens[loopOathName]) then
        oathReminderTokens[loopOathName].setPosition({ (oathReminderStartPosition[1] + tokenOffset),
        (oathReminderStartPosition[2] + tokenOffset),
        (oathReminderStartPosition[3] + tokenOffset) })
        oathReminderTokens[loopOathName].setRotation({ oathReminderStartRotation[1], oathReminderStartRotation[2], oathReminderStartRotation[3] })
        oathReminderTokens[loopOathName].locked = false
        oathReminderTokens[loopOathName].interactable = true
        oathReminderTokens[loopOathName].tooltip = true

        tokenOffset = (tokenOffset + 0.2)
            end
        end
    end

    spawnSingleCard("The Grand Scepter", true, grandScepterStartPosition, 0.0, false)

    if (("Devotion" == curOath) and (false == isManualControlEnabled)) then
        darkestSecret.setPosition({ chancellorSpecialStartPosition[1], chancellorSpecialStartPosition[2], chancellorSpecialStartPosition[3] })
        darkestSecret.locked = false
        darkestSecret.interactable = true
        darkestSecret.tooltip = true
    else
        darkestSecret.setPosition({ darkestSecretShowPosition[1], darkestSecretShowPosition[2], darkestSecretShowPosition[3] })
        darkestSecret.setRotation({ 0, 180, 0 })
        darkestSecret.locked = false
        darkestSecret.interactable = true
        darkestSecret.tooltip = true
    end

    if (("People" == curOath) and (false == isManualControlEnabled)) then
        peoplesFavor.setPosition({ chancellorSpecialStartPosition[1], chancellorSpecialStartPosition[2], chancellorSpecialStartPosition[3] })
        peoplesFavor.locked = false
        peoplesFavor.interactable = true
        peoplesFavor.tooltip = true
    else
        peoplesFavor.setPosition({ peoplesFavorShowPosition[1], peoplesFavorShowPosition[2], peoplesFavorShowPosition[3] })
        peoplesFavor.setRotation({ 0, 180, 0 })
        peoplesFavor.locked = false
        peoplesFavor.interactable = true
        peoplesFavor.tooltip = true
    end

    showDice()
end

function hideGeneralPieces()
    curOathkeeperToken.setPosition({ oathkeeperTokenHidePosition[1], oathkeeperTokenHidePosition[2], oathkeeperTokenHidePosition[3] })
    curOathkeeperToken.locked = true
    curOathkeeperToken.interactable = false
    curOathkeeperToken.tooltip = false

    for loopOathName,loopOathCode in pairs(oathCodes) do
        if (nil ~= oathReminderTokens[loopOathName]) then
    oathReminderTokens[loopOathName].setPosition({ oathReminderTokenHidePositions[loopOathName][1],
    oathReminderTokenHidePositions[loopOathName][2],
    oathReminderTokenHidePositions[loopOathName][3] })
    oathReminderTokens[loopOathName].locked = true
    oathReminderTokens[loopOathName].interactable = false
    oathReminderTokens[loopOathName].tooltip = false
        end
    end

    darkestSecret.setPosition({ darkestSecretHidePosition[1], darkestSecretHidePosition[2], darkestSecretHidePosition[3] })
    darkestSecret.locked = true
    darkestSecret.interactable = false
    darkestSecret.tooltip = false

    peoplesFavor.setPosition({ peoplesFavorHidePosition[1], peoplesFavorHidePosition[2], peoplesFavorHidePosition[3] })
    peoplesFavor.locked = true
    peoplesFavor.interactable = false
    peoplesFavor.tooltip = false

    hideDice()
end

function showPieces(playerColor)
    local oldPosition = nil

    if ("Purple" == playerColor) then
        oldPosition = reliquary.getPosition()
        reliquary.setPosition({ oldPosition[1], 0.96, oldPosition[3] })
        reliquary.locked = true
        reliquary.interactable = true
        reliquary.tooltip = true
    end

    oldPosition = playerBoards[playerColor].getPosition()
    playerBoards[playerColor].setPosition({ oldPosition[1], 0.96, oldPosition[3] })
    playerBoards[playerColor].locked = true
    playerBoards[playerColor].interactable = true
    playerBoards[playerColor].tooltip = true

    oldPosition = playerPawns[playerColor].getPosition()
    playerPawns[playerColor].setPosition({ oldPosition[1], 1.06, oldPosition[3] })
    playerPawns[playerColor].locked = false
    playerPawns[playerColor].interactable = true
    playerPawns[playerColor].tooltip = true

    oldPosition = playerSupplyMarkers[playerColor].getPosition()
    playerSupplyMarkers[playerColor].setPosition({ oldPosition[1], 1.06, oldPosition[3] })
    playerSupplyMarkers[playerColor].locked = false
    playerSupplyMarkers[playerColor].interactable = true
    playerSupplyMarkers[playerColor].tooltip = true

    oldPosition = playerWarbandBags[playerColor].getPosition()
    playerWarbandBags[playerColor].setPosition({ oldPosition[1], 0.77, oldPosition[3] })
    playerWarbandBags[playerColor].locked = true
    playerWarbandBags[playerColor].interactable = true
    playerWarbandBags[playerColor].tooltip = true
end

function hidePieces(playerColor)
    local oldPosition = nil

    if ("Purple" == playerColor) then
        oldPosition = reliquary.getPosition()
        reliquary.setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
        reliquary.locked = true
        reliquary.interactable = false
        reliquary.tooltip = false
    end

    oldPosition = playerBoards[playerColor].getPosition()
    playerBoards[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
    playerBoards[playerColor].locked = true
    playerBoards[playerColor].interactable = false
    playerBoards[playerColor].tooltip = false

    oldPosition = playerPawns[playerColor].getPosition()
    playerPawns[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
    playerPawns[playerColor].locked = true
    playerPawns[playerColor].interactable = false
    playerPawns[playerColor].tooltip = false

    oldPosition = playerSupplyMarkers[playerColor].getPosition()
    playerSupplyMarkers[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
    playerSupplyMarkers[playerColor].locked = true
    playerSupplyMarkers[playerColor].interactable = false
    playerSupplyMarkers[playerColor].tooltip = false

    oldPosition = playerWarbandBags[playerColor].getPosition()
    playerWarbandBags[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
    playerWarbandBags[playerColor].locked = true
    playerWarbandBags[playerColor].interactable = false
    playerWarbandBags[playerColor].tooltip = false
end

function generateRandomWorldDeck(cardsForWorldDeck, cardsForWorldDeckCount, numCardsToChoose)
    local visionsAvailable = { normalCardsBySaveID[210],
                               normalCardsBySaveID[211],
                               normalCardsBySaveID[212],
                               normalCardsBySaveID[213],
                               normalCardsBySaveID[214] }
    local numVisionsAvailable = 5
    local copyCardName = nil
    local sourceSubset = {}
    local numSubsetCardsAvailable = 0
    local chosenIndex = nil
    local cardValid = true

    -- If no card options were provided, determine which cards are options to add to the world deck.
    if (0 == cardsForWorldDeckCount) then
        cardsForWorldDeck = {}

        if (curWorldDeckCardCount > 0) then
            -- This is the normal case.  Use known non-Vision world deck cards as the source.
            for cardSourceIndex = 1,curWorldDeckCardCount do
                if ("Vision" ~= cardsTable[curWorldDeckCards[cardSourceIndex]].cardtype) then
            table.insert(cardsForWorldDeck, curWorldDeckCards[cardSourceIndex])
            cardsForWorldDeckCount = (cardsForWorldDeckCount + 1)
                end
            end
        else
            -- There are no cards in the world deck.  Select default non-archive cards that are not the 3 starting locations.
            -- Sanity check to make sure there are no dispossessed cards.
            if (curDispossessedDeckCardCount > 0) then
                printToAll("Warning, there are dispossessed card(s) but no world deck.", {1,0,0})
            end

            for cardSaveID = 0,53 do
                copyCardName = normalCardsBySaveID[cardSaveID]

                if (("Longbows" ~= copyCardName)       and
            ("Taming Charm" ~= copyCardName)   and
            ("Elders" ~= copyCardName))              then
            table.insert(cardsForWorldDeck, copyCardName)
            cardsForWorldDeckCount = (cardsForWorldDeckCount + 1)
                end
            end -- end for cardSaveID = 0,53
        end -- end if (curWorldDeckCardCount > 0)

        -- If the number of cards to choose as not provided, use them all.
        if (0 == numCardsToChoose) then
            numCardsToChoose = cardsForWorldDeckCount
        end
    end -- end if (0 == cardsForWorldDeckCount)

    -- Clear world deck.
    curWorldDeckCards = {}
    curWorldDeckCardCount = 0

    -- Form subset of 10 random denizen cards with 2 random visions.
    sourceSubset = {}
    for subsetIndex = 1,10 do
        chosenIndex = math.random(1, cardsForWorldDeckCount)
        sourceSubset[subsetIndex] = cardsForWorldDeck[chosenIndex]
        -- Remove the chosen card from the source cards.
        table.remove(cardsForWorldDeck, chosenIndex)
        cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
        numCardsToChoose = (numCardsToChoose - 1)
    end
    for subsetIndex = 11,12 do
        chosenIndex = math.random(1, numVisionsAvailable)
        sourceSubset[subsetIndex] = visionsAvailable[chosenIndex]
        -- Remove the chosen vision from the available visions.
        table.remove(visionsAvailable, chosenIndex)
        numVisionsAvailable = (numVisionsAvailable - 1)
    end
    -- Randomly choose from the 12 cards and add them to the overall deck.
    numSubsetCardsAvailable = 12
    for cardDestIndex = 1,12 do
        chosenIndex = math.random(1, numSubsetCardsAvailable)
        curWorldDeckCards[cardDestIndex] = sourceSubset[chosenIndex]
        table.remove(sourceSubset, chosenIndex)
        curWorldDeckCardCount = (curWorldDeckCardCount + 1)
        numSubsetCardsAvailable = (numSubsetCardsAvailable - 1)
    end

    -- Form subset of 15 random denizen cards with 3 random visions.
    sourceSubset = {}
    for subsetIndex = 1,15 do
        chosenIndex = math.random(1, cardsForWorldDeckCount)
        sourceSubset[subsetIndex] = cardsForWorldDeck[chosenIndex]
        -- Remove the chosen card from the source cards.
        table.remove(cardsForWorldDeck, chosenIndex)
        cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
        numCardsToChoose = (numCardsToChoose - 1)
    end
    for subsetIndex = 16,18 do
        chosenIndex = math.random(1, numVisionsAvailable)
        sourceSubset[subsetIndex] = visionsAvailable[chosenIndex]
        -- Remove the chosen vision from the available visions.
        table.remove(visionsAvailable, chosenIndex)
        numVisionsAvailable = (numVisionsAvailable - 1)
    end
    -- Randomly choose from the 18 cards and add them to the overall deck.
    numSubsetCardsAvailable = 18
    for cardDestIndex = 13,30 do
        chosenIndex = math.random(1, numSubsetCardsAvailable)
        curWorldDeckCards[cardDestIndex] = sourceSubset[chosenIndex]
        table.remove(sourceSubset, chosenIndex)
        curWorldDeckCardCount = (curWorldDeckCardCount + 1)
        numSubsetCardsAvailable = (numSubsetCardsAvailable - 1)
    end

    -- Finally, randomly add all the remaining source cards to the bottom of the world deck, limiting if needed.
    local cardDestIndex = 31
    while (numCardsToChoose > 0) do
        chosenIndex = math.random(1, cardsForWorldDeckCount)

        cardValid = true

        -- If doing random setup, the bottom 3 cards in the deck must be non-player-only cards so they can be placed onto the map.
        if (true == randomEnabled) then
            if (numCardsToChoose <= 3) then
                if (true == cardsTable[cardsForWorldDeck[chosenIndex]].playerOnly) then
                    cardValid = false
                end
            end
        end

        if (true == cardValid) then
            curWorldDeckCards[cardDestIndex] = cardsForWorldDeck[chosenIndex]
            table.remove(cardsForWorldDeck, chosenIndex)
            curWorldDeckCardCount = (curWorldDeckCardCount + 1)
            cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
            numCardsToChoose = (numCardsToChoose - 1)
            cardDestIndex = (cardDestIndex + 1)
        end
    end
end

function generateRandomRelicDeck()
    local copyCardName = nil
    local cardsForRelicDeck = {}
    local cardsForRelicDeckCount = 0
    local numCardsToChoose = 0
    local chosenIndex = nil

    -- Determine which cards are options to add to the relic deck.
    for cardSaveID = 218,237 do
        copyCardName = normalCardsBySaveID[cardSaveID]

        table.insert(cardsForRelicDeck, copyCardName)
        cardsForRelicDeckCount = (cardsForRelicDeckCount + 1)
    end -- end for cardSaveID = 218,237

    numCardsToChoose = cardsForRelicDeckCount

    -- Clear relic deck.
    curRelicDeckCards = {}
    curRelicDeckCardCount = 0

    -- Randomly add all available relic cards to the relic deck strucutre.
    local cardDestIndex = 1
    while (numCardsToChoose > 0) do
        chosenIndex = math.random(1, cardsForRelicDeckCount)
        curRelicDeckCards[cardDestIndex] = cardsForRelicDeck[chosenIndex]
        table.remove(cardsForRelicDeck, chosenIndex)
        curRelicDeckCardCount = (curRelicDeckCardCount + 1)
        cardsForRelicDeckCount = (cardsForRelicDeckCount - 1)
        numCardsToChoose = (numCardsToChoose - 1)
        cardDestIndex = (cardDestIndex + 1)
    end
end

function spawnFavor()
    local newFavorToken = nil
    local newSecretToken = nil
    local favorYOffset = 0.18
    local supplyFavor = 36
    local curFavorCount = 0

    if (false == isManualControlEnabled) then
        -- Set up favor stacks.
        for curSuitName,curSuitCode in pairs(suitCodes) do
            -- Large player counts have more starting favor.
            if (curGameNumPlayers >= 5) then
                curFavorCount = 4
            else
                curFavorCount = 3
            end

            curFavorValues[curSuitName] = curFavorCount
            supplyFavor = (supplyFavor - curFavorCount)

            for tokenIndex = 1, curFavorCount do
                -- Clone the below-table favor token.
                newFavorToken = belowTableFavor.clone()
                newFavorToken.setName("Favor (" .. curFavorCount .. " " .. curSuitName .. ")")
                newFavorToken.locked = false
                newFavorToken.interactable = true
                newFavorToken.tooltip = true
                newFavorToken.use_gravity = true
                newFavorToken.setPosition({ favorSpawnPositions[curSuitName][1],
                                            (favorSpawnPositions[curSuitName][2] + ((tokenIndex - 1) * favorYOffset)),
                                            favorSpawnPositions[curSuitName][3] })
                newFavorToken.setRotation({ 0, 180, 0 })
            end
        end -- end looping through suits
    end -- if (false == isManualControlEnabled)

    -- Set up favor supply bag.
    if (nil ~= favorBag) then
    favorBag.getComponent("AudioSource").set("mute", true)

    for tokenIndex = 1,supplyFavor do
    newFavorToken = belowTableFavor.clone()
    newFavorToken.setName("Favor")
    newFavorToken.locked = false
    newFavorToken.interactable = true
    newFavorToken.tooltip = true
    newFavorToken.use_gravity = true
    newFavorToken.setRotation({ 0, 180, 0 })

    favorBag.putObject(newFavorToken)
    end

    favorBag.getComponent("AudioSource").set("mute", false)
    end
end

function spawnWorldDeck(removedFromUnderneathCount)
    local spawnStatus = STATUS_SUCCESS
    local spawnParams = {}
    local deckJSON = nil
    local cardJSON = nil
    local curCardName = nil
    local curCardDescription = nil
    local curCardInfo = nil
    local curCardDeckID = nil
    local curCardTTSDeckInfo = nil
    local isCardSideways = false

    deckJSON = {
        Name = "Deck",
        Transform = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.0,
            rotX = 0.0,
            rotY = 90.0,
            -- The deck is spawned facedown.
            rotZ = 180.0,
            scaleX = 1.50,
            scaleY = 1.00,
            scaleZ = 1.50
        },
        Nickname = "World Deck",
        Description = "",
        ColorDiffuse = {
            r = 0.713235259,
            g = 0.713235259,
            b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        SidewaysCard = false,
        HideWhenFaceDown = false,
        DeckIDs = {},
        CustomDeck = {},
        LuaScript = "",
        LuaScriptState = "",
        ContainedObjects = {},
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "800000"
    }

    -- Iterate over all cards except those removed from underneath the world deck.
    for cardIndex = 1, (curWorldDeckCardCount - removedFromUnderneathCount) do
        curCardName = curWorldDeckCards[cardIndex]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    if ("Vision" == curCardInfo.cardtype) then
    isCardSideways = true
    else
    isCardSideways = false
    end

    if (nil ~= curCardInfo.faqText) then
    curCardDescription = curCardInfo.faqText
    else
    curCardDescription = NO_FAQ_TEXT
    end

    curCardDeckID = string.sub(curCardInfo.ttscardid, 1, -3)
    cardJSON = {
    Name = "Card",
    Transform = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.0,
    rotX = 0.0,
    rotY = 0.0,
    rotZ = 0.0,
    scaleX = 1.50,
    scaleY = 1.00,
    scaleZ = 1.50
    },
    Nickname = curCardName,
    Description = curCardDescription,
    ColorDiffuse = {
    r = 0.713235259,
    g = 0.713235259,
    b = 0.713235259
    },
    Locked = false,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    HideWhenFaceDown = true,
    CardID = curCardInfo.ttscardid,
    SidewaysCard = isCardSideways,

    -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
    CustomDeck = nil,
    LuaScript = "",
    LuaScriptState = "",
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "700000"
    }

    -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
    table.insert(deckJSON.DeckIDs, curCardInfo.ttscardid)

    -- If needed, record the CustomDeck information in the overall deck JSON.
    if (nil == deckJSON.CustomDeck[curCardDeckID]) then
    curCardTTSDeckInfo = ttsDeckInfo[tonumber(curCardDeckID)]

    if (nil ~= curCardTTSDeckInfo) then
    deckJSON.CustomDeck[curCardDeckID] = {
    FaceURL = curCardTTSDeckInfo.deckimage,
    BackURL = curCardTTSDeckInfo.backimage,
    NumWidth = curCardTTSDeckInfo.deckwidth,
    NumHeight = curCardTTSDeckInfo.deckheight,
    BackIsHidden = true,
    UniqueBack = curCardTTSDeckInfo.hasuniqueback
    }
        else -- end if (nil ~= curCardTTSDeckInfo)
        printToAll("Error, did not find deck with ID " .. curCardDeckID, {1,0,0})
    spawnStatus = STATUS_FAILURE
    break
    end
    end

    -- Add the card to the deck JSON.
    table.insert(deckJSON.ContainedObjects, cardJSON)
    else -- end if (nil ~= curCardInfo)
    printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end -- end looping through world deck cards

    -- Spawn the world deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { worldDeckSpawnPosition[1], (-3.5), worldDeckSpawnPosition[3] }
        spawnParams.rotation = { 0, 90, 180 }
        spawnParams.callback_function = function(spawnedObject)
            handleSpawnedObject(spawnedObject,
                    { worldDeckSpawnPosition[1], worldDeckSpawnPosition[2], worldDeckSpawnPosition[3] },
                    true,
                    true) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end
end

function spawnDiscardDeck(cardsBottomToTop, spawnPosition)
    local spawnStatus = STATUS_SUCCESS
    local spawnParams = {}
    local deckJSON = nil
    local cardJSON = nil
    local curCardName = nil
    local curCardDescription = nil
    local curCardInfo = nil
    local curCardDeckID = nil
    local curCardTTSDeckInfo = nil
    local isCardSideways = false

    deckJSON = {
        Name = "Deck",
        Transform = {
            posX = 0.0,
            posY = 0.0,
            posZ = 0.0,
            rotX = 0.0,
            rotY = 90.0,
            -- The deck is spawned facedown.
            rotZ = 180.0,
            scaleX = 1.50,
            scaleY = 1.00,
            scaleZ = 1.50
        },
        Nickname = "",
        Description = "",
        ColorDiffuse = {
            r = 0.713235259,
            g = 0.713235259,
            b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        SidewaysCard = false,
        HideWhenFaceDown = false,
        DeckIDs = {},
        CustomDeck = {},
        LuaScript = "",
        LuaScriptState = "",
        ContainedObjects = {},
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "800000"
    }

    -- Iterate over the given list of cards starting at the top.
    for cardIndex = #cardsBottomToTop,1,-1 do
        curCardName = cardsBottomToTop[cardIndex]
        curCardInfo = cardsTable[curCardName]

        if (nil ~= curCardInfo) then
    if ("Vision" == curCardInfo.cardtype) then
    isCardSideways = true
    else
    isCardSideways = false
    end

    if (nil ~= curCardInfo.faqText) then
    curCardDescription = curCardInfo.faqText
    else
    curCardDescription = NO_FAQ_TEXT
    end

    curCardDeckID = string.sub(curCardInfo.ttscardid, 1, -3)
    cardJSON = {
    Name = "Card",
    Transform = {
    posX = 0.0,
    posY = 0.0,
    posZ = 0.0,
    rotX = 0.0,
    rotY = 0.0,
    rotZ = 0.0,
    scaleX = 1.50,
    scaleY = 1.00,
    scaleZ = 1.50
    },
    Nickname = curCardName,
    Description = curCardDescription,
    ColorDiffuse = {
    r = 0.713235259,
    g = 0.713235259,
    b = 0.713235259
    },
    Locked = false,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    HideWhenFaceDown = true,
    CardID = curCardInfo.ttscardid,
    SidewaysCard = isCardSideways,

    -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
    CustomDeck = nil,
    LuaScript = "",
    LuaScriptState = "",
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "700000"
    }

    -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
    table.insert(deckJSON.DeckIDs, curCardInfo.ttscardid)

    -- If needed, record the CustomDeck information in the overall deck JSON.
    if (nil == deckJSON.CustomDeck[curCardDeckID]) then
    curCardTTSDeckInfo = ttsDeckInfo[tonumber(curCardDeckID)]

    if (nil ~= curCardTTSDeckInfo) then
    deckJSON.CustomDeck[curCardDeckID] = {
    FaceURL = curCardTTSDeckInfo.deckimage,
    BackURL = curCardTTSDeckInfo.backimage,
    NumWidth = curCardTTSDeckInfo.deckwidth,
    NumHeight = curCardTTSDeckInfo.deckheight,
    BackIsHidden = true,
    UniqueBack = curCardTTSDeckInfo.hasuniqueback
    }
        else -- end if (nil ~= curCardTTSDeckInfo)
        printToAll("Error, did not find deck with ID " .. curCardDeckID, {1,0,0})
    spawnStatus = STATUS_FAILURE
    break
    end
    end

    -- Add the card to the deck JSON.
    table.insert(deckJSON.ContainedObjects, cardJSON)
    else -- end if (nil ~= curCardInfo)
    printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
    end -- for cardIndex = #cardsBottomToTop,1,-1

    -- Spawn the discard deck.
    if (STATUS_SUCCESS == spawnStatus) then
        -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
        spawnParams.json = JSON.encode(deckJSON)
        spawnParams.position = { spawnPosition[1], (-3.5), spawnPosition[3] }
        spawnParams.rotation = { 0.0, 90.0, 180.0 }
        spawnParams.callback_function = function(spawnedObject)
            -- The Y position is somewhat higher than the final resting position so that discard piles of a few cards can be spawned for tutorial setup.
            handleSpawnedObject(spawnedObject,
                    { spawnPosition[1], (spawnPosition[2] + 0.15), spawnPosition[3] },
                    true,
                    true) end

        -- Update expected spawn count and spawn the object.
        loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
        spawnObjectJSON(spawnParams)
    end
end

function spawnRelicDeck()
    local spawnStatus = STATUS_SUCCESS
    local spawnParams = {}
    local deckJSON = nil
    local cardJSON = nil
    local curCardName = nil
    local curCardDescription = nil
    local curCardInfo = nil
    local curCardDeckID = nil
    local curCardTTSDeckInfo = nil

    if (curRelicDeckCardCount >= 1) then
        deckJSON = {
            Name = "Deck",
            Transform = {
                posX = 0.0,
                posY = 0.0,
                posZ = 0.0,
                rotX = 0.0,
                rotY = 90.0,
                -- The deck is spawned facedown.
                rotZ = 180.0,
                scaleX = 1.50,
                scaleY = 1.00,
                scaleZ = 1.50
            },
            Nickname = "Relic Deck",
            Description = "",
            ColorDiffuse = {
                r = 0.713235259,
                g = 0.713235259,
                b = 0.713235259
            },
            Locked = false,
            Grid = false,
            Snap = true,
            Autoraise = true,
            Sticky = true,
            Tooltip = true,
            SidewaysCard = false,
            HideWhenFaceDown = false,
            DeckIDs = {},
            CustomDeck = {},
            LuaScript = "",
            LuaScriptState = "",
            ContainedObjects = {},
            -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
            GUID = "810000"
        }

        -- Iterate over all cards in relic deck, starting from the end of the array which represents the top card of the deck.
        for cardIndex = curRelicDeckCardCount,1,-1 do
            curCardName = curRelicDeckCards[cardIndex]
            curCardInfo = cardsTable[curCardName]

            if (nil ~= curCardInfo) then
        if (nil ~= curCardInfo.faqText) then
        curCardDescription = curCardInfo.faqText
        else
        curCardDescription = NO_FAQ_TEXT
        end

        curCardDeckID = string.sub(curCardInfo.ttscardid, 1, -3)
        cardJSON = {
        Name = "Card",
        Transform = {
        posX = 0.0,
        posY = 0.0,
        posZ = 0.0,
        rotX = 0.0,
        rotY = 0.0,
        rotZ = 0.0,
        scaleX = 0.96,
        scaleY = 1.00,
        scaleZ = 0.96
        },
        Nickname = curCardName,
        Description = curCardDescription,
        ColorDiffuse = {
        r = 0.713235259,
        g = 0.713235259,
        b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        HideWhenFaceDown = true,
        CardID = curCardInfo.ttscardid,
        SidewaysCard = false,

        -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
        CustomDeck = nil,
        LuaScript = "",
        LuaScriptState = "",
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "700000"
        }

        -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
        table.insert(deckJSON.DeckIDs, curCardInfo.ttscardid)

        -- If needed, record the CustomDeck information in the overall deck JSON.
        if (nil == deckJSON.CustomDeck[curCardDeckID]) then
        curCardTTSDeckInfo = ttsDeckInfo[tonumber(curCardDeckID)]

        if (nil ~= curCardTTSDeckInfo) then
        deckJSON.CustomDeck[curCardDeckID] = {
        FaceURL = curCardTTSDeckInfo.deckimage,
        BackURL = curCardTTSDeckInfo.backimage,
        NumWidth = curCardTTSDeckInfo.deckwidth,
        NumHeight = curCardTTSDeckInfo.deckheight,
        BackIsHidden = true,
        UniqueBack = curCardTTSDeckInfo.hasuniqueback
        }
            else -- end if (nil ~= curCardTTSDeckInfo)
            printToAll("Error, did not find deck with ID " .. curCardDeckID, {1,0,0})
        spawnStatus = STATUS_FAILURE
        break
        end
        end

        -- Add the card to the deck JSON.
        table.insert(deckJSON.ContainedObjects, cardJSON)
        else -- end if (nil ~= curCardInfo)
        printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
            spawnStatus = STATUS_FAILURE
            break
            end
        end -- end looping through relic deck cards

        -- Spawn the relic deck.
        if (STATUS_SUCCESS == spawnStatus) then
            -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
            spawnParams.json = JSON.encode(deckJSON)
            spawnParams.position = { relicDeckSpawnPosition[1], (-3.5), relicDeckSpawnPosition[3] }
            spawnParams.rotation = { 0, 180, 180 }
            spawnParams.scale = { 0.96, 1.00, 0.96 }
            spawnParams.callback_function = function(spawnedObject)
                handleSpawnedObject(spawnedObject,
                        { relicDeckSpawnPosition[1], relicDeckSpawnPosition[2], relicDeckSpawnPosition[3] },
                        true,
                        true) end

            -- Update expected spawn count and spawn the object.
            loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
            spawnObjectJSON(spawnParams)
        end
    else -- end if (curRelicDeckCardCount >= 1)
        -- This should never happen, since corrupted relic decks are fixed when the chronicle string is loaded.
        printToAll("Error, no cards left for relic deck.", {1,0,0})
    end
end

function loadFromSaveString(saveDataString, setupGameAfter)
    local oathMajorVersion = nil
    local oathMinorVersion = nil
    local oathPatchVersion = nil

    -- Set the global load status.
    loadStatus = STATUS_SUCCESS

    --
    -- Parse data string.
    --

    if (string.len(saveDataString) > 6) then
        oathMajorVersion = tonumber(string.sub(saveDataString, 1, 2), 16)
        oathMinorVersion = tonumber(string.sub(saveDataString, 3, 4), 16)
        oathPatchVersion = tonumber(string.sub(saveDataString, 5, 6), 16)

        if (false == isManualControlEnabled) then
            printToAll("", {1,1,1})
            printToAll("Loading data from version " ..  oathMajorVersion .. "." .. oathMinorVersion .. "." .. oathPatchVersion ..  ".  Please wait...", {1,1,1})
        end

        -- No change in save format through the first several versions.
        if (((1 == oathMajorVersion) and (6 == oathMinorVersion) and (0 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (6 == oathMinorVersion) and (1 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (6 == oathMinorVersion) and (2 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (0 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (1 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (2 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (8 == oathMinorVersion) and (0 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (0 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (1 == oathPatchVersion))          or
                ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (2 == oathPatchVersion))          or
                ((2 == oathMajorVersion) and (0 == oathMinorVersion) and (0 == oathPatchVersion))          or
                ((2 == oathMajorVersion) and (0 == oathMinorVersion) and (3 == oathPatchVersion))) then
            -- No change in save format.
            loadFromSaveString_1_6_0(saveDataString)

            -- Create a random relic deck.
            generateRandomRelicDeck({}, 0, 0)
            -- Copy it into the load structure so that setupLoadedState() will work correctly.
            loadRelicDeckInitCardCount = curRelicDeckCardCount
            loadRelicDeckInitCards = {}
            for cardIndex = 1,curRelicDeckCardCount do
                loadRelicDeckInitCards[cardIndex] = curRelicDeckCards[cardIndex]
            end

            -- Fill in placeholder previous state.
            loadPreviousWinningColor           = "Purple"
            loadPreviousWinningSteamName       = "UNKNOWN"
            loadPreviousPlayersActive          = { ["Clock"]  = false,
                                                   ["Purple"] = true,
                                                   ["Red"]    = true,
                                                   ["Brown"]  = true,
                                                   ["Blue"]   = true,
                                                   ["Yellow"] = true,
                                                   ["White"]  = true }
            loadPreviousPlayerStatus           = { ["Purple"] = "Chancellor",
                                                   ["Red"]    = "Exile",
                                                   ["Brown"]  = "Exile",
                                                   ["Blue"]   = "Exile",
                                                   ["Yellow"] = "Exile",
                                                   ["White"]  = "Exile" }
        elseif (((3 == oathMajorVersion) and (1 == oathMinorVersion) and (0 == oathPatchVersion))      or
                ((3 == oathMajorVersion) and (1 == oathMinorVersion) and (1 == oathPatchVersion))      or
                ((3 == oathMajorVersion) and (1 == oathMinorVersion) and (2 == oathPatchVersion))      or
                ((3 == oathMajorVersion) and (1 == oathMinorVersion) and (3 == oathPatchVersion))      or
                ((3 == oathMajorVersion) and (2 == oathMinorVersion) and (0 == oathPatchVersion))      or
                ((3 == oathMajorVersion) and (3 == oathMinorVersion) and (0 == oathPatchVersion))) then
            -- The relic deck is part of the save format from this version onwards.
            loadFromSaveString_3_1_0(saveDataString)

            -- Fill in placeholder previous state.
            loadPreviousWinningColor           = "Purple"
            loadPreviousWinningSteamName       = "UNKNOWN"
            loadPreviousPlayersActive          = { ["Clock"]  = false,
                                                   ["Purple"] = true,
                                                   ["Red"]    = true,
                                                   ["Brown"]  = true,
                                                   ["Blue"]   = true,
                                                   ["Yellow"] = true,
                                                   ["White"]  = true }
            loadPreviousPlayerStatus           = { ["Purple"] = "Chancellor",
                                                   ["Red"]    = "Exile",
                                                   ["Brown"]  = "Exile",
                                                   ["Blue"]   = "Exile",
                                                   ["Yellow"] = "Exile",
                                                   ["White"]  = "Exile" }
        elseif ((3 == oathMajorVersion) and (3 == oathMinorVersion) and (1 == oathPatchVersion) or
                (3 == oathMajorVersion) and (3 == oathMinorVersion) and (2 == oathPatchVersion) or
                (3 == oathMajorVersion) and (3 == oathMinorVersion) and (3 == oathPatchVersion)) then
            -- Previous starting citizen/exile status, previous winning color, and previous winner's Steam name are part of the save format from this version onwards.
            loadFromSaveString_3_3_1(saveDataString)
        else
            --printToAll("Save string:  " .. saveDataString, {1,1,1})
            printToAll("Unsupported data version.  Data version must be " .. OATH_MAJOR_VERSION .. "." .. OATH_MINOR_VERSION .. "." .. OATH_PATCH_VERSION .. " or earlier.", {1,0,0})
            loadStatus = STATUS_FAILURE
        end
    else
        printToAll("Error, invalid data string.", {1,0,0})
        loadStatus = STATUS_FAILURE
    end

    if (STATUS_SUCCESS == loadStatus) then
        -- The following can be used for load timing.
        --printToAll("Time:  " .. Time.time, {1,1,1})

        -- Setup game state using the loaded state.
        setupLoadedState(setupGameAfter)
    end
end

function loadFromSaveString_1_6_0(saveDataString)
    local parseGameCountHex = nil
    local parseChronicleNameLengthHex = nil
    local parseChronicleNameLength = nil
    local statusByteHex = nil
    local statusByte = nil
    local parseOathCodeHex = nil
    local parseOathCode = nil
    local parseSuitCodeHex = nil
    local parseSuitCode = nil
    local parseCodeHex = nil
    local parseCode = nil
    local cardCountHex = nil
    local oathCodeFound = nil
    local suitCodeFound = nil
    local nextParseIndex = nil
    local cardInfo = nil

    --
    -- Parse the save data string.  Bytes 1-6 contained the version and have already been parsed.
    --

    nextParseIndex = 7

    if (STATUS_SUCCESS == loadStatus) then
        parseGameCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 3))

        if (nil ~= parseGameCountHex) then
    loadGameCount = tonumber(parseGameCountHex, 16)
    nextParseIndex = (nextParseIndex + 4)
    else
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        parseChronicleNameLengthHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil ~= parseChronicleNameLengthHex) then
    parseChronicleNameLength = tonumber(parseChronicleNameLengthHex, 16)
    nextParseIndex = (nextParseIndex + 2)
    else
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        if ((parseChronicleNameLength >= MIN_NAME_LENGTH) and
                (parseChronicleNameLength <= MAX_NAME_LENGTH)) then
            -- There must be byte(s) after the chronicle name length.  Otherwise, the save string is invalid.
            if ((nextParseIndex + parseChronicleNameLength) < string.len(saveDataString)) then
                loadChronicleName = string.sub(saveDataString, nextParseIndex, (nextParseIndex + (parseChronicleNameLength - 1)))
                nextParseIndex = (nextParseIndex + parseChronicleNameLength)
            else
                printToAll("Error, invalid save string.", {1,0,0})
                loadStatus = STATUS_FAILURE
            end
        else
            printToAll("Error, invalid save string.", {1,0,0})
            loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        statusByteHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil ~= statusByteHex) then
    -- NOTE:  Starting with version 3.3.2 of the mod, this byte is parsed and used to represent active players
    --        from the previous game, including whether the Clockwork Prince was active.
    statusByte = tonumber(statusByteHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    parsePreviousActiveStatusByte(statusByte)
    else
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        statusByteHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil ~= statusByteHex) then
    statusByte = tonumber(statusByteHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    parseExileCitizenStatusByte(statusByte)
    else
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        parseOathCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil ~= parseOathCodeHex) then
    parseOathCode = tonumber(parseOathCodeHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    oathCodeFound = false
    for testOathName,testOathCode in pairs(oathCodes) do
    if (testOathCode == parseOathCode) then
    loadCurOath = testOathName
    oathCodeFound = true
    break
    end
    end

    if (false == oathCodeFound) then
    printToAll("Error, invalid oath code.", {1,0,0})
    loadStatus = STATUS_FAILURE
    end
    else
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        for parseSuitIndex = 1,6 do
            parseSuitCodeHex = string.sub(saveDataString, nextParseIndex, nextParseIndex)

            if (nil ~= parseSuitCodeHex) then
        parseSuitCode = tonumber(parseSuitCodeHex, 16)
        nextParseIndex = (nextParseIndex + 1)

        suitCodeFound = false
        for testSuitName,testSuitCode in pairs(suitCodes) do
        if (testSuitCode == parseSuitCode) then
        loadSuitOrder[parseSuitIndex] = testSuitName
        suitCodeFound = true
        break
        end
        end

        if (false == suitCodeFound) then
        printToAll("Error, invalid suit code.", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
        end
        else
        printToAll("Error, invalid save string.", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
            end
        end
    end

    if (STATUS_SUCCESS == loadStatus) then
        for parseMapSiteIndex = 1,8 do
            --
            -- Parse site.
            --

            parseSiteCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))
            if (nil ~= parseSiteCodeHex) then
        parseCode = tonumber(parseSiteCodeHex, 16)
        nextParseIndex = (nextParseIndex + 2)

        if (nil ~= sitesBySaveID[parseCode]) then
        loadMapSites[parseMapSiteIndex][1] = sitesBySaveID[parseCode]
        -- If the parse code is >= 24, it represents a facedown site.
        if (parseCode >= 24) then
        loadMapSites[parseMapSiteIndex][2] = true
        else
        loadMapSites[parseMapSiteIndex][2] = false
        end
        else
        printToAll("Error, invalid site code 0x" .. parseSiteCodeHex .. ".", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
        end

        --
        -- Parse denizen / edifice / ruin card(s) at the site.
        --

        for parseCardIndex = 1,3 do
        parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil ~= parseCodeHex) then
        parseCode = tonumber(parseCodeHex, 16)
        nextParseIndex = (nextParseIndex + 2)

        if (nil ~= normalCardsBySaveID[parseCode]) then
        loadMapNormalCards[parseMapSiteIndex][parseCardIndex][1] = normalCardsBySaveID[parseCode]
        cardInfo = cardsTable[loadMapNormalCards[parseMapSiteIndex][parseCardIndex][1]]

        -- For ruins and relics, mark the card as flipped.
        if (nil ~= ruinSaveIDs[parseCode]) then
        loadMapNormalCards[parseMapSiteIndex][parseCardIndex][2] = true
        elseif ((nil ~= cardInfo) and ("Relic" == cardInfo.cardtype)) then
        loadMapNormalCards[parseMapSiteIndex][parseCardIndex][2] = true
        else
        loadMapNormalCards[parseMapSiteIndex][parseCardIndex][2] = false
        end
        else
        printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
        end
        else
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
        end
        end

        if (STATUS_SUCCESS ~= loadStatus) then
        break
        end
        else -- end if site code available
        printToAll("Error, invalid save string.", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
            end
        end -- end loop through map sites
    end -- end if success

    --
    -- This code can be uncommented for debug purposes.
    --
    --if (STATUS_SUCCESS == loadStatus) then
    --  printToAll("MAP:", {1,1,1})
    --  printToAll("====", {1,1,1})
    --  for siteIndex = 1,8 do
    --    printToAll(loadMapSites[siteIndex][1], {1,1,1})
    --    printToAll("  " .. loadMapNormalCards[siteIndex][1][1], {1,1,1})
    --    printToAll("  " .. loadMapNormalCards[siteIndex][2][1], {1,1,1})
    --    printToAll("  " .. loadMapNormalCards[siteIndex][3][1], {1,1,1})
    --  end
    --end

    if (STATUS_SUCCESS == loadStatus) then
        cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        -- Reset world deck, attempting to release memory.
        loadWorldDeckInitCardCount = 0
        loadWorldDeckInitCards = nil
        loadWorldDeckInitCards = {}

        if (nil ~= cardCountHex) then
    loadWorldDeckInitCardCount = tonumber(cardCountHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    for cardIndex = 1,loadWorldDeckInitCardCount do
    parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil ~= parseCodeHex) then
    parseCode = tonumber(parseCodeHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    if (nil ~= normalCardsBySaveID[parseCode]) then
    loadWorldDeckInitCards[cardIndex] = normalCardsBySaveID[parseCode]
    else
    printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    else
    printToAll("Error, invalid save string.", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    end -- end loop through world deck cards
    else -- end if card count available
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end -- end if success

    --
    -- This code can be uncommented for debug purposes.
    --
    --if (STATUS_SUCCESS == loadStatus) then
    --  printToAll("World deck:", {1,1,1})
    --  printToAll("===========", {1,1,1})
    --  printToAll(loadWorldDeckInitCardCount .. " cards", {1,1,1})
    --  printToAll("===========", {1,1,1})
    --  for cardIndex = 1,loadWorldDeckInitCardCount do
    --    printToAll(loadWorldDeckInitCards[cardIndex], {1,1,1})
    --  end
    --end

    if (STATUS_SUCCESS == loadStatus) then
        cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        -- Reset deck of dispossessed cards, attempting to release memory.
        loadDispossessedDeckInitCardCount = 0
        loadDispossessedDeckInitCards = nil
        loadDispossessedDeckInitCards = {}

        if (nil ~= cardCountHex) then
    loadDispossessedDeckInitCardCount = tonumber(cardCountHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    for cardIndex = 1,loadDispossessedDeckInitCardCount do
    parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil ~= parseCodeHex) then
    parseCode = tonumber(parseCodeHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    if (nil ~= normalCardsBySaveID[parseCode]) then
    loadDispossessedDeckInitCards[cardIndex] = normalCardsBySaveID[parseCode]
    else
    printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    else
    printToAll("Error, invalid save string.", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    end -- end loop through dispossessed deck cards
    else -- end if card count available
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end -- end if success

    --
    -- This code can be uncommented for debug purposes.
    --
    --if (STATUS_SUCCESS == loadStatus) then
    --  printToAll("Dispossessed deck:", {1,1,1})
    --  printToAll("==================", {1,1,1})
    --  printToAll(loadDispossessedDeckInitCardCount .. " cards", {1,1,1})
    --  printToAll("===========", {1,1,1})
    --  for cardIndex = 1,loadDispossessedDeckInitCardCount do
    --    printToAll(loadDispossessedDeckInitCards[cardIndex], {1,1,1})
    --  end
    --end

    return nextParseIndex
end

function loadFromSaveString_3_1_0(saveDataString)
    local parseCodeHex = nil
    local parseCode = nil
    local cardCountHex = nil
    local nextParseIndex = startParseIndex
    local cardFound = false
    local missingRelicCount = 0
    local updatedRelicDeck = {}
    local relicDeckDeleteIndices = {}

    -- Parse the first part of the save string, which is the same as the old version but does not include relic deck data.
    nextParseIndex = loadFromSaveString_1_6_0(saveDataString)

    --
    -- Parse relic deck data.
    --

    if (STATUS_SUCCESS == loadStatus) then
        cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        -- Reset relic deck, attempting to release memory.
        loadRelicDeckInitCardCount = 0
        loadRelicDeckInitCards = nil
        loadRelicDeckInitCards = {}

        if (nil ~= cardCountHex) then
    loadRelicDeckInitCardCount = tonumber(cardCountHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    for cardIndex = 1,loadRelicDeckInitCardCount do
    parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil ~= parseCodeHex) then
    parseCode = tonumber(parseCodeHex, 16)
    nextParseIndex = (nextParseIndex + 2)

    if (nil ~= normalCardsBySaveID[parseCode]) then
    loadRelicDeckInitCards[cardIndex] = normalCardsBySaveID[parseCode]
    else
    printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    else
    printToAll("Error, invalid save string.", {1,0,0})
    loadStatus = STATUS_FAILURE
    break
    end
    end -- end loop through relic deck cards
    else -- end if card count available
    printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        end
    end -- end if success

    --
    -- In case of corrupted chronicles, detect and fix any duplicate or missing relics, considering both the map and the relic deck.
    --

    if (STATUS_SUCCESS == loadStatus) then
        -- First, scan the map for relics.
        for siteIndex = 1,8 do
            for normalCardIndex = 1,3 do
                cardName = loadMapNormalCards[siteIndex][normalCardIndex][1]
                cardInfo = cardsTable[cardName]

                if (nil ~= cardInfo) then
            -- This should already be guaranteed, but make sure that relics are facedown to start the game.
            if ("Relic" == cardInfo.cardtype) then
            if (false == loadMapNormalCards[siteIndex][normalCardIndex][2]) then
            loadMapNormalCards[siteIndex][normalCardIndex][2] = true
            printToAll("INFO:  Flipped map relic facedown.", {1,1,0})
            end
            end

            if ("Relic" == cardInfo.cardtype) then
            -- Check if there are any duplicate(s) on the map itself after the current position.
            for checkSiteIndex = 1,8 do
            for checkNormalCardIndex = 1,3 do
            if ((checkSiteIndex > siteIndex) or
            ((checkSiteIndex == siteIndex) and (checkNormalCardIndex > normalCardIndex))) then
            checkCardName = loadMapNormalCards[checkSiteIndex][checkNormalCardIndex][1]
            checkCardInfo = cardsTable[checkCardName]

            if (nil ~= checkCardInfo) then
            if ("Relic" == checkCardInfo.cardtype) then
            if (cardName == checkCardName) then
            printToAll("INFO:  Deleted duplicate relic \"" .. checkCardName .. "\" from the map.", {1,1,0})

            -- Delete the duplicate from the map.
            loadMapNormalCards[checkSiteIndex][checkNormalCardIndex][1] = "NONE"
            loadMapNormalCards[checkSiteIndex][checkNormalCardIndex][2] = false
            end -- end if (cardName == checkCardName)
            end -- end if ("Relic" == checkCardInfo.cardtype)
            end -- end if (nil ~= checkCardInfo)
            end -- end if this is later on the map
            end -- end for checkNormalCardIndex = 1,3
                end -- end for checkSiteIndex = 1,8
                end -- end if ("Relic" == cardInfo.cardtype)
                end -- end if (nil ~= cardInfo)
            end -- end for normalCardIndex = 1,3
        end -- end for siteIndex = 1,8

        -- Delete any card(s) from the relic deck which are duplicate of map relic card(s).
        -- An array copy is used to avoid problems when the array shifts down, adjusting indices.
        updatedRelicDeck = {}
        for sourceRelicDeckIndex = 1,loadRelicDeckInitCardCount do
            cardFound = false
            sourceCardName = loadRelicDeckInitCards[sourceRelicDeckIndex]

            for siteIndex = 1,8 do
                for normalCardIndex = 1,3 do
                    cardName = loadMapNormalCards[siteIndex][normalCardIndex][1]
                    cardInfo = cardsTable[cardName]

                    if (nil ~= cardInfo) then
                if ("Relic" == cardInfo.cardtype) then
                if (sourceCardName == cardName) then
                    printToAll("INFO:  Deleted duplicate relic \"" .. cardName .. "\" from the relic deck.", {1,1,0})
                    cardFound = true
                    break
                    end -- end if (sourceCardName == cardName)
                    end -- end if ("Relic" == cardInfo.cardtype)
                    end -- end if (nil ~= cardInfo)
                end -- for normalCardIndex = 1,3

                if (true == cardFound) then
                    break
                end
            end -- for siteIndex = 1,8

            if (false == cardFound) then
                table.insert(updatedRelicDeck, loadRelicDeckInitCards[sourceRelicDeckIndex])
            end
        end -- end for sourceRelicDeckIndex = 1,loadRelicDeckInitCardCount do

        loadRelicDeckInitCards = updatedRelicDeck
        loadRelicDeckInitCardCount = #updatedRelicDeck

        -- Now, scan the relic deck itself.  Start at the end of the array which represents the top card.
        -- An array copy is used to avoid problems when the array shifts down, adjusting indices.  Note
        -- that this loop stops at 2 since with a topdown scan, there is nothing the bottom card can
        -- be a duplicate of.
        relicDeckDeleteIndices = {}
        for cardIndex = loadRelicDeckInitCardCount,2,-1 do
            -- Check only for duplicates lower in the deck.
            for checkCardIndex = (cardIndex - 1),1,-1 do
                if (loadRelicDeckInitCards[cardIndex] == loadRelicDeckInitCards[checkCardIndex]) then
                    -- Prepare to delete the lower duplicate from the relic deck.  Keep searching in case
                    -- there are more duplicate(s) lower in the deck.
                    printToAll("INFO:  Deleted duplicate relic \"" .. loadRelicDeckInitCards[checkCardIndex] .. "\" from the relic deck.", {1,1,0})
                    table.insert(relicDeckDeleteIndices, checkCardIndex)
                end -- end if (loadRelicDeckInitCards[cardIndex] == loadRelicDeckInitCards[checkCardIndex])
            end -- end for checkCardIndex = cardIndex,loadRelicDeckInitCardCount
        end -- end for cardIndex = 1,loadRelicDeckInitCardCount

        -- Delete any newly found duplicate card(s) from the relic deck.
        -- An array copy is used to avoid problems when the array shifts down, adjusting indices.
        updatedRelicDeck = {}
        for sourceRelicDeckIndex = 1,loadRelicDeckInitCardCount do
            cardFound = false

            for arrayIndex,indexToDelete in ipairs(relicDeckDeleteIndices) do
                if (sourceRelicDeckIndex == indexToDelete) then
                    cardFound = true
                    break
                end
            end

            if (false == cardFound) then
                table.insert(updatedRelicDeck, loadRelicDeckInitCards[sourceRelicDeckIndex])
            end
        end -- end for sourceRelicDeckIndex = 1,loadRelicDeckInitCardCount

        loadRelicDeckInitCards = updatedRelicDeck
        loadRelicDeckInitCardCount = #updatedRelicDeck

        -- Finally, if any relics do not exist on the map or the relic deck, add them to the relic deck.
        missingRelicCount = 0
        for cardSaveID = 218,237 do
            cardName = normalCardsBySaveID[cardSaveID]
            cardFound = false

            -- Check the map for the relic.
            if (false == cardFound) then
                for checkSiteIndex = 1,8 do
                    for checkNormalCardIndex = 1,3 do
                        checkCardName = loadMapNormalCards[checkSiteIndex][checkNormalCardIndex][1]
                        checkCardInfo = cardsTable[checkCardName]

                        if (nil ~= checkCardInfo) then
                    if ("Relic" == checkCardInfo.cardtype) then
                    if (cardName == checkCardName) then
                        cardFound = true
                        break
                        end -- if (cardName == checkCardName)
                        end -- if ("Relic" == checkCardInfo.cardtype)
                        end -- if (nil ~= checkCardInfo)
                    end -- end for checkNormalCardIndex = 1,3
                end -- end for checkSiteIndex = 1,8
            end -- end if (false == cardFound)

            -- Check the relic deck for the relic.
            if (false == cardFound) then
                for checkCardIndex = 1,loadRelicDeckInitCardCount do
                    if (cardName == loadRelicDeckInitCards[checkCardIndex]) then
                        cardFound = true
                        break
                    end
                end
            end -- end if (false == cardFound)

            -- If the relic was not found, add it to the relic deck.
            if (false == cardFound) then
                table.insert(loadRelicDeckInitCards, cardName)
                loadRelicDeckInitCardCount = (loadRelicDeckInitCardCount + 1)
                missingRelicCount = (missingRelicCount + 1)
            end
        end -- end for cardSaveID = 218,237

        if (20 == missingRelicCount) then
            -- This is the case for !reset_chronicle.  Create a random relic deck.
            generateRandomRelicDeck({}, 0, 0)
            -- Copy it into the load structure so that setupLoadedState() will work correctly.
            loadRelicDeckInitCardCount = curRelicDeckCardCount
            loadRelicDeckInitCards = {}
            for cardIndex = 1,curRelicDeckCardCount do
                loadRelicDeckInitCards[cardIndex] = curRelicDeckCards[cardIndex]
            end

            if (false == isManualControlEnabled) then
                printToAll("INFO:  Initialized random relic deck.", {0,0.8,0})
            end
        elseif (missingRelicCount > 0) then
            printToAll("INFO:  Added " .. missingRelicCount .. " missing relics to the relic deck.", {1,1,0})
        else
            -- Nothing needs done.
        end
    end -- end if (STATUS_SUCCESS == loadStatus)

    --
    -- This code can be uncommented for debug purposes.
    --
    --if (STATUS_SUCCESS == loadStatus) then
    --  printToAll("Relic deck:", {1,1,1})
    --  printToAll("===========", {1,1,1})
    --  printToAll(loadRelicDeckInitCardCount .. " cards", {1,1,1})
    --  printToAll("===========", {1,1,1})
    --  for cardIndex = 1,loadRelicDeckInitCardCount do
    --    printToAll(loadRelicDeckInitCards[cardIndex], {1,1,1})
    --  end
    --end

    return nextParseIndex
end

function loadFromSaveString_3_3_1(saveDataString)
    local nextParseIndex = startParseIndex
    local parseSteamNameLength = nil
    local hexValue = nil
    local byteValue = nil

    -- Parse the first part of the save string using the previous format.
    nextParseIndex = loadFromSaveString_3_1_0(saveDataString)

    --
    -- Parse previous game data.
    --

    if (STATUS_SUCCESS == loadStatus) then
        hexValue = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))
        byteValue = tonumber(hexValue, 16)
        nextParseIndex = (nextParseIndex + 2)

        parsePreviousExileCitizenStatusByte(byteValue)

        hexValue = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))
        byteValue = tonumber(hexValue, 16)
        nextParseIndex = (nextParseIndex + 2)

        parsePreviousWinningColorByte(byteValue)

        -- Parse the winning Steam name.

        hexValue = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))
        parseSteamNameLength = tonumber(hexValue, 16)
        nextParseIndex = (nextParseIndex + 2)

        if ((parseSteamNameLength >= MIN_NAME_LENGTH) and
                (parseSteamNameLength <= MAX_NAME_LENGTH)) then
            -- Confirm the entire Steam name string is present.
            if (((nextParseIndex + parseSteamNameLength) - 1) <= string.len(saveDataString)) then
                loadPreviousWinningSteamName = string.sub(saveDataString, nextParseIndex, (nextParseIndex + (parseSteamNameLength - 1)))
                nextParseIndex = (nextParseIndex + parseSteamNameLength)
            else
                printToAll("Error, invalid save string.", {1,0,0})
                loadStatus = STATUS_FAILURE
            end
        else
            printToAll("Error, invalid save string.", {1,0,0})
            loadStatus = STATUS_FAILURE
        end
    end
end

function parseExileCitizenStatusByte(statusByte)
    -- Use bitwise AND to read bits from the exile/citizen status byte.

    if (0x10 == bit32.band(statusByte, 0x10)) then
        loadPlayerStatus["Brown"][1] = "Citizen"
    else
        loadPlayerStatus["Brown"][1] = "Exile"
    end

    if (0x08 == bit32.band(statusByte, 0x08)) then
        loadPlayerStatus["Yellow"][1] = "Citizen"
    else
        loadPlayerStatus["Yellow"][1] = "Exile"
    end

    if (0x04 == bit32.band(statusByte, 0x04)) then
        loadPlayerStatus["White"][1] = "Citizen"
    else
        loadPlayerStatus["White"][1] = "Exile"
    end

    if (0x02 == bit32.band(statusByte, 0x02)) then
        loadPlayerStatus["Blue"][1] = "Citizen"
    else
        loadPlayerStatus["Blue"][1] = "Exile"
    end

    if (0x01 == bit32.band(statusByte, 0x01)) then
        loadPlayerStatus["Red"][1] = "Citizen"
    else
        loadPlayerStatus["Red"][1] = "Exile"
    end
end

function parsePreviousActiveStatusByte(statusByte)
    -- Use bitwise AND to read bits from the previous game active/inactive status byte.

    if (0x40 == bit32.band(statusByte, 0x40)) then
        loadPreviousPlayersActive["Clock"] = true
    else
        loadPreviousPlayersActive["Clock"] = false
    end

    if (0x20 == bit32.band(statusByte, 0x20)) then
        loadPreviousPlayersActive["Purple"] = true
    else
        loadPreviousPlayersActive["Purple"] = false
    end

    if (0x10 == bit32.band(statusByte, 0x10)) then
        loadPreviousPlayersActive["Brown"] = true
    else
        loadPreviousPlayersActive["Brown"] = false
    end

    if (0x08 == bit32.band(statusByte, 0x08)) then
        loadPreviousPlayersActive["Yellow"] = true
    else
        loadPreviousPlayersActive["Yellow"] = false
    end

    if (0x04 == bit32.band(statusByte, 0x04)) then
        loadPreviousPlayersActive["White"] = true
    else
        loadPreviousPlayersActive["White"] = false
    end

    if (0x02 == bit32.band(statusByte, 0x02)) then
        loadPreviousPlayersActive["Blue"] = true
    else
        loadPreviousPlayersActive["Blue"] = false
    end

    if (0x01 == bit32.band(statusByte, 0x01)) then
        loadPreviousPlayersActive["Red"] = true
    else
        loadPreviousPlayersActive["Red"] = false
    end
end

function parsePreviousExileCitizenStatusByte(statusByte)
    -- Use bitwise AND to read bits from the previous exile/citizen status byte.

    if (0x10 == bit32.band(statusByte, 0x10)) then
        loadPreviousPlayerStatus["Brown"] = "Citizen"
    else
        loadPreviousPlayerStatus["Brown"] = "Exile"
    end

    if (0x08 == bit32.band(statusByte, 0x08)) then
        loadPreviousPlayerStatus["Yellow"] = "Citizen"
    else
        loadPreviousPlayerStatus["Yellow"] = "Exile"
    end

    if (0x04 == bit32.band(statusByte, 0x04)) then
        loadPreviousPlayerStatus["White"] = "Citizen"
    else
        loadPreviousPlayerStatus["White"] = "Exile"
    end

    if (0x02 == bit32.band(statusByte, 0x02)) then
        loadPreviousPlayerStatus["Blue"] = "Citizen"
    else
        loadPreviousPlayerStatus["Blue"] = "Exile"
    end

    if (0x01 == bit32.band(statusByte, 0x01)) then
        loadPreviousPlayerStatus["Red"] = "Citizen"
    else
        loadPreviousPlayerStatus["Red"] = "Exile"
    end
end

function parsePreviousWinningColorByte(statusByte)
    -- Use bitwise AND to read bits from the previous exile/citizen status byte.

    if (0x20 == bit32.band(statusByte, 0x20)) then
        loadPreviousWinningColor = "Purple"
    elseif (0x10 == bit32.band(statusByte, 0x10)) then
        loadPreviousWinningColor = "Brown"
    elseif (0x08 == bit32.band(statusByte, 0x08)) then
        loadPreviousWinningColor = "Yellow"
    elseif (0x04 == bit32.band(statusByte, 0x04)) then
        loadPreviousWinningColor = "White"
    elseif (0x02 == bit32.band(statusByte, 0x02)) then
        loadPreviousWinningColor = "Blue"
    elseif (0x01 == bit32.band(statusByte, 0x01)) then
        loadPreviousWinningColor = "Red"
    else
        -- This should never happen.
        printToAll("Error, no previous winner found.", {1,0,0})
        loadPreviousWinningColor = "Purple"
    end
end

function updatePlayerBoardRotation(updateColor)
    local boardRotation = nil

    if ("Purple" ~= updateColor) then
    boardRotation = playerBoards[updateColor].getRotation()
    if ("Exile" == curPlayerStatus[updateColor][1]) then
    playerBoards[updateColor].setRotation({ boardRotation[1], boardRotation[2], 0.0 })
    else
    playerBoards[updateColor].setRotation({ boardRotation[1], boardRotation[2], 180.0 })
    end
    end
end

function updateRotationFromPlayerBoard(playerColor)
    local boardRotation = nil
    local translatedPlayerColor = playerColor

    if ("Brown" == playerColor) then
        translatedPlayerColor = "Black"
    end

    if ("Purple" ~= playerColor) then
    -- Only check the player color if the player is active.
    if (true == curPlayerStatus[playerColor][2]) then
    boardRotation = playerBoards[playerColor].getRotation()
    if ((boardRotation[3] >= (-20.0)) and (boardRotation[3] <= (20.0))) then
    if (curPlayerStatus[playerColor][1] ~= "Exile") then
    printToAll("Warning, " .. translatedPlayerColor .. " player board was manually flipped and has been resynced.", {1,1,1})
    curPlayerStatus[playerColor][1] = "Exile"
    end
    else
    if (curPlayerStatus[playerColor][1] ~= "Citizen") then
    printToAll("Warning, " .. translatedPlayerColor .. " player board was manually flipped and has been resynced.", {1,1,1})
    curPlayerStatus[playerColor][1] = "Citizen"
    end
    end
    end
    end
end

function visionCheckResult(player, value, id)
    --
    -- This implements chronicle step 8.1:  Vow an Oath.
    --

    if (true == player.host) then
        if ("yes" == value) then
            -- Make sure the winning player was actually an Exile.
            if ("Exile" == curPlayerStatus[pendingWinningColor][1]) then
                usedVision = true
                wonBySuccession = false

                -- If a player won with a Vision, the Oath for the next game matches it.
                pendingOath = nil
                Global.UI.setAttribute("mark_vision", "active", false)
                Global.UI.setAttribute("panel_use_vision_check", "active", false)
                Global.UI.setAttribute("panel_choose_vision", "active", true)
            else
                printToAll("Impossible.  Only those living in Exile truly see Visions.", {1,0,0})
            end
        else
            usedVision = false
            wonBySuccession = false

            -- If a player won without a Vision, they must choose any Oath except the current one for the next game.
            pendingOath = nil
            Global.UI.setAttribute("mark_chronicle_oath", "active", false)
            Global.UI.setAttribute("panel_use_vision_check", "active", false)
            Global.UI.setAttribute("banned_chronicle_oath", "offsetXY", selectOathOffsets[curOath])
            Global.UI.setAttribute("panel_choose_oath_except", "active", true)
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function changeChronicleVision(player, value, id)
    if (true == player.host) then
        pendingOath = oathNamesFromCode[tonumber(value)]
        Global.UI.setAttribute("mark_vision", "active", true)
        Global.UI.setAttribute("mark_vision", "offsetXY", selectOathOffsets[pendingOath])
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmSelectVision(player, value, id)
    if (true == player.host) then
        if (nil ~= pendingOath) then
    curOath = pendingOath
    pendingOath = nil

        Global.UI.setAttribute("panel_choose_vision", "active", false)

    handleChronicleAfterVow(player)
    else
    printToAll("Error, you must select a Vision.", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function changeChronicleOath(player, value, id)
    local clickedOath = nil

    if (true == player.host) then
        clickedOath = oathNamesFromCode[tonumber(value)]

        if (curOath == clickedOath) then
            printToAll("Error, you may not select the current Oath.", {1,0,0})
        else
            pendingOath = clickedOath
            Global.UI.setAttribute("mark_chronicle_oath", "active", true)
            Global.UI.setAttribute("mark_chronicle_oath", "offsetXY", selectOathOffsets[pendingOath])
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function confirmSelectChronicleOath(player, value, id)
    if (true == player.host) then
        if (nil ~= pendingOath) then
    curOath = pendingOath
    pendingOath = nil

        Global.UI.setAttribute("panel_choose_oath_except", "active", false)

    handleChronicleAfterVow(player)
    else
    printToAll("Error, you must select an Oath.", {1,0,0})
        end
    else
        printToAll("Error, only the host can click that.", {1,0,0})
    end
end

function handleChronicleAfterVow(player)
    --
    -- This implements chronicle step 8.2:  Offer Citizenship
    --

    -- Officially record the winner.
    winningColor = pendingWinningColor
    curPreviousWinningColor = winningColor
    if ((nil ~= Player[pendingWinningColor]) and
    (nil ~= Player[pendingWinningColor].steam_name) and
    ("" ~= Player[pendingWinningColor].steam_name)) then
    curPreviousWinningSteamName = Player[pendingWinningColor].steam_name
    else
    curPreviousWinningSteamName = "UNKNOWN"
    end
    pendingWinningColor = nil

    for i,curColor in ipairs(playerColors) do
    if ("Purple" ~= curColor) then
    grantPlayerCitizenship[curColor] = false
    end
    end

    -- This step is only performed if the winner was an Exile.
    if ("Exile" == curPlayerStatus[winningColor][1]) then
    for i,curColor in ipairs(playerColors) do
    -- Clear selection markers for each non-chancellor color.
    if ("Purple" ~= curColor) then
    Global.UI.setAttribute("mark_color_grant_" .. curColor, "active", false)

    -- Use the banned graphic for the winner, citizens, and inactive players.
    if ((winningColor == curColor) or
    ("Citizen" == curPlayerStatus[curColor][1]) or
    (false == curPlayerStatus[curColor][2])) then
    Global.UI.setAttribute("banned_citizen_" .. curColor, "active", true)
    else
    Global.UI.setAttribute("banned_citizen_" .. curColor, "active", false)
    end
    end
    end

    grantCitizenshipLocked = false

    -- Show the offer citizenship panel.  The text color needs set after making the button active due to an apparent TTS bug that resets the color.
    Global.UI.setAttribute("offer_citizenship_done", "active", true)
    Global.UI.setAttribute("offer_citizenship_done", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("offer_citizenship_skip", "active", true)
    Global.UI.setAttribute("offer_citizenship_skip", "textColor", "#FFFFFFFF")
    Global.UI.setAttribute("offer_citizenship_confirm", "active", false)
    Global.UI.setAttribute("offer_citizenship_back", "active", false)
    Global.UI.setAttribute("panel_offer_citizenship", "active", true)
    else -- if ("Exile" == curPlayerStatus[winningColor][1])
    -- Chancellor / Citizen winners cannot invite anyone.
    handleChronicleAfterOfferCitizenship(player)
    end
end

function grantCitizenship(player, value, id)
    local convertedColor = nil

    if ((true == player.host) or (player.color == winningColor)) then
        if ("Done" == value) then
            grantCitizenshipLocked = true

            -- Change the user interface so the user can click Confirm or Back.
            Global.UI.setAttribute("offer_citizenship_done", "active", false)
            Global.UI.setAttribute("offer_citizenship_skip", "active", false)
            -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
            Global.UI.setAttribute("offer_citizenship_confirm", "active", true)
            Global.UI.setAttribute("offer_citizenship_confirm", "textColor", "#FFFFFFFF")
            Global.UI.setAttribute("offer_citizenship_back", "active", true)
            Global.UI.setAttribute("offer_citizenship_back", "textColor", "#FFFFFFFF")
        elseif ("Back" == value) then
            grantCitizenshipLocked = false

            -- Go back to exile selection.  The text color needs set after making the button active due to an apparent TTS bug that resets the color.
            Global.UI.setAttribute("offer_citizenship_done", "active", true)
            Global.UI.setAttribute("offer_citizenship_done", "textColor", "#FFFFFFFF")
            Global.UI.setAttribute("offer_citizenship_skip", "active", true)
            Global.UI.setAttribute("offer_citizenship_skip", "textColor", "#FFFFFFFF")
            Global.UI.setAttribute("offer_citizenship_confirm", "active", false)
            Global.UI.setAttribute("offer_citizenship_back", "active", false)
        elseif ("Confirm" == value) then
            -- Since an Exile won, convert existing Citizens to Exiles, and grant citizenship to any selected Exiles.
            for i,curColor in ipairs(playerColors) do
                if ("Purple" ~= curColor) then
            if ("Brown" == curColor) then
            convertedColor = "Black"
            else
            convertedColor = curColor
            end

            -- Reset even inactive Citizen boards to the Exile side, but only grant active Exile players citizenship.
            if ("Citizen" == curPlayerStatus[curColor][1]) then
            curPlayerStatus[curColor][1] = "Exile"

            printToAll("The [" .. Color.fromString(convertedColor):toHex(false) .. "]" .. convertedColor .. "[-] player has become an Exile.", {1,1,1})
            elseif (("Exile" == curPlayerStatus[curColor][1]) and
            (true == curPlayerStatus[curColor][2])    and
            (true == grantPlayerCitizenship[curColor]))     then
            curPlayerStatus[curColor][1] = "Citizen"

            printToAll("The [" .. Color.fromString(convertedColor):toHex(False) .. "]" .. convertedColor .. "[-] player has joined the new Commonwealth.", {1,1,1})
                else
                -- Nothing needs done.
                end
                end -- end if ("Purple" ~= curColor)
            end -- end for i,curColor in ipairs(playerColors)

            Global.UI.setAttribute("panel_offer_citizenship", "active", false)

            handleChronicleAfterOfferCitizenship(player)
        else
            -- Otherwise, the value must be "Skip".
            grantCitizenshipLocked = true

            -- Clear all color grant options.
            for i,curColor in ipairs(playerColors) do
                if ("Purple" ~= curColor) then
            grantPlayerCitizenship[curColor] = false
                Global.UI.setAttribute("mark_color_grant_" .. curColor, "active", false)
                end
            end

            -- Change the user interface so the user can click Confirm or Back.
            Global.UI.setAttribute("offer_citizenship_done", "active", false)
            Global.UI.setAttribute("offer_citizenship_skip", "active", false)
            -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
            Global.UI.setAttribute("offer_citizenship_confirm", "active", true)
            Global.UI.setAttribute("offer_citizenship_confirm", "textColor", "#FFFFFFFF")
            Global.UI.setAttribute("offer_citizenship_back", "active", true)
            Global.UI.setAttribute("offer_citizenship_back", "textColor", "#FFFFFFFF")
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function isEdificeAvailable(edificeName)
    local edificeAvailable = true

    for siteIndex = 1,8 do
        for normalCardIndex = 1,3 do
            if (edificeName == curMapNormalCards[siteIndex][normalCardIndex][1]) then
                edificeAvailable = false
                break
            end
        end

        if (false == edificeAvailable) then
            break
        end
    end

    return edificeAvailable
end

function handleChronicleAfterOfferCitizenship(player)
    local curObjectName = nil
    local curObjectDescription = nil
    local convertedObjectColor = nil
    local doesWinnerCountBanditCrown = false
    local cardName = nil
    local cardInfo = nil
    local isCardFlipped = false
    local siteHasEdificeOrRuin = false
    local siteHasWarband = false

    --
    -- This implements chronicle step 8.3:  Clean Up Map and Build Edifices
    --

    -- Check whether the winner counts the bandit crown.
    --
    -- The winner "counting" the Bandit Crown means either the winner holds it, or a Citizen holds it after the offer citizenship phase.

    doesWinnerCountBanditCrown = false

    if (nil ~= banditCrownHoldingColor) then
    if ((winningColor == banditCrownHoldingColor) or
    ("Citizen" == curPlayerStatus[banditCrownHoldingColor][1])) then
    doesWinnerCountBanditCrown = true
    end
    end

    -- Step 8.3.1:  If winner is the Chancellor or a Citizen, they may build or repair one edifice.
    --
    --              A new edifice can only be at a site the winner rules, and they can only replace a denizen card
    --              with an edifice of the matching suit.
    --
    --              A new edifice can only be built at a site with no existing edifice (intact or ruined).
    --
    --              If repairing an edifice, the edifice must be at a site the winner rules.

    if (true == doesWinnerCountBanditCrown) then
    printToAll("Due to the Bandit Crown, all sites without warbands will be treated as ruled by the winner.", {1,1,1})
    end

    -- Update the doesWinnerRule state to determine build eligibility and other operation(s) later.
    for siteIndex = 1,8 do
    siteHasWarband = false
    doesWinnerRule[siteIndex] = false

    -- Only scan the site if it is faceup.
    if (false == curMapSites[siteIndex][2]) then
    -- Check for winning warband(s) on the site, accounting for succession victories (winning as Citizen) and former Exiles who were granted citizenship.
    --
    -- NOTE:  Per Cole on 07/31/2020, chronicle rules have changed so that "your site" no longer matters.  This means if the winner's
    --        pawn is located on a site they do not rule, that site may be removed in the chronicle phase.  If the winner rules nothing,
    --        the map could end up entirely new.
    scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
    for i,curObject in ipairs(scriptZoneObjects) do
    curObjectName = curObject.getName()
    curObjectDescription = curObject.getDescription()

    if ("Black" == curObjectDescription) then
    convertedObjectColor = "Brown"
    else
    convertedObjectColor = curObjectDescription
    end

    if ("Figurine" == curObject.tag) then
    if ("Warband" == curObjectName) then
    siteHasWarband = true

    if ((winningColor == convertedObjectColor) or
    (true == grantPlayerCitizenship[convertedObjectColor]) or
    (("Purple" == curObjectDescription) and (true == wonBySuccession))) then
    doesWinnerRule[siteIndex] = true
    end
    end
    end
    end

    -- Since the site is faceup, if the winner counts the Bandit Crown and the site does NOT have any warbands, the winner rules the site.
    if ((true == doesWinnerCountBanditCrown) and (false == siteHasWarband)) then
    doesWinnerRule[siteIndex] = true
    end
    end
    end

    if (("Chancellor" == curPlayerStatus[winningColor][1]) or ("Citizen" == curPlayerStatus[winningColor][1])) then
    -- Find options to build/repair.
    numBuildRepairOptions = 0
    for siteIndex = 1,8 do
    Global.UI.setAttribute("build_repair_" .. siteIndex, "active", false)
    Global.UI.setAttribute("build_repair_" .. siteIndex, "text", "")

    -- Scan for edifices first.
    siteHasEdificeOrRuin = false
    for normalCardIndex = 1,3 do
    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
    isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
    cardInfo = cardsTable[cardName]

    if ("EdificeRuin" == cardInfo.cardtype) then
    siteHasEdificeOrRuin = true
    break
    end
    end

    for normalCardIndex = 1,3 do
    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
    isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
    cardInfo = cardsTable[cardName]

    if ((true == doesWinnerRule[siteIndex]) and ("Denizen" == cardInfo.cardtype)) then
    -- This may be a build option if the matching edifice/ruin card is currently unused.
    if (true == isEdificeAvailable(edificesBySuit[cardInfo.suit])) then
    -- The Drowned City is never an option, even if Salt the Earth is present, due to the FAQ.
    if ("Drowned City" ~= curMapSites[siteIndex][1]) then
    -- This is a build option if no edifice/ruin already exists at this site.
    if (false == siteHasEdificeOrRuin) then
    buildRepairOptions[siteIndex][normalCardIndex] = "build"
    numBuildRepairOptions = (numBuildRepairOptions + 1)
    end
    else
    printToAll("NOTE:  Even if Salt the Earth is present, an edifice may NEVER be built at the Drowned City.", {1,1,1})
    end
    end

    -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
    Global.UI.setAttribute("build_repair_" .. siteIndex, "text", curMapSites[siteIndex][1])
    Global.UI.setAttribute("build_repair_" .. siteIndex, "active", true)
    Global.UI.setAttribute("build_repair_" .. siteIndex, "textColor", "#FFFFFFFF")
    elseif ((true == doesWinnerRule[siteIndex]) and ("EdificeRuin" == cardInfo.cardtype) and (true == isCardFlipped)) then
    -- This is a repair option.
    buildRepairOptions[siteIndex][normalCardIndex] = "repair"
    numBuildRepairOptions = (numBuildRepairOptions + 1)

    -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
    Global.UI.setAttribute("build_repair_" .. siteIndex, "text", curMapSites[siteIndex][1])
    Global.UI.setAttribute("build_repair_" .. siteIndex, "active", true)
    Global.UI.setAttribute("build_repair_" .. siteIndex, "textColor", "#FFFFFFFF")
    else
    -- This is neither a build nor repair option.
    buildRepairOptions[siteIndex][normalCardIndex] = "none"
    end
    end -- end for normalCardIndex = 1,3
    end -- end for siteIndex = 1,8
    end

    if ("Chancellor" == curPlayerStatus[winningColor][1]) then
    selectedBuildRepairIndex = nil
    Global.UI.setAttribute("mark_build_repair", "active", false)

    printToAll("As Chancellor, the winner is allowed to build or repair an edifice.", {1,1,1})
    if (numBuildRepairOptions > 0) then
    Global.UI.setAttribute("panel_build_repair", "active", true)
    else
    printToAll("But, no options are available.", {1,1,1})
    handleChronicleAfterBuildRepair(player)
    end
    elseif ("Citizen" == curPlayerStatus[winningColor][1]) then
    selectedBuildRepairIndex = nil

    printToAll("As a Citizen, the winner is allowed to build or repair an edifice.", {1,1,1})
    if (numBuildRepairOptions > 0) then
    Global.UI.setAttribute("panel_build_repair", "active", true)
    else
    printToAll("But, no options are available.", {1,1,1})
    handleChronicleAfterBuildRepair(player)
    end
    else
    printToAll("As an exile, the winner cannot build or repair an edifice.", {1,1,1})
    handleChronicleAfterBuildRepair(player)
    end
end

function selectBuildRepair(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        -- Sanity check the choice in case an invalid button is ever triggered.
        if (("none" ~= buildRepairOptions[tonumber(value)][1]) or
    ("none" ~= buildRepairOptions[tonumber(value)][2]) or
    ("none" ~= buildRepairOptions[tonumber(value)][3])) then
    selectedBuildRepairIndex = tonumber(value)
    Global.UI.setAttribute("mark_build_repair", "active", true)
    Global.UI.setAttribute("mark_build_repair", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
    else
    -- This should never happen.
    printToAll("Error, invalid site selected.", {1,0,0})
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function confirmBuildRepair(player, value, id)
    local cardName = nil
    local ruinName = nil

    if ((true == player.host) or (player.color == winningColor)) then
        if ("true" == value) then
            if (nil ~= selectedBuildRepairIndex) then
        -- Display the available denizen / ruin cards that can be chosen.
        for normalCardIndex = 1,3 do
        if ("build" == buildRepairOptions[selectedBuildRepairIndex][normalCardIndex]) then
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex,
        "text",
        "(replace) " .. curMapNormalCards[selectedBuildRepairIndex][normalCardIndex][1])
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", true)
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "textColor", "#FFFFFF")
        elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][normalCardIndex]) then
        cardName = curMapNormalCards[selectedBuildRepairIndex][normalCardIndex][1]
        ruinName = string.sub(cardName, (string.find(cardName, "/") + 2))

        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex,
        "text",
        "(repair) " .. ruinName)
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", true)
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "textColor", "#FFFFFF")
        else
        Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", false)
        end
        end

        -- Prompt to select a card from the site.
        selectedBuildRepairCardIndex = nil
        Global.UI.setAttribute("panel_build_repair", "active", false)
        Global.UI.setAttribute("mark_build_repair_card", "active", false)
        Global.UI.setAttribute("panel_build_repair_cards", "active", true)
        else -- end if (nil ~= selectedBuildRepairIndex)
        printToAll("Error, no site selected.", {1,0,0})
            end
        else
            Global.UI.setAttribute("panel_build_repair", "active", false)
            printToAll("The winner chose not to build or repair an edifice.")
            handleChronicleAfterBuildRepair(player)
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function selectBuildRepairCard(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        if ("build" == buildRepairOptions[selectedBuildRepairIndex][tonumber(value)]) then
            selectedBuildRepairCardIndex = tonumber(value)
            Global.UI.setAttribute("mark_build_repair_card", "active", true)
            Global.UI.setAttribute("mark_build_repair_card", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
        elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][tonumber(value)]) then
            selectedBuildRepairCardIndex = tonumber(value)
            Global.UI.setAttribute("mark_build_repair_card", "active", true)
            Global.UI.setAttribute("mark_build_repair_card", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
        else
            -- This should never happen.
            printToAll("Error, invalid card selected.", {1,0,0})
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function cancelBuildRepairCards(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        selectedBuildRepairIndex = nil

        Global.UI.setAttribute("panel_build_repair_cards", "active", false)
        Global.UI.setAttribute("mark_build_repair", "active", false)
        Global.UI.setAttribute("panel_build_repair", "active", true)
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function confirmBuildRepairCards(player, value, id)
    local cardName = nil
    local cardInfo = nil
    local cardSuit = nil
    local edificeName = nil
    local ruinName = nil
    local edificeIndex = nil
    local edificeFullName = nil
    local edificeAvailable = false
    local siteEdificeCardCount = 0

    if ((true == player.host) or (player.color == winningColor)) then
        if (nil ~= selectedBuildRepairCardIndex) then
    -- Check if an edifice card is already on the site.
    siteEdificeCardCount = 0
    for normalCardIndex = 1,3 do
    cardName = curMapNormalCards[selectedBuildRepairIndex][normalCardIndex][1]
    cardInfo = cardsTable[cardName]
    if ("EdificeRuin" == cardInfo.cardtype) then
    siteEdificeCardCount = (siteEdificeCardCount + 1)
    end
    end

    -- Warn if more than one edifice card was found at this site.  It should be impossible for
    -- more than one edifice card to exist at a single location, aside from old chronicles.
    if (siteEdificeCardCount > 1) then
    printToAll("Warning, more than one edifice card was found at site \"" .. curMapSites[selectedBuildRepairIndex][1] .. "\".", {1,1,1})
    printToAll("This may happen if you are continuing an old chronicle, but should not happen for a new chronicle.", {1,1,1})
    end

    if ("build" == buildRepairOptions[selectedBuildRepairIndex][selectedBuildRepairCardIndex]) then
    -- Check if the matching edifice is available.
    cardName = curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1]
    cardSuit = cardsTable[cardName].suit
    edificeIndex = edificeIndicesBySuit[cardSuit]
    edificeFullName = normalCardsBySaveID[edificeSaveIDs[edificeIndex]]

    edificeAvailable = true
    for siteIndex = 1,8 do
    for normalCardIndex = 1,3 do
    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
    if (edificeFullName == cardName) then
    edificeAvailable = false
    break
    end
    end
    end

    if (true == edificeAvailable) then
        -- Check if an edifice already existed at the site.
        if (0 == siteEdificeCardCount) then
        selectedEdificeIndex = edificeIndex
        Global.UI.setAttribute("sheet_edifices", "offsetXY", edificeOffsets[selectedEdificeIndex])
        Global.UI.setAttribute("sheet_ruins", "offsetXY", edificeOffsets[selectedEdificeIndex])
        Global.UI.setAttribute("panel_build_repair_cards", "active", false)
        Global.UI.setAttribute("panel_choose_edifice", "active", true)
        else
        -- This should never happen anymore, since the site edifice status is checked earlier.
        printToAll("Error, the \"" .. curMapSites[selectedBuildRepairIndex][1] .. "\" site already has an edifice / ruin card.", {1,0,0})
        end
        else
        -- This should never happen anymore, since the edifice availability is checked earlier.
        printToAll("Error, the " .. cardSuit .. " edifice or ruin is already on the map.", {1,0,0})
    end
    elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][selectedBuildRepairCardIndex]) then
    cardName = curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1]
    edificeName = string.sub(cardName, 1, (string.find(cardName, "/") - 2))
    ruinName = string.sub(cardName, (string.find(cardName, "/") + 2))

    -- Flip the ruin back to the edifice side.
    curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][2] = false
    printToAll(ruinName .. " was repaired and is now " .. edificeName .. ".", {1,1,1})

    -- Continue with the chronicle phase.
    Global.UI.setAttribute("panel_build_repair_cards", "active", false)
    handleChronicleAfterBuildRepair(player)
    else
    -- This should never happen.
    printToAll("Error, invalid card selected.", {1,0,0})
    end
    else -- end if (nil ~= selectedBuildRepairCardIndex)
    printToAll("Error, no card selected.", {1,0,0})
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function edificeCancel(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        selectedBuildRepairCardIndex = nil

        Global.UI.setAttribute("panel_choose_edifice", "active", false)
        Global.UI.setAttribute("mark_build_repair_card", "active", false)
        Global.UI.setAttribute("panel_build_repair_cards", "active", true)
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function edificeConfirm(player, value, id)
    local oldCardName = nil
    local newCardName = nil
    local newCardSuit = nil
    local edificeIndex = nil
    local edificeName = nil

    if ((true == player.host) or (player.color == winningColor)) then
        oldCardName = curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1]
        newCardName = normalCardsBySaveID[edificeSaveIDs[selectedEdificeIndex]]
        newCardSuit = cardsTable[newCardName].suit
        edificeIndex = edificeIndicesBySuit[cardSuit]
        edificeName = string.sub(newCardName, 1, (string.find(newCardName, "/") - 2))

        -- Replace the denizen card with the edifice.
        curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1] = newCardName
        curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][2] = false
        printToAll(oldCardName .. " was replaced by " .. edificeName .. ".", {0,0.8,0})

        -- Discard the old denizen card.  The scanTable() function will not be called again
        -- during the Chronicle phase so this is okay to do.
        if (selectedBuildRepairIndex <= 2) then
            table.insert(discardContents[2], oldCardName)
        elseif (selectedBuildRepairIndex <= 5) then
            table.insert(discardContents[3], oldCardName)
        else
            table.insert(discardContents[1], oldCardName)
        end

        -- Continue with the chronicle phase.
        Global.UI.setAttribute("panel_choose_edifice", "active", false)
        handleChronicleAfterBuildRepair(player)
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function handleChronicleAfterBuildRepair(player)
    local setAsideSites = {}
    local setAsideNormalCards = {}
    local curObjectName = nil
    local curObjectDescription = nil
    local convertedObjectColor = nil
    local scriptZoneObjects = nil
    local adviserSuitCounts = nil
    local cardName = nil
    local cardInfo = nil
    local cardSuit = nil
    local isCardFlipped = false
    local hasRuin = false
    local siteFound = false
    local maxSuitCount = 0
    local availableSites = {}
    local removeSiteIndex = 0
    local numAvailableSites = 0
    local siteUsed = false
    local siteName = nil
    local wasEdificeFlipped = false
    local forestTempleExists = false

    -- Step 8.3.2:  Discard all site cards except sites the winner rules and sites with an intact edifice.
    --              The winner is considered to rule sites formerly ruled by other Exile(s) if those Exile(s) were granted citizenship by a winning Exile.
    --              It includes all sites ruled by the Commonwealth if the winner was part of the Commonwealth.

    -- Do edifice processing before doing further site and denizen checking.
    for siteIndex = 1,8 do
        keepSiteStatus[siteIndex] = false

        for normalCardIndex = 1,3 do
            cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
            cardInfo = cardsTable[cardName]
            if (nil ~= cardInfo) then
        if (("EdificeRuin" == cardInfo.cardtype) and (false == isCardFlipped)) then
        keepSiteStatus[siteIndex] = true

        -- Check if this is the forest temple.  The flip status was already checked, so this is the Forest Temple if it matches the full name.
        if ("Forest Temple / Ruined Temple" == cardName) then
        forestTempleExists = true
        end
        end
        end
        end
    end

    if (true == forestTempleExists) then
        printToAll("The Forest Temple exists!  All sites with beast cards will be kept.", {1,1,1})
    end

    -- Now that edifice and Forest Temple status is known, check all sites.
    for siteIndex = 1,8 do
        -- Check for winning warband(s) on the site, accounting for succession victories (winning as Citizen) and former Exiles who were granted citizenship.
        --
        -- NOTE:  Per Cole on 07/31/2020, chronicle rules have changed so that "your site" no longer matters.  This means if the winner's
        --        pawn is located on a site they do not rule, that site may be removed in the chronicle phase.  If the winner rules nothing,
        --        the map could end up entirely new.
        scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
            curObjectName = curObject.getName()
            curObjectDescription = curObject.getDescription()

            if ("Black" == curObjectDescription) then
                convertedObjectColor = "Brown"
            else
                convertedObjectColor = curObjectDescription
            end

            if ("Figurine" == curObject.tag) then
                if (("Warband" == curObjectName) and
                        ((winningColor == convertedObjectColor) or
                                (true == grantPlayerCitizenship[convertedObjectColor]) or
                                (("Purple" == curObjectDescription) and (true == wonBySuccession)))) then
                    keepSiteStatus[siteIndex] = true
                end
            end
        end

        -- Check if doesWinnerRule was set earlier.
        if (true == doesWinnerRule[siteIndex]) then
            keepSiteStatus[siteIndex] = true
        end

        -- Check for an intact edifice, or a Beast card when the Forest Temple is in play.
        for normalCardIndex = 1,3 do
            cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
            cardInfo = cardsTable[cardName]
            if (nil ~= cardInfo) then
        if (("EdificeRuin" == cardInfo.cardtype) and (false == isCardFlipped)) then
        keepSiteStatus[siteIndex] = true
        elseif ((true == forestTempleExists) and ("Denizen" == cardInfo.cardtype) and ("Beast" == cardInfo.suit)) then
        -- Since the Forest Temple exists, any Beast denizen will result in the site being kept.
        printToAll("Due to the Forest Temple, keeping site \"" .. curMapSites[siteIndex][1] .. "\".", {0,0.8,0})
        keepSiteStatus[siteIndex] = true
        else
        -- Nothing needs done.
        end
        end
        end

        -- Discard the site card if there is no reason for it to be kept.
        if (false == keepSiteStatus[siteIndex]) then
            -- Only print a message if the site was faceup.
            if (("NONE" ~= curMapSites[siteIndex][1]) and (false == curMapSites[siteIndex][2])) then
        printToAll("Discarding site \"" .. curMapSites[siteIndex][1] .. "\".", {0,0.8,0})
        end

        -- The available site list will be generated later, so the site data can simply be deleted.
        curMapSites[siteIndex][1] = "NONE"
        curMapSites[siteIndex][2] = false

        -- Delete the site card.
        scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
        curObjectName = curObject.getName()
        if ("Card" == curObject.tag) then
        destroyObject(curObject)
        end
        end

        -- Discard all denizen, relic, and ruin cards.
        for normalCardIndex = 1,3 do
        scriptZoneObjects = mapNormalCardZones[siteIndex][normalCardIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
        if ("Card" == curObject.tag) then
        cardName = curObject.getName()
        cardInfo = cardsTable[cardName]

        if (nil ~= cardInfo) then
        if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
        -- Discard denizen and vision cards to the discard pile structure.  The scanTable() function
        -- will not be called again during the Chronicle phase so this is okay to do.
        if (siteIndex <= 2) then
        table.insert(discardContents[2], cardName)
        elseif (siteIndex <= 5) then
        table.insert(discardContents[3], cardName)
        else
        table.insert(discardContents[1], cardName)
        end
        elseif ("Relic" == cardInfo.cardtype) then
        -- Discard relic cards back into the relic deck structure.
        table.insert(curRelicDeckCards, cardName)
        curRelicDeckCardCount = (curRelicDeckCardCount + 1)
        else
        -- Nothing needs done in the case of ruin cards.  They will automatically be detected as available in the future.
        end

        -- Update the normal card data structure.  The scanTable() function
        -- will not be called again during the Chronicle phase so this is okay to do.
        curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"
        curMapNormalCards[siteIndex][normalCardIndex][2] = false
        else -- end if (nil ~= cardInfo)
        printToAll("Error, unknown card found in site denizen area.", {1,0,0})
            end

            -- Delete the card.
            destroyObject(curObject)
            end -- end if ("Card" == curObject.tag)
            end -- end for i,curObject in ipairs(scriptZoneObjects)
            end -- end for normalCardIndex = 1,3
        end -- end if (false == keepSiteStatus[siteIndex])
    end -- end for siteIndex = 1,8

    -- Step 8.3.3:  Flip any intact edifices NOT ruled by the winner to their ruined sides.
    --              Due to earlier logic, this takes into account succession victories and promoted Exiles.
    --
    --              Discard all denizen cards at sites where an edifice was flipped.
    --
    --              Then, set aside any sites that have ruins, along with their ruin and relic cards, ordered from
    --              top of Cradle to bottom of Hinterland.
    for siteIndex = 1,8 do
        hasRuin = false
        wasEdificeFlipped = false

        for normalCardIndex = 1,3 do
            cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
            cardInfo = cardsTable[cardName]
            if (nil ~= cardInfo) then
        if ("EdificeRuin" == cardInfo.cardtype) then
        if ((false == isCardFlipped) and (false == doesWinnerRule[siteIndex])) then
        -- This is an edifice falling into ruin, so flip it.
        printToAll(cardName .. " has fallen into ruin.", {0,0.8,0})
        curMapNormalCards[siteIndex][normalCardIndex][2] = true
        hasRuin = true

        -- Record that denizen cards need discarded.
        wasEdificeFlipped = true
        else
            if (true == isCardFlipped) then
            -- This is an existing ruin.
            hasRuin = true
            end
            end
            end
            end -- end if (nil ~= cardInfo)
        end -- end for normalCardIndex = 1,3

        if (true == hasRuin) then
            -- Discard denizen cards if needed.
            if (true == wasEdificeFlipped) then
                for normalCardIndex = 1,3 do
                    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
                    cardInfo = cardsTable[cardName]

                    if ("Denizen" == cardInfo.cardtype) then
                        if (siteIndex <= 2) then
                            table.insert(discardContents[2], cardName)
                        elseif (siteIndex <= 5) then
                            table.insert(discardContents[3], cardName)
                        else
                            table.insert(discardContents[1], cardName)
                        end

                        curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"
                        curMapNormalCards[siteIndex][normalCardIndex][2] = false
                    end
                end
            end

            -- Set aside the site and associated cards.
            table.insert(setAsideSites, { curMapSites[siteIndex][1],
                                          curMapSites[siteIndex][2] })
            table.insert(setAsideNormalCards, { { curMapNormalCards[siteIndex][1][1], curMapNormalCards[siteIndex][1][2] },
                                                { curMapNormalCards[siteIndex][2][1], curMapNormalCards[siteIndex][2][2] },
                                                { curMapNormalCards[siteIndex][3][1], curMapNormalCards[siteIndex][3][2] } })

            -- Clear the site and normal card area for now.
            curMapSites[siteIndex][1] = "NONE"
            curMapSites[siteIndex][2] = false
            for normalCardIndex = 1,3 do
                curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"
                curMapNormalCards[siteIndex][normalCardIndex][2] = false
            end
        end -- end if (true == hasRuin)
    end -- end for siteIndex = 1,8

    -- Step 8.3.4:  Remove pawns, favor, secrets, and warbands from map.
    -- This is done in cleanTable() which is called later on.

    -- Step 8.3.5:  Fill empty site slots by moving sites, along with their attached denizen, intact edifice, and relic cards.

    -- Substep 1:  Fill empty Cradle site slots from top to bottom by pushing Cradle sites up, then by moving Provinces sites
    --             from top to bottom, then by moving Hinterland sites from top to bottom.

    -- Move the bottom site up if possible.
    if ((curMapSites[1][1] == "NONE") and
            (curMapSites[2][1] ~= "NONE")) then
    printToAll("Moved site \"" .. curMapSites[2][1] .. "\" up.", {0,0.8,0})
    curMapSites[1][1] = curMapSites[2][1]
    curMapSites[1][2] = curMapSites[2][2]
    curMapSites[2][1] = "NONE"
    curMapSites[2][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[1][normalCardIndex][1] = curMapNormalCards[2][normalCardIndex][1]
    curMapNormalCards[1][normalCardIndex][2] = curMapNormalCards[2][normalCardIndex][2]
    curMapNormalCards[2][normalCardIndex][1] = "NONE"
    curMapNormalCards[2][normalCardIndex][2] = false
    end -- end for normalCardIndex = 1,3
    end -- end if possible to move site up

    -- Fill empty Cradle site slots from top to bottom.  Note that intact edifices ARE allowed to move.
    for siteIndex = 1,2 do
    siteFound = false
    if (curMapSites[siteIndex][1] == "NONE") then
    -- Check Provinces.
    for fromSiteIndex = 3,5 do
    if (curMapSites[fromSiteIndex][1] ~= "NONE") then
    siteFound = true

    printToAll("Moved site \"" .. curMapSites[fromSiteIndex][1] .. "\" to the Cradle.", {0,0.8,0})
    curMapSites[siteIndex][1] = curMapSites[fromSiteIndex][1]
    curMapSites[siteIndex][2] = curMapSites[fromSiteIndex][2]
    curMapSites[fromSiteIndex][1] = "NONE"
    curMapSites[fromSiteIndex][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[fromSiteIndex][normalCardIndex][1]
    curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[fromSiteIndex][normalCardIndex][2]
    curMapNormalCards[fromSiteIndex][normalCardIndex][1] = "NONE"
    curMapNormalCards[fromSiteIndex][normalCardIndex][2] = false
    end

    break
    end -- end if (curMapSites[fromSiteIndex][1] ~= "NONE")
    end -- end for fromSiteIndex = 3,5 do

    if (false == siteFound) then
    -- Check Hinterland.
    for fromSiteIndex = 6,8 do
    if (curMapSites[fromSiteIndex][1] ~= "NONE") then
    siteFound = true

    printToAll("Moved site \"" .. curMapSites[fromSiteIndex][1] .. "\" to the Cradle.", {0,0.8,0})
    curMapSites[siteIndex][1] = curMapSites[fromSiteIndex][1]
    curMapSites[siteIndex][2] = curMapSites[fromSiteIndex][2]
    curMapSites[fromSiteIndex][1] = "NONE"
    curMapSites[fromSiteIndex][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[fromSiteIndex][normalCardIndex][1]
    curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[fromSiteIndex][normalCardIndex][2]
    curMapNormalCards[fromSiteIndex][normalCardIndex][1] = "NONE"
    curMapNormalCards[fromSiteIndex][normalCardIndex][2] = false
    end

    break
    end -- end if (curMapSites[fromSiteIndex][1] ~= "NONE")
    end -- end for fromSiteIndex = 6,8
    end -- end if (false == siteFound)

    -- If there are no more replacement sites in the Provinces and Hinterland, stop searching.
    if (false == siteFound) then
    break
    end
    end -- end if (curMapSites[siteIndex][1] == "NONE")
    end -- end for siteIndex = 1,2

    -- Substep 2:  Fill empty Provinces site slots from top to bottom by pushing Provinces sites up, then by moving in Hinterland sites from top to bottom.

    -- Move sites up if possible.
    for siteIndex = 3,4 do
    for fromSiteIndex = (siteIndex + 1),5 do
    if ((curMapSites[siteIndex][1] == "NONE") and
    (curMapSites[fromSiteIndex][1] ~= "NONE")) then
    printToAll("Moved site \"" .. curMapSites[fromSiteIndex][1] .. "\" up.", {0,0.8,0})
    curMapSites[siteIndex][1] = curMapSites[fromSiteIndex][1]
    curMapSites[siteIndex][2] = curMapSites[fromSiteIndex][2]
    curMapSites[fromSiteIndex][1] = "NONE"
    curMapSites[fromSiteIndex][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[fromSiteIndex][normalCardIndex][1]
    curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[fromSiteIndex][normalCardIndex][2]
    curMapNormalCards[fromSiteIndex][normalCardIndex][1] = "NONE"
    curMapNormalCards[fromSiteIndex][normalCardIndex][2] = false
    end

    break
    end -- end if possible to move site up
    end -- end for fromSiteIndex = (siteIndex + 1),5
    end -- end for siteIndex = 3,4

    -- Fill empty Provinces site slots from top to bottom.  Note that intact edifices ARE allowed to move.
    for siteIndex = 3,5 do
    siteFound = false
    if (curMapSites[siteIndex][1] == "NONE") then
    -- Check Hinterland.
    for fromSiteIndex = 6,8 do
    if (curMapSites[fromSiteIndex][1] ~= "NONE") then
    siteFound = true

    printToAll("Moved site \"" .. curMapSites[fromSiteIndex][1] .. "\" to the Provinces.", {0,0.8,0})
    curMapSites[siteIndex][1] = curMapSites[fromSiteIndex][1]
    curMapSites[siteIndex][2] = curMapSites[fromSiteIndex][2]
    curMapSites[fromSiteIndex][1] = "NONE"
    curMapSites[fromSiteIndex][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[fromSiteIndex][normalCardIndex][1]
    curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[fromSiteIndex][normalCardIndex][2]
    curMapNormalCards[fromSiteIndex][normalCardIndex][1] = "NONE"
    curMapNormalCards[fromSiteIndex][normalCardIndex][2] = false
    end

    break
    end -- end if (curMapSites[fromSiteIndex][1] ~= "NONE")
    end -- end for fromSiteIndex = 6,8 do

    -- If there are no more replacement sites in the Hinterland, stop searching.
    if (false == siteFound) then
    break
    end
    end -- end if (curMapSites[siteIndex][1] == "NONE")
    end -- end for siteIndex = 3,5

    -- Substep 3:  Fill empty Hinterland site slots from top to bottom by pushing Hinterland sites up.

    for siteIndex = 6,7 do
    for fromSiteIndex = (siteIndex + 1),8 do
    if ((curMapSites[siteIndex][1] == "NONE") and
    (curMapSites[fromSiteIndex][1] ~= "NONE")) then
    printToAll("Moved site \"" .. curMapSites[fromSiteIndex][1] .. "\" up.", {0,0.8,0})
    curMapSites[siteIndex][1] = curMapSites[fromSiteIndex][1]
    curMapSites[siteIndex][2] = curMapSites[fromSiteIndex][2]
    curMapSites[fromSiteIndex][1] = "NONE"
    curMapSites[fromSiteIndex][2] = false
    for normalCardIndex = 1,3 do
    curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[fromSiteIndex][normalCardIndex][1]
    curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[fromSiteIndex][normalCardIndex][2]
    curMapNormalCards[fromSiteIndex][normalCardIndex][1] = "NONE"
    curMapNormalCards[fromSiteIndex][normalCardIndex][2] = false
    end

    break
    end -- end if possible to move site up
    end -- end for fromSiteIndex = (siteIndex + 1),5
    end -- end for siteIndex = 3,4

    -- Substep 4:  Fill empty Hinterland site slots from bottom to top with the set-aside sites with ruins from bottom to top.
    -- Substep 5:  Fill empty Provinces site slots the same way.
    --
    -- These substeps are performed in the same loop over set-aside sites, always checking for Hinterland space first.
    for setAsideIndex = #setAsideSites,1,-1 do
    siteFound = false

    -- Check Hinterland for space.
    for toSiteIndex = 8,6,-1 do
    if (curMapSites[toSiteIndex][1] == "NONE") then
    siteFound = true

    printToAll("Moved site \"" .. setAsideSites[setAsideIndex][1] .. "\" to the Hinterland due to ruin(s).", {0,0.8,0})
    -- NOTE:  The set-aside structures do not need anything erased since they are not used after these two substeps finish.
    curMapSites[toSiteIndex][1] = setAsideSites[setAsideIndex][1]
    curMapSites[toSiteIndex][2] = setAsideSites[setAsideIndex][2]
    for normalCardIndex = 1,3 do
    curMapNormalCards[toSiteIndex][normalCardIndex][1] = setAsideNormalCards[setAsideIndex][normalCardIndex][1]
    curMapNormalCards[toSiteIndex][normalCardIndex][2] = setAsideNormalCards[setAsideIndex][normalCardIndex][2]
    end

    break
    end -- end if (curMapSites[toSiteIndex][1] == "NONE")
    end -- end for toSiteIndex = 8,6,-1

    -- Check Provinces for space.
    if (false == siteFound) then
    for toSiteIndex = 5,3,-1 do
    if (curMapSites[toSiteIndex][1] == "NONE") then
    siteFound = true

    printToAll("Moved site \"" .. setAsideSites[setAsideIndex][1] .. "\" to the Provinces due to ruin(s).", {0,0.8,0})
    -- NOTE:  The set-aside structures do not need anything erased since they are not used after these two substeps finish.
    curMapSites[toSiteIndex][1] = setAsideSites[setAsideIndex][1]
    curMapSites[toSiteIndex][2] = setAsideSites[setAsideIndex][2]
    for normalCardIndex = 1,3 do
    curMapNormalCards[toSiteIndex][normalCardIndex][1] = setAsideNormalCards[setAsideIndex][normalCardIndex][1]
    curMapNormalCards[toSiteIndex][normalCardIndex][2] = setAsideNormalCards[setAsideIndex][normalCardIndex][2]
    end

    break
    end -- end if (curMapSites[toSiteIndex][1] == "NONE")
    end -- end for toSiteIndex = 5,3,-1
    end -- end if (false == siteFound)

    -- This should be impossible since there are only 6 edifice/ruin cards.
    if (false == siteFound) then
    printToAll("Error, no space found to move set-aside site.", {1,0,0})
    end
    end -- end for setAsideIndex = #setAsideSites,1,-1

    -- Substep 6:  Fill empty site slots with facedown sites from the site deck, shuffling the site deck first per step 8.3.2.

    -- Make a list of unused sites.
    availableSites = {}
    numAvailableSites = 0
    for siteCode = 0, (NUM_TOTAL_SITES - 1) do
    siteName = sitesBySaveID[siteCode]
    siteUsed = false

    for siteIndex = 1,8 do
    if (siteName == curMapSites[siteIndex][1]) then
    siteUsed = true
    break
    end
    end

    if (false == siteUsed) then
    table.insert(availableSites, siteName)
    numAvailableSites = (numAvailableSites + 1)
    end
    end -- end for siteCode = 0, (NUM_TOTAL_SITES - 1)

    -- Deal random available sites to fill vacant slots.
    for siteIndex = 1,8 do
    if ("NONE" == curMapSites[siteIndex][1]) then
    removeSiteIndex = math.random(1, numAvailableSites)
    -- Deal the site facedown.
    curMapSites[siteIndex][1] = availableSites[removeSiteIndex]
    curMapSites[siteIndex][2] = true

    table.remove(availableSites, removeSiteIndex)
    numAvailableSites = (numAvailableSites - 1)
    end -- end if ("NONE" == curMapSites[siteIndex][1])
    end -- end for siteIndex = 1,8

    -- Substep 7:  In each region where no sites are face up, reveal the top site.
    if ((true == curMapSites[1][2]) and
    (true == curMapSites[2][2])) then
    printToAll("Revealed " .. curMapSites[1][1] .. " in Cradle.", {0,0.8,0})
    curMapSites[1][2] = false
    end
    if ((true == curMapSites[3][2]) and
    (true == curMapSites[4][2]) and
    (true == curMapSites[5][2])) then
    printToAll("Revealed " .. curMapSites[3][1] .. " in Provinces.", {0,0.8,0})
    curMapSites[3][2] = false
    end
    if ((true == curMapSites[6][2]) and
    (true == curMapSites[7][2]) and
    (true == curMapSites[8][2])) then
    printToAll("Revealed " .. curMapSites[6][1] .. " in Hinterland.", {0,0.8,0})
    curMapSites[6][2] = false
    end

    --
    -- Step 8.4:  Add six cards to world deck.
    --

    -- Find the most common suit(s) in the winner's advisers, if any.  Note that sites no longer grant the winner adviser(s).

    adviserSuitCounts = { ["Discord"] = 0,
    ["Arcane"]  = 0,
    ["Order"]   = 0,
    ["Hearth"]  = 0,
    ["Beast"]   = 0,
    ["Nomad"]   = 0 }
    adviserSuitOptions = {}

    -- Check regular advisers.
    for adviserIndex = 1,numPlayerAdvisers[winningColor] do
    -- Only consider faceup advisers for suit purposes.  Facedown advisers are not considered to have a suit.
    if (false == playerAdvisersFacedown[winningColor][adviserIndex]) then
    cardSuit = cardsTable[playerAdvisers[winningColor][adviserIndex]].suit
    adviserSuitCounts[cardSuit] = (adviserSuitCounts[cardSuit] + 1)

    -- Count the card "Marriage" twice because of its effect.
    if ("Marriage" == playerAdvisers[winningColor][adviserIndex]) then
    printToAll("Counting \"Marriage\" as 2 advisers for Hearth.", {0,0.8,0})
    adviserSuitCounts[cardSuit] = (adviserSuitCounts[cardSuit] + 1)
    end
    end
    end

    -- Find the suit(s) with the maximum number of advisers.
    maxSuitCount = 0
    for i,curSuit in ipairs(suitNames) do
    if (adviserSuitCounts[curSuit] == maxSuitCount) then
    -- This suit is tied for the maximum count, so add it to the options.
    table.insert(adviserSuitOptions, curSuit)
    elseif (adviserSuitCounts[curSuit] > maxSuitCount) then
    -- This suit sets a new maximum, so replace the options.
    adviserSuitOptions = { curSuit }
    maxSuitCount = adviserSuitCounts[curSuit]
    else
    -- Ignore this suit since it is not even tied for maximum.
    end
    end

    if ((#adviserSuitOptions) > 0) then
    --
    -- Since there is at least one valid option, filter and prompt the winner to choose.
    --

    -- Block all suits before enabling valid option(s).
    for i,curSuit in ipairs(suitNames) do
    Global.UI.setAttribute("ban_suit_" .. curSuit, "active", true)
    Global.UI.setAttribute("select_suit_" .. curSuit, "active", false)
    end

    -- Enable valid options.
    for i,curSuit in ipairs(adviserSuitOptions) do
    Global.UI.setAttribute("ban_suit_" .. curSuit, "active", false)
    Global.UI.setAttribute("select_suit_" .. curSuit, "active", true)
    end
    else -- end if ((#adviserSuitOptions) > 0)
    --
    -- There are no options, so allow the winner to choose any suit.
    --

    -- Enable all suits.
    for i,curSuit in ipairs(suitNames) do
    Global.UI.setAttribute("ban_suit_" .. curSuit, "active", false)
    Global.UI.setAttribute("select_suit_" .. curSuit, "active", true)
    end
    end

    -- Enable the panel.
    selectedSuit = nil
    Global.UI.setAttribute("mark_suit", "active", false)
    Global.UI.setAttribute("panel_select_suit", "active", true)
end

function selectSuit(player, value, id)
    if ((true == player.host) or (player.color == winningColor)) then
        -- Sanity check just in case an invalid button was clicked.
        for i,curSuit in ipairs(adviserSuitOptions) do
            if (curSuit == value) then
                selectedSuit = value
                Global.UI.setAttribute("mark_suit", "active", true)
                Global.UI.setAttribute("mark_suit", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
                break
            end
        end
    else
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function confirmSelectSuit(player, value, id)
    local archivePullSuits = {}
    local chosenPullIndex = 0

    if ((true == player.host) or (player.color == winningColor)) then
        if (nil ~= selectedSuit) then
    -- Determine contents of the archive.
    calculateArchiveContents()

    -- Determine the 3 suits that should have cards added, starting with the selected suit.
    archivePullSuits[1] = selectedSuit
    archivePullSuits[2] = chronicleNextSuits[archivePullSuits[1]]
    archivePullSuits[3] = chronicleNextSuits[archivePullSuits[2]]

    cardsAddedToWorldDeck = {}

    -- Check whether the archive has enough cards to pull from these suits.  Otherwise, heal the archive.
    if (((#(archiveContentsBySuit[archivePullSuits[1]])) >= 3) and
    ((#(archiveContentsBySuit[archivePullSuits[2]])) >= 2) and
    ((#(archiveContentsBySuit[archivePullSuits[3]])) >= 1)) then

    -- Add 3 cards from the first suit.
    for archivePullCount = 1,3 do
    chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[1]]))
    table.insert(remainingWorldDeck, archiveContentsBySuit[archivePullSuits[1]][chosenPullIndex])
    table.insert(cardsAddedToWorldDeck, archiveContentsBySuit[archivePullSuits[1]][chosenPullIndex])
    table.remove(archiveContentsBySuit[archivePullSuits[1]], chosenPullIndex)
    end

    -- Add 2 cards from the next suit.
    for archivePullCount = 1,2 do
    chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[2]]))
    table.insert(remainingWorldDeck, archiveContentsBySuit[archivePullSuits[2]][chosenPullIndex])
    table.insert(cardsAddedToWorldDeck, archiveContentsBySuit[archivePullSuits[2]][chosenPullIndex])
    table.remove(archiveContentsBySuit[archivePullSuits[2]], chosenPullIndex)
    end

    -- Add 1 card from the last suit.
    chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[3]]))
    table.insert(remainingWorldDeck, archiveContentsBySuit[archivePullSuits[3]][chosenPullIndex])
    table.insert(cardsAddedToWorldDeck, archiveContentsBySuit[archivePullSuits[3]][chosenPullIndex])
    table.remove(archiveContentsBySuit[archivePullSuits[3]], chosenPullIndex)

    printToAll("The world has changed.", {1,1,1})
    printToAll("  Added 3 " .. archivePullSuits[1] .. " cards to the world deck.", {1,1,1})
    printToAll("  Added 2 " .. archivePullSuits[2] .. " cards to the world deck.", {1,1,1})
    printToAll("  Added 1 " .. archivePullSuits[3] .. " card to the world deck.", {1,1,1})
    else -- end if the archive has enough cards to pull 3/2/1 of the needed suits.
    mostDispossessedSuit = calculateMostDispossessedSuit()

    -- Confirm that the dispossessed stack for this suit actually has at least 6 cards.
    if (#(dispossessedContentsBySuit[mostDispossessedSuit]) >= 6) then
    -- Take 6 cards of the chosen suit from the dispossessed deck and add them to the world deck.
    for dispossessedPullCount = 1,6 do
    chosenPullIndex = math.random(1, #(dispossessedContentsBySuit[mostDispossessedSuit]))
    table.insert(remainingWorldDeck, dispossessedContentsBySuit[mostDispossessedSuit][chosenPullIndex])
    table.insert(cardsAddedToWorldDeck, dispossessedContentsBySuit[mostDispossessedSuit][chosenPullIndex])
    table.remove(dispossessedContentsBySuit[mostDispossessedSuit], chosenPullIndex)
    end

    -- Clear the dispossessed deck, which effectively shuffles all dispossessed cards into the archive.
    curDispossessedDeckCardCount = 0
    curDispossessedDeckCards = {}

    printToAll("The Dispossessed have returned to the land!", {1,1,1})
    printToAll("  Added 6 " .. mostDispossessedSuit .. " cards to the world deck.", {1,1,1})
    printToAll("  Shuffled all Dispossessed cards back into the Archive.", {1,1,1})
    else -- end if (#(dispossessedContentsBySuit[mostDispossessedSuit]) >= 6)
    -- This should never happen, since there should either be enough cards in the archive or enough cards in the dispossessed for this suit.
    printToAll("Error, insufficient " .. mostDispossessedSuit .. " cards to heal the Archive.", {1,0,0})
    end
    end

    -- Continue with the chronicle phase.
    Global.UI.setAttribute("panel_select_suit", "active", false)
    handleChronicleAfterSelectSuit()
    else -- end if (nil ~= selectedSuit)
    printToAll("Error, no suit selected.", {1,0,0})
        end
    else -- end if ((true == player.host) or (player.color == winningColor))
        printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
end

function calculateArchiveContents()
    local cardName = nil
    local cardInfo = nil
    local cardFound = false
    local mapDenizens = {}

    -- Reset archive contents.
    for i,curSuit in ipairs(suitNames) do
        archiveContentsBySuit[curSuit] = {}
    end

    -- Make a list of current map denizens.
    for siteIndex = 1,8 do
        for normalCardIndex = 1,3 do
            cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            cardInfo = cardsTable[cardName]

            if ((nil ~= cardInfo) and ("Denizen" == cardInfo.cardtype)) then
        table.insert(mapDenizens, cardName)
            end
        end
    end

    -- For every possible card, add it to the archive unless it is in the remaining world deck,
    -- in a discard pile, on the map, in an adviser zone, or in the dispossessed deck.
    for cardSaveID = 0,197 do
        cardName = normalCardsBySaveID[cardSaveID]
        cardFound = false

        for worldDeckIndex = 1,#remainingWorldDeck do
            if (cardName == remainingWorldDeck[worldDeckIndex]) then
                cardFound = true
                break
            end
        end

        if (false == cardFound) then
            for discardZoneIndex = 1,3 do
                discardCount = #(discardContents[discardZoneIndex])

                for cardIndex = 1,discardCount do
                    if (cardName == discardContents[discardZoneIndex][cardIndex]) then
                        cardFound = true
                        break
                    end
                end

                if (true == cardFound) then
                    break
                end
            end
        end

        if (false == cardFound) then
            for mapDenizenIndex = 1,#mapDenizens do
                if (cardName == mapDenizens[mapDenizenIndex]) then
                    cardFound = true
                    break
                end
            end
        end

        if (false == cardFound) then
            for i,curColor in ipairs(playerColors) do
                for cardIndex = 1,numPlayerAdvisers[curColor] do
                    if (cardName == playerAdvisers[curColor][cardIndex]) then
                        cardFound = true
                        break
                    end
                end

                if (true == cardFound) then
                    break
                end
            end
        end

        if (false == cardFound) then
            for dispossessedDeckIndex = 1,curDispossessedDeckCardCount do
                if (cardName == curDispossessedDeckCards[dispossessedDeckIndex]) then
                    cardFound = true
                    break
                end
            end
        end

        if (false == cardFound) then
            table.insert(archiveContentsBySuit[cardsTable[cardName].suit], cardName)
        end
    end -- end for cardSaveID = 0,197
end

function calculateMostDispossessedSuit()
    local returnSuit = nil
    local cardInfo = nil
    local maxSuitCount = 0
    local dispossessedSuitOptions = {}
    local dispossessedSuitCounts = { ["Discord"] = 0,
                                     ["Arcane"]  = 0,
                                     ["Order"]   = 0,
                                     ["Hearth"]  = 0,
                                     ["Beast"]   = 0,
                                     ["Nomad"]   = 0 }

    for i,curSuit in ipairs(suitNames) do
        dispossessedContentsBySuit[curSuit] = {}
    end

    for i,curCard in ipairs(curDispossessedDeckCards) do
        cardInfo = cardsTable[curCard]
        table.insert(dispossessedContentsBySuit[cardInfo.suit], curCard)
        dispossessedSuitCounts[cardInfo.suit] = (dispossessedSuitCounts[cardInfo.suit] + 1)
    end

    -- Start the maximum count at 1 to avoid selecting suits with no cards in the dispossessed deck.
    maxSuitCount = 1

    for i,curSuit in ipairs(suitNames) do
        if (dispossessedSuitCounts[curSuit] == maxSuitCount) then
            -- This suit is tied for the maximum count, so add it to the options.
            table.insert(dispossessedSuitOptions, curSuit)
        elseif (dispossessedSuitCounts[curSuit] > maxSuitCount) then
            -- This suit sets a new maximum, so replace the options.
            dispossessedSuitOptions = { curSuit }
            maxSuitCount = dispossessedSuitCounts[curSuit]
        else
            -- Ignore this suit since it is not even tied for maximum.
        end
    end

    if ((#dispossessedSuitOptions) > 1) then
        -- If there is more than one option, choose one at random.
        returnSuit = dispossessedSuitOptions[math.random(1, (#dispossessedSuitOptions))]
    elseif ((#dispossessedSuitOptions) == 1) then
        -- If there is exactly one option, use that one.
        returnSuit = dispossessedSuitOptions[1]
    else
        -- This should never happen.
        printToAll("Error, no dispossessed cards available.", {1,0,0})
    end

    return returnSuit
end

function handleChronicleAfterSelectSuit()
    local newSuitOrderString = nil
    local discardCount = 0
    local dispossessOptions = {}
    local dispossessIndex = nil
    local worldDeckOptions = {}
    local cardName = nil
    local cardInfo = nil
    local cardFound = false
    local curCardInfo = nil
    local siteName = nil
    local siteInfo = nil
    local siteRelicCount = 0
    local emptySpaceFound = false
    local scriptZoneObjects = nil
    local curObjectName = nil
    local mapRelics = {}
    local saveRelicsBeforeShuffle = {}
    local deckRelicsAvailable = {}
    local deckRelicsBeforeShuffle = {}
    local finalDeckRelics = {}
    local finalDeckRelicCount = 0
    local newDispossessedCards = {}
    local saveRelicsCount = 0
    local chosenPullIndex = 0

    --
    -- Step 8.5:  Remove six cards to the dispossessed deck.
    --

    dispossessOptions = {}

    -- First, process the discard piles of all three regions.
    for discardZoneIndex = 1,3 do
        discardCount = #(discardContents[discardZoneIndex])

        for cardIndex = 1,discardCount do
            cardName = discardContents[discardZoneIndex][cardIndex]
            cardInfo = cardsTable[cardName]

            -- Only process known cards, and only process denizens.
            if (nil ~= cardInfo) then
        if ("Denizen" == cardInfo.cardtype) then
        table.insert(dispossessOptions, cardName)
            end
            end
        end
    end

    -- Next, process the advisers of all losing players.
    for i,curColor in ipairs(playerColors) do
        if (winningColor ~= curColor) then
    for cardIndex = 1,numPlayerAdvisers[curColor] do
    cardName = playerAdvisers[curColor][cardIndex]
    cardInfo = cardsTable[cardName]

    -- Only process known cards, and only process denizens.
    if (nil ~= cardInfo) then
    if ("Denizen" == cardInfo.cardtype) then
    table.insert(dispossessOptions, cardName)
        end
        end
        end
        end
    end

    -- Choose 6 cards from dispossessed options.  The chosen cards will be added to the dispossessed deck.
    for removeCount = 1,6 do
        if ((#dispossessOptions) > 0) then
            dispossessIndex = math.random(1, #dispossessOptions)
            cardName = dispossessOptions[dispossessIndex]

            -- As a sanity check, confirm that the card does not exist on the map.
            for siteIndex = 1,8 do
                for normalCardIndex = 1,3 do
                    if (cardName == curMapNormalCards[siteIndex][normalCardIndex][1]) then
                        -- This should never happen since any discarded denizens should not be in the map structure.
                        printToAll("Error, dispossessed card " .. cardName .. " was tracked as being on the map.  Please report this to AgentElrond!", {1,0,0})
                    end
                end
            end

            -- As a sanity check, confirm that the card does not exist in the remaining world deck.
            for worldDeckIndex = 1,#remainingWorldDeck do
                if (cardName == remainingWorldDeck[worldDeckIndex]) then
                    -- This should never happen since any discarded denizens should not be in the remaining world deck structure.
                    printToAll("Error, dispossessed card " .. cardName .. " was tracked as being in the remaining world deck.  Please report this to AgentElrond!", {1,0,0})
                end
            end

            -- Add the card to the dispossessed deck.
            table.insert(curDispossessedDeckCards, cardName)
            curDispossessedDeckCardCount = (curDispossessedDeckCardCount + 1)

            -- Add the card to the newly dispossessed list.
            table.insert(newDispossessedCards, cardName)

            -- Remove the card from the dispossessed options list.
            table.remove(dispossessOptions, dispossessIndex)
        else -- end if ((#dispossessOptions) > 0)
            -- It should be impossible or nearly impossible for this game state to ever occur, since players will typically play and discard enough denizens.
            printToAll("Not enough cards were available to dispossess.", {1,0,0})
        end
    end -- end for removeCount = 1,6

    --
    -- Step 8.6:  Clean up relics.
    --

    -- First, make a list of all possible relics, indexing by name for convenience.
    deckRelicsAvailable = {}
    for cardSaveID = 218,237 do
        cardName = normalCardsBySaveID[cardSaveID]
        deckRelicsAvailable[cardName] = true
    end
    -- Next, make a list of relics on the map, setting elements in deckRelicsAvailable to false as needed.
    mapRelics = {}
    for siteIndex = 1,8 do
        for normalCardIndex = 1,3 do
            cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            if ((nil ~= cardName) and ("NONE" ~= cardName)) then
        cardInfo = cardsTable[cardName]
        if (nil ~= cardInfo) then
        if ("Relic" == cardInfo.cardtype) then
        table.insert(mapRelics, cardName)
        deckRelicsAvailable[cardName] = false
        end
            end
            end
        end
    end
    -- Finally, make a list of relics in the reliquary.  These include relics already in the reliquary, as well as relics the winner moved to the reliquary.
    -- All of these relics will be saved to go on top of the next game's relic deck.
    saveRelicsBeforeShuffle = {}
    scriptZoneObjects = bigReliquaryZone.getObjects()
    for i,curObject in ipairs(scriptZoneObjects) do
        curObjectName = curObject.getName()
        if ("Deck" == curObject.tag) then
            -- Since a deck was encountered, scan it for Relic cards.
            for i,curCardInDeck in ipairs(curObject.getObjects()) do
                cardName = curCardInDeck.nickname
                cardInfo = cardsTable[cardName]

                if (nil ~= cardInfo) then
            if ("Relic" == cardInfo.cardtype) then
            table.insert(saveRelicsBeforeShuffle, cardName)
                deckRelicsAvailable[cardName] = false
                end
                end
            end
        elseif ("Card" == curObject.tag) then
            cardInfo = cardsTable[curObjectName]
            if (nil ~= cardInfo) then
        if ("Relic" == cardInfo.cardtype) then
        table.insert(saveRelicsBeforeShuffle, curObjectName)
            deckRelicsAvailable[curObjectName] = false
            end
            end
        else
            -- Nothing needs done for other types of object(s).
        end
    end

    -- Step 8.6.1:  Return all relics of the losing players to the relic deck, and shuffle it.

    -- This is accomplished by taking each card name that is still marked as available, creating a list of available names, and randomly choosing the order.
    -- All available relics were either in the relic deck or belonged to losing players.  All other relics were on the world map or in the reliquary.
    -- Relics in the reliquary are there because they were already there, or because the winner moved them there at the start of the chronicle phase.
    deckRelicsBeforeShuffle = {}
    for cardSaveID = 218,237 do
        cardName = normalCardsBySaveID[cardSaveID]
        if (true == deckRelicsAvailable[cardName]) then
            table.insert(deckRelicsBeforeShuffle, cardName)
        end
    end
    finalDeckRelics = {}
    finalDeckRelicCount = #deckRelicsBeforeShuffle
    for finalDeckIndex = 1,finalDeckRelicCount do
        chosenPullIndex = math.random(1, #(deckRelicsBeforeShuffle))
        table.insert(finalDeckRelics, deckRelicsBeforeShuffle[chosenPullIndex])
        table.remove(deckRelicsBeforeShuffle, chosenPullIndex)
    end

    -- Continuing step 8.6.1:  Draw and put facedown relics at faceup sites so they have the number of relics shown on the site cards.
    for siteIndex = 1,8 do
        siteName = curMapSites[siteIndex][1]
        if ((nil ~= siteName) and ("" ~= siteName)) then
    siteInfo = cardsTable[siteName]
    if (nil ~= siteInfo) then
    -- Only process the site if it is faceup.
    if (false == curMapSites[siteIndex][2]) then
    -- Count relics already at the site, making sure they are facedown in the process.
    siteRelicCount = 0
    for normalCardIndex = 1,3 do
    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
    cardInfo = cardsTable[cardName]
    if (nil ~= cardInfo) then
    if ("Relic" == cardInfo.cardtype) then
    siteRelicCount = (siteRelicCount + 1)

    -- Make sure the relic is facedown.
    curMapNormalCards[siteIndex][normalCardIndex][2] = true
    end -- end if ("Relic" == cardInfo.cardtype)
    end -- end if (nil ~= cardInfo)
    end -- for normalCardIndex = 1,3

    -- If more relics are needed to fill the site relic count, deal some facedown from the relic deck.
    while (siteRelicCount < siteInfo.relicCount) do
    emptySpaceFound = false

    -- Note this goes from 3 down to 1 to deal from right to left.
    for normalCardIndex = 3,1,-1 do
    cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
    cardInfo = cardsTable[cardName]

    if (nil ~= cardInfo) then
    if ("NONE" == cardInfo.cardtype) then
    emptySpaceFound = true

    -- This is an empty slot, so deal a relic facedown from the top of the shuffled relic deck.
    if (finalDeckRelicCount > 0) then
    curMapNormalCards[siteIndex][normalCardIndex][1] = finalDeckRelics[finalDeckRelicCount]
    curMapNormalCards[siteIndex][normalCardIndex][2] = true

        table.remove(finalDeckRelics, finalDeckRelicCount)
        finalDeckRelicCount = (finalDeckRelicCount - 1)
    else -- end if (finalDeckRelicCount > 0)
    -- This should never happen.
    printToAll("Error, ran out of relics while dealing.", {1,0,0})
    end

    -- Even if a card was not found, increase the site relic count so the loop finishes.
    siteRelicCount = (siteRelicCount + 1)

    break
        end -- end if ("NONE" == normalCardInfo.cardtype)
        end -- end if (nil ~= normalCardInfo)
        end -- end for normalCardIndex = 3,1,-1

        if (false == emptySpaceFound) then
        printToAll("Error, no empty space found at " .. siteName .. " to deal relic.", {1,0,0})
        break
        end -- end if (false == emptySpaceFound)
        end -- end while (siteRelicCount < siteInfo.relicCount)
        end -- end if (false == curMapSites[siteIndex][2])
        end -- end if (nil ~= siteInfo)
        end -- end if ((nil ~= siteName) and ("" ~= siteName))
    end -- for siteIndex = 1,8

    -- Step 8.6.2:  Shuffle together the relics held by the winner and in the reliquary.  Stack them on top of the relic deck.

    -- These relics are already collected in saveRelicsBeforeShuffle.  Shuffle them and add them to the end of finalDeckRelics.
    saveRelicsCount = #saveRelicsBeforeShuffle
    for saveRelicIndex = 1,saveRelicsCount do
        chosenPullIndex = math.random(1, #(saveRelicsBeforeShuffle))
        table.insert(finalDeckRelics, saveRelicsBeforeShuffle[chosenPullIndex])
        table.remove(saveRelicsBeforeShuffle, chosenPullIndex)
        finalDeckRelicCount = (finalDeckRelicCount + 1)
    end

    -- Suit order is no longer a concept in Oath, so just save the legacy values.
    newSuitOrderString = curSuitOrder[1]
    for suitOrderIndex = 1,6 do
        newSuitOrderString = curSuitOrder[suitOrderIndex]
    end

    --
    -- Step 8.7:  Save map and boards.
    --

    -- This is handled later by generateSaveString().

    --
    -- Step 8.8:  Rebuild world deck.
    --

    -- Reset and regenerate curWorldDeckCards and curWorldDeckCardCount from the following:
    --   * All Vision cards.
    --   * All remaining world deck cards, including the 6 new cards added in step 8.4.
    --   * All discard piles.
    --   * All player adviser zones.
    -- For the last 3 categories above, only denizen cards are to be processed, and newly dispossessed cards are to be skipped.

    -- Reset world deck structure.
    curWorldDeckCardCount = 0
    curWorldDeckCards = {}

    -- Add vision cards to the actual world deck structure so they do not need found elsewhere.
    for cardSaveID = 210,214 do
        table.insert(curWorldDeckCards, normalCardsBySaveID[cardSaveID])
        curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    end

    -- Reset world deck options structure.
    worldDeckOptions = {}

    -- Add remaining world deck cards to the options structure.
    for worldDeckIndex = 1,#remainingWorldDeck do
        table.insert(worldDeckOptions, remainingWorldDeck[worldDeckIndex])
    end

    -- Add discard pile cards to the options structure.
    for discardZoneIndex = 1,3 do
        discardCount = #(discardContents[discardZoneIndex])

        for cardIndex = 1,discardCount do
            cardName = discardContents[discardZoneIndex][cardIndex]
            cardInfo = cardsTable[cardName]

            -- Only process known cards, and only process denizens.
            if (nil ~= cardInfo) then
        if ("Denizen" == cardInfo.cardtype) then
        table.insert(worldDeckOptions, cardName)
            end
            end
        end
    end

    -- Add player adviser cards to the options structure.
    for i,curColor in ipairs(playerColors) do
        for cardIndex = 1,numPlayerAdvisers[curColor] do
            cardName = playerAdvisers[curColor][cardIndex]
            cardInfo = cardsTable[cardName]

            -- Only process known cards, and only process denizens.
            if (nil ~= cardInfo) then
        if ("Denizen" == cardInfo.cardtype) then
        table.insert(worldDeckOptions, cardName)
            end
            end
        end
    end

    -- Use the world deck options structure to update the world deck.  Skip anything but denizen cards, and skip newly dispossessed cards.
    for optionsIndex = 1,#worldDeckOptions do
        cardName = worldDeckOptions[optionsIndex]
        cardInfo = cardsTable[cardName]

        if (nil ~= cardInfo) then
    if ("Denizen" == cardInfo.cardtype) then
    cardFound = false

    for i,curCard in ipairs(newDispossessedCards) do
    if (cardName == curCard) then
    cardFound = true

    break
    end
    end

    if (false == cardFound) then
    table.insert(curWorldDeckCards, cardName)
    curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    end
    end -- end if ("Denizen" == cardInfo.cardtype)
    else
    printToAll("Error, invalid denizen/edifice/ruin/relic card with name \"" .. cardName .. "\".", {1,0,0})
        end
    end

    -- The generateRandomWorldDeck() function ignores Vision cards and generates the world deck for the next game from known available cards.
    generateRandomWorldDeck({}, 0, 0)

    -- Copy the final relic deck directly into the relic deck structure for encoding.
    curRelicDeckCards = {}
    curRelicDeckCardCount = finalDeckRelicCount
    for relicIndex = 1,finalDeckRelicCount do
        curRelicDeckCards[relicIndex] = finalDeckRelics[relicIndex]
    end

    -- Officially update previous game exile/citizen status.
    for i,curColor in ipairs(playerColors) do
        curPreviousPlayerStatus[curColor] = curStartPlayerStatus[curColor]
        curPreviousPlayersActive[curColor] = curPlayerStatus[curColor][2]
        curStartPlayerStatus[curColor] = curPlayerStatus[curColor]
    end

    curPreviousPlayersActive["Clock"] = isClockworkPrinceEnabled

    -- Generate final save string and update the chronicle.  Note that the table is NOT scanned here, since the state is being adjusted.
    chronicleStateString = generateSaveString()
    ingameStateString = ""
    -- Cleanup the table.
    cleanTable()
    loadFromSaveString(chronicleStateString, false)

    -- Hide pieces for all players.
    for i,curColor in ipairs(playerColors) do
        resetSupplyCylinder(curColor)
        hidePieces(curColor)
    end

    -- Hide general pieces.
    hideGeneralPieces()

    -- Announce that everything is finished.
    printToAll("", {1,1,1})
    printToAll("CHRONICLE UPDATE COMPLETE.", {0,0.8,0})
    printToAll("", {1,1,1})

    isChronicleInProgress = false
end