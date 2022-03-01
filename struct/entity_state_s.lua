
entity_state_s = {
	-- Fields which are filled in by routines outside of delta compression
				entityType = 1, -- int
	-- Index inato cl_entities array for this entity.
				number = 2, -- int
			msg_time = 3, -- float

	-- Message number last time the player/entity state was updated.
				messagenum = 4, -- int

	-- Fields which can be transitted and reconstructed over the network stream
			origin = 5, -- vec3_t
			angles = 6, -- vec3_t

				modelindex = 7, -- int
				sequence = 8, -- int
			frame = 9, -- float
				colormap = 10, -- int
			skin = 11, -- short
			solid = 12, -- short
				effects = 13, -- int
			scale = 14, -- float

			eflags = 15, -- byte

	-- Render information
				rendermode = 16, -- int
				renderamt = 17, -- int
			rendercolor = 18, -- color24
				renderfx = 19, -- int

				movetype = 20, -- int
			animtime = 21, -- float
			framerate = 22, -- float
				body = 23, -- int
			controller = 24, -- byte[4]
			blending = 25, -- byte[4]
			velocity = 26, -- vec3_t

	-- Send bbox down to client for use during prediction.
			mins = 27, -- vec3_t
			maxs = 28, -- vec3_t

				aiment = 29, -- int
	-- If owned by a player, the index of that player ( for projectiles ).
				owner = 30, -- int

	-- Friction, for prediction.
			friction = 31, -- float
	-- Gravity multiplier
			gravity = 32, -- float

	-- PLAYER SPECIFIC
				team = 33, -- int
				playerclass = 34, -- int
				health = 35, -- int
		spectator = 36, -- qboolean
	         weaponmodel = 37, -- int
				gaitsequence = 38, -- int
	-- If standing on conveyor, e.g.
			basevelocity = 39, -- vec3_t
	-- Use the crouched hull, or the regular player hull.
				usehull = 40, -- int
	-- Latched buttons last time state updated.
				oldbuttons = 41, -- int
	-- -1 = in air, else pmove entity number
				onground = 42, -- int
				iStepLeft = 43, -- int
	-- How fast we are falling
			flFallVelocity = 44, -- float

			fov = 45, -- float
				weaponanim = 46, -- int

	-- Parametric movement overrides
					startpos = 47, -- vec3_t
					endpos = 48, -- vec3_t
					impacttime = 49, -- float
					starttime = 50, -- float

	-- For mods
				iuser1 = 51, -- int
				iuser2 = 52, -- int
				iuser3 = 53, -- int
				iuser4 = 54, -- int
			fuser1 = 55, -- float
			fuser2 = 56, -- float
			fuser3 = 57, -- float
			fuser4 = 58, -- float
			vuser1 = 59, -- vec3_t
			vuser2 = 60, -- vec3_t
			vuser3 = 61, -- vec3_t
			vuser4 = 62 -- vec3_t
}
entity_state_t = entity_state_s
return entity_state_s