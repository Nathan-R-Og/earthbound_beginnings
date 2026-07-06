module earthboundbeginnings.ram;

import replatform64.nes;

// zeropage global variables
ubyte UNK_0;
ubyte UNK_1;
ubyte UNK_2;
ubyte UNK_3;
ubyte UNK_4;
ubyte UNK_5;
ubyte UNK_6; // antipiracy byte
ubyte music_bank; // $7
ubyte melody_timer; // $8
ubyte[3] UNK_9;
ubyte player_direction; // $C
ubyte UNK_d;
ubyte fade_type; // $E
ubyte UNK_f;
ubyte map_tileset_1; // $10
ubyte map_tileset_1_lobits; // $11
ubyte map_tileset_2; // $12
ubyte map_tileset_2_lobits; // $13
ubyte map_current_palette; // $14
ubyte map_area; // $15
ubyte map_meta_nullchunk; // $16
ubyte map_meta_nulltilesetchr; // $17
ushort player_x; // $18
ushort player_y; // $1A
ubyte[3] UNK_1c;
ubyte UNK_1F; // $1F -> 1 when run button is held?
ubyte fade_flag; // $20
ubyte is_scripted; // $21 -> An object index?
ubyte autowalk_direction; // $22 ; For cutscenes? If bit 4 is set, then walks through other objects
ubyte is_tank; // $23
ubyte UNK_24;
ubyte UNK_25;

ushort random_num; // $26
// $28 -> Object script character ID
// $29 -> Object script item ID
ubyte[2] UNK_28;
ushort global_wordvar; // $2A // Object script 16-bit number
ubyte[4] UNK_2C;
void* object_pointer; // $30 // Pointer to object_memory
void* object_data; // $32 // Pointer to ROM object data
ubyte UNK_34; // $34 -> Object script interaction type
ubyte object_script_offset; // $35 // TODO: APPLY ALL LABELS
ubyte UNK_36;
ubyte UNK_37;
ubyte[2] UNK_38; //probably a party_info pointer
ubyte[4] UNK_3A;
ushort movement_direction; // $3E
ubyte UNK_40; // $40 -> CHR bank 2 during IRQ?
ubyte UNK_41; // $41 -> CHR bank 3 during IRQ?
ubyte UNK_42; // $42 -> CHR bank 4 during IRQ? -- ALSO: Another party member? Seems related to $28
ubyte UNK_43; // $43 -> CHR bank 5 during IRQ?
ubyte UNK_44;
ubyte UNK_45;
ubyte UNK_46; // $46 -> Some scanline for IRQ?
ubyte UNK_47;


ubyte enemy_group; // $48
ubyte[7] UNK_49;
// $4E -> Damage (16-bit) -- only during battle?
ubyte[0x10] UNK_50;
// $53 -> Attacker offset -- in battles
// $54 -> Target offset -- in battles
// $58 -> Move type -- only during battle?
ushort UNK_60;
ushort UNK_62;
ushort UNK_64;
ushort UNK_66;
ushort UNK_68;
ushort UNK_6A;
ushort UNK_6C;
ushort UNK_6E;
ubyte UNK_70;
ubyte UNK_71;
ubyte UNK_72;
ushort text_id;
ubyte UNK_73;
ubyte[] tilepack_ptr; // $74
ubyte ntbl_x;
ubyte ntbl_y;
ubyte UNK_78;
ubyte UNK_79;
ubyte UNK_7A;
ubyte UNK_7B;
ubyte UNK_7C;
ubyte UNK_7D;
ubyte char_count;          // counts chars (not charas...)
ubyte byte_count;          // counts bytes (todo: find purpose)
ubyte[2] UNK_80;

// Position of menu cursor in whole numbers, incrementing by 1 per step
ubyte[2] menucursor_pos; // $82
ubyte[2] UNK_84;
ubyte menu_x_pos; // $86 // X pos in whole numbers
ubyte menu_y_pos; // $87 // Y pos in whole numbers
void* map_tmp_ptr; // $88
ubyte[2] UNK_8A;
ubyte[4] UNK_8C;
ubyte[4] UNK_90;
ubyte UNK_94; // map bank
ubyte UNK_95;
ubyte UNK_96;
ubyte UNK_97;
ubyte[3] UNK_98;
ubyte UNK_9B;
ubyte[4] UNK_9C;
// $a0 -> Player movement direction?
ubyte UNK_A0;
ubyte UNK_A1;
ubyte UNK_A2;
ubyte UNK_A3;
ubyte UNK_A4;
ubyte UNK_A5;
ubyte[2] UNK_A6; //object object_m_colPointer?
ubyte UNK_A8;
ubyte UNK_A9;
// $aa -> X position for collision detection?
ubyte[2] UNK_AA; //mirror of xpos? object world xpos?
// $ac -> Y position for collision detection?
ushort UNK_AC; //mirror of ypos? object world ypos?
ubyte[2] UNK_AE;
ubyte unk_b0; // $b0
ubyte unk_b1; // $b1
ubyte unk_b2; // $b2
ubyte unk_b3; // $b3
ubyte unk_b4; // $b4
ubyte UNK_b5; // $b5
ubyte[2] unk_b6; // $b6 //two byte
ubyte[2] UNK_b8; // $b7
ubyte unk_ba; // $ba
// $bb -> Something to do with music (2 bytes). Interacts with $07FF
ubyte[2] unk_bb; // $bb //SOMETIMES two byte???? lohi??? probably
// $bd -> Current music channel? (1=noise, 2=pulse1, 3=pulse2, 4=triangle, 5=dmc)?
ubyte unk_bd; // $bd
ubyte unk_be; // $be
ubyte unk_bf; // $bf
//basically func ram.
ubyte[0x10] UNK_C0;
ubyte[3] dad_call_timer; // $d0 // 24 bit
ubyte dad_call_input_time; // How many multiples of 256 frames the controller hasn't been touched. Stops counting at 42 (about 3 minutes). When 42, the dad call timer also stops counting.
ubyte UNK_D4;
ubyte step_count; // $d5 // used for poison / cold. every 8 steps inflicts damage
ubyte UNK_D6; //seems to copy UNK_D4, but UNK_D4 can continue???
void function() @safe post_nmi_callback; //either a valid JMP instruction, or the first byte is 00 (if zero, then don't jump)
ubyte pad1_forced; // $da
ubyte pad2_forced; // $db
ubyte pad1_press; // $dc
ubyte pad2_press; // $dd
ubyte pad1_hold; // $de
ubyte pad2_hold; // $df
// Timer that ticks down during NMI, at a rate influenced by the frame skip setting (UNK_E7)
ubyte current_animation_timer; // $e0

ubyte frameskip_this_frame;
ubyte oam_and_300_clear_flag; // $e2 // Set Bit 7 before Clear OAM & $300 are, Free bit after
ubyte sprite_object_set2_start;
ubyte oam_set2_start;
// Set new_animation_timer to something nonzero to trigger the processing of the NMI command queue.
// You should only write to it after setting up the NMI queue, to avoid race conditions.
// As the name suggests, the low 7 bits are also used to initialize current_animation_timer, once/if
// there is no current animation timer running. (If you don't want to start a new timer, write 0x80,
// which is nonzero but has the low 7 bits all set to 0. That will only process the NMI queue.)
// Reading it and checking that it's nonzero is a way to tell if the NMI queue has been processed
// or not.
ubyte new_animation_timer; // $e5
ubyte nmi_data_offset; // $e6
ubyte UNK_E7; // $e7 - low 6 bits are a frameskip setting// bit 6 seems to be a "camera shake mode" toggle// bit 7 seems unused...?
ubyte shift_x; // $e8
ubyte shift_y; // $e9
ubyte nmi_mode; // $ea // 01 = waiting for NMI, 80 = is running non-reentrant part of NMI handler
ubyte irq_latch; // $eb
ubyte irq_count; // $ec // IRQ Count
ubyte irq_index; // $ed // IRQ routine index (multiple of 2)
ubyte bankswitch_mode; // $ee // Bankswitch "mode"  (-----mmm), $8000 MMC3 register
// $ef // Bankswitch "flags" (ff------), $8000 MMC3 register
//basically read only for the top two bits of BANKSELECT, set at the start of Reset
ubyte bankswitch_flags;
ubyte[8] current_banks; // $f0 // Current banks for each "mode" (8 bytes)
ubyte[4] UNK_F8;
ubyte scroll_y; // $fc
ubyte scroll_x; // $fd
ubyte ram_PPUMASK; // $fe
ubyte ram_PPUCTRL; // $ff

struct Vector2B {
    ubyte x_vel;
    ubyte y_vel;
}

struct SpriteTile {
	Vector2B position;
	ubyte attr;
	ubyte id;
}

struct SpritePointerDef {
	SpriteTile* pointer;
	ubyte base_tile_id;
	ubyte palettes;
}

// *** RAM DEFINES ***

ubyte[0x10] UNK_100;
ubyte[0x40] text_data_buffer;
ubyte[0xb0] stack;

OAMEntry[64] shadow_oam;
struct SpriteObject {
	ubyte count_flags;
	ubyte oam_slot_flags;
	Vector2B position;
	Vector2B velocity;
	Vector2B shake;
	SpritePointerDef* spriteDef;
}
SpriteObject[32] SPRITE_OBJECTS;
ubyte[0x100] nmi_queue;

ubyte[0x20] palette_queue;
ubyte[0x20] palette_backup;
ubyte[0x40] irq_pointers;


ubyte[0x100] unk0700;
ubyte soundqueue_noise; //$07F0
ubyte soundqueue_pulseg0; //$07F1
ubyte soundactive_unk; //$07F2
ubyte soundqueue_triangle; //$07F3
ubyte soundqueue_pulseg1; //$07F4
ubyte soundqueue_track; //$07F5

ubyte current_music;
ubyte sram_mode;

// *** SRAM DEFINES ***

struct party_info {
    ubyte unk_0;
    ubyte status;
    ubyte resistances;
    ushort max_hp;
    ushort max_pp;
    ushort offense;
    ushort defense;
    ubyte fight;
    ubyte speed;
    ubyte wisdom;
    ubyte strength;
    ubyte force;
    ubyte level;
    ubyte[3] exp;
    ushort curr_hp;
    ushort curr_pp;
    char* name_pointer;
    ubyte unk_1a;
    ubyte unk_1b;
    ubyte unk_1c;
    ubyte unk_1d;
    SpritePointerDef* sprite_pointer;
    ubyte[8] items;
    ubyte weapon;
    ubyte coin;
    ubyte ring;
    ubyte pendant;
    ushort[2] crumb_coords;
    bool[64] psi_learntable;
    char[8] name;
}

struct save_file_structure {
    ushort checksum;
    ubyte slot;
    ubyte state;
    ushort[2] current_daDef;
    ubyte[4] party_members;
    ushort[2] saved_daDef;
    ushort wallet_money;
    ubyte[3] bank_money;
    ubyte[3] dad_money;
    ubyte battle_message_speed;
    ubyte repel_counter;
    ubyte[4] unk_1a;
    ubyte unk_1e;
    ubyte big_bag_uses;
    char[17] player_name;
    ubyte[11] player_name_end;
	ubyte[4] preferences;
	party_info ninten_data;
	party_info ana_data;
	party_info lloyd_data;
	party_info teddy_data;
	party_info pippi_data;
	party_info eve_data;
	party_info flyingman_data;
	bool[256] story_flags;
	bool[512] present_flags;
	ubyte[32] counters;
}

save_file_structure save_file_current;
save_file_structure save_file_1;
save_file_structure save_file_2;
save_file_structure save_file_3;
