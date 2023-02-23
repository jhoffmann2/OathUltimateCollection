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

function table.indexOf(table, element)
  for i, item in ipairs(table) do
    if item == element then
      return i
    end
  end
  return nil
end

function table.findSubArray(array, subArray)
  local begin = table.indexOf(array, subArray[1])
  
  -- if subTable[1] isn't in table, then subTable isn't in table
  if not begin then
    return nil
  end
  
  begin = begin - 1 -- zero index for easier math
  
  -- if there aren't enough elements after begin, then subTable isn't in table
  if (#array - begin) < #subArray then
    return nil
  end

  for i, element in ipairs(subArray) do
    if element ~= array[begin + i] then
      return nil
    end
  end
  return begin + 1, begin + #subArray
end
