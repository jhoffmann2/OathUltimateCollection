﻿---@alias OathCardType "Site" | "Denizen" | "EdificeRuin" | "Vision" | "Relic" | "SuperRelic"
---@alias OathCardSuit "Arcane" | "Beast" | "Discord" | "Hearth" | "Nomad" | "Order"

---@class OathCardData
---@field cardName string
---@field saveid number
---@field ttscardid number
---@field cardtype OathCardType
---@field capacity number
---@field relicCount number
---@field suit nil | OathCardSuit
---@field playerOnly nil | boolean
---@field metatags string[]

---@class OathDeckInfo
---@field deckimage string
---@field backimage string
---@field deckwidth string
---@field deckheight string
---@field hasuniqueback boolean
---@field metatags string[]

---@field Site OathCardData[]
---@field Denizen OathCardData[]
---@field EdificeRuin OathCardData[]
---@field Vision OathCardData[]
---@field Relic OathCardData[]
---@field SuperRelic OathCardData[]
local cardLists

local seenPluginsSet
local pluginBeingLoaded = nil
local cachedPluginLookup = {}
local addDeckCallCounter = 0

function onLoad(save_string)
  local save_data = {}
  if save_string and save_string ~= '' then
    save_data = JSON.decode(save_string)
  end

  if save_data.cachedPluginLookup then
    cachedPluginLookup = save_data.cachedPluginLookup
  end
  
  Method.ResetDecks()

  InvokeMethod("AddCommand", Global, {
    identifier = '!card_weights',
    description = 'Open an editor to change how likely cards are to show up in random games',
    hostOnly = true,
    eventName = 'OnCommand_CardWeights',
  })
end

function onSave()
  local save_data = {}
  save_data.cachedPluginLookup = cachedPluginLookup
  return JSON.encode(save_data)
end

function Method.ResetDecks()
  shared.dataIsAvailable = false
  addDeckCallCounter = 0

  cardLists = {
    Site = {},
    Denizen = {},
    EdificeRuin = {},
    Vision = {},
    Relic = {},
    SuperRelic = {},
    Extra = {}
  }
  seenPluginsSet = {}
  shared.deckPlugins = {}

  shared.cardMetatagWeights = {}
  shared.cardWeightsCache = nil

  shared.sitesBySaveID = { [-1] = "NONE" }
  shared.normalCardsBySaveID = { [-1] = "NONE" }
  shared.cardsTable = {
    ["NONE"] = { cardtype = "NONE", saveid = -1 }
  }

  shared.ttsDeckInfo = {}
  shared.ruinSaveIDs = {}
  shared.edificesBySuit = {}
  shared.translateNameFromFAQ = {
    ["Banner of the People's Favor"] = "The People's Favor / The Mob's Favor",
    ["Banner of the Mob's Favor"] = "The People's Favor / The Mob's Favor",
    ["Banner of the Darkest Secret"] = "The Darkest Secret"
  }
  shared.edificeSaveIDs = {}
end

---@param deckInfo OathDeckInfo
---@param cards OathCardData[]
function Method.AddDeck(deckInfo, cards)
  addDeckCallCounter = addDeckCallCounter + 1

  if cachedPluginLookup[addDeckCallCounter] ~= nil then
    pluginBeingLoaded = cachedPluginLookup[addDeckCallCounter]
  else
    cachedPluginLookup[addDeckCallCounter] = pluginBeingLoaded
  end
  
  if deckInfo.backimage == "SITE_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/landBack.jpg"
  elseif deckInfo.backimage == "DENIZEN_BACK" or deckInfo.backimage == nil then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cardbackDefault.jpg"
  elseif deckInfo.backimage == "VISION_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cardbackVision.jpg"
  elseif deckInfo.backimage == "RELIC_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/relicBack.jpg"
  end
  
  -- if we haven't seen this plugin before, record it
  if not seenPluginsSet[pluginBeingLoaded] then
    seenPluginsSet[pluginBeingLoaded] = true

    if not shared.deckPlugins then
      shared.deckPlugins = {}
    end
    table.insert(shared.deckPlugins, pluginBeingLoaded)
  end

  table.insert(shared.ttsDeckInfo, deckInfo)
  local deckId = #shared.ttsDeckInfo
  for deckIndex, oathCardData in ipairs(cards) do
    
    -- all cards inherit metatags of deck
    if not oathCardData.metatags then
      oathCardData.metatags = {}
    end
    if deckInfo.metatags then
      for _, deckMetaTag in ipairs(deckInfo.metatags) do
        table.insert(oathCardData.metatags, deckMetaTag)
      end
    end
    
    -- if we haven't seen a metatag before, add it's weight
    for _, metatag in ipairs(oathCardData.metatags) do
      if not shared.cardMetatagWeights[metatag] then
        shared.cardMetatagWeights[metatag] = 1 -- default weight is 1
      end
    end
    
    -- insert card based on type
    if oathCardData.cardtype ~= nil then
      oathCardData.ttscardid = string.format("%02d%02d", deckId, deckIndex - 1)
      oathCardData.saveid = nil -- if saveid was provided, delete it. we'll write our own saveid

      table.insert(cardLists[oathCardData.cardtype], oathCardData.cardName)
      shared.cardsTable[oathCardData.cardName] = oathCardData
    end
  end
end

function Method.SetDeckPluginsList(pluginList)
  if waitingForPlugins ~= nil then
    printToAll("Error: Tried to SetDeckPluginsList while the previous plugin list was still loading", {1,0,0})
    return
  end
  
  if #pluginList == #shared.deckPlugins then
    local pluginsUnchanged = true
    for i, plugin in ipairs(pluginList) do
      if plugin ~= shared.deckPlugins[i] then
        pluginsUnchanged = false
        break
      end
    end
    if pluginsUnchanged then
      InvokeEvent("OnFinishSetDeckPluginsList")
      return
    end
  end

  waitingForPlugins = {}
  for _, plugin in ipairs(pluginList) do
    waitingForPlugins[plugin] = true
  end
  
  for _, plugin in ipairs(shared.deckPlugins) do
    InvokeEvent("OnDeactivatePlugin", plugin)
  end

  Method.ResetDecks()
  cachedPluginLookup = {}
  
  for _, plugin in ipairs(pluginList) do
    InvokeEvent("OnActivatePlugin", plugin)
  end
end

function Callback.OnPluginStartup(pluginName)
  pluginBeingLoaded = pluginName
end

function Callback.OnPluginActivated(pluginName)
  if waitingForPlugins ~= nil then
    waitingForPlugins[pluginName] = nil
    
    -- because sets don't have an isEmpty operator, use pairs() to check if there's at least one element
    local stillWaiting = false
    for plugin,_ in pairs(waitingForPlugins) do
      stillWaiting = true
      break
    end
    if not stillWaiting then
      waitingForPlugins = nil
      Method.UpdateDeckData()
      InvokeEvent("OnFinishSetDeckPluginsList")
    end
  end
  pluginBeingLoaded = nil
end

function Method.UpdateDeckData()
  shared.NUM_TOTAL_SITES = #cardLists.Site
  shared.NUM_TOTAL_DENIZENS = #cardLists.Denizen

  -- sitesBySaveID has every site twice to symbolize faceup and facedown versions
  local siteCardCount = 0

  shared.MIN_SITE = siteCardCount
  siteCardCount = AppendCardList(shared.sitesBySaveID, cardLists.Site, siteCardCount)
  shared.MAX_SITE = siteCardCount - 1

  siteCardCount = siteCardCount + 1 -- legacy padding between faceup and facedown sites

  shared.MIN_SITE_FACEDOWN = siteCardCount
  siteCardCount = AppendCardList(shared.sitesBySaveID, cardLists.Site, siteCardCount)
  shared.MAX_SITE_FACEDOWN = siteCardCount - 1

  local normalCardCount = 0

  shared.MIN_DENIZEN = normalCardCount
  normalCardCount = AppendCardList(shared.normalCardsBySaveID, cardLists.Denizen, normalCardCount)
  shared.MAX_DENIZEN = normalCardCount - 1

  shared.MIN_EDIFICE_RUIN = normalCardCount
  normalCardCount = AppendEdificeRuins(normalCardCount)
  shared.MAX_EDIFICE_RUIN = normalCardCount - 1

  shared.MIN_VISION = normalCardCount
  normalCardCount = AppendCardList(shared.normalCardsBySaveID, cardLists.Vision, normalCardCount)
  shared.MAX_VISION = normalCardCount - 1

  shared.MIN_SUPER_RELIC = normalCardCount
  normalCardCount = AppendCardList(shared.normalCardsBySaveID, cardLists.SuperRelic, normalCardCount)
  shared.MAX_SUPER_RELIC = normalCardCount - 1

  shared.MIN_RELIC = normalCardCount
  normalCardCount = AppendCardList(shared.normalCardsBySaveID, cardLists.Relic, normalCardCount)
  shared.MAX_RELIC = normalCardCount - 1

  shared.MIN_EXTRA_CARD = normalCardCount
  normalCardCount = AppendCardList(shared.normalCardsBySaveID, cardLists.Extra, normalCardCount)
  shared.MAX_EXTRA_CARD = normalCardCount - 1
  
  shared.MAX_CARD_ID = normalCardCount - 1
  
  -- update site save ids in the cardsTable
  for index, cardName in ipairs(cardLists.Site) do
    shared.cardsTable[cardName].saveid = index - 1
  end

  -- update 'normal card' save ids in the cardsTable
  for saveid, cardName in pairs(shared.normalCardsBySaveID) do
    if not shared.ruinSaveIDs[saveid] then
      shared.cardsTable[cardName].saveid = saveid
    end
  end

  -- USED FOR DEBUGGING
  local ttsDeckInfo = getmetatable(shared.ttsDeckInfo).data()
  local sitesBySaveID = getmetatable(shared.sitesBySaveID).data()
  local normalCardsBySaveID = getmetatable(shared.normalCardsBySaveID).data()
  local cardsTable = getmetatable(shared.cardsTable).data()
  local ruinSaveIDs = getmetatable(shared.ruinSaveIDs).data()
  local edificesBySuit = getmetatable(shared.edificesBySuit).data()
  local translateNameFromFAQ = getmetatable(shared.translateNameFromFAQ).data()

  shared.dataIsAvailable = true
end

function AppendCardList(lhs, rhs, len)
  for _, item in ipairs(rhs) do
    lhs[len] = item
    len = len + 1
  end
  return len
end

function AppendEdificeRuins(len)
  ---@param cardName string
  for _, cardName in ipairs(cardLists.EdificeRuin) do
    shared.normalCardsBySaveID[len] = cardName -- edifice side
    table.insert(shared.edificeSaveIDs, len)
    len = len + 1

    shared.normalCardsBySaveID[len] = cardName -- ruin side
    shared.ruinSaveIDs[len] = true
    len = len + 1

    ---@type OathCardData
    local cardInfo = shared.cardsTable[cardName]
    shared.edificesBySuit[cardInfo.suit] = cardName -- currently only one edifice per suit is supported

    local edificeEnd, ruinBegin = cardName:find(' / ')
    local edificeName = cardName:sub(1, edificeEnd - 1)
    local ruinName = cardName:sub(ruinBegin + 1)
    shared.translateNameFromFAQ[edificeName] = cardName
    shared.translateNameFromFAQ[ruinName] = cardName
  end
  return len
end

function Callback.OnCommand_CardWeights()
  local asJson = JSON.encode_pretty(shared.cardMetatagWeights)
  
  -- open a data editor to edit the weights
  InvokeMethod("OpenDataEditor", Global,
    '\n'..asJson, "Modify Weights: ", "SetCardWeights", Global
  )
end

function Method.SetCardWeights(asJson)
  local result = JSON.decode(asJson)
  
  if not result then
    printToAll("Invalid JSON provided", {1,0,0})
    return
  end
  
  for tag, weight in pairs(shared.cardMetatagWeights) do
    if result[tag] == nil then
      printToAll(tag.." missing from JSON", {1,0,0})
      return
    end
  end

  for tag, weight in pairs(result) do
    if weight > 655.35 then
      printToAll("weights cannot exceed 655.35", {1,0,0})
      return
    end

    if weight < 0 then
      printToAll("weights must be positive", {1,0,0})
      return
    end
  end
  
  shared.cardMetatagWeights = result
  shared.cardWeightsCache = nil
end

function Method.CalculateCardDrawWeight(cardName)
  if shared.cardWeightsCache == nil then
    shared.cardWeightsCache = {}
    for cardName, oathCardData in pairs(shared.cardsTable) do
      local cardWeight = 1
      if oathCardData.metatags then
        for _, metatag in ipairs(oathCardData.metatags) do
          -- a card's weight is the product of all it's metatag weights
          cardWeight = cardWeight * shared.cardMetatagWeights[metatag]
        end
      end
      shared.cardWeightsCache[cardName] = cardWeight
    end
  end

  return shared.cardWeightsCache[cardName]
end
