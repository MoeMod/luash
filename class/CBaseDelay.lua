
local CBaseEntity_pdata = require("class/CBaseEntity")
local enum_merge = require("core/enum_merge")

CBaseDelay_pdata = enum_merge(CBaseEntity_pdata, {
    "m_flDelay", -- duration_t
    "m_iszKillTarget", -- int
})

return CBaseDelay_pdata