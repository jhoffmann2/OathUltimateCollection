function Callback.SetupTurnOrder()
  shared.turnOrder = {
    "Purple",
    "Red",
    "Brown",
    "Blue",
    "Yellow",
    "White"
  }
  for i = 1, 100 do
    swapIndices(shared.turnOrder, math.random(2, 6), math.random(2, 6))
  end
  Turns.order = shared.turnOrder
end

function swapIndices(t, i, j)
  local temp = t[i]
  t[i] = t[j]
  t[j] = temp
end