module earthboundbeginnings.chr.bankf;

import replatform64.nes;

@Asset("split/us/chr/battle_extra.bin", DataType.raw)
immutable(ubyte)[] battle_extra;

@Asset("split/us/chr/ui.bin", DataType.raw)
immutable(ubyte)[] ui_gfx;