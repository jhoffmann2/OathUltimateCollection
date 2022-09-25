local zeroVal = string.byte(" ")
local key = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!\"#$%&'()*+,-./:;<=>?@[]^_`{|}~"
BaseEncodeMax = #key

---@param val number
---@param base number
---@return string
function BaseEncode(val, base, minLength)
  if base > BaseEncodeMax or base < 1 then
    return nil
  end

  str = ""
  while val > 0 do
    str = string.char(key:byte(val % base + 1))..str
    val = math.floor(val / base)
  end

  if minLength ~= nil then
    -- pad string with zeros at beginning
    while #str < minLength do
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
    val = (val * base) + decoder[str:byte(i)]
  end
  return val
end
