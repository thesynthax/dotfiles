local mainMod = "SUPER"
local home = os.getenv("HOME")
local scriptsDir = home .. "/.config/hypr/scripts"
local userScriptsDir = home .. "/.config/hypr/UserScripts"
local files = "thunar"
local term = "kitty"
local editor = "nvim"
local browser = "brave --enable-features=UseOzonePlatform --ozone-platform=wayland"

--hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser"), { release = true })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,window"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("pkill rofi || rofi -show run"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(userScriptsDir .. "/ZshChangeTheme.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(userScriptsDir .. "/mpd.sh"))
hl.bind("ALT + Space", hl.dsp.exec_cmd(userScriptsDir .. "/movie.sh"))
