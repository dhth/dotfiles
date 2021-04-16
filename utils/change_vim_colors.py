import re
import sys
import os

def update_config(colorscheme, background_type, vim_config_file_loc, begin_marker, end_marker):
    chop = re.compile(f"{begin_marker}.*?{end_marker}", re.DOTALL)

    f = open(vim_config_file_loc, "r")
    data = f.read()
    f.close()

    if background_type == "dark":
        new_config = """
set background=dark
colorscheme {colorscheme}
        """
    elif background_type == "light":
        new_config = """
set background=light
colorscheme {colorscheme}
        """
    elif background_type == "timed":
        new_config = """
if strftime("%H") > 8 && strftime("%H") < 14
  set background=light
  colorscheme {colorscheme}
else
  set background=dark
  colorscheme {colorscheme}
endif
        """
    updated_text = f"{begin_marker}\n{new_config.format_map({'colorscheme':colorscheme})}\n{end_marker}"
    data_chopped = chop.sub(updated_text, data)

    f = open(vim_config_file_loc, "w")
    f.write(data_chopped)
    f.close()

if __name__ == "__main__":
    colorscheme = sys.argv[1]
    background_type = sys.argv[2]
    vim_config_file_loc = f'{os.environ["NVIM_DIR"]}/keys/colors.vim'
    update_config(
        colorscheme,
        background_type,
        vim_config_file_loc,
        begin_marker="\" VIMCOLORSSTART",
        end_marker="\" VIMCOLORSEND",
    )
    print(f"Changed to {colorscheme} {background_type}.")
