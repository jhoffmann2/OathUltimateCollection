function onLoad()

  -------------------------------------------------------------------------------------------
  --- Sites
  ---


  -------------------------------------------------------------------------------------------
  --- Denizens
  ---

  InvokeMethod('AddDeck', Global,
    {
      deckimage = "http://cloud-3.steamusercontent.com/ugc/2023841948349596968/AF7613EAA5DD372390E2CEF171C0A1268531AA27/",
      backimage = "DENIZEN_BACK",
      deckwidth = 9,
      deckheight = 6,
      hasuniqueback = false,
      metatags = {'Custom', 'LegendsDeck'},
      plugin = "LegendsDeck"
    },
    {
      { cardName = "Anarchy", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Fire Giant", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Pirates", suit = "Discord", cardtype = "Denizen" },
      
      { cardName = "ShadowLord", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Level 100 Wizard", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "In the Stars", suit = "Arcane", cardtype = "Denizen" },
      
      { cardName = "Golden Basilica", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Oppression", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "The Old Guard", suit = "Order", cardtype = "Denizen", playerOnly = true },
      
      { cardName = "The Hound", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Grim Raiders", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Corruption", suit = "Discord", cardtype = "Denizen" },
      
      { cardName = "Dark Vizier", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Lore Seeker", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Mysterious Aura", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      
      { cardName = "Paved Roads", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Ambush", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Reinforcements", suit = "Order", cardtype = "Denizen" },
      
      { cardName = "Knives Flashing", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Plague Rats", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Anti-hero", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      
      { cardName = "Magic Missiles", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Airships", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Secret Ritual", suit = "Arcane", cardtype = "Denizen" },
      
      { cardName = "Victory March", suit = "Order", cardtype = "Denizen" },
      { cardName = "Seat of Power", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "War Council", suit = "Order", cardtype = "Denizen" },


      { cardName = "Camp for the Night", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Questing Knights", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Vow of the North", suit = "Nomad", cardtype = "Denizen", playerOnly = true, locked = true },

      { cardName = "Infestation", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Owlbear Country", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Camouflage", suit = "Beast", cardtype = "Denizen", siteOnly = true },

      { cardName = "Get Together", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Friendly Loan", suit = "Hearth", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Soup Kitchen", suit = "Hearth", cardtype = "Denizen" },

      { cardName = "Adventure Party", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Bounty Hunter", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Lost", suit = "Nomad", cardtype = "Denizen", siteOnly = true },

      { cardName = "Primal Kinship", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Spirit Guide", suit = "Beast", cardtype = "Denizen" },
      { cardName = "World Eater", suit = "Beast", cardtype = "Denizen", siteOnly = true, locked = true },

      { cardName = "Coastal Village", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Local Hero", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Popular Support", suit = "Hearth", cardtype = "Denizen" },

      { cardName = "Barbarian Camp", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Journey", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Grand Conjunction", suit = "Nomad", cardtype = "Denizen", siteOnly = true },

      { cardName = "Poacher", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Hunter", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Wild Born", suit = "Beast", cardtype = "Denizen", playerOnly = true, locked = true },

      { cardName = "Bake Sale", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Town Market", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Ranch", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      
    }
  )


  -------------------------------------------------------------------------------------------
  --- Edifices / Ruins
  ---


  -------------------------------------------------------------------------------------------
  --- Relics
  ---

end