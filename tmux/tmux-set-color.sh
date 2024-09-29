#!/usr/bin/env sh

choose_color() {
    arg="$1"
    colors="#d3869b #b8bb26 #83a598 #a89984 #8ec07c #fe8019 #fabd2f"
    # Take the ASCII value of the first character of the argument
    ascii_value=$(printf "%d" "'$arg")
    # Use modulus to get a valid index within the range of colors
    index=$(expr $ascii_value % $(echo "$colors" | wc -w))
    # Extract the color at the computed index
    selected_color=$(echo "$colors" | cut -d ' ' -f $((index + 1)))
    echo "$selected_color"
}

# validate_color() {
#     color_pattern="^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
#     if ! [[ $1 =~ $color_pattern ]]; then
#         echo "Error: Invalid color format. Please provide a hexadecimal color code (e.g., #RRGGBB)."
#         exit 1
#     fi
# }
validate_color() {
    color_pattern="^#\\([A-Fa-f0-9]\\{6\\}\\|[A-Fa-f0-9]\\{3\\}\\)$"
    if ! echo "$1" | grep -Eq "$color_pattern"; then
        echo "Error: Invalid color format. Please provide a hexadecimal color code (e.g., #RRGGBB)."
        exit 1
    fi
}

if [ $# -eq 0 ]; then
    argument=$(basename "$PWD")
    selected_color=$(choose_color "$argument")
else
    argument="$1"
    validate_color "$argument"
    selected_color="$argument"
fi

echo $selected_color
# tmux set status-left "#[fg=#282828,bg=$selected_color] #S "
