#!/bin/bash

# textcolor="\e[0m"
# labelcolor="\e[1;34m"



color_ctl() {
	color="$1"
	#printf "\033[97m"
	printf "\033[${color}m"
}

color_and_undo() {
	color="$1"
	message="$2"

	pre="$(color_ctl "$1")"
	post="$(color_ctl 0)"

	printf "${pre}${message}${post}"
}

color_test() {
	for i in $(seq 0 110)
	do
		color_and_undo "$i" "#${i}\n"
	done
}

color_find() {
	color="$1"
	needle="$2"

	pre="$(color_ctl $color)"
	post="$(color_ctl 0)"

	if [ "$#" -lt 3 ]
	then
		cat
	else
		printf "$3\n"
	fi | sed -e "/${needle}/ s/\(${needle}\)/${pre}\1${post}/g"
}

printf "SHELL: '$SHELL'\n"
printf "ARG 0: '$0'\n"

if [ "$SHELL" != "$(which \"$0\")" ]; then
	echo "Exec mode"
	#color_test
	#color_and_undo "$@"
else
	echo "Source mode"
fi
