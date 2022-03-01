ui_textfuncs_s = {
	pfnEnableTextInput = 1, -- void (*)( int enable );
	pfnUtfProcessChar = 2, -- int (*) ( int ch );
	pfnUtfMoveLeft = 3, -- int (*) ( char *str, int pos );
	pfnUtfMoveRight = 4, -- int (*) ( char *str, int pos, int length );
}
ui_textfuncs_t = ui_textfuncs_s
return ui_textfuncs_s