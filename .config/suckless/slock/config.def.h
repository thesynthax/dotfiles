/* user and group to drop privileges to */
static const char *user  = "thesynthax";
static const char *group = "users"; // use "nobody" for arch

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#FF0000",   /* wrong password */
};




/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "locked",       STRING,  &colorname[INIT] },
		{ "input",        STRING,  &colorname[INPUT] },
		{ "failed",       STRING,  &colorname[FAILED] },
};


/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;









