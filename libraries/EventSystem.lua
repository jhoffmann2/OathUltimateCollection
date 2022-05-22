Callback = {}
function InvokeEvent(eventName, ...)

  -- compress tables so they can be be transported across events
  params = { ... }
  for i, param in ipairs(params) do
    mt = getmetatable(param)
    if mt and mt.__compress then
      params[i] = mt.__compress(param)
    end
  end

  Global.call('_InvokeEvent', {
    name = eventName,
    params = params
  })
end

local function decompressParams(msg)
  params = {}
  for i, param in pairs(msg.params) do
    if param and param.__decompress ~= nil then
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
  return params
end

function _OnRecieveEventMessage(msg)
  local callback = Callback[msg.name]
  if callback ~= nil then
    if msg.params == nil then
      callback()
    else
      callback(table.unpack(decompressParams(msg)))
    end
  end
end