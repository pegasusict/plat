#!/bin/bash
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 1/9 ###### creating snapshots ##########################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
#lxc  2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 2/9 ###### Updating apt cache ##########################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
apt-get -qqy update 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 3/9 ###### Updating installed packages #################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
apt-get -qqy --allow-unauthenticated upgrade 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 4/9 ###### Cleaning up obsolete packages ###############"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
apt-get -qqy autoremove 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 5/9 ###### Purging apt package cache ###################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
apt-get -qqy clean 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 6/9 ###### Emptying the trash ##########################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
trash-empty 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 7/9 ###### Clearing user cache #########################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
find /home/* -type f \( -name '*.tmp' -o -name '*.temp' -o -name '*.swp' -o -name '*~' -o -name '*.bak' -o -name '..netrwhist' \) -delete 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 8/9 ###### Deleting old logs ###########################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
find /var/log -name "*.log" -mtime +30 -a ! -name "SQLUpdate.log" -a ! -name "updated_days*" -a ! -name "qadirectsvcd*" -exec rm -f {} \;  2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp- 9/9 ###### Purging TMP directories #####################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE
# CRUNCHIFY_TMP_DIRS - List of directories to search
CRUNCHIFY_TMP_DIRS="/tmp /var/tmp"
# DEFAULT_FILE_AGE - # days ago (rounded up) that file was last accessed
DEFAULT_FILE_AGE=+2
# DEFAULT_LINK_AGE - # days ago (rounded up) that symlink was last accessed
DEFAULT_LINK_AGE=+2
# DEFAULT_SOCK_AGE - # days ago (rounded up) that socket was last accessed
DEFAULT_SOCK_AGE=+2
find $CRUNCHIFY_TMP_DIRS -depth -type f -a -ctime $DEFAULT_FILE_AGE -print -delete 2>&1 | tee -a $PLAT_LOGFILE
find $CRUNCHIFY_TMP_DIRS -depth -type l -a -ctime $DEFAULT_LINK_AGE -print -delete 2>&1 | tee -a $PLAT_LOGFILE
find $CRUNCHIFY_TMP_DIRS -depth -type f -a -empty -print -delete 2>&1 | tee -a $PLAT_LOGFILE
find $CRUNCHIFY_TMP_DIRS -depth -type s -a -ctime $DEFAULT_SOCK_AGE -a -size 0 -print -delete 2>&1 | tee -a $PLAT_LOGFILE
find $CRUNCHIFY_TMP_DIRS -depth -mindepth 1 -type d -a -empty -a ! -name 'lost+found' -print -delete 2>&1 | tee -a $PLAT_LOGFILE
################################################################################
_timestamp=$(date +"%Y-%m-%d_%H.%M.%S,%3N")
_logline="########## $_timestamp ###### Maintenance complete #############################"
echo $_logline 2>&1 | tee -a $PLAT_LOGFILE