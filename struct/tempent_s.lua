tempent_s = {
	flags = 1, -- int
	die = 2, -- float
	frameMax = 3, -- float
	x = 4, -- float
	y = 5, -- float
	z = 6, -- float
	fadeSpeed = 7, -- float
	bounceFactor = 8, -- float
	hitSound = 9, -- int
	hitcallback = 10, -- void		( * )	( struct tempent_s *ent, struct pmtrace_s *ptr );
	callback = 11, -- void		( * )		( struct tempent_s *ent, float frametime, float currenttime );
	next = 12, -- TEMPENTITY	*
	priority = 13, -- int			
	clientIndex = 14, -- short		 if attached, this is the index of the client to stick to
								-- if COLLIDEALL, this is the index of the client to ignore
								-- TENTS with FTENT_PLYRATTACHMENT MUST set the clientindex! 

	tentOffset = 15, -- vec3_t				 if attached, client origin + tentOffset = tent origin.
	entity = 16 -- cl_entity_t	
}
tempent_t = tempent_s
return tempent_s