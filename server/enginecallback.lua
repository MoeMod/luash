
function PRECACHE_MODEL(path)
    if not CLIENT_DLL then
        return engfunc.pfnPrecacheModel(path)
    end
end

function PRECACHE_SOUND(path)
    if not CLIENT_DLL then
        return engfunc.pfnPrecacheSound(path)
    end
end

function PRECACHE_EVENT(type, path)
    return engfunc.pfnPrecacheEvent(type, path)
end

-- void	(*pfnPlaybackEvent)( int flags, const edict_t *pInvoker, unsigned short eventindex, float delay, float *origin, float *angles, float fparam1, float fparam2, int iparam1, int iparam2, int bparam1, int bparam2 )
function PLAYBACK_EVENT_FULL(flags, pInvoker, eventindex, delay, origin, angles, fparam1, fparam2, iparam1, iparam2, bparam1, bparam2)
    return engfunc.pfnPlaybackEvent(flags, pInvoker, eventindex, delay, origin, angles, fparam1, fparam2, iparam1, iparam2, bparam1, bparam2)
end

-- void	(*pfnSetModel)( edict_t *e, const char *m )
function SET_MODEL(edict, model)
    if not CLIENT_DLL then
        return engfunc.pfnSetModel(edict, model)
    end
end

function ALLOC_STRING(str)
    return engfunc.pfnAllocString(str)
end

function MAKE_VECTORS(rgflVector)
    return engfunc.pfnMakeVectors(rgflVector)
end