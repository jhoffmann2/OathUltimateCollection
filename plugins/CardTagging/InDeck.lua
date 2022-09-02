
local ownerType = nil
local deckData = nil -- data shared between all the cards/decks in this zone
local globalData = nil
local prevIsHoveredAndCollapsed = {}

function onLoad()
  deckData = Shared(shared.deckZone) -- shared.deckZone was set in Global.lua
  globalData = Shared(Global)

  ownerType = owner.type
  if not deckData.cardCount then
    deckData.cardCount = 0
  end
  if not shared.isHovered then
    shared.isHovered = {}
  end

  if ownerType == 'Deck' or ownerType == 'Card' then
    deckData.cardCount = deckData.cardCount + 1
    print(deckData.cardCount)
  end
end

function onDestroy()
  if ownerType == 'Deck' or ownerType == 'Card' then
    deckData.cardCount = deckData.cardCount - 1
    print(deckData.cardCount)
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

function update()
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
