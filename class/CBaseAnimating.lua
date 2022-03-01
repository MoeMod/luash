
local CBaseDelay_pdata = require("class/CBaseDelay")
local enum_merge = require("core/enum_merge")

CBaseAnimating_pdata = enum_merge(CBaseDelay_pdata, {
    "m_flFrameRate", -- float
	"m_flGroundSpeed", -- float
	"m_flLastEventCheck", -- time_point_t
	"m_fSequenceFinished", -- BOOL
	"m_fSequenceLoops", -- BOOL
})

return CBaseAnimating_pdata