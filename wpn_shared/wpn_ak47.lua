
CAK47 = CAK47 or class("CAK47", CBasePlayerWeapon)

local WeaponConfig = {
    ClassName = "weapon_ak47",
    AmmoType = "762Nato",
    MaxAmmo = 90,
    AmmoType2 = nil,
    MaxAmmo2 = -1,
    MaxClip = 30,
    ItemSlot = PRIMARY_WEAPON_SLOT,
    ItemPosition = 1,
    WeaponId = WEAPON_AK47,
    Weight = 25,
    V_Model = "models/v_ak47.mdl",
    P_Model = "models/p_ak47.mdl",
    W_Model = "models/w_ak47.mdl",
    EventFile = "addons/luash/events/event_ak47.lua",
    AnimExtension = "rifle",
    DefaultReloadTime = 2.2,
    DefaultDeployTime = 0.75,
    WeaponIdleTime = 20,
    DamageDefault = 36,
    DamageZB = 42,
    DamageZBS = 42,
    AccuracyMin = 0.2,
    AccuracyMax = 1.25,
    AccuracyDefault = 0.2,
    AccuracyCalc = function(N) return ((N * N * N) / 200.0) + 0.35 end,
    SpreadCalcNotOnGround = function(A) return 0.04 + (0.4) * A end,
    SpreadCalcWalking = function(A) return 0.04 + (0.07) * A end,
    SpreadCalcDefault = function(A) return 0.0275 end,
    SpreadCalcDucking = function(A) return 0.0275 end,
    CycleTime = 0.0955,
    KickBackWalking = {1.5, 0.45, 0.225, 0.05, 6.5, 2.5, 7},
    KickBackNotOnGround = {2.0, 1.0, 0.5, 0.35, 9.0, 6.0, 5},
    KickBackDucking = {0.9, 0.35, 0.15, 0.025, 5.5, 1.5, 9},
    KickBackDefault = {1.0, 0.375, 0.175, 0.0375, 5.75, 1.75, 8},
    KnockBack = {350.0, 250.0, 200.0, 100.0, 0.6},
    Distance = 8192,
    Penetration = 2,
    RangeModifier = 0.98,
    BulletType = BULLET_PLAYER_762MM,
    PlayerMaxSpeed = 221,
}

local ANIM_IDLE1 = 0
local ANIM_RELOAD = 1
local ANIM_DRAW = 2

LINK_ENTITY_TO_CLASS(WeaponConfig.ClassName, CAK47)

function CAK47:Spawn() -- override
	self.pev.classname = MAKE_STRING(WeaponConfig.ClassName)

	self:Precache();
	self.m_iId = WeaponConfig.WeaponId;
	SET_MODEL(self, WeaponConfig.W_Model);

	self.m_iDefaultAmmo = WeaponConfig.MaxClip;
	self.m_flAccuracy = WeaponConfig.AccuracyDefault;
	self.m_iShotsFired = 0;

	self:FallInit();
end

function CAK47:Precache() -- override
	PRECACHE_MODEL(WeaponConfig.V_Model)
	PRECACHE_MODEL(WeaponConfig.P_Model)
	PRECACHE_MODEL(WeaponConfig.W_Model);

	self.m_iShell = PRECACHE_MODEL("models/rshell.mdl");
	self.m_usFireAK47 = PRECACHE_EVENT(1, WeaponConfig.EventFile);
end

function CAK47:GetItemInfo(p) -- override
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

function CAK47:PrimaryAttack() -- override
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

function CAK47:WeaponFire(flSpread, flCycleTime, fUseAutoAim)
    self.m_bDelayFire = true;
	self.m_iShotsFired = self.m_iShotsFired + 1;
    self.m_flAccuracy = math.min(math.max(WeaponConfig.AccuracyMin, WeaponConfig.AccuracyCalc(self.m_iShotsFired)), WeaponConfig.AccuracyMax)

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

	PLAYBACK_EVENT_FULL(flags, self.m_pPlayer, self.m_usFireAK47, 0, {0,0,0}, {0,0,0}, vecDir[1], vecDir[2], self.m_pPlayer.pev.punchangle[1] * 100, self.m_pPlayer.pev.punchangle[2] * 100, FALSE, FALSE);

	self.m_pPlayer.m_iWeaponVolume = NORMAL_GUN_VOLUME
	self.m_pPlayer.m_iWeaponFlash = BRIGHT_GUN_FLASH
	self.m_flNextPrimaryAttack = UTIL_WeaponTimeBase() + flCycleTime
    self.m_flNextSecondaryAttack = UTIL_WeaponTimeBase() + flCycleTime

    if not CLIENT_DLL then
        if self.m_iClip == 0 and self.m_pPlayer.m_rgAmmo[self.m_iPrimaryAmmoType] <= 0 then
            self.m_pPlayer:SetSuitUpdate("!HEV_AMO0", FALSE, 0)
        end
    end
	self.m_flTimeWeaponIdle = UTIL_WeaponTimeBase() + 1.9

	if VectorLength2D(self.m_pPlayer.pev.velocity) > 0 then
		self:KickBack(unpack(WeaponConfig.KickBackWalking))
	elseif not FBitSet(self.m_pPlayer.pev.flags, FL_ONGROUND) then
		self:KickBack(unpack(WeaponConfig.KickBackNotOnGround))
	elseif FBitSet(self.m_pPlayer.pev.flags, FL_DUCKING) then
		self:KickBack(unpack(WeaponConfig.KickBackDucking))
	else
		self:KickBack(unpack(WeaponConfig.KickBackDefault))
    end
end

function CAK47:Reload() -- override
	if self:DefaultReload(WeaponConfig.MaxClip, ANIM_RELOAD, WeaponConfig.DefaultReloadTime, 0) then
        if not CLIENT_DLL then
            self.m_pPlayer:SetAnimation(PLAYER_RELOAD)
        end
		self.m_flAccuracy = WeaponConfig.AccuracyDefault
		self.m_iShotsFired = 0
		self.m_bDelayFire = false
    end
end

function CAK47:Deploy()
	self.m_flAccuracy = WeaponConfig.AccuracyDefault
	self.m_iShotsFired = 0
	self.iShellOn = 1
	local result = self:DefaultDeploy(WeaponConfig.V_Model, WeaponConfig.P_Model, ANIM_DRAW, WeaponConfig.AnimExtension, self:UseDecrement() ~= FALSE)
	self.m_pPlayer.m_flNextAttack = WeaponConfig.DefaultDeployTime
    return result
end

function CAK47:WeaponIdle() -- override
    self:ResetEmptySound()
    self.m_pPlayer:GetAutoaimVector(AUTOAIM_10DEGREES)

    if self.m_flTimeWeaponIdle > UTIL_WeaponTimeBase() then
        return
    end

    self.m_flTimeWeaponIdle = UTIL_WeaponTimeBase() + WeaponConfig.WeaponIdleTime
    self:SendWeaponAnim(ANIM_IDLE1, self:UseDecrement() ~= FALSE)
end

function CAK47:UseDecrement()  -- override {
    if CLIENT_WEAPONS then
		return TRUE
    else
        return FALSE
    end
end

function CAK47:GetDamage()
    local Damage = {
        [DT_NONE] = WeaponConfig.DamageDefault,
        [DT_ZB] = WeaponConfig.DamageZB,
        [DT_ZBS] = WeaponConfig.DamageZBS
    }
	return Damage[GetDamageTrack and GetDamageTrack() or DT_NONE]
end

function CAK47:GetKnockBackData() -- override
    return WeaponConfig.KnockBack
end

function CAK47:GetMaxSpeed() -- override
    return WeaponConfig.PlayerMaxSpeed
end

function CAK47:GetCSModelName()
    return WeaponConfig.W_Model
end

function CAK47:iItemSlot()
    return WeaponConfig.ItemSlot
end

function CAK47:GetBuyAmmoConfig()
    return { "ammo_762nato" , 90 }
end
