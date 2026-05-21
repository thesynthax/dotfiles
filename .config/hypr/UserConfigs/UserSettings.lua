local colors = require("wallust.wallust-hyprland")

hl.config({
    dwindle = {
        preserve_split = true,
        special_scale_factor = 0.8,
    },

    master = {
        new_status = "master",
        new_on_top = true,
        mfact = 0.5,
    },

    general = {
        gaps_in = 4,
        gaps_out = 6,
        border_size = 2,
        resize_on_border = false,
        col = {
            active_border   = colors.color12,
            inactive_border = colors.background,
        },
        layout = "master",
    },

    group = {
        col = {
            border_active = colors.color12,
        },
        groupbar = {
            col = {
                active = colors.color0,
            },
        },
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive = false,
        dim_strength = 0.1,
        dim_special = 0.8,

        shadow = {
            enabled = false,
            range = 6,
            render_power = 1,
            color = colors.color12,
            color_inactive = colors.color2,
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            noise = 0.0200,
            vibrancy = 0.1796,
            ignore_opacity = true,
            new_optimizations = true,
            special = true,
            popups = true,
        },
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules = "",
        repeat_rate = 25,
        repeat_delay = 300,
        numlock_by_default = true,
        left_handed = false,
        follow_mouse = true,
        float_switch_override_focus = false,
        sensitivity = 0.5,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            clickfinger_behavior = false,
            middle_button_emulation = true,
            tap_to_click = true,
            drag_lock = false,
        },
    },

    gestures = {
        workspace_swipe_distance = 600,
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 10,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
        workspace_swipe_forever = true,
    },

    debug = {
        vfr = true,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        enable_swallow = true,
        swallow_regex = "^(kitty)$",
        focus_on_activate = false,
        initial_workspace_tracking = 0,
        middle_click_paste = true,
    },

    binds = {
        workspace_back_and_forth = false,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    render = {
        direct_scanout = false,
    },

    cursor = {
        no_hardware_cursors = false,
        enable_hyprcursor = true,
        warp_on_change_workspace = true,
        no_warps = true,
    },
})

hl.curve("default", { type = "bezier", points = { {0, 1}, {0, 1} } })
hl.curve("wind",    { type = "bezier", points = { {0.05, 0.69}, {0.1, 1} } })
hl.curve("winIn",   { type = "bezier", points = { {0.1, 1.1}, {0.1, 1} } })
hl.curve("winOut",  { type = "bezier", points = { {0.3, 1}, {0, 1} } })
hl.curve("linear",  { type = "bezier", points = { {1, 1}, {1, 1} } })
hl.curve("easeOut", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6.9, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6.9, bezier = "easeOut", style = "popin 90%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 6.9, bezier = "easeOut", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 6.9, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 10,  bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "layers",      enabled = true, speed = 6.9, bezier = "easeOut", style = "slide" })
