for w = 1, 10 do
  hl.workspace_rule({ workspace = tostring(w),         monitor = "eDP-1" })
  hl.workspace_rule({ workspace = tostring(w + 10),     monitor = "HDMI-A-2" })
end
