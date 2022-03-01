cl_entity_s = {
	index = 1,      -- int Index into cl_entities ( should match actual slot, but not necessarily )
	player = 2,      -- qboolean True if this entity is a "player"
	baseline = 3,    -- entity_state_t The original state from which to delta during an uncompressed message
	prevstate = 4,   -- entity_state_t The state information from the penultimate message received from the server
	curstate = 5,    -- entity_state_t The state information from the last message received from server
	current_position = 6,  -- int Last received history update index
	ph = 7, -- [ HISTORY_MAX ]   -- position_history_t History of position and angle updates for this player
	mouth = 8,			-- mouth_t For synchronizing mouth movements.
	latched = 9,		-- latchedvars_t Variables used by studio model rendering routines

	-- Information based on interplocation, extrapolation, prediction, or just copied from last msg received.
	--
	lastmove = 10, -- float

	-- Actual render position and angles
	origin = 11, -- vec3_t
	angles = 12, -- vec3_t

	-- Attachment points
	attachment = 13, -- vec3_t[16]

	-- Other entity local information
	trivial_accept = 14, -- int
	model = 15,			-- struct model_s* cl.model_precache[ curstate.modelindes ];  all visible entities have a model
	efrag = 16,			-- struct efrag_s* linked list of efrags
	topnode = 17,		-- struct mnode_s* for bmodels, first world node that splits bmodel, or NULL if not split
	syncbase = 18,		-- float	for client-side animations -- used by obsolete alias animation system, remove?
	visframe = 19,		-- int		last frame this entity was found in an active leaf
	cvFloorColor = 20   -- colorVec
}

cl_entity_t = cl_entity_s
return cl_entity_s