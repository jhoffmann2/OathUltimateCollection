local globalData
local visionCounterGUID = "a7e6d2"
local visionCounter
local visionCounterPositions = {
  {-17.45, 1.20, -2.09},
  {-15.76, 1.20, -2.09},
  {-14.73, 1.20, -2.09},
  {-13.20, 1.20, -2.09},
  {-12.16, 1.20, -2.09},
  {-11.13, 1.20, -2.09}
}
local seenVisions = {}

function onLoad(save_string)
  local save_data = {}
  if save_string and save_string ~= '' then
    save_data = JSON.decode(save_string)
  end
  
  globalData = Shared(Global)
  visionCounter = getObjectFromGUID(visionCounterGUID)
  visionCounter.setLock(true)
  
  if save_data.seenVisions then
    seenVisions = save_data.seenVisions
  end
end

function onSave()
  local save_data = {}
  save_data.seenVisions = seenVisions;
  return JSON.encode(save_data)
end

function Callback.OnGameStart()
  seenVisions = {}
end

---@return tts__Object
function GetDeck()
  function IsFaceDown(object)
    local flip = object.getRotation().z
    return 175 < flip and 185 > flip
  end

  function compareYPos(object1, object2)
    return object1.getPosition().y <  object2.getPosition().y
  end

  local allObjects = owner.getObjects(true)
  local deckObjects = {}
  for _, object in ipairs(allObjects) do
    if IsFaceDown(object) then
      if object.type == 'Deck' then
        table.insert(deckObjects, object)
      elseif object.type == 'Card' then
        -- ignore moving cards (they're likely being drawn)
        if object.getVelocity():magnitude() == 0 and object.getAngularVelocity():magnitude() == 0 then
          table.insert(deckObjects, object)
        end
      end
    end
  end
  if #deckObjects > 1 then
    table.sort(deckObjects, compareYPos)
    deckObjects = group(deckObjects)
  end
  if #deckObjects > 1 then
    printToAll("Error, deck failed to merge", {1,0,0})
  end
  return deckObjects[1]
end

function Method.OnNumberTyped_Zone(object, player_color, number)
  local deck = GetDeck()
  if not deck then
    return false
  end
  
  for i = 1, number do
    local card = deck.takeObject({top = true})
    card.deal(1, player_color)
    if globalData.cardsTable[card.getName()].cardtype == "Vision" then
      InvokeEvent("OnVisionDrawn", player_color, card)
      break
    end
  end
  
  return true
end

function Callback.OnVisionDrawn(player_color, vision)
  seenVisions[vision.getName()] = true
  local visionCount = 0
  for seenVision, _ in pairs(seenVisions) do
    visionCount = visionCount + 1
  end
  visionCounter.setPositionSmooth(visionCounterPositions[visionCount + 1])
end