
local CBaseToggle_pdata = require("class/CBaseToggle")
local enum_merge = require("core/enum_merge")

CBaseMonster_pdata = enum_merge(CBaseToggle_pdata, {
    "m_Activity", -- Activity
	"m_IdealActivity", -- Activity
	"m_LastHitGroup", -- int
	"m_bitsDamageType", -- int
	"m_rgbTimeBasedDamage", -- BYTE [CDMG_TIMEBASED];
	"m_MonsterState", -- MONSTERSTATE
	"m_IdealMonsterState", -- MONSTERSTATE
	"m_afConditions", -- int
	"m_afMemory", -- int
	"m_flNextAttack", -- duration_t
	"m_hEnemy", -- EHANDLE
	"m_hTargetEnt", -- EHANDLE
	"m_flFieldOfView", -- float
	"m_bloodColor", -- int
	"m_HackedGunPos", -- Vector
	"m_vecEnemyLKP", -- Vector
	"m_timeNextAttack", -- time_point_t
})

return CBaseMonster_pdata