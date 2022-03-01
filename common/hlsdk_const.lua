
CHAN_AUTO = 0
CHAN_WEAPON = 1
CHAN_VOICE = 2
CHAN_ITEM = 3
CHAN_BODY = 4
CHAN_STREAM = 5	-- allocate stream channel from the static or dynamic area
CHAN_STATIC = 6	-- allocate channel from the static area 
CHAN_NETWORKVOICE_BASE = 7	-- voice data coming across the network
CHAN_NETWORKVOICE_END = 500	-- network voice data reserves slots (CHAN_NETWORKVOICE_BASE through CHAN_NETWORKVOICE_END).
CHAN_BOT = 501 -- channel used for bot chatter

ATTN_NONE = 0
ATTN_NORM = 0.8
ATTN_IDLE = 2
ATTN_STATIC = 1.25 

PITCH_NORM = 100 -- non-pitch shifted
PITCH_LOW = 95 -- other values are possible - 0-255, where 255 is very high
PITCH_HIGH = 120

TE_BOUNCE_NULL = 0
TE_BOUNCE_SHELL = 1
TE_BOUNCE_SHOTSHELL = 2

FL_FLY = bit.lshift(1, 0)	-- Changes the SV_Movestep() behavior to not need to be on ground
FL_SWIM = bit.lshift(1, 1)	-- Changes the SV_Movestep() behavior to not need to be on ground (but stay in water)
FL_CONVEYOR = bit.lshift(1, 2)
FL_CLIENT = bit.lshift(1, 3)
FL_INWATER = bit.lshift(1, 4)
FL_MONSTER = bit.lshift(1, 5)
FL_GODMODE = bit.lshift(1, 6)
FL_NOTARGET = bit.lshift(1, 7)
FL_SKIPLOCALHOST = bit.lshift(1, 8)	-- Don't send entity to local host, it's predicting this entity itself
FL_ONGROUND = bit.lshift(1, 9)	-- At rest / on the ground
FL_PARTIALGROUND = bit.lshift(1, 10)	-- not all corners are valid
FL_WATERJUMP = bit.lshift(1, 11)	-- player jumping out of water
FL_FROZEN = bit.lshift(1, 12)	-- Player is frozen for 3rd person camera
FL_FAKECLIENT = bit.lshift(1, 13)	-- JAC: fake client, simulated server side; don't send network messages to them
FL_DUCKING = bit.lshift(1, 14)	-- Player flag -- Player is fully crouched
FL_FLOAT = bit.lshift(1, 15)	-- Apply floating force to this entity when in water
FL_GRAPHED = bit.lshift(1, 16)	-- worldgraph has this ent listed as something that blocks a connection
FL_IMMUNE_WATER = bit.lshift(1, 17)
FL_IMMUNE_SLIME = bit.lshift(1, 18)
FL_IMMUNE_LAVA = bit.lshift(1, 19)
FL_PROXY	 = bit.lshift(1, 20)	-- This is a spectator proxy
FL_ALWAYSTHINK = bit.lshift(1, 21)	-- Brush model flag -- call think every frame regardless of nextthink - ltime (for constantly changing velocity/path)
FL_BASEVELOCITY = bit.lshift(1, 22)	-- Base velocity has been applied this frame (used to convert base velocity into momentum)
FL_MONSTERCLIP = bit.lshift(1, 23)	-- Only collide in with monsters who have FL_MONSTERCLIP set
FL_ONTRAIN	 = bit.lshift(1, 24)	-- Player is _controlling_ a train, so movement commands should be ignored on client during prediction.
FL_WORLDBRUSH = bit.lshift(1, 25)	-- Not moveable/removeable brush entity (really part of the world, but represented as an entity for transparency or something)
FL_SPECTATOR = bit.lshift(1, 26)	-- This client is a spectator, don't run touch functions, etc.
FL_CUSTOMENTITY = bit.lshift(1, 29)	-- This is a custom entity
FL_KILLME	 = bit.lshift(1, 30)	-- This entity is marked for death -- This allows the engine to kill ents at the appropriate time
FL_DORMANT	 = bit.lshift(1, 31)	-- Entity is dormant, no updates to client

EF_BRIGHTFIELD = 1	-- swirling cloud of particles
EF_MUZZLEFLASH = 2	-- single frame ELIGHT on entity attachment 0
EF_BRIGHTLIGHT = 4	-- DLIGHT centered at entity origin
EF_DIMLIGHT = 8	-- player flashlight
EF_INVLIGHT = 16	-- get lighting from ceiling
EF_NOINTERP = 32	-- don't interpolate the next frame
EF_LIGHT = 64	-- rocket flare glow sprite
EF_NODRAW = 128	-- don't draw entity

kRenderNormal = 0		-- src
kRenderTransColor = 1		-- c*a+dest*(1-a)
kRenderTransTexture = 2	-- src*a+dest*(1-a)
kRenderGlow = 3		-- src*a+dest -- No Z buffer checks
kRenderTransAlpha = 4		-- src*srca+dest*(1-srca)
kRenderTransAdd = 5		-- src*a+dest
kRenderWorldGlow = 6		-- Same as kRenderGlow but not fixed size in screen space

kRenderFxNone = 0
kRenderFxPulseSlow = 1
kRenderFxPulseFast = 2
kRenderFxPulseSlowWide = 3
kRenderFxPulseFastWide = 4
kRenderFxFadeSlow = 5
kRenderFxFadeFast = 6
kRenderFxSolidSlow = 7
kRenderFxSolidFast = 8
kRenderFxStrobeSlow = 9
kRenderFxStrobeFast = 10
kRenderFxStrobeFaster = 11
kRenderFxFlickerSlow = 12
kRenderFxFlickerFast = 13
kRenderFxNoDissipation = 14
kRenderFxDistort = 15			-- Distort/scale/translate flicker
kRenderFxHologram = 16			-- kRenderFxDistort + distance fade
kRenderFxDeadPlayer = 17		-- kRenderAmt is the player index
kRenderFxExplode = 18			-- Scale up really big!
kRenderFxGlowShell = 19			-- Glowing Shell
kRenderFxClampMinScale = 20		-- Keep this sprite from getting very small (SPRITES only!)

TRUE = 1
FALSE = 0