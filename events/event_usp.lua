
require("events/events")

local usp_e =  {
	USP_IDLE = 0,
	USP_SHOOT1 = 1,
	USP_SHOOT2 = 2,
	USP_SHOOT3 = 3,
	USP_SHOOT_EMPTY = 4,
	USP_RELOAD = 5,
	USP_DRAW = 6,
	USP_ATTACH_SILENCER = 7,
	USP_UNSIL_IDLE = 8,
	USP_UNSIL_SHOOT1 = 9,
	USP_UNSIL_SHOOT2 = 10,
	USP_UNSIL_SHOOT3 = 11,
	USP_UNSIL_SHOOT_EMPTY = 12,
	USP_UNSIL_RELOAD = 13,
	USP_UNSIL_DRAW = 14,
	USP_DETACH_SILENCER = 15,
}

local function EV_FireUSP( args )
    local silencer_on = args[event_args_t.bparam2] ~= 0
	local empty = args[event_args_t.bparam1] == 0
	local idx = args[event_args_t.entindex]
	local origin = args[event_args_t.origin]
	local angles = {
		args[event_args_t.iparam1] / 100.0 + args[event_args_t.angles][1],
		args[event_args_t.iparam2] / 100.0 + args[event_args_t.angles][2],
		args[event_args_t.angles][3]
	}
	local velocity = args[event_args_t.velocity]
	local forward, right, up = AngleVectors(angles)

	local ShellVelocity = {}
	local ShellOrigin = {}

	if EV_IsLocal( idx ) then
		EV_AddShotsFired(1)

		local seq = 0
		if silencer_on then
			if not empty then
				seq = RandomLong(usp_e.USP_SHOOT1, usp_e.USP_SHOOT3)
			else
				seq = usp_e.USP_SHOOT_EMPTY
			end
		else
			if not empty then
				seq = RandomLong(usp_e.USP_UNSIL_SHOOT1, usp_e.USP_UNSIL_SHOOT3)
			else
				seq = usp_e.USP_UNSIL_SHOOT_EMPTY
			end

		end

		EV_WeaponAnimation(seq, 2)

		if EV_IsRightHand() then
			EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 36.0, -14.0, -14.0, false)
		else
			EV_GetDefaultShellInfo(args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 36.0, -14.0, 14.0, false)
		end
	else
		EV_GetDefaultShellInfo( args, origin, velocity, ShellVelocity, ShellOrigin, forward, right, up, 20.0, -12.0, 4.0, false)
	end

	local shell = EV_FindModelIndex("models/pshell.mdl")
	EV_EjectBrass(ShellOrigin, ShellVelocity, angles[ YAW ], shell, TE_BOUNCE_SHELL)

	if silencer_on then
		EV_PlaySound(idx, origin, CHAN_WEAPON, (RandomLong(0, 1) == 1 and "weapons/usp1.wav" or "weapons/usp2.wav"), 1.0, ATTN_NORM, 0, 94 + RandomLong(0, 0xf))
	else
		EV_PlaySound(idx, origin, CHAN_WEAPON, "weapons/usp_unsil-1.wav", 1.0, 2.0, 0, 94 + RandomLong(0, 0xf))
	end

	local vecSrc = {}
	EV_GetGunPosition( args, vecSrc, origin )
	local vecAiming = {}
	VectorCopy(forward, vecAiming)
	local vSpread = { args[event_args_t.fparam1], args[event_args_t.fparam2] }
	EV_HLDM_FireBullets( idx, forward, right, up, 1, vecSrc, vecAiming, vSpread, 8192.0, BULLET_PLAYER_45ACP, 2 )
end

return EV_FireUSP