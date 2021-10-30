#!/bin/bash

# wget http://www.festvox.org/flite/packed/flite-2.0/voices/cmu_us_slt.flitevox
LOCKFILE="/tmp/mimic-lock"
if [ ! -f "${LOCKFILE}" ];then
  touch "${LOCKFILE}"
else
  pkill mimic
  exit 0
fi
DATE=$(date +"%Y%m%d")
TIME=$(date +"%Y-%m-%d %H:%M:%S")
FILE="$HOME/nextcloud/Documents/read/${DATE}.txt"
DUR="0.55"
#DUR="1.0"
echo '####################################################################' >> ${FILE}
echo "################### $(date +"%Y-%m-%d %H:%M:%S")  DUR ${DUR} ###################" >> ${FILE}
TEXT="$(xclip -o )"
TEXTSHA="$(echo ${TEXT} | sha256sum -)"
echo "# ${TEXTSHA/ -/}#" >> ${FILE}
echo ${TEXT}
echo '####################################################################' >> ${FILE}
mimic -pw --setf duration_stretch=${DUR} -t "${TEXT}" -voice ~/cmu_us_slt.flitevox >> ${FILE}
echo '####################################################################' >> ${FILE}
      ####################### 2016-08-16 14:26:42 #######################
echo "####################### $(date +"%Y-%m-%d %H:%M:%S") ########################" >> ${FILE}
echo '####################################################################' >> ${FILE}
echo '' >> ${FILE}
rm "${LOCKFILE}"
