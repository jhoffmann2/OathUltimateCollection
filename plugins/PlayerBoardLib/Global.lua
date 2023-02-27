

local playerSupplyZoneGuids = {
  ["Purple"] = { "fb63e7", "68402c", "cec926", "97c70b", "141532", "0ff24c", "bd8025", "912653" },
  ["Red"]    = { "69401c", "071b32", "c2cb5f", "084798", "eb860c", "172b1c", "9b07e5", "be9726" },
  ["Brown"]  = { "4bdee6", "7779df", "608a76", "0b6e65", "00596d", "a02f57", "9028e4", "5d05ce" },
  ["Blue"]   = { "385cd5", "d9cd4d", "3f2e51", "adb919", "b6107e", "97ed50", "4ed3e5", "f31c0c" },
  ["Yellow"] = { "8881ac", "497680", "5f127f", "86eabe", "a55481", "6032c6", "a6a2c2", "d7389b" },
  ["White"]  = { "e82a9f", "c6b2af", "c123f2", "cdbeda", "ca1638", "695075", "ce7fc9", "b9bea2" },
}

function onLoad()
  ---@param playerBoard tts__Object
  ---@param color tts__PlayerColor
  for playerColor, playerBoard in pairs(shared.playerBoards) do
    -- make sure every warbandBag is given the proper tag
    if (not playerBoard.hasTag('PlayerBoard') or not playerBoard.hasTag(playerColor)) then
      playerBoard.addTag(playerColor)
      playerBoard.addTag('PlayerBoard')
    end
    Shared(playerBoard).playerColor = playerColor
  end
  
  shared.playerSupplyZones = {}
  for color, supplyZoneGuids in pairs(playerSupplyZoneGuids) do
    shared.playerSupplyZones[color] = {}
    for _, supplyZoneGuid in ipairs(supplyZoneGuids) do
      table.insert(shared.playerSupplyZones[color], getObjectFromGUID(supplyZoneGuid))
    end
  end

  -- the zones for finding the denizens are really small by default but this will increase
  -- their size so they can also be used to find favor and secrets
  local cardScale = shared.mapSiteCardZones[1].getScale()
  cardScale.x = 2.8
  local cardPadding = 0.25

  for i, denizenZones in ipairs(shared.mapNormalCardZones) do
    ---@param zone tts__Object
    for j, zone in ipairs(denizenZones) do
      zone.setScale(cardScale)
      local position = shared.mapSiteCardZones[i].getPosition()
      position.x = position.x + (shared.mapSiteCardZones[i].getScale().x / 2)
      position.x = position.x + (cardScale.x / 2) + cardPadding
      position.x = position.x + ((j - 1) * (cardScale.x + cardPadding))
      zone.setPosition(position)
    end
  end

  for playerColor, denizenZones in pairs(shared.playerAdviserZones) do
    ---@param zone tts__Object
    for j, zone in ipairs(denizenZones) do
      zone.setScale(cardScale)
      local position = shared.playerBoards[playerColor].getPosition()
      position.y = cardScale.y / 2
      local offset = Vector(-7.6, 0, 0)
      offset.x = offset.x - ((cardScale.x / 2) + cardPadding)
      offset.x = offset.x - ((j - 1) * (cardScale.x + cardPadding))
      Vector.rotateOver(offset, 'y', shared.playerBoards[playerColor].getRotation().y)
      zone.setPosition(position + offset)
    end
  end
  
end