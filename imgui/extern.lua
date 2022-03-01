function lua_clone(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function lua_class(classname, super)
    local superType = type(super)
    local cls

    if superType ~= "table" then
        superType = nil
        super = nil
    end

    if super then
        cls = lua_clone(super)
        cls.super = super
    else
        cls = {ctor = function() end}
    end

    cls.__cname = classname
    cls.__index = cls

    function cls.new(...)
        local instance = setmetatable({}, cls)
        instance.lua_class = cls
        instance:ctor(...)
        return instance
    end

    return cls
end