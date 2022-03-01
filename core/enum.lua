
local function enum(t)
    local result = {}
    for i, name in ipairs(t) do
        result[name] = i
    end
    return result
end

return enum