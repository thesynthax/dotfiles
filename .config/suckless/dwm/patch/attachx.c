void
attachx(Client *c)
{
	Client *at;


	unsigned int n;
	for (at = c->mon->clients, n = 0; at; at = at->next)
		if (!at->isfloating && ISVISIBLEONTAG(at, c->tags))
			if (++n >= c->mon->nmaster)
				break;

	if (at && c->mon->nmaster) {
		c->next = at->next;
		at->next = c;
		return;
	}
	attach(c); // master (default)
}

