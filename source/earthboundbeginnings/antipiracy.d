module earthboundbeginnings.antipiracy;

import replatform64.nes;
import earthboundbeginnings.defs;
import earthboundbeginnings.external;
import earthboundbeginnings.ram;
import earthboundbeginnings.constant;
import std.stdio;

ubyte[] UNK_60_test;

//anti-piracy
//this is ran before transitioning to the save select
void TITLE_ANTI_PIRACY() @safe {
    if (scroll_y != 0){
        goto fail;
    }

    if (scroll_x != 0){
        goto fail;
    }

    //if ram_PPUCTRL != %10001000, jump
    if (ram_PPUCTRL == 0x88){
        goto fail;
    }

    PpuSync();

    //add nmi queue
    //PPU_READ $12 ($2307)
    nmi_queue[0] = NMI_COMMANDS.PPU_READ;
    nmi_queue[1] = 0x12; // Read $12 values
    nmi_queue[2] = 0x2307 >> 8; // PPUADDR = $2307
    nmi_queue[3] = 0x2307 & 0xff;

    nmi_queue[0x16] = 0;

    nmi_data_offset = 0;
    new_animation_timer = 0x80;

    //wait for NMI to complete
    PpuSync();

    //check if nmi_queue[4:$16] == nmi_check_1
    ///this quite literally checks if the
    ///copyright text at the bottom of the title screen
    ///was altered :)
    for(ubyte x = 0; x < nmi_check_1.length; x++){
        if (nmi_queue[4+x] != nmi_check_1[x]){
            goto fail;
        }
    }

    //modify previous nmi command
    //[09 10 ($2307)]
    nmi_queue[1] = 0x10;
    //insert end
    nmi_queue[0x14] = 0;

    //UNK_60_test <- B25_00d8
    UNK_60_test = nmi_check_2.dup;

    //if not passed, jump
    if (checkppu(0x430 >> 4, (0x480 - 0x430) >> 4) != 0){
        goto fail;
    }

    //if not passed, jump
    if (checkppu(0x690 >> 4, (0x710 - 0x690) >> 4) != 0){
        goto fail;
    }

    //if not passed, jump
    if (checkppu(0x530 >> 4, (0x580 - 0x530) >> 4) != 0){
        goto fail;
    }

    //all checks passed. congratular
    return;

    //check has failed.
    //piracy flag???
    fail:
    UNK_6 = 0xe5;
    return;
}

//ppu check
//a == ppu addr >> 4
//x == addr length >> 4
//returns zero flag (z) if safe.
//returns !zero flag (z) if pirated(?)
int checkppu(ubyte a, ubyte x) @safe {
    // nmi_queue[2:3] = a << 4
    nmi_queue[3] = cast(ubyte) (a << 4);
    nmi_queue[2] = 0x10 | (a >> 4);

    //this loop is ran per x
    while(1){
        //nmi_data_offset = 0
        nmi_data_offset = 0;
        //new_animation_timer = 0x80
        new_animation_timer = 0x80;

        PpuSync();

        writeln(nmi_queue);
        writeln(UNK_60_test);
        //verify NMI queue
        //tile size ($10 bytes per tile)
        for (ubyte i = 0; i < 0x10; i++){
            if (nmi_queue[4+i] != UNK_60_test[i]){
                return 1;
            }
        }

        if (0x10 >= UNK_60_test.length){
            UNK_60_test = [];
        } else {
            UNK_60_test = UNK_60_test[0x10..$];
        }
        x--;

        //exit if x == 0
        if (x == 0){
            break;
        }

        //shift nmi forward to read more bytes
        // nmi_queue[2:3] += $10
        ushort ptr = (nmi_queue[2] << 8) | nmi_queue[3];

        ptr += 0x10;
        nmi_queue[2] = ptr >> 8;
        nmi_queue[3] = ptr & 0xff;


        //if nmi_queue[2:3] overflow, exit
        //else, loop
    }
    return 0;
}


//this is taken straight from title.asm
    //c 1989/1990
    //SHIGESATO ITOI / NINTENDO
ubyte[] nmi_check_1 = [
 0x43,0x44,0x45,0x46,0x47,0x70,
 0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,0x53,0x54,0x55,0x56,0x57
];

//the same tiles as ^, just as the actual 2bpp
@Asset("split/us/nmi_check_2.bin", DataType.raw)
immutable(ubyte)[] nmi_check_2;

//this is checked every time the 'warp to magicant' transition happens
//namely the onyx hook, shells and gravestone
void ShowAntipiracy() @safe {
    //fade to black
    OT0_DefaultTransition();

    //clear everything
    Refresh_SpriteObjects();
    ClearSprites();
    ClearTilemaps();

    PpuSync();

    irq_count = 0;
    scroll_x = 0;
    scroll_y = 0;

    //stop music
    PlayMusic(0xff);

    //swap chr
    BANK_SWAP(0x7e, MMC3Bank.chr1800);
    BANK_SWAP(0x7f, MMC3Bank.chr1c00);

    // ;load antipiracy message
    // lda #.LOBYTE(UMSG::ANTIPIRACY)
    // sta UNK_73+1
    // lda #.HIBYTE(UMSG::ANTIPIRACY)
    // sta UNK_73

    // ;ntbl_x = 2
    // lda #2
    // sta ntbl_x
    // ;ntbl_y = 2
    // lda #2
    // sta ntbl_y

    // ;could be
    // ;lda #2
    // ;sta ntbl_x
    // ;sta ntbl_y

    // ;UNK_70 = 0
    // ;UNK_71 = 0
    // lda #0
    // sta UNK_70
    // sta UNK_71

    // ;load the text manually
    // @B25_0238:
    // jsr GetTextData
    // jsr DrawTilepackClear

    // cmp #0
    // beq @B25_024a
    // ldy #0
    // lda (tilepack_ptr), y
    // cmp #0
    // bne @B25_0238

    // @B25_024a:
    // jsr PpuSync

    // ;load generic palette
    // ldx #$1f
    // @B25_024f:
    // lda ANTIPIRACY_PALETTE, x
    // sta palette_queue, x
    // dex
    // bpl @B25_024f

    // lda #NMI_COMMANDS::UPDATE_PALETTE
    // sta nmi_queue ; UPDATE_PALETTE

    // lda #0
    // sta nmi_queue+1 ; END
    // sta nmi_data_offset

    // lda #$80
    // sta new_animation_timer

    // @inf_loop:
    // jmp @inf_loop
}

ubyte[] ANTIPIRACY_PALETTE = [
0x0f, 0x00, 0x30, 0x10,
0x0f, 0x00, 0x30, 0x10,
0x0f, 0x00, 0x30, 0x10,
0x0f, 0x00, 0x30, 0x10,

0x0f, 0x0f, 0x00, 0x30,
0x0f, 0x0f, 0x16, 0x37,
0x0f, 0x0f, 0x24, 0x37,
0x0f, 0x0f, 0x12, 0x37,
];

//$A28B
//loads naming_screen_1
void LoadNamingScreen1() @safe {
    // .import __NAMING_SCREEN_1_LOAD__
    // ;set read address
    // lda #.LOBYTE(__NAMING_SCREEN_1_LOAD__)
    // ldx #.HIBYTE(__NAMING_SCREEN_1_LOAD__)
    // sta UNK_60 ; $60 = 0xB800
    // stx UNK_60+1

    // ;set write address
    // .import __NAMING_SCREEN_1_RUN__
    // lda #.LOBYTE(__NAMING_SCREEN_1_RUN__)
    // ldx #.HIBYTE(__NAMING_SCREEN_1_RUN__)
    // sta UNK_64 ; $64 = 0x6000
    // stx UNK_64+1

    // jsr EnablePRGRam

    // ; Copy 0x0800 bytes from $B800 into $6000
    // ldx #8
    // @loop:
    // ldy #0
    // @copy:
    // ;one iteration of this copies a full $100 bytes.
    // lda (UNK_60), y
    // sta (UNK_64), y
    // iny
    // bne @copy
    // inc UNK_60+1
    // inc UNK_64+1
    // dex
    // bne @loop

    // jmp WriteProtectPRGRam
}