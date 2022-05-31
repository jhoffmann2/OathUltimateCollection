function onLoad()
  InvokeEvent('OnEnsureModActive', 'PlayerOwnershipZones')
  
  ---@param warbandBag tts__Object
    ---@param color tts__PlayerColor
  for playerColor, warbandBag in pairs(shared.playerWarbandBags) do
    -- make sure every warbandBag is given the proper tag
    if (not warbandBag.hasTag('WarbandBag') or not warbandBag.hasTag(playerColor)) then
      warbandBag.addTag(playerColor)
      warbandBag.addTag('WarbandBag')
    end
    Shared(warbandBag).playerColor = playerColor
  end
  
end