



local CBaseAnimating_pdata = require("class/CBaseAnimating")
local enum_merge = require("core/enum_merge")

CBaseToggle_pdata = enum_merge(CBaseAnimating_pdata, {
    "m_toggle_state", -- TOGGLE_STATE
	"m_flActivateFinished", -- time_point_t
	"m_flMoveDistance", -- float
	"m_flWait", -- duration_t
	"m_flLip", -- float
	"m_flTWidth", -- float
	"m_flTLength", -- float
	"m_vecPosition1", -- Vector
	"m_vecPosition2", -- Vector
	"m_vecAngle1", -- Vector
	"m_vecAngle2", -- Vector
	"m_cTriggersLeft", -- int
	"m_flHeight", -- float
	"m_hActivator", -- EHANDLE
	"m_pfnCallWhenMoveDone", -- void (CBaseToggle::*)(void);
	"m_vecFinalDest", -- Vector
	"m_vecFinalAngle", -- Vector
	"m_bitsDamageInflict", -- int
	"m_sMaster", -- string_t
})

return CBaseToggle_pdata