module earthboundbeginnings.chr.bank8;

import replatform64.nes;

@Asset("split/us/chr/title.bin", DataType.raw)
immutable(ubyte)[] title_gfx;
@Asset("split/us/chr/earth.bin", DataType.raw)
immutable(ubyte)[] earth_gfx;
@Asset("split/us/chr/melody_effect.bin", DataType.raw)
immutable(ubyte)[] melody_effect;