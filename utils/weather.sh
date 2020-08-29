declare -a cities=(
    "Vienna",
    "Berlin",
    "New+York",
    "Toronto",
    "Dallas",
    "San+Francisco",
    "Hyderabad",
    "Sundarnagar",
    "Shimla"
)

echo "===========\n"
for city in "${cities[@]}" 
do curl wttr.in/${city}?format=3
done
echo "\n==========="
