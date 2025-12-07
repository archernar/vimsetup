#!/usr/bin/bash
Tmp=/tmp/$$
Tmp0=/tmp/$$_$$
Tmp1=/tmp/$$_$$_$$
Tmp2=/tmp/$$_$$_$$_$$
Tmp3=/tmp/$$_$$_$$_$$_$$
trap 'exit 0' INT HUP QUIT TERM ALRM USR1
trap 'rm -f "$Tmp" "$Tmp0" "$Tmp1" "$Tmp2" "$Tmp3"' EXIT
rm -f "$Tmp" "$Tmp0" "$Tmp1" "$Tmp2" "$Tmp3"  >/dev/null 2>&1;
#  >/dev/null 2>&1;

REVERSE="NO"
while getopts "bfsmudpirj" arg
do
    case $arg in
        b) REVERSE="YES"
           ;;
    esac
done
shift $(($OPTIND - 1))

BASHLIBHOME=..
source $BASHLIBHOME/bash.library

if [ "REVERSE" == "YES" ]; then                                                                                               
    #echo "Exiting main script."
fi

VERSION_FILE="version.txt"
if [ ! -f "$VERSION_FILE" ]; then
  echo "1.0.0" > "$VERSION_FILE"
fi
