--
--function onLoad(save_string)
--  local save_data = {}
--  if save_string then
--    save_data = JSON.encode(save_string)
--  end
--  
--  if save_data.turnOrder then
--    shared.turnOrder = save_data.turnOrder
--  else
--    shared.turnOrder = {
--      "Purple",
--      "Red",
--      "Brown",
--      "Blue",
--      "Yellow",
--      "White"
--    }
--  end
--  
--  if shared.isGameInProgress then
--    print('enabling turns')
--    Turns.enable = true
--    --Turns.order = shared.turnOrder
--    if save_data.turnColor then
--      Turns.turn_color = save_data.turnColor
--    end
--  end
--end
--
--function onSave()
--  return JSON.encode({
--    turnColor = Turns.turn_color,
--    turnOrder = shared.turnOrder
--  })
--end

function Callback.OnGameStart()
  Wait.time(function()
      Turns.enable = true
      Turns.turn_color = "Purple"
    end,
    1
  )
end