--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2020
--
-- This file contains card data so that the main script file can be shorter.
--

function onLoad()

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/relics.jpg", 
      backimage = "RELIC_BACK", 
      deckwidth = 5, 
      deckheight = 5, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Sticky Fire", cardtype = "Relic" },
      { cardName = "Cursed Cauldron", cardtype = "Relic" },
      { cardName = "Brass Horse", cardtype = "Relic" },
      { cardName = "Truthful Harp", cardtype = "Relic" },
      { cardName = "Grand Mask", cardtype = "Relic" },
      { cardName = "Horned Mask", cardtype = "Relic" },
      { cardName = "Cup of Plenty", cardtype = "Relic" },
      { cardName = "Whistle", cardtype = "Relic" },
      { cardName = "Dowsing Sticks", cardtype = "Relic" },
      { cardName = "Cracked Horn", cardtype = "Relic" },
      { cardName = "Bandit Crown", cardtype = "Relic" },
      { cardName = "Ring of Devotion", cardtype = "Relic" },
      { cardName = "Skeleton Key", cardtype = "Relic" },
      { cardName = "Oracular Pig", cardtype = "Relic" },
      { cardName = "Circlet of Command", cardtype = "Relic" },
      { cardName = "Ivory Eye", cardtype = "Relic" },
      { cardName = "Map", cardtype = "Relic" },
      { cardName = "Obsidian Cage", cardtype = "Relic" },
      { cardName = "Book of Records", cardtype = "Relic" },
      { cardName = "Dragonskin Drum", cardtype = "Relic" }
    }
  )

end