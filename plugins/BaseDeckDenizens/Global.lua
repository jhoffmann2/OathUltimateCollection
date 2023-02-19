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
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Wrestlers", suit = "Order", cardtype = "Denizen" },
      { cardName = "Battle Honors", suit = "Order", cardtype = "Denizen" },
      { cardName = "Bear Traps", suit = "Order", cardtype = "Denizen" },
      { cardName = "Longbows", suit = "Order", cardtype = "Denizen" },
      { cardName = "Keep", suit = "Order", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Pressgangs", suit = "Order", cardtype = "Denizen" },
      { cardName = "Garrison", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Scouts", suit = "Order", cardtype = "Denizen" },
      { cardName = "Alchemist", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Martial Culture", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Errand Boy", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Mercenaries", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Tinker's Fair", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Rain Boots", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "A Small Favor", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Second Wind", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Sleight of Hand", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Key to the City", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Scryer", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Disgraced Captain", suit = "Discord", cardtype = "Denizen" }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards2.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4,
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Naysayers", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Book Burning", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Ancient Binding", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Horse Archers", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Warning Signals", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Elders", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "The Gathering", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Faithful Friend", suit = "Nomad", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Tents", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Great Herd", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Fire Talkers", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Magician's Code", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Spirit Snare", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Wizard School", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Dazzle", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Acting Troupe", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Taming Charm", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Inquisitor", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Wolves", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Animal Playmates", suit = "Beast", cardtype = "Denizen", playerOnly = true }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards3.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "True Names", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "The Old Oak", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Forest Paths", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Long-Lost Heir", suit = "Beast", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Rangers", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Roving Terror", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Wayside Inn", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Extra Provisions", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Memory of Home", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Welcoming Party", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Traveling Doctor", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Storyteller", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Armed Mob", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Tavern Songs", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Secret Signal", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Augury", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Rusting Ray", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Portal", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Billowing Fog", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Kindred Warriors", suit = "Arcane", cardtype = "Denizen" }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards4.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Terror Spells", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Blood Pact", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Revelation", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Observatory", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Plague Engines", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Gleaming Armor", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Bewitch", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Jinx", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Tutor", suit = "Arcane", cardtype = "Denizen", playerOnly = true },
      { cardName = "Dream Thief", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Cracking Ground", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Sealing Ward", suit = "Arcane", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Initiation Rite", suit = "Arcane", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Vow of Silence", suit = "Arcane", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Forgotten Vault", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Map Library", suit = "Arcane", cardtype = "Denizen", siteOnly = true },
      { cardName = "Witch's Bargain", suit = "Arcane", cardtype = "Denizen" },
      { cardName = "Master of Disguise", suit = "Arcane", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Charlatan", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Assassin", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards5.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Downtrodden", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Blackmail", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Cracked Sage", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Dissent", suit = "Discord", cardtype = "Denizen" },
      { cardName = "False Prophet", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Vow of Renewal", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Zealots", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Royal Ambitions", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Salt the Earth", suit = "Discord", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Beast Tamer", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Riots", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Silver Tongue", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Gambling Hall", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Boiling Lake", suit = "Discord", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Relic Thief", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Enchantress", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Insomnia", suit = "Discord", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Sneak Attack", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Gossip", suit = "Discord", cardtype = "Denizen", siteOnly = true },
      { cardName = "Bandit Chief", suit = "Discord", cardtype = "Denizen", siteOnly = true }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards6.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Chaos Cult", suit = "Discord", cardtype = "Denizen", playerOnly = true },
      { cardName = "Slander", suit = "Discord", cardtype = "Denizen" },
      { cardName = "Code of Honor", suit = "Order", cardtype = "Denizen" },
      { cardName = "Outriders", suit = "Order", cardtype = "Denizen" },
      { cardName = "Messenger", suit = "Order", cardtype = "Denizen" },
      { cardName = "Field Promotion", suit = "Order", cardtype = "Denizen" },
      { cardName = "Palanquin", suit = "Order", cardtype = "Denizen", playerOnly = true },
      { cardName = "Shield Wall", suit = "Order", cardtype = "Denizen" },
      { cardName = "Military Parade", suit = "Order", cardtype = "Denizen" },
      { cardName = "Tome Guardians", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Tyrant", suit = "Order", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Forced Labor", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Secret Police", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Specialist", suit = "Order", cardtype = "Denizen" },
      { cardName = "Captains", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Siege Engines", suit = "Order", cardtype = "Denizen" },
      { cardName = "Royal Tax", suit = "Order", cardtype = "Denizen" },
      { cardName = "Toll Roads", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Curfew", suit = "Order", cardtype = "Denizen", siteOnly = true },
      { cardName = "Knights Errant", suit = "Order", cardtype = "Denizen" }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards7.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Vow of Obedience", suit = "Order", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Hunting Party", suit = "Order", cardtype = "Denizen" },
      { cardName = "Council Seat", suit = "Order", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Encirclement", suit = "Order", cardtype = "Denizen" },
      { cardName = "Peace Envoy", suit = "Order", cardtype = "Denizen" },
      { cardName = "Relic Hunter", suit = "Order", cardtype = "Denizen" },
      { cardName = "Homesteaders", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Crop Rotation", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "A Round of Ale", suit = "Hearth", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Land Warden", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Charming Friend", suit = "Hearth", cardtype = "Denizen", playerOnly = true },
      { cardName = "Village Constable", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Family Heirloom", suit = "Hearth", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "News from Afar", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Levelers", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Fabled Feast", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "The Great Levy", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Hearts and Minds", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Relic Breaker", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Book Binders", suit = "Hearth", cardtype = "Denizen", playerOnly = true }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards8.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Ballot Box", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Saddle Makers", suit = "Hearth", cardtype = "Denizen", playerOnly = true },
      { cardName = "Herald", suit = "Hearth", cardtype = "Denizen", playerOnly = true },
      { cardName = "Rowdy Pub", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Vow of Peace", suit = "Hearth", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Deed Writer", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Salad Days", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Marriage", suit = "Hearth", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Hospital", suit = "Hearth", cardtype = "Denizen", siteOnly = true },
      { cardName = "Awaited Return", suit = "Hearth", cardtype = "Denizen" },
      { cardName = "Convoys", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Vow of Kinship", suit = "Nomad", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Wild Mounts", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Lancers", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Mountain Giant", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Rival Khan", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Lost Tongue", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Special Envoy", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Resettle", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Oracle", suit = "Nomad", cardtype = "Denizen", siteOnly = true }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards9.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Pilgrimage", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Spell Breaker", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Mounted Patrol", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Great Crusade", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Ancient Bloodline", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Ancient Pact", suit = "Nomad", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Storm Caller", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Family Wagon", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Way Station", suit = "Nomad", cardtype = "Denizen", siteOnly = true },
      { cardName = "Twin Brother", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "Hospitality", suit = "Nomad", cardtype = "Denizen", playerOnly = true },
      { cardName = "A Fast Steed", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Relic Worship", suit = "Nomad", cardtype = "Denizen" },
      { cardName = "Sacred Ground", suit = "Nomad", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Nature Worship", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Birdsong", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Small Friends", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Grasping Vines", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Threatening Roar", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Fae Merchant", suit = "Beast", cardtype = "Denizen" }
    }
  )

  InvokeMethod('AddDeck', Global,
    { 
      deckimage = "http://tts.ledergames.com/Oath/cards/3_2_0/cards10.jpg", 
      backimage = "DENIZEN_BACK", 
      deckwidth = 5, 
      deckheight = 4, 
      hasuniqueback = false,
      metatags = {'Official', 'BaseDeck'}
    },
    {
      { cardName = "Second Chance", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Pied Piper", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Mushrooms", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Insect Swarm", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "Vow of Union", suit = "Beast", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Giant Python", suit = "Beast", cardtype = "Denizen", playerOnly = true },
      { cardName = "War Tortoise", suit = "Beast", cardtype = "Denizen" },
      { cardName = "New Growth", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Wild Cry", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Animal Host", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Memory of Nature", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Marsh Spirit", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Vow of Poverty", suit = "Beast", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Forest Council", suit = "Beast", cardtype = "Denizen", siteOnly = true, locked = true },
      { cardName = "Walled Garden", suit = "Beast", cardtype = "Denizen", siteOnly = true },
      { cardName = "Vow of Beastkin", suit = "Beast", cardtype = "Denizen", playerOnly = true, locked = true },
      { cardName = "Bracken", suit = "Beast", cardtype = "Denizen" },
      { cardName = "Wild Allies", suit = "Beast", cardtype = "Denizen" }
    }
  )

end