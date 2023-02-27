Callback = {}
Method = {}

local function Decompress(...)
  local params = {}
  for i, param in pairs({...}) do
    if param and type(param) == 'table' and param.__decompress ~= nil then
      local func = _G[param.__decompress.func]
      if func ~= nil then
        params[i] = func(table.unpack(param.__decompress.params))
        goto continue
      end

      printToAll("Couldn't find function: " .. param.__decompress.func .. " in Global namespace", {1,0,0})
      params[i] = nil
    else
      params[i] = param
    end
    ::continue::
  end
  return table.unpack(params)
end

local function Compress(...)
  local params = { ... }
  for i, param in ipairs(params) do
    mt = getmetatable(param)
    if mt and mt.__compress then
      params[i] = mt.__compress(param)
    end
  end
  return params
end

function InvokeEvent(eventName, ...)
  Global.call('_InvokeEvent', {
    name = eventName,
    params = Compress(...)
  })
end

function InvokeMethod(methodName, owner, ...)
  local ownerGUID = owner.guid
  if owner == Global then
    ownerGUID = 'Global'
  end
  local result = Global.call('_InvokeMethod', {
    name = methodName,
    owner = ownerGUID,
    params = Compress(...)
  })

  return Decompress(result)
end

function _HasMethod(msg)
  return Method[msg.name] ~= nil
end

function _OnRecieveEventMessage(msg)
  local callback = Callback[msg.name]
  if callback ~= nil then
    if msg.params == nil then
      callback()
    else
      callback(Decompress(table.unpack(msg.params)))
    end
  end
end

function _CallMethod(msg)
  local method = Method[msg.name]
  if method ~= nil then
    local result
    if msg.params == nil then
      result = method()
    else
      result = method(Decompress(table.unpack(msg.params)))
    end
    return result
  end
end

function ExternMethod(methodName)
  _G[methodName] = function(...)
    return InvokeMethod(methodName, owner, ...)
  end
end
