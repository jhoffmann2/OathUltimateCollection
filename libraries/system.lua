local _type = type
function type(v)
  if v ~= nil and _type(v) == 'table' then
    if v.__type ~= nil then
      return v.__type
    end
    local mt = getmetatable(v)
    if mt ~= nil and mt.__type ~= nil then
      return mt.__type
    end
  end
  return _type(v)
end

local _tableRemove = table.remove
function table.remove(list, pos)
  local mt = getmetatable(list)
  if mt == nil then
    -- without a metatable, we can just use the standard table.remove
    return _tableRemove(list, pos)
  end
  
  -- default position to last index
  if pos == nil then
    pos = #list
  end

  local removed = list[pos]
  for i=pos, #list - 1 do
    list[i] = list[i + 1]
  end
  list[#list] = nil
  return removed
end

function table.removeSwap(list, pos)
  local removed = list[pos]
  list[pos] = list[#list]
  table.remove(list)
  return removed
end

function table.shallowCopy(source, destination, rangeBegin, rangeEnd)
  if #source > 0 then
    if rangeBegin == nil then
      rangeBegin = 1
    end
    if rangeEnd == nil then
      rangeEnd = #source
    end
    
    for i = rangeBegin, rangeEnd do
      table.insert(destination, source[i])
    end
  else
    for k, v in pairs(source) do
      destination[k] = v
    end
  end
end