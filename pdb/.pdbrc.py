import pdb


if hasattr(pdb, 'DefaultConfig'):
    class Config(pdb.DefaultConfig):
        sticky_by_default = True
