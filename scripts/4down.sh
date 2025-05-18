#!/bin/bash

#set -euo pipefail
IFS=$'\n\t'

WGET_OPTS=("--quiet")
#WGET_OPTS=("--debug" "--verbose")

USERAGENT='Mozilla/5.0 (X11; Linux x86_64; rv:137.0) Gecko/20100101 Firefox/137.0'
COOKIE='__cf_bm=tM9r92tnURDzbADORD2ZOQmf92T6WuSZRtYU9MQEpSE-1747591300-1.0.1.1-a8wzT0j.AS7YaoBiFr7E4YsU5y4bxRYowrFGxJ1ZLZQZD5qfZpwi3FXxjdHqZQ7a5tgL9nysk9Aehcbzcw8hi2c6rM9Dp8nZKoEtkLsmSA4'

# Functions

show_and_run() {
	echo "$@"
	$@
}

showUrlParts() {
  echo "Thread URL is: $threadURL"
  echo "Board name is: $boardName"
  echo "Thread number is: $threadNumber"
}

downloadContent() {
  echo "downloadContent function executed"

	  #-A "html,css,jpg,jpeg,png,webp,gif,webm,mp4,mp3,m4a" -R "*s.jpg,*s.jpeg,*s.png,*s.webp" \
  # Use wget to download only full-size images and videos, avoiding the 's' versions.
  show_and_run wget "${WGET_OPTS[@]}" "${WGET_HEADERS[@]}" --recursive --convert-links --compression gzip --domains 'i.4cdn.org' \
	  --header "Referer: ${threadURL}" \
	  -np -nH -nd \
	  -e robots=off \
	  -A "html,css,jpg,jpeg,png,webp,gif,webm,mp4,mp3,m4a" \
	  -H "${threadURL}/index.html" --show-progress
}

downloadThread() {
  echo "downloadThread function executed"

  show_and_run wget "${WGET_OPTS[@]}" "${WGET_HEADERS[@]}" \
	  --header "Referer: https://boards.4chan.org/${boardName}/" \
	  -m -l 3 -nd -np -e robots=off --convert-links -w 1 \
	  "$threadURL" --show-progress
}

# Main execution
echo "(Upgraded)                        Cipher's 4chan thread download tool"
printf "
  / // / ____/ /___ _      ______
 / // /_/ __  / __ \\ | /| / / __ \\
/__  __/ /_/ / /_/ / |/ |/ / / / /
  /_/  \\____/\\____/|__/|__/_/ /_/
" | cat

echo "As a note you should also have cd'd into the directory where you want all of these contents to download to" | cat
echo "Enter the URL of the thread that you want to download: " | cat
read -p "" threadURL

# Extracting board name and thread number from URL
threadURLStripped="${threadURL#https://boards.4channel.org}"
threadURLStripped="${threadURLStripped#https://boards.4chan.org}"
threadURLStripped="${threadURLStripped//thread/}"
threadURLStripped="${threadURLStripped///}"
boardName="${threadURLStripped//[0-9]/}"

threadNumStripped="${threadURL#https://boards.4channel.org}"
threadNumStripped="${threadNumStripped#https://boards.4chan.org}"
threadNumStripped="${threadNumStripped//thread/}"
threadNumStripped="${threadNumStripped///}"
threadNumber="${threadNumStripped//[!0-9]/}"

showUrlParts

WGET_HEADERS=(--header "User-Agent: ${USERAGENT}" --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --header 'Accept-Encoding: gzip, deflate, br, zstd' --header 'DNT: 1' --header 'Sec-GPC: 1' --header 'Connection: keep-alive' --header "Cookie: ${COOKIE}" --header 'Upgrade-Insecure-Requests: 1' --header 'Sec-Fetch-Dest: document' --header 'Sec-Fetch-Mode: navigate' --header 'Sec-Fetch-Site: same-origin' --header 'Sec-Fetch-User: ?1' --header 'Priority: u=0, i')

mkdir "${threadNumber}" && pushd "${threadNumber}" > /dev/null

downloadContent

popd > /dev/null
