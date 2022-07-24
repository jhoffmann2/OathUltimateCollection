
-- wrap incoming object parameters of events with ProxyObject(...) so that they work properly
function FixupEvent(name, paramIndices)
  if _G[name] then
    local userDefinedFunction = _G[name]
    _G[name] = function(...)
      local params = {...}
      for _, index in ipairs(paramIndices) do
        params[index] = ProxyObject(params[index])
      end
      userDefinedFunction(table.unpack(params))
    end
  end
end

--TODO: onObjectCollisionEnter
--TODO: onObjectCollisionExit
--TODO: onObjectCollisionStay
FixupEvent('onObjectDestroy', { 1 })
FixupEvent('onObjectDrop', { 2 })
FixupEvent('onObjectEnterContainer', { 1, 2 })
FixupEvent('onObjectEnterScriptingZone', { 1, 2 })
FixupEvent('onObjectEnterZone', { 1, 2 })
FixupEvent('onObjectFlick', { 1 })
FixupEvent('onObjectHover', { 2 })
FixupEvent('onObjectLeaveContainer', { 1, 2 })
FixupEvent('onObjectLeaveScriptingZone', { 1, 2 })
FixupEvent('onObjectLeaveZone', { 1, 2 })
FixupEvent('onObjectLoopingEffect', { 1 })
FixupEvent('onObjectNumberTyped', { 1 })
FixupEvent('onObjectPageChange', { 1 })
FixupEvent('onObjectPeek', { 1 })
FixupEvent('onObjectPickUp', { 2 })
FixupEvent('onObjectRandomize', { 1 })
FixupEvent('onObjectRotate', { 1 })
FixupEvent('onObjectSearchEnd', { 1 })
FixupEvent('onObjectSearchStart', { 1 })
FixupEvent('onObjectSpawn', { 1 })
FixupEvent('onObjectStateChange', { 1 })
FixupEvent('onObjectTriggerEffect', { 1 })
FixupEvent('filterObjectEnterContainer', { 1, 2 })
--TODO: onZoneGroupSort
FixupEvent('tryObjectEnterContainer', { 1, 2 })
FixupEvent('tryObjectRandomize', { 1 })
FixupEvent('tryObjectRotate', { 1 })
FixupEvent('filterObjectEnter', { 1 })
--TODO: onCollisionEnter
--TODO: onCollisionExit
--TODO: onCollisionStay
--TODO: onGroupSort
FixupEvent('tryObjectEnter', { 1 })
