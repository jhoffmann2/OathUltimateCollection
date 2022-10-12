---@alias OathCardType "Site" | "Denizen" | "EdificeRuin" | "Vision" | "Relic" | "SuperRelic"
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

function onLoad(saveString)
  shared.dataIsAvailable = false

  cardLists = {
    Site = {},
    Denizen = {},
    EdificeRuin = {},
    Vision = {},
    Relic = {},
    SuperRelic = {},
    Extra = {}
  }

  shared.cardWeights = {}

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

  InvokeMethod("AddCommand", Global, {
    identifier = '!card_weights',
    description = 'Open an editor to change how likely cards are to show up in random games',
    hostOnly = true,
    eventName = 'OnCommand_CardWeights',
  })
end

function Method.ResetDecks()
  onLoad()
end

---@param deckInfo OathDeckInfo
---@param cards OathCardData[]
function Method.AddDeck(deckInfo, cards)
  if deckInfo.backimage == "SITE_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/landBack.jpg"
  elseif deckInfo.backimage == "DENIZEN_BACK" or deckInfo.backimage == nil then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cardbackDefault.jpg"
  elseif deckInfo.backimage == "VISION_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cardbackVision.jpg"
  elseif deckInfo.backimage == "RELIC_BACK" then
    deckInfo.backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/relicBack.jpg"
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
      if not shared.cardWeights[metatag] then
        shared.cardWeights[metatag] = 1 -- default weight is 1
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
  local asJson = JSON.encode_pretty(shared.cardWeights)
  
  -- open a data editor to edit the weights
  InvokeMethod("OpenDataEditor", Global,
    '\n'..asJson, "Modify Weights: ", "SetCardWeights", Global
  )
end

function Method.SetCardWeights(asJson)
  print(asJson)
  shared.cardWeights = JSON.decode(asJson)
end
