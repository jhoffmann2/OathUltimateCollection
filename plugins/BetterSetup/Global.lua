
function onLoad()
  InvokeEvent("OnEnsurePluginActive", "PlayerBoardLib")
end


function Callback.OnGameStart()
  local rotation = { 0.00, 180.00, 0.00}
  
  -- put a purple warband at all sites with a suited card
  local purpleWarbandBag = shared.playerWarbandBags['Purple']
  for siteIndex = 2, 8 do
    if SiteHasSuitedCard(siteIndex) then
      local position = shared.mapSiteCardZones[siteIndex].getPosition()
      purpleWarbandBag.takeObject({ position = position, rotation = rotation })
    end
  end
  -- top cradle has two warbands regardless of suited cards
  local sitePosition = shared.mapSiteCardZones[1].getPosition()
  local leftWarbandPosition = sitePosition - Vector(0.67,0,0)
  local rightWarbandPosition = sitePosition + Vector(0.67,0,0)
  purpleWarbandBag.takeObject({ position = leftWarbandPosition, rotation = rotation })
  purpleWarbandBag.takeObject({ position = rightWarbandPosition, rotation = rotation })
  
  -- put a favor on PF
  local peoplesFavorPosition = shared.peoplesFavor.getPosition() + Vector(0,0.32,0)
  shared.favorBag.takeObject({position = peoplesFavorPosition, rotation = rotation})
  
  -- put a secret on DS
  local darkestSecretPosition = shared.darkestSecret.getPosition() + Vector(0,0.96,0)
  shared.secretBag.takeObject({position = darkestSecretPosition, rotation = rotation})
  
end

function SiteHasSuitedCard(siteIndex)
  for normalCardIndex = 1, 3 do
    local zone = shared.mapNormalCardZones[siteIndex][normalCardIndex]
    if zone ~= nil then
      local scriptZoneObjects = zone.getObjects(true)
      for i, object in ipairs(scriptZoneObjects) do
        if (IsSuitedCard(object)) then
          return true
        end
      end
    end
  end
  return false
end

function IsSuitedCard(object)
  if ("Card" == object.type) then
    local cardInfo = shared.cardsTable[object.getName()]
    if cardInfo.cardtype == 'Denizen' then
      return true
    end
    if cardInfo.cardtype == 'EdificeRuin' and CardIsFaceup(object)  then
      return true
    end
  end
  return false
end

function CardIsFaceup(card)
  local flip = card.getRotation().z
  return not(175 < flip and 185 > flip)
end
