
-- defined in PlayerBoardLib/PlayerBoard.lua
ExternMethod("GetPlayerSupply")
ExternMethod("GetSecretReturnPosition")
ExternMethod("GetFavorReturnPosition")
ExternMethod("GetXYRotation")
ExternMethod("OffsetToPosition")

local warbandSetupOffsets = {
  {-2.24, 0.1, -3.35},
  {-3.41, 0.1, -3.35},
  {-4.58, 0.1, -3.35}
}

local globalData
function onLoad()
  globalData = Shared(Global)
end

function Callback.OnGameStart()
  local playerActive = globalData.curPlayerStatus[shared.playerColor][2]
  if (not playerActive) then
    return
  end

  local rotation = GetXYRotation()

  -- give player favor and secrets
  globalData.secretBag.takeObject({position = GetSecretReturnPosition(), rotation = rotation})
  globalData.favorBag.takeObject({position = GetFavorReturnPosition(), rotation = rotation})
  if shared.playerColor == 'Purple' then
    -- give chancellor a second favor
    globalData.favorBag.takeObject({position = GetFavorReturnPosition(nil, 2), rotation = rotation})
  end
  
  local warbandBag = globalData.playerWarbandBags[shared.playerColor]
  if globalData.curPlayerStatus[shared.playerColor][1] == 'Citizen' then
    -- citizens use chancellors warbands
    warbandBag = globalData.playerWarbandBags['Purple']
  end

  -- give player 3 warbands
  for _, offset in ipairs(warbandSetupOffsets) do
    warbandBag.takeObject({position = OffsetToPosition(offset), rotation = rotation})
  end
  
end



