local home = os.getenv("HOME")

hl.on("hyprland.start", function()
    hl.exec_cmd(home .. "/.config/hypr/initial-boot.sh")
end)
