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