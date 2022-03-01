

--[[
    example class =
    {
        name = "class"
        base = CBaseEntity,
        cppclass = "CBaseEntity", -- sets when represents a cpp class
        ...
    }
]]

--[[
    example object =
    {
        isa = CLuaClass,
        this = lightuserdata,
        super = object_CBaseEntity,
        pdata = {}
    }
]]

local class_metatable = {
    __index = function (self, key)
        local base = rawget(self, "base")
        return base and base[key] or nil
    end,
    __newindex = function (self, key, value)
        return rawset(self, key, value)
    end,
}

local object_metatable = {
    __index = function (self, key)
        return rawget(self.pdata, key) or (self.isa and self.isa[key]) or (self.this and self.this[key]) or nil
    end,
    __newindex = function (self, key, value)
        if self.this and self.this[key] ~= nil then
            self.this[key] = value
            return 
        end
        rawset(self.pdata, key, value)
    end,
}

function is_base_of(base, derived)
    while derived ~= nil do
        if base == derived then
            return true
        end
        derived = derived.base
    end
    return false
end

function isa(object, class)
    return is_base_of(class, object and object.isa or nil)
end

local function table_copy(A)
    local B = {}
    for k, v in pairs(A) do
        B[k] = v
    end
    return B
end

local function build_derive_tree(Class, Raw)
    if not Class then
        return Raw
    end
    if not Class.name then
        return assert_false()
    end
    local super = build_derive_tree(Class.base, Raw)

    local ret = table_copy(super)
    ret.isa = Class
    ret.super = super
    ret[Class.name] = ret
    setmetatable(ret, object_metatable)
    return ret
end

local function delete_derive_this(LuaObject)
    while LuaObject ~= nil do
        LuaObject.this = nil
        LuaObject.pdata = nil
        LuaObject = LuaObject.super
    end
end

-- C++ calls this
function class_new(Class, This)
    local LuaObject = build_derive_tree(Class, { this = This, pdata = {} })
    if LuaObject.constructor then
        LuaObject:constructor()
    end
    return LuaObject
end

-- C++ calls this
function class_this(LuaObject)
    return LuaObject.this or LuaObject
end

-- C++ calls this
function class_delete(LuaObject, This)
    if LuaObject.this ~= This then
        return assert_false()
    end

    if LuaObject.destructor then
        LuaObject:destructor()
    end
    delete_derive_this(LuaObject)
end

-- C++ calls this
function class(ClassName, BaseClass)
    local Class = { name = ClassName, base = BaseClass }
    setmetatable(Class, class_metatable)
    return Class
end
