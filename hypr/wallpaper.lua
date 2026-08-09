
local M = {}
local wallpaper_dir = os.getenv("HOME") .. "/.config/wallpapers"
local live_wallpaper_dir = os.getenv("HOME") .. "/.config/liveWallpapers"
local wallpaper_fetch_count = 0
local CACHE_FLUSH_INTERVAL = 15

-- ─────────────────────────────────────────────
-- Logging
-- ─────────────────────────────────────────────

local LOG_FILE = os.getenv("HOME") .. "/.config/hypr/wallpaper.log"

local function log(level, message)
    local file = io.open(LOG_FILE, "a")

    if file then
        file:write(
            os.date("[%Y-%m-%d %H:%M:%S] ")
            .. "[" .. level .. "] "
            .. message
            .. "\n"
        )
        file:close()
    end

    -- Also print to Hyprland/Lua output
    print("[wallpaper][" .. level .. "] " .. message)
end

local function notify(title, message)
    hl.exec_cmd(
        'notify-send "' .. title .. '" "' .. message .. '"'
    )
end


local function log_error(message)
    log("ERROR", message)
end


local function log_info(message)
    log("INFO", message)
end


-- ─────────────────────────────────────────────
-- Random Wallpaper
-- ─────────────────────────────────────────────

local function get_random_wallpaper()

    log_info("Searching for wallpaper in: " .. wallpaper_dir)

    local handle = io.popen(
        'find -L "' .. wallpaper_dir .. '" -maxdepth 1 -type f ' ..
        '\\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" ' ..
        '-o -iname "*.png" -o -iname "*.webp" \\) ' ..
        '! -name ".*" | shuf -n1'
    )

    if not handle then
        log_error("Failed to execute wallpaper search command")
        return nil
    end

    local path = handle:read("*l")
    local success, _, exit_code = handle:close()

    if not path or path == "" then
        log_error(
            "No wallpaper found in directory: "
            .. wallpaper_dir
        )
        return nil
    end

    log_info("Selected wallpaper: " .. path)

    return path
end


function M.random_wallpaper()
    log_info("random_wallpaper() called")
    wallpaper_fetch_count = wallpaper_fetch_count + 1
    log_info("Wallpaper fetch count: " .. wallpaper_fetch_count)
    if wallpaper_fetch_count % CACHE_FLUSH_INTERVAL == 0 then
        wallpaper_fetch_count = 0;
        log_info("Flushing awww cache")
        hl.exec_cmd("awww clear-cache")
    end

    hl.exec_cmd("pkill -x mpvpaper 2>/dev/null")

    local wallpaper = get_random_wallpaper()

    if not wallpaper then
        log_error("Could not select a random wallpaper")
        return
    end

    local command =
        'awww img "' .. wallpaper .. '" ' ..
        '--transition-type any ' ..
        '--transition-step 150 ' ..
        '--transition-duration 1 ' ..
        '--transition-fps 240 ' ..
        '--transition-angle 70'

    log_info("Executing: " .. command)

    local result = hl.exec_cmd(command)

    log_info("Wallpaper applied successfully")
end


-- ─────────────────────────────────────────────
-- Restore Wallpaper
-- ─────────────────────────────────────────────

function M.restore_wallpaper()

    log_info("restore_wallpaper() called")

    hl.exec_cmd([[
        if ! pgrep -x awww-daemon >/dev/null; then
            echo "[wallpaper] Starting awww-daemon"
            awww-daemon &
        fi

        while ! awww query >/dev/null 2>&1; do
            sleep 0.1
        done

        echo "[wallpaper] Restoring wallpaper"
        awww restore
    ]])

    log_info("Restore command sent")
end


-- ─────────────────────────────────────────────
-- Random GIF Wallpaper
-- ─────────────────────────────────────────────

function M.random_video_wallpaper()
    log_info("random_video_wallpaper() called")
    notify("Video Wallpaper", "Changing wallpaper...")

    -- 1. Clear awww but keep daemon alive
    log_info("Clearing awww wallpaper...")
    hl.exec_cmd("awww clear")

    -- 2. Kill old mpvpaper and WAIT briefly so it releases the Wayland socket
    log_info("Stopping existing mpvpaper...")
    hl.exec_cmd("pkill -x mpvpaper 2>/dev/null")

    log_info("Searching for video wallpaper in: " .. live_wallpaper_dir)

    local handle = io.popen(
        'find -L "' .. live_wallpaper_dir .. '" -maxdepth 1 -type f ' ..
        '\\( -iname "*.mp4" \\) | shuf -n1'
    )

    if not handle then
        log_error("Failed to execute video search command")
        notify("Video Wallpaper", "❌ Failed to search for videos")
        return
    end

    local video = handle:read("*l")
    handle:close()

    if not video or video == "" then
        log_error("No video wallpaper found in: " .. live_wallpaper_dir)
        notify("Video Wallpaper", "❌ No MP4 video found")
        return
    end

    log_info("Selected video: " .. video)
    local filename = video:match("([^/]+)$") or video
    notify("Video Wallpaper", "🎬 " .. filename)

    local command =
        'nohup mpvpaper -o "--panscan=1.0 --loop-file=inf --no-audio" ' ..
        'eDP-1 "' .. video .. '" ' ..
        '> /dev/null 2>&1 &'

    log_info("Executing (detached): " .. command)

    local result = hl.exec_cmd(command)

    if result ~= true and result ~= 0 then
        log_error("mpvpaper failed to start for: " .. video)
        notify("Video Wallpaper", "❌ Failed to apply " .. filename)
        return
    end

    log_info("Video wallpaper launched successfully")
    notify("Video Wallpaper", "✓ Applied " .. filename)
end


return M
