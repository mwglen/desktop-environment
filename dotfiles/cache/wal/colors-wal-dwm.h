static const char norm_fg[] = "#f5d8a6";
static const char norm_bg[] = "#0a0409";
static const char norm_border[] = "#ab9774";

static const char sel_fg[] = "#f5d8a6";
static const char sel_bg[] = "#C9473A";
static const char sel_border[] = "#f5d8a6";

static const char urg_fg[] = "#f5d8a6";
static const char urg_bg[] = "#9B2E33";
static const char urg_border[] = "#9B2E33";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
