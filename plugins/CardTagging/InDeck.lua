
local ownerType = nil
local deckData = nil -- data shared between all the cards/decks in this zone
local globalData = nil
local prevIsHoveredAndCollapsed = {}

function onLoad(save_string)
  local save_data = {}
  if save_string then
    save_data = JSON.decode(save_string)
  end

  -- deckZone must have either already been set or be in the save data
  if not shared.deckZone then
    shared.deckZone = getObjectFromGUID(save_data.deckZoneGuid)
  end
  
  deckData = Shared(shared.deckZone) -- shared.deckZone was set in Global.lua
  globalData = Shared(Global)

  ownerType = owner.type
  if not deckData.cardCount then
    deckData.cardCount = 0
  end
  
  -- isHovered is assumed false at startup
  if not shared.isHovered then
    shared.isHovered = {}
  end

  if ownerType == 'Deck' or ownerType == 'Card' then
    deckData.cardCount = deckData.cardCount + 1
  end
end

function onSave()
  local save_data = {
    deckZoneGuid = shared.deckZone.guid
  }
  return JSON.encode(save_data)
end

function onDestroy()
  if ownerType == 'Deck' or ownerType == 'Card' then
    deckData.cardCount = deckData.cardCount - 1
  end
end

-- return whether the deck has been collapsed to a single card or deck object
function DeckIsCollapsed()
  -- only do work if there's exactly one card/deck in the zone
  return deckData.cardCount == 1
end

function onObjectHover(player_color, object)
  shared.isHovered[player_color] = (object ~= nil) and (object.guid == owner.guid)
end

-- called every .5 seconds instead of every frame
function Callback.SlowUpdate()
  for player_color, isHovered in pairs(shared.isHovered) do
    local hoveredAndCollapsed = isHovered and DeckIsCollapsed()
    local hoveredThisFrame = not prevIsHoveredAndCollapsed[player_color] and hoveredAndCollapsed
    local unHoveredThisFrame = prevIsHoveredAndCollapsed[player_color] and not hoveredAndCollapsed

    if hoveredThisFrame then
      InvokeMethod('HoveredInDeck', owner, player_color)
    end
    if unHoveredThisFrame then
      InvokeMethod('UnHoveredInDeck', owner, player_color)
    end

    prevIsHoveredAndCollapsed[player_color] = hoveredAndCollapsed
  end
end
