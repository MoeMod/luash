local function enum_merge(old_enum, t)
    local result = {}
    local max_value = 0
    for name, value in pairs(old_enum) do
        max_value = math.max(max_value, value)
        result[name] = value
    end
    
    for i, name in ipairs(t) do
        result[name] = i + max_value
    end
    return result
end
return enum_merge