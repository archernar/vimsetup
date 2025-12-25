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

if [ ! -d ".git" ]; then
     echo "Not a Git Repo"
     exit 1
fi






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
MSG="Merge Without Message"
# The file where the version number is stored
VERSION_FILE="version.txt"

while getopts "m:nedsr" arg
do
    case $arg in
        m) MSG="$OPTARG"
           echo "$MSG"
           ;;
        n) git checkout develop
           git pull origin develop
           git checkout -b feature/my-new-feature
           exit 0
           ;;
        e) git checkout develop
           git merge --no-ff  feature/my-new-feature -m "$MSG"
           git branch -d      feature/my-new-feature
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
        r) 
           git checkout develop

           # Check if the version file exists. If not, create it with a default version.
           if [ ! -f "$VERSION_FILE" ]; then
             echo "1.0.0" > "/tmp/$VERSION_FILE"
           fi

           # Read the current version from the file
           current_version=$(cat "$VERSION_FILE")

           # Use IFS to split the version string into an array (major, minor, patch)
           IFS='.' read -ra version_parts <<< "$current_version"

           # Assign parts to variables
           major=${version_parts[0]}
           minor=${version_parts[1]}
           # patch=${version_parts[2]} # Old patch number isn't needed

           # Increment the minor version
           new_minor=$((minor + 1))

           # Reset the patch version to 0
           new_patch=0

           # Assemble the new version string
           new_version="$major.$new_minor.$new_patch"
           BUILDVERSION="$major.$new_minor.$new_patch"

           # Write the new version back to the file
           # Print the new version to the console
           echo "$new_version" > "/tmp/$VERSION_FILE"
           echo "Version updated to $new_version"

           git checkout -b release/$new_version
           cp "/tmp/$VERSION_FILE"   "$VERSION_FILE"
           git add "VERSION_FILE"
           git commit -m "Version $new_version"


           git checkout master
           git merge --no-ff release/$new_version
           git tag -a v$new_version -m 'Release $new_version'
           git checkout develop
           git merge --no-ff release/$new_version
           git branch -d release/$new_version
           git push origin master develop --tags
           exit 0
           ;;

        s) echo ""
           echo "+--------------------------------------------------------------------------------+"
           echo "+--------------------------------------------------------------------------------+"
           echo ""
           git status
           echo ""
           echo ""
           git branch -a
           echo ""
           echo ""
           exit 0
           ;;

    esac
done
shift $(($OPTIND - 1))

