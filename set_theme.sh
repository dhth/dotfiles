#!/bin/sh

themes=(gruvbox-dark gruvbox-light neodark) 

theme_to_set=$1

other_themes=${themes[@]/$theme_to_set}
# echo $other_themes


for theme in ${other_themes[@]}
do
   sed -i '' "s/^source-file \~\/tmux-$theme-sq\.conf$/# source-file \~\/tmux-$theme-sq\.conf/g" $DOT_FILES_DIR/tmux/.tmux.conf
done

sed -i '' "s/^# source-file \~\/tmux-$theme_to_set-sq\.conf$/source-file \~\/tmux-$theme_to_set-sq\.conf/g" $DOT_FILES_DIR/tmux/.tmux.conf

echo -e "\033]50;SetProfile=$theme_to_set\a"
tmux source-file ~/.tmux.conf

echo "$theme_to_set set."
