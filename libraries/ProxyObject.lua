---@param ttsObjectTable tts__Object[]
---@return ProxyObject[]
local function ProxyObjectTable(ttsObjectTable)
  if ttsObjectTable == nil then
    return nil
  end
  
  local t = {};
  for _, ttsObject in ipairs(ttsObjectTable) do
    table.insert(t, ProxyObject(ttsObject))
  end
  return t
end
---@param inTable table
---@return ProxyObject[] | table[]
local function MaybeProxyObjectTable(inTable)
  if inTable == nil then
    return nil
  end
  
  local t = {};
  for _, v in ipairs(inTable) do
    if(type(v) == 'userdata') then
      table.insert(t, ProxyObject(v))
    else
      table.insert(t, v)
    end
  end
  return t
end

---@param proxyObjectTable ProxyObject[]
---@return tts__Object[]
local function TTSObjectTable(proxyObjectTable)
  local t = {};
  for _, proxyObject in ipairs(proxyObjectTable) do
    table.insert(t, proxyObject.ttsObject)
  end
  return t
end

local function UnShared(t)
  if(type(t) == 'SharedData') then
    t = getmetatable(t).data()
  end
  return t
end

local function UnSharedRecursive(t)
  local valType = type(t)
  if(valType == 'table' or valType == 'SharedData') then
    local result = {}
    for k,v in pairs(t) do
      result[k] = UnSharedRecursive(v)
    end
    return result
  end
  
  return t
end

---@param object tts__Object
---@return ProxyObject
function ProxyObject(object)
  if (object == nil) then
    return nil
  end

  -- ensure that the type is userdata
  if (not type(object) == 'userdata') then
    printToAll('ProxyObject only accepts userdata Objects', { 1, 0, 0 })
    return nil
  end

  ---@class ProxyObject

  local mt = {
    ---@type tts__Object
    ttsObject = object,

    self = { __type = 'ProxyObject', __ttsObject = object },

    ---@type function[]
    __get = {},

    ---@type function[]
    __set = {},
  }

  
  ---@return ProxyObject
  function mt.__get.remainder()
    return ProxyObject(mt.ttsObject.remainder)
  end

  ---@param v ProxyObject
  function mt.__set.remainder(v)
    mt.ttsObject.remainder = v.ttsObject
  end

  function mt.__get.tag()
    printToAll("tag is deprecated. Use type instead", {1,0,0})
    return mt.ttsObject.tag
  end
  function mt.__set.tag(v)
    printToAll("tag is deprecated. Use type instead", {1,0,0})
    mt.ttsObject.tag = v
  end

  function mt.__get.value_flags()
    printToAll("value_flags is deprecated. Use value_flags instead", {1,0,0})
    return mt.ttsObject.value_flags
  end
  function mt.__set.value_flags(v)
    printToAll("value_flags is deprecated. Use value_flags instead", {1,0,0})
    mt.ttsObject.value_flags = v
  end
  
  
  function mt.__get.destroyed()
    return mt.ttsObject == nil
  end
  

  ---@param vector tts__VectorShape
  ---@param force_type number
  ---@return boolean
  function mt.addForce(vector, force_type)
    return mt.ttsObject.addForce(UnShared(vector), force_type)
  end

  ---@param vector tts__VectorShape
  ---@param force_type number
  ---@return boolean
  function mt.addTorque(vector, force_type)
    return mt.ttsObject.addTorque(UnShared(vector), force_type)
  end

  ---@param vector tts__VectorShape
  ---@return tts__VectorShape
  function mt.positionToLocal(vector)
    return mt.ttsObject.positionToLocal(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@return tts__VectorShape
  function mt.positionToWorld(vector)
    return mt.ttsObject.positionToWorld(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.rotate(vector)
    return mt.ttsObject.rotate(UnShared(vector))
  end

  ---@param v tts__VectorShape | number
  ---@return boolean
  function mt.scale(v)
    return mt.ttsObject.scale(UnShared(v))
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.setAngularVelocity(vector)
    return mt.ttsObject.setAngularVelocity(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.setPosition(vector)
    return mt.ttsObject.setPosition(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@param collide boolean
  ---@param fast boolean
  ---@return boolean
  function mt.setPositionSmooth(vector, collide, fast)
    return mt.ttsObject.setPositionSmooth(UnShared(vector), collide, fast)
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.setRotation(vector)
    return mt.ttsObject.setRotation(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@param collide boolean
  ---@param fast boolean
  ---@return boolean
  function mt.setRotationSmooth(vector, collide, fast)
    return mt.ttsObject.setRotationSmooth(UnShared(vector), collide, fast)
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.setScale(vector)
    return mt.ttsObject.setScale(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.setVelocity(vector)
    return mt.ttsObject.setVelocity(UnShared(vector))
  end

  ---@param vector tts__VectorShape
  ---@return boolean
  function mt.translate(vector)
    return mt.ttsObject.translate(UnShared(vector))
  end

  ---@param tag string
  ---@return boolean
  function mt.addTag(tag)
    local hadTag = mt.ttsObject.hasTag(tag)
    local result = mt.ttsObject.addTag(tag)
    if not hadTag then
      InvokeEvent('OnObjectTagged', mt.self, tag)
    end
    return result
  end

  ---@param tag string
  ---@return boolean
  function mt.removeTag(tag)
    if not mt.ttsObject then
      return
    end
    local hadTag = mt.ttsObject.hasTag(tag)
    local result = mt.ttsObject.removeTag(tag)

    if hadTag then
      InvokeEvent('OnObjectUntagged', mt.self, tag)
    end
    return result
  end

  ---@param tag string
  ---@return boolean
  function mt.setTags(tags)
    local prev_tags = mt.ttsObject.getTags()
    if mt.ttsObject.setTags(UnShared(tags)) then

      local tagsToRemove = {}
      for _, tag in ipairs(prev_tags) do
        tagsToRemove[tag] = true
      end
      for _, tag in ipairs(tags) do
        tagsToRemove[tag] = nil
      end
      for tag, _ in pairs(tagsToRemove) do
        InvokeEvent('OnObjectUntagged', mt.self, tag)
      end

      local tagsToAdd = {}
      for _, tag in ipairs(tags) do
        tagsToAdd[tag] = true
      end
      for _, tag in ipairs(prev_tags) do
        tagsToAdd[tag] = nil
      end
      for tag, _ in pairs(tagsToAdd) do
        InvokeEvent('OnObjectTagged', mt.self, tag)
      end

      return true
    end
    return false
  end

  ---@param parameters tts__CreateButtonParameters
  ---@return boolean
  function mt.createButton(parameters)
    return mt.ttsObject.createButton(UnSharedRecursive(parameters))
  end

  ---@param parameters table
  ---@return boolean
  function mt.createInput(parameters)
    return mt.ttsObject.createInput(UnSharedRecursive(parameters))
  end

  ---@param parameters tts__EditButtonParameters
  ---@return boolean
  function mt.editButton(parameters)
    return mt.ttsObject.editButton(UnSharedRecursive(parameters))
  end

  ---@param parameters table
  ---@return boolean
  function mt.editInput(parameters)
    return mt.ttsObject.editInput(UnSharedRecursive(parameters))
  end

  ---@return nil | ProxyObject[] | tts__IndexedSimpleObjectState[]
  function mt.getObjects()
    return MaybeProxyObjectTable(mt.ttsObject.getObjects())
  end

  ---@param color tts__Color
  ---@return boolean
  function mt.setColorTint(color)
    return mt.ttsObject.setColorTint(UnShared(color))
  end

  ---@param rotation_values table
  ---@return boolean
  function mt.setRotationValues(rotation_values)
    return mt.ttsObject.setRotationValues(UnSharedRecursive(rotation_values))
  end

  ---@param state_id number
  ---@return ProxyObject
  function mt.setState(state_id)
    return ProxyObject(mt.ttsObject.setState(state_id))
  end

  ---@param inObject ProxyObject
  ---@return boolean
  function mt.addAttachment(inObject)
    return mt.ttsObject.addAttachment(inObject.ttsObject)
  end

  ---@param parameters table
  ---@return ProxyObject
  function mt.clone(parameters)
    return ProxyObject(mt.ttsObject.clone(UnSharedRecursive(parameters)))
  end

  ---@param offset tts__VectorShape
  ---@param flip boolean
  ---@param player_color string
  ---@return ProxyObject
  function mt.dealToColorWithOffset(offset, flip, player_color)
    return ProxyObject(mt.ttsObject.dealToColorWithOffset(UnShared(offset), flip, player_color))
  end

  ---@param color tts__ColorShape
  ---@return boolean
  function mt.highlightOff(color)
    return mt.ttsObject.highlightOff(UnShared(color))
  end

  ---@param color tts__ColorShape
  ---@param duration number
  ---@return boolean
  function mt.highlightOn(color, duration)
    return mt.ttsObject.highlightOn(UnShared(color), duration)
  end

  ---@param inObject ProxyObject
  ---@param parameters tts__JointParameters
  ---@return boolean
  function mt.jointTo(inObject, parameters)
    return mt.ttsObject.jointTo(inObject.ttsObject, UnSharedRecursive(parameters))
  end

  ---@param inObject ProxyObject
  ---@return ProxyObject
  function mt.putObject(inObject)
    return ProxyObject(mt.ttsObject.putObject(inObject.ttsObject))
  end

  ---@return ProxyObject
  function mt.reload()
    return ProxyObject(mt.ttsObject.reload())
  end

  ---@param index number
  ---@return ProxyObject
  function mt.removeAttachment(index)
    return ProxyObject(mt.ttsObject.removeAttachment(index))
  end

  ---@param index number
  ---@return ProxyObject[]
  function mt.removeAttachments()
    return ProxyObjectTable(mt.ttsObject.removeAttachments())
  end

  ---@return ProxyObject
  function mt.shuffleStates()
    return ProxyObject(mt.ttsObject.shuffleStates())
  end

  ---@param piles number
  ---@return ProxyObject[]
  function mt.split(piles)
    return ProxyObjectTable(mt.ttsObject.split(piles))
  end

  ---@param distance number
  ---@return ProxyObject[]
  function mt.spread(distance)
    return ProxyObjectTable(mt.ttsObject.spread(distance))
  end

  ---@param parameters tts__Object_TakeObjectParameters
  ---@return ProxyObject
  function mt.takeObject(parameters)
    return ProxyObject(mt.ttsObject.takeObject(UnSharedRecursive(parameters)))
  end

  ---@param players tts__PlayerColor[]
  ---@return boolean
  function mt.setHiddenFrom(players)
    return mt.ttsObject.setHiddenFrom(UnShared(players))
  end

  ---@param players tts__PlayerColor[]
  ---@return boolean
  function mt.setInvisibleTo(players)
    return mt.ttsObject.setInvisibleTo(UnShared(players))
  end

  ---@param id string
  ---@param hidden boolean
  ---@param players tts__PlayerColor[]
  ---@return boolean
  function mt.attachHider(id, hidden, players)
    return mt.ttsObject.attachHider(id, hidden, UnShared(players))
  end

  ---@param id string
  ---@param hidden boolean
  ---@param players tts__PlayerColor[]
  ---@return boolean
  function mt.attachInvisibleHider(id, hidden, players)
    return mt.ttsObject.attachInvisibleHider(id, hidden, UnShared(players))
  end

  ---@param parameters table
  ---@return boolean
  function mt.addDecal(parameters)
    return mt.ttsObject.addDecal(UnSharedRecursive(parameters))
  end

  ---@param parameters table
  ---@return boolean
  function mt.setDecals(parameters)
    return mt.ttsObject.setDecals(UnSharedRecursive(parameters))
  end

  ---@param parameters tts__Object_SnapPointParameters
  ---@return boolean
  function mt.setSnapPoints(snap_points)
    return mt.ttsObject.setSnapPoints(UnSharedRecursive(snap_points))
  end

  ---@param parameters tts__Object_VectorLineParameters
  ---@return boolean
  function mt.setVectorLines(parameters)
    return mt.ttsObject.setVectorLines(UnSharedRecursive(parameters))
  end
  
  function mt.getPosition()
    local vector = mt.ttsObject.getPosition()
    return vector
  end

  function mt.__index(t, k)
    if (mt[k] ~= nil) then
      return mt[k]
    end
    if (mt.__get[k] ~= nil) then
      return mt.__get[k]()
    end
    return mt.ttsObject[k]
  end

  function mt.__newindex(t, k, v)
    if (mt[k] ~= nil) then
      mt[k] = v;
      return
    end
    if (mt.__set[k] ~= nil) then
      mt.__set[k](v)
      return
    end
    mt.ttsObject[k] = v
    return
  end

  -- return a table that can be passed through events and be decompressed on the other side
  function mt.__compress(t)
    return {
      __compressed_type = 'ProxyObject',
      __decompress = {
        func = 'getObjectFromGUID',
        params = { t.ttsObject.guid }
      },
    }
  end

  return setmetatable(mt.self, mt)
end

local _copy = copy
---@param objects ProxyObject[]
---@return boolean
function copy(objects)
  return _copy(TTSObjectTable(objects))
end

local _destroyObject = destroyObject
---@param obj ProxyObject
---@return boolean
function destroyObject(obj)
  return _destroyObject(obj.ttsObject)
end

local _getObjectFromGUID = getObjectFromGUID
---@param guid string
---@return ProxyObject
function getObjectFromGUID(guid)
  return ProxyObject(_getObjectFromGUID(guid))
end

local _getObjects = getObjects
---@return ProxyObject[]
function getObjects()
  return ProxyObjectTable(_getObjects())
end

local _getObjects = getObjects
---@return ProxyObject[]
function getAllObjects()
  printToAll("getAllObjects() is deprecated. Use getObjects() instead", { 1, 0, 0 })
  return ProxyObjectTable(_getObjects())
end

local _getObjectsWithTag = getObjectsWithTag
---@param tag string
---@return ProxyObject[]
function getObjectsWithTag(tag)
  return ProxyObjectTable(_getObjectsWithTag(tag))
end

local _getObjectsWithAnyTags = getObjectsWithAnyTags
---@param tags string[]
---@return ProxyObject[]
function getObjectsWithAnyTags(tags)
  return ProxyObjectTable(_getObjectsWithAnyTags(UnShared(tags)))
end

local _getObjectsWithAllTags = getObjectsWithAllTags
---@param tags string[]
---@return ProxyObject[]
function getObjectsWithAllTags(tags)
  return ProxyObjectTable(_getObjectsWithAllTags(UnShared(tags)))
end

local _group = group
---@param objects ProxyObject[]
---@return ProxyObject[]
function group(objects)
  return ProxyObjectTable(_group(TTSObjectTable(objects)))
end

local _paste = paste
---@return ProxyObject[]
function paste(parameters)
  return ProxyObjectTable(_paste(UnSharedRecursive(parameters)))
end

local _spawnObject = spawnObject
---@param parameters tts__SpawnObjectParams
---@return ProxyObject
function spawnObject(parameters)
  local _callback_function = parameters.callback_function
  if _callback_function then
    parameters.callback_function = function(spawnedObject)
      _callback_function(ProxyObject(spawnedObject))
    end
  end
  
  return ProxyObject(_spawnObject(UnSharedRecursive(parameters)))
end

local _spawnObjectData = spawnObjectData
---@param parameters tts__SpawnObjectDataParams
---@return ProxyObject
function spawnObjectData(parameters)
  local _callback_function = parameters.callback_function
  if _callback_function then
    parameters.callback_function = function(spawnedObject)
      _callback_function(ProxyObject(spawnedObject))
    end
  end

  return ProxyObject(_spawnObjectData(UnSharedRecursive(parameters)))
end

local _spawnObjectJSON = spawnObjectJSON
---@param parameters tts__SpawnObjectJSONParams
---@return ProxyObject
function spawnObjectJSON(parameters)
  local _callback_function = parameters.callback_function
  if _callback_function then
    parameters.callback_function = function(spawnedObject)
      _callback_function(ProxyObject(spawnedObject))
    end
  end

  return ProxyObject(_spawnObjectJSON(UnSharedRecursive(parameters)))
end


local _ColorNew = Color.new
function Color.new(...)
  if select('#', ...) == 1 then
    -- single parameter overload is a table. make sure it's unshared
    return _ColorNew(UnShared(select(1, ...)))
  end
  return _ColorNew(...)
end


local _VectorNew = Vector.new
function Vector.new(...)
  if select('#', ...) == 1 then
    -- single parameter overload is a table. make sure it's unshared
    return _VectorNew(UnShared(select(1, ...)))
  end
  return _VectorNew(...)
end

local _jsonEncode = JSON.encode
---@overload fun(value: table | string | number | boolean)
---@param value table | string | number | boolean
---@param etc any @Unused
---@param options tts__JSON__EncodeOptions
---@return string
function JSON.encode(value, etc, options)
  return _jsonEncode(UnSharedRecursive(value), etc, UnSharedRecursive(options))
end

local _jsonEncodePretty = JSON.encode_pretty
---@param value table | string | number | boolean
---@param etc any @Unused
---@param options tts__JSON__EncodeOptions
---@return string
function JSON.encode_pretty(value, etc, options)
  return _jsonEncodePretty(UnSharedRecursive(value), etc, UnSharedRecursive(options))
end

local _Lighting = Lighting
local lightingOverloads = {}
local lightingMetatable = {}

function lightingMetatable.__index(t,k)
  v = lightingOverloads[k]
  if v then
    return v
  end
  
  return _Lighting[k]
end

function lightingMetatable.__newindex(t,k,v)
  _Lighting[k] = v
end

---@param tint tts__Color
---@return boolean
function lightingOverloads.setAmbientEquatorColor(tint)
  return _Lighting.setAmbientEquatorColor(UnShared(tint))
end

---@param tint tts__Color
---@return boolean
function lightingOverloads.setAmbientGroundColor(tint)
  return _Lighting.setAmbientGroundColor(UnShared(tint))
end

---@param tint tts__Color
---@return boolean
function lightingOverloads.setAmbientSkyColor(tint)
  return _Lighting.setAmbientSkyColor(UnShared(tint))
end

---@param tint tts__Color
---@return boolean
function lightingOverloads.setLightColor(tint)
  return _Lighting.setLightColor(UnShared(tint))
end

Lighting = setmetatable({}, lightingMetatable)

local _Physics = Physics
local physicsOverloads = {}
local physicsMetatable = {}

function physicsMetatable.__index(t,k)
  v = physicsOverloads[k]
  if v then
    return v
  end

  return _Physics[k]
end

function physicsMetatable.__newindex(t,k,v)
  _Physics[k] = v
end

--- Returns an array (of up to 1000) intersections.
---@param parameters tts__Physics_CastRayParameters | tts__Physics_CastSphereParameters | tts__Physics_CastBoxParameters
---@return tts__Physics_CastResult[]
function physicsOverloads.cast(parameters)
  return _Physics.cast(UnSharedRecursive(parameters))
end

Physics = setmetatable({}, physicsMetatable)


-- redefine owner because SharedData may have been included before this
owner = [[##OWNER##]]

--TODO: find a way to wrap self without breaking UI
--self = ProxyObject(self)
