
function onLoad()
  if not shared.worldDeckZone.hasTag('WorldDeckZone') then
    shared.worldDeckZone.addTag('WorldDeckZone')
  end

  for regionNumber, discardZone in ipairs(shared.discardZones) do
    if not discardZone.hasTag('DiscardDeckZone') then
      discardZone.addTag('DiscardDeckZone')
    end
  end
end