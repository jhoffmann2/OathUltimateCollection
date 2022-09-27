function onLoad()
  
  -- this deck inherits cards from the base deck
  InvokeEvent('OnEnsurePluginActive', 'BaseDeck')

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://cloud-3.steamusercontent.com/ugc/1806529457279026191/1A8289CF00032FA77777D8E493A897A932876A1F/", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 2, 
      hasuniqueback = false 
    },
    {
      {  }, -- skip card
      {  }, -- skip card
      {  }, -- skip card
      { cardName = "BigHouse", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Bustling Tavern", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Friendly Conversation", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Gnome Ambush", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Grouchy Gnome", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Returning Home", suit = "Hearth", cardtype = "Denizen", playerOnly = true },
      { cardName = "The Good Stuff", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "The Traveler's Tale", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Too Many Cooks", suit = "Hearth", cardtype = "Denizen", siteOnly = true }
    }
  )
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://cloud-3.steamusercontent.com/ugc/1806529457279029392/24FCF529F730964E317690DD2406415AA9431EE1/", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 2, 
      hasuniqueback = false 
    },
    {
      {  }, -- skip card
      {  }, -- skip card
      { cardName = "Aggressive Curator", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Brutal Training", suit = "Order", cardtype = "Denizen" },
      { cardName = "Convincing Offer", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Divine Right", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Hound Dogs", suit = "Order", cardtype = "Denizen" },
      { cardName = "Manifest Destiny", suit = "Order", cardtype = "Denizen" },
      { cardName = "Secret Army", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Secret Tunnels", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Trusted Entourage", suit = "Order", cardtype = "Denizen", playerOnly = true },
    }
  )
  
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://cloud-3.steamusercontent.com/ugc/1806529457278981365/7872A46561AD8D7E09F1A4BD60D0765E2E27D9CC/", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 3, 
      hasuniqueback = false 
    },
    {
      { cardName = "Alchemist's Professor", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Annihilation", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Blood Benders", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Charismatic Spells", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Dangerous Spells", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Delve", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Translocation", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Truth Serum", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Wizard Mine", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      {}, -- Alpha Female isn't a denizen
      { cardName = "Bone Marrow", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Fountain of Youth", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Lonely Alpha", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Nocturnal", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Seeking Guidance", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Shape Shifter", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Territorial", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      {}, -- The Whole Pack isn't a denizen
      { cardName = "Transplant", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Underdog", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Wild Berries", suit = "Beast", cardtype = "Denizen", siteOnly = true },
    }
  )
  
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://cloud-3.steamusercontent.com/ugc/1806529457279015024/7EF38B8EC9D98F28FEEBD3DF7D1B21C7DC144717/", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 3, 
      hasuniqueback = false
    },
    {
      { cardName = "Alleyways", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Bullies", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Cantankerous Elders", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Carnival Floats", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Fireworks", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Hooligans", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Inside Agents", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Junk Dealer", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Mad With Power!", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Opportunists", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Tactical Gift", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Urchins", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "A Long Journey", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Across the Land", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Adventurer's Guild", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Ancient Guardians", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Noisy Neighbors", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "High Tide", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Navigators", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Oasis", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Sacred March", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Tourist Agency", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Traveling Market", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Wandering Laborers", suit = "Nomad", cardtype = "Denizen" },
    }
  )
  
  InvokeMethod('AddDeck', Global,
    { deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/lands2.jpg", backimage = "SITE_BACK", deckwidth = 2, deckheight = 4, hasuniqueback = false },
    {
      { cardName = "AAAAAA", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "BBBBBB", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "CCCCCC", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "DDDDDD", cardtype = "Site", capacity = 2, relicCount = 0 },
      { cardName = "EEEEEE", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "FFFFFF", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "GGGGGG", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "HHHHHH", cardtype = "Site", capacity = 2, relicCount = 1 }
    }
  )
  
end