--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2020
--
-- This file contains card data so that the main script file can be shorter.
--

function onLoad()

  -------------------------------------------------------------------------------------------
  --- Banners (Legacy)
  ---

  -- DS and PF added for legacy reasons
  InvokeMethod('AddDeck', Global,
    {},
    {
      { cardName = "The Darkest Secret", cardtype = "SuperRelic" },
      { cardName = "The People's Favor / The Mob's Favor", cardtype = "SuperRelic" },
      { cardName = "The Grand Scepter", cardtype = "SuperRelic" }
    }
  )


  -------------------------------------------------------------------------------------------
  --- Grand Scepter
  ---
  
  InvokeMethod('AddDeck', Global,
    { deckimage = "http://tts.ledergames.com/Oath/cards/3_3_2/grandScepterBack.png", backimage = "http://tts.ledergames.com/Oath/cards/3_3_2/grandScepterFront.png", deckwidth = 1, deckheight = 1, hasuniqueback = true },
    {
      { cardName = "The Grand Scepter", cardtype = "SuperRelic" }
    }
  )

end