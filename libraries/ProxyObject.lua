
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

    self = {},

    __type = 'ProxyObject',

    ---@type function[]
    __get = {},

    ---@type function[]
    __set = {},
  }

  ---@param tag string
  ---@return boolean
  function mt.addTag(tag,...)
    local hadTag = mt.ttsObject.hasTag(tag)
    local result = mt.ttsObject.addTag(tag,...)
    
    if not hadTag then
      InvokeEvent('OnObjectTagged', mt.self, tag)
    end
    return result
  end

  function mt.removeTag(tag,...)
    local hadTag = mt.ttsObject.hasTag(tag)
    local result = mt.ttsObject.removeTag(tag,...)

    if hadTag then
      InvokeEvent('OnObjectUntagged', mt.self, tag)
    end
    return result
  end

  function mt.setState(...)
    return ProxyObject(mt.ttsObject.setState(...))
  end

  function mt.addAttachment(inObject,...)
    return mt.ttsObject.addAttachment(inObject.ttsObject,...)
  end

  function mt.clone(...)
    return ProxyObject(mt.ttsObject.clone(...))
  end

  function mt.dealToColorWithOffset(...)
    return ProxyObject(mt.ttsObject.dealToColorWithOffset(...))
  end

  function mt.jointTo(inObject, ...)
    return mt.ttsObject.jointTo(inObject.ttsObject, ...)
  end

  function mt.putObject(inObject, ...)
    return ProxyObject(mt.ttsObject.putObject(inObject.ttsObject, ...))
  end

  function mt.reload(...)
    return ProxyObject(mt.ttsObject.reload(...))
  end

  function mt.removeAttachment(...)
    return ProxyObject(mt.ttsObject.removeAttachment(...))
  end

  function mt.shuffleStates(...)
    return ProxyObject(mt.ttsObject.shuffleStates(...))
  end

  function mt.takeObject(...)
    return ProxyObject(mt.ttsObject.takeObject(...))
  end

  ---@param tag string
  ---@return boolean
  function mt.setTags(tags)
    local prev_tags = mt.ttsObject.getTags()
    if mt.ttsObject.setTags(tags) then
      print(type(mt.self) .. '.setTags("' .. JSON.encode(tags) .. '")')

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

  ---@return ProxyObject
  function mt.__get.remainder()
    return ProxyObject(mt.ttsObject.remainder)
  end

  ---@param v ProxyObject
  function mt.__set.remainder(v)
    mt.ttsObject.remainder = v.ttsObject
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

---@param ttsObjectTable tts__Object[]
---@return ProxyObject[]
local function ProxyObjectTable(ttsObjectTable)
  local t = {};
  for _, ttsObject in ipairs(ttsObjectTable) do
    table.insert(t, ProxyObject(ttsObject))
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
  return ProxyObjectTable(_getObjectsWithAnyTags(tags))
end

local _getObjectsWithAllTags = getObjectsWithAllTags
---@param tags string[]
---@return ProxyObject[]
function getObjectsWithAllTags(tags)
  return ProxyObjectTable(_getObjectsWithAllTags(tags))
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
  return ProxyObjectTable(_paste(parameters))
end

local _spawnObject = spawnObject
---@return ProxyObject
function spawnObject(parameters)
  return ProxyObject(_spawnObject(parameters))
end

local _spawnObjectData = spawnObjectData
---@return ProxyObject
function spawnObjectData(parameters)
  return ProxyObject(_spawnObjectData(parameters))
end

local _spawnObjectJSON = spawnObjectJSON
---@return ProxyObject
function spawnObjectJSON(parameters)
  return ProxyObject(_spawnObjectJSON(parameters))
end

-- redefine owner because SharedData may have been included before this
owner = [[##OWNER##]]

--TODO: find a way to wrap self without breaking UI
--self = ProxyObject(self)
