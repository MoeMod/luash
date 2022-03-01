
local CBaseMonster_pdata = require("class/CBaseMonster")
local enum_merge = require("core/enum_merge")

CBasePlayer_pdata = enum_merge(CBaseMonster_pdata, {
    "random_seed", -- int
	"m_usPlayerBleed", -- unsigned short
	"m_hObserverTarget", -- EHANDLE
	"m_flNextObserverInput", -- time_point_t
	"m_iObserverWeapon", -- int
	"m_iObserverC4State", -- int
	"m_bObserverHasDefuser", -- bool
	"m_iObserverLastMode", -- int
	"m_flFlinchTime", -- time_point_t
	"m_flAnimTime", -- time_point_t
	"m_bHighDamage", -- bool
	"m_flVelocityModifier", -- float
	"m_iLastZoom", -- int
	"m_bResumeZoom", -- bool
	"m_flEjectBrass", -- time_point_t
	"m_iKevlar", -- int
	"m_bNotKilled", -- bool
	"m_iTeam", -- TeamName
	"m_iAccount", -- CPlayerAccount
	"m_bHasPrimary", -- bool
	"m_flDeathThrowTime", -- time_point_t
	"m_iThrowDirection", -- int
	"m_flLastTalk", -- time_point_t
	"m_bJustConnected", -- bool
	"m_bContextHelp", -- bool
	"m_iJoiningState", -- JoinState
	"m_pIntroCamera", -- CBaseEntity *;
	"m_fIntroCamTime", -- time_point_t
	"m_fLastMovement", -- time_point_t
	"m_bMissionBriefing", -- bool
	"m_bTeamChanged", -- bool
	"m_iModelName", -- ModelName
	"m_iTeamKills", -- int
	"m_iIgnoreGlobalChat", -- int
	"m_bHasNightVision", -- bool
	"m_bNightVisionOn", -- bool
	"m_vRecentPath", -- Vector [MAX_RECENT_PATH];
	"m_flIdleCheckTime", -- time_point_t
	"m_flRadioTime", -- time_point_t
	"m_iRadioMessages", -- int
	"m_bIgnoreRadio", -- bool
	"m_bHasC4", -- bool
	"m_bHasDefuser", -- bool
	"m_bKilledByBomb", -- bool
	"m_vBlastVector", -- Vector
	"m_bKilledByGrenade", -- bool
	"m_hintMessageQueue", -- CHintMessageQueue
	"m_flDisplayHistory", -- int
	"m_iMenu", -- _Menu
	"m_iChaseTarget", -- int
	"m_pChaseTarget", -- CBaseEntity *;
	"m_fCamSwitch", -- float
	"m_bEscaped", -- bool
	"m_bIsVIP", -- bool
	"m_tmNextRadarUpdate", -- time_point_t
	"m_vLastOrigin", -- Vector
	"m_iCurrentKickVote", -- int
	"m_flNextVoteTime", -- time_point_t
	"m_bJustKilledTeammate", -- bool
	"m_iHostagesKilled", -- int
	"m_iMapVote", -- int
	"m_bCanShoot", -- bool
	"m_flLastFired", -- time_point_t
	"m_flLastAttackedTeammate", -- time_point_t
	"m_bHeadshotKilled", -- bool
	"m_bPunishedForTK", -- bool
	"m_bReceivesNoMoneyNextRound", -- bool
	"m_iTimeCheckAllowed", -- time_point_t
	"m_bHasChangedName", -- bool
	"m_szNewName", -- char [MAX_PLAYER_NAME_LENGTH];
	"m_bIsDefusing", -- bool
	"m_tmHandleSignals", -- time_point_t
	"m_signals", -- CUnifiedSignals
	"m_pentCurBombTarget", -- edict_t *;
	"m_iPlayerSound", -- int
	"m_iTargetVolume", -- int
	"m_iWeaponVolume", -- int
	"m_iExtraSoundTypes", -- int
	"m_iWeaponFlash", -- int
	"m_flStopExtraSoundTime", -- float
	"m_flFlashLightTime", -- time_point_t
	"m_iFlashBattery", -- int
	"m_afButtonLast", -- int
	"m_afButtonPressed", -- int
	"m_afButtonReleased", -- int
	"m_pentSndLast", -- edict_t *;
	"m_flSndRoomtype", -- float
	"m_flSndRange", -- float
	"m_flFallVelocity", -- float
	"m_rgItems", -- int [MAX_ITEMS];
	"m_fNewAmmo", -- int
	"m_afPhysicsFlags", -- unsigned int
	"m_fNextSuicideTime", -- time_point_t
	"m_flTimeStepSound", -- time_point_t
	"m_flTimeWeaponIdle", -- time_point_t
	"m_flSwimTime", -- time_point_t
	"m_flDuckTime", -- time_point_t
	"m_flWallJumpTime", -- time_point_t
	"m_flSuitUpdate", -- time_point_t
	"m_rgSuitPlayList", -- int [CSUITPLAYLIST];
	"m_iSuitPlayNext", -- int
	"m_rgiSuitNoRepeat", -- int [CSUITNOREPEAT];
	"m_rgflSuitNoRepeatTime", -- float [CSUITNOREPEAT];
	"m_lastDamageAmount", -- int
	"m_tbdPrev", -- time_point_t
	"m_flgeigerRange", -- float
	"m_flgeigerDelay", -- time_point_t
	"m_igeigerRangePrev", -- int
	"m_iStepLeft", -- int
	"m_szTextureName", -- char [CBTEXTURENAMEMAX];
	"m_chTextureType", -- char
	"m_idrowndmg", -- int
	"m_idrownrestored", -- int
	"m_bitsHUDDamage", -- int
	"m_fInitHUD", -- BOOL
	"m_fGameHUDInitialized", -- BOOL
	"m_iTrain", -- int
	"m_fWeapon", -- BOOL
	"m_pTank", -- EHANDLE
	"m_fDeadTime", -- time_point_t
	"m_fNoPlayerSound", -- BOOL
	"m_fLongJump", -- BOOL
	"m_tSneaking", -- time_point_t
	"m_iUpdateTime", -- int
	"m_iClientHealth", -- int
	"m_iClientBattery", -- int
	"m_iHideHUD", -- int
	"m_iClientHideHUD", -- int
	"m_iFOV", -- int
	"m_iClientFOV", -- int
	"m_iNumSpawns", -- int
	"m_pObserver", -- CBaseEntity *;
	"m_rgpPlayerItems", -- CBasePlayerItem *[MAX_ITEM_TYPES];
	"m_pActiveItem", -- CBasePlayerItem *;
	"m_pClientActiveItem", -- CBasePlayerItem *;
	"m_pLastItem", -- CBasePlayerItem *;
	"m_rgAmmo", -- int [MAX_AMMO_SLOTS];
	"m_rgAmmoLast", -- int [MAX_AMMO_SLOTS];
	"m_vecAutoAim", -- Vector
	"m_fOnTarget", -- BOOL
	"m_iDeaths", -- int
	"m_izSBarState", -- int [SBAR_END];
	"m_flNextSBarUpdateTime", -- time_point_t
	"m_flStatusBarDisappearDelay", -- time_point_t
	"m_SbarString0", -- char [SBAR_STRING_SIZE];
	"m_lastx", -- int
	"m_lasty", -- int
	"m_nCustomSprayFrames", -- int
	"m_flNextDecalTime", -- time_point_t
	"m_szTeamName", -- char [TEAM_NAME_LENGTH];
	"m_modelIndexPlayer", -- int
	"m_szAnimExtention", -- char [32];
	"m_iGaitsequence", -- int
	"m_flGaitframe", -- float
	"m_flGaityaw", -- float
	"m_prevgaitorigin", -- Vector
	"m_flPitch", -- float
	"m_flYaw", -- float
	"m_flGaitMovement", -- float
	"m_iAutoWepSwitch", -- int
	"m_bVGUIMenus", -- bool
	"m_bShowHints", -- bool
	"m_bShieldDrawn", -- bool
	"m_bOwnsShield", -- bool
	"m_bWasFollowing", -- bool
	"m_flNextFollowTime", -- time_point_t
	"m_flYawModifier", -- float
	"m_blindUntilTime", -- time_point_t
	"m_blindStartTime", -- time_point_t
	"m_blindHoldTime", -- duration_t
	"m_blindFadeTime", -- duration_t
	"m_blindAlpha", -- int
	"m_allowAutoFollowTime", -- time_point_t
	"m_autoBuyString", -- char [MAX_AUTOBUY_LENGTH];
	"m_rebuyString", -- std::string
	"m_rebuyStruct", -- RebuyStruct
	"m_bIsInRebuy", -- bool
	"m_flLastUpdateTime", -- time_point_t
	"m_lastLocation", -- char [MAX_LOCATION_LENGTH];
	"m_progressStart", -- time_point_t
	"m_progressEnd", -- time_point_t
	"m_bObserverAutoDirector", -- bool
	"m_canSwitchObserverModes", -- bool
	"m_heartBeatTime", -- float
	"m_intenseTimestamp", -- float
	"m_silentTimestamp", -- float
	"m_musicState", -- MusicState
	"m_flLastCommandTime", -- time_point_t [8];
	"m_bIsZombie", -- bool
	"m_bSpawnProtection", -- bool
	"m_iZombieLevel", -- int
	"m_flTimeSpawnProctionExpires", -- float
	"m_bIsFemale", -- bool
})

return CBasePlayer_pdata
