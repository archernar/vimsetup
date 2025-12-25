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

function git_branch() {
         local void="11";                          # Bash-Function-Args
     if [ -d ".git" ]; then
         git branch --show-current 2> /dev/null 
     else
         exit 1
     fi
}
ITEM=""
NAME=""

while getopts "f:ed" arg
do
    case $arg in
        f) ITEM="$OPTARG"
           NAME=`echo $ITEM | sed 's/[[:space:]]/-/g'`
           git checkout develop
           git pull origin develop
           git checkout -b feature/$NAME
           exit 0
           ;;
        e) echo $(git_branch) > .thisbranch
           cat .thisbranch
           exit 0
           git checkout develop
           git merge --no-ff $(git_branch)
           git branch -d feature/my-new-feature
           git push origin develop
           exit 0
           ;;
        d) echo $(git_branch) > .thisbranch
           cat .thisbranch
           git checkout develop
           git branch -D  $(cat .thisbranch)
           rm -f .thisbranch >/dev/null 2>&1;
           exit 0
           ;;

    esac
done
shift $(($OPTIND - 1))

