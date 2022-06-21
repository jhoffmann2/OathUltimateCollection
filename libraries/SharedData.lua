local _rawtableinsert = table.insert
function table.insert(...)
  local table = nil
  local pos = nil
  local val = nil
  if select('#', ...) == 2 then
    table = select(1, ...)
    pos = #table + 1
    val = select(2, ...)
  else
    table = select(1, ...)
    pos = select(2, ...)
    val = select(3, ...)
  end

  -- shift everything over
  for i = #table, pos, -1 do
    table[i + 1] = table[i]
  end

  table[pos] = val
end

local function _dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. _dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local function _shallowCopy(original)
  local copy = {}
  for key, value in pairs(original) do
    copy[key] = value
  end
  return copy
end

function Shared(obj, layers)

  -- if obj is a ProxyObject, remove the proxy
  if (type(obj) == 'ProxyObject') then
    obj = obj.ttsObject
  end

  if layers == nil then
    layers = {}
  end

  local mt = {
    __type = 'SharedData'
  }

  function mt.__index(t, k)
    local allLayers = _shallowCopy(layers)
    table.insert(allLayers, k)

    local v = obj.getVar(allLayers[1])
    for i, layer in ipairs(allLayers) do
      if i ~= 1 then
        -- first element is handled above
        v = v[layer]
      end
    end

    if (type(v) == "userdata") then
      return ProxyObject(v)
    end

    if (type(v) == "table") then
      return Shared(obj, allLayers)
    end

    -- when passed through get/set table metatable is destroyed. repair it.
    if (type(v) == "ProxyObject") then
      return ProxyObject(v.__ttsObject)
    end

    return v
  end

  function mt.__newindex(t, k, v)
    if (type(v) == 'ProxyObject') then
      v = v.ttsObject
    end
    if (type(v) == 'SharedData') then
      v = getmetatable(v).data()
    end
    
    if #layers > 0 then

      local base = obj.getTable(layers[1])
      local parent = base
      for i, layer in ipairs(layers) do
        if i ~= 1 then
          -- first element is handled above
          parent = parent[layer]
        end
      end
      parent[k] = v

      if (type(base) == 'table') then
        obj.setTable(layers[1], base)
      else
        obj.setVar(layers[1], base)
      end
    else

      if (type(v) == 'table') then
        obj.setTable(k, v)
      else
        obj.setVar(k, v)
      end
    end

  end

  local function itr(t, i)
    i = i + 1
    local v = t[i]
    if v then
      if (type(v) == "userdata") then
        return i, ProxyObject(v)
      end
      return i, v
    end
  end

  local function _next(t, k_in)
    local k, v = next(t, k_in)
    if (type(v) == "userdata") then
      return k, ProxyObject(v)
    end
    return k, v
  end

  function mt.__pairs(t)
    local tbl = obj.getTable(layers[1])
    for i, layer in ipairs(layers) do
      if i ~= 1 then
        -- first element is handled above
        tbl = tbl[layer]
      end
    end

    return _next, tbl, nil
  end

  function mt.__ipairs(t)
    local tbl = obj.getTable(layers[1])
    for i, layer in ipairs(layers) do
      if i ~= 1 then
        -- first element is handled above
        tbl = tbl[layer]
      end
    end

    return itr, tbl, 0
  end

  function mt.__len(t)
    local tbl = obj.getTable(layers[1])
    for i, layer in ipairs(layers) do
      if i ~= 1 then
        -- first element is handled above
        tbl = tbl[layer]
      end
    end

    return #tbl
  end

  function mt.data()
    local tbl = obj.getTable(layers[1])
    for i, layer in ipairs(layers) do
      if i ~= 1 then
        -- first element is handled above
        tbl = tbl[layer]
      end
    end

    return tbl
  end

  function mt.__call(t)
    return mt.data()
  end

  -- return a table that can be passed through events and be decompressed on the other side
  function mt.__compress(t)
    return {
      __type = 'CompressedInstance',
      __compressed_type = 'SharedData',
      __decompress = {
        func = 'Shared',
        params = { obj, layers }
      },
    }
  end

  return setmetatable({}, mt)
end

if owner == nil then
  ---@class owner:tts__Object
  owner = [[##OWNER##]]
end

---@class shared:tts__Self
shared = Shared(owner)