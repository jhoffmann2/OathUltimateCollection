
function onLoad()
  shared.turnOrder = {
    "Purple",
    "Red",
    "Brown",
    "Blue",
    "Yellow",
    "White"
  }
  Turns.order = shared.turnOrder
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