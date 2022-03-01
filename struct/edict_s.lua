edict_s = {
    free = 1, -- qboolean
	serialnumber = 2, -- int
	area = 3, -- link_t	// linked to a division node or leaf
	headnode = 4, -- int	// -1 to use normal leaf check
	num_leafs = 5, -- int
	leafnums = 6, -- short[MAX_ENT_LEAFS]
	freetime = 7, -- float	// sv.time when the object was freed
	pvPrivateData = 8, -- void*	// Alloced and freed by engine, used by DLLs
	v = 9, -- entvars_t	// C exported fields from progs
}
edict_t = edict_s
return edict_s