local loadingFinished = false

warbandAssetInfo = {
    White = {
        bagColorTint = { 1, 1, 1, 1 },
        totalWarbandSupply = 14,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_white_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0.84375, 0.84375, 0.84375, 1 }
    },
    Blue = {
        bagColorTint = { 0, 0.68235, 1, 1 },
        totalWarbandSupply = 14,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_blue_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0, 0.686274, 1, 1 }
    },
    Purple = {
        bagColorTint = { 0.803921, 0.254877, 1, 1 },
        totalWarbandSupply = 24,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_purple_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0.8, 0.8, 0.8, 1 }
    },
    Brown = {
        bagColorTint = { 0.625435, 0.625435, 0.625435, 1 },
        totalWarbandSupply = 14,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_black_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0.8, 0.8, 0.8, 1 }
    },
    Yellow = {
        bagColorTint = { 1, 0.903346, 0, 1 },
        totalWarbandSupply = 14,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_yellow_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0.941176, 0.803921, 0.117628, 1 }
    },
    Red = {
        bagColorTint = { 1, 0.078376, 0.078376, 1 },
        totalWarbandSupply = 14,
        warbandAsset = {
            assetbundle = "http://tts.ledergames.com/Oath/models/3_2_0/oath_warband_red_2.unity3d",
            assetbundle_secondary = "",
            material = 1,
            type = 1
        },
        warbandColorTint = { 0.865853, 0.387654, 0.387654, 1 }
    } }

function onLoad()
    Wait.frames(onInit, 1)
end

function onInit()
    globalData = Shared(Global)
    playerWarbandBags = globalData.playerWarbandBags
    curPlayerStatus = globalData.curPlayerStatus

    -- Todo
    --playerOwnershipZones = globalData.playerOwnershipZones
    loadingFinished = true
end

function Callback.OnPlayerCitizened(color)
    if (color == shared.color) then
        onSwapToCitizen()
    end
end

function Callback.OnPlayerExiled(color)
    if (color == shared.color) then
        onSwapToExile()
    end
end

function onSwapToCitizen()
    shared.warbandColor = "Purple"
    resetWarbandBag()

    -- list of all warbands that need to be changed into emperial warbands
    local WarbandsToGiveCitizenship = getObjectsWithTag(shared.color .. "Warband")
    if (warbandSupplyCount("Purple") >= #WarbandsToGiveCitizenship) then
        for i, warband in ipairs(WarbandsToGiveCitizenship) do
            warband = setWarbandColor(warband, "Purple")
        end
    else
        -- there's not enough warbands in the supply. have players replace 
        -- them manually so they can pick where they want them
        printToAll("Not Enough Warbands in Empirial Supply. Replace " ..
                "[00FF00]Green[-] Warbands Manually", { 1, 1, 1 })

        -- make left over warbands lime green so it's obvious what to replace
        for i, warband in ipairs(WarbandsToGiveCitizenship) do
            warband.setCustomObject(shared.warbandAsset)
            warband.setTags({})
            warband.setColorTint({ 0, 1, 0 })
            warband.reload()
        end
    end

end

function onSwapToExile()
    shared.warbandColor = shared.color
    resetWarbandBag()

    -- TODO: ADD OWNERSHIP ZONES BACK IN
    -- turn all imperial warbands in players space into exile warbands
    -- local playerIndex = Global.getTable("playerIndex")
    -- for i, object in pairs(playerOwnershipZones[playerIndex[color]].getObjects()) do
    --     if (object.getName() == "Warband" and object.getDescription() == "Purple") then
    --         if (warbandSupplyCount(warbandColor) > 0) then
    --             object = setWarbandColor(object, color)
    --         else
    --             -- not enough warbands in exile supply. just get rid of excess
    --             destroyObject(object)
    --         end
    --     end
    -- end
end

function resetWarbandBag()
    -- empty the warband bag (it will get filled in update)
    for i, objectInfo in pairs(owner.getObjects()) do
        local warband = owner.takeObject({ guid = objectInfo.guid, position = { 0, -1, 0 } })
        destroyObject(warband)
    end
    -- make sure bag is colored properly
    owner.setColorTint(warbandAssetInfo[shared.warbandColor].bagColorTint)
end

function onShow()
    resetWarbandBag()
end

function onUpdate()

    -- only update if we've finished initalizing all our state
    if not loadingFinished then
        return
    end

    local curPlayerStatus = globalData.curPlayerStatus[shared.color]
    shared.playerFaction = curPlayerStatus[1] -- Chancellor, Exile, or Citizen
    shared.isPlayerActive = curPlayerStatus[2]

    shared.warbandColor = shared.color
    if (shared.playerFaction == "Citizen") then
        shared.warbandColor = "Purple"
    end
    -- only update during an active game
    if not globalData.isGameInProgress then
        return
    end

    -- only update if this color is even active in the game
    if not shared.isPlayerActive then
        return
    end

    -- ensureTopWarbandIsCorrectColor()

    local desiredSupplyCount = warbandSupplyCount(shared.warbandColor)

    -- remove extra supply
    while (#owner.getObjects() > desiredSupplyCount) do
        destroyObject(owner.takeObject({ top = true, position = { 0, -1, 0 } }))
    end

    -- add missing supply
    while (#owner.getObjects() < desiredSupplyCount) do
        spawnWarbandInBag(shared.warbandColor)
    end

end

-- return the amount of warbands in this color's supply
-- note: this doesn't look in the bag. it instead subtracts from the number of warbands
-- in the world.
function warbandSupplyCount(warbandColor)
    -- grab all warbands of this color (that aren't in a bag)
    local activeWarbands = getObjectsWithTag(warbandColor .. "Warband")
    local activeWarbandCount = 0
    for i, warband in ipairs(activeWarbands) do
        if (not warband.isDestroyed()) then
            activeWarbandCount = activeWarbandCount + 1
        end
    end

    local colorData = warbandAssetInfo[shared.warbandColor]
    return math.max(0, colorData.totalWarbandSupply - activeWarbandCount)
end

-- if the top warband in the bag isn't the right color, change the color
function ensureTopWarbandIsCorrectColor()
    local warbands = owner.getObjects()
    if (#warbands > 0) then
        if (not colorsMatch(warbands[#warbands].description, warbandColor)) then
            local topWarband = owner.takeObject({ top = true, position = { 0, -1, 0 } })
            setWarbandColor(topWarband, shared.warbandColor)
            owner.putObject(topWarband)
        end
    end
end

function spawnWarbandInBag(color)
    local position = owner.getPosition()
    position.y = position.y - 10 -- move down so it doesn't get in the way
    local warband = spawnObject({
        type = "Custom_Assetbundle",
        scale = warbandScale,
        sound = false,
        position = position
    })
    warband.setName("Warband")
    warband.use_snap_points = false
    owner.putObject(setWarbandColor(warband, color))
    destroyObject(warband)
end

function setWarbandColor(warband, newColor)
    local colorData = warbandAssetInfo[shared.warbandColor]
    warband.setCustomObject(colorData.warbandAsset)
    warband.setDescription(newColor)
    warband.setTags({ newColor .. "Warband" })
    warband.setColorTint(colorData.warbandColorTint)
    return warband.reload()
end

-- checks whether the colors match (example: Brown and Black are equivilent)
function colorsMatch(color1, color2)
    local matchTable = {
        ["Purple"] = 1,
        ["Imperial"] = 1,
        ["Chancellor"] = 1,

        ["Brown"] = 2,
        ["Black"] = 2,

        ["Yellow"] = 3,

        ["White"] = 4,

        ["Blue"] = 5,

        ["Red"] = 6
    }

    return matchTable[color1] == matchTable[color2]
end

