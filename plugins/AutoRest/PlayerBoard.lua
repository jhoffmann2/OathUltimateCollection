
-- defined in PlayerBoardLib/PlayerBoard.lua
ExternMethod("GetPlayerSupply")
ExternMethod("GetSecretReturnPosition")
ExternMethod("GetFavorReturnPosition")
ExternMethod("GetXYRotation")

function onLoad()
  globalData = Shared(Global)
  owner.clearContextMenu()
  owner.addContextMenuItem("Rest", OnRest)
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
      for i, object in ipairs(zone.getObjects(true)) do
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
    for i, object in ipairs(zone.getObjects(true)) do
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
      for i, object in ipairs(zone.getObjects(true)) do
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
    for i, object in ipairs(zone.getObjects(true)) do
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

