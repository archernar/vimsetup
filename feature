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
THISHOME="$HOME/.vim/vimsetup"


ALAMOHOSTA="terra"
ALAMOHOSTB="tower"
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# --- Colors for formatting ---
BOLD="\033[1m"
UNDERLINE="\033[4m"
RESET="\033[0m"

RED="\033[31m"
BOLDRED="$BOLD$RED"
GREEN="\033[32m"
BOLDGREEN="$BOLD$GREEN"
YELLOW="\033[33m"
BOLDYELLOW="$BOLD$YELLOW"
BLUE="\033[34m"
BOLDBLUE="$BOLD$BLUE"
CYAN="\033[36m"
BOLDCYAN="$BOLD$CYAN"


# --- Icons ---
CHECKICON="✅"
EXICON="❌"

# --- Functions ---
ansi() {
    echo -e "$1${RESET}"
}
ansibold() {
    echo -e "${BOLD}$1${RESET}"
}
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

get_cursor_pos() {
    # 1. format the terminal to not echo user input (so the response code isn't printed)
    local old_stty=$(stty -g)
    stty -echo

    # 2. Send the request code to the terminal
    # \033[6n is the ANSI escape code for "Device Status Report"
    echo -en "\033[6n" > /dev/tty

    # 3. Read the response into variable 'pos'
    # -s: silent mode
    # -d R: read until the character 'R' (which ends the response)
    read -s -d R pos < /dev/tty

    # 4. Restore terminal settings
    stty "$old_stty"

    # 5. Parse the response
    # The response format is: ESC [ rows ; cols R
    # We strip the first 2 characters (ESC and [)
    pos=${pos:2}
    
    # Split the string by the semicolon
    local row=${pos%;*}
    local col=${pos#*;}

    echo "Row: $row, Column: $col"
}


pause() {
    # -n 1 : Wait for exactly 1 character
    # -s   : Silent mode (don't echo the character to screen)
    # -r   : Raw input (don't interpret backslashes)
    # -p   : Prompt message
    # "${1:-...}" : Uses the first argument if provided, otherwise uses default text
    read -n 1 -s -r -p "${1:-Press any key to continue...}"
    echo # Output a new line so subsequent text doesn't appear on the same line
}

check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: Required command '$1' not found.${RESET}"
        exit 1
    fi
}

# -c 1: Send only 1 packet
# -W 1: Wait max 1 second for a response (can use decimal 0.2 on some versions)
# -q:   Quiet output
function is_online() {
    ping -c 1 -W 1 -q 8.8.8.8 &> /dev/null

    if [ $? -eq 0 ]; then
        return 0 # Online
    else
        return 1 # Offline
    fi
#   ALTERNATIVE -  Timeout is set to 0.1 seconds for extreme speed
#   if timeout 0.1 bash -c 'true &> /dev/tcp/8.8.8.8/53'; then
#       return 0 # Online
#   else
#       return 1 # Offline
#   fi
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
function divergence() {
    # Get the current branch name
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    # Handle detached HEAD state
    if [ "$current_branch" == "HEAD" ]; then
        echo "Error: You are in a 'detached HEAD' state."
        exit 1
    fi
    # Fetch the latest metadata from origin (quietly)
    # This ensures we are comparing against the actual state of the remote server
    #git fetch origin -q
    # Check if the upstream branch exists
    if ! git rev-parse --verify "origin/$current_branch" > /dev/null 2>&1; then
        echo "Error: Remote branch 'origin/$current_branch' does not exist or is not tracked."
        exit 1
    fi
    # Count the commits
    # 'origin..local' counts commits reachable from local but not origin (Ahead)
    ahead_count=$(git rev-list --count "origin/$current_branch..$current_branch")
    # 'local..origin' counts commits reachable from origin but not local (Behind)
    behind_count=$(git rev-list --count "$current_branch..origin/$current_branch")

    # Output the results
    echo "  $current_branch vs. origin/$current_branch" | $THISHOME/posi
    echo "    Ahead (Needs Push): $ahead_count" | $THISHOME/posi
    echo "    Behind (Needs Pull): $behind_count" | $THISHOME/posi

    # Optional: Simple summary
    if [ "$ahead_count" -eq 0 ] && [ "$behind_count" -eq 0 ]; then
        echo "    $current_branch is up to date with origin." | $THISHOME/posi
    else
        echo "    Sync required." | $THISHOME/posi
    fi
    echo ""                                    | $THISHOME/posi
}
function gitstatus() {
           shopt -s dotglob
           $THISHOME/is -l `ls|$THISHOME/lsgi`    | $THISHOME/lsgi | $THISHOME/posi -x -c 6   -r 4
           $THISHOME/is -u `ls|$THISHOME/lsgi`    |  $THISHOME/posi    -c 54  -r 4
           if is_online; then
               echo -e "  ${CHECKICON} ${BOLDGREEN}Online ${RESET}"     | $THISHOME/posi    -c 102 -r 4
           else
               echo -e "  ${EXICON} ${BOLDRED}Offline${RESET}"     | $THISHOME/posi    -c 102 -r 4
           fi
           ansiGreen
           echo "  Repository Name   " "$REPO_NAME"      | $THISHOME/posi    -c 102
           echo "  Remote Origin     " "$REMOTE_URL"     | $THISHOME/posi -p -c 102 
           echo "  Remote Origin     " "$HTTPS_URL"      | $THISHOME/posi -p -c 102 
           echo "  Production Branch " "$MASTER_BRANCH"  | $THISHOME/posi -p -c 102 
           echo "  Current Branch    " "$CURRENT_BRANCH" | $THISHOME/posi -p -c 102 
           echo "  Last Origin Fetch " $(stat -c %y .git/FETCH_HEAD) | $THISHOME/posi -p -c 102
           echo "  ThisHome          " "$THISHOME"       |  $THISHOME/posi -p -c 102
           ansiReset
           echo ""                                    | $THISHOME/posi
           git branch                                 | $THISHOME/posi
           echo ""                                    | $THISHOME/posi
           echo "---------------------------------"   | $THISHOME/posi
           echo "Changes"                           | $THISHOME/posi
           git status -s | gawk '
           /^ M/ {
               print $2
           }' | $THISHOME/lsgi | gawk '{ print "    ✅ " $1 }'    | $THISHOME/posi
           git status -s | gawk '
           /^[?][?]/ {
               print $2
           }' | tee zzz | $THISHOME/lsgi | gawk '{ print "    ❌ " $1 }'    | $THISHOME/posi



           echo ""                                    | $THISHOME/posi
           echo "Staged"                           | $THISHOME/posi
           git diff --name-only --cached | gawk '
           {
               print "✅ " $0
           }' | gawk '{print "    " $0}'    | $THISHOME/posi
           echo "---------------------------------"   | $THISHOME/posi


           #  git diff --name-only HEAD | gawk '{print "    " $0}'    | $THISHOME/posi
           #  git status --porcelain                     | gawk '{print "  " $2}' | $THISHOME/posi
           


           echo "" | $THISHOME/posi
           ansibold "${UNDERLINE}Vim Session"             | $THISHOME/posi
           if [ -f ".vim.vimsession" ]; then
               cat .vim.vimsession                    | gawk '{print "  " $0}' | $THISHOME/posi 
           fi

           echo "" | $THISHOME/posi
           ansibold "${UNDERLINE}GitFlow Divergence" | $THISHOME/posi




this_branch=$(git rev-parse --abbrev-ref HEAD)
git checkout -q master
divergence
git checkout -q develop
divergence
git checkout -q $this_branch



           shopt -u dotglob

           WIDTH=$(tput cols < /dev/tty)
           HEIGHT=$(tput lines < /dev/tty)
           ROW=$((HEIGHT - 4))
           COLUMN=$((0 + 6))
           printf "\033[${ROW};${COLUMN}H"
}


# --- HELP FUNCTION ---
function usage() {
    echo -e "\n${BOLD}Usage: $(basename "$0") [OPTIONS]${RESET}"
    echo -e "A GitFlow helper, backup utility, and status dashboard."
    echo ""
    
    echo -e "${UNDERLINE}${BOLD}General & Status${RESET}"
    echo -e "  ${BOLDGREEN}-h${RESET}          Show this help message."
    echo -e "  ${BOLDGREEN}-s${RESET}          Status: Show git status and list branches."
    echo -e "  ${BOLDGREEN}-v${RESET}          Dashboard: Enter interactive Git status loop."
    echo -e "  ${BOLDGREEN}-o${RESET}          Fetch: Quietly fetch from origin."
    echo -e "  ${BOLDGREEN}-p${RESET}          Divergence: Calculate ahead/behind counts for master/develop."
    echo -e "  ${BOLDGREEN}-g${RESET}          Gource: Visualize project history."
    echo ""

    echo -e "${UNDERLINE}${BOLD}Feature Workflow${RESET} (Hardcoded: 'feature/my-new-feature')"
    echo -e "  ${BOLDGREEN}-n${RESET}          New: Update develop, then create/checkout the feature branch."
    echo -e "  ${BOLDGREEN}-e${RESET}          End: Merge feature into develop, push, and delete local branch."
    echo -e "  ${BOLDGREEN}-d${RESET}          Delete: Force delete the feature branch without merging."
    echo -e "  ${BOLDGREEN}-u${RESET}          Update: Commit tracked files with message 'Update'."
    echo -e "  ${BOLDGREEN}-m <msg>${RESET}    Message: Set custom merge/commit message (Default: '$MSG')."
    echo ""

    echo -e "${UNDERLINE}${BOLD}Release & Hotfix${RESET}"
    echo -e "  ${BOLDGREEN}-r${RESET}          Release: Increment minor ver, merge to master/develop, and tag."
    echo -e "  ${BOLDGREEN}-1${RESET}          Hotfix Start: Increment patch ver, checkout 'hotfix/<ver>'."
    echo -e "  ${BOLDGREEN}-2${RESET}          Hotfix Finish: Merge 'release/1.0.0' into master/develop."
    echo ""

    echo -e "${UNDERLINE}${BOLD}Maintenance & Backups${RESET}"
    echo -e "  ${BOLDGREEN}-a${RESET}          Archive: Tar/Gzip current folder and SCP to Alamo host."
    echo -e "  ${BOLDGREEN}-b${RESET}          Backup: Archive .git folder specifically."
    echo -e "  ${BOLDGREEN}-f <file>${RESET}   File Transfer: SCP a specific file to Alamo hosts."
    echo -e "  ${BOLDGREEN}-g <file>${RESET}   File Transfer: SCP a specific file from Alamo hosts."
    echo -e "  ${BOLDGREEN}-x${RESET}          ${BOLDRED}Reset:${RESET} Hard reset develop/master to match origin (Destructive)."
    echo ""
    
    exit 0
}

confirm() {
   # Usage: confirm "Question text" [default (y/n)]
    local prompt="${1:-Are you sure?}"
    local default="${2:-n}"  # Default to 'n' for safety if not specified

    local reply
    
    # Check if a default is provided to format the prompt options
    if [[ "$default" =~ ^[Yy]$ ]]; then
        local options="[Y/n]"
    else
        local options="[y/N]"
    fi

    # Read user input
    echo -n -e "$prompt"
    read -r -p " $options " reply
    #read -r -p "$prompt $options " reply

    # Handle empty input (Enter key) by using the default
    if [[ -z "$reply" ]]; then
        reply="$default"
    fi

    # Check the reply
    case "${reply,,}" in  # ${reply,,} converts input to lowercase
        y|yes) return 0 ;; # Return success (true)
        *)     return 1 ;; # Return failure (false) for anything else
    esac
}
function proceed() {
    if confirm "${BOLD}${GREEN}Proceed?${RESET}"; then
        NOTHING=0
    else
        echo ""
        echo "Operation cancelled."
        echo ""
        exit 0
    fi
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
#   ORIGIN_REACHABLE="NO"
#   # 1. Check if the current directory is a git repository
#   if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#       echo "Error: Not inside a Git repository."
#       exit 1
#   fi
#   
#   # 2. Check if a remote named 'origin' actually exists in the config
#   if ! git config remote.origin.url >/dev/null 2>&1; then
#       echo "Error: No remote named 'origin' configured."
#       exit 1
#   fi
#   
#   echo "Checking connectivity to 'origin'..."
#   
#   # 3. Attempt to contact the remote
#   # We use 'git ls-remote' with exit code checking.
#   # 'HEAD' limits output to just the default branch to save bandwidth.
#   if git ls-remote origin HEAD >/dev/null 2>&1; then
#       echo "✅ Success: Remote 'origin' is reachable."
#       ORIGIN_REACHABLE="YES"
#   else
#       echo "❌ Failure: Remote 'origin' is NOT reachable."
#       echo "   (Possible causes: Network down, VPN required, bad credentials, or repo deleted)"
#   fi
#   


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



while getopts "hopvxm:neds12rubaf:g:y" arg
do
    case $arg in
        h) usage
           ;;
        o) git fetch origin -q
           ;;
        p) # Calculate divergence
           BEHIND=$(git rev-list --count "develop..origin/master")
           AHEAD=$(git rev-list --count "origin/master..develop")
           N=$((BEHIND - AHEAD))
           N="master..origin/master   ";echo -e "${BOLDGREEN}$N  $(git rev-list --count $N)${RESET}"
           N="origin/master..master   ";echo -e "${BOLDGREEN}$N  $(git rev-list --count $N)${RESET}"
           N="develop..origin/develop ";echo -e "${BOLDGREEN}$N  $(git rev-list --count $N)${RESET}"
           N="origin/develop..develop ";echo -e "${BOLDGREEN}$N  $(git rev-list --count $N)${RESET}"
           git rev-list $N
           exit 0
           ;;

        v) gitcheck
           while true; do
               # '-e' enables readline support (arrow keys, backspace works better)
               H=$(tput lines < /dev/tty)
               H=$((H - 5))
               gitstatus
               #STATUSPROMPT='$(hostname) $(pwd | sed -e 's,^$HOME,~,') \
               #($(if [ -d '.git' ]; then git branch --show-current 2> /dev/null; fi)) \
               #($(if [ -d '.git' ]; then git diff --name-only --cached | wc -l; else echo 'n'; fi),$(if [ -d '.git' ]; then git status --porcelain | wc -l; else echo 'n'; fi)) >> "

               STATUSPROMPT="Run>> "
               STATUSPROMPT="$(hostname) $(pwd)"
               BRANCHPROMPT="($(if [ -d '.git' ]; then git branch --show-current 2> /dev/null; fi))"
               SP="($(if [ -d '.git' ]; then git diff --name-only --cached | wc -l; else echo 'n'; fi),$(if [ -d '.git' ]; then git status --porcelain | wc -l; else echo 'n'; fi))"
               $THISHOME/posi -r $H  -c 1 "" 
               read -e -p "$STATUSPROMPT $BRANCHPROMPT$SP >> " cmd

               # Skip loop if input is empty
               [[ -z "$cmd" ]] && continue

               # Break loop if input is 'exit'
               [[ "$cmd" == "exit" ]] && break
               # Break loop if input is 'q'
               [[ "$cmd" == "q" ]] && break

               # Execute command (redirecting stderr to stdout so you see errors)
               eval "$cmd"
               if [[ "$cmd" =~ ^(vim|vi|apple|banana|cherry)$ ]]; then
                   NOTHING=0
               else
                   pause
               fi

           done
           exit 0
           ;;
        x) gitcheck
           echo ""
           echo ""
           if confirm "${BOLD}${RED}This will perform a hard reset of develop and master. Continue?${RESET}"; then
               git checkout develop
               git reset --hard origin/develop
               git checkout master
               git reset --hard origin/master
           else
               echo ""
               echo "Operation cancelled."
               echo ""
           fi
           exit 0
           ;;
        y) proceed
           GOURCEVIDEO="NO"
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

        s) gitcheck
           gitstatus
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
               if ssh -o ConnectTimeout=2 $USER@$ALAMOHOSTB exit; then
                   echo "Alamo Server is up and SSH is working."
                   scp $filename.gz $USER@$ALAMOHOSTB:/home/$USER/Alamo
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
        a) mkdir -p ~/BACKUPS
           filename="$(pwd | sed 's/[/ .]/_/g' | tr -d '/')_$(date +%Y%m%d_%H%M%S)"
           filename="$(echo $filename | sed 's/^_//g')"
           filename="$(echo $filename | sed 's/__/_/g')"
           filename=~/BACKUPS/$(hostname)_$filename.tar
           tar cf $filename .
           gzip -9 $filename
           if ssh -o ConnectTimeout=2 $USER@$ALAMOHOSTB exit; then
               echo "Alamo Server is up and SSH is working."
               scp $filename.gz $USER@$ALAMOHOSTB:/home/$USER/Alamo
           else
               echo "AlamoServer is down or unreachable."
           fi
           echo ""
           ls -lh  $filename.gz
           rm -f $filename.gz
           echo ""
           exit 0
           ;;
        f) filename="$OPTARG"
           if ssh -o ConnectTimeout=2 $USER@$ALAMOHOSTA exit; then
               echo ""
               echo "$ALAMOHOSTA Alamo Server is up and SSH is working."
               echo ""
               echo "scp"
               echo "    $filename"
               echo "    $USER@$ALAMOHOSTA:/home/$USER/Alamo/FILES/$filename"
               scp "$filename" "$USER@$ALAMOHOSTA:/home/$USER/Alamo/FILES/$filename"
           else
               echo "$ALAMOHOSTA Alamo Server is down or unreachable."
           fi
           if ssh -o ConnectTimeout=2 $USER@$ALAMOHOSTB exit; then
               echo ""
               echo "$ALAMOHOSTB Alamo Server is up and SSH is working."
               echo ""
               echo "scp"
               echo "    $filename"
               echo "    $USER@$ALAMOHOSTB:/home/$USER/Alamo/FILES/$filename"
               scp "$filename" "$USER@$ALAMOHOSTB:/home/$USER/Alamo/FILES/$filename"
           else
               echo "$ALAMOHOSTB Alamo Server is down or unreachable."
           fi
           echo ""
           exit 0
           ;;
        g) filename="$OPTARG"
           if ssh -o ConnectTimeout=2 $USER@$ALAMOHOSTA exit; then
               echo ""
               echo "$ALAMOHOSTA Alamo Server is up and SSH is working."
               echo ""
               echo "scp"
               echo "    $USER@$ALAMOHOSTA:/home/$USER/Alamo/FILES/$filename"
               echo "    XFR/$filename"
               mkdir -p ./XFR
               scp "$USER@$ALAMOHOSTA:/home/$USER/Alamo/FILES/$filename" "XFR/$filename"
           else
               echo "$ALAMOHOSTA Alamo Server is down or unreachable."
           fi
           echo ""
           exit 0
           ;;

    esac
done
shift $(($OPTIND - 1))


#  # BASH IF-STATEMENT OPERATORS CHEAT SHEET
#  # ==============================================================================
#  
#  # 1. SYNTAX OVERVIEW
#  # ------------------------------------------------------------------------------
#  # [ ... ]     : posix standard. Strict. Variables should be quoted: "$var"
#  # [[ ... ]]   : Bash extension. Safer, handles whitespace, supports regex.
#  # (( ... ))   : Arithmetic only. C-style syntax (no $ needed for vars).
#  
#  
#  # 2. INTEGER OPERATORS
#  # ------------------------------------------------------------------------------
#  # Method A: Classic Flags (Use inside [ ] or [[ ]])
#  # -eq  : Equal
#  # -ne  : Not Equal
#  # -gt  : Greater Than
#  # -ge  : Greater or Equal
#  # -lt  : Less Than
#  # -le  : Less or Equal
#  
#  if [ "$a" -eq 10 ]; then echo "Equal"; fi
#  
#  # Method B: Arithmetic Context (Use inside (( )))
#  # ==   : Equal
#  # !=   : Not Equal
#  # >    : Greater Than
#  # >=   : Greater or Equal
#  # <    : Less Than
#  # <=   : Less or Equal
#  
#  if (( a > 10 )); then echo "Greater"; fi
#  
#  
#  # 3. STRING OPERATORS
#  # ------------------------------------------------------------------------------
#  # Best used inside [[ ... ]] to handle spaces/empty vars safely.
#  
#  # =    : Equal (POSIX standard)
#  # ==   : Equal (Bash specific, synonym for =)
#  # !=   : Not Equal
#  # <    : ASCII alphabetical less than (needs [[ ]])
#  # >    : ASCII alphabetical greater than (needs [[ ]])
#  # -z   : String is empty (null/zero length)
#  # -n   : String is NOT empty (nonzero length)
#  
#  if [[ -z "$var" ]]; then echo "Empty"; fi
#  if [[ "$a" == "$b" ]]; then echo "Match"; fi
#  
#  
#  # 4. FILE TEST OPERATORS
#  # ------------------------------------------------------------------------------
#  # Checks the state of files on the filesystem.
#  
#  # -e   : Exists
#  # -f   : Exists and is a regular file
#  # -d   : Exists and is a directory
#  # -s   : Exists and size > 0 (not empty)
#  # -r   : Readable
#  # -w   : Writable
#  # -x   : Executable
#  # -L   : Symbolic Link
#  
#  if [[ -f "/path/to/file.txt" ]]; then echo "File found"; fi
#  if [[ ! -d "/path/to/dir" ]]; then echo "Dir missing"; fi
#  
#  
#  # 5. LOGICAL OPERATORS
#  # ------------------------------------------------------------------------------
#  # Combining multiple checks.
#  
#  # Inside [[ ... ]] (Recommended):
#  # &&   : AND
#  # ||   : OR
#  # !    : NOT
#  
#  if [[ -f "file.txt" && -r "file.txt" ]]; then echo "Exists AND Readable"; fi
#  
#  # Inside [ ... ] (Legacy):
#  # -a   : AND
#  # -o   : OR
#  # !    : NOT
#  
#  if [ -f "file.txt" -a -r "file.txt" ]; then echo "Legacy Check"; fi
#  
#  
#  # 6. ADVANCED MATCHING ( [[ ... ]] ONLY )
#  # ------------------------------------------------------------------------------
#  
#  # Globbing (Wildcards)
#  # Use * for any string, ? for any char
#  if [[ "$filename" == *.jpg ]]; then echo "Is a JPG"; fi
#  
#  # Regex (Regular Expressions)
#  # Use =~ for extended regex matching
#  # Do not quote the regex pattern on the right side
#  if [[ "$email" =~ ^.+@.+\..+$ ]]; then echo "Valid Email"; fi 
