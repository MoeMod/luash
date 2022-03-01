
require("events/events")

local ak47_e =  {
	AK47_IDLE1 = 0,
	AK47_RELOAD = 1,
	AK47_DRAW = 2,
	AK47_SHOOT1 = 3,
	AK47_SHOOT2 = 4,
	AK47_SHOOT3 = 5,
}

local function EV_FireAK47( args )
	local idx = args.entindex
	local origin = args.origin
	local angles = {
		args.iparam1 / 100.0 + args.angles[1],
		args.iparam2 / 100.0 + args.angles[2],
		args.angles[3]
	}
	local velocity = args.velocity
	local forward, right, up = AngleVectors(angles)

	local ShellVelocity = {}
	local ShellOrigin = {}

	if EV_IsLocal( idx ) then
		EV_AddShotsFired(1)

		local seq = RandomLong(ak47_e.AK47_SHOOT1, ak47_e.AK47_SHOOT3)

		EV_WeaponAnimation(seq, 2)

		if not EV_IsRightHand() then
			EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 20.0, -8.0, -10.0, false)
		else
			EV_GetDefaultShellInfo(args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 20.0, -8.0, 10.0, false)
		end
	else
		EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 20.0, -12.0, 4.0, false)
	end

	local shell = EV_FindModelIndex("models/rshell.mdl")
	EV_EjectBrass(ShellOrigin, ShellVelocity, angles[ YAW ], shell, TE_BOUNCE_SHELL)

	EV_PlaySound(idx, origin, CHAN_WEAPON, (RandomLong(0, 1) == 1 and "weapons/ak47-1.wav" or "weapons/ak47-2.wav"), 1.0, ATTN_NORM, 0, 94 + RandomLong(0, 0xf))

	local vecSrc = {}
	EV_GetGunPosition( args, vecSrc, origin )
	local vecAiming = {}
	VectorCopy(forward, vecAiming)
	local vSpread = { args.fparam1, args.fparam2 }
	EV_HLDM_FireBullets( idx, forward, right, up, 1, vecSrc, vecAiming, vSpread, 8192.0, BULLET_PLAYER_762MM, 2 )
end

return EV_FireAK47