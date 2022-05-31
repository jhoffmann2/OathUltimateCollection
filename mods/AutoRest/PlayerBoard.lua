﻿
local favorStackOffset = Vector(-6.2, 0.1, 1.08)
local secretStackOffset = Vector(-6.2, 0.32, -0.76)

function onLoad()
  
  globalData = Shared(Global)
  local exileBoard = globalData.playerBoards["Purple"]
  InvokeMethod('GetPlayerSupply', exileBoard)

  owner.clearContextMenu()
  owner.addContextMenuItem("Rest", OnRest)
  CreateRestButtons()

  if shared.warbandBag == nil then
    shared.warbandBag = globalData.playerWarbandBags[shared.playerColor]
  end

  if shared.supplyMarker == nil then
    shared.supplyMarker = globalData.playerSupplyMarkers[shared.playerColor]
  end

  if shared.supplyZones == nil then
    ---@type tts__Object[]
    shared.supplyZones = globalData.playerSupplyZones[shared.playerColor]()
  end

  SetupFavorAndSecretZones()
end

function SetupFavorAndSecretZones()
  if shared.favorZone == nil then
    shared.favorZone = spawnObject({
      type = "ScriptingTrigger",
    })
  end
  if shared.secretZone == nil then
    shared.secretZone = spawnObject({
      type = "ScriptingTrigger",
    })
  end

  local rotation = owner.getRotation()
  local scale = Vector(1.8, 5.10, 1.8)
  
  favorStackPosition = favorStackOffset
  Vector.rotateOver(favorStackPosition, 'y', rotation.y)
  favorStackPosition = favorStackPosition + owner.getPosition()
  local favorZonePosition = favorStackPosition
  favorZonePosition.y = 3.61 - owner.getPosition().y
  
  secretStackPosition = secretStackOffset
  Vector.rotateOver(secretStackPosition, 'y', rotation.y)
  secretStackPosition = secretStackPosition + owner.getPosition()
  local secretZonePosition = secretStackPosition
  secretZonePosition.y = 3.61 - owner.getPosition().y

  shared.favorZone.setPosition(favorZonePosition)
  shared.favorZone.setScale(scale)
  shared.favorZone.setRotation(rotation)
  
  shared.secretZone.setPosition(secretZonePosition)
  shared.secretZone.setScale(scale)
  shared.secretZone.setRotation(rotation)
end

function CreateRestButtons()
  owner.clearButtons()
  local params = {
    label = "",
    click_function = "OnRest",
    function_owner = self,
    scale = { 0.5, 1.0, 0.5 },
    width = 300,
    height = 100,
    tooltip = "Click to Automate Rest Phase",
    color = { 0.5, 0.5, 0.5, 0 }
  }

  -- exile side
  params.position = { -1.916, 0.15, 0.6486 }
  params.rotation = { 0.0, 0.0, 0.0 }
  owner.createButton(params)

  -- citizen side
  params.position = { 1.916, 0, 0.6486 }
  params.rotation = { 0.0, 0.0, 180.0 }
  owner.createButton(params)
  
end

-- return the amount of action supply that this player has
function GetPlayerSupply()
  for i, zone in ipairs(shared.supplyZones) do
    for j, object in ipairs(zone.getObjects()) do
      if (object.guid == shared.supplyMarker.guid) then
        return i - 1;
      end
    end
  end
  return 0
end

function Method.GetPlayerSupply()
  return GetPlayerSupply()
end

function OnRest()
  InvokeEvent('OnRest', shared.playerColor)
  ReturnFavor()
  ReturnSecrets()
  ResetSupply()
end

function GetSecretReturnPosition(count)
  local secretHeight = 0.5
  local output = Vector(secretStackPosition)
  for _, object in ipairs(shared.secretZone.getObjects()) do
    if object.hasTag('Secret') then
      output.y = math.max(output.y, object.getPosition().y)
    end
  end
  output.y = output.y + (count * secretHeight)
  return output
end

function GetFavorReturnPosition(suit, count)
  local favorHeight = 0.2
  local zone = globalData.suitFavorZones[suit]
  local output = Vector(zone.getPosition())
  output.y = favorStackPosition.y
  for _, object in ipairs(zone.getObjects()) do
    if object.hasTag('Favor') then
      output.y = math.max(output.y, object.getPosition().y)
    end
  end
  output.y = output.y + (count * favorHeight)
  return output
end

-- TODO
function ReturnFavor()
  local foundFavorCounts = { 
    ["Discord"] = 0,
    ["Arcane"] = 0,
    ["Order"] = 0,
    ["Hearth"] = 0,
    ["Beast"] = 0,
    ["Nomad"] = 0 
  }
  
  for _, denizenZones in ipairs(globalData.mapNormalCardZones) do
    ---@param zone tts__Object
    for _, zone in ipairs(denizenZones) do
      local favorOnCard = {}
      local cardSuit = nil
      ---@param object tts__Object
      for i, object in ipairs(zone.getObjects()) do
        if object.hasTag('Favor') then
          table.insert(favorOnCard, object)
        end
        if ("Card" == object.type) then
          local cardName = object.getName()
          local cardInfo = globalData.cardsTable[cardName]
          if (cardInfo and cardInfo.suit) then
            cardSuit = cardInfo.suit
          end
        end
      end

      if cardSuit and #favorOnCard > 0 then
        for i, favor in ipairs(favorOnCard) do
          foundFavorCounts[cardSuit] = foundFavorCounts[cardSuit] + 1
          favor.setPositionSmooth(GetFavorReturnPosition(cardSuit, foundFavorCounts[cardSuit]))
          favor.setRotationSmooth(owner.getRotation())
        end
      end
      
    end
  end
  
  for _, zone in ipairs(globalData.playerAdviserZones[shared.playerColor]) do
    local favorOnCard = {}
    local cardSuit = nil
    
    ---@param object tts__Object
    for i, object in ipairs(zone.getObjects()) do
      if object.hasTag('Favor') then
        table.insert(favorOnCard, object)
      end
      if ("Card" == object.type) then
        local cardName = object.getName()
        local cardInfo = globalData.cardsTable[cardName]
        if (cardInfo and cardInfo.suit) then
          cardSuit = cardInfo.suit
        end
      end
    end

    if cardSuit and #favorOnCard > 0 then
      for i, favor in ipairs(favorOnCard) do
        foundFavorCounts[cardSuit] = foundFavorCounts[cardSuit] + 1
        favor.setPositionSmooth(GetFavorReturnPosition(cardSuit, foundFavorCounts[cardSuit]))
        favor.setRotationSmooth(owner.getRotation())
      end
    end
  end
  
end

function ReturnSecrets()
  local foundSecretCount = 0
  for _, denizenZones in ipairs(globalData.mapNormalCardZones) do
    ---@param zone tts__Object
    for _, zone in ipairs(denizenZones) do
      ---@param object tts__Object
      for i, object in ipairs(zone.getObjects()) do
        if object.hasTag('Secret') then
          foundSecretCount = foundSecretCount + 1
          object.setPositionSmooth(GetSecretReturnPosition(foundSecretCount))
          object.setRotationSmooth(owner.getRotation())
        end
      end
    end
  end

  for _, zone in ipairs(globalData.playerAdviserZones[shared.playerColor]) do
    ---@param object tts__Object
    for i, object in ipairs(zone.getObjects()) do
      if object.hasTag('Secret') then
        foundSecretCount = foundSecretCount + 1
        object.setPositionSmooth(GetSecretReturnPosition(foundSecretCount))
        object.setRotationSmooth(owner.getRotation())
      end
    end
  end
end

function ResetSupply()
  local curPlayerStatus = globalData.curPlayerStatus[shared.playerColor]
  local playerFaction = curPlayerStatus[1] -- Chancellor, Exile, or Citizen
  self.call("Reset" .. playerFaction .. "Supply")
end

function ResetExileSupply()
  local remainingSupply = GetPlayerSupply()
  local warbandCount = #shared.warbandBag.getObjects()

  -- 9+ warbands
  if (warbandCount >= 9) then
    SetSupply(remainingSupply + 6)
    return
  end

  -- 4-8 warbands
  if (warbandCount >= 4) then
    SetSupply(remainingSupply + 5)
    return
  end

  -- 0-3 warbands
  SetSupply(remainingSupply + 4)
end

function ResetChancellorSupply()
  local remainingSupply = GetPlayerSupply()
  local warbandCount = #shared.warbandBag.getObjects()

  -- 18+ warbands
  if (warbandCount >= 18) then
    SetSupply(remainingSupply + 6)
    return
  end

  -- 11-17 warbands
  if (warbandCount >= 11) then
    SetSupply(remainingSupply + 5)
    return
  end

  -- 4-10 warbands
  if (warbandCount >= 4) then
    SetSupply(remainingSupply + 4)
    return
  end

  -- 0-3 warbands
  SetSupply(remainingSupply + 3)
end

function ResetCitizenSupply()
  local remainingSupply = GetPlayerSupply()
  local exileBoard = globalData.playerBoards["Purple"]
  local chancellorSupply = InvokeMethod('GetPlayerSupply', exileBoard)
  SetSupply(chancellorSupply + remainingSupply)
end

function SetSupply(supply)
  supply = math.min(supply, 7)
  shared.supplyMarker.setPositionSmooth(shared.supplyZones[supply + 1].getPosition())
end
