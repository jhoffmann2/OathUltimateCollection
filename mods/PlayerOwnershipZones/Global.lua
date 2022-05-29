local guids = {
  ["Purple"] = 'c753a0',
  ["Red"] = '1fd109',
  ["Brown"] = '9dc047',
  ["Blue"] = '6133b5',
  ["Yellow"] = '1c0108',
  ["White"] = 'd2c7cd'
}

function onLoad()
  shared.playerOwnershipZones = {
    ["Purple"] = getObjectFromGUID(guids['Purple']),
    ["Red"] = getObjectFromGUID(guids['Red']),
    ["Brown"] = getObjectFromGUID(guids['Brown']),
    ["Blue"] = getObjectFromGUID(guids['Blue']),
    ["Yellow"] = getObjectFromGUID(guids['Yellow']),
    ["White"] = getObjectFromGUID(guids['White']) 
  }
end