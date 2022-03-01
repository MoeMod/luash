
require("events/events")

local m37se_e = {
	M37SE_IDLE1 = 0,
	M37SE_SHOOT1 = 1,
	M37SE_SHOOT2 = 2,
	M37SE_INSERT = 3,
	M37SE_AFTER_RELOAD = 4,
	M37SE_START_RELOAD = 5,
	M37SE_DRAW = 6,
}

local function EV_FireM37se( args )
	local vecSrc = {}
	local vecAiming = {}
	local idx = args[event_args_t.entindex]
	local origin = args[event_args_t.origin]
	local angles = {
		args[event_args_t.iparam1] / 100.0 + args[event_args_t.angles][1],
		args[event_args_t.iparam2] / 100.0 + args[event_args_t.angles][2],
		args[event_args_t.angles][3]
	}
	
	local forward, right, up = AngleVectors(angles)

	if EV_IsLocal( idx ) then
		EV_AddShotsFired(1)
		EV_WeaponAnimation(RandomLong(m37se_e.M37SE_SHOOT1, m37se_e.M37SE_SHOOT2), 2)
	end
	
	EV_PlaySound(idx, origin, CHAN_WEAPON, "CK_WPN/WEAPON/NANOM37/G_SHOOT_NANOM37.wav", 1.0, 2.0, 0, 94 + RandomLong(0, 0xf))
	
	local vSpread = { args[event_args_t.fparam1], args[event_args_t.fparam2] }
	EV_GetGunPosition( args, vecSrc, origin );
	VectorCopy( forward, vecAiming );
	if (args[event_args_t.bparam2] ~= 0) then
		EV_HLDM_FireBullets(idx, forward, right, up, 1, vecSrc, vecAiming, vSpread, 8192.0, BULLET_PLAYER_BUCKSHOT, 1);	
	else
		vSpread[1] = 0.0725
		vSpread[2] = 0.0725
		EV_HLDM_FireBullets(idx, forward, right, up, 8, vecSrc, vecAiming, vSpread, 8192.0, BULLET_PLAYER_BUCKSHOT, 1);
	end
end
return EV_FireM37se

