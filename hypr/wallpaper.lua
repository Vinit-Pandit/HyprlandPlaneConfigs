
local M = {}
local wallpaper_dir = os.getenv("HOME") .. "/.config/wallpapers"
local live_wallpaper_dir = os.getenv("HOME") .. "/.config/liveWallpapers"

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
        '--transition-angle 90'

    log_info("Executing: " .. command)

    local result = os.execute(command)

    if result ~= true and result ~= 0 then
        log_error(
            "awww failed while setting wallpaper: "
            .. wallpaper
        )
        return
    end

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

    log_info(
        "Searching for GIF wallpaper in: "
        .. live_wallpaper_dir
    )

    local handle = io.popen(
        'find -L "' .. live_wallpaper_dir .. '" -maxdepth 1 -type f ' ..
        '\\( -iname "*.gif" \\) | shuf -n1'
    )

    if not handle then
        log_error("Failed to execute GIF search command")
        return
    end

    local gif = handle:read("*l")
    local success, _, exit_code = handle:close()

    if not success then
        log_error(
            "GIF search command failed with exit code: "
            .. tostring(exit_code)
        )
        return
    end

    if not gif or gif == "" then
        log_error(
            "No GIF wallpaper found in: "
            .. live_wallpaper_dir
        )
        return
    end

    log_info("Selected GIF: " .. gif)

    local command =
        'awww img "' .. gif .. '" ' ..
        '--transition-type any ' ..
        '--transition-step 150 ' ..
        '--transition-duration 1 ' ..
        '--transition-fps 240 ' ..
        '--transition-angle 90'

    log_info("Executing: " .. command)

    local result = os.execute(command)

    if result ~= true and result ~= 0 then
        log_error(
            "awww failed while setting GIF: "
            .. gif
        )
        return
    end

    log_info("GIF wallpaper applied successfully")
end


return M
