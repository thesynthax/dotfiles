/* Copyright 2011-2013 Bert Muennich
 *
 * This file is part of sxiv.
 *
 * sxiv is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 *
 * sxiv is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with sxiv.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "sxiv.h"

#include <stdlib.h>
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <curl/curl.h>

bool is_url(const char *url) {
	CURLU       *h = curl_url();
	int         rc;

	rc = curl_url_set(h, CURLUPART_URL, url, 0);
	curl_url_cleanup(h);
	return rc == 0;
}

static size_t write_data(void *ptr, size_t size, size_t nmemb, void *stream) {
	size_t written = fwrite(ptr, size, nmemb, (FILE *)stream);
	return written;
}

int get_url(const char *url, char **out) {
	CURL        *curl_handle;
	CURLcode    ret;
	char        tmp[] = "/tmp/sxiv-XXXXXX";
	FILE        *file = NULL;
	int         fd;

	fd = mkstemp(tmp);
	if (fd == -1)
		return -1;
	close(fd);

	file = fopen(tmp, "wb");

	if (file == NULL) {
		return -1;
	}

	*out = strdup(tmp);
	if (*out == NULL) {
		return -1;
	}

	curl_global_init(CURL_GLOBAL_ALL);
	curl_handle = curl_easy_init();

	curl_easy_setopt(curl_handle, CURLOPT_URL, url);
	curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, write_data);
	curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, file);

	ret = curl_easy_perform(curl_handle);

	if (ret != CURLE_OK) {
		printf("Error: %s\n", curl_easy_strerror(ret));
		return -1;
	}

	fclose(file);
	curl_easy_cleanup(curl_handle);
	curl_global_cleanup();

	return 0;
}