# adapted from https://www.raspberrypi.org/forums/viewtopic.php?t=23440

let total=$(/usr/bin/cut -d "." -f 1 /proc/uptime)

let ss=$(($total%60))
let mm=$(($total/60%60))
let hh=$(($total/3600%24))
let dd=$(($total/86400))

uptime=$(printf "%d days, %02dh %02dm %02ds" "$dd" "$hh" "$mm" "$ss")

# get the load averages
read one five fifteen rest < /proc/loadavg

echo "$(/usr/bin/tput setaf 2)
  .~~~.   .~~~.     $(/bin/date +"%A, %e %B %Y, %r")
  '. \ ' ' / .'     $(/bin/uname -srmo)$(/usr/bin/tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :     Uptime:             ${uptime}
 ~ (   ) (   ) ~    Memory:             $(/usr/bin/free -m | /usr/bin/awk 'NR==2 {printf "%sMiB (Used) / %sMiB (Total)", $3, $2}')
( : '~'.~.'~' : )   Load Averages:      ${one}, ${five}, ${fifteen} (1, 5, 15 min)
 ~ .~ (   ) ~. ~    Running Processes:  $(/bin/ps ax | /usr/bin/wc -l | /usr/bin/tr -d " ")
  (  : '~' :  )     IP Addresses:       $(/sbin/ifconfig eth0 | /bin/grep inet | head -n 1 | /usr/bin/tr -s " " | /usr/bin/cut -d " " -f 3) and $(/usr/bin/curl -s --connect-timeout 1 http://ipinfo.io/ip | /usr/bin/tail)
   '~ .~~~. ~'      Temperature:        $(/usr/bin/awk '{printf "%3.1f°C\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp)
       '~'
$(/usr/bin/tput sgr0)"
