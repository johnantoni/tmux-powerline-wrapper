#!/usr/bin/env bash
#
# Print the status-right for tmux.
#

# The tmux-powerline-wrapper directory path.
if [ -z "$TMUX_POWERLINE_WRAPPER_DIR" ]; then
    TMUX_POWERLINE_WRAPPER_DIR=$(cd "$(dirname "$0")" && pwd)
    export TMUX_POWERLINE_WRAPPER_DIR
fi

# Source tmux-powerline-wrapper global configurations.
source "$TMUX_POWERLINE_WRAPPER_DIR/config.sh"


## Declare the variable of each segment
#
#   tmux-powerline segments path: ${segments_path}
#
#   tmux-powerline-wrapper segments path: ${wrapper_segments_path}
#
declare -A lang
lang+=(["script"]="${wrapper_segments_path}/lang.sh")
lang+=(["foreground"]="colour248")
lang+=(["background"]="colour95")
lang+=(["separator"]="${separator_left_bold}")

declare -A uptime
uptime+=(["script"]="${wrapper_segments_path}/uptime.sh")
uptime+=(["foreground"]="colour22")
uptime+=(["background"]="colour64")
uptime+=(["separator"]="${separator_left_bold}")

declare -A load_mem
load_mem+=(["script"]="${wrapper_segments_path}/load-mem.sh")
load_mem+=(["foreground"]="colour107")
load_mem+=(["background"]="colour58")
load_mem+=(["separator"]="${separator_left_bold}")

declare -A battery
if [ "$PLATFORM" == "mac" ]; then
    battery+=(["script"]="${segments_path}/battery_mac.sh")
else
    battery+=(["script"]="${segments_path}/battery.sh")
fi
battery+=(["foreground"]="colour127")
battery+=(["background"]="colour137")
battery+=(["separator"]="${separator_left_bold}")

declare -A weather
weather+=(["script"]="${wrapper_segments_path}/weather_yahoo.sh")
#weather+=(["script"]="${segments_path}/weather_google.sh")
weather+=(["foreground"]="colour255")
weather+=(["background"]="colour37")
weather+=(["separator"]="${separator_left_bold}")

declare -A date
date+=(["script"]="${wrapper_segments_path}/date.sh")
date+=(["foreground"]="colour136")
date+=(["background"]="colour235")
date+=(["separator"]="${separator_left_bold}")


#
# Register Segments
#
if [ "$window_width" -ge 122 ]; then
    register_segment "lang"
fi
if [ "$window_width" -ge 150 ]; then
    register_segment "uptime"
fi
register_segment "load_mem"
if [ "$window_width" -ge 177 ]; then
    register_segment "battery"
fi
if [ "$window_width" -ge 170 ]; then
    register_segment "weather"
fi
register_segment "date"


# Print the status line in the order of registration above.
print_status_line_right

exit 0
