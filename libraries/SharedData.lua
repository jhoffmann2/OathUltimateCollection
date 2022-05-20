local _rawtableinsert = table.insert
function table.insert(...)
    local table = nil
    local pos = nil
    local val = nil
    if select('#', ...) == 2 then
        table = select(1, ...)
        pos = #table + 1
        val = select(2, ...)
    else
        table = select(1, ...)
        pos = select(2, ...)
        val = select(3, ...)
    end

    -- shift everything over
    for i = #table, pos, -1 do
        table[i+1] = table[i]
    end

    table[pos] = val
end

local function _dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. _dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

local function _shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function Shared(obj, layers)

    if layers == nil then
        layers = {}
    end

    local mt = {
        __index = function (t,k)
            local allLayers = _shallowCopy(layers)
            table.insert(allLayers, k)

            local v = obj.getVar(allLayers[1])
            for i, layer in ipairs(allLayers) do
                if i ~= 1 then -- first element is handled above
                    v = v[layer]
                end
            end

            if(type(v) == "table") then
                return Shared(obj, allLayers)
            end

            return v
        end,

        __newindex = function (t,k,v)
            if #layers > 0 then

                local base = obj.getTable(layers[1])
                local parent = base
                for i, layer in ipairs(layers) do
                    if i ~= 1 then -- first element is handled above
                        parent = parent[layer]
                    end
                end
                parent[k] = v

                if(type(base) == 'table') then
                    obj.setTable(layers[1], base)
                else
                    obj.setVar(layers[1], base)
                end
            else
                if(type(v) == 'table') then
                    obj.setTable(k, v)
                else
                    obj.setVar(k, v)
                end
            end

        end,

        __pairs = function(t)
            local tbl = obj.getTable(layers[1])
            for i, layer in ipairs(layers) do
                if i ~= 1 then -- first element is handled above
                    tbl = tbl[layer]
                end
            end

            return pairs(tbl)
        end,

        __ipairs = function(t)
            local tbl = obj.getTable(layers[1])
            for i, layer in ipairs(layers) do
                if i ~= 1 then -- first element is handled above
                    tbl = tbl[layer]
                end
            end

            return ipairs(tbl)
        end,

        __len = function(t)

            local tbl = obj.getTable(layers[1])
            for i, layer in ipairs(layers) do
                if i ~= 1 then -- first element is handled above
                    tbl = tbl[layer]
                end
            end

            return #tbl
        end,

        __call = function(t)
            local tbl = obj.getTable(layers[1])
            for i, layer in ipairs(layers) do
                if i ~= 1 then -- first element is handled above
                    tbl = tbl[layer]
                end
            end

            return tbl
        end
    }
    return setmetatable({}, mt)
end

owner = [[##OWNER##]]
shared = Shared(owner)