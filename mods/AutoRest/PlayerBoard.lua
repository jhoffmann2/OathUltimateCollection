
local favorStackOffset = Vector(-6.2, 0.1, 1.08)
local secretStackOffset = Vector(-6.2, 0.2, -0.76)


function Callback.OnPlayerPiecesShown(color)
  if (color == shared.playerColor) then
    OnShown()
  end
end

function onLoad()
  globalData = Shared(Global)

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

  owner.clearContextMenu()
  owner.addContextMenuItem("Rest", OnRest)
  CreateRestButtons()
end

function OnShown()
  SetupFavorAndSecretZones()
end

function FavorStackPosition()
  local rotation = GetXYRotation()
  local favorStackPosition = Vector.new(favorStackOffset)
  Vector.rotateOver(favorStackPosition, 'y', rotation.y)
  favorStackPosition = favorStackPosition + owner.getPosition()
  return favorStackPosition
end

function SecretStackPosition()
  local rotation = GetXYRotation()
  local secretStackPosition = Vector.new(secretStackOffset)
  Vector.rotateOver(secretStackPosition, 'y', rotation.y)
  secretStackPosition = secretStackPosition + owner.getPosition()
  return secretStackPosition
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

  local rotation = GetXYRotation()
  local scale = Vector(1.8, 5.10, 1.8)
  local favorZonePosition = FavorStackPosition()
  favorZonePosition.y = favorZonePosition.y + (scale.y / 2)
  
  local secretZonePosition = SecretStackPosition()
  secretZonePosition.y = secretZonePosition.y + (scale.y / 2)

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

function onPlayerTurn(player, previous_player)
  if (previous_player) then
    if (previous_player.color == shared.playerColor) then
      OnRest()
    end
  end
end

function OnRest()
  if Turns.enable and Turns.turn_color == shared.playerColor then
    Turns.turn_color = Turns.getNextTurnColor()
    return
  end
  InvokeEvent('OnRest', shared.playerColor)
  ReturnFavor()
  ReturnSecrets()
  ResetSupply()
end

function GetSecretReturnPosition(count)
  local secretHeight = 0.5
  local output = Vector(SecretStackPosition())
  for _, object in ipairs(shared.secretZone.getObjects()) do
    output.y = math.max(output.y, object.getPosition().y + object.getScale().y / 2)
  end
  output.y = output.y + (count * secretHeight)
  return output
end

function GetFavorReturnPosition(suit, count)
  local favorHeight = 0.2
  local zone = globalData.suitFavorZones[suit]
  local output = Vector(zone.getPosition())
  output.y = FavorStackPosition().y
  for _, object in ipairs(zone.getObjects()) do
    output.y = math.max(output.y, object.getPosition().y + object.getScale().y / 2)
  end
  output.y = output.y + (count * favorHeight)
  return output
end

function GetXYRotation()
  local output = owner.getRotation()
  output.z = 0
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
          favor.setRotationSmooth(GetXYRotation())
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
        favor.setRotationSmooth(GetXYRotation())
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
          object.setRotationSmooth(GetXYRotation())
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
        object.setRotationSmooth(GetXYRotation())
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

