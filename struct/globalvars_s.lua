local enum = require("core/enum")
globalvars_s = enum {	
	"time",	 -- time_point_t
	"frametime",	 -- duration_t
	"force_retouch",	 -- float
	"mapname",	 -- string_t
	"startspot",	 -- string_t
	"deathmatch",	 -- float
	"coop",	 -- float
	"teamplay",	 -- float
	"serverflags",	 -- float
	"found_secrets",	 -- float
	"v_forward",	 -- vec3_t
	"v_up",	 -- vec3_t
	"v_right",	 -- vec3_t
	"trace_allsolid",	 -- float
	"trace_startsolid",	 -- float
	"trace_fraction",	 -- float
	"trace_endpos",	 -- vec3_t
	"trace_plane_normal",	 -- vec3_t
	"trace_plane_dist",	 -- float
	"trace_ent",	 -- edict_t *
	"trace_inopen",	 -- float
	"trace_inwater",	 -- float
	"trace_hitgroup",	 -- int
	"trace_flags",	 -- int
	"changelevel",	 -- int	// transition in progress when true (was msg_entity)
	"cdAudioTrack",	 -- int
	"maxClients",	 -- int
	"maxEntities",	 -- int
	"pStringBase",	 -- const char	*
	"pSaveData",	 -- SAVERESTOREDATA *r
	"vecLandmarkOffset",	 -- vec3_t
}
globalvars_t = globalvars_s
return globalvars_s