
function onLoad()
  InvokeEvent('OnEnsurePluginActive', 'PlayerOwnershipZones')
  if not shared.worldDeckZone.hasTag('DeckZone') or not shared.worldDeckZone.hasTag('WorldDeckZone') then
    shared.worldDeckZone.addTag('DeckZone')
    shared.worldDeckZone.addTag('WorldDeckZone')
  end
  for regionNumber, discardZone in ipairs(shared.discardZones) do
    if not discardZone.hasTag('DeckZone') or not discardZone.hasTag('DiscardDeckZone') then
      discardZone.addTag('DeckZone')
      discardZone.addTag('DiscardDeckZone')
      Shared(discardZone).regionNumber = regionNumber
    end
  end
end