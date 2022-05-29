function onLoad()
  InvokeEvent('OnEnsureModActive', 'PlayerOwnershipZones')
  
  ---@param warbandBag tts__Object
    ---@param color tts__PlayerColor
  for color, warbandBag in pairs(shared.playerWarbandBags) do
    -- make sure every warbandBag is given the proper tag
    if (not warbandBag.hasTag('WarbandBag') or not warbandBag.hasTag(color)) then
      warbandBag.addTag(color)
      warbandBag.addTag('WarbandBag')
    end
    Shared(warbandBag).color = color
  end
  
end