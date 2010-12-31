#!/bin/bash
# Version 4.0.0
#
# "THE COFFEE-WARE LICENSE" (Revision 12/2007):
#
# Sebastian Wicki <gandro@gmx.net> wrote this file. As long as you retain
# this notice you can do whatever you want with this stuff. If we meet some
# day, and you think this stuff is worth it, you can buy me a cup of coffee
# in return.
#

################################################################################
# DEFAULT SETTINGS #############################################################
################################################################################

# Where to log any messages
LOGFILE=

# Fetch and save the MD5 hash of the downloads (1=yes or 0=no)
MD5SUM=0

# Remove downloaded urls from input file (1=yes or 0=no)
CONSUME=0

# Arguments for wget for the file download (optional)
WGET_ARGS=

################################################################################
################################################################################
################################################################################

API_INTERFACE="http://api.rapidshare.com/cgi-bin/rsapi.cgi?sub="
API_WGET_ARGS="-q -O -"

function rs_api_call() {
local sub params reply

sub=$1
shift
params=$(rs_api_params $@)

reply=$(wget $API_WGET_ARGS "${API_INTERFACE}${sub}${params}")
if [ $? != 0 ] ; then
echo "Internal Error: wget returned with non-zero!"
return 1
elif [ "${reply:0:6}" = "ERROR:" ] ; then
echo "Rapidshare Error: ${reply:7}" | head -1
return 1
fi

echo $reply | tr "," "${IFS:0:1}"

return 0
}

function rs_api_params() {
for p in $@ ; do
echo -n "&${p}"
done
}

function rs_filename() {
basename "$*"
}

function rs_fileid() {
basename $(dirname "$*")
}

function rs_getfileinfo() {
local filename fileid fileinfo

filename=$(rs_filename $1)
fileid=$(rs_fileid $1)

fileinfo=(`rs_api_call checkfiles_v1 \
files=$fileid filenames=$filename incmd5=$MD5SUM`)

if [ $? != 0 ] ; then
echo ${fileinfo[*]}
return 1
elif [ "${fileinfo[4]}" -ne 1 ] ; then
case "${fileinfo[4]}" in
0)
echo "Rapidshare Error: File not found!"
return 1
;;
3)
echo "Rapidshare Error: Server down!"
return 1
;;
4)
echo "Rapidshare Error: File marked as illegal!"
return 1
;;
5)
echo -n "Rapidshare Error: Anonymous file locked, "
echo "because it has more than 10 downloads already"
return 1
;;
esac
fi

echo ${fileinfo[@]}
}

function rs_freeuser_download_url() {
local reply secs server dlauth

reply=$(rs_api_call download_v1 fileid=$1 filename=$2)

if [ $? != 0 ] ; then
if echo $reply | grep -q "You need to wait" ; then
secs=$(echo "${reply[*]}" | sed -nr 's/.* ([0-9]+) seconds.*/\1/p')
log_countdown $secs "Download limit reached. Please wait:"

rs_freeuser_download_url $@
return $?
else
log_print $reply
return 1
fi
fi


reply=($reply)
server=$(echo ${reply[0]} | cut -d':' -f2)
dlauth=${reply[1]}
secs=${reply[2]}

log_countdown $secs "Ready. Please wait:"

echo -n "http://${server}/cgi-bin/rsapi.cgi?sub=download_v1&"
echo "fileid=${1}&filename=${2}&dlauth=${dlauth}"
}

function rs_download() {
local fileinfo fileid filename filesize md5sum url

fileinfo=(`rs_getfileinfo $1`)
if [ $? != 0 ] ; then
log_print "${fileinfo[*]} (URL: ${1})"
return 1
fi

fileid=${fileinfo[0]}
filename=${fileinfo[1]}

filesize=$((${fileinfo[2]} / 1024 / 1024))


log_print "Downloading \"${filename}\" (${filesize} MiB)"

md5=$(echo ${fileinfo[6]} | tr '[:upper:]' '[:lower:]')
if [ "${MD5SUM}" = 1 ] ; then
local md5line="${md5} ${filename}"
if ! grep -q "${md5line}" MD5SUMS ; then
echo "${md5} ${filename}" >>MD5SUMS
fi
fi

url=$(rs_freeuser_download_url $fileid $filename)
if [ $? != 0 ] ; then
return 1
elif [ -e $filename ] ; then
log_print -n "Warning: ${filename} already exists - "
filename=$(mktemp -u "${filename}.XXXX")
log_print "saving as ${filename}"
fi

wget $WGET_ARGS -O $filename "${url}" >&2
return $?
}

function log_init() {
if [ -n "${LOGFILE}" ]; then
exec 2>>$LOGFILE
fi

if [ -t 2 ] ; then
WGET_ARGS="--progress=bar:force ${WGET_ARGS}"
else
WGET_ARGS="-nv ${WGET_ARGS}"
fi
}

function log_close() {
exec 2>&-
}

function log_countdown() {
local countdown=$1
local message=${2:-Please wait:}

if [ -t 2 ]; then
while [ $countdown -gt 0 ] ; do
printf "\r${message} %02d:%02d..." \
$((countdown/60)) $((countdown%60)) >&2

let countdown--
sleep 1
done
log_print " done."
else
printf "${message} %02d:%02d...\n" \
$((countdown/60)) $((countdown%60)) >&2

sleep $countdown
fi
}

function log_print() {
echo $@ >&2
}

#
# Main programm
#

while [ -n "${1}" ] ; do
case ${1} in
-l|--log)
LOGFILE=${2?"Missing logfile"}
shift
;;
-m|--md5sum)
MD5SUM=1
;;
-c|--consume)
CONSUME=1
;;
-i|--input)
INPUT=${2?"Missing inputfile"}
shift
;;
http://*)
URL=${1}
;;
-h|--help)
echo "Usage:"
echo
echo "  ${0} [OPTIONS] [URL]"
echo
echo "Available Options:"
echo "    -i --input  INPUTFILE   Read URLs from input file"
echo "    -l --log    LOGFILE     Write output to log file"
echo
echo "    -m --md5sum             Create MD5SUMS file"
echo "    -c --consume            Disable downloaded URLs in linklist"
echo
echo "    -h --help               Show this help page"
echo
exit
;;
*)
log_print "${0}: unknown option: ${1}"
;;
esac
shift
done

log_init

# Read from stdin/paste mode
if [ -z "${URL}" ] && [ -z "${INPUT}" ] ; then
if [ -t 0 ] ; then
INPUT="${TMP:-/tmp}/$(date +RSLINKS-%y%m%d-%H%M.txt)"
if [ -z "$EDITOR" ] ; then
echo "Notice: No input file. Enter URLs, then press CTRL+D to start."
cat >"${INPUT}"
else
echo >$INPUT
echo "#" >>$INPUT
echo "# Rapidshare Linklist - created $(date)" >>$INPUT
echo "#" >>$INPUT
echo "# - Please enter one Rapidshare link per line." >>$INPUT
echo "# - Lines starting with '#' will be ignored." >>$INPUT
echo "#" >>$INPUT

if ! $EDITOR "${INPUT}" ; then
log_print "Error: Creating new linklist aborted."
exit 1
fi
fi
else
INPUT="/dev/stdin"
fi
fi

# Downloading only one url
if [ -n "${URL}" ] ; then
rs_download "${URL}"
fi

# Start reading from the input list
if [ -n "${INPUT}" ] ; then
while read url ; do
if [ "${url:0:4}" = 'http' ] ; then
if rs_download "${url}" && [ "${CONSUME}" = 1 ] ; then
url=$(echo $url | sed -e 's/\(\.\|\/\|\*\|\[\|\]\|\\\)/\\&/g')
sed -i "s/${url}/#${url}/" "${INPUT}"
fi
fi
done < "${INPUT}"
fi

log_close