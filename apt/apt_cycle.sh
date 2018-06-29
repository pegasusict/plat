#!/bin/bash
############################################################################
# Pegasus' Linux Administration Tools #			apt-get maintenance script #
# (C)2017-2018 Mattijs Snepvangers	  #				 pegasus.ict@gmail.com #
# License: MIT						  # Please keep my name in the credits #
############################################################################
# Ver 0.0.5-BETA
# Build	20180621
START_TIME=$(date +"%Y-%m-%d_%H.%M.%S.%3N")
# Making sure this script is run by bash to prevent mishaps
if [ "$(ps -p "$$" -o comm=)" != "bash" ]; then bash "$0" "$@" ; exit "$?" ; fi
# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then echo "This script must be run as root" ; exit 1 ; fi
echo "$START_TIME ## Starting Update Process #######################"
echo "Updating apt cache"					;	apt-get -qqy update
echo "checking for distribution upgrade"	;	apt-get -qqy dist-upgrade
echo "Updating installed packages"			;	apt-get -qqy --allow-unauthenticated upgrade
echo "Cleaning up obsolete packages"		;	apt-get -qqy auto-remove
echo "Clearing old/obsolete package cache"	;	apt-get -qqy autoclean
END_TIME=$(date +"%Y-%m-%d_%H.%M.%S.%3N")
echo "$END_TIME ## Update Process Finished ########################"
