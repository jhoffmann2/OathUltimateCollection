
local uiCardWidth = 213.75
local uiCardHeight = 337.5

function onLoad()
  globalData = Shared(Global)
end

function onDestroy()
  WhenGlobalUIMutable(DisableTavernSongsUI)
end

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

function Method.OnNumberTyped_Zone(object, player_color, number)
  shared.cardsBeingDrawn = true
  Wait.time(
    function()
      shared.cardsBeingDrawn = false
    end,
    0.5
  )
  return false
end

function onPlayerTurn(newPlayer, previousPlayer)
  if newPlayer ~= previousPlayer and previousPlayer then
    WhenGlobalUIMutable(DisableTavernSongsUI, previousPlayer.color)
  end
end

function WhenGlobalUIMutable(func, ...)
  local args = table.pack(...)
  
  Wait.condition(
      function()
        func(table.unpack(args))
      end,
      function()
        return Global.UI.loading == false
      end
  )
end

function Method.OnHover_Zone(object, player_color)
  -- you can only peak at cards on your turn
  if Turns.turn_color ~= player_color then
    return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
  end
  
  if shared.cardsBeingDrawn then
    return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
  end

  if not PlayerHandIsEmpty(player_color) then
    return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
  end
  
  local card_power
  if (owner.hasTag('DiscardDeckZone')) then
    if shared.regionNumber ~= GetRegionOfPlayerPawn(player_color) then
      return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
    end
    if not PlayerCanUseCard(player_color, 'Tavern Songs') then
      return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
    end
    card_power = 'TAVERN SONGS'
  end
  if (owner.hasTag('WorldDeckZone')) then
    if not PlayerCanUseRelic(player_color, 'Oracular Pig') then
      return WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
    end
    card_power = 'ORACULAR PIG'
  end
  WhenGlobalUIMutable(EnableTavernSongsUI, player_color, card_power)
end

function Method.OnUnHover_Zone(object, player_color)
  WhenGlobalUIMutable(DisableTavernSongsUI, player_color)
end

-- return true if either 
-- A. card is in player's advisers
-- B. card is at player's site
-- C. card is at a site that the player rules
-- D. card is at an imperial site and the player has Grand Mask
function PlayerCanUseCard(player_color, cardName)
  if CardIsInPlayerAdvisers(player_color, cardName) then
    return true
  end
  
  if CardIsAtSite(GetSiteOfPlayerPawn(player_color), cardName) then
    return true
  end

  for _, siteIndex in ipairs(GetSitesRuledByPlayer(player_color)) do
    if CardIsAtSite(siteIndex, cardName) then
      return true
    end
  end

  if PlayerCanUseRelic(player_color, 'Grand Mask') then
    for _, siteIndex in ipairs(GetSitesRuledByPlayer('Purple')) do
      if CardIsAtSite(siteIndex, cardName) then
        return true
      end
    end
  end
  return false
end

function PlayerHandIsEmpty(player_color)
  return #Player[player_color].getHandObjects() == 0 and #Player[player_color].getHoldingObjects() == 0
end

function CardIsInPlayerAdvisers(player_color, cardName)
  InvokeMethod('ScanPlayerAdvisers', Global)
  for i, adviser in ipairs(globalData.playerAdvisers[player_color]) do
    if not globalData.playerAdvisersFacedown[player_color][i] and adviser == cardName then
      return true
    end
  end
  return false
end

function CardIsAtSite(siteIndex, cardName)
  for normalCardIndex = 1, 3 do
    scriptZoneObjects = globalData.mapNormalCardZones[siteIndex][normalCardIndex].getObjects(true)
    for i, curObject in ipairs(scriptZoneObjects) do
      if ("Card" == curObject.type) then
        if cardName == curObject.getName() then
          return true
        end
      end
    end
  end
  return false
end

function GetRegionOfPlayerPawn(player_color)
  local region = {
    1,1,   -- cradle
    2,2,2, -- provinces
    3,3,3  -- hinterland
  }

  local pawnSite = GetSiteOfPlayerPawn(player_color)
  if pawnSite then
    return region[pawnSite]
  end
  
  return nil
end

function GetSiteOfPlayerPawn(player_color)
  for siteIndex = 1, 8 do
    local scriptZoneObjects = globalData.mapSiteCardZones[siteIndex].getObjects(true)
    for i, curObject in ipairs(scriptZoneObjects) do
      local curObjectName = curObject.getName()
      local convertedObjectColor = curObject.getDescription()
      
      if ("Black" == convertedObjectColor) then
        convertedObjectColor = "Brown"
      end

      if ("Figurine" == curObject.type) then
        if ("Pawn" == curObjectName) then
          if (player_color == convertedObjectColor) then
            return siteIndex
          end
        end
      end
    end
  end
  return nil
end

function GetSitesRuledByPlayer(player_color)
  local sitesRuledByPlayer = {}
  
  for siteIndex = 1, 8 do
    local scriptZoneObjects = globalData.mapSiteCardZones[siteIndex].getObjects(true)
    for i, curObject in ipairs(scriptZoneObjects) do
      if ("Figurine" == curObject.type) then
        if ("Warband" == curObject.getName()) then

          local warbandColor = curObject.getDescription()
          if ("Black" == warbandColor) then
            warbandColor = "Brown"
          end
          
          local playerWarbandColor = player_color
          if globalData.curPlayerStatus[player_color][1] == "Citizen" then
            playerWarbandColor = 'Purple'
          end
          
          if (playerWarbandColor == warbandColor) then
            table.insert(sitesRuledByPlayer, siteIndex)
          end
        end
      end
    end
  end
  return sitesRuledByPlayer
end

function PlayerCanUseRelic(player_color, relicName)
  for _, object in ipairs(globalData.playerOwnershipZones[player_color].getObjects(true)) do
    if object.getName() == relicName then
      -- Check if the relic is faceup.
      testRotation = object.getRotation()
      if ((testRotation[3] < 150) or (testRotation[3] > 210)) then
        return true
      end
    end
  end
  return false
end

function EnableTavernSongsUI(player_color, card_power)
  
  local assets = Global.UI.getCustomAssets()
  
  function SetAssetPath(name, url)
    for i, asset in ipairs(assets) do
      if asset.name == name then
        if asset.url ~= url then
          asset.url = url
          return true
        end
        return false
      end
    end
    table.insert(assets, {name = name, url = url})
    return true
  end

  local cardAssets = GetCardAssets(3)
  local assetsChanged = false
  for i, cardAsset in ipairs(cardAssets) do
    local cardImageID = 'CardImage'..tostring(i)
    
    if cardAsset then
      local assetName = "DeckSpriteSheet"..tostring(cardAsset.deckID)
      if SetAssetPath(assetName, cardAsset.spritesheet) then
        assetsChanged = true
      end

      Global.UI.setAttribute(cardImageID, 'image', assetName)
      Global.UI.setAttribute(cardImageID, 'width', tostring(uiCardWidth * cardAsset.numWidth))
      Global.UI.setAttribute(cardImageID, 'height', tostring(uiCardHeight * cardAsset.numHeight))
      local offsetX = -uiCardWidth * cardAsset.column
      local offsetY = uiCardHeight * cardAsset.row
      Global.UI.setAttribute(cardImageID, 'offsetXY', tostring(offsetX)..' '..tostring(offsetY))
      Global.UI.setAttribute(cardImageID, 'color', '#'..cardAsset.tint)
    end
  end

  if assetsChanged then
    Global.UI.setCustomAssets(assets)
  end
  
  Global.UI.setAttribute('CardPeek', 'visibility', player_color)
  Global.UI.setAttribute('CardPeek', 'active', 'true')
  Global.UI.setValue('CardPeekTitle', card_power)
  
end

function DisableTavernSongsUI(player_color)
  if Global.UI.getAttribute('CardPeek', 'visibility') == player_color then
    Global.UI.setAttribute('CardPeek', 'active', 'false')
  end
end

function GetCardAssets(count)
  local cardAssets = {}
  local deck = GetDeck()
  if not deck then
    -- case for no cards (shouldn't happen but supported anyway)
    table.insert(cardAssets, GetCardAsset(nil))
    table.insert(cardAssets, GetCardAsset(nil))
    table.insert(cardAssets, GetCardAsset(nil))
  elseif (deck.type == 'Card') then
    -- case for a single card
    local cardData = deck.getData()
    table.insert(cardAssets, GetCardAsset(cardData.CardID, cardData.CustomDeck))
    table.insert(cardAssets, GetCardAsset(nil))
    table.insert(cardAssets, GetCardAsset(nil))
  else
    -- case for an entire deck
    local deckData = deck.getData()
    for i = 1, 3 do
      local cardData = deckData.ContainedObjects[i]
      if cardData then
        table.insert(cardAssets, GetCardAsset(cardData.CardID, deckData.CustomDeck))
      else
        table.insert(cardAssets, GetCardAsset(nil))
      end
    end
  end
  
  return cardAssets
end

function GetCardAsset(cardId, customDeck)
  if cardId == nil then
    return {
      row = 0,
      column = 0,
      numWidth = 1,
      numHeight = 1,
      spritesheet = 'http://tts.ledergames.com/Oath/cards/3_2_0/cardbackDefault.jpg',
      deckID = -1,
      tint = Color(0.2, 0.2, 0.2, 1):toHex()
    }
  end

  local deckID = math.floor(cardId / 100)
  local index = cardId % 100

  local deck = customDeck[deckID];
  local row = math.floor(index / deck.NumWidth)
  local column = index % deck.NumWidth

  local spritesheet = deck.FaceURL

  return {
    row = row,
    column = column,
    numWidth = deck.NumWidth,
    numHeight = deck.NumHeight,
    spritesheet = spritesheet,
    deckID = deckID,
    tint = Color(1,1,1,1):toHex()
  }
  end