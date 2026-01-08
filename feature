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

# --- Colors for formatting ---
BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
RESET="\033[0m"

# --- Functions ---
ansiGreen() {
    printf "${GREEN}"
}
ansiReset() {
    printf "${RESET}"
}

print_header() {
    echo -e "\n${BLUE}${BOLD}=== $1 ===${RESET}"
}

print_kv() {
    printf "${BOLD}%-25s${RESET} %s\n" "$1:" "$2"
}

check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: Required command '$1' not found.${RESET}"
        exit 1
    fi
}

# --- Main Execution ---

check_dependency git
check_dependency awk
check_dependency sed

function gitcheck() {
    if [ ! -d ".git" ]; then
         echo "Not a Git Repo"
         exit 1
    fi

    if git remote | grep -q "^origin$"; then
        echo "Remote 'origin' exists."
    else
        echo "No remote named 'origin' found."
        exit 1
    fi

    if git rev-parse --verify master >/dev/null 2>&1; then
        echo "branch master exists locally."
    else
        echo "branch master does not exist locally."
        echo "run $ git checkout -b master"
        exit 1
    fi
    if git rev-parse --verify develop >/dev/null 2>&1; then
        echo "branch develop exists locally."
    else
        echo "branch develop does not exist locally."
        echo "run $ git checkout -b develop"
        exit 1
    fi
}

# --- HELP FUNCTION ---
function usage() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo ""
    echo "A helper script for managing feature branches, releases, and hotfixes."
    echo ""
    echo "Options:"
    echo "  -h          Show this help message."
    echo "  -m <msg>    Set a custom message for merges or commits (Default: 'Merge Without Message')."
    echo "  -s          Status: Show git status and list all branches."
    echo "  -u          Update: Stage all modified files (git add -u) and commit with message 'Update'."
    echo "  -g          Run Gource."
    echo "  -a          Backup the current folder."
    echo "  -b          Backup .git folder."
    echo ""
    echo "Feature Workflow (Hardcoded to 'feature/my-new-feature'):"
    echo "  -n          New Feature: Checkout develop, pull, and create/checkout 'feature/my-new-feature'."
    echo "  -e          End Feature: Merge 'feature/my-new-feature' into develop, push, and delete local branch."
    echo "  -d          Delete Feature: Force delete 'feature/my-new-feature' without merging."
    echo ""
    echo "Release & Hotfix Workflow:"
    echo "  -r          Release Start: Increment minor version, create release branch, commit, merge to master/develop, and tag."
    echo "  -1          Hotfix Start: Increment version, update version.txt, and checkout 'hotfix/<version>'."
    echo "  -2          Hotfix Finish: Merge 'release/1.0.0' (hardcoded) into master/develop and tag."
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") -n           # Start a new feature"
    echo "  $(basename "$0") -m \"Fix\" -u  # Update tracked files with message 'Fix'"
    exit 0
}



function git_branch() {
         local void="11";                          # Bash-Function-Args
     if [ -d ".git" ]; then
         git branch --show-current 2> /dev/null 
     else
         exit 1
     fi
}

# CMD="lsgi"
# if ! command -v "$CMD" >/dev/null 2>&1; then
#         echo "Error: Required dependency '$CMD' is not installed or not in PATH." >&2
#         exit 1
# fi
ORIGIN_REACHABLE="NO"
# 1. Check if the current directory is a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
    exit 1
fi

# 2. Check if a remote named 'origin' actually exists in the config
if ! git config remote.origin.url >/dev/null 2>&1; then
    echo "Error: No remote named 'origin' configured."
    exit 1
fi

echo "Checking connectivity to 'origin'..."

# 3. Attempt to contact the remote
# We use 'git ls-remote' with exit code checking.
# 'HEAD' limits output to just the default branch to save bandwidth.
if git ls-remote origin HEAD >/dev/null 2>&1; then
    echo "✅ Success: Remote 'origin' is reachable."
    ORIGIN_REACHABLE="YES"
else
    echo "❌ Failure: Remote 'origin' is NOT reachable."
    echo "   (Possible causes: Network down, VPN required, bad credentials, or repo deleted)"
fi



ITEM=""
NAME=""
MSG="Merge Without Message"
# The file where the version number is stored
VERSION_FILE="version.txt"
# Added gource

if [ -d ".git" ]; then
    REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
    MASTER_BRANCH="master"
    # Detect Master/Main
    if git show-ref --verify --quiet refs/remotes/origin/main; then
        MASTER_BRANCH="main"
    fi
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    REMOTE_URL=$(git config --get remote.origin.url)
    HTTPS_URL=$(echo $REMOTE_URL | sed 's/[:]/./')
    HTTPS_URL=$(echo $HTTPS_URL  | sed 's/^git@/https:\/\//')
    HTTPS_URL=$(echo $HTTPS_URL  | sed 's/github[.]com[.]/github.com\//')
fi



while getopts "hgm:neds12ruba" arg
do
    case $arg in
        h) usage
           ;;
        g) GOURCEVIDEO="NO"
           if [[ "$GOURCEVIDEO" != "YES" ]]; then                                                                                               
               gource \
                --seconds-per-day 0.5 \
                --auto-skip-seconds 1 \
                --multi-sampling \
                --camera-mode track \
                --bloom-multiplier 1.2 \
                --bloom-intensity 1.5 \
                --hide mouse,progress,filenames \
                --font-size 24 \
                --title "Project History" \
                --file-idle-time 0 \
                -1920x1080
           else
                gource \
                   -1920x1080 \
                   --seconds-per-day 0.5 \
                   --auto-skip-seconds 1 \
                   --multi-sampling \
                   --stop-at-end \
                   --key \
                   --highlight-users \
                   --hide mouse,progress \
                   --file-idle-time 0 \
                   --output-ppm-stream - \
                   --output-framerate 60 \
                   | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset medium -pix_fmt yuv420p -crf 18 output.mp4v
           fi
           ;;
        m) MSG="$OPTARG"
           echo "$MSG"
           ;;
        n) gitcheck
           git checkout develop
               if git remote | grep -q "^origin$"; then
                   git pull origin develop
               else
                   echo "+++++++++++++++++++++++====="
                   echo "+++++++++++++++++++++++====="
                   echo "+++++++++++++++++++++++====="
               fi

           BRANCH_NAME="feature/my-new-feature"
           if git rev-parse --verify "$BRANCH_NAME" >/dev/null 2>&1; then
               echo "Branch '$BRANCH_NAME' exists locally."
               git checkout feature/my-new-feature
               exit 0
           else
               echo "Branch '$BRANCH_NAME' does not exist locally."
               git checkout -b feature/my-new-feature
           fi

           exit 0
           ;;
        e) gitcheck
           git checkout develop
           git merge --no-ff  feature/my-new-feature -m "$MSG"
           git branch -d      feature/my-new-feature
           if git remote | grep -q "^origin$"; then
               git push origin develop
           fi
           exit 0

           ;;
        d) gitcheck
           git checkout develop
           if git rev-parse --verify feature/my-new-feature >/dev/null 2>&1; then
               git branch -D  feature/my-new-feature
           fi
           exit 0
           ;;
        1) exit 0
           gitcheck
           git checkout master
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
           patch=${version_parts[2]}

           # Increment the patch version
           new_patch=$((minor + 1))

           # Assemble the new version string
           new_version="$major.$minor.$new_patch"

           # Write the new version back to the file
           # Print the new version to the console
           echo "$new_version" > "/tmp/$VERSION_FILE"
           echo "Version updated to $new_version"

           git checkout -b hotfix/$new_version
           cp "/tmp/$VERSION_FILE"   "$VERSION_FILE"
           exit 0
           ;;
        2) exit 0
           gitcheck
           git checkout master
           git merge --no-ff release/1.0.0
           git tag -a v1.0.0 -m 'Release 1.0.0'
           git checkout develop
           git merge --no-ff release/1.0.0
           git branch -d release/1.0.0
           if git remote | grep -q "^origin$"; then
               git push origin master develop --tags
           fi
           exit 0
           ;;
        r) gitcheck
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
           git push origin develop --tags
           git push origin master --tags

           git pull origin develop
           git pull origin master

           exit 0
           ;;

        s)  
           shopt -s dotglob
           gitcheck
           is -l *                                     | posi -x -c 6   -r 4
           is -u *                                     | posi    -c 54  -r 4
           ansiGreen
           echo "  Repository Name   " "$REPO_NAME"      | posi    -c 102 -r 4
           echo "  Remote Origin     " "$REMOTE_URL"     | posi -p -c 102 
           echo "  Remote Origin     " "$HTTPS_URL"      | posi -p -c 102 
           echo "  Production Branch " "$MASTER_BRANCH"  | posi -p -c 102 
           echo "  Current Branch    " "$CURRENT_BRANCH" | posi -p -c 102 
           ansiReset
           echo ""                                    | posi
           git branch                                 | posi
           echo ""                                    | posi
           echo "---------------------------------"   | posi
           echo "  Changes"                           | posi
           git status -s | gawk '
           /^ M/ {
               print "✅ " $2
           }
           /^[?][?]/ {
               print "❌  " $2
           }' | gawk '{print "    " $0}'    | posi
           echo ""                                    | posi
           echo "  Staged"                           | posi
           git diff --name-only --cached | gawk '
           {
               print "✅ " $0
           }' | gawk '{print "    " $0}'    | posi
           echo "---------------------------------"   | posi


           #  git diff --name-only HEAD | gawk '{print "    " $0}'    | posi
           #  git status --porcelain                     | gawk '{print "  " $2}' | posi
           


           echo ""                                    | posi
           if [ -f ".vim.vimsession" ]; then
               echo ""                                | posi 
               echo ""                                | posi 
               cat .vim.vimsession                    | gawk '{print "  " $0}' | posi 
           fi

           echo "" | posi
           echo  "  GitFlow Divergence" | posi

               # Calculate divergence
               BEHIND=$(git rev-list --count "develop..$MASTER_BRANCH")
               AHEAD=$(git rev-list --count "$MASTER_BRANCH..develop")
               echo "" | posi
               echo -e "  ${BOLD}develop${RESET} ahead of ${BOLD}$MASTER_BRANCH${RESET}: ${GREEN}$AHEAD${RESET} (New features pending release)" | posi
               echo -e "  ${BOLD}develop${RESET} behind ${BOLD}$MASTER_BRANCH${RESET}: ${RED}$BEHIND${RESET} (Hotfixes missing in develop)" | posi
           shopt -u dotglob

           WIDTH=$(tput cols < /dev/tty)
           HEIGHT=$(tput lines < /dev/tty)
           ROW=$((HEIGHT - 4))
           COLUMN=$((0 + 6))
           printf "\033[${ROW};${COLUMN}H"


           exit 0
           ;;
        u) gitcheck
           if [ "$(git branch --show-current)" != "feature/my-new-feature" ]; then
               echo "Not on 'feature/my-new-feature' branch."
               exit 1
               exit 1
           fi
           #git add -u
           git commit -m "Update"
           exit 0
           ;;
        b) if [ -d ".git" ]; then
               mkdir -p ~/BACKUPS
               rm -rf   ~/GITSTAGE
               mkdir -p ~/GITSTAGE
               filename="$(pwd | sed 's/[/ .]/_/g' | tr -d '/')_$(date +%Y%m%d_%H%M%S)"
               filename="$(echo $filename | sed 's/^_//g')"
               filename="$(echo $filename | sed 's/__/_/g')"
               filename=~/BACKUPS/$(hostname)_$filename.tar
               tar cf $filename .
               cp $filename ~/GITSTAGE
               gzip -9 $filename
               if ssh -o ConnectTimeout=2 $USER@tower exit; then
                   echo "Alamo Server is up and SSH is working."
                   scp $filename.gz $USER@tower:/home/$USER/Alamo
               else
                   echo "AlamoServer is down or unreachable."
               fi

               echo ""
               ls -lh  $filename.gz
               echo ""
               exit 0
           fi
           exit 0
           ;;
        a)     mkdir -p ~/BACKUPS
               filename="$(pwd | sed 's/[/ .]/_/g' | tr -d '/')_$(date +%Y%m%d_%H%M%S)"
               filename="$(echo $filename | sed 's/^_//g')"
               filename="$(echo $filename | sed 's/__/_/g')"
               filename=~/BACKUPS/$(hostname)_$filename.tar
               tar cf $filename .
               gzip -9 $filename
               if ssh -o ConnectTimeout=2 $USER@tower exit; then
                   echo "Alamo Server is up and SSH is working."
                   scp $filename.gz $USER@tower:/home/$USER/Alamo
               else
                   echo "AlamoServer is down or unreachable."
               fi

               echo ""
               ls -lh  $filename.gz
               rm -f $filename.gz

               echo ""
           exit 0
           ;;

    esac
done
shift $(($OPTIND - 1))

