local M = {}

local wallpaper_dir = os.getenv("HOME") .. "/wallpapers"
local live_wallpaper_dir = os.getenv("HOME") .. "/liveWallpapers"

local function get_random_wallpaper()
    local handle = io.popen(
        'find "' .. wallpaper_dir .. '" -maxdepth 1 -type f ' ..
        '\\( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" ' ..
        '-o -iname "*.png" -o -iname "*.webp" \\) ' ..
        '! -name ".*" | shuf -n1'
    )

    if not handle then
        return nil
    end

    local path = handle:read("*l")
    handle:close()

    return path
end

function M.random_wallpaper()
    local wallpaper = get_random_wallpaper()

    if wallpaper then
        hl.exec_cmd(
            'awww img "' .. wallpaper .. '" ' ..
            '--transition-type any ' ..
            '--transition-step 150 ' ..
            '--transition-duration 1 ' ..
            '--transition-fps 240 ' ..
            '--transition-angle 90'
        )
    end
end

function M.restore_wallpaper()
    hl.exec_cmd([[
        if ! pgrep -x awww-daemon >/dev/null; then
            awww-daemon &
        fi

        while ! awww query >/dev/null 2>&1; do
            sleep 0.1
        done

        awww restore
    ]])
end

function M.random_video_wallpaper()
    local handle = io.popen(
        'find "' .. live_wallpaper_dir .. '" -maxdepth 1 -type f ' ..
        '\\( -iname "*.gif" \\) | shuf -n1'
    )

    if not handle then
        return
    end

    local gif = handle:read("*l")
    handle:close()

    if gif then
        hl.exec_cmd(
            'awww img "' .. gif .. '" ' ..
            '--transition-type any ' ..
            '--transition-step 150 ' ..
            '--transition-duration 1 ' ..
            '--transition-fps 240 ' ..
            '--transition-angle 90'
        )
    end
end

return M
