local globalData

function onLoad()
  globalData = Shared(Global)
end

---@param object tts__Object
function onObjectDrop(player_color, object)
  if ("Card" == object.type) then
    object.setHiddenFrom({})
    CheckRestrictions(object, player_color)
  end
end

function onObjectRotate(object, spin, flip, player_color, old_spin, old_flip)
  if ("Card" == object.type and not object.held_by_color) then
    CheckRestrictions(object, player_color, flip)
  end
end

---@param card tts__Card
function CheckRestrictions(card, player_color, flip)
  if ("Card" == card.type) then
    local cardName = card.getName()
    local cardInfo = globalData.cardsTable[cardName]
    if not cardInfo then
      return
    end

    if (not CardIsFacedown(card, flip)) then
      if (cardInfo.playerOnly) then
        if (CardIsAtSite(card)) then
          HideCardFromOtherPlayers(card, player_color)
          card.deal(1, player_color);
          broadcastToColor("You cannot play an advisor only card to a site!", player_color, {r=1, g=0, b=0})
          return
        end
      elseif (cardInfo.siteOnly) then
        if (CardIsInPlayerAdvisers(card)) then
            FlipCardFacedown(card)
            broadcastToColor("You cannot play a site only card as an advisor!", player_color, {r=1, g=0, b=0})
            return
          end
      end
    end
    
    if (cardInfo.locked) then
      -- the object needs time to fall to the table before locking it
      Wait.time(function()
        if (not CardIsFacedown(card, flip)) then
          card.setLock(true)
        end
      end, 1)
    end
  end
end

---@param zone tts__Object
---@param card tts__Object
function onObjectLeaveZone(zone, card)
  if ("Card" == card.type and card.held_by_color) then
    if zone.type == 'Hand' then
      HideCardFromOtherPlayers(card, card.held_by_color)
    end
  end
end

function HideCardFromOtherPlayers(card, player_color)
  local other_players = {}
  for _, playerColor in ipairs(shared.playerColors) do
    if playerColor ~= player_color then
      table.insert(other_players, playerColor)
    end
  end
  card.setHiddenFrom(other_players)
end

function CardIsFacedown(card, flip)
  if not flip then
    flip = card.getRotation().z
  end
  return 175 < flip and 185 > flip
end

function FlipCardFacedown(card)
  local rotation = card.getRotation();
  rotation.z = 180
  card.setRotation(rotation)
end

function CardIsInPlayerAdvisers(card)
  for _, curColor in ipairs(shared.playerColors) do
    for adviserSlotIndex = 1, 3 do
      local scriptZoneObjects = shared.playerAdviserZones[curColor][adviserSlotIndex].getObjects(true)
      for _, curObject in ipairs(scriptZoneObjects) do
        if curObject.guid == card.guid then
          return true
        end
      end
    end
  end
  return false
end

function CardIsAtSite(card)
  for siteIndex = 1, 8 do
    for denizenSlotIndex = 1, 3 do
      local scriptZoneObjects = globalData.mapNormalCardZones[siteIndex][denizenSlotIndex].getObjects(true)
      for _, curObject in ipairs(scriptZoneObjects) do
        if curObject.guid == card.guid then
          return true
        end
      end
    end
  end
  return false
end
