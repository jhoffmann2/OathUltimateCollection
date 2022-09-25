
local defaultTurnOrder = {
  "Purple",
  "Red",
  "Brown",
  "Blue",
  "Yellow",
  "White"
}

function onLoad(savedTurnOrder)
  if (savedTurnOrder) then
    shared.turnOrder = JSON.decode(savedTurnOrder)
  else
    shared.turnOrder = defaultTurnOrder
  end
  Turns.order = shared.turnOrder
end

function onSave()
  return JSON.encode(shared.turnOrder)
end

function Callback.OnGameStart()
  Wait.frames(
    function()
      Turns.turn_color = "Purple"
      Turns.enable = true
    end,
    2
  )
end
