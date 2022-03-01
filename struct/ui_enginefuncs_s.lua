ui_enginefuncs_s = {
	pfnPIC_Load = 1, -- HIMAGE	(*)( const char *szPicName, const byte *ucRawImage, long ulRawImageSize, long flags );
	pfnPIC_Free = 2, -- void	(*)( const char *szPicName );
	pfnPIC_Width = 3, -- int	(*)( HIMAGE hPic );
	pfnPIC_Height = 4, -- int	(*)( HIMAGE hPic );
	pfnPIC_Set = 5, -- void	(*)( HIMAGE hPic, int r, int g, int b, int a );
	pfnPIC_Draw = 6, -- void	(*)( int x, int y, int width, int height, const wrect_t *prc );
	pfnPIC_DrawHoles = 7, -- void	(*)( int x, int y, int width, int height, const wrect_t *prc );
	pfnPIC_DrawTrans = 8, -- void	(*)( int x, int y, int width, int height, const wrect_t *prc );
	pfnPIC_DrawAdditive = 9, -- void	(*)( int x, int y, int width, int height, const wrect_t *prc );
	pfnPIC_EnableScissor = 10, -- void	(*)( int x, int y, int width, int height );
	pfnPIC_DisableScissor = 11, -- void	(*)( void );
	pfnFillRGBA = 12, -- void	(*)( int x, int y, int width, int height, int r, int g, int b, int a );
	pfnRegisterVariable = 13, -- cvar_t*	(*)( const char *szName, const char *szValue, int flags );
	pfnGetCvarFloat = 14, -- float	(*)( const char *szName );
	pfnGetCvarString = 15, -- char*	(*)( const char *szName );
	pfnCvarSetString = 16, -- void	(*)( const char *szName, const char *szValue );
	pfnCvarSetValue = 17, -- void	(*)( const char *szName, float flValue );
	pfnAddCommand = 18, -- int	(*)( const char *cmd_name, void (*function)(void) );
	pfnClientCmd = 19, -- void	(*)( int execute_now, const char *szCmdString );
	pfnDelCommand = 20, -- void	(*)( const char *cmd_name );
	pfnCmdArgc = 21, -- int       (*)( void );	
	pfnCmdArgv = 22, -- char*	(*)( int argc );
	pfnCmd_Args = 23, -- char*	(*)( void );
	Con_Printf = 24, -- void	(*)( const char *fmt, ... );
	Con_DPrintf = 25, -- void	(*)( const char *fmt, ... );
	Con_NPrintf = 26, -- void	(*)( int pos, const char *fmt, ... );
	Con_NXPrintf = 27, -- void	(*)( struct con_nprint_s *info, const char *fmt, ... );
	pfnPlayLocalSound = 28, -- void	(*)( const char *szSound );
	pfnDrawLogo = 29, -- void	(*)( const char *filename, float x, float y, float width, float height );
	pfnGetLogoWidth = 30, -- int	(*)( void );
	pfnGetLogoHeight = 31, -- int	(*)( void );
	pfnGetLogoLength = 32, -- float	(*)( void );	// cinematic duration in seconds
	pfnDrawCharacter = 33, -- void	(*)( int x, int y, int width, int height, int ch, int ulRGBA, HIMAGE hFont );
	pfnDrawConsoleString = 34, -- int	(*)( int x, int y, const char *string );
	pfnDrawSetTextColor = 35, -- void	(*)( int r, int g, int b, int alpha );
	pfnDrawConsoleStringLen = 36, -- void	(*)(  const char *string, int *length, int *height );
	pfnSetConsoleDefaultColor = 37, -- void	(*)( int r, int g, int b ); // color must came from colors.lst
	pfnGetPlayerModel = 38, -- struct cl_entity_s* (*)( void );	// for drawing playermodel previews
	pfnSetModel = 39, -- void	(*)( struct cl_entity_s *ed, const char *path );
	pfnClearScene = 40, -- void	(*)( void );
	pfnRenderScene = 41, -- void	(*)( const struct ref_params_s *fd );
	CL_CreateVisibleEntity = 42, -- int	(*)( int type, struct cl_entity_s *ent );
	pfnHostError = 43, -- void	(*)( const char *szFmt, ... );
	pfnFileExists = 44, -- int	(*)( const char *filename, int gamedironly );
	pfnGetGameDir = 45, -- void	(*)( char *szGetGameDir );
	pfnCreateMapsList = 46, -- int	(*)( int fRefresh );
	pfnClientInGame = 47, -- int	(*)( void );
	pfnClientJoin = 48, -- void	(*)( const struct netadr_s adr );
	COM_LoadFile = 49, -- byte*	(*)( const char *filename, int *pLength );
	COM_ParseFile = 50, -- char*	(*)( char *data, char *token );
	COM_FreeFile = 51, -- void	(*)( void *buffer );
	pfnKeyClearStates = 52, -- void	(*)( void );				// call when menu open or close
	pfnSetKeyDest = 53, -- void	(*)( int dest );
	pfnKeynumToString = 54, -- const char *(*)( int keynum );
	pfnKeyGetBinding = 55, -- const char *(*)( int keynum );
	pfnKeySetBinding = 56, -- void	(*)( int keynum, const char *binding );
	pfnKeyIsDown = 57, -- int	(*)( int keynum );
	pfnKeyGetOverstrikeMode = 58, -- int	(*)( void );
	pfnKeySetOverstrikeMode = 59, -- void	(*)( int fActive );
	pfnKeyGetState = 60, -- void	*(*)( const char *name );			// for mlook, klook etc
	pfnMemAlloc = 61, -- void*	(*)( size_t cb, const char *filename, const int fileline );
	pfnMemFree = 62, -- void	(*)( void *mem, const char *filename, const int fileline );
	pfnGetGameInfo = 63, -- int	(*)( GAMEINFO *pgameinfo );
	pfnGetGamesList = 64, -- GAMEINFO	**(*)( int *numGames );			// collect info about all mods
	pfnGetFilesList = 65, -- char 	**(*)( const char *pattern, int *numFiles, int gamedironly );	// find in files
	pfnGetSaveComment = 66, -- int 	(*)( const char *savename, char *comment );
	pfnGetDemoComment = 67, -- int	(*)( const char *demoname, char *comment );
	pfnCheckGameDll = 68, -- int	(*)( void );				// returns false if hl.dll is missed or invalid
	pfnGetClipboardData = 69, -- char	*(*)( void );
	pfnShellExecute = 70, -- void	(*)( const char *name, const char *args, int closeEngine );
	pfnWriteServerConfig = 71, -- void	(*)( const char *name );
	pfnChangeInstance = 72, -- void	(*)( const char *newInstance, const char *szFinalMessage );
	pfnPlayBackgroundTrack = 73, -- void	(*)( const char *introName, const char *loopName );
	pfnHostEndGame = 74, -- void	(*)( const char *szFinalMessage );
	pfnRandomFloat = 75, -- float	(*)( float flLow, float flHigh );	
	pfnRandomLong = 76, -- long	(*)( long lLow, long lHigh );
	pfnSetCursor = 77, -- void	(*)( void *hCursor );			// change cursor
	pfnIsMapValid = 78, -- int	(*)( const char *filename );
	pfnProcessImage = 79, -- void	(*)( int texnum, float gamma, int topColor, int bottomColor );
	pfnCompareFileTime = 80, -- int	(*)( char *filename1, char *filename2, int *iCompare );
	pfnGetModeString = 81, -- const char *(*)( int vid_mode );
}
ui_enginefuncs_t = ui_enginefuncs_s
return ui_enginefuncs_s