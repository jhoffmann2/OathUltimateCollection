local roundMarkerPositions = {
  {-20.86, 1.06, -1.83},
  {-19.70, 1.06, -2.70},
  {-19.77, 1.06, -4.11},
  {-20.86, 1.06, -5.19},
  {-22.14, 1.06, -5.19},
  {-23.49, 1.06, -4.21},
  {-23.46, 1.06, -2.66},
  {-22.15, 1.06, -1.70}
}

local roundMarkerGuid = "c1f67a"
--- @type tts__Object
local roundMarker = nil
local lastRememberedRound = 1
local lastTurnWasDrafting = false

local purpleDiePos = {-21.60, 1.56, -3.46}
local purpleDieRotations = {
  {270.00, 0.00, 0.00},
  {0.00, 0.00, 0.00},
  {0.00, 0.00, 270.00},
  {0.00, 0.00, 90.00},
  {0.00, 0.00, 180.00},
  {90.00, 0.00, 0.00}
}
local purpleDieGuid = "8e1eb3"
--- @type tts__Object
local purpleDie = nil

function onLoad()
  roundMarker = getObjectFromGUID(roundMarkerGuid)
  roundMarker.setLock(true)
end

function Callback.OnGameStart()
  lastTurnWasDrafting = true

  --purpleDie = getObjectFromGUID(purpleDieGuid)
  --purpleDie.setPosition(purpleDiePos)
end

function onPlayerTurn(player, previous_player)
  -- only move round counter if we're not in the drafting phase
  if not lastTurnWasDrafting then
    if player and player.color == "Purple" then
      local round = GetNextRound()
      roundMarker.setPositionSmooth(roundMarkerPositions[round])
      --if round >= 6 then
      --  RollPurpleDie()
      --end 
    end
  else
    lastTurnWasDrafting = CardsInHands()
  end
end

function RollPurpleDie()
  startLuaCoroutine(self, "RollPurpleDieCoroutine")
end

function RollPurpleDieCoroutine()
  local function YieldForTime(seconds)
    local finished = false
    Wait.time(
        function()
          finished = true
        end,
        seconds
    )
    while not finished do
      coroutine.yield(0)
    end
  end
  purpleDie.setPosition(purpleDiePos)
  for i = 1, 10 do
    purpleDie.setRotationSmooth(purpleDieRotations[math.random(1, 6)], false, true)
    YieldForTime(.2)
  end
  return 1
end

function FloatApproxEqual(f1, f2)
  return math.abs(f1 - f2) < 0.01 
end

function VecApproxEqual(v1, v2)
  for i = 1, 3 do
    if not FloatApproxEqual(v1[i], v2[i]) then
      return false
    end
  end
  return true
end

-- return true if any players have cards in their hand
function CardsInHands()
  --- @param player tts__Player
  for _, playerColor in ipairs(Player.getAvailableColors()) do
    if #Player[playerColor].getHandObjects() > 0 then
      return true
    end
  end
  return false
end

function GetRound()
  for round, pos in ipairs(roundMarkerPositions) do
    if VecApproxEqual(pos, roundMarker.getPosition()) then
      return round
    end
  end
  return nil
end

function GetNextRound()
  local calculatedRound = GetRound()
  if calculatedRound then
    lastRememberedRound = calculatedRound + 1
  else
    lastRememberedRound = lastRememberedRound + 1
  end
  
  -- clamp round to <= 8
  if lastRememberedRound > 8 then
    lastRememberedRound = 8
  end
  
  return lastRememberedRound
end
