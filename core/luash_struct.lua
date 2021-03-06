
StructMetaTableCache = StructMetaTableCache or {}

local function CreateStructMetaTable(struct_name)
    local struct_meta = StructMetaTableCache[struct_name]
    if not struct_meta then
        local struct_index = require("struct/" .. struct_name)
        if struct_index then
            struct_meta = {
                __index = function (table, key)
                    local offset = struct_index[key]
                    return offset and rawget(table, offset) or rawget(table, key)
                end,
                __newindex = function (table, key, value)
                    local offset = struct_index[key]
                    table[offset] = value
                end,
                __tostring = function (table)
                    -- TODO : very slow implementation
                    local result = struct_name .. "{ "
                    for key, offset in pairs(struct_index) do
                        local value = tostring(table[offset])
                        result = result .. "." .. key .. " = " ..value .. ", "
                    end
                    result = result .. "}"
                    return result
                end
            }
            StructMetaTableCache[struct_name] = struct_meta
        end
    end
    return struct_meta
end

-- C++ calls this
function OnStructCreate(struct_table, struct_name)
    local struct_meta = CreateStructMetaTable(struct_name)
    if struct_meta then
        setmetatable(struct_table, struct_meta)
    else
        print("luash_meta:OnStructCreate Error: struct_index not found for ", struct_name)
    end
    return struct_table
end
