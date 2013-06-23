#!/usr/bin/env bash
# DESCRIPTION
#	link all config files to the user $HOME directory.
#
# USAGE
#	./home/install.sh
#

scriptDir="$(dirname "$0")"

#printf "repo: %s; cur: %s" "$repoDir" "$curDir"

for f in "$scriptDir"/{*,.*}; do 
	[[ -f "$f" || -h "$f" ]] || continue # only files or symlinks
	[[ "$f" == *"install.sh" || "$f" == *.swp ]] && continue # ignore install.sh and *.swp

	nf="$HOME/$(basename "$f")"
	printf "%s\n" "$f"
	if [[ -f "$nf" || -h "$nf" ]]; then
		# backup existing file
		printf "\tBackup to: %s\n" "$nf".bak
		mv "$nf"{,.bak}
	fi

	# symlink to file
	printf "\tLinking to: %s\n" "$nf"
	ln -s "$f" "$nf"
done