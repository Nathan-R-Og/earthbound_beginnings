import replatform64.nes;
import std.format;
import std.functional;
import std.logger;
import std.meta;

import earthboundbeginnings.external;
import earthboundbeginnings.commondefs;
import earthboundbeginnings.constant;
import earthboundbeginnings.ram;
import earthboundbeginnings.debugging;

//assets
import earthboundbeginnings.constant;
import earthboundbeginnings.antipiracy;
import earthboundbeginnings.chr.tilesets;
import earthboundbeginnings.chr.enemies;
import earthboundbeginnings.chr.bank8;
import earthboundbeginnings.chr.characters;
import earthboundbeginnings.chr.bankf;
import earthboundbeginnings.chr.us;
alias loadableDataModules = AliasSeq!(
	earthboundbeginnings.constant,
	earthboundbeginnings.antipiracy,
	earthboundbeginnings.chr.tilesets,
	earthboundbeginnings.chr.enemies,
	earthboundbeginnings.chr.bank8,
	earthboundbeginnings.chr.characters,
	earthboundbeginnings.chr.bankf,
	earthboundbeginnings.chr.us
);

void main(string[] args) {
	nes.entryPoint = &Reset_Vector;
	nes.interruptHandlerVBlank = &NmiHandler;
	nes.title = "Earthbound Beginnings"; //window title
	nes.gameID = "earthbound_beginnings"; //rom
	nes.debugMenuRenderer = (&prepareDebugUI).toDelegate;
	nes.gameStateMenu = (&renderDebugWindow).toDelegate;
	if (nes.parseArgs(args)) {
		return;
	}
	auto settings = nes.loadSettings!GameSettings();
	nes.initialize();
	nes.handleAssets!loadableDataModules([&extractStuff], [&loadStuff]);
	nes.run();
	nes.saveSettings(settings);
}
