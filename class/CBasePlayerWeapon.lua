local CBasePlayerItem_pdata = require("class/CBasePlayerItem")
local enum_merge = require("core/enum_merge")

CBasePlayerWeapon_pdata = enum_merge(CBasePlayerItem_pdata, {
	"m_iPlayEmptySound", -- int
	"m_fFireOnEmpty", -- int
	"m_flNextPrimaryAttack", -- duration_t
	"m_flNextSecondaryAttack", -- duration_t
	"m_flTimeWeaponIdle", -- duration_t
	"m_iPrimaryAmmoType", -- int
	"m_iSecondaryAmmoType", -- int
	"m_iClip", -- int
	"m_iClientClip", -- int
	"m_iClientWeaponState", -- int
	"m_fInReload", -- int
	"m_fInSpecialReload", -- int
	"m_iDefaultAmmo", -- int
	"m_iShellId", -- int
	"m_fMaxSpeed", -- float
	"m_bDelayFire", -- bool
	"m_iDirection", -- int
	"m_bSecondarySilencerOn", -- bool
	"m_flAccuracy", -- float
	"m_flLastFire", -- time_point_t
	"m_iShotsFired", -- int
	"m_vVecAiming", -- Vector
	"model_name", -- string_t
	"m_flGlock18Shoot", -- time_point_t                // time to shoot the remaining bullets of the glock18 burst fire
	"m_iGlock18ShotsFired", -- int            // used to keep track of the shots fired during the Glock18 burst fire mode.
	"m_flFamasShoot", -- time_point_t
	"m_iFamasShotsFired", -- int
	"m_fBurstSpread", -- float
	"m_iWeaponState", -- int
	"m_flNextReload", -- duration_t
	"m_flDecreaseShotsFired", -- time_point_t
	"m_usFireGlock18", -- unsigned short
	"m_usFireFamas", -- unsigned short
	"m_flPrevPrimaryAttack", -- duration_t
	"m_flLastFireTime", -- time_point_t
})

return CBasePlayerWeapon_pdata