module earthboundbeginnings.defs;

enum MMC3Bank {
	chr0000 = 0,
	chr0800 = 1,
	chr1000 = 2,
	chr1400 = 3,
	chr1800 = 4,
	chr1c00 = 5,
	prg8000 = 6,
	prgA000 = 7,
}

enum NMI_COMMANDS {
    SKIP = 0,
    NOTHING = 1,
    BRANCH = 2,
    GOTO = 3,
    UPDATE_PALETTE = 4,
    PPU_WRITE = 5,
    PPU_WRITE_32 = 6,
    PPU_WRITE_ADDRS = 7,
    PPU_WRITE_BYTE = 8,
    PPU_READ = 9,
	PPU_READ_TEXT = 10,
}

enum PAD_A = 1 << 7;
enum PAD_B = 1 << 6;
enum PAD_SELECT = 1 << 5;
enum PAD_START = 1 << 4;
enum PAD_UP = 1 << 3;
enum PAD_DOWN = 1 << 2;
enum PAD_LEFT = 1 << 1;
enum PAD_RIGHT = 1 << 0;

enum newLine = 1;
enum stopText = 0;
enum waitThenOverwrite = 2;
enum pauseText = 3;
enum t_nop = 5;

//literally how do we do these
//char[3] text_goto(ref ushort ta) { return [4, ta & 0xff, ta >> 8]; }
//char[3] set_pos(ref ubyte tx, ubyte ty) { return [0x20, tx, ty]; }
// .define print_string(ta) $21,.LOBYTE(ta),.HIBYTE(ta)
// .define repeatTile(ta,tb) $22,ta,tb
// .define print_number(ta, tb, tc) $23,.LOBYTE(ta),.HIBYTE(ta),tb,tc

// .define price print_number $2A, 2, 0
// .define lvFIGinc print_number $58, 1, 0
// .define lvSPDinc print_number $59, 1, 0
// .define lvWISinc print_number $5A, 1, 0
// .define lvSTRinc print_number $5B, 1, 0
// .define lvFORinc print_number $5C, 1, 0
// .define lvHPPPinc print_number $5D, 1, 0
// .define attacker print_string $580
// .define beingAttacked print_string $588
// .define attackResult print_string $590
// .define damageAmount print_number $590, 2, 0
// .define defenseStat print_number $592, 2, 0
// .define partyLead print_string $670A
// .define result print_string $6d00
// .define item print_string $6D04
// .define user print_string $6D20
// .define recipient print_string $6D24
// .define currentCash print_number $7412, 3, 0
// .define cashDeposit print_number $7415, 3, 0
// .define playerName print_string $7420
// .define nintenName print_string Ninten_Data+party_info::name
// .define lloydName print_string Lloyd_Data+party_info::name
// .define anaName print_string Ana_Data+party_info::name
// .define teddyName print_string Teddy_Data+party_info::name
// .define favFood print_string $7689
// .define SMAAAAASH $97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F ; this isnt a command per se but this is helpful enough