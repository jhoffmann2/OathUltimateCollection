function onLoad()

  -------------------------------------------------------------------------------------------
  --- Sites
  ---
  

  -------------------------------------------------------------------------------------------
  --- Denizens
  ---
  
  
  --- HEARTH -------------------------------------------------------------------------------
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "https://cdn.discordapp.com/attachments/1019210076768178196/1026721115290206239/oath-denizen-for-tts_2.png", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 2, 
      hasuniqueback = false,
      metatags = {'Custom', 'NaysayersDeck'}
    },
    {
      {  }, -- skip template card
      {  }, -- skip template card
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
  
  --- ORDER -------------------------------------------------------------------------------
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "https://cdn.discordapp.com/attachments/1019210076768178196/1025271975293231185/oath-denizen-for-tts_2.png", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 2, 
      hasuniqueback = false,
      metatags = {'Custom', 'NaysayersDeck'}
    },
    {
      {  }, -- skip template card
      {  }, -- skip template card
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

  --- ARCANE / BEAST ----------------------------------------------------------------------
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://cloud-3.steamusercontent.com/ugc/1794145495333391310/59C9BA82FB37DD410C40D8D9258FFD8E078DB615/", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 3, 
      hasuniqueback = false,
      metatags = {'Custom', 'NaysayersDeck'}
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

  --- DISCORD / NOMAD ---------------------------------------------------------------------
  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "https://media.discordapp.net/attachments/1019210076768178196/1025283295216414750/oath-denizen-for-tts_2_but_better.png", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 10, 
      deckheight = 3, 
      hasuniqueback = false,
      metatags = {'Custom', 'NaysayersDeck'}
    },
    {
      { cardName = "Alleyways", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Cantankerous Elders", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Fireworks", suit = "Discord", cardtype = "Denizen" },
      { cardName = "A Long Journey", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Across the Land", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Adventurer's Guild", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Ancient Guardians", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      {}, -- skip template card
      { cardName = "Bullies", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Carnival Floats", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Hooligans", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Inside Agents", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Junk Dealer", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Mad With Power!", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Noisy Neighbors", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Opportunists", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Tactical Gift", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Urchins", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "High Tide", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Navigators", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Oasis", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Sacred March", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Tourist Agency", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Traveling Market", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Wandering Laborers", suit = "Nomad", cardtype = "Denizen" },
    }
  )


  -------------------------------------------------------------------------------------------
  --- Edifices / Ruins
  ---


  -------------------------------------------------------------------------------------------
  --- Relics
  ---
  
end