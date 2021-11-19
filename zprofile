let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
let freeMem="$(cat /proc/meminfo | grep MemFree | awk {'print $2'})"
let totalMem="$(cat /proc/meminfo | grep MemTotal | awk {'print $2'})"

UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`
FREE=`bc -l <<< "scale=2; $freeMem/1000000"`
TOTAL=`bc -l <<< "scale=2; $totalMem/1000000"`

freeRoot=$(df -H | grep -E '^/dev/root' | awk '{ print $4 }')

wxrss="http://rss.accuweather.com/rss/liveweather_rss.asp?metric=0&locCode=NAM|US|MO|KANSAS%20CITY"

platform=$(dmesg 2>/dev/null | grep "Raspberry")

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %r"`
  '. \ ' ' / .'   `/bin/hostname` - `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.    Platform...........: ${platform//*: /}
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Memory.............: ${FREE}G (Free) / ${TOTAL}G (Total)
( : '~'.~.'~' : ) Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~  Running Processes..: `ps ax | wc -l | tr -d " "`
  (  : '~' :  )   IPv4 Address.......: `/sbin/ifconfig -a | awk '/(cast)/ { print $2 }' | cut -d':' -f2 | head -1`
   '~ .~~~. ~'    Weather............: `curl -s ${wxrss} | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
       '~'        $(tput setaf 3)Free Disk Space....: ${freeRoot} on /
$(tput sgr0)"
