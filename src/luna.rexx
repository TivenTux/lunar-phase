/* REXX script that calculates current luna phase */
parse version interpreter_ver

/* set lunar month average
29 (Earth) days, 12 hours, 44 minutes and 2.9 seconds, according to wikipedia */
avg_days = 29
avg_hours = 12
avg_minutes = 44
avg_seconds = 2.9

/* convert time */
avg_hours = avg_hours / 24
avg_minutes = avg_minutes / (24 * 60)
avg_seconds = avg_seconds / (60 * 60 * 24)

lunar_month_average = avg_days + avg_hours + avg_minutes + avg_seconds
say '====================================================='
say interpreter_ver
say 'Lunar month average estimated at: ' lunar_month_average
say '====================================================='
say ''

say 'Please enter current month:'
parse pull current_month
say 'Please enter current day of month:'
parse pull current_dayofmonth

current_month = translate(current_month)
/* init */
current_month_short = 'na'
error_check = 'clr'

/* if full month str entered, produce short version */
if length(current_month) >= 3 then
    current_month_short = substr(current_month, 1, 3)

if current_month = 1 | current_month_short = 'JAN' then
    DO
    current_month = 1
    current_month_desc = 'January'
    END
else if current_month = 2 | current_month_short = 'FEB' then
    DO
    current_month = 2
    current_month_desc = 'February'
    END
else if current_month = 3 | current_month_short = 'MAR' then
    DO
    current_month = 3
    current_month_desc = 'March'
    END
else if current_month = 4 | current_month_short = 'APR' then
    DO
    current_month = 4
    current_month_desc = 'April'
    END
else if current_month = 5 | current_month_short = 'MAY' then
    DO
    current_month = 5
    current_month_desc = 'May'
    END
else if current_month = 6 | current_month_short = 'JUN' then
    DO
    current_month = 6
    current_month_desc = 'June'
    END
else if current_month = 7 |  current_month_short = 'JUL' then
    DO
    current_month = 7
    current_month_desc = 'July'
    END
else if current_month = 8 | current_month_short = 'AUG' then
    DO
    current_month = 8
    current_month_desc = 'August'
    END
else if current_month = 9 | current_month_short = 'SEP' then
    DO
    current_month = 9
    current_month_desc = 'September'
    END
else if current_month = 10 | current_month_short = 'OCT' then
    DO
    current_month = 10
    current_month_desc = 'October'
    END
else if current_month = 11 | current_month_short = 'NOV' then
    DO
    current_month = 11
    current_month_desc = 'November'
    END
else if current_month = 12 | current_month_short = 'DEC' then
    DO
    current_month = 12
    current_month_desc = 'December'
    END
else
    DO
    error_check = 'invalid_data'
    current_month = 0
    END


if DATATYPE(current_dayofmonth, 'N') then
    DO
    if current_dayofmonth < 1 | current_dayofmonth > 31 then
        DO
        error_check = 'invalid_data'
        current_dayofmonth = 0
        END
    END
else
    DO
    error_check = 'invalid_data'
    current_dayofmonth = 0
    END




days_after_new_year = ((current_month - 1) * (365/12)) + current_dayofmonth

luna_cycles = days_after_new_year / lunar_month_average
/* keep percent */
current_phase = luna_cycles - trunc(luna_cycles)

if current_phase < 0.03 | current_phase > 0.97 then
    moon_current_phase = 'New Moon'
else if current_phase >= 0.03 & current_phase < 0.25 then
    moon_current_phase = 'Waxing Crescent'
else if current_phase >= 0.25 & current_phase < 0.27 then
    moon_current_phase = 'First Quarter'
else if current_phase >= 0.27 & current_phase < 0.50 then
    moon_current_phase = 'Waxing Gibbous'
else if current_phase >= 0.50 & current_phase < 0.53 then
    moon_current_phase = 'Full Moon'
else if current_phase >= 0.53 & current_phase < 0.75 then
    moon_current_phase = 'Waning Gibbous'
else if current_phase >= 0.75 & current_phase < 0.77 then
    moon_current_phase = 'Third Quarter'
else
    moon_current_phase = 'Waning Crescent'

if length(error_check) >= 4 then
    say 'Invalid data, please try again.'
else
    say 'Moon phase for' current_month_desc current_dayofmonth ': ' moon_current_phase
