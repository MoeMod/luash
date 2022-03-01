-- (\w+)\s(\w+);
-- "$2", -- $1

local enum = require("core/enum")

CBaseEntity_pdata = enum({
    "pev", -- entvars_t * ;
	"m_pGoalEnt", -- CBaseEntity *;
	"m_pLink", -- CBaseEntity *;
	"m_pfnThink", -- void (CBaseEntity::*)(void);
	"m_pfnTouch", -- void (CBaseEntity::*)(CBaseEntity *pOther);
	"m_pfnUse", -- void (CBaseEntity::*)(CBaseEntity *pActivator, CBaseEntity *pCaller, USE_TYPE useType, float value);
	"m_pfnBlocked", -- void (CBaseEntity::*)(CBaseEntity *pOther);
	"current_ammo", -- int
	"currentammo", -- int
	"maxammo_buckshot", -- int
	"ammo_buckshot", -- int
	"maxammo_9mm", -- int
	"ammo_9mm", -- int
	"maxammo_556nato", -- int
	"ammo_556nato", -- int
	"maxammo_556natobox", -- int
	"ammo_556natobox", -- int
	"maxammo_762nato", -- int
	"ammo_762nato", -- int
	"maxammo_45acp", -- int
	"ammo_45acp", -- int
	"maxammo_50ae", -- int
	"ammo_50ae", -- int
	"maxammo_338mag", -- int
	"ammo_338mag", -- int
	"maxammo_57mm", -- int
	"ammo_57mm", -- int
	"maxammo_357sig", -- int
	"ammo_357sig", -- int
	"m_flStartThrow", -- time_point_t
	"m_flReleaseThrow", -- time_point_t
	"m_iSwing", -- int
	"has_disconnected", -- bool
})

return CBaseEntity_pdata