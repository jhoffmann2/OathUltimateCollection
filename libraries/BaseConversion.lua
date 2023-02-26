local zeroVal = string.byte(" ")
local key = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!\"#$%&'()*+,-./:;<=>?@[]^_`{|}~"
MaximumBase = #key

---@param val number
---@param base number
---@return string
function BaseEncode(val, base, digitCount)
  if base > MaximumBase or base < 1 then
    return nil
  end

  -- negatives wrap around to max value
  if val < 0 then
    val = (base^digitCount) + val
  end

  str = ""
  while val > 0 do
    str = string.char(key:byte(val % base + 1))..str
    val = math.floor(val / base)
  end

  if digitCount ~= nil then
    -- pad string with zeros at beginning
    while #str < digitCount do
      str = string.char(key:byte(1))..str
    end
  end
  
  return str
end

-- calculate the inverse lookup for every character
local decoder = {}
for i = 1, #key do
  decoder[key:byte(i)] = i - 1
end

---@param str string
---@param base number
---@return number
function BaseDecode(str, base)
  val = 0
  for i = 1, #str do
    local digitVal = decoder[str:byte(i)]
    if not digitVal or digitVal > base then
      printToAll("BaseDecode included a character outside the bounds of the provided base", {1,0,0})
      return -1
    end
    
    val = (val * base) + decoder[str:byte(i)]
  end
  return val
end
