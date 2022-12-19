/*
 * This file contains patch control flags.
 *
 * In principle you should be able to mix and match any patches
 * you may want. In cases where patches are logically incompatible
 * one patch may take precedence over the other as noted in the
 * relevant descriptions.
 */

/* This patch removes redundant handling of the escape key allowing it to be used for other
 * things such as exiting the external key handler with no output.
 *
 * Look at the scripts under exec/ which can be copied to your $XDG_CONFIG_HOME/sxiv/exec/
 * directory. Now when using the keybinding of Ctrl+x the key-handler script is run and you
 * can do Ctrl+g to open the image in gimp as an example.
 *
 * This example patch allows you to do Ctrl+x to trigger the external key handler, then hit
 * the escape key to return with no output.
 *
 * Optionally this patch allows multiple inputs to be sent to the external key handler until
 * it returns with an exit status of 1.
 *
 * https://github.com/muennich/sxiv/pull/428
 */
#define ALLOW_ESCAPE_KEY_IN_EXTERNAL_KEY_HANDLER_PATCH 0

/* Adds alpha support not for transparency, but to allow sxiv to be embedded into applications
 * that expects support it (e.g. tabbed with alpha patch).
 *
 * This patch depends on the following libraries:
 *    - Xrender
 *
 * Remember to uncomment the relevant lines in the Makefile when enabling this patch.
 *
 * https://github.com/muennich/sxiv/issues/342
 * https://github.com/jaredforrest/sxiv/commit/49bb193074f92ebe05f165c091256e9f07c56e5f
 */
#define ALPHA_PATCH 0

/* Adds dmenu-like behaviour for sxiv such that selecting an image and pressing enter will exit
 * sxiv and output the path to the currently selected file to standard out.
 *
 * This is enabled with the "-d" command line option and Ctrl+Enter will allow the mode to be
 * changed to thumbnail mode and back.
 *
 * https://github.com/muennich/sxiv/pull/405
 */
#define DMENU_LIKE_BEHAVIOUR_PATCH 0

/* Sets the _NET_WM_PID X property.
 *
 * Without this using tools like wmctrl -lp the PID for sxiv windows are displayed
 * as 0 indicating that "the application owning the window does not support it."
 *
 * https://github.com/muennich/sxiv/issues/398
 * https://github.com/muennich/sxiv/pull/403
 */
#define EWMH_NET_WM_PID_PATCH 0

/* Sets the WM_CLIENT_MACHINE X property.
 * https://github.com/muennich/sxiv/pull/403
 */
#define EWMH_WM_CLIENT_MACHINE 0

/* Adds support for pipe-based redirection for sxiv.
 *
 * Example commands:
 *   $ sxiv <(curl -s https://i.imgur.com/JdfIbt4g.png) <(curl -s https://i.imgur.com/WwcW92d.png)
 *   $ curl -s https://i.imgur.com/JdfIbt4g.png | sxiv /dev/stdin
 *
 * This is not possible out of the box because FIFO/pipe files are not seekable which breaks
 * things. The patch works around this by draining the pipe to a temporary file which is displayed
 * and unlinked on exit.
 *
 * https://github.com/muennich/sxiv/pull/369
 */
#define FIFO_PATCH 0

/* Adds the ability to cycle when viewing multiple images.
 * https://github.com/i-tsvetkov/sxiv-patches
 */
#define IMAGE_MODE_CYCLE_PATCH 1

/* Add support for remote links with libcurl
 *
 * The binary now supports the displays of remote images with libcurl
 * bindings. One can pass the url to the binary like a local file.
 *
 * This patch depends on the following libraries for loading images via curl:
 *    - curl
 *
 * Remember to uncomment the relevant lines in the Makefile when enabling this patch.
 *
 * https://github.com/explosion-mental/sxiv/blob/main/patches/libcurl.patch
 */
#define LIBCURL_PATCH 0

/* Shows marked files with a separate colored border in the thumbnail view.
 * The color can be specified by adding Sxiv.mark in your .Xresources file.
 * https://github.com/muennich/sxiv/issues/294
 */
#define MARK_BORDER_PATCH 0

/* Shows the number of marked files in the thumbnail view.
 * https://github.com/muennich/sxiv/issues/294
 */
#define MARK_COUNT_PATCH 0

/* Allows for the same keys used to scroll to be re-used for navigation if the image is not zoomed.
 * https://github.com/muennich/sxiv/pull/368
 */
#define NAVIGATE_IF_NOT_SCROLL_PATCH 0

/* Adds fill scale mode.
 * https://github.com/muennich/sxiv/pull/446
 */
#define SCALE_FILL_MODE_PATCH 1

/* Adds the option of having separate colors for the bar in thumbnail view (instead of re-using
 * the foreground and background colors).
 *
 * You can set the bar specific colors by setting Sxiv.barforeground and Sxiv.barbackground
 * in your .Xresources file.

 * https://github.com/muennich/sxiv/pull/386
 */
#define SEPARATE_BAR_COLORS_PATCH 0

/* Allows the window title to be set via a command line flag during runtime. Also see
 * the window title patch that sets the title dynamically. A set title will override that.
 * https://github.com/muennich/sxiv/pull/427
 */
#define SET_WINDOW_TITLE_PATCH 0

/* Similar to the "-n" command line option, "-F" starts from a file instead of its index.
 * https://github.com/muennich/sxiv/pull/371
 */
#define START_FROM_FILE_PATCH 0

/* Makes thumbnails square.
 * https://github.com/i-tsvetkov/sxiv-patches
 */
#define SQUARE_THUMBNAILS_PATCH 0

/* Adds support for SVG image format (2021-03-14).
 *
 * This patch depends on the following libraries for loading svg documents:
 *    - librsvg
 *    - cairo
 *
 * Remember to uncomment the relevant lines in the Makefile when enabling this patch.
 *
 * https://github.com/muennich/sxiv/pull/440
 */
#define SVG_IMAGE_SUPPORT_PATCH 0

/* Swaps the foreground and background colors of the bar.
 * https://github.com/muennich/sxiv/pull/392
 */
#define SWAP_BAR_COLORS_PATCH 0

/* Adds some control over the padding between thumbnails.
 * https://github.com/explosion-mental/sxiv/blob/main/patches/thumb_paddings.patch
 */
#define THUMBS_PADDING_PATCH 0

/* Adds support for animated WebP image format.
 * Note that as-is sxiv has support for still WebP images through the Imlib2 library. This
 * only adds support for animated WebP images (similar to animated GIF images).
 *
 * This patch depends on the following libraries for loading svg documents:
 *    - lwebp
 *    - lwebpdemux
 *
 * Remember to uncomment the relevant lines in the Makefile when enabling this patch.
 *
 * Known issues:
 *    - the rendering of transparency for still WebP images is different to what sxiv has
 *      by default when rendering WebP images (without this patch)
 *
 * https://github.com/muennich/sxiv/pull/437
 */
#define WEBP_IMAGE_SUPPORT_PATCH 0

/* Makes the window size fit the image when displaying a single image.
 * https://github.com/i-tsvetkov/sxiv-patches
 */
#define WINDOW_FIT_IMAGE_PATCH 0

/* Adds the name or path of the currently viewed file to the window title.
 *
 * You can change the title prefix (defaults to "sxiv - ") by setting Sxiv.titlePrefix
 * in your .Xresources file.
 *
 * You can change the title suffix (defaults to 0) by setting Sxiv.titleSuffix in your
 * .Xresources file - refer to the following values:
 *
 *    Value  Format
 *    0      Basename of file
 *    1      Basename of directory
 *    2      Full path to file
 *    3      Full path to directory
 *    4      Empty string
 *
 * https://github.com/muennich/sxiv/pull/453
 */
#define WINDOW_TITLE_PATCH 1

/*
 * With this patch when the window is mapped, some ICCCM WM_HINTS are set.
 * The input field is set to true and state is set to NormalState.
 *
 * To quote the spec, "The input field is used to communicate to the window
 * manager the input focus model used by the client" and "[c]lients with
 * the Passive and Locally Active models should set the input flag to
 * True". sxiv falls under the Passive Input model, since it expects keyboard
 * input, but only listens for key events on its single, top-level window instead
 * of subordinate windows (Locally Active) or the root window (Globally Active).
 *
 * From the end users prospective, all EWMH/ICCCM compliant WMs (especially
 * the minimalistic ones) will allow the user to focus sxiv, which will
 * allow sxiv to receive key events. If the input field is not set, WMs are
 * allowed to assume that sxiv doesn't require focus.
 *
 * https://github.com/muennich/sxiv/pull/406
 */
#define WM_HINTS_PATCH 0
