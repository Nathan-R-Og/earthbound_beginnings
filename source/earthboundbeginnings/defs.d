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