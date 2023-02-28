
function onLoad()
  InvokeEvent('OnEnsurePluginActive', 'PlayerOwnershipZones')
end

---@param player tts__Player
---@param previous_player tts__Player
function onPlayerTurn(player, previous_player)
  if not player then
    return
  end

  local peoplesFavor = shared.peoplesFavor
  if IsOwnedByPlayer(peoplesFavor, player.color) then
    player.pingTable(peoplesFavor.getPosition())
    
    -- wait and ping once more with a message
    Wait.time(function()
      player.pingTable(peoplesFavor.getPosition())
      broadcastToColor("Remember to resolve the People's Favor", player.color, {0, 1, 1})
    end, 1)
  end
end

function IsOwnedByPlayer(inObject, playerColor)
  for _, object in ipairs(shared.playerOwnershipZones[playerColor].getObjects(true)) do
    if object.guid == inObject.guid then
      return true
    end
  end
  return false
end