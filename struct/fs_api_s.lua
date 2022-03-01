
local enum = require("core/enum")
fs_api_s = enum
{
	-- indicates version of API. Should be equal to FS_API_VERSION
	-- version changes when existing functions are changes
    "version", 	--	int

	-- fopen engine equivalent
	"FS_Open", 	--	file_t *(*)( const char *filepath, const char *mode, qboolean gamedironly );

	-- fclose engine equivalent
	"FS_Close", 	--	int (*)( file_t *file );

	-- ftell engine equivalent
	"FS_Tell", 	--	fs_offset_t (*)( file_t* file );

	-- fseek engine equivalent
	"FS_Seek", 	--	int (*)( file_t *file, fs_offset_t offset, int whence );

	-- fread engine equivalent
	"FS_Read", 	--	fs_offset_t (*)( file_t *file, void *buffer, size_t buffersize );

	-- fwrite engine equivalent
	"FS_Write", 	--	fs_offset_t (*)( file_t *file, const void *data, size_t datasize );

	-- vfprintf engine equivalent
	"FS_VPrintf", 	--	int (*)( file_t *file, const char* format, va_list ap );

	-- fgetc engine equivalent
	"FS_Getc", 	--	int (*)( file_t *file );

	-- feof engine equivalent
	"FS_Eof", 	--	qboolean (*)( file_t* file );

	-- mkdir engine equivalent
	"FS_CreatePath", 	--	void (*)( char *path );

	-- add game directory to search path
	"FS_AddGameDirectory", 	--	void (*)( const char *, int );

	-- search files by pattern
	"FS_Search", 	--	search_t *(*)( const char *pattern, int caseinsensitive, int gamedironly );

	-- get file size by name
	"FS_FileSize", 	--	fs_offset_t (*)( const char *filename, qboolean gamedironly );

	-- get file time by name
	"FS_FileTime", 	--	fs_offset_t (*)( const char *filename, qboolean gamedironly );

	-- get disk path by it's relative
	"FS_GetDiskPath", 	--	const char *(*)( const char *name, qboolean gamedironly );

	-- find file
	"FS_FindFile", 	--	searchpath_t *(*)( const char *name, int* index, qboolean gamedironly );

	-- get all search paths
	"FS_GetSearchPaths", 	--	searchpath_t *(*)();

	-- add pack to search path
	"FS_AddPack_Fullpath", 	--	qboolean (*)( const char *pakfile, qboolean *already_loaded, qboolean keep_plain_dirs, int flags );

	-- log spew
	"Msg", 	--	void (*)( const char *pMsg, ... );

	-- memory utils
	"_Mem_Alloc", 	--	void *(*)( size_t size, const char *filename, int fileline );
	"_Mem_Free", 	--	void (*)( void *data, const char *filename, int fileline );
}
fs_api_t = fs_api_s