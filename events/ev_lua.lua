DONT_REQUIRE_ME()
-- for IDE-friendly decl only
-- DO NOT require me !

function EV_IsLocal(index) return false end
function EV_IsPlayer(index) return false end
function EV_MuzzleFlash() end
function EV_WeaponAnimation(sequence, body) end
function EV_LocalPlayerViewheight() return {0,0,0} end
function EV_EjectBrass(ShellOrigin, ShellVelocity, rotation, shell, soundtype, life) end
function EV_PlaySound(idx, origin, channel, sample, volume, attenuation, fFlags, pitch) end
function EV_FindModelIndex(name) return 0 end
function EV_HLDM_FireBullets(idx, forward, right, up, cShots, vecSrc, vecDirShooting, vecSpread, flDistance, iBulletType, iPenetration) end
function EV_AddShotsFired(n) end
function EV_IsRightHand() return false end
function RandomLong(a, b) return 0 end
function RandomFloat(a, b) return 0.0 end
