-- Skip local host for event send.
FEV_NOTHOST = 1

-- Send the event reliably.  You must specify the origin and angles and use
-- PLAYBACK_EVENT_FULL for this to work correctly on the server for anything
-- that depends on the event origin/angles.  I.e., the origin/angles are not
-- taken from the invoking edict for reliable events.
FEV_RELIABLE = 2

-- Don't restrict to PAS/PVS, send this event to _everybody_ on the server ( useful for stopping CHAN_STATIC
--  sounds started by client event when client is not in PVS anymore ( hwguy in TFC e.g. ).
FEV_GLOBAL = 4

-- If this client already has one of these events in its queue, just update the event instead of sending it as a duplicate
--
FEV_UPDATE = 8

-- Only send to entity specified as the invoker
FEV_HOSTONLY = 16

-- Only send if the event was created on the server.
FEV_SERVER = 32

-- Only issue event client side ( from shared code )
FEV_CLIENT = 64