local CBaseAnimating_pdata = require("class/CBaseAnimating")
local enum_merge = require("core/enum_merge")

CBasePlayerItem_pdata = enum_merge(CBaseAnimating_pdata, {
	"m_pPlayer", -- CBasePlayer *
	"m_pNext", -- CBasePlayerItem *
	"m_iId", -- WeaponIdType
})

return CBasePlayerItem_pdata