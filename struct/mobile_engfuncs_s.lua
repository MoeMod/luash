mobile_engfuncs_s = {
	version = 1, -- int ;
	pfnVibrate = 2, -- void (*)( float life, char flags );
	pfnEnableTextInput = 3, -- void (*)( int enable );
	pfnTouchAddClientButton = 4, -- void (*)( const char *name, const char *texture, const char *command, float x1, float y1, float x2, float y2, unsigned char *color, int round, float aspect, int flags );
	pfnTouchAddDefaultButton = 5, -- void (*)( const char *name, const char *texturefile, const char *command, float x1, float y1, float x2, float y2, unsigned char *color, int round, float aspect, int flags );
	pfnTouchHideButtons = 6, -- void (*)( const char *name, unsigned char hide );
	pfnTouchRemoveButton = 7, -- void (*)( const char *name );
	pfnTouchSetClientOnly = 8, -- void (*)( unsigned char state );
	pfnTouchResetDefaultButtons = 9, -- void (*)( void );
	pfnDrawScaledCharacter = 10, -- int (*)( int x, int y, int number, int r, int g, int b, float scale );
	pfnSys_Warn = 11, -- void (*)( const char *format, ... );
	pfnGetNativeObject = 12, -- void *(*)( const char *obj );
	pfnSetCustomClientID = 13, -- void (*)( const char *id );
}
mobile_engfuncs_t = mobile_engfuncs_s
return mobile_engfuncs_s