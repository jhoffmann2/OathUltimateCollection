

function onLoad()
    local shouldReloadMod = false
    
    ---@param warbandBag tts__Object
    ---@param color tts__PlayerColor
    for color, warbandBag in pairs(shared.playerWarbandBags) do
        -- make sure every warbandBag is given the proper tag
        if(not warbandBag.hasTag('WarbandBag') or not warbandBag.hasTag(color)) then
            warbandBag.addTag('WarbandBag')
            warbandBag.addTag(color)
            shouldReloadMod = true
        end
        Shared(warbandBag).color = color
    end
    
    if shouldReloadMod then
        InvokeEvent('OnActivateMod', 'SmartWarbands')
    end
end