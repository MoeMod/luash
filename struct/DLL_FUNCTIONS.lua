-- (.+[\s\t].?\(\*)(\w+)(\s?\).+)
-- \t"$2", \t--$1$3
local enum = require("core/enum")
DLL_FUNCTIONS = enum {
	"pfnGameInit", 	--    void	(*)( void );				
	"pfnSpawn", 	--	int	(*)( edict_t *pent );
	"pfnThink", 	--	void	(*)( edict_t *pent );
	"pfnUse", 	--	void	(*)( edict_t *pentUsed, edict_t *pentOther );
	"pfnTouch", 	--	void	(*)( edict_t *pentTouched, edict_t *pentOther );
	"pfnBlocked", 	--	void	(*)( edict_t *pentBlocked, edict_t *pentOther );
	"pfnKeyValue", 	--	void	(*)( edict_t *pentKeyvalue, KeyValueData *pkvd );
	"pfnSave", 	--	void	(*)( edict_t *pent, SAVERESTOREDATA *pSaveData );
	"pfnRestore", 	--	int 	(*)( edict_t *pent, SAVERESTOREDATA *pSaveData, int globalEntity );
	"pfnSetAbsBox", 	--	void	(*)( edict_t *pent );
	"pfnSaveWriteFields", 	--	void	(*)( SAVERESTOREDATA*, const char*, void*, TYPEDESCRIPTION*, int );
	"pfnSaveReadFields", 	--	void	(*)( SAVERESTOREDATA*, const char*, void*, TYPEDESCRIPTION*, int );
	"pfnSaveGlobalState", 	--	void	(*)( SAVERESTOREDATA * );
	"pfnRestoreGlobalState", 	--	void	(*)( SAVERESTOREDATA * );
	"pfnResetGlobalState", 	--	void	(*)( void );
	"pfnClientConnect", 	--	qboolean	(*)( edict_t *pEntity, const char *pszName, const char *pszAddress, char szRejectReason[128] );
	"pfnClientDisconnect", 	--	void	(*)( edict_t *pEntity );
	"pfnClientKill", 	--	void	(*)( edict_t *pEntity );
	"pfnClientPutInServer", 	--	void	(*)( edict_t *pEntity );
	"pfnClientCommand", 	--	void	(*)( edict_t *pEntity );
	"pfnClientUserInfoChanged", 	--	void	(*)( edict_t *pEntity, char *infobuffer );
	"pfnServerActivate", 	--	void	(*)( edict_t *pEdictList, int edictCount, int clientMax );
	"pfnServerDeactivate", 	--	void	(*)( void );
	"pfnPlayerPreThink", 	--	void	(*)( edict_t *pEntity );
	"pfnPlayerPostThink", 	--	void	(*)( edict_t *pEntity );
	"pfnStartFrame", 	--	void	(*)( void );
	"pfnParmsNewLevel", 	--	void	(*)( void );
	"pfnParmsChangeLevel", 	--	void	(*)( void );
	"pfnGetGameDescription", 	--	const char     *(*)( void );     
	"pfnPlayerCustomization", 	--	void	(*)( edict_t *pEntity, customization_t *pCustom );
	"pfnSpectatorConnect", 	--	void	(*)( edict_t *pEntity );
	"pfnSpectatorDisconnect", 	--	void	(*)( edict_t *pEntity );
	"pfnSpectatorThink", 	--	void	(*)( edict_t *pEntity );
	"pfnSys_Error", 	--	void	(*)( const char *error_string );
	"pfnPM_Move", 	--	void	(*)( struct playermove_s *ppmove, qboolean server );
	"pfnPM_Init", 	--	void	(*)( struct playermove_s *ppmove );
	"pfnPM_FindTextureType", 	--	char	(*)( char *name );
	"pfnSetupVisibility", 	--	void	(*)( struct edict_s *pViewEntity, struct edict_s *pClient, unsigned char **pvs, unsigned char **pas );
	"pfnUpdateClientData", 	--	void	(*) ( const struct edict_s *ent, int sendweapons, struct clientdata_s *cd );
	"pfnAddToFullPack", 	--	int	(*)( struct entity_state_s *state, int e, edict_t *ent, edict_t *host, int hostflags, int player, unsigned char *pSet );
	"pfnCreateBaseline", 	--	void	(*)( int player, int eindex, struct entity_state_s *baseline, struct edict_s *entity, int playermodelindex, vec3_t player_mins, vec3_t player_maxs );
	"pfnRegisterEncoders", 	--	void	(*)( void );
	"pfnGetWeaponData", 	--	int	(*)( struct edict_s *player, struct weapon_data_s *info );
	"pfnCmdStart", 	--	void	(*)( const edict_t *player, struct usercmd_s *cmd, unsigned int random_seed );
	"pfnCmdEnd", 	--	void	(*)( const edict_t *player );
	"pfnConnectionlessPacket", 	--	int	(* )( const struct netadr_s *net_from, const char *args, char *response_buffer, int *response_buffer_size );
	"pfnGetHullBounds", 	--	int	(*)	( int hullnumber, float *mins, float *maxs );
	"pfnCreateInstancedBaselines", 	--	void	(*) ( void );
	"pfnInconsistentFile", 	--	int	(*)( const struct edict_s *player, const char *filename, char *disconnect_message );
	"pfnAllowLagCompensation", 	--	int	(*)( void );
}
return DLL_FUNCTIONS