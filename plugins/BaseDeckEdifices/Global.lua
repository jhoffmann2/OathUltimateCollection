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
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/edificeFront.jpg", 
      backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/edificeBack.jpg", 
      deckwidth = 3, 
      deckheight = 2, 
      hasuniqueback = true,
      metatags = {'Official', 'BaseDeck'},
      plugin = "BaseDeckEdifices"
    },
    {
      { cardName = "Sprawling Rampart / Bandit Rampart", suit = "Order", cardtype = "EdificeRuin" },
      { cardName = "Hall of Debate / Hall of Mockery", suit = "Hearth", cardtype = "EdificeRuin" },
      { cardName = "Forest Temple / Ruined Temple", suit = "Beast", cardtype = "EdificeRuin" },
      { cardName = "Festival District / Squalid District", suit = "Discord", cardtype = "EdificeRuin" },
      { cardName = "Great Spire / Fallen Spire", suit = "Arcane", cardtype = "EdificeRuin" },
      { cardName = "Ancient Forge / Broken Forge", suit = "Nomad", cardtype = "EdificeRuin" }
    }
  )

end