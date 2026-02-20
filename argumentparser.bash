## Argument Parser
###################

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -l)
            SET_LIST=true
            shift
            ;;
        -all)
            SET_LIST_ALL=true
            shift
            OPTARG="$1"
            shift
            ;;
        -a)
            SET_ALBUM=true
            shift
            ;;
        -*)
            echo "Unknown option: $1"
            usage
            ;;
        *)
            # Assign positional arguments
            if [ -z "$TARGET_DIR" ]; then
                TARGET_DIR="$1"
                ARTIST_NAME="$1"
            # elif [ -z "$ARTIST_NAME" ]; then
            #    ARTIST_NAME="$1"
            else
                echo "Error: Too many arguments provided."
                usage
            fi
            shift
            ;;
    esac
done
