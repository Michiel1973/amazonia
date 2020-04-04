**Configurable different speeds for daytime and nighttime.**

This mod allows the configuration of two tome speeds. One time speed for a defined night time and one time speed for a defined daytime. The mod stores the original time speed and restores it when the server is shut down normally.


# Chat command
All players with the `settime` permission are allowed to disable this functionality on runtime. After restarting the server the configuration will be restored and the mod controls the time speed again.

    /timespeed start Optional reason
    /timespeed stop Optional reason

The starting and stopping is logged to the server’s log file with time, date, and player name.

# Configuration
In the client’s advanced configuration you’ll find a section for the mod. The following options are settable.

~~~~
timespeed_daytime_start = 4300
timespeed_nighttime_start = 19359
timespeed_daytime_speed = 72
timespeed_nighttime_speed = 360
~~~~

The daytime start has to be earlier than the nighttime start (of course …). Daytime/Nighttime speed should not be set to 0 because then the time freezes and will never reach daytime/nighttime start. The “millihours” value is used. It ranges from 0 (midnight) to 23999 (“the other side” of midnight).

# Known issues
Since Minetest has a large delay depending on time speed and server connection the change from daytime to nighttime could “flicker” a little before the new time speed gets applied and the time of the day will be corrected. This is not fixable because this is how Minetest works.

The time index values are not accurate. There seems no way to get the current time of the day in “millihours”. The conversion unfortunately is not exact.
