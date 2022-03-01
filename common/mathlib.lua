
-- up / down
    PITCH = 1
-- left / right
    YAW = 2
-- fall over
    ROLL = 3

function VectorCopy(a, out)
    out = out or {}
    out[1] = a[1]
    out[2] = a[2]
    out[3] = a[3]
    return out
end

function VectorSet(out, x, y, z)
    out[1] = x
    out[2] = y
    out[3] = z
end

function VectorSubtract(a, b, out)
    out = out or {}
    out[1] = a[1] - b[1]
    out[2] = a[2] - b[2]
    out[3] = a[3] - b[3]
    return out
end

function VectorAdd(a, b, out)
    out = out or {}
    out[1] = a[1] + b[1]
    out[2] = a[2] + b[2]
    out[3] = a[3] + b[3]
    return out
end

function VectorClear(out, x, y, z)
    VectorSet(out, 0.0, 0.0, 0.0)
end

function DotProduct(a, b)
    return (a[1]*b[1]+a[2]*b[2]+a[3]*b[3])
end

function VectorMA(a, scale, b, out)
    out = out or {}
    out[1] = a[1] * scale + b[1]
    out[2] = a[2] * scale + b[2]
    out[3] = a[3] * scale + b[3]
    return out
end

local function hypot(a, b, c)
    c = c or 0
    return math.sqrt(a * a + b * b + c * c)
end

function VectorLength(vec)
    return hypot(vec[1], vec[2], vec[3])
end

function VectorLength2D(vec)
    return hypot(vec[1], vec[2])
end

function VectorScale(a, scale, out)
    out = out or {}
    out[1] = a[1] * scale
    out[2] = a[2] * scale
    out[3] = a[3] * scale
    return out
end

function VectorNormalize(a, out)
    return VectorScale(a, 1 / Length(a), out)
end

function VectorInverse(a, out)
    out = out or {}
    out[1] = -a[1]
    out[2] = -a[2]
    out[3] = -a[3]
    return out
end

function VectorCompare(a, b)
    return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
end

function CrossProduct(a, b)
    return {a[2] * b[3] - a[3] * b[2], a[3] * b[1] - a[1] * b[3], a[1] * b[2] - a[2] * b[1]}
end

M_PI = 3.14159265358979323846

function RAD2DEG(x)
    --return x * (180 / M_PI)
    return math.deg(x)
end

function DEG2RAD(x)
    --return x * (M_PI / 180)
    return math.rad(x)
end

function AngleBetweenVectors(a, b)
    return DotProduct(a, b)
end

function AngleVectors(angles, out_forward, out_right, out_up)
    local sp = math.sin(DEG2RAD(angles[PITCH]))
    local sy = math.sin(DEG2RAD(angles[YAW]))
    local sr = math.sin(DEG2RAD(angles[ROLL]))
    local cp = math.cos(DEG2RAD(angles[PITCH]))
    local cy = math.cos(DEG2RAD(angles[YAW]))
    local cr = math.cos(DEG2RAD(angles[ROLL]))
    out_forward = out_forward or {}
    out_right = out_right or {}
    out_up = out_up or {}
    VectorSet(out_forward, cp * cy, cp * sy, -sp)
    VectorSet(out_right, (-sr * sp * cy + -cr * -sy), (-sr * sp * sy + -cr * cy), (-sr * cp))
    VectorSet(out_up, (cr * sp * cy + -sr * -sy), (cr * sp * sy + -sr * cy), (cr * cp))
    return out_forward, out_right, out_up
end

function VectorAngles(forward, out_angles)
    out_angles = out_angles or {}

    if  forward[1] == 0 and forward[2] == 0 then
		-- fast case
		out_angles[YAW] = 0
		if forward[3] > 0 then
			out_angles[PITCH] = 90
		else 
            out_angles[PITCH] = 270
        end
	else
		out_angles[YAW] = RAD2DEG(math.atan(forward[2], forward[1]))
		if out_angles[YAW] < 0 then
            out_angles[YAW] = out_angles[YAW] + 360
        end

		local tmp = hypot(forward[1], forward[2])
		out_angles[PITCH] = RAD2DEG(math.atan(forward[3], tmp))
		if out_angles[PITCH] < 0 then
            out_angles[YAW] = out_angles[YAW] + 360
        end
    end

	out_angles[ROLL] = 0
    return out_angles
end

return {}