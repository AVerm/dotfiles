DATE=`date +"%b-%d"`
LEADER="${DATE} \| "
DIR="${DATE}_in_history"
cd ~/Pictures/
mkdir "${DIR}"
find `pwd` -printf "%Ab %Ad | %h/%f\n" | grep "${DATE}" | sed -E "s:${LEADER}(.):\1:"
#find `pwd` -printf "%Ab %Ad | %h/%f | %f\n" | grep "Dec 25" | sed -E 's:Dec 25 | (.) | (.):\1 \2:'
