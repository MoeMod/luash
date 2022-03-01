
CDEAGLE = CDEAGLE or class("CDEAGLE", CBasePlayerWeapon)

local WeaponConfig = {
    ClassName = "weapon_deagle",
    AmmoType = "50AE",
    MaxAmmo = 35, -- 备弹数量
    AmmoType2 = nil,
    MaxAmmo2 = -1,
    MaxClip = 7, -- 弹匣数量
    ItemSlot = PISTOL_SLOT,
    ItemPosition = 2,
    WeaponId = WEAPON_DEAGLE,
    Weight = 7,
    V_Model = "models/v_deagle.mdl",
    P_Model = "models/p_deagle.mdl",
    W_Model = "models/w_deagle.mdl",
    EventFile = "addons/luash/events/event_deagle.lua",
    AnimExtension = "onehanded", -- 持枪动作
    DefaultReloadTime = 2.2, -- 换弹时间
    DefaultDeployTime = 0.75, -- 切枪时间
    WeaponIdleTime = 20, -- 持枪静止时间
    DamageDefault = 56, -- 伤害
    DamageZB = 70, -- 生化伤害
    DamageZBS = 70, -- 灾变伤害
    AccuracyMin = 0.55, -- 精准度最小值
    AccuracyMax = 0.9, -- 精准度最大值
    AccuracyDefault = 0.9, -- 初始精准度
    SpreadCalcNotOnGround = function(A) return 1.5 * (1 - A) end, -- 空中精准度
    SpreadCalcWalking = function(A) return 0.25 * (1 - A) end, -- 移动精准度
    SpreadCalcDucking = function(A) return 0.115 * (1 - A) end, -- 蹲下精准度
    SpreadCalcDefault = function(A) return 0.13 * (1 - A) end, -- 站立精准度
    CycleTime = 0.3, -- 开火间隔
    PunchAngle = function(A) return {A[1] - 2, A[2], A[3]} end, -- 后坐力
    KnockBack = {350.0, 250.0, 350.0, 100.0, 0.6}, -- 击退
    Distance = 4096, -- 射击距离 
    Penetration = 2, -- 穿透
    RangeModifier = 0.81, -- 距离修正
    BulletType = BULLET_PLAYER_50AE,
    PlayerMaxSpeed = 250, -- 移速
    BuyAmmoConfig = { "ammo_50ae" , 40 } -- 子弹购买类型、价格
}

local ANIM_IDLE1 = 0
local ANIM_RELOAD = 4
local ANIM_DRAW = 5
local SHIELDGUN_IDLE = 0
local SHIELDGUN_SHOOT1 = 1
local SHIELDGUN_SHOOT2 = 2
local SHIELDGUN_SHOOT_EMPTY = 3
local SHIELDGUN_RELOAD = 4
local SHIELDGUN_DRAW = 5
local SHIELDGUN_DRAWN_IDLE = 6
local SHIELDGUN_UP = 7
local SHIELDGUN_DOWN = 8

LINK_ENTITY_TO_CLASS(WeaponConfig.ClassName, CDEAGLE)

function CDEAGLE:Spawn() -- override
	self.pev.classname = MAKE_STRING(WeaponConfig.ClassName)

	self:Precache();
	self.m_iId = WeaponConfig.WeaponId;
	SET_MODEL(self, WeaponConfig.W_Model);

	self.m_iDefaultAmmo = WeaponConfig.MaxClip;
	self.m_flAccuracy = WeaponConfig.AccuracyDefault;
	self.m_iShotsFired = 0;
	self.m_iWeaponState = bit.band(self.m_iWeaponState, bit.bnot(WPNSTATE_SHIELD_DRAWN))

	self:FallInit();
end

function CDEAGLE:Precache() -- override
	PRECACHE_MODEL(WeaponConfig.V_Model)
	PRECACHE_MODEL(WeaponConfig.P_Model)
	PRECACHE_MODEL(WeaponConfig.W_Model)
	PRECACHE_SOUND("weapons/deagle-1.wav")
	PRECACHE_SOUND("weapons/deagle-2.wav")
	PRECACHE_SOUND("weapons/de_clipout.wav")
	PRECACHE_SOUND("weapons/de_clipin.wav")
	PRECACHE_SOUND("weapons/de_deploy.wav")


	self.m_iShell = PRECACHE_MODEL("models/pshell.mdl")
	self.m_usFireDEAGLE = PRECACHE_EVENT(1, WeaponConfig.EventFile)
end

function CDEAGLE:GetItemInfo(p) -- override
	p.pszName = STRING(self.pev.classname)
	p.pszAmmo1 = WeaponConfig.AmmoType
	p.iMaxAmmo1 = WeaponConfig.MaxAmmo
	p.pszAmmo2 = WeaponConfig.AmmoType2
	p.iMaxAmmo2 = WeaponConfig.MaxAmmo2
	p.iMaxClip = WeaponConfig.MaxClip
	p.iSlot = WeaponConfig.ItemSlot - 1
	p.iPosition = WeaponConfig.ItemPosition
	p.iId = WeaponConfig.WeaponId;
    self.m_iId = WeaponConfig.WeaponId
	p.iFlags = 0
	p.iWeight = WeaponConfig.Weight

	return 1;
end

function CDEAGLE:PrimaryAttack() -- override
    if not FBitSet(self.m_pPlayer.pev.flags, FL_ONGROUND) then
        self:WeaponFire(WeaponConfig.SpreadCalcNotOnGround(self.m_flAccuracy), WeaponConfig.CycleTime, FALSE)
    elseif (VectorLength2D(self.m_pPlayer.pev.velocity) > 140) then
        self:WeaponFire(WeaponConfig.SpreadCalcNotOnGround(self.m_flAccuracy), WeaponConfig.CycleTime, FALSE)
    elseif FBitSet(self.m_pPlayer.pev.flags, FL_DUCKING) then
        self:WeaponFire(WeaponConfig.SpreadCalcDucking(self.m_flAccuracy), WeaponConfig.CycleTime, FALSE)
    else
        self:WeaponFire(WeaponConfig.SpreadCalcDefault(self.m_flAccuracy), WeaponConfig.CycleTime, FALSE)
    end
end

function CDEAGLE:WeaponFire(flSpread, flCycleTime, fUseAutoAim)
    flCycleTime = flCycleTime - 0.075;
	self.m_iShotsFired = self.m_iShotsFired + 1;
	if self.m_iShotsFired > 1 then
		return
    end

    if self.m_flLastFire ~= 0 then
        self.m_flAccuracy = self.m_flAccuracy - (0.4 - ((global.time - self.m_flLastFire) / 1)) * 0.35;
        self.m_flAccuracy = math.min(math.max(WeaponConfig.AccuracyMin, self.m_flAccuracy), WeaponConfig.AccuracyMax)
    end
    self.m_flLastFire = global.time;

	if self.m_iClip <= 0 then
		if (self.m_fFireOnEmpty) then
			self:PlayEmptySound()
			self.m_flNextPrimaryAttack = UTIL_WeaponTimeBase() + 0.2
        end
        return 
    end

	self.m_iClip = self.m_iClip - 1;
	self.m_pPlayer.pev.effects = bit.bor(self.m_pPlayer.pev.effects, EF_MUZZLEFLASH);
    if not CLIENT_DLL then
        self.m_pPlayer:SetAnimation(PLAYER_ATTACK1);
    end
	local forward, right, up = AngleVectors(VectorAdd(self.m_pPlayer.pev.v_angle, self.m_pPlayer.pev.punchangle));
	local vecSrc = self.m_pPlayer:GetGunPosition();
	local vecDir = self.m_pPlayer:FireBullets3(vecSrc, forward, flSpread, WeaponConfig.Distance, WeaponConfig.Penetration, WeaponConfig.BulletType, self:GetDamage(), WeaponConfig.RangeModifier, self.m_pPlayer.pev, FALSE, self.m_pPlayer.random_seed);

    local flags = 0
    if CLIENT_WEAPONS then
        flags = FEV_NOTHOST
    else
        flags = 0
    end

	PLAYBACK_EVENT_FULL(flags, self.m_pPlayer, self.m_usFireDEAGLE, 0, {0,0,0}, {0,0,0}, vecDir[1], vecDir[2], self.m_pPlayer.pev.punchangle[1] * 100, self.m_pPlayer.pev.punchangle[2] * 100, self.m_iClip ~= 0 and TRUE or FALSE, FALSE);

	self.m_pPlayer.m_iWeaponVolume = BIG_EXPLOSION_VOLUME
	self.m_pPlayer.m_iWeaponFlash = BRIGHT_GUN_FLASH
	self.m_flNextPrimaryAttack = UTIL_WeaponTimeBase() + flCycleTime
    self.m_flNextSecondaryAttack = UTIL_WeaponTimeBase() + flCycleTime
    
    if not CLIENT_DLL then
        if self.m_iClip == 0 and self.m_pPlayer.m_rgAmmo[self.m_iPrimaryAmmoType] <= 0 then
            self.m_pPlayer:SetSuitUpdate("!HEV_AMO0", FALSE, 0)
        end
    end
	self.m_flTimeWeaponIdle = UTIL_WeaponTimeBase() + 1.8

	self.m_pPlayer.pev.punchangle = WeaponConfig.PunchAngle(self.m_pPlayer.pev.punchangle)
	self:ResetPlayerShieldAnim()
end

function CDEAGLE:Reload() -- override
	if self:DefaultReload(WeaponConfig.MaxClip, ANIM_RELOAD, WeaponConfig.DefaultReloadTime, 0) then
        if not CLIENT_DLL then
            self.m_pPlayer:SetAnimation(PLAYER_RELOAD)
        end
		self.m_flAccuracy = WeaponConfig.AccuracyDefault
		self.m_iShotsFired = 0
		self.m_bDelayFire = false
    end
end

function CDEAGLE:Deploy()
	self.m_flAccuracy = WeaponConfig.AccuracyDefault
	self.m_iWeaponState = bit.band(self.m_iWeaponState, bit.bnot(WPNSTATE_SHIELD_DRAWN))
	self.m_iShotsFired = 0
	self.iShellOn = 1
	local result = self:DefaultDeploy(WeaponConfig.V_Model, WeaponConfig.P_Model, ANIM_DRAW, WeaponConfig.AnimExtension, self:UseDecrement() ~= FALSE)
	self.m_pPlayer.m_flNextAttack = WeaponConfig.DefaultDeployTime
    return result
end

function CDEAGLE:WeaponIdle() -- override
    self:ResetEmptySound()
    self.m_pPlayer:GetAutoaimVector(AUTOAIM_10DEGREES)

    if self.m_flTimeWeaponIdle > UTIL_WeaponTimeBase() then
        return
    end

    self.m_flTimeWeaponIdle = UTIL_WeaponTimeBase() + WeaponConfig.WeaponIdleTime
	if FBitSet(self.m_iWeaponState, WPNSTATE_SHIELD_DRAWN) then
        self:SendWeaponAnim(SHIELDGUN_DRAWN_IDLE, self:UseDecrement() ~= FALSE);
    end
end

function CDEAGLE:UseDecrement()  -- override {
    if CLIENT_WEAPONS then
		return TRUE
    else
        return FALSE
    end
end

function CDEAGLE:GetDamage()
    local Damage = {
        [DT_NONE] = WeaponConfig.DamageDefault,
        [DT_ZB] = WeaponConfig.DamageZB,
        [DT_ZBS] = WeaponConfig.DamageZBS
    }
	return Damage[GetDamageTrack and GetDamageTrack() or DT_NONE]
end

function CDEAGLE:GetKnockBackData() -- override
    return WeaponConfig.KnockBack
end

function CDEAGLE:GetMaxSpeed() -- override
    return WeaponConfig.PlayerMaxSpeed
end

function CDEAGLE:GetCSModelName()
    return WeaponConfig.W_Model
end

function CDEAGLE:iItemSlot()
    return WeaponConfig.ItemSlot
end

function CDEAGLE:GetBuyAmmoConfig()
    return WeaponConfig.BuyAmmoConfig
end
