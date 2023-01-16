local globalData
local visionCounterGUID = "a7e6d2"
local visionCounterPositions = {
  {-17.45, 1.38, -2.09},
  {-15.76, 1.38, -2.09},
  {-14.73, 1.38, -2.09},
  {-13.20, 1.38, -2.09},
  {-12.16, 1.38, -2.09},
  {-11.13, 1.38, -2.09}
}

function onLoad()
  globalData = Shared(Global)
end

function Method.OnNumberTyped(player_color, number)
  for i = 1, number do
    local card = owner.takeObject({top = true})
    card.deal(1, player_color)
    if globalData.cardsTable[card.getName()].cardtype == "Vision" then
      InvokeEvent("OnVisionDrawn", player_color, card)
      break
    end
  end
  
  return true
end 

function Callback.OnVisionDrawn(player_color, vision)
  local visionCounter = getObjectFromGUID(visionCounterGUID)
  local visionCount = 5
  for _, card in ipairs(owner.getObjects()) do
    if globalData.cardsTable[card.name].cardtype == "Vision" then
      visionCount = visionCount - 1
    end
  end
  visionCounter.setPositionSmooth(visionCounterPositions[visionCount + 1])
end