
local handTransforms = {
  {
    position = Vector(-16.0913448, 1.05, 32.4),
    rotation = Vector(0.0, 180.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
  {
    position = Vector(13.435605, 1.05, 29.8299961),
    rotation = Vector(0.0, 180.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
  {
    position = Vector(47.2922668, 1.05, 4.84),
    rotation = Vector(0.0, 270.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
  {
    position = Vector(11.9127407, 1.05, -29.8299961),
    rotation = Vector(0.0, 0.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
  {
    position = Vector(-17.1396332, 1.05, -29.8299961),
    rotation = Vector(0.0, 0.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
  {
    position = Vector(-47.4030876, 1.05, 4.84),
    rotation = Vector(0.0, 90.0, 0.0),
    scale = Vector(15.332943, 7.780516, 6.37460375)
  },
}

local boardOrigins = {
  {
    position = Vector(-18.4, 0.96, 17.25),
    rotation = Vector(0.00, 0.00, 0.00),
  },
  {
    position = Vector(12.01, 0.96, 17.22),
    rotation = Vector(0.00, 0.00, 0.00),
  },
  {
    position = Vector(29.26, 0.96, 4.23),
    rotation = Vector(0.00, 90.00, 0.00),
  },
  {
    position = Vector(12.83, 0.96, -11.05),
    rotation = Vector(0.00, 180.00, 0.00),
  },
  {
    position = Vector(-16.53, 0.96, -11.06),
    rotation = Vector(0.00, 180.00, 0.00),
  },
  {
    position = Vector(-29.12, 0.96, 4.68),
    rotation = Vector(0.00, 270.00, 0.00),
  },
}

local handCardSpawnPositions = { { { -13.15, 2.97, 29.83 }, { -16.09, 3.07, 29.83 }, { -19.03, 3.17, 29.83 } },
                                 { { 16.38, 2.97, 29.83 }, { 13.44, 3.07, 29.83 }, { 10.49, 3.17, 29.83 } },
                                 { { 47.29, 2.97, 1.90 }, { 47.29, 3.07, 4.84 }, { 47.29, 3.17, 7.79 } },
                                 { { 8.97, 2.97, -29.83 }, { 11.91, 3.07, -29.83 }, { 14.85, 3.17, -29.83 } },
                                 { { -20.08, 2.97, -29.83 }, { -17.14, 3.07, -29.83 }, { -14.20, 3.17, -29.83 } },
                                 { { -47.40, 2.97, 7.78 }, { -47.40, 3.07, 4.84 }, { -47.40, 3.17, 1.90 } } }

local handCardYRotations = { 0.0, 0.0, 90.0, 180.0, 180.0, 270.0 }

local playerOwnershipZoneTransforms = {
  {
    position = Vector(-26.82, 0.00, 21.59),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(33.70, 12.00, 15.94)
  },
  {
    position = Vector(7.73, 0.00, 21.54),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(34.75, 12.00, 16.18)
  },
  {
    position = Vector(33.81, 0.00, 9.53),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(16.69, 12.00, 32.33)
  },
  {
    position = Vector(23.06, 0.00, -16.31),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(37.60, 12.00, 18.46)
  },
  {
    position = Vector(-10.36, 0.00, -16.48),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(28.77, 12.00, 18.77)
  },
  {
    position = Vector(-34.45, 0.00, -3.20),
    rotation = Vector(0.00, 0.00, 0.00),
    scale = Vector(18.77, 12.00, 32.35)
  },
}

-- for games with 4 or less players, don't seat index 3 or 6
local playerSeat

function onLoad()
  InvokeEvent('OnEnsureModActive', 'PlayerOwnershipZones')
end

function Callback.BeforeGameStart()
  SetupPlayerSeatIndices()
  local turnOrder = shared.turnOrder
  if turnOrder == nil then
    turnOrder = Turns.order
  end
  
  local playerTurnIndex = 1
  -- seat players that are playing
  for i, playerColor in ipairs(turnOrder) do
    if shared.curPlayerStatus[playerColor][2] then
      MovePlayerHand(playerColor, playerTurnIndex)
      playerTurnIndex = playerTurnIndex + 1
    end
  end
  -- seat players that aren't playing
  for i, playerColor in ipairs(turnOrder) do
    if not shared.curPlayerStatus[playerColor][2] then
      MovePlayerHand(playerColor, playerTurnIndex)
      playerTurnIndex = playerTurnIndex + 1
    end
  end
end


function Callback.OnGameStart()
  local turnOrder = shared.turnOrder
  if turnOrder == nil then
    turnOrder = Turns.order
  end

  local playerPieces = {}
  for i, playerColor in ipairs(turnOrder) do
    playerPieces[playerColor] = GetObjectsAndZonesInZone(shared.playerOwnershipZones[playerColor])
  end

  local playerTurnIndex = 1
  -- setup players that are playing
  for i, playerColor in ipairs(turnOrder) do
    if shared.curPlayerStatus[playerColor][2] then
      MovePlayerPieces(playerColor, playerTurnIndex, playerPieces[playerColor])
      playerTurnIndex = playerTurnIndex + 1
    end
  end
  -- setup players that aren't playing
  for i, playerColor in ipairs(turnOrder) do
    if not shared.curPlayerStatus[playerColor][2] then
      MovePlayerPieces(playerColor, playerTurnIndex, playerPieces[playerColor])
      playerTurnIndex = playerTurnIndex + 1
    end
  end
end

function MovePlayerHand(playerColor, playerTurnIndex)
  local seatIndex = playerSeat[playerTurnIndex]
  Player[playerColor].setHandTransform(handTransforms[seatIndex])
  shared.handCardSpawnPositions[playerColor] = handCardSpawnPositions[seatIndex]
  shared.handCardYRotations[playerColor] = handCardYRotations[seatIndex]
end

function MovePlayerPieces(playerColor, playerTurnIndex, pieces)
  local seatIndex = playerSeat[playerTurnIndex]
  local board = shared.playerBoards[playerColor]
  local boardPosition = board.getPosition()
  local boardRotation = board.getRotation()
  local deltaPosition = boardOrigins[seatIndex].position - boardPosition
  deltaPosition.y = 0
  local deltaRotation = boardOrigins[seatIndex].rotation - boardRotation

  for _, piece in ipairs(pieces) do
    local localPosition = piece.getPosition() - boardPosition
    Vector.rotateOver(localPosition, 'y', deltaRotation.y)
    localPosition = localPosition + deltaPosition
    
    local localRotation = piece.getRotation() - boardRotation
    localRotation.y = localRotation.y + deltaRotation.y
    
    piece.setPosition(localPosition + boardPosition)
    piece.setRotation(localRotation + boardRotation)
  end
  
  shared.playerOwnershipZones[playerColor].setPosition(playerOwnershipZoneTransforms[seatIndex].position)
  shared.playerOwnershipZones[playerColor].setRotation(playerOwnershipZoneTransforms[seatIndex].rotation)
  shared.playerOwnershipZones[playerColor].setScale(playerOwnershipZoneTransforms[seatIndex].scale)
end

function HidePlayerHand(playerColor)
  local transform = Player[playerColor].getHandTransform()
  transform.position.y = transform.position.y - 30
  Player[playerColor].setHandTransform(transform)
end

function SetupPlayerSeatIndices()
  local turnOrder = shared.turnOrder
  if turnOrder == nil then
    turnOrder = Turns.order
  end
  
  local playerCount = 0
  for i, playerColor in ipairs(turnOrder) do
    if (true == shared.curPlayerStatus[playerColor][2]) then
      playerCount = playerCount + 1
    end
  end

  -- seat active players in the most convenient seats to see the board
  if playerCount == 2 then
    playerSeat = {1,5   ,2,3,4,6}
    return
  end
  
  if playerCount == 3 then
    playerSeat = {1,4,5   ,2,3,6}
    return
  end
  
  if playerCount == 4 then
    playerSeat = {1,2,4,5    ,3,6}
    return
  end
  
  if playerCount == 5 then
    playerSeat = {1,2,3,4,5    ,6}
    return
  end

  playerSeat = {1,2,3,4,5,6}
end

---@param obj tts__Object
function GetObjectAABB(obj)
  local bounds = obj.getBounds()
  bounds.size.x = math.max(bounds.size.x, obj.getScale().x)
  bounds.size.y = math.max(bounds.size.y, obj.getScale().y)
  bounds.size.z = math.max(bounds.size.z, obj.getScale().z)

  return {
    min = Vector(
        bounds.center.x - (bounds.size.x / 2),
        bounds.center.y - (bounds.size.y / 2),
        bounds.center.z - (bounds.size.z / 2)
    ),
    max = Vector(
        bounds.center.x + (bounds.size.x / 2),
        bounds.center.y + (bounds.size.y / 2),
        bounds.center.z + (bounds.size.z / 2)
    ),
  }
end

function AABBIntersect(a, b, ignoreY)
  return (a.min.x <= b.max.x and a.max.x >= b.min.x) and
         (ignoreY or (a.min.y <= b.max.y and a.max.y >= b.min.y)) and
         (a.min.z <= b.max.z and a.max.z >= b.min.z)
end

function pointInAABB(a, p, ignoreY)
  return (p.x >= a.min.x and p.x <= a.max.x) and
         (ignoreY or (p.y >= a.min.y and p.y <= a.max.y)) and
         (p.z >= a.min.z and p.z <= a.max.z)
end

---@param zone tts__Object
function GetObjectsAndZonesInZone(zone)
  local objectsInZone = {}
  local zoneAABB = GetObjectAABB(zone)

  for _, obj in ipairs(getObjects()) do
    if obj.guid ~= zone.guid and not zone.hasTag('ScriptRunner') then
      --objAABB = GetObjectAABB(obj)
      if(pointInAABB(zoneAABB, obj.getPosition(), true)) then
        table.insert(objectsInZone, obj)
      end
    end
  end
  
  return objectsInZone
end