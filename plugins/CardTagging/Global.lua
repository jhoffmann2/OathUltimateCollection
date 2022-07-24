

function onLoad()
  
  --if not shared.worldDeckZone.hasTag('WorldDeckZone') then
  --  shared.worldDeckZone.addTag('WorldDeckZone')
  --end
--
  --for _, discardZone in ipairs(shared.discardZones) do
  --  if not discardZone.hasTag('DiscardZone') then
  --    discardZone.addTag('DiscardZone')
  --  end
  --end
  
end

function onObjectEnterZone( zone,  object)
  if zone.guid == shared.worldDeckZoneGuid then
    if object.type == 'Deck' or object.type == 'Card' then
      Shared(object).deckZone = zone
      object.addTag('WorldDeck')
      object.addTag('InDeck')
    end
  end

  for i, discardZoneGuid in ipairs(shared.discardZoneGuids) do
    if zone.guid == discardZoneGuid then
      if object.type == 'Deck' or object.type == 'Card' then
        local objectData = Shared(object)
        objectData.deckZone = zone
        objectData.regionNumber = i
        object.addTag('DiscardDeck')
        object.addTag('InDeck')
      end
    end
  end
end


function onObjectLeaveZone( zone,  object)
  if object == nil then
    return
  end
  
  if zone.guid == shared.worldDeckZoneGuid then
    if object.type == 'Deck' or object.type == 'Card' then
      object.removeTag('WorldDeck')
      object.removeTag('InDeck')
      Shared(object).deckZone = nil
    end
  end

  for _, discardZoneGuid in ipairs(shared.discardZoneGuids) do
    if zone.guid == discardZoneGuid then
      if object.type == 'Deck' or object.type == 'Card' then
        object.removeTag('DiscardDeck')
        object.removeTag('InDeck')
        Shared(object).deckZone = nil
      end
    end
  end
end
