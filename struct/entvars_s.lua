entvars_s = {
    classname           = 1,        -- string_t
    globalname          = 2,        -- string_t
    origin              = 3,        -- vec3_t
    oldorigin           = 4,        -- vec3_t
    velocity            = 5,        -- vec3_t
    basevelocity        = 6,        -- vec3_t
    clbasevelocity      = 7,        -- vec3_t
    movedir             = 8,        -- vec3_t
    angles              = 9,        -- vec3_t
    avelocity           = 10,        -- vec3_t
    punchangle          = 11,       -- vec3_t
    v_angle             = 12,       -- vec3_t
    endpos              = 13,       -- vec3_t
    startpos            = 14,       -- vec3_t
    impacttime          = 15,       -- time_point_t
    starttime           = 16,       -- time_point_t
    fixangle            = 17,       -- int
    idealpitch          = 18,       -- float
    pitch_spee          = 19,       -- float
    ideal_yaw           = 20,       -- float
    yaw_speed           = 21,       -- float
    modelindex          = 22,       -- int
    model               = 23,       -- string_t
    viewmodel           = 24,       -- int
    weaponmode          = 25,       -- int
    absmin              = 26,       -- vec3_t
    absmax              = 27,       -- vec3_t
    mins                = 28,       -- vec3_t
    maxs                = 29,       -- vec3_t
    size                = 30,       -- vec3_t
    ltime               = 31,       -- time_point_t
    nextthink           = 32,       -- time_point_t
    movetype            = 33,       -- int
    solid               = 34,       -- int
    skin                = 35,       -- int
    body                = 36,       -- int
    effects             = 37,       -- int
    gravity             = 38,       -- float
    friction            = 39,       -- float
    light_leve          = 40,       -- int
    sequence            = 41,       -- int
    gaitsequen          = 42,       -- int
    frame               = 43,       -- float
    animtime            = 44,       -- time_point_t
    framerate           = 45,       -- float
    controller          = 46,       -- byte[4]
    blending            = 47,       -- byte[2]
    scale               = 48,       -- float
    rendermode          = 49,       -- int
    renderamt           = 50,       -- float
    rendercolo          = 51,       -- vec3_t
    renderfx            = 52,       -- int
    health              = 53,       -- float
    frags               = 54,       -- float
    weapons             = 55,       -- int
    takedamage          = 56,       -- float
    deadflag            = 57,       -- int
    view_ofs            = 58,       -- vec3_t
    button              = 59,       -- int
    impulse             = 60,       -- int
    chain               = 61,       -- edict_t *
    dmg_inflic          = 62,       -- edict_t *
    enemy               = 63,       -- edict_t *
    aiment              = 64,       -- edict_t *
    owner               = 65,       -- edict_t *
    groundenti          = 66,       -- edict_t *
    spawnflags          = 67,       -- int
    flags               = 68,       -- int
    colormap            = 69,       -- int
    team                = 70,       -- int
    max_health          = 71,       -- float
    teleport_t          = 72,       -- float
    armortype           = 73,       -- float
    armorvalue          = 74,       -- float
    waterlevel          = 75,       -- int
    watertype           = 76,       -- int
    target              = 77,       -- string_t
    targetname          = 78,       -- string_t
    netname             = 79,       -- string_t
    message             = 80,       -- string_t
    dmg_take            = 81,       -- float
    dmg_save            = 82,       -- float
    dmg                 = 83,       -- float
    dmgtime             = 84,       -- time_point_t
    noise               = 85,       -- string_t
    noise1              = 86,       -- string_t
    noise2              = 87,       -- string_t
    noise3              = 88,       -- string_t
    speed               = 89,       -- float
    air_finish          = 90,       -- time_point_t
    pain_finis          = 91,       -- time_point_t
    radsuit_fi          = 92,       -- time_point_t
    pContainin          = 93,       -- edict_t *
    playerclas          = 94,       -- int
    maxspeed            = 95,       -- float
    fov                 = 96,       -- float
    weaponanim          = 97,       -- int
    pushmsec            = 98,       -- int
    bInDuck             = 99,       -- int
    flTimeStep          = 100,       -- int
    flSwimTime          = 101,      -- int
    flDuckTime          = 102,      -- int
    iStepLeft           = 103,      -- int
    flFallVelo          = 104,      -- float
    gamestate           = 105,      -- int
    oldbuttons          = 106,      -- int
    groupinfo           = 107,      -- int
    iuser1              = 108,      -- int
    iuser2              = 109,      -- int
    iuser3              = 110,      -- int
    iuser4              = 111,      -- int
    fuser1              = 112,      -- float
    fuser2              = 113,      -- float
    fuser3              = 114,      -- float
    fuser4              = 115,      -- float
    vuser1              = 116,      -- vec3_t
    vuser2              = 117,      -- vec3_t
    vuser3              = 118,      -- vec3_t
    vuser4              = 119,      -- vec3_t
    euser1              = 120,      -- edict_t *
    euser2              = 121,      -- edict_t *
    euser3              = 122,      -- edict_t *
    euser4              = 123,      -- edict_t *
}
entvars_t = entvars_s
return entvars_s