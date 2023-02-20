--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2020
--
-- This file contains card data so that the main script file can be shorter.
--

function onLoad()
  
  -------------------------------------------------------------------------------------------
  --- Sites
  ---

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/lands.jpg", 
      backimage = "SITE_BACK", 
      deckwidth = 2, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'},
      plugin = "BaseDeckSites"
    },
    {
      { cardName = "Mine", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "Salt Flats", cardtype = "Site", capacity = 2, relicCount = 0 },
      { cardName = "Fertile Valley", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "Barren Coast", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "Plains", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "River", cardtype = "Site", capacity = 2, relicCount = 0 },
      { cardName = "Steppe", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "Mountain", cardtype = "Site", capacity = 2, relicCount = 1 }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/lands2.jpg", 
      backimage = "SITE_BACK", 
      deckwidth = 2, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'},
      plugin = "BaseDeckSites"
    },
    {
      { cardName = "Lush Coast", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "Marshes", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "Wastes", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "Rocky Coast", cardtype = "Site", capacity = 2, relicCount = 0 },
      { cardName = "Narrow Pass", cardtype = "Site", capacity = 1, relicCount = 1 },
      { cardName = "Charming Valley", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "Deep Woods", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "Standing Stones", cardtype = "Site", capacity = 2, relicCount = 1 }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/lands3.jpg", 
      backimage = "SITE_BACK", 
      deckwidth = 2, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'},
      plugin = "BaseDeckSites"
    },
    {
      { cardName = "Ancient City", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "Drowned City", cardtype = "Site", capacity = 0, relicCount = 2 },
      { cardName = "Great Slum", cardtype = "Site", capacity = 3, relicCount = 0 },
      { cardName = "Buried Giant", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "The Tribunal", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "Shrouded Wood", cardtype = "Site", capacity = 2, relicCount = 1 },
      { cardName = "The Hidden Place", cardtype = "Site", capacity = 2, relicCount = 1 }
    }
  )

end