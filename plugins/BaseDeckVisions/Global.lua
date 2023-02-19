--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2020
--
-- This file contains card data so that the main script file can be shorter.
--

function onLoad()

  -------------------------------------------------------------------------------------------
  --- Visions
  ---

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/visions.jpg", 
      backimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cardbackVision.jpg", 
      deckwidth = 3, 
      deckheight = 2, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Sanctuary", cardtype = "Vision" },
      { cardName = "Rebellion", cardtype = "Vision" },
      { cardName = "Conspiracy", cardtype = "Vision" },
      { cardName = "Faith", cardtype = "Vision" },
      { cardName = "Conquest", cardtype = "Vision" },
    }
  )

end