
local favorStackOffset = Vector(-6.2, 0.1, 1.08)
local secretStackOffset = Vector(-6.2, 0.2, -0.76)


function Callback.OnPlayerPiecesShown(color)
  if (color == shared.playerColor) then
    OnShown()
  end
end

function onLoad(save_string)
  globalData = Shared(Global)

  local save_data = {}
  if save_string and save_string ~= '' then
    save_data = JSON.decode(save_string)
  end

  if shared.warbandBag == nil then
    shared.warbandBag = globalData.playerWarbandBags[shared.playerColor]
  end

  if shared.supplyMarker == nil then
    shared.supplyMarker = globalData.playerSupplyMarkers[shared.playerColor]
  end

  if shared.supplyZones == nil then
    ---@type tts__Object[]
    shared.supplyZones = globalData.playerSupplyZones[shared.playerColor]
  end

  function GetSavedData(name, default)
    if save_data[name] ~= nil then
      return save_data[name]
    end
    return default
  end
  
  function GetSavedObject(name)
    local guid = GetSavedData(name..'GUID')
    if guid ~= nil then
      return getObjectFromGUID(guid)
    end
    return nil
  end

  shared.secretZone = GetSavedObject('secretZone')
  shared.favorZone = GetSavedObject('favorZone')
  
end

function onSave()
  local save_data = {}
  
  function SaveData(name, val)
    save_data[name] = val
  end
  
  function SaveObject(name, val)
    if val ~= nil then
      save_data[name..'GUID'] = val.guid
    else
      save_data[name..'GUID'] = nil
    end
  end

  SaveObject('secretZone', shared.secretZone)
  SaveObject('favorZone', shared.favorZone)
  
  return JSON.encode(save_data)
end

function OnShown()
  SetupFavorAndSecretZones()
end

function Method.OffsetToPosition(boardOffset)
  local rotation = Method.GetXYRotation()
  local result = Vector.new(boardOffset)
  Vector.rotateOver(result, 'y', rotation.y)
  result = result + owner.getPosition()
  return result
end

function FavorStackPosition()
  return Method.OffsetToPosition(favorStackOffset)
end

function SecretStackPosition()
  return Method.OffsetToPosition(secretStackOffset)
end

function SetupFavorAndSecretZones()
  if shared.favorZone == nil then
    shared.favorZone = spawnObject({
      type = "ScriptingTrigger",
    })
  end
  if shared.secretZone == nil then
    shared.secretZone = spawnObject({
      type = "ScriptingTrigger",
    })
  end

  local rotation = Method.GetXYRotation()
  local scale = Vector(1.8, 5.10, 1.8)
  local favorZonePosition = FavorStackPosition()
  favorZonePosition.y = favorZonePosition.y + (scale.y / 2)
  
  local secretZonePosition = SecretStackPosition()
  secretZonePosition.y = secretZonePosition.y + (scale.y / 2)

  shared.favorZone.setPosition(favorZonePosition)
  shared.favorZone.setScale(scale)
  shared.favorZone.setRotation(rotation)
  
  shared.secretZone.setPosition(secretZonePosition)
  shared.secretZone.setScale(scale)
  shared.secretZone.setRotation(rotation)
end

-- return the amount of action supply that this player has
function Method.GetPlayerSupply()
  for i, zone in ipairs(shared.supplyZones) do
    for j, object in ipairs(zone.getObjects(true)) do
      if (object.guid == shared.supplyMarker.guid) then
        return i - 1;
      end
    end
  end
  return 0
end

function Method.GetSecretReturnPosition(count)
  if count == nil then
    count = 1
  end
  
  local secretHeight = 0.5
  local output = Vector(SecretStackPosition())
  for _, object in ipairs(shared.secretZone.getObjects(true)) do
    output.y = math.max(output.y, object.getPosition().y + object.getScale().y / 2)
  end
  output.y = output.y + (count * secretHeight)
  return output
end

function Method.GetFavorReturnPosition(suit, count)
  if count == nil then
    count = 1
  end
  
  local zone
  if suit then
    zone = globalData.suitFavorZones[suit]
  else
    -- if no suit was provided, put favor on the player board
    zone = shared.favorZone
  end

  local favorHeight = 0.2
  local output = Vector(zone.getPosition())
  output.y = FavorStackPosition().y
  for _, object in ipairs(zone.getObjects(true)) do
    output.y = math.max(output.y, object.getPosition().y + object.getScale().y / 2)
  end
  output.y = output.y + (count * favorHeight)
  return output
end

function Method.GetXYRotation()
  local output = owner.getRotation()
  output.z = 0
  return output
end

function Method.ReturnSecret(secret)
  
end
