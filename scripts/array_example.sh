#!/bin/bash

############################################################
# A little cheat sheet for some weird bash array           #
# operations.                                              #
# Call like this for full experience:                      #
#   ```bash                                                #
#   ./array_example.sh ./array_example.sh echo "a a"       #
#   "b b " c d e "f g h i"                                 #
#   ```                                                    #
############################################################

quote_array(){
	# Get a copy of the items
	items=("$@")
	# Declare an empty array
	quoted_array=()
	# Iterate over the array with properly quoted items
	for element in "${items[@]}"; do
		# If the element contains a space
		# (done with a regex and escaped space)
		if [[ ${element} == *\ * ]]; then
			# Add (as a string) quotes around
			# the element
			element="\"${element}\""
		fi
		# Add it to the quoted array
		quoted_array+=("${element}")
	done
	# No need to do anything here, bash lets you see the
	# local variable $quoted_array from outside.
	IFS=' ' echo "inner: ${quoted_array[*]}"
}

# Grab args
args=("$@")
# Print a bunch of stuff
echo Number of arguments: $#
echo 1st argument: ${args[0]}
echo 2nd argument: ${args[1]}
echo 3nd argument: ${args[2]}
echo 4nd argument: ${args[3]}
echo 5nd argument: ${args[4]}
echo 6nd argument: ${args[5]}
# Quote any elements in the array that have spaces
quote_array "${args[@]}"
# Print the stuff out here also
IFS=' ' echo "outer: ${quoted_array[*]}"
#Execute
"${args[@]}"
