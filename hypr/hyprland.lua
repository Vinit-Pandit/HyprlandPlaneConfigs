---@module 'hl'

local wallpaper = require("wallpaper")

hl.monitor({
    output = "eDP-1",
    mode = "2560x1600@240",
    position = "0x0",
    scale = 1.6
})

hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon")

    hl.exec_cmd("waybar")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- NetworkManager tray applet
    hl.exec_cmd("nm-applet --indicator")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
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
        inactive_opacity = 0.7,
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
        { 0.0,  1.25 },
        { 0.15, 1.0 },
    },
})

hl.curve("buttery", {
    type = "bezier",
    points = {
        { 0.1,  1.15 },
        { 0.15, 1.02 },
    },
})

hl.curve("smooth", {
    type = "bezier",
    points = {
        { 0.0,  0.0 },
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
            natural_scroll = true,
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
    hl.exec_cmd("~/.config/wofi/launcher.sh --show drun")
end)

hl.bind(mod .. " + " .. "Return", hl.dsp.exec_cmd("kitty"))

hl.bind(mod .. " + " .. "E", hl.dsp.exec_cmd("thunar"))

hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | ~/.config/wofi/launcher.sh --dmenu | cliphist decode | wl-copy"))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "Q", hl.dsp.window.close())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "space", hl.dsp.window.float())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "W", wallpaper.random_wallpaper)

hl.bind(
    mod .. "+" .. "ALT + V",
    wallpaper.random_video_wallpaper
)

hl.bind(mod .. " + " .. "L", hl.dsp.exec_cmd("hyprlock"))

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

hl.bind(mod .. " + CTRL + Left",  hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + Right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + Up",    hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mod .. " + CTRL + Down",  hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })


hl.bind(mod .. " + Tab", hl.dsp.window.cycle_next())

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "Tab", hl.dsp.window.cycle_next({ next = false }))

hl.bind(mod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))

hl.bind(mod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))

hl.bind(mod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))

hl.bind(mod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))

hl.bind(mod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))

hl.bind(mod .. " + " .. "ALT + Right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mod .. " + " .. "ALT + Left", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))

hl.bind(mod .. " + " .. "S", hl.dsp.workspace.toggle_special(nil))

hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special" }))

hl.bind(mod .. " + " .. "P", hl.dsp.window.pseudo())

hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

-- hl.bind("SUPER" .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- hl.bind("SUPER + SHIFT" .. " + " .. "N", hl.dsp.exec_cmd("swaync-client -C"))

-- hl.bind("Print", hl.dsp.exec_cmd("grim ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot Saved\""))

-- hl.bind("SHIFT" .. " + " .. "Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot Saved\""))

-- hl.bind("Menu", hl.dsp.exec_cmd("~/.config/scripts/define.sh"))

-- hl.bind(mod .. " + " .. "R", hl.dsp.exec_cmd("gpu-screen-recorder -w screen -f 30 -a default_output -o ~/screen-recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4 & notify-send \"Recording Started\""))

-- hl.bind(mod .. " + " .. "SHIFT" .. " + " .. "R", hl.dsp.exec_cmd("killall -SIGINT gpu-screen-recorder && notify-send \"Recording Stopped\""))

-- ============================================================
-- Screenshots
-- ============================================================

hl.bind(
    "Print",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/Screenshot.sh full")
)

hl.bind(
    "SHIFT + Print",
    hl.dsp.exec_cmd("~/.config/hypr/scripts/Screenshot.sh area")
)


-- ============================================================
-- Screen Recording
-- ============================================================

-- Start recording
hl.bind(
    mod .. " + " .. "R",
    hl.dsp.exec_cmd(
        "mkdir -p ~/screen-recordings && " ..
        "gpu-screen-recorder " ..
        "-w screen " ..
        "-f 30 " ..
        "-a default_output " ..
        "-o ~/vinit/Pictures/screenRecordings/$(date +%Y-%m-%d_%H-%M-%S).mp4 " ..
        "& notify-send 'Recording Started'"
    )
)

hl.bind(
    mod .. " + SHIFT + R",
    hl.dsp.exec_cmd(
        "pkill -SIGINT gpu-screen-recorder; notify-send 'Recording Stopped'"
    )
)
hl.bind(mod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("F1", hl.dsp.exec_cmd("amixer set Master toggle"))

hl.bind("F2", hl.dsp.exec_cmd("amixer set Master 1%-"), { repeating = true })

hl.bind("F3", hl.dsp.exec_cmd("amixer set Master 1%+"), { repeating = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer set Master toggle"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer set Master 1%-"), { repeating = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer set Master 1%+"), { repeating = true })

-- Brightness
hl.bind("F9", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

hl.bind("F10", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })

hl.bind("SUPER + M", hl.dsp.exit())

hl.window_rule({
    name = "lorien",
    match = {
        class = "Lorien",
    },
    opacity = "0.8 1",
})

hl.window_rule({
    name = "sublime",
    match = {
        class = "sublime_text",
    },
    opacity = "0.88 1",
})


hl.window_rule({
    name = "thunar",
    match = {
        class = "thunar|Thunar",
    },
    opacity = "0.9 1",
})

hl.window_rule({
    name = "vscodium",
    match = {
        class = "code",
    },
    opacity = "0.9",
})

-- hl.window_rule({
--     name = "codium",
--     match = {
--         class = "codium",
--     },
--     opacity = "0.88 1",
-- })

-- hl.window_rule({
--     name = "zathura",
--     match = {
--         class = "org.pwmt.zathura",
--     },
--     opacity = "0.9 1",
-- })

hl.window_rule({
    name = "brave-browser",
    match = {
        class = "brave-browser",
    },
    opacity = "1.0 1.0",
})

hl.window_rule({
    name = "mpv",
    match = {
        class = "mpv",
    },
    float = true,
    size = "640 360",
    center = true,
    opacity = "1.0 1.0",
})

hl.window_rule({
    name = "floating_windows",
    match = {
        float = true,
    },
    center = true,
})

-- hl.window_rule({
--     name = "scratchterm",
--     match = {
--         class = "scratchterm",
--     },
--     float = true,
--     size = "85% 70%",
--     center = true,
-- })

hl.window_rule({
    name = "blueman_popup",
    match = {
        class = "blueman-manager",
    },

    float = true,
    size = "300 600",
    move = "1080 60",
})

hl.layer_rule({
    match = {
        namespace = "waybar",
    },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = {
        namespace = "swaync-control-center",
    },
    blur = true,
    ignore_alpha = 0,
})

hl.layer_rule({
    match = {
        namespace = "match:namespace swaync",
    },
    blur = true,
    ignore_alpha = 0,
})

-- hl.layer_rule({
--     match = {
--         namespace = "match:namespace quickshell",
--     },
--     blur = true,
--     ignore_alpha = 0,
-- })

-- Autostart
hl.on("hyprland.shutdown", function()
    hl.exec_cmd("pkill -x awww-daemon")
    hl.exec_cmd("pkill -x waybar")
    hl.exec_cmd("pkill -x nm-applet")
end)
