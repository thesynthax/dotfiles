void
nametag(const Arg *arg)
{
	char *p, name[MAX_TAGLEN];
	FILE *f;
	int i, group;
	int tagindex;
	Monitor *m = selmon;

	errno = 0; // popen(3p) says on failure it "may" set errno
	if (!(f = popen(NAMETAG_COMMAND, "r"))) {
		fprintf(stderr, "dwm: popen command failed%s%s\n", errno ? ": " : "", errno ? strerror(errno) : "");
		return;
	}

	if (!(p = fgets(name, MAX_TAGLEN, f)) && (i = errno) && ferror(f))
		fprintf(stderr, "dwm: fgets failed: %s\n", strerror(i));

	pclose(f);

	if (!p)
		return;
	if ((p = strchr(name, '\n')))
		*p = '\0';

	for (i = 0; i < NUMTAGS; i++) {
		if (m->tagset[m->seltags] & (1 << i)) {

		 	tagindex = i + NUMTAGS * m->num;
			if (tagindex >= LENGTH(tagicons[DEFAULT_TAGS]))
				tagindex = tagindex % LENGTH(tagicons[DEFAULT_TAGS]);

			group = DEFAULT_TAGS;

			snprintf(tagicons[group][i], MAX_TAGLEN, NAMETAG_FORMAT, name);
		}
	}
	drawbars();
}
