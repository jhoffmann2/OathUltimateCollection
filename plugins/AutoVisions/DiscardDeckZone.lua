
---@return tts__Object
function GetDeck()
  local allObjects = owner.getObjects(true)
  local deckObjects = {}
  for _, object in ipairs(allObjects) do
    if object.type == 'Deck' then
      table.insert(deckObjects, object)
    elseif object.type == 'Card' then
      -- ignore moving cards (they're likely being drawn)
      if object.getVelocity():magnitude() == 0 and object.getAngularVelocity():magnitude() == 0 then
        table.insert(deckObjects, object)
      end
    end
  end
  if #deckObjects > 1 then
    deckObjects = group(deckObjects)
  end
  if #deckObjects > 1 then
    printToAll("Error, deck failed to merge", {1,0,0})
  end
  return deckObjects[1]
end

local globalData

function onLoad()
  globalData = Shared(Global)
end

---@param object tts__Object
function Method.OnHover_Zone(object, player_color)
  ---@type tts__Object
  local deck = GetDeck()
  if not deck then
    return
  elseif (deck.type == 'Card') then
    return
  else
    local tooltip = ""
    for i, curCardInDeck in ipairs(deck.getObjects()) do
      cardName = curCardInDeck.nickname
      cardInfo = globalData.cardsTable[cardName]
      if cardInfo and ("Vision" == cardInfo.cardtype) then
        tooltip = tooltip.."\n- Vision in "..tostring(i).." card"
        if i > 1 then
          tooltip = tooltip..'s'
        end
      end
    end
    deck.setName(tooltip)
  end
end
