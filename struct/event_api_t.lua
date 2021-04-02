event_api_t = {
    version = 1,                    -- int
	EV_PlaySound = 2,               -- void	( * ) ( int ent, float *origin, int channel, const char *sample, float volume, float attenuation, int fFlags, int pitch );
	EV_StopSound = 3,               -- void	( * ) ( int ent, int channel, const char *sample );
	EV_FindModelIndex = 4,          -- int		( * )( const char *pmodel );
	EV_IsLocal = 5,                 -- int		( * ) ( int playernum );
	EV_LocalPlayerDucking = 6,      -- int		( * ) ( void );
	EV_LocalPlayerViewheight = 7,   -- void	( * ) ( float * );
	EV_LocalPlayerBounds = 8,       -- void	( * ) ( int hull, float *mins, float *maxs );
	EV_IndexFromTrace = 9,          -- int		( *) ( struct pmtrace_s *pTrace );
	EV_GetPhysent = 10,             -- struct physent_s *( * ) ( int idx );
	EV_SetUpPlayerPrediction = 11,  -- void	( * ) ( int dopred, int bIncludeLocalClient );
	EV_PushPMStates = 12,           -- void	( * ) ( void );
	EV_PopPMStates = 13,            -- void	( * ) ( void );
	EV_SetSolidPlayers = 14,        -- void	( * ) (int playernum);
	EV_SetTraceHull = 15,           -- void	( * ) ( int hull );
	EV_PlayerTrace = 16,            -- void	( * ) ( float *start, float *end, int traceFlags, int ignore_pe, struct pmtrace_s *tr );
	EV_WeaponAnimation = 17,        -- void	( * ) ( int sequence, int body );
	EV_PrecacheEvent = 18,          -- unsigned short ( * ) ( int type, const char* psz );
	EV_PlaybackEvent = 19,          -- void	( * ) ( int flags, const struct edict_s *pInvoker, unsigned short eventindex, float delay, float *origin, float *angles, float fparam1, float fparam2, int iparam1, int iparam2, int bparam1, int bparam2 );
	EV_TraceTexture = 20,           -- const char *( * ) ( int ground, float *vstart, float *vend );
	EV_StopAllSounds = 21,          -- void	( * ) ( int entnum, int entchannel );
	EV_KillEvents = 22,             -- void    ( * ) ( int entnum, const char *eventname );
}
event_api_s = event_api_t
return event_api_t