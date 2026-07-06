module earthboundbeginnings.external;

import replatform64.assets;
import replatform64.backend.common;
import replatform64.nes;

import std.concurrency;

NES!() nes;

void loadStuff(const scope char[] name, const scope ubyte[] data, scope PlatformBackend backend) @safe {}
void extractStuff(scope AddFileFunction, scope ProgressUpdateFunction, scope immutable(ubyte)[] data) @safe {}
