
# #####################################################################################################
# #####################################################################################################
# #####################################################################################################
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <vim_files>"
    exit 1
fi

gawk '
    /^[ ]*fu(nc|nction)/ {
        print $0
    }
' "$@"

function examplesComparison() {
    local local str="$2"                   # Bash-Function-Args

    # String Comparisons

    if [ "$string1" == "$string3" ]; then
      echo "string1 and string3 are equal"
    fi

    if [ "$string1" != "$string2" ]; then
      echo "string1 and string2 are not equal"
    fi

    if [ "$string1" = "$string3" ]; then
      echo "string1 and string3 are also equal"
    fi

    if [ -z "$empty_string" ]; then
      echo "empty_string is empty"
    fi

    if [ -n "$non_empty_string" ]; then
      echo "non_empty_string is not empty"
    fi

    if [ ! "$empty_string" ]; then
      echo "empty_string is empty (using negation)"
    fi


    # Numeric Comparisons

    if [ "$num1" -eq "$num3" ]; then
      echo "$num1 is equal to $num3"
    fi

    if [ "$num1" -ne "$num2" ]; then
      echo "$num1 is not equal to $num2"
    fi

    if [ "$num1" -lt "$num2" ]; then
      echo "$num1 is less than $num2"
    fi

    if [ "$num2" -gt "$num1" ]; then
      echo "$num2 is greater than $num1"
    fi

    if [ "$num1" -le "$num3" ]; then
      echo "$num1 is less than or equal to $num3"
    fi

    if [ "$num2" -ge "$num1" ]; then
      echo "$num2 is greater than or equal to $num1"
    fi

    echo ""

    # File Comparisons
    ddecho "--- File Comparisons ---"

    touch my_file.txt
    mkdir my_directory
    chmod +x my_file.txt # Make it executable for -x test

    if [ -e "my_file.txt" ]; then
      echo "my_file.txt exists"
    fi

    if [ -f "my_file.txt" ]; then
      echo "my_file.txt is a regular file"
    fi

    if [ -d "my_directory" ]; then
      echo "my_directory is a directory"
    fi

    if [ -r "my_file.txt" ]; then
      echo "my_file.txt is readable"
    fi

    if [ -w "my_file.txt" ]; then
      echo "my_file.txt is writable"
    fi

    if [ -x "my_file.txt" ]; then
      echo "my_file.txt is executable"
    fi

    if [ -s "my_file.txt" ]; then
      echo "my_file.txt exists and is not empty"
    fi
}
# #####################################################################################################
# #####################################################################################################
# #####################################################################################################

