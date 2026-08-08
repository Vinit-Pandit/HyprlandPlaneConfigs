---@module 'hl'

local wallpaper = require("wallpaper")

hl.monitor({
  output = "DP-1",
  mode = "2560x1600@240",
  position = "0x0",
  scale = 1,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon")

     hl.exec_cmd("waybar")

    -- NetworkManager tray applet
    hl.exec_cmd("nm-applet --indicator")
end)




local mod = "SUPER"


hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 8,
        border_size = 1,
        layout = "dwindle",
        col = {
            active_border = "rgb(585b70)",
            inactive_border = "rgb(2a2b36)",
        },
    },
})

hl.config({
    decoration = {
        rounding = 16,
        active_opacity = 1,
        inactive_opacity = 0.8,
        dim_inactive = true,
        dim_strength = 0.04,
        shadow = {
            enabled = true,
            range = 18,
            render_power = 3,
            color = "rgba(00000040)",
            offset = "0 6",
        },
        blur = {
            enabled = true,
            size = 7,
            passes = 3,
            ignore_opacity = true,
            new_optimizations = true,
            special = true,
            popups = true,
            xray = false,
            vibrancy = 0.1696,
        },
    },
})

-- Animation ********************************************************************************************


-- =========================
-- Animation curves
-- =========================

hl.curve("bounce", {
    type = "bezier",
    points = {
        { 0.0, 1.25 },
        { 0.15, 1.0 },
    },
})

hl.curve("buttery", {
    type = "bezier",
    points = {
        { 0.1, 1.15 },
        { 0.15, 1.02 },
    },
})

hl.curve("smooth", {
    type = "bezier",
    points = {
        { 0.0, 0.0 },
        { 0.12, 1.0 },
    },
})

hl.curve("linear", {
    type = "bezier",
    points = {
        { 0.0, 0.0 },
        { 1.0, 1.0 },
    },
})


-- =========================
-- Global animation
-- =========================

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 1,
    bezier = "linear",
})


-- =========================
-- Windows
-- =========================

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.5,
    bezier = "bounce",
    style = "slide",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3.5,
    bezier = "smooth",
    style = "slide",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4,
    bezier = "buttery",
    style = "slide",
})


-- =========================
-- Fade
-- =========================

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 3.5,
    bezier = "smooth",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 3,
    bezier = "smooth",
})

hl.animation({
    leaf = "fadeDim",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})

hl.animation({
    leaf = "fadeShadow",
    enabled = true,
    speed = 4,
    bezier = "smooth",
})


-- =========================
-- Workspaces
-- =========================

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4.5,
    bezier = "buttery",
    style = "slidefade 10%",
})

hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 4.5,
    bezier = "buttery",
    style = "slidefadevert -15%",
})


-- =========================
-- Borders
-- =========================

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 7,
    bezier = "smooth",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 35,
    bezier = "linear",
    style = "loop",
})


-- =========================
-- Layers
-- =========================

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "bounce",
    style = "slide",
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 3,
    bezier = "smooth",
    style = "slide",
})


-- Animation ********************************************************************************************



hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        kb_options = "caps:escape",
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        vrr = 1,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

hl.config({
    cursor = {
        inactive_timeout = 3,
    },
})

-- Application launcher
hl.bind(mod .. " + " .. "D", function()
    hl.exec_cmd("~/.config/wofi/launcher.sh")
end)

hl.bind(mod .. " + " .. "Return", hl.dsp.exec_cmd("kitty"))

hl.bind(mod .. " + " .. "E", hl.dsp.exec_cmd("thunar"))


hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "Q", hl.dsp.window.close())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "space", hl.dsp.window.float())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "W", wallpaper.random_wallpaper)

hl.bind(
     mod .. "+" .. "ALT + V",
    wallpaper.random_video_wallpaper
)

hl.bind(mod .. " + " .. "X", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mod .. " + " .. "B", hl.dsp.exec_cmd("brave"))

hl.bind(mod .. " + " .. "F", hl.dsp.window.fullscreen())

hl.bind(mod .. " + " .. "Left", hl.dsp.focus({ direction = "left" }))

hl.bind(mod .. " + " .. "Down", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + " .. "Up", hl.dsp.focus({ direction = "up" }))

hl.bind(mod .. " + " .. "Right", hl.dsp.focus({ direction = "right" }))

hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + L", hl.dsp.exit())

-- TODO: manual review (unknown dispatcher: resizeactive)
-- hl.bind("$mod + CTRL + Left", hl.dsp.resizeactive("-20 0"))

-- TODO: manual review (unknown dispatcher: resizeactive)
-- hl.bind("$mod + CTRL + Right", hl.dsp.resizeactive("20 0"))

-- TODO: manual review (unknown dispatcher: resizeactive)
-- hl.bind("$mod + CTRL + Up", hl.dsp.resizeactive("0 -20"))

-- TODO: manual review (unknown dispatcher: resizeactive)
-- hl.bind("$mod + CTRL + Down", hl.dsp.resizeactive("0 20"))

hl.bind(mod .. " + " .. "Tab", hl.dsp.window.cycle_next())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "Tab", hl.dsp.window.cycle_next({ next = false }))

hl.bind(mod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))

hl.bind(mod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))

hl.bind(mod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))

hl.bind(mod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))

hl.bind(mod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))

hl.bind(mod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))

hl.bind(mod .. " + " .. "S", hl.dsp.workspace.toggle_special(nil))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special" }))

hl.bind(mod .. " + " .. "P", hl.dsp.window.pseudo())

hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind("SUPER" .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind("SUPER + SHIFT" .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -C"))

hl.bind("Print", hl.dsp.exec_cmd("grim ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot Saved\""))

hl.bind("SHIFT" .. " + " .. "Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot Saved\""))

hl.bind("Menu", hl.dsp.exec_cmd("~/.config/scripts/define.sh"))

hl.bind(mod .. " + " .. "R", hl.dsp.exec_cmd("gpu-screen-recorder -w screen -f 30 -a default_output -o ~/screen-recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4 & notify-send \"Recording Started\""))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "R", hl.dsp.exec_cmd("killall -SIGINT gpu-screen-recorder && notify-send \"Recording Stopped\""))

hl.bind(mod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("F1", hl.dsp.exec_cmd("amixer set Master toggle"))

hl.bind("F2", hl.dsp.exec_cmd("amixer set Master 1%-"))

hl.bind("F3", hl.dsp.exec_cmd("amixer set Master 1%+"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer set Master toggle"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer set Master 1%-"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer set Master 1%+"))

hl.window_rule({
    name  = "match_class_lorien",
    match = {
        class = "opacity 0.8 1",
    },
    -- TODO: review rule: "match:class Lorien"
})

hl.window_rule({
    name  = "match_class_sublime_",
    match = {
        class = "opacity 0.88 1",
    },
    -- TODO: review rule: "match:class sublime_text"
})

hl.window_rule({
    name  = "match_class_thunar",
    match = {
        class = "opacity 0.9 1",
    },
    -- TODO: review rule: "match:class thunar"
})

hl.window_rule({
    name  = "match_class_thunar",
    match = {
        class = "opacity 0.9 1",
    },
    -- TODO: review rule: "match:class Thunar"
})

hl.window_rule({
    name  = "match_class_vscodium",
    match = {
        class = "opacity 0.88 1",
    },
    -- TODO: review rule: "match:class VSCodium"
})

hl.window_rule({
    name  = "match_class_codium",
    match = {
        class = "opacity 0.88 1",
    },
    -- TODO: review rule: "match:class codium"
})

hl.window_rule({
    name  = "match_class_org_pwmt",
    match = {
        class = "opacity 0.9 1",
    },
    -- TODO: review rule: "match:class org.pwmt.zathura"
})

hl.window_rule({
    name  = "match_class_firefox",
    match = {
        class = "opacity 1.0 1.0",
    },
    -- TODO: review rule: "match:class firefox"
})

hl.window_rule({
    name  = "match_class_mpv",
    match = {
        class = "float on",
    },
    -- TODO: review rule: "match:class mpv"
})

hl.window_rule({
    name  = "match_class_mpv",
    match = {
        class = "size 640 360",
    },
    -- TODO: review rule: "match:class mpv"
})

hl.window_rule({
    name  = "match_class_mpv",
    match = {
        class = "center on",
    },
    -- TODO: review rule: "match:class mpv"
})

hl.window_rule({
    name  = "match_class_mpv",
    match = {
        class = "opacity 1.0 1.0",
    },
    -- TODO: review rule: "match:class mpv"
})

hl.window_rule({
    name  = "match_float_yes",
    match = {
        class = "center on",
    },
    -- TODO: review rule: "match:float yes"
})

hl.window_rule({
    name  = "match_class_scratcht",
    match = {
        class = "float on",
    },
    -- TODO: review rule: "match:class scratchterm"
})

hl.window_rule({
    name  = "match_class_scratcht",
    match = {
        class = "size 85% 70%",
    },
    -- TODO: review rule: "match:class scratchterm"
})

hl.window_rule({
    name  = "match_class_scratcht",
    match = {
        class = "center on",
    },
    -- TODO: review rule: "match:class scratchterm"
})

hl.layer_rule({
    match = {
        namespace = "match:namespace waybar",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace waybar",
    },
    ignore_alpha = 0,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace swaync-control-center",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace swaync-notification-window",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace swaync-control-center",
    },
    ignore_alpha = 0,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace swaync-notification-window",
    },
    ignore_alpha = 0,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace quickshell",
    },
    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace quickshell",
    },
    ignore_alpha = 0,
})

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("wal -R -n")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("mpd-mpris")
    hl.exec_cmd("kdeconnect-indicator")
end)
