import os

with open(f"{os.environ['DOT_FILES_DIR']}/karabiner/karabiner.edn") as karabiner_file:
    lines = karabiner_file.read().split("\n")

mode = ""
mode_set = False
mode_start = ""

for line in lines:
    if not mode_set:
        if ":rules [" in line:
            mode = line.split("[:")[-1].strip()
            if "-mode" in mode:
                mode_start = mode.split("-mode")[0].strip()
                mode_set = True
                # print(f"mode set->>{line}")
    else:
        if "]}" in line:
            mode_set = False
            # print(f"mode end->>{line}")
        elif line.strip().startswith("[:"):
            els = line.strip().split(";;")
            mapping = els[0]
            comment = ""
            if len(els) == 2:
                comment = els[1].strip()
            mapping_stripped = f"{comment} {mapping} {mode_start}".replace("[", "").replace("]", "").replace(":", "").replace('"', '').replace("_", " ").replace("-", " ").replace(".", " ")
            print(f"{mode_start}=={mapping}=={comment}=={mapping_stripped}")
