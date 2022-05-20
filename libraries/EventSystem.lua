
Callback = {}
function InvokeEvent(eventName, ...)
    Global.call('_InvokeEvent', {
        name = eventName,
        params = {...}
    })
end

function _OnRecieveEventMessage(msg)
    local callback = Callback[msg.name]
    if callback ~= nil then
        if msg.params == nil then
            callback()
        else
            callback(table.unpack(msg.params))
        end
    end
end