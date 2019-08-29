alias todolist='vim ~/Desktop/Todo.txt'
alias asuserver='ssh -p 22 avermill@general.asu.edu'
alias net_test='ping 1.1.1.1 -f -i0.2'
alias rot13='tr 'A-Za-z' 'N-ZA-Mn-za-m''
alias rebase='git rebase'

journal() {
	NAME="$@"
	TITLE=`echo "$NAME" | sed 's/ //g'`
	SHORTDATE=`date +%Y%m%d`
	HYPHENDATE=`date +%F`
	FILENAME="${SHORTDATE}_${TITLE}.md"

	if [ ! -f $FILENAME ]; then
		echo "#" $NAME >> $FILENAME
		echo $HYPHENDATE >> $FILENAME
	fi
	vim $FILENAME;
}

note() {
	SHORTDATE=`date +%Y%m%d`
	FILENAME="${SHORTDATE}notes.md"

	vim $FILENAME;
}

mdtohtml() {
	# The total argument list should be just the markdown filename since it was
	# already sanitized
	MDNAME="$@"
	# Simply strip off the ".md" and replace with ".html"
	HTMLNAME=`echo "$MDNAME" | sed -e 's_\(.\)\.md_\1.html_'`

	# If the file doesn't already exist
	if [ ! -f $HTMLNAME ]; then
		TITLE=`head -n 1 $MDNAME`
		# As per https://stackoverflow.com/a/14853319, for each line, execute
		# no command and join lines with "\n\n"
		cat $MDNAME | awk 1 ORS="\n\n" | pandoc -f commonmark -o $HTMLNAME
		if [ -f "HTML_BEFORE.html" ]; then
			cat <(sed -e "s:TITLE_HERE:$TITLE:" HTML_BEFORE.html) cat $HTMLNAME > $HTMLNAME
		fi
		if [ -f "HTML_AFTER.html" ]; then
			cat "HTML_AFTER.html" >> $HTMLNAME
		fi
# date = `date -u +"%a, %d %b %Y %T %z"`
	# If the file already exists
	else
		# Print error
		echo "Error," $HTMLNAME "already exists"
	fi
}
