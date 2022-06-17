static const char norm_fg[] = "#d9c8ce";
static const char norm_bg[] = "#150f0d";
static const char norm_border[] = "#978c90";

static const char sel_fg[] = "#d9c8ce";
static const char sel_bg[] = "#C67045";
static const char sel_border[] = "#d9c8ce";

static const char urg_fg[] = "#d9c8ce";
static const char urg_bg[] = "#D89664";
static const char urg_border[] = "#D89664";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
