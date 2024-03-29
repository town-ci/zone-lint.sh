#!/bin/bash
# zone-lint.sh: This script checks zonefiles format.
#        usage: ./zone-lint.sh zonefile
#

SCRIPT_PATH=`echo $(cd $(dirname $0);pwd)`
TMPFILE=/tmp/zone.$$.$(date +%s)
TMPFILE2=/tmp/zone.$(date +%s).$$

RETV=0

if [ ! -e ${SCRIPT_PATH}/txtformatter.sh ];
then
  echo "txtformatter.sh not found"
  exit 9
fi

if [ $# -ne 1 ];
then
    echo "Usage: $0 zonefile";
    exit 9
fi

if [ ! -e $1 ];
then
  echo "$1: not found"
  exit 9
fi


${SCRIPT_PATH}/txtformatter.sh $1 | grep -v "^;" > $TMPFILE
grep -E 'NS|MX|CNAME' $TMPFILE > $TMPFILE2

echo "Serial = $(grep -i serial $TMPFILE)"

#for iline in $(grep -E 'NS|MX|CNAME' $TMPFILE)

while read iline
do
  ENDOFLINE=$(echo ${iline} | rev | cut -c 1)
  if [ ${ENDOFLINE} != "." ];
  then
    echo "末尾の . がありません: ${iline}"
    RETV=1
  fi
done < $TMPFILE2

if [ $RETV -eq 0 ];
then
  echo "OK"
fi

exit
