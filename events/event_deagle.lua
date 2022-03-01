
require("events/events")

local deagle_e =  {
	DEAGLE_IDLE = 0,
	DEAGLE_SHOOT1 = 1,
	DEAGLE_SHOOT2 = 2,
	DEAGLE_SHOOT_EMPTY = 3,
	DEAGLE_RELOAD = 4,
	DEAGLE_DRAW = 5
}

local function EV_FireDEAGLE( args )
	local empty = args.bparam1 == 0
	local idx = args.entindex
	local origin = args.origin
	local angles = {
		args.iparam1 / 100.0 + args.angles[1],
		args.iparam2 / 100.0 + args.angles[2],
		args.angles[3]
	}
    print(empty)
	local velocity = args.velocity
	local forward, right, up = AngleVectors(angles)

	local ShellVelocity = {}
	local ShellOrigin = {}

	if EV_IsLocal( idx ) then
		EV_AddShotsFired(1)
		EV_MuzzleFlash()

		local seq = 0
		if not empty then
			seq = RandomLong(deagle_e.DEAGLE_SHOOT1, deagle_e.DEAGLE_SHOOT2)
		else
			seq = deagle_e.DEAGLE_SHOOT_EMPTY
		end

		EV_WeaponAnimation(seq, 2)

		if not EV_IsRightHand() then
			EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 35.0, -11.0, -16.0, false)
		else
			EV_GetDefaultShellInfo(args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 35.0, -11.0, 16.0, false)
		end
	else
		EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 20.0, -12.0, 4.0, false)
	end

	local shell = EV_FindModelIndex("models/pshell.mdl")
	EV_EjectBrass(ShellOrigin, ShellVelocity, angles[ YAW ], shell, TE_BOUNCE_SHELL)
	EV_PlaySound(idx, origin, CHAN_WEAPON, (RandomLong(0, 1) == 1 and "weapons/deagle-1.wav" or "weapons/deagle-2.wav"), 1.0, 2.0, 0, 94 + RandomLong(0, 0xf))

	local vecSrc = {}
	EV_GetGunPosition( args, vecSrc, origin )
	local vecAiming = {}
	VectorCopy(forward, vecAiming)
	local vSpread = { args.fparam1, args.fparam2 }
	EV_HLDM_FireBullets( idx, forward, right, up, 1, vecSrc, vecAiming, vSpread, 8192.0, BULLET_PLAYER_50AE, 2 )
end

return EV_FireDEAGLE