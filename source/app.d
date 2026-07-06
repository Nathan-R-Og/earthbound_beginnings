import replatform64.nes;
import std.format;
import std.functional;
import std.logger;
import std.meta;

import earthboundbeginnings.external;
import earthboundbeginnings.commondefs;
import earthboundbeginnings.constant;
import earthboundbeginnings.ram;

//assets
import earthboundbeginnings.chr.bank8;
alias loadableDataModules = AliasSeq!(earthboundbeginnings.chr.bank8);

void main(string[] args) {
	nes.entryPoint = &Reset_Vector;
	nes.interruptHandlerVBlank = &NmiHandler;
	nes.title = "Earthbound Beginnings"; //window title
	nes.gameID = "ebb"; //rom
	if (nes.parseArgs(args)) {
		return;
	}
	auto settings = nes.loadSettings!GameSettings();
	nes.initialize();
	nes.handleAssets!loadableDataModules([&extractStuff], [&loadStuff]);
	nes.run();
	nes.saveSettings(settings);
}
