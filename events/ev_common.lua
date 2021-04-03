local DEFAULT_VIEWHEIGHT = 28
local VEC_DUCK_VIEW = 12

function EV_GetGunPosition(args, out_pos, origin)
    local idx = args.entindex
    local view_ofs = { 0, 0, DEFAULT_VIEWHEIGHT }
    if EV_IsPlayer(idx) then
        view_ofs = EV_LocalPlayerViewheight()
    elseif args.ducking == 1 then
        view_ofs[3] = VEC_DUCK_VIEW
    end

    VectorAdd( origin, view_ofs, out_pos )
    return out_pos
end

function EV_GetDefaultShellInfo(args, origin, velocity, out_ShellVelocity, out_ShellOrigin, forward, right, up, forwardScale, upScale, rightScale, bReverseDirection)
    local idx = args.entindex
    local view_ofs = { 0, 0, DEFAULT_VIEWHEIGHT }
    if EV_IsPlayer(idx) then
        view_ofs = EV_LocalPlayerViewheight()
    elseif args.ducking == 1 then
        view_ofs[3] = VEC_DUCK_VIEW
    end

    local fR = RandomFloat( 50, 70 )
	local fU = RandomFloat( 75, 175 )
	local fF = RandomFloat( 25, 250 )
	local fDirection = rightScale > 0.0 and -1.0 or 1.0

    for i=1, 3 do
        if( bReverseDirection ) then
			out_ShellVelocity[i] = velocity[i] * 0.5 - right[i] * fR * fDirection + up[i] * fU + forward[i] * fF
		else
			out_ShellVelocity[i] = velocity[i] * 0.5 + right[i] * fR * fDirection + up[i] * fU + forward[i] * fF
        end

		out_ShellOrigin[i] = velocity[i] * 0.1 + origin[i] + view_ofs[i] + upScale * up[i] + forwardScale * forward[i] + rightScale * right[i]
    end
end

return {}