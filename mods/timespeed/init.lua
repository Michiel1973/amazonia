local setting_get = function (name, default)
    return tonumber(minetest.settings:get('timespeed_'..name) or default)
end

local log = function (t, s)
    minetest.log('action', 'Timespeed mod sets time_speed to '..s..' for '..t)
end


local daytime_start = setting_get('daytime_start', 4300)
local nighttime_start = setting_get('nighttime_start', 19359)
local daytime_speed = setting_get('daytime_speed', 72)
local nighttime_speed = setting_get('nighttime_speed', 360)
local check_interval = 10
local check_timer = 5
local storage = minetest.get_mod_storage()
local runtime_disabled = false


local set_timespeed = function()
    if runtime_disabled == true then return end

    -- We’ll never know why “millihours” can be set, but a float between
    -- 0 and 1 will be returned. So we first need to get the current time in
    -- “millihours” first before we can do anything
    local current_time = minetest.get_timeofday()*24000

    local speed = ''
    local time = storage:get_string('timespeed_time') or ''

    -- “Logic table”
    local greater_daytime = current_time >= daytime_start
    local greater_nighttime = current_time >= nighttime_start
    local lower_daytime = current_time <= daytime_start
    local lower_nighttime = current_time <= nighttime_start
    local is_day = greater_daytime and lower_nighttime
    local is_night = greater_nighttime or lower_daytime

    if is_day and time ~= 'day' then
        minetest.settings:set('time_speed', daytime_speed)
        speed = daytime_speed..' for daytime'
        storage:set_string('timespeed_time', 'day')
        log('daytime', daytime_speed)
    elseif is_night and time ~= 'night' then
        minetest.settings:set('time_speed', nighttime_speed)
        speed = nighttime_speed..' for nighttime'
        storage:set_string('timespeed_time', 'night')
        log('nighttime', nighttime_speed)
    end

end


minetest.after(check_timer, function ()
    -- Store original time speed because of this Minetest issue:
    -- https://github.com/minetest/minetest/issues/5353
    storage:set_float('timespeed_original', minetest.settings:get('time_speed'))

    -- Initially set on server start
    set_timespeed()

    -- Register regular check
    minetest.register_globalstep(function(dtime)
        check_timer = check_timer + dtime
        if check_timer >= check_interval then
            check_timer = 0
            set_timespeed()
        end
    end)
end)


-- Register chat command to disble the mod on runtime. The setting is not
-- stored and after restart the mod runs again.
minetest.register_chatcommand('timespeed', {
    params = '<start|stop> <reason>',
    description = 'Disabled time speed control via timespeed mod',
    privs = { settime = true  },
    func = function(username, paramstring)
        -- Check for validity
        local action = paramstring:gsub(' .*', '')
        local start_and_not_stop = action == 'start' and action ~= 'stop'
        local stop_and_not_start = action == 'stop' and action ~= 'start'
        if start_and_not_stop == false and stop_and_not_start == false then
            return
        end

        -- Logic table
        local stop_running = runtime_disabled == false and action == 'stop'
        local start_stopped = runtime_disabled == true and action == 'start'

        -- Perform the requested action or inform the user that the mod is
        -- started or stopped already
        if stop_running or start_stopped then
            local reason = paramstring:gsub('^%a+ ', '')
            if reason == action then reason = 'No reason given' end

            local message = ('1 sets the timespeed mod to 2 (3)'):gsub('%d', {
                ['1'] = username,
                ['2'] = action,
                ['3'] = reason
            })
            minetest.log('action', message)

            if action == 'start' then
                runtime_disabled = false
                set_timespeed()
            end

            if action == 'stop' then
                runtime_disabled = true
                local original_speed = storage:get_float('timespeed_original')
                minetest.settings:set('time_speed', original_speed)
                storage:set_string('timespeed_time', nil)
            end
        else
            if action == 'stop' then action = 'stopp' end
            local message = 'The timespeed mod is '..action..'ed already'
            minetest.chat_send_player(username, message)
        end

    end
})


-- Set original time speed value back to configuration when server shuts
-- down normally (i.e. no crash or killed process)
minetest.register_on_shutdown(function ()
    minetest.settings:set('time_speed', storage:get_float('timespeed_original'))
    storage:set_string('timespeed_time', nil)
    storage:set_string('timespeed_original', nil)
end)


