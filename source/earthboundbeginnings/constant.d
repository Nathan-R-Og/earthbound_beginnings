module earthboundbeginnings.constant;

import earthboundbeginnings.chr.main;

import replatform64.nes : MirrorType;

import earthboundbeginnings.music;
import earthboundbeginnings.external;
import earthboundbeginnings.ram;
import earthboundbeginnings.overworld;
import earthboundbeginnings.title;
import earthboundbeginnings.defs;
import earthboundbeginnings.structures;

import std.stdio;
import std.range;

ubyte nmi_y = 0;
ubyte tiledarea_x = 0;
ubyte tiledarea_y = 0;
ubyte[] tiledarea_stack = [];
ubyte working_tile = 0xa0;
bool printing_tilepack = false;

//UNKNOWN_C200:
//	LDA #$0F
//	STA UNKNOWN_0100
//	LDA #$03
//	ORA $EF
//	STA BANKSELECT
//	LDX #$09
//	LDY #$02
//@UNKNOWN0:
//	DEY
//	BNE @UNKNOWN0
//	BIT $00
//	JMP UNKNOWN_C220
//UNKNOWN_C218:
//	STA IRQLATCH
//	LDA #$02
//	ORA $EF
//	TAX
//UNKNOWN_C220:
//	LDY #$04
//@UNKNOWN2:
//	DEY
//	BNE @UNKNOWN2
//	RTS

//UNKNOWN_C226:
//	LDA #$0F
//	STA UNKNOWN_0100
//	RTS

// DATA NOW!
// control codes
// NOTE: in EBB, these are almost completely irrelevant. these are basically only
//here as holdover from MOTHER.
ubyte[] control_codes = [
    0x00, // 00 stopText
    0x01, // 01 newLine
    0x02, // 02 waitThenOverwrite
    0x03, // 03 pauseText
    0x08, // 04 XX XX goto
    0x09, // 05 t_nop
    0x96, // 06 が
    0x97, // 07 ぎ
    0x98, // 08 ぐ
    0x99, // 09 げ
    0x9a, // 0A ご
    0x9b, // 0B ざ
    0x9c, // 0C じ
    0x9d, // 0D ず
    0x9e, // 0E ぜ
    0x9f, // 0F ぞ
    0xa0, // 10 だ
    0xa1, // 11 ぢ
    0xa2, // 12 づ
    0xa3, // 13 で
    0xa4, // 14 ど
    0x2a, // 15 ぱ
    0x2b, // 16 ぴ
    0x2c, // 17 ぷ
    0x2d, // 18 ぺ
    0x2e, // 19 ぽ
    0xaa, // 1A ば
    0xab, // 1B び
    0xac, // 1C ぶ
    0xad, // 1D べ hirigana
    0xae, // 1E ぼ

    0x93, // 1F
    0x04, // [20 XX YY] set_pos
    0x05, // [21 XX XX] print_string
    0x06, // [22 XX YY] repeatTile
    0x07, // [23 XX XX YY ZZ AA] print_number
    0x0e, // 24 uibox_l
    0x0f, // 25 uibox_r

    0xd6, // 26 ガ
    0xd7, // 27 ギ
    0xd8, // 28 グ
    0xd9, // 29 ゲ
    0xda, // 2A ゴ
    0xdb, // 2B ザ
    0xdc, // 2C ジ
    0xdd, // 2D ズ
    0xde, // 2E ゼ
    0xdf, // 2F ゾ
    0xe0, // 30 ダ
    0xe1, // 31 ヂ
    0xe2, // 32 ヅ
    0xe3, // 33 デ
    0xe4, // 34 ド
    0x6a, // 35 パ
    0x6b, // 36 ピ
    0x6c, // 37 プ
    0x6d, // 38 ペ katakana
    0x6e, // 39 ポ
    0xea, // 3A バ
    0xeb, // 3B ビ
    0xec, // 3C ブ
    0xed, // 3D ベ katakana
    0xee, // 3E ボ
    0xd3, // 3F ヴ
];

//UNKNOWN_C26C:
//	LDA #$D9
//	LDX #$91
//	STA $74
//	STX $75
//UNKNOWN_C274:
//	JSR UNKNOWN_C542
//	JSR PpuSync
//	LDA #$19
//	LDX #$B2
//	LDY #$A2
//	JSR TempUpperBankswitch
//	LDA #$00
//	STA $EC
//	LDA #$FF
//	STA UNKNOWN_07F7
//	LDA #$0F
//	STA SND_CHN
//	JSR WaitNMI
//	LDX #$00
//@UNKNOWN0:
//	LDA #$25
//	STA UNKNOWN_0540,X
//	INX
//	LDA #$C2
//	STA UNKNOWN_0540,X
//	INX
//	CPX #$1A
//	BNE @UNKNOWN0
//	LDA #$00
//	STA UNKNOWN_0540,X
//	INX
//	STA UNKNOWN_0540,X
//	LDA #$0F
//	STA $EC
//UNKNOWN_C2B3:
//	JSR UNKNOWN_C322
//@UNKNOWN2:
//	JSR PpuSync
//	LDX #$00
//	STX $E6
//	JSR TiledArea
//	STY $E6
//	INC $77
//	LDY #$00
//	LDA ($74),Y
//	PHA
//	INY
//	LDA ($74),Y
//	PHA
//	INY
//	TYA
//	JSR AddTo_UNK_74
//	LDA $72
//	CMP #$00
//	BNE @UNKNOWN4
//	JSR TiledArea
//	JSR UNKNOWN_C306
//	PLA
//	TAX
//	PLA
//	CMP UNKNOWN_0540,X
//	BCC @UNKNOWN3
//	STA UNKNOWN_0540,X
//@UNKNOWN3:
//	LDA $72
//	CMP #$00
//	BNE @UNKNOWN2
//	RTS
//@UNKNOWN4:
//	INC $77
//	JSR ClearAreaOnScreen
//	JSR UNKNOWN_C306
//	PLA
//	TAX
//	PLA
//	CMP UNKNOWN_0540,X
//	BCC @UNKNOWN5
//	STA UNKNOWN_0540,X
//@UNKNOWN5:
//	JMP UNKNOWN_C2B3

//UNKNOWN_C306:
//	STY $E6
//	JSR UNKNOWN_C46E
//	LDA #$00
//	STA $0400,X
//	STA $E6
//	LDA #$80
//	STA $E5
//	LDA #$19
//	LDX #$1D
//	LDY #$A3
//	JSR TempUpperBankswitch
//	JMP UNKNOWN_FD4A

//UNKNOWN_C322:
//	LDA #$00
//	LDX #BANK::PRG8000
//	JMP BANK_SWAP

//UNKNOWN_C329:
//	.BYTE $20, $01, $17, $21, $4B, $92, $01, $25, $16, $21, $10, $67, $00, $25, $18, $FB, $22, $FC, $1C, $FD
//UNKNOWN_C33D:
//	.BYTE $00
//UNKNOWN_C33E:
//	.BYTE $20, $01, $15, $21, $4B, $92, $01, $25, $14, $21, $10, $67, $01, $25, $16, $21, $2E, $67, $00, $25, $18, $FB, $22, $FC, $1C, $FD, $00
//UNKNOWN_C359:
//	.BYTE $20, $01, $13, $21, $4B, $92, $01, $25, $12, $21, $10, $67, $01, $25, $14, $21, $2E, $67, $01, $25, $16, $21, $4C, $67, $00, $25, $18, $FB, $22, $FC, $1C, $FD, $00
//UNKNOWN_C37A:
//	.BYTE $24, $A0, $23, $38, $00, $00, $07, $23, $10, $00, $01, $03, $23, $14, $00, $02, $04, $23, $16, $00, $02, $04, $23, $11, $00, $03, $08, $A0, $25, $00

//UNKNOWN_C398:
//	ORA ($04,X)
//	LDY #$A0
//	AND ($A0,X)
//	LDA ($00,X)
//UNKNOWN_C3A0:
//	LDA #$6A
//	LDX #$92
//UNKNOWN_C3A4:
//	STA $74
//	STX $75
//	LDA $EC
//	BEQ @UNKNOWN0
//	JMP UNKNOWN_C2B3
//@UNKNOWN0:
//	JMP UNKNOWN_C274

//UNKNOWN_C3B2:
//    LDA #$9B
//    LDX #$92
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3B9:
//    LDA #$CF
//    LDX #$92
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3C0:
//    LDA #$00
//    LDX #$93
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3C7:
//    LDA #$17
//    LDX #$93
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3CE:
//    LDA #$5F
//    LDX #$93
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3D5:
//    JSR UNKNOWN_C542
//    LDA #$48
//    LDX #$92
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3DF:
//    LDA #$6A
//    LDX #$93
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3E6:
//    LDA #$8D
//    LDX #$93
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3ED:
//    LDA #$1E
//    LDX #$95
//    JMP UNKNOWN_C3A4

//UNKNOWN_C3F4:
//    PHP
//    JSR UNKNOWN_CFAC
//    JSR UNKNOWN_FDC0
//    LDA #$01
//    STA $E5
//    LDA #$00
//    STA UNKNOWN_07F7
//    PLP
//    RTS

//UNKNOWN_C406:
//	LDA #$FF
//UNKNOWN_C408:
//	STA $60
//	JSR UNKNOWN_FDE7
//	LDA #$00
//@UNKNOWN0:
//	PHA
//	TAX
//	LDA $0600,X
//	BEQ @UNKNOWN2
//	LDA $0618,X
//	STA $74
//	LDA $0619,X
//	STA $75
//	LDY #$01
//	LDA $0601,X
//	AND $60
//	STA ($74),Y
//	LDY #$14
//@UNKNOWN1:
//	LDA $0603,X
//	STA ($74),Y
//	INX
//	INY
//	CPY #$18
//	BCC @UNKNOWN1
//@UNKNOWN2:
//	PLA
//	CLC
//	ADC #$20
//	BPL @UNKNOWN0
//	JSR UNKNOWN_FDED
//UNKNOWN_C43F:
//	JSR UNKNOWN_C542
//	LDA $F6
//	PHA
//	JSR UNKNOWN_C322
//	LDA #$48
//	LDX #$92
//	STA $74
//	STX $75
//	JSR DrawTilepack
//	BNE @UNKNOWN4
//@UNKNOWN3:
//	JSR DrawTilepackClear
//@UNKNOWN4:
//	LDA #$02
//	JSR AddTo_UNK_74
//	LDA $72
//	CMP #$00
//	BNE @UNKNOWN3
//	INC $77
//	JSR DrawTilepack
//	PLA
//	LDX #BANK::PRG8000
//	JMP BANK_SWAP
//UNKNOWN_C46E:
//	LDA $7E
//	LSR
//	ADC #$00
//	TAX
//	LDA $77
//	AND #$1E
//	ASL
//	ASL
//	ASL
//	STA $7A
//	LDA $76
//	ADC #$01
//	LSR
//	ORA $7A
//	STA $7A
//	TAY
//	JSR UNKNOWN_FDE7
//	LDA #$FF
//@UNKNOWN5:
//	STA $6600,Y
//	INY
//	DEX
//	BNE @UNKNOWN5
//	JSR UNKNOWN_FDED
//	LDX $0402
//	LDY $0403
//	TYA
//	CLC
//	AND #$03
//	ADC #$03
//	ADC $7E
//	LSR
//	LSR
//	STA $7C
//	TYA
//	AND #$80
//	STA $79
//	TXA
//	LSR
//	ROR $79
//	LSR
//	ROR $79
//	TYA
//	AND #$1C
//	ORA $79
//	LSR
//	LSR
//	ORA #$C0
//	STA $79
//	ORA #$F8
//	STA $7B
//	TXA
//	ORA #$03
//	STA $78
//	TYA
//	AND #$42
//	LSR
//	LSR
//	ADC #$00
//	EOR #$FF
//	ADC #$01
//	CLC
//	ADC $7A
//	TAY
//	LDX $E6
//	LDA #$07
//	STA $0400,X
//	INX
//	LDA $7C
//	STA $0400,X
//	INX
//UNKNOWN_C4E5:
//	LDA $78
//	STA $0400,X
//	INX
//	LDA $79
//	STA $0400,X
//	INX
//	LDA $6600,Y
//	AND #$03
//	STA $7A
//	INY
//	LDA $6600,Y
//	AND #$0C
//	ORA $7A
//	STA $7A
//	TYA
//	CLC
//	ADC #$0F
//	TAY
//	LDA $6600,Y
//	AND #$30
//	ORA $7A
//	STA $7A
//	INY
//	LDA $6600,Y
//	AND #$C0
//	ORA $7A
//	STA $0400,X
//	INX
//	TYA
//	SEC
//	SBC #$0F
//	TAY
//	DEC $7C
//	BNE UNKNOWN_C528
//	STX $E6
//	RTS
//UNKNOWN_C528:
//	INC $7B
//	BEQ @UNKNOWN0
//	INC $79
//	JMP UNKNOWN_C4E5
//@UNKNOWN0:
//	LDA #$04
//	EOR $78
//	STA $78
//	LDA #$F8
//	STA $7B
//	AND $79
//	STA $79
//	JMP UNKNOWN_C4E5

/**
 * Original_Address: $(DOLLAR) $C542, bank $1E
 */
void SetupPartyUi() @safe {
//	JSR UNKNOWN_FDE7
//	LDX #$10
//	LDY #$00
//	STY $6707
//@UNKNOWN1:
//	JSR UNKNOWN_C62E
//	BCS @UNKNOWN7
//	INC $6707
//	JSR UNKNOWN_C665
//	TYA
//	PHA
//	LDY #$00
//@UNKNOWN2:
//	JSR UNKNOWN_C637
//	CPY #$14
//	BNE @UNKNOWN2
//	TYA
//	PHA
//	LDY #$01
//	LDA ($60),Y
//	LDY #$0E
//@UNKNOWN3:
//	ASL
//	BCC @UNKNOWN5
//	PLA
//	TYA
//	PHA
//	LDY #$00
//@UNKNOWN4:
//	LDA UNKNOWN_C398,Y
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	CPY #$05
//	BNE @UNKNOWN4
//	PLA
//	TAY
//	LDA UNKNOWN_C61E,Y
//	STA UNKNOWN_6700,X
//	INX
//	LDA UNKNOWN_C61E + 1,Y
//	STA UNKNOWN_6700,X
//	INX
//	LDY #$1B
//	BNE @UNKNOWN6
//@UNKNOWN5:
//	DEY
//	DEY
//	BPL @UNKNOWN3
//	PLA
//	TAY
//	JSR UNKNOWN_C637
//@UNKNOWN6:
//	LDA UNKNOWN_C37A,Y
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	CPY #$1E
//	BNE @UNKNOWN6
//	PLA
//	TAY
//	LDA $6707
//	CMP #$03
//	BCS @UNKNOWN8
//@UNKNOWN7:
//	INY
//	CPY #$04
//	BCC @UNKNOWN1
//@UNKNOWN8:
//	LDA #$00
//	STA $6704
//	STA $6705
//	STA $6706
//	SEC
//	LDA #$03
//	SBC $6707
//	TAX
//	LDY #$00
//@UNKNOWN9:
//	JSR UNKNOWN_C62E
//	BCS @UNKNOWN10
//	STA $6704,X
//	INX
//	CPX #$03
//	BCS @UNKNOWN11
//@UNKNOWN10:
//	INY
//	CPY #$04
//	BCC @UNKNOWN9
//@UNKNOWN11:
//	LDA $6707
//	ASL
//	TAX
//	LDA #$04
//	STA UNKNOWN_6700
//	STA $670A
//	CPX #$04
//	BCS @UNKNOWN12
//	LDA #$00
//@UNKNOWN12:
//	STA $670D
//	LDA UNKNOWN_C616,X
//	STA UNKNOWN_6700 + 1
//	LDA UNKNOWN_C616 + 1,X
//	STA $6702
//	LDA $6713
//	STA $670B
//	LDA $6714
//	STA $670C
//	LDA #$9D
//	STA $670E
//	LDA #$C3
//	STA $670F
//	JMP UNKNOWN_FDED
	//assert(0, "NYI");
}

//UNKNOWN_C616:
//	.WORD UNKNOWN_C33D
//	.WORD UNKNOWN_C329
//	.WORD UNKNOWN_C33E
//	.WORD UNKNOWN_C359

//UNKNOWN_C61E:
//	.WORD $8629
//	.WORD $8622
//	.WORD $861B
//	.WORD $8614
//	.WORD $860D
//	.WORD $8606
//	.WORD $85FF
//	.WORD $85F8

//UNKNOWN_C62E:
//	SEC
//	LDA $7408,Y
//	BEQ @UNKNOWN0
//	CMP #$06
//@UNKNOWN0:
//	RTS

//UNKNOWN_C637:
//	LDA UNKNOWN_C37A,Y
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	LDA UNKNOWN_C37A,Y
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	LDA UNKNOWN_C37A,Y
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	CLC
//	LDA UNKNOWN_C37A,Y
//	ADC $60
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	LDA UNKNOWN_C37A,Y
//	ADC $61
//	STA UNKNOWN_6700,X
//	INX
//	INY
//	RTS

//UNKNOWN_C665:
//	STA $61
//	LDA #$00
//	LSR $61
//	ROR
//	LSR $61
//	ROR
//	ADC #$00
//	STA $60
//	LDA $61
//	ADC #$74
//	STA $61
//	RTS

//UNKNOWN_C67A:
//	JSR DrawTilepack
//	BNE @UNKNOWN1
//@UNKNOWN0:
//	JSR DrawTilepackClear
//@UNKNOWN1:
//	CMP #$00
//	BNE @UNKNOWN0
//	INC $77
//	JMP DrawTilepack

//UNKNOWN_C68B:
//	PHA
//	JSR PpuSync
//	JSR CalculateNTAddr
//	LDA #$05
//	STA $0400
//	LDA #$01
//	STA $0401
//	LDA $78
//	STA $0402
//	LDA $79
//	STA $0403
//	PLA
//	STA $0404
//	LDA #$00
//	STA $0405
//	STA $E6
//	LDA #$80
//	STA $E5
//	RTS

void AddSpacesOnScreen() @safe {
	if (UNK_70 - char_count < 0){
		nmi_data_offset = tiledarea_y;
		return;
	}

	ubyte temp_y = cast(ubyte) (UNK_70 - char_count);
	while(temp_y != 0xff){
		AddTile(0xA0, &tiledarea_x);
		temp_y--;
	}
	temp_y = nmi_queue[cast(ubyte) (nmi_data_offset+1)];
	if (temp_y != 0){
		nmi_data_offset = tiledarea_x;
	}
}


ubyte DrawTilepack() @safe {
	PpuSync();
	nmi_data_offset = 0;
	return TilesTilNMI();
}

ubyte DrawTilepackClear() @safe {
	PpuSync();
	nmi_data_offset = 0;
	//ClearAreaOnScreen();
	AddSpacesOnScreen();
	return TilesTilNMI();
}

ubyte TilesTilNMI() @safe {
	TiledArea();
	AddSpacesOnScreen();

	//BUGGERA
	nmi_queue[tiledarea_y] = 0;
	//nmi_queue[nmi_data_offset] = 0;
	nmi_data_offset = 0;
	new_animation_timer = 0x80;
	return TilesTilNMI_CheckLastRow();
}

ubyte TilesTilNMI_CheckLastRow() @safe {
	GetTextRowPtr();
	if (UNK_72 == 1){
		ntbl_y++;
		ntbl_y++;
	}
	return UNK_72;
}

//UNKNOWN_C707:
//	JSR PpuSync
//	LDA #$33
//	STA $E6
//	PHA
//	JSR TiledArea
//	JSR AddSpacesOnScreen
//	STY $7B
//	PLA
//	TAX
//	LDA #$05
//	STA $0400
//	LDA #$01
//	STA $0401
//@UNKNOWN0:
//	LDA #$00
//	STA $0400,Y
//	CPX $7B
//	BCS TilesTilNMI_CheckLastRow
//	LDA #$08
//	STA $0400,Y
//	LDA $0401,X
//	STA $7E
//	STA $0401,Y
//	LDA #$A0
//	STA $0404,Y
//	CLC
//	LDA $0403,X
//	STA $0403
//	ADC #$20
//	STA $0403,Y
//	LDA $0402,X
//	STA $0402
//	ADC #$00
//	STA $0402,Y
//	TXA
//	CLC
//	ADC #$04
//	TAX
//	TYA
//	CLC
//	ADC #$05
//	TAY
//@UNKNOWN1:
//	LDA $0400,X
//	STA $0404
//	CMP #$A0
//	BEQ @UNKNOWN2
//	LDA UNKNOWN_07EF
//	BMI @UNKNOWN2
//	EOR #$01
//	STA UNKNOWN_07EF
//	LSR
//	BCC @UNKNOWN2
//	LDA #$0E
//	STA UNKNOWN_07EF+2
//@UNKNOWN2:
//	LDA #$00
//	STA $0405
//	STA $E6
//	LDA #$80
//	STA $E5
//	JSR PpuSync
//	BIT UNKNOWN_07EF
//	BVC @UNKNOWN4
//	TXA
//	PHA
//	LDA $0404
//	LDX #$28
//	CMP #$AE
//	BEQ @UNKNOWN3
//	CMP #$AC
//	BEQ @UNKNOWN3
//	LDX #$03
//@UNKNOWN3:
//	JSR WaitXFrames_Min1
//	PLA
//	TAX
//@UNKNOWN4:
//	INC $0403
//	INX
//	DEC $7E
//	BNE @UNKNOWN1
//	JMP @UNKNOWN0

//UNKNOWN_C7AF:
//	CMP #$01
//	BNE @UNKNOWN6
//	PHA
//	LDX #$A4
//@UNKNOWN5:
//	LDA $0432,X
//	STA $045B,X
//	DEX
//	BNE @UNKNOWN5
//	PLA
//@UNKNOWN6:
//	RTS

//UNKNOWN_C7C1:
//	LDA #$33
//@UNKNOWN0:
//	CLC
//	ADC #$29
//	DEX
//	BNE @UNKNOWN0
//	STX $7F
//	TAX
//	PHA
//	JSR UNKNOWN_C7D4
//	STA $7F
//	PLA
//	TAX
//UNKNOWN_C7D4:
//	JSR PpuSync
//	STX $E6
//@UNKNOWN2:
//	LDA $0400,X
//	BEQ @UNKNOWN5
//	EOR #$05
//	BNE @UNKNOWN4
//	ORA $7F
//	BNE @UNKNOWN3
//	JSR UNKNOWN_C80E
//@UNKNOWN3:
//	TXA
//	CLC
//	ADC #$04
//	ADC $0401,X
//	TAX
//	BCC @UNKNOWN2
//@UNKNOWN4:
//	JSR UNKNOWN_C80E
//	TXA
//	CLC
//	ADC #$05
//	TAX
//	BCC @UNKNOWN2
//@UNKNOWN5:
//	STA $7F
//	SEC
//	LDA $E6
//	SBC #$29
//	TAX
//	LDA #$80
//	STA $E5
//	CPX #$5C
//	BCS UNKNOWN_C7D4
//	RTS

//UNKNOWN_C80E:
//	SEC
//	LDA $0403,X
//	SBC #$20
//	STA $0403,X
//	LDA $0402,X
//	STA $7B
//	SBC #$00
//	STA $0402,X
//	EOR $7B
//	AND #$04
//	BEQ @UNKNOWN0
//	SEC
//	LDA $0403,X
//	SBC #$40
//	STA $0403,X
//	LDA $0402,X
//	SBC #$04
//	AND #$0F
//	ORA #$20
//	STA $0402,X
//@UNKNOWN0:
//	RTS

void TiledArea() @safe {
	CalculateNTAddr();
	byte_count = UNK_71;
	tiledarea_x = nmi_data_offset;
	tiledarea_y = 0;
	char_count = 0;
	tiledarea_stack ~= 0;

	WriteRowHeader(&tiledarea_x);
	printing_tilepack = true;

	while(printing_tilepack){
		byte_count--;
		if (byte_count > 0x7f) {
			working_tile = tilepack_ptr[tiledarea_y];
			if (B30_0a5c()){
				StringCommandHandler();
				continue;
			}
		} else {
			working_tile = 0xa0;
		}
		AddTile(working_tile, &tiledarea_x);
	}
}

void ClearAreaOnScreen() @safe {
}
//	DEC $77
//	JSR CalculateNTAddr
//	LDA $71
//	STA $7F
//	LDX $E6
//	LDY #$00
//	STY $7E
//	TYA
//	PHA
//	JSR WriteRowHeader
//@UNKNOWN__:
//	DEC $7F
//	BPL @UNKNOWN0
//	LDA ($74),Y
//	JSR UNKNOWN_CA7C
//	BCS @UNKNOWN1
//	ORA #$80
//	LDY #$81
//	STY $7C
//	LDY #$C8
//	STY $7D
//	JMP StringCommandHandler
//@UNKNOWN0:
//	LDA #$A0
//@UNKNOWN1:
//	JSR AddTile
//	JMP @UNKNOWN__



void TILES_restoreptr() @safe {
	ubyte dude = tiledarea_stack.front;
	tiledarea_stack.popFront();
	if (dude == 0){
		if (nmi_queue[cast(ubyte) (nmi_data_offset+1)] != 0){
			tiledarea_y = tiledarea_x;
		}
		if (UNK_72 > 0x7F){
			ntbl_y++;
		} else {
			AddTo_UNK_74(UNK_7A);
		}
		printing_tilepack = false; //exit
	} else {
		writeln("IMPLEMENT THIS");
		// ;a -> y, y++ ++
		// tay
		// iny
		// iny
		// ;pull a, a -> $75
		// pla
		// .ifdef VER_JP
		// 	J30_0a57:
		// .endif
		// sta tilepack_ptr+1
		// ;pull a, a -> $74
		// pla
		// sta tilepack_ptr
		// jmp (UNK_7C)
	}
}

void StringCommandHandler() @safe {
	UNK_72 = working_tile;
	switch (working_tile) {
		case 0:
		case 1:
		case 2:
		case 3:
			TILES_restoreptr();
			return;
		//set_pos
		case 4:
			bool overflow = UNK_7A >= 0xFE;
			ntbl_x = tilepack_ptr[UNK_7A];
			UNK_7A++;
			ntbl_y = tilepack_ptr[UNK_7A];
			UNK_7A++;

			if (overflow){
				ntbl_y--;
			}


			if (nmi_queue[nmi_data_offset+1] == 0){
				tiledarea_x = nmi_data_offset;
			}
			CalculateNTAddr();
			WriteRowHeader(&tiledarea_x);

			tiledarea_y = UNK_7A;
			return;
		case 5:
			tiledarea_y++;
			tiledarea_y++;
			return;
		//repeatTile
		case 6:
			UNK_72 = tilepack_ptr[UNK_7A];
			UNK_7A++;
			ubyte count = tilepack_ptr[UNK_7A];
			UNK_7A++;

			while (true){
				count--;
				if (count == 0xff){
					break;
				}
				AddTile(UNK_72, &tiledarea_x);
			}

			tiledarea_y++;
			tiledarea_y++;
			return;
		case 7:
			tiledarea_y++;
			tiledarea_y++;
			tiledarea_y++;
			tiledarea_y++;
			return;
		//goto
		case 8:
			tiledarea_y++;
			tiledarea_y++;
			return;
		case 9:
			return;
		default:
			return;
	}
}

//	STA $72
//	ASL
//	TAY
//	LDA UNKNOWN_C8AE+1,Y
//	PHA
//	LDA UNKNOWN_C8AE,Y
//	PHA
//	RTS

//UNKNOWN_C8AE:
//	.WORD UNKNOWN_C8E2 - 1
//	.WORD UNKNOWN_C8E2 - 1
//	.WORD UNKNOWN_C8E2 - 1
//	.WORD UNKNOWN_C8E2 - 1
//	.WORD UNKNOWN_C909 - 1
//	.WORD UNKNOWN_C8D4 - 1
//	.WORD UNKNOWN_C92F - 1
//	.WORD UNKNOWN_C950 - 1
//	.WORD UNKNOWN_C8C2 - 1
//	.WORD UNKNOWN_C9D2 - 1

//UNKNOWN_C8C2:
//	LDY $7A
//UNKNOWN_C8C4:
//	LDA ($74),Y
//	PHA
//	INY
//	LDA ($74),Y
//	STA $75
//	PLA
//	STA $74
//	LDY #$00
//	JMP ($007C)

//UNKNOWN_C8D4:
//	LDY $7A
//	BEQ UNKNOWN_C8E2
//	LDA $74
//	PHA
//	LDA $75
//	PHA
//	TYA
//	PHA
//	BNE UNKNOWN_C8C4

//UNKNOWN_C8E2:
//	PLA
//	BEQ @UNKNOWN2
//	TAY
//	INY
//	INY
//	PLA
//	STA $75
//	PLA
//	STA $74
//	JMP ($007C)
//@UNKNOWN2:
//	LDY $E6
//	LDA $0401,Y
//	BEQ @UNKNOWN3
//	TXA
//	TAY
//@UNKNOWN3:
//	LDA $72
//	BPL @UNKNOWN4
//	INC $77
//	RTS
//@UNKNOWN4:
//	LDA $7A
//	JSR AddTo_UNK_74
//	LDA $72
//	RTS

//UNKNOWN_C909:
//	LDY $7A
//	LDA ($74),Y
//	STA $76
//	INY
//	LDA ($74),Y
//	STA $77
//	INY
//	STY $7A
//	BCC @UNKNOWN0
//	DEC $77
//@UNKNOWN0:
//	LDY $E6
//	LDA $0401,Y
//	BNE @UNKNOWN1
//	LDX $E6
//@UNKNOWN1:
//	JSR CalculateNTAddr
//	JSR WriteRowHeader
//	LDY $7A
//	JMP ($007C)

//UNKNOWN_C92F:
//	LDY $7A
//	LDA ($74),Y
//	BCC @UNKNOWN0
//	LDA #$A0
//@UNKNOWN0:
//	STA $72
//	INY
//	LDA ($74),Y
//	INY
//	STY $7A
//	TAY
//@UNKNOWN1:
//	DEY
//	BMI @UNKNOWN2
//	LDA $72
//	JSR AddTile
//	JMP @UNKNOWN1
//@UNKNOWN2:
//	LDY $7A
//	JMP ($007C)

//UNKNOWN_C950:
//	LDY $7A
//	LDA ($74),Y
//	STA $64
//	INY
//	LDA ($74),Y
//	STA $65
//	INY
//	LDA ($74),Y
//	STA $66
//	INY
//	LDA ($74),Y
//	STA $67
//	INY
//	TYA
//	PHA
//	LDY $66
//	BEQ @UNKNOWN7
//	LDA #$00
//	STA $60
//	STA $61
//	STA $62
//	DEY
//@UNKNOWN4:
//	LDA ($64),Y
//	STA $0060,Y
//	DEY
//	BPL @UNKNOWN4
//	TXA
//	PHA
//	JSR UNKNOWN_F161
//	PLA
//	TAX
//	LDA $67
//	BNE @UNKNOWN5
//	SEC
//	LDA #$08
//	SBC $63
//	STA $67
//	LDA $63
//	BPL @UNKNOWN6
//@UNKNOWN5:
//	SEC
//	LDA #$08
//	SBC $67
//@UNKNOWN6:
//	CLC
//	ADC #$68
//	STA $64
//	LDA #$00
//	ADC #$00
//	STA $65
//@UNKNOWN7:
//	LDY #$00
//@UNKNOWN8:
//	LDA $72
//	BMI @UNKNOWN9
//	LDA ($64),Y
//	JSR B30_0a5c
//	BCS @UNKNOWN12
//	BCC @UNKNOWN11
//@UNKNOWN9:
//	LDA ($64),Y
//	JSR UNKNOWN_CA7C
//	BCS @UNKNOWN12
//	BCC @UNKNOWN11
//@UNKNOWN10:
//	LDA #$A0
//	JSR AddTile
//@UNKNOWN11:
//	DEC $67
//	BPL @UNKNOWN10
//	BMI @UNKNOWN13
//@UNKNOWN12:
//	JSR AddTile
//	DEC $67
//	BNE @UNKNOWN8
//@UNKNOWN13:
//	PLA
//	TAY
//	JMP ($007C)

//UNKNOWN_C9D2:
//	LDY $7A
//	JMP ($007C)

void CalculateNTAddr() @safe {
	ubyte c = cast(ubyte) ((ram_PPUCTRL & 2) << 6);
	UNK_79 = cast(ubyte) (c | ((scroll_y >> 1) + 8));

	c = cast(ubyte) (((ntbl_y + 1) << 2) + UNK_79);
	if (c < 0x80){
		c -= 8;
	}
	UNK_79 = (c << 1) & 0xF8;

	c = (c & 0x80) >> 7;

	ushort doubler = cast(ushort) (((c | 4) << 9) | UNK_79);
	doubler <<= 2;
	UNK_78 = doubler >> 8;
	UNK_79 = doubler & 0xff;

	c = (ram_PPUCTRL & 1) << 7;
	c |= scroll_x >> 1;
	c >>= 2;
	c += ntbl_x;
	UNK_78 += (c & 0x20) >> 3;
	UNK_79 += c & 0x1f;
}

void AddTile(ubyte tile, ubyte* queue_pos) @safe {
	nmi_queue[*queue_pos] = tile;
	(*queue_pos)++;
	nmi_queue[nmi_data_offset+1]++;
	char_count++;
	UNK_7B++;
	if (UNK_7B != 0){
		return;
	}
	//UNK_79 &= 0xE0;
	//UNK_78 ^= 0x04;
	//WriteRowHeader(queue_pos);
}

void WriteRowHeader(ubyte* x) @safe {
	nmi_data_offset = *x;

	nmi_queue[*x] = NMI_COMMANDS.PPU_WRITE;
	(*x)++;
	nmi_queue[*x] = 0;
	(*x)++;
	nmi_queue[*x] = UNK_78;
	(*x)++;
	nmi_queue[*x] = UNK_79;
	(*x)++;
	UNK_7B = UNK_79 |= 0xE0;
}

bool B30_0a5c() @safe {
	tiledarea_y++;
	UNK_7A = tiledarea_y;
	//normal tile
	if (working_tile >= 0x40){
		return false;
	}

	//load index in control codes
	working_tile = control_codes[working_tile];

	//kana
	if (working_tile >= 0x80){
		return false;
	}

	//output
	if (working_tile >= 0x80){
		working_tile |= 0x80;
		return false;
	}

	//is ui piece
	if (working_tile >= 0xA){
		working_tile |= 0xD0;
		return false;
	}
	return true;
}

//UNKNOWN_CA7C:
//	INY
//	STY $7A
//	CMP #$40
//	BCS @UNKNOWN3
//	TAY
//	LDA UNKNOWN_C22C,Y
//	LDY $7A
//	CMP #$80
//	BCS @UNKNOWN2
//	CMP #$20
//	BCS @UNKNOWN1
//	CMP #$0A
//	BCS @UNKNOWN0
//	RTS
//@UNKNOWN0:
//	ORA #$D0
//	RTS
//@UNKNOWN1:
//	LDA #$FF
//	RTS
//@UNKNOWN2:
//	LDA #$FE
//	RTS
//@UNKNOWN3:
//	LDA #$A0
//	RTS

//UNKNOWN_CAA2:
//	LDA $73
//	BPL @UNKNOWN0
//	STA $75
//	RTS
//@UNKNOWN0:
//	CMP #$7F
//	BCS @UNKNOWN1
//	TAX
//	LDA $74
//	ASL $74
//	ROL $73
//	ADC $74
//	STA $74
//	TXA
//	ADC $73
//	ADC #$80
//	STA $75
//	LDA #$7F
//	STA $73
//	LDA $F6
//	PHA
//	LDA #$18
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDY #$00
//	LDA ($74),Y
//	STA $09
//	INY
//	LDA ($74),Y
//	STA $0A
//	INY
//	LDA ($74),Y
//	STA $0B
//	PLA
//	JSR BANK_SWAP
//@UNKNOWN1:
//	JSR PpuSync
//	LDA #$0A
//	STA $0400
//	LDA $0B
//	LSR
//	LDA $0A
//	ROR
//	SEC
//	ROR
//	STA $0401
//	LDA $0A
//	AND #$03
//	ORA #$08
//	STA $0402
//	LDA $09
//	STA $0403
//	LDA #$00
//	STA $0404
//	LDA #$00
//	STA $E6
//	LDA #$80
//	STA $E5
//	LDA #$10
//	STA $74
//	LDA #$01
//	STA $75
//	JMP PpuSync

//pointer manip. check if works?
void GetTextRowPtr() @safe {
}

//check if works
//tilepack_ptr += a
void AddTo_UNK_74(ubyte offset) @safe {
	if (offset >= tilepack_ptr.length){
		tilepack_ptr = [];
	} else {
    	tilepack_ptr = tilepack_ptr[offset..$];
	}
}

/**
 * Original_Address: $(DOLLAR) $CB44, bank $1E
 */
void PostInit() @safe {
	WriteProtectPRGRam();

	sram_mode = 0xC0;

	BANKSET_H14();
	// intro, title screen, file select
	intro();
	sram_mode = 0;
	do {
		BANKSET_H13();
		OverworldTransitionIntepreter();
		B30_0b5d:
		SetupPartyUi();
		GetScreenMapData();
		UNK_24 = 0;
		UNK_d = (save_file_current.current_daDef[1] & 0xF) ^ 0x84;

		B30_0b70:
		ClearSprites();
		STORE_COORDINATES();

		while(1){
			nes.wait();
		}

		B30_0b76:
		B30_1e99();
		B31_0ef0();
		if (UNK_25 == 0) {
			if (!(pad1_hold & 0x70)) {
				UNK_1F = 0;
			} else if (!(unknownCC9D() & 0x8)) {
				UNK_1F = 0;
			} else {
				UNK_1F = 1;
			}
		}
		PpuSync();
	} while (0);
	unknownDD01();
	unknownDFDA();
	unknownCC2B();
	ubyte y;
	if (is_scripted != 0) {
		BANKSET_H13();
		if (!unknown13A1C6()) {
			goto PostInit8;
		}
	}
// 3
	BANKSET_H13();
	y = pad1_forced;
	pad1_forced = 0;
	if (autowalk_direction || is_tank || is_scripted || fade_flag) {
		goto PostInit8;
	}
	if (((y & 0xF0) >= 0x80)) {
		unknown13A178();
		goto PostInit7;
	}
	if (y & 0xF0) {
		const a = unknownCC9D();
		if (!(a & 0xA0)) {
			goto PostInit7;
		} else if ((a & 0xA0) >= 0x80) {
			unknown13A000();
			goto PostInit7;
		}
		unknown13A82F();
		goto PostInit7;
	}
	unknown13A123();
	PostInit7:
	BANKSET_H14();
	unknown149516();
	PostInit8:
	if (enemy_group == 0) {
		goto B30_0b76;
	} else if (enemy_group == 0xA2) {
		BANKSET_H14();
		unknown149779();
		if (unknownF202()) {
			goto B30_0b5d;
		}
		BANKSET_H14();
		return unknown1497A3();
	}
	PpuSync();
	if (unknownF202()) {
		goto B30_0b5d;
	}
	unknownFD28(current_music);
	if (is_scripted) {
		BANKSET_H13();
		unknown13AB53();
		if (fade_flag) {
			goto B30_0b5d;
		}
		return unknownCB70();
	}
//	JSR UNKNOWN_FDED
//	LDA #$C0
//	STA UNKNOWN_07EF
//	JSR UNKNOWN_CEE1
//	JSR UNKNOWN_149400
//	LDA #$00
//	STA UNKNOWN_07EF
//UNKNOWN_CB44_0:
//	JSR BANKSET_H13
//	JSR UNKNOWN_13BCEC
//UNKNOWN_CB5D:
//	JSR UNKNOWN_C542
//	JSR UNKNOWN_CEFC
//	LDA #$00
//	STA $24
//	LDA $7406
//	AND #$0F
//	EOR #$84
//	STA $0D
//UNKNOWN_CB70:
//	JSR ClearSprites
//	JSR UNKNOWN_CFAC
//UNKNOWN_CB76:
//	JSR UNKNOWN_DE99
//	JSR UNKNOWN_EEF0
//	LDA $25
//	BNE UNKNOWN_CB44_2
//	LDA $DE
//	AND #$70
//	BEQ UNKNOWN_CB44_1
//	JSR UNKNOWN_CC9D
//	AND #$08
//	BEQ UNKNOWN_CB44_1
//	LDA #$01
//UNKNOWN_CB44_1:
//	STA $1F
//UNKNOWN_CB44_2:
//	JSR PpuSync
//	LDA $20
//	BNE UNKNOWN_CB44_0
//	JSR UNKNOWN_DD01
//	JSR UNKNOWN_DFDA
//	JSR UNKNOWN_CC2B
//	LDA $21
//	BEQ UNKNOWN_CB44_3
//	JSR BANKSET_H13
//	JSR UNKNOWN_13A1C6
//	BCC UNKNOWN_CB44_8
//UNKNOWN_CB44_3:
//	JSR BANKSET_H13
//	LDA #$00
//	LDY $DA
//	STA $DA
//	LDA $22
//	ORA $23
//	ORA $21
//	ORA $20
//	BNE UNKNOWN_CB44_8
//	TYA
//	AND #$F0
//	BMI UNKNOWN_CB44_6
//	BNE UNKNOWN_CB44_4
//	JSR UNKNOWN_13A123
//	JMP UNKNOWN_CB44_7

//UNKNOWN_CB44_4:
//	JSR UNKNOWN_CC9D
//	AND #$A0
//	BEQ UNKNOWN_CB44_7
//	BMI UNKNOWN_CB44_5
//	JSR UNKNOWN_13A82F
//	JMP UNKNOWN_CB44_7

//UNKNOWN_CB44_5:
//	JSR UNKNOWN_13A000
//	JMP UNKNOWN_CB44_7

//UNKNOWN_CB44_6:
//	JSR UNKNOWN_13A178
//UNKNOWN_CB44_7:
//	JSR UNKNOWN_CEE1
//	JSR $9516
//UNKNOWN_CB44_8:
//	LDA $48
//	BEQ UNKNOWN_CB44_11
//	CMP #$A2
//	BEQ UNKNOWN_CB44_12
//	JSR PpuSync
//	LDA $078C
//	PHA
//	JSR UNKNOWN_F202
//	PLA
//	BCS UNKNOWN_CB44_10
//	JSR UNKNOWN_FD28
//	LDA $21
//	BEQ UNKNOWN_CB44_9
//	JSR BANKSET_H13
//	JSR UNKNOWN_13AB53
//	LDA $20
//	BNE UNKNOWN_CB44_10
//UNKNOWN_CB44_9:
//	JMP UNKNOWN_CB70

//UNKNOWN_CB44_10:
//	JMP UNKNOWN_CB5D

//UNKNOWN_CB44_11:
//	JMP UNKNOWN_CB76

//UNKNOWN_CB44_12:
//	JSR UNKNOWN_CEE1
//	JSR $9779
//	JSR UNKNOWN_F202
//	BCS UNKNOWN_CB44_10
//	JSR UNKNOWN_CEE1
//	JMP $97A3
}

/**
 * Original_Address: $(DOLLAR) $CB70, bank $1E
 */
void unknownCB70() @safe {
	//assert(0, "NYI");
}

/**
 * Original_Address: $(DOLLAR) $CC2B, bank $1E
 */
void unknownCC2B() @safe {
	//	LDA $1F
	//	CMP #$07
	//	BCS @UNKNOWN2
	//	LDA #$10
	//	STA $E5
	//	JSR UNKNOWN_D05E
	//	JSR UNKNOWN_D0B1
	//@UNKNOWN0:
	//	LDA $E5
	//	BNE @UNKNOWN0
	//@UNKNOWN1:
	//	LDA $E0
	//	CMP #$09
	//	BCS @UNKNOWN1
	//	SEC
	//	ROR $E2
	//	JSR UNKNOWN_E065
	//	ASL $E2
	//	JSR UNKNOWN_D232
	//	LDA #$00
	//	STA $0400,X
	//	STA $E6
	//	LDA #$80
	//	STA $E5
	//	BNE @UNKNOWN4
	//@UNKNOWN2:
	//	JSR UNKNOWN_D05E
	//	JSR UNKNOWN_D0B1
	//	JSR UNKNOWN_D232
	//	LDA #$00
	//	STA $0400,X
	//	STA $E6
	//	LDA #$10
	//	STA $E5
	//	LDA $1F
	//	CMP #$0F
	//	BCS @UNKNOWN4
	//@UNKNOWN3:
	//	LDA $E5
	//	BNE @UNKNOWN3
	//	SEC
	//	ROR $E2
	//	JSR UNKNOWN_E065
	//	ASL $E2
	//@UNKNOWN4:
	//	LDA $A0
	//	LSR
	//	BCC @UNKNOWN5
	//	JSR UNKNOWN_D21C
	//	LDA #$00
	//	STA $0400,X
	//	STA $E6
	//	LDA #$80
	//	STA $E5
	//@UNKNOWN5:
	//	BIT $A0
	//	BMI @UNKNOWN6
	//	INC $D5
	//@UNKNOWN6:
	//	RTS
	//assert(0, "NYI");
}

/**
 * Original_Address: $(DOLLAR) $CC9D, bank $1E
 */
ubyte unknownCC9D() @safe {
	//UNKNOWN_CC9D:
	//	LSR
	//	LSR
	//	LSR
	//	LSR
	//	TAX
	//	LDY UNKNOWN_CCA9,X
	//	LDA $743C,Y
	//	RTS
	//assert(0, "NYI");
	return 0;
}

//UNKNOWN_CCA9:
//	.BYTE $00, $01, $02, $01, $00, $00, $00, $00

//UNKNOWN_CCB1:
//	LDA #$FF
//	JSR UNKNOWN_FD28
//	JSR UNKNOWN_DA16
//	LDA #$02
//	STA UNKNOWN_07EF+1
//	LDA #$01
//	ORA $FE
//	STA $FE
//	LDX #$08
//@UNKNOWN0:
//	JSR UNKNOWN_EEE4
//	DEX
//	BNE @UNKNOWN0
//	LDA #$1E
//	AND $FE
//	STA $FE
//	JSR UNKNOWN_FD4F
//	JMP UNKNOWN_CD79
//UNKNOWN_CCD8:

//	LDA $078C
//	PHA
//	LDA #$FF
//	STA $0F
//	JSR UNKNOWN_FD28
//	JSR UNKNOWN_C3F4
//	LDA #$01
//	STA UNKNOWN_07EF+5
//	JSR UNKNOWN_CD9D
//	LDX #$05
//@UNKNOWN1:
//	JSR UNKNOWN_CD8B
//	LDA $A0
//	BMI UNKNOWN_CCB1
//	LDA $DE
//	AND #$0F
//	TAX
//	LDA $EBDD,X
//	BMI @UNKNOWN2
//	ORA #$40
//	TAX
//	EOR $22
//	CMP #$04
//	BEQ @UNKNOWN2
//	STX $22
//@UNKNOWN2:
//	LDX $25
//	INX
//	CPX #$2D
//	BCC @UNKNOWN1
//	JSR PpuSync
//	LDA #$20
//@UNKNOWN3:
//	TAX
//	ASL $0304,X
//	ASL $0305,X
//	SEC
//	SBC #$08
//	BNE @UNKNOWN3
//	LDA #$0A
//@UNKNOWN4:
//	PHA
//	JSR UNKNOWN_CC2B
//	JSR PpuSync
//	PLA
//	SEC
//	SBC #$01
//	BNE @UNKNOWN4
//	LDA #$01
//	STA UNKNOWN_07EF+4
//	LDA #$22
//	JSR UNKNOWN_EDFE
//	JSR BANKSET_H13
//	JSR UNKNOWN_FDE7
//	JSR $BBD4
//	JSR UNKNOWN_D9FA
//	PLA
//	LDA $7404
//	TAX
//	AND #$3F
//	PHA
//	TXA
//	AND #$C0
//	STA $7404
//	JSR UNKNOWN_D8C9
//	LDX #$14
//	JSR WaitXFrames_Min1
//	JSR UNKNOWN_C542
//	JSR UNKNOWN_CEFC
//	JSR ClearSprites
//	JSR UNKNOWN_CFAC
//	JSR UNKNOWN_CD9D
//	LDX #$2C
//@UNKNOWN5:
//	JSR UNKNOWN_CD8B
//	LDX $25
//	DEX
//	DEX
//	BPL @UNKNOWN5
//UNKNOWN_CD79:
//	LDX #$00
//	STX $22
//	STX $DA
//	STX $0F
//	JSR UNKNOWN_CDAF
//	PLA
//	JSR UNKNOWN_FD28
//	JMP UNKNOWN_CB76

//UNKNOWN_CD8B:
//	JSR UNKNOWN_CDAF
//	JSR UNKNOWN_DE99
//	JSR PpuSync
//	JSR UNKNOWN_DD01
//	JSR UNKNOWN_DFDA
//	JMP UNKNOWN_CC2B

//UNKNOWN_CD9D:
//	JSR UNKNOWN_FDE7
//	LDA $7406
//	AND #$0F
//	STA $6799
//	ORA #$40
//	STA $22
//	JMP UNKNOWN_FDED

//UNKNOWN_CDAF:
//	STX $25
//	LDA UNKNOWN_CDB7,X
//	STA $1F
//	RTS

//UNKNOWN_CDB7:
//	.BYTE $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $05, $05, $05, $05, $05, $05, $05, $05, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $0F, $0F, $0F, $0F, $0F

//UNKNOWN_CDE4:
//	PHA
//	LDA $078C
//	TAX
//	PLA
//	JSR UNKNOWN_FD28
//	LDA #$00
//	STA $DA
//@UNKNOWN0:
//	BIT $DA
//	BVS @UNKNOWN1
//	LDA $078C
//	BNE @UNKNOWN0
//@UNKNOWN1:
//	LDA #$00
//	STA $DA
//	TXA
//	JMP UNKNOWN_FD28

//UNKNOWN_CE02:
//	LDY #$5E
//	LDA #$00
//	LDX #$6C
//UNKNOWN_CE08:
//	STA $60
//	STX $61
//	JSR PpuSync
//	TYA
//	LDX #BANK::CHR0800
//	JSR BANK_SWAP
//	LDA #$09
//	LDX #$40
//	STA $0400
//	STX $0401
//	LDA #$00
//	LDX #$18
//	STX $0402
//	STA $0403
//	LDA #$00
//	STA $0444
//	LDX #$20
//@UNKNOWN2:
//	LDA #$00
//	STA $E6
//	LDA #$80
//	STA $E5
//	JSR PpuSync
//	JSR UNKNOWN_FDE7
//	LDY #$00
//@UNKNOWN3:
//	LDA $0404,Y
//	STA ($60),Y
//	INY
//	CPY #$40
//	BCC @UNKNOWN3
//	JSR UNKNOWN_FDED
//	CLC
//	TYA
//	ADC $60
//	STA $60
//	LDA #$00
//	ADC $61
//	STA $61
//	CLC
//	TYA
//	ADC $0403
//	STA $0403
//	LDA #$00
//	ADC $0402
//	STA $0402
//	DEX
//	BNE @UNKNOWN2
//	RTS

//UNKNOWN_CE6D:
//	LDA #$00
//	LDX #$00
//	STA $60
//	STX $61
//	LDA #$00
//	LDX #$20
//	STA $64
//	STX $65
//	LDA #$10
//	STA $68
//@UNKNOWN0:
//	LDA $60
//	LDX $61
//	LDY #$09
//	JSR UNKNOWN_CEB2
//	LDA $64
//	LDX $65
//	LDY #$05
//	JSR UNKNOWN_CEB2
//	CLC
//	LDA #$40
//	ADC $60
//	STA $60
//	LDA #$00
//	ADC $61
//	STA $61
//	CLC
//	LDA #$40
//	ADC $64
//	STA $64
//	LDA #$00
//	ADC $65
//	STA $65
//	DEC $68
//	BNE @UNKNOWN0
//	RTS

//UNKNOWN_CEB2:
//	PHA
//	JSR PpuSync
//	PLA
//	STA $0403
//	STX $0402
//	STY $0400
//	LDA #$40
//	STA $0401
//	LDA #$00
//	STA $0444
//	LDA #$00
//	STA $E6
//	LDA #$80
//	STA $E5
//	RTS


/**
 * Original_Address: $(DOLLAR) $CED3, bank $1E
 */
void BANKSET_H13() @safe {
	bankSwap(0x13, MMC3Bank.prgA000);
}

/**
 * Original_Address: $(DOLLAR) $CEDA, bank $1E
 */
void unknownCEDA() @safe {
	bankSwap(0x17, MMC3Bank.prgA000);
}

/**
 * Original_Address: $(DOLLAR) $CEE1, bank $1E
 */
void BANKSET_H14() @safe {
	bankSwap(0x14, MMC3Bank.prg8000);
}

void BankswitchCHRFromTable(ubyte[] addr) @safe {
	ubyte x = 5; //stored for the bank index
	ubyte y = 5; //stored for the iterator

	while (y != 0xff){
		if (addr[y] != 0){
			bankSwap(addr[y], x);
		}
		x--;
		y--;
	}
}

/**
 * Original_Address: $(DOLLAR) $CEFC, bank $1E
 */
void GetScreenMapData() @safe {
	//	JSR UNKNOWN_D674
	//	LDA #$14
	//	LDX #BANK::PRG8000
	//	JSR BANK_SWAP
	//	LDA #$00
	//	STA $89
	//	LDA $14
	//	ASL
	//	ASL
	//	ASL
	//	ROL $89
	//	ASL
	//	ROL $89
	//	ADC #$00
	//	STA $88
	//	LDA $89
	//	ADC #$90
	//	STA $89
	//	JSR PpuSync
	//	LDY #$0F
	//@UNKNOWN0:
	//	LDA ($88),Y
	//	BPL @UNKNOWN1
	//	JSR UNKNOWN_E0F2
	//@UNKNOWN1:
	//	STA $0500,Y
	//	DEY
	//	BPL @UNKNOWN0
	//	LDY #$0F
	//@UNKNOWN2:
	//	LDA UNKNOWN_CF9C,Y
	//	STA $0510,Y
	//	DEY
	//	BPL @UNKNOWN2
	//	LDX $050C
	//	LDY $050E
	//	STX $17
	//	STY $16
	//	LDX #$0F
	//	LDY #$30
	//	STX $050C
	//	STY $050E
	//	JSR UNKNOWN_D5C4
	//	LDA $1A
	//	AND #$C0
	//	STA $AC
	//	LDA $1B
	//	STA $AD
	//	LDA #$40
	//	STA $AE
	//	LDA #$00
	//	STA $AF
	//	LDA #$10
	//	STA $9B
	//@UNKNOWN3:
	//	SEC
	//	LDA $18
	//	AND #$C0
	//	SBC #$40
	//	STA $AA
	//	LDA $19
	//	SBC #$00
	//	STA $AB
	//	LDA #$13
	//	STA $A8
	//	JSR UNKNOWN_D11D
	//	DEC $9B
	//	BEQ @UNKNOWN4
	//	CLC
	//	LDA $AC
	//	ADC #$40
	//	STA $AC
	//	LDA $AD
	//	ADC #$00
	//	STA $AD
	//	JMP @UNKNOWN3

	//@UNKNOWN4:
	//	JSR UNKNOWN_D09E
	//	LDY #$00
	//	STY $1D
	//	JMP UNKNOWN_DD72
	//assert(0, "NYI");
}

//UNKNOWN_CF9C:
//	.BYTE $0F, $0F, $00, $30, $0F, $0F, $16, $37, $0F, $0F, $24, $37, $0F, $0F, $12, $37

/**
 * Original_Address: $(DOLLAR) $CFAC, bank $1E
 */
void STORE_COORDINATES() @safe {
	PpuSync();

	scroll_x = UNK_1c[0] | 0x10;
	scroll_y = UNK_1c[1];
	UNK_98[1] = UNK_1c[1];
	//ram_PPUCTRL = (ram_PPUCTRL & 0xFC) | UNK_1c[2];

	UNK_AC = (player_y & 0xc0) + 0x380;

	UNK_9B = 0xf;

//@UNKNOWN0:
//	CLC
//	LDA $99
//	ADC #$F0
//	BCS @UNKNOWN1
//	ADC #$F0
//@UNKNOWN1:
//	STA $99
//	LDA $18
//	AND #$C0
//	STA $AA
//	LDA $19
//	STA $AB
//	LDX $9B
//	LDA UNKNOWN_D04F - 1,X
//	EOR $99
//	AND #$10
//	BNE @UNKNOWN2
//	LDA UNKNOWN_D04F - 1,X
//@UNKNOWN2:
//	STA $93
//	JSR PpuSync
//	JSR UNKNOWN_D2C4
//	LDA #$00
//	STA $0400,X
//	STA $E6
//	LDA #$80
//	STA $E5
//	DEC $9B
//	BEQ @UNKNOWN3
//	LDA $9B
//	ASL
//	TAX
//	JSR UNKNOWN_FD4A
//	LDA #$25
//	STA $053E,X
//	SEC
//	LDA $AC
//	SBC #$40
//	STA $AC
//	LDA $AD
//	SBC #$00
//	STA $AD
//	JMP @UNKNOWN0
//@UNKNOWN3:
//	JSR PpuSync
//	JSR UNKNOWN_D5C4
//	LDA #$04
//	STA $0400
//	LDA #$00
//	STA $0401
//	STA $E6
//	LDA #$80
//	STA $E5
//	LDA #$88
//	STA $A0
//	LDA #$00
//	STA $EC
//	STA $DA
//	RTS
	//assert(0, "NYI");
}

//UNKNOWN_D04F:
//	.BYTE $F0, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $10, $20

//UNKNOWN_D05E:
//	LDA $A0
//	BMI UNKNOWN_D09E_RET
//	ASL
//	ASL
//	ASL
//	TAX
//	CLC
//	LDA UNKNOWN_EBED,X
//	ADC $18
//	STA $18
//	LDA UNKNOWN_EBED + 1,X
//	ADC $19
//	STA $19
//	CLC
//	LDA UNKNOWN_EBED + 2,X
//	ADC $1A
//	STA $1A
//	LDA UNKNOWN_EBED + 3,X
//	ADC $1B
//	STA $1B
//	CLC
//	LDA UNKNOWN_EBED + 2,X
//	BEQ UNKNOWN_D09E
//	BMI @UNKNOWN0
//	LDA $1D
//	ADC #$20
//	BCC @UNKNOWN1
//	BCS @UNKNOWN2
//@UNKNOWN0:
//	LDA $1D
//	ADC #$F0
//	BCS @UNKNOWN2
//@UNKNOWN1:
//	ADC #$F0
//@UNKNOWN2:
//	STA $1D
//UNKNOWN_D09E:
//	LDA $19
//	AND #$07
//	STA $1E
//	LDA $18
//	AND #$C0
//	LSR $1E
//	ROR
//	LSR $1E
//	ROR
//	STA $1C
//UNKNOWN_D09E_RET:
//	RTS

//UNKNOWN_D0B1:
//	JSR UNKNOWN_D5C4
//	LDA $A0
//	BMI @UNKNOWN0
//	JSR UNKNOWN_D0C4
//	LDA $A0
//	LSR
//	BCS @UNKNOWN1
//@UNKNOWN0:
//	RTS
//@UNKNOWN1:
//	ADC #$00
//	ASL
//UNKNOWN_D0C4:
//	AND #$06
//	ASL
//	ASL
//	TAX
//	CLC
//	LDA $18
//	AND #$C0
//	ADC UNKNOWN_D0FD,X
//	STA $AA
//	LDA $19
//	ADC UNKNOWN_D0FD + 1,X
//	STA $AB
//	CLC
//	LDA $1A
//	AND #$C0
//	ADC UNKNOWN_D0FD + 2,X
//	STA $AC
//	LDA $1B
//	ADC UNKNOWN_D0FD + 3,X
//	STA $AD
//	LDA UNKNOWN_D0FD + 4,X
//	STA $AE
//	LDA UNKNOWN_D0FD + 5,X
//	STA $AF
//	LDA UNKNOWN_D0FD + 6,X
//	STA $A8
//	JMP UNKNOWN_D11D

//UNKNOWN_D0FD:
//	.BYTE $C0, $FF, $00, $00, $40, $00, $13, $00
//	.BYTE $40, $04, $00, $00, $00, $40, $10, $00
//	.BYTE $C0, $FF, $C0, $03, $40, $00, $13, $00
//	.BYTE $C0, $FF, $00, $00, $00, $40, $10, $00

//UNKNOWN_D11D:
//	JSR UNKNOWN_D55D
//@UNKNOWN0:
//	JSR UNKNOWN_D59D
//	LDY #$00
//	LDA ($88),Y
//	AND #$3F
//	CMP $14
//	BEQ @UNKNOWN1
//	LDA $16
//	JMP @UNKNOWN2
//@UNKNOWN1:
//	LDA $94
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	CLC
//	LDA $AB
//	STA $88
//	LDA $AD
//	AND #$1F
//	ADC #$80
//	STA $89
//	LDY #$00
//	LDA ($88),Y
//	BPL @UNKNOWN2
//	JSR UNKNOWN_E0F2
//@UNKNOWN2:
//	TAX
//	AND #$40
//	ASL
//	STA $97
//	LSR
//	LSR
//	STA $96
//	BEQ @UNKNOWN3 + 1
//	LDA $13
//@UNKNOWN3:
//	BIT $11A5
//	STA $89
//	TXA
//	ASL
//	ASL
//	ASL
//	ROL $89
//	ASL
//	ROL $89
//	STA $88
//	STA $8A
//	LDA $89
//	ADC #$80
//	ADC $96
//	STA $89
//	ADC #$10
//	STA $8B
//	LDA $10
//	LSR
//	ORA #$01
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDA $12
//	LSR
//	ORA #$01
//	LDX #BANK::PRGA000
//	JSR BANK_SWAP
//@UNKNOWN4:
//	LDA $AA
//	LSR
//	LSR
//	ORA $AC
//	LSR
//	LSR
//	LSR
//	LSR
//	TAX
//	TAY
//	JSR UNKNOWN_FDE7
//	LDA ($88),Y
//	EOR $97
//	LDY $A1
//	STA ($A2),Y
//	TXA
//	TAY
//	LDA ($8A),Y
//	AND #$C0
//	STA $90
//	LSR
//	LSR
//	ORA $90
//	LSR
//	LSR
//	ORA $90
//	LSR
//	LSR
//	ORA $90
//	LDY $A1
//	STA ($A4),Y
//	LDA #$00
//	STA ($A6),Y
//	JSR UNKNOWN_FDED
//	DEC $A8
//	BEQ @UNKNOWN8
//	LDA $AE
//	BEQ @UNKNOWN5
//	INC $A1
//	CLC
//	ADC $AA
//	STA $AA
//	BCC @UNKNOWN6
//	LDA #$00
//	ADC $AB
//	STA $AB
//	AND #$03
//	BNE @UNKNOWN7
//	LDA $A1
//	SEC
//	SBC #$10
//	STA $A1
//	LDA $A3
//	EOR #$01
//	STA $A3
//	CLC
//	ADC #$02
//	STA $A5
//	ADC #$02
//	STA $A7
//	JMP @UNKNOWN0
//@UNKNOWN5:
//	LDX $AF
//	BEQ @UNKNOWN8
//	CLC
//	LDA $A1
//	ADC #$10
//	STA $A1
//	CLC
//	TXA
//	ADC $AC
//	STA $AC
//	BCC @UNKNOWN6
//	LDA #$00
//	ADC $AD
//	STA $AD
//	JMP @UNKNOWN0
//@UNKNOWN6:
//	JMP @UNKNOWN4
//@UNKNOWN7:
//	JMP @UNKNOWN0
//@UNKNOWN8:
//	RTS

//UNKNOWN_D21C:
//	LDA $E5
//	BNE UNKNOWN_D21C
//	LDA $A0
//	BMI UNKNOWN_D21C_0
//	AND #$07
//	ASL
//	ASL
//	ASL
//	TAX
//	LDA UNKNOWN_D284+7,X
//	BPL UNKNOWN_D21C_2
//UNKNOWN_D21C_0:
//	LDX #$00
//	RTS
//UNKNOWN_D232:
//	LDA $E5
//	BNE UNKNOWN_D232
//	LDA $A0
//	BMI UNKNOWN_D21C_0
//	AND #$07
//	ASL
//	ASL
//	ASL
//UNKNOWN_D21C_2:
//	TAX
//	CLC
//	LDA $18
//	AND #$C0
//	ADC UNKNOWN_D284,X
//	STA $AA
//	LDA $19
//	ADC UNKNOWN_D284 + 1,X
//	STA $AB
//	CLC
//	LDA $1A
//	AND #$C0
//	ADC UNKNOWN_D284 + 2,X
//	STA $AC
//	LDA $1B
//	ADC UNKNOWN_D284 + 3,X
//	STA $AD
//	CLC
//	LDA UNKNOWN_D284 + 4,X
//	ADC $1D
//	BCS @UNKNOWN3
//	ADC #$F0
//@UNKNOWN3:
//	STA $99
//	LDA UNKNOWN_D284 + 6,X
//	BMI @UNKNOWN6
//	EOR $99
//	AND #$10
//	BNE @UNKNOWN5
//	LDA UNKNOWN_D284 + 5,X
//@UNKNOWN5:
//	STA $93
//	JMP UNKNOWN_D2C4
//@UNKNOWN6:
//	JMP UNKNOWN_D398

//UNKNOWN_D284:
//	.BYTE $00, $00, $00, $00, $10, $F0, $10, $88
//	.BYTE $00, $00, $00, $00, $10, $F0, $10, $10
//	.BYTE $00, $04, $00, $00, $10, $00, $FF, $88
//	.BYTE $00, $00, $80, $03, $F0, $20, $00, $10
//	.BYTE $00, $00, $80, $03, $F0, $20, $00, $88
//	.BYTE $00, $00, $80, $03, $F0, $20, $00, $30
//	.BYTE $00, $00, $00, $00, $10, $00, $FF, $88
//	.BYTE $00, $00, $00, $00, $10, $F0, $10, $30

//UNKNOWN_D2C4:
//	JSR UNKNOWN_D4B7
//	LDA #$11
//	STA $91
//	LDX #$00
//@UNKNOWN0:
//	LDA #$05
//	STA $0400,X
//	STA $042A,X
//	INX
//	LDA $91
//	ASL
//	STA $0400,X
//	STA $042A,X
//	INX
//	LDA $8D
//	STA $0400,X
//	STA $042A,X
//	INX
//	LDA $8C
//	STA $0400,X
//	ORA #$20
//	STA $042A,X
//	INX
//@UNKNOWN1:
//	JSR UNKNOWN_D537
//	LDY #$00
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0400,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0401,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $042A,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $042B,X
//	INX
//	INX
//	DEC $91
//	BEQ @UNKNOWN2
//	INC $A1
//	LDA $A1
//	BIT UNKNOWN_D47F
//	BNE @UNKNOWN1
//	SEC
//	SBC #$10
//	STA $A1
//	LDA $A3
//	EOR #$01
//	STA $A3
//	LDA $8C
//	AND #$E0
//	STA $8C
//	LDA $8D
//	EOR #$04
//	STA $8D
//	SEC
//	LDA #$11
//	SBC $91
//	ASL
//	STA $0401
//	STA $042B
//	JMP @UNKNOWN0
//@UNKNOWN2:
//	LDA #$09
//	STA $91
//	LDX #$54
//	LDA #$07
//	STA $0400,X
//	INX
//	LDA $91
//	STA $0400,X
//	INX
//@UNKNOWN3:
//	JSR UNKNOWN_D480
//	DEC $91
//	BEQ @UNKNOWN4
//	INC $8E
//	CLC
//	LDA $92
//	ADC #$02
//	STA $92
//	BIT UNKNOWN_D47F
//	BNE @UNKNOWN3
//	SEC
//	SBC #$10
//	STA $92
//	LDA $A5
//	EOR #$01
//	STA $A5
//	SEC
//	LDA $8E
//	SBC #$08
//	STA $8E
//	LDA $8F
//	EOR #$04
//	STA $8F
//	JMP @UNKNOWN3
//@UNKNOWN4:
//	RTS

//UNKNOWN_D398:
//	JSR UNKNOWN_D4B7
//	SEC
//	LDA #$F0
//	SBC $99
//	CLC
//	ADC $A1
//	STA $A1
//	LDA #$0F
//	STA $91
//	LDX #$00
//	LDA #$06
//	STA $0400,X
//	STA $0422,X
//	INX
//	LDA $91
//	ASL
//	STA $0400,X
//	STA $0422,X
//	INX
//	LDA $8D
//	AND #$FC
//	STA $0400,X
//	STA $0422,X
//	INX
//	LDA $8C
//	AND #$1E
//	STA $0400,X
//	ORA #$01
//	STA $0422,X
//	INX
//	LDA $99
//	STA $8C
//@UNKNOWN0:
//	LDA $8C
//	SEC
//	SBC #$10
//	STA $8C
//	BCS @UNKNOWN1
//	LDA $A1
//	ADC #$10
//	STA $A1
//@UNKNOWN1:
//	JSR UNKNOWN_D537
//	LDY #$00
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0400,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0422,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0401,X
//	INY
//	LDA ($88),Y
//	AND #$3F
//	EOR $97
//	STA $0423,X
//	INX
//	INX
//	DEC $91
//	BEQ @UNKNOWN2
//	CLC
//	LDA $A1
//	ADC #$10
//	STA $A1
//	JMP @UNKNOWN0
//@UNKNOWN2:
//	LDA #$08
//	STA $91
//	LDX #$44
//	LDA #$07
//	STA $0400,X
//	INX
//	LDA $91
//	STA $0400,X
//	INX
//	LDA $99
//	AND #$10
//	BEQ @UNKNOWN3
//	SEC
//	LDA $92
//	PHA
//	SBC #$10
//	STA $92
//	LDA #$20
//	STA $93
//	JSR UNKNOWN_D480
//	PLA
//	STA $92
//	LDA #$10
//	STA $93
//	BNE @UNKNOWN5
//@UNKNOWN3:
//	LDA #$10
//	STA $93
//@UNKNOWN4:
//	JSR UNKNOWN_D480
//@UNKNOWN5:
//	DEC $91
//	BEQ @UNKNOWN6
//	CLC
//	LDA $92
//	ADC #$20
//	STA $92
//	CLC
//	LDA $8E
//	ADC #$08
//	STA $8E
//	BCC @UNKNOWN4
//	SBC #$40
//	STA $8E
//	SEC
//	LDA $92
//	SBC #$10
//	STA $92
//	JMP @UNKNOWN4
//@UNKNOWN6:
//	RTS

//UNKNOWN_D47F:
//	.BYTE $0F

//UNKNOWN_D480:
//	LDA $8F
//	STA $0400,X
//	INX
//	LDA $8E
//	STA $0400,X
//	INX
//	LDY $92
//	LDA ($A4),Y
//	AND #$03
//	STA $90
//	INY
//	LDA ($A4),Y
//	AND #$0C
//	ORA $90
//	STA $90
//	CLC
//	LDA $92
//	ADC $93
//	TAY
//	LDA ($A4),Y
//	AND #$30
//	ORA $90
//	STA $90
//	INY
//	LDA ($A4),Y
//	AND #$C0
//	ORA $90
//	STA $0400,X
//	INX
//	RTS

//UNKNOWN_D4B7:
//	LDA $10
//	LSR
//	ORA #$01
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDA $12
//	LSR
//	ORA #$01
//	LDX #BANK::PRGA000
//	JSR BANK_SWAP
//	JSR UNKNOWN_D55D
//	LDA $AB
//	AND #$07
//	STA $9A
//	LDA $AA
//	LSR $9A
//	ROR
//	LSR $9A
//	ROR
//	STA $98
//	LDA $99
//	EOR $A1
//	AND #$10
//	BNE @UNKNOWN0
//	LDA $A1
//	AND #$EE
//	JMP @UNKNOWN1
//@UNKNOWN0:
//	SEC
//	LDA $A1
//	SBC #$10
//	ORA #$10
//	AND #$FE
//@UNKNOWN1:
//	BIT $93
//	BPL @UNKNOWN2
//	LDX #$20
//	STX $93
//	SEC
//	SBC #$10
//@UNKNOWN2:
//	STA $92
//	LDA $99
//	AND #$F0
//	STA $8C
//	LDA $9A
//	ASL $8C
//	ROL
//	ASL $8C
//	ROL
//	ORA #$20
//	STA $8D
//	ORA #$03
//	STA $8F
//	LDA $98
//	AND #$F0
//	LSR
//	LSR
//	LSR
//	ORA $8C
//	STA $8C
//	LSR
//	LSR
//	AND #$07
//	STA $8E
//	LDA $99
//	LSR
//	LSR
//	AND #$38
//	ORA #$C0
//	ORA $8E
//	STA $8E
//	RTS

//UNKNOWN_D537:
//	LDY $A1
//	LDA ($A2),Y
//	AND #$80
//	LSR
//	STA $97
//	LSR
//	STA $96
//	BEQ @UNKNOWN0 + 1
//	LDA $13
//@UNKNOWN0:
//	BIT $11A5
//	STA $89
//	LDA ($A2),Y
//	ASL
//	ASL
//	ROL $89
//	STA $88
//	LDA $89
//	ADC #$90
//	ADC $96
//	STA $89
//	RTS

//UNKNOWN_D55D:
//	LDA $AB
//	AND #$07
//	STA $A3
//	LDA $AA
//	LSR $A3
//	ROR
//	LSR $A3
//	ROR
//	LSR
//	LSR
//	ORA $AC
//	STA $A1
//	LDA $AD
//	LSR
//	ROR $A1
//	LSR
//	ROR $A1
//	LDA #$00
//	STA $A2
//	STA $A4
//	STA $A6
//	LDA $A3
//	CLC
//	ADC #$60
//	STA $A3
//	ADC #$02
//	STA $A5
//	ADC #$02
//	STA $A7
//	RTS

//UNKNOWN_D591:
//	JSR UNKNOWN_D59D
//	LDY #$00
//	LDA ($88),Y
//	AND #$3F
//	STA $14
//	RTS

//UNKNOWN_D59D:
//	LDA $AD
//	LSR
//	LSR
//	LSR
//	LSR
//	AND #$0E
//	STA $94
//	ORA #$01
//	LDX #BANK::PRGA000
//	JSR BANK_SWAP
//	LDA $AD
//	LSR
//	LSR
//	AND #$07
//	STA $89
//	LDA $AB
//	AND #$FC
//	CLC
//	STA $88
//	LDA $89
//	ADC #$B8
//	STA $89
//	RTS

//UNKNOWN_D5C4:
//	CLC
//	LDA $19
//	ADC #$02
//	STA $AB
//	CLC
//	LDA $1A
//	ADC #$C0
//	STA $AC
//	LDA $1B
//	ADC #$01
//	STA $AD
//	JSR UNKNOWN_D59D
//	LDY #$00
//	LDA ($88),Y
//	AND #$3F
//	CMP $14
//	BEQ @UNKNOWN0
//	LDA $17
//	LDX #BANK::CHR1400
//	JSR BANK_SWAP
//	STA $12
//	AND #$03
//	STA $13
//	RTS
//@UNKNOWN0:
//	LDA $23
//	BEQ @UNKNOWN1
//	BPL @UNKNOWN2
//	AND #$7F
//	STA $23
//	BPL @UNKNOWN3
//@UNKNOWN1:
//	LDY #$01
//	LDA ($88),Y
//	AND #$3F
//	STA $15
//	TAX
//	LDA UNKNOWN_D634,X
//	BEQ @UNKNOWN3
//@UNKNOWN2:
//	LDX #BANK::CHR0800
//	JSR BANK_SWAP
//@UNKNOWN3:
//	LDY #$02
//	LDA ($88),Y
//	AND #$3F
//	LDX #BANK::CHR1000
//	JSR BANK_SWAP
//	STA $10
//	AND #$03
//	STA $11
//	INY
//	LDA ($88),Y
//	AND #$3F
//	LDX #BANK::CHR1400
//	JSR BANK_SWAP
//	STA $12
//	AND #$03
//	STA $13
//	RTS

//UNKNOWN_D634:
//	.BYTE $00, $68, $62, $62, $62, $62, $64, $62, $74, $64, $6A, $62, $66, $6C, $62, $00, $00, $00, $00, $00, $66, $00, $6A, $66, $62, $68, $64, $68, $6E, $66, $66, $66, $62, $62, $62, $66, $64, $6E, $62, $64, $66, $74, $6C, $66, $00, $00, $68, $6C, $72, $00, $66, $00, $00, $00, $6A, $00, $6C, $6E, $6C, $6E, $6C, $6E, $6E, $00

//UNKNOWN_D674:
//	LDA $20
//	BPL @UNKNOWN0
//	AND #$0F
//	STA $3E
//	LDA $6784
//	AND #$C0
//	STA $AA
//	LDA $6785
//	STA $AB
//	LDA $6786
//	AND #$C0
//	STA $AC
//	LDA $6787
//	STA $AD
//	JMP @UNKNOWN1
//@UNKNOWN0:
//	LDA $7406
//	AND #$3F
//	STA $3E
//	CLC
//	LDA $7404
//	AND #$C0
//	STA $18
//	ADC #$00
//	STA $AA
//	LDA $7405
//	STA $19
//	ADC #$02
//	STA $AB
//	CLC
//	LDA $7406
//	AND #$C0
//	STA $1A
//	ADC #$C0
//	STA $AC
//	LDA $7407
//	STA $1B
//	ADC #$01
//	STA $AD
//	JSR UNKNOWN_D591
//@UNKNOWN1:
//	JSR UNKNOWN_D55D
//	JSR UNKNOWN_DD57
//	JSR UNKNOWN_FDE7
//	LDA $23
//	BNE @UNKNOWN6
//	LDX #$00
//@UNKNOWN2:
//	LDA $7408,X
//	BEQ @UNKNOWN3
//	JSR UNKNOWN_D7DF
//	LDY #$19
//	LDA #$88
//	STA ($30),Y
//	LDA #$0C
//	CPX #$00
//	BNE @UNKNOWN3
//	LDY #$1C
//	LDA ($38),Y
//@UNKNOWN3:
//	LDY #$00
//	STA ($30),Y
//	LDA $20
//	AND #$C0
//	BEQ @UNKNOWN8
//	JSR UNKNOWN_DD64
//	INX
//	CPX #$04
//	BCC @UNKNOWN2
//@UNKNOWN4:
//	LDA $7404
//	AND #$3F
//	BEQ @UNKNOWN5
//	JSR UNKNOWN_FD28
//@UNKNOWN5:
//	LDA #$00
//	STA $20
//	LDA $22
//	AND #$CF
//	STA $22
//	JMP UNKNOWN_FDED
//@UNKNOWN6:
//	JSR UNKNOWN_D7E2
//	LDY #$00
//	LDA ($30),Y
//	AND #$3F
//	CMP #$0D
//	BNE @UNKNOWN7
//	JSR UNKNOWN_D884
//	LDY #$19
//	LDA $3E
//	STA ($30),Y
//	EOR #$04
//	STA $3E
//	JSR UNKNOWN_D7E2
//@UNKNOWN7:
//	JMP @UNKNOWN4
//@UNKNOWN8:
//	LDA $7409,X
//	BEQ @UNKNOWN9
//	JSR UNKNOWN_D768
//	BCC @UNKNOWN10
//@UNKNOWN9:
//	JSR UNKNOWN_DD64
//	JSR UNKNOWN_FDE7
//	LDY #$00
//	LDA #$00
//	STA ($30),Y
//@UNKNOWN10:
//	INX
//	CPX #$03
//	BCC @UNKNOWN8
//	JMP @UNKNOWN4
//UNKNOWN_D759:
//	PHA
//	LDX #$00
//@UNKNOWN11:
//	LDA $7409,X
//	BEQ UNKNOWN_D768_10
//	INX
//	CPX #$03
//	BCC @UNKNOWN11
//	PLA
//	RTS

//UNKNOWN_D768:
//	PHA
//UNKNOWN_D768_10:
//	TXA
//	PHA
//	JSR UNKNOWN_D86C
//	JSR UNKNOWN_D884
//	JSR UNKNOWN_FDE7
//	PLA
//	TAX
//	PLA
//	STA $7409,X
//	JSR UNKNOWN_D7DF
//	LDY #$19
//	LDA $3E
//	STA ($30),Y
//	LDY #$00
//	LDA #$0C
//	STA ($30),Y
//	CLC
//	JMP UNKNOWN_FDED
//UNKNOWN_D78D:
//	LDX #$00
//@UNKNOWN0:
//	CMP $7408,X
//	BEQ @UNKNOWN1
//	INX
//	CPX #$04
//	BCC @UNKNOWN0
//	RTS
//@UNKNOWN1:
//	JSR UNKNOWN_FDE7
//@UNKNOWN2:
//	CPX #$03
//	BCS @UNKNOWN3
//	LDA $7409,X
//	BEQ @UNKNOWN4
//	STA $7408,X
//	INX
//	BCC @UNKNOWN2
//@UNKNOWN3:
//	LDA #$00
//@UNKNOWN4:
//	STA $7408,X
//	TXA
//	JSR UNKNOWN_D86C
//	JSR UNKNOWN_DFBF
//	JSR UNKNOWN_DD57
//	LDX #$00
//@UNKNOWN5:
//	LDA $7408,X
//	BEQ @UNKNOWN6
//	JSR UNKNOWN_D813
//	LDA #$0C
//	CPX #$00
//	BNE @UNKNOWN6
//	LDY #$1C
//	LDA ($38),Y
//@UNKNOWN6:
//	LDY #$00
//	STA ($30),Y
//	JSR UNKNOWN_DD64
//	INX
//	CPX #$04
//	BCC @UNKNOWN5
//	CLC
//	JMP UNKNOWN_FDED

//UNKNOWN_D7DF:
//	JSR UNKNOWN_D813
//UNKNOWN_D7E2:
//	LDY #$04
//	LDA $AA
//	STA ($30),Y
//	INY
//	LDA $AB
//	STA ($30),Y
//	LDY #$06
//	LDA $AC
//	STA ($30),Y
//	INY
//	LDA $AD
//	STA ($30),Y
//	LDY #$11
//	LDA $A1
//	STA ($30),Y
//	INY
//	LDA $A6
//	STA ($30),Y
//	INY
//	LDA $A7
//	STA ($30),Y
//	LDA $3E
//	LDY #$15
//	STA ($30),Y
//	LDY #$1D
//	STA ($30),Y
//	RTS

//UNKNOWN_D813:
//	LDY #$02
//	AND #$07
//	STA $39
//	LDA #$00
//	LSR $39
//	ROR
//	LSR $39
//	ROR
//	STA $38
//	STA ($30),Y
//	INY
//	LDA $39
//	ADC #$74
//	STA $39
//	STA ($30),Y
//	LDY #$1D
//	LDA ($38),Y
//	LDY #$14
//	PHA
//	AND #$F0
//	STA ($30),Y
//	LDY #$08
//	PLA
//	AND #$0F
//	STA ($30),Y
//UNKNOWN_D840:
//	LDY #$1E
//	LDA ($38),Y
//	LDY #$16
//	STA ($30),Y
//	LDY #$1F
//	LDA ($38),Y
//	LDY #$17
//	STA ($30),Y
//	CLC
//	LDY #$01
//	LDA ($38),Y
//	BPL @UNKNOWN0
//	AND #$80
//	STA ($38),Y
//	LDY #$16
//	LDA ($30),Y
//	ADC #$A0
//	STA ($30),Y
//	INY
//	LDA ($30),Y
//	ADC #$00
//	STA ($30),Y
//	SEC
//@UNKNOWN0:
//	RTS

//UNKNOWN_D86C:
//	STA $31
//	LDA #$00
//	LSR $31
//	ROR
//	LSR $31
//	ROR
//	LSR $31
//	ROR
//	ADC #$80
//	STA $30
//	LDA $31
//	ADC #$67
//	STA $31
//	RTS

//UNKNOWN_D884:
//	LDY #$15
//	LDA ($30),Y
//	STA $3E
//	EOR #$04
//	ASL
//	ASL
//	ASL
//	TAX
//	LDY #$04
//	CLC
//	LDA $EBED,X
//	ADC ($30),Y
//	STA $AA
//	INY
//	LDA $EBEE,X
//	ADC ($30),Y
//	STA $AB
//	LDY #$06
//	CLC
//	LDA $EBEF,X
//	ADC ($30),Y
//	STA $AC
//	INY
//	LDA $EBF0,X
//	ADC ($30),Y
//	STA $AD
//	JSR UNKNOWN_D55D
//	JMP UNKNOWN_DD64

//UNKNOWN_D8BA:
//	JSR UNKNOWN_D86C
//	LDY #$02
//	LDA ($30),Y
//	STA $38
//	INY
//	LDA ($30),Y
//	STA $39
//	RTS

//UNKNOWN_D8C9:
//	LDA #$07
//	JSR UNKNOWN_D78D
//UNKNOWN_D8CE:
//	LDA #$06
//	JMP UNKNOWN_D78D
//UNKNOWN_D8D3:
//	LDA $7581
//	BPL @UNKNOWN0
//	LDA #$06
//	JSR UNKNOWN_D78D
//@UNKNOWN0:
//	LDA $75C1
//	BPL @UNKNOWN1
//	LDA #$07
//	JSR UNKNOWN_D78D
//@UNKNOWN1:
//	LDX #$00
//	STX $37
//@UNKNOWN2:
//	JSR UNKNOWN_D9F1
//	BCS @UNKNOWN4
//	TXA
//	JSR UNKNOWN_D8BA
//	JSR UNKNOWN_FDE7
//	JSR UNKNOWN_D840
//	BCS @UNKNOWN3
//	INC $37
//@UNKNOWN3:
//	JSR UNKNOWN_FDED
//	INX
//	CPX #$04
//	BCC @UNKNOWN2
//@UNKNOWN4:
//	STX $36
//	LDA $37
//	BEQ @UNKNOWN5
//	CLC
//	RTS
//@UNKNOWN5:
//	JSR UNKNOWN_D8C9
//	JSR UNKNOWN_FDE7
//	LDA #$00
//	STA $7441
//	STA $7456
//	STA $7457
//	LDA $7443
//	STA $7454
//	LDA $7444
//	STA $7455
//	LDA $7410
//	LSR $7411
//	ROR
//	ADC #$00
//	STA $7410
//	LDA $7411
//	ADC #$00
//	STA $7411
//	LDA #$01
//	STA $37
//	LDA #$00
//	STA $21
//	STA $23
//	LDX $47
//	LDY UNKNOWN_D96B,X
//	LDX #$03
//@UNKNOWN6:
//	LDA UNKNOWN_D96B + 4,Y
//	STA $7404,X
//	DEY
//	DEX
//	BPL @UNKNOWN6
//	LDA $7406
//	AND #$0F
//	ORA #$20
//	STA $20
//	EOR #$60
//	STA $22
//	SEC
//	JMP UNKNOWN_FDED

//UNKNOWN_D96B:
//	.BYTE $03, $03, $03, $07, $5C, $DF, $00, $24, $8B, $DF, $40, $DB

//UNKNOWN_D977:
//	DEC $36
//	BMI @UNKNOWN3
//	BEQ @UNKNOWN3
//@UNKNOWN0:
//	LDA $7408
//	CMP #$01
//	BEQ @UNKNOWN2
//	JSR UNKNOWN_D998
//	BCS @UNKNOWN0
//@UNKNOWN1:
//	JSR UNKNOWN_D998
//@UNKNOWN2:
//	LDA #$00
//	JSR UNKNOWN_D8BA
//	LDY #$01
//	LDA ($38),Y
//	BMI @UNKNOWN1
//@UNKNOWN3:
//	RTS

//UNKNOWN_D998:
//	JSR UNKNOWN_FDE7
//	LDX #$00
//	STX $37
//@UNKNOWN0:
//	LDA $7408,X
//	PHA
//	LDA $7409,X
//	STA $7408,X
//	PLA
//	STA $7409,X
//	LDA #$02
//	JSR UNKNOWN_D9DE
//	LDA #$03
//	JSR UNKNOWN_D9DE
//	LDA #$08
//@UNKNOWN1:
//	PHA
//	JSR UNKNOWN_D9DE
//	PLA
//	CLC
//	ADC #$01
//	CMP #$11
//	BCC @UNKNOWN1
//	LDA #$16
//	JSR UNKNOWN_D9DE
//	LDA #$17
//	JSR UNKNOWN_D9DE
//	CLC
//	LDA $37
//	ADC #$20
//	STA $37
//	INX
//	CPX $36
//	BCC @UNKNOWN0
//	JMP UNKNOWN_FDED

//UNKNOWN_D9DE:
//	CLC
//	ADC $37
//	TAY
//	LDA $6780,Y
//	PHA
//	LDA $67A0,Y
//	STA $6780,Y
//	PLA
//	STA $67A0,Y
//	RTS

//UNKNOWN_D9F1:
//	SEC
//	LDA $7408,X
//	BEQ @UNKNOWN0
//	CMP #$06
//@UNKNOWN0:
//	RTS

//UNKNOWN_D9FA:
//	LDX #$00
//@UNKNOWN0:
//	LDA $7408,X
//	BEQ @UNKNOWN2
//	JSR UNKNOWN_C665
//	LDY #$2C
//@UNKNOWN1:
//	LDA $73D8,Y
//	STA ($60),Y
//	INY
//	CPY #$30
//	BCC @UNKNOWN1
//@UNKNOWN2:
//	INX
//	CPX #$04
//	BCC @UNKNOWN0
//	RTS

//UNKNOWN_DA16:
//	JSR PpuSync
//	JSR UNKNOWN_FDC0
//	LDX #$00
//@UNKNOWN0:
//	JSR UNKNOWN_D9F1
//	BCS @UNKNOWN1
//	TXA
//	JSR UNKNOWN_D8BA
//	LDY #$01
//	LDA ($38),Y
//	BMI @UNKNOWN1
//	LDY #$10
//	LDA ($30),Y
//	TAY
//	LDA #$80
//	STA $0306,Y
//	LDA #$81
//	STA $0307,Y
//@UNKNOWN1:
//	INX
//	CPX #$04
//	BCC @UNKNOWN0
//	LDA #$01
//	STA $E5
//	JMP PpuSync
//UNKNOWN_DA48:
//	LDA $37
//	STA $64
//	LDA $49
//	STA $60
//	LDA $4A
//	STA $61
//	LDA $4B
//	STA $62
//	JSR UNKNOWN_F13D
//	LDA $68
//	BEQ @UNKNOWN2
//	LDA #$01
//@UNKNOWN2:
//	CLC
//	ADC $60
//	STA $49
//	LDA #$00
//	ADC $61
//	STA $4A
//	LDA #$00
//	ADC $62
//	STA $4B
//	JSR UNKNOWN_FDE7
//	LDX #$00
//@UNKNOWN3:
//	JSR UNKNOWN_D9F1
//	BCS @UNKNOWN7
//	STA $28
//	TXA
//	LSR
//	ROR
//	ROR
//	ROR
//	STA $53
//	TXA
//	PHA
//	JSR UNKNOWN_D8BA
//	LDY #$01
//	LDA ($38),Y
//	BMI @UNKNOWN6
//	LDA $47
//	BNE @UNKNOWN5
//	LDY #$11
//	CLC
//	LDA $49
//	ADC ($38),Y
//	STA ($38),Y
//	INY
//	LDA $4A
//	ADC ($38),Y
//	STA ($38),Y
//	INY
//	LDA $4B
//	ADC ($38),Y
//	STA ($38),Y
//	BCC @UNKNOWN4
//	LDY #$11
//	LDA #$FF
//	STA ($38),Y
//	INY
//	STA ($38),Y
//	INY
//	STA ($38),Y
//@UNKNOWN4:
//	LDY #$10
//	LDA ($38),Y
//	JSR UNKNOWN_DB40
//	LDY #$11
//	SEC
//	LDA ($38),Y
//	SBC $64
//	INY
//	LDA ($38),Y
//	SBC $65
//	INY
//	LDA ($38),Y
//	SBC $66
//	BCC @UNKNOWN5
//	JSR UNKNOWN_DB6C
//	BCC @UNKNOWN4
//@UNKNOWN5:
//	JSR UNKNOWN_DC87
//@UNKNOWN6:
//	PLA
//	TAX
//@UNKNOWN7:
//	INX
//	CPX #$04
//	BCC @UNKNOWN3
//	JSR UNKNOWN_C43F
//	LDA $47
//	BNE @UNKNOWN11
//	JSR UNKNOWN_FDE7
//	LDX #$12
//	JSR UNKNOWN_DC11
//	LDX #$15
//	JSR UNKNOWN_DC11
//	LDA $48
//	BEQ @UNKNOWN11
//	STA $29
//	JSR BANKSET_H13
//	JSR UNKNOWN_13BBC3
//	LDA #$FF
//	STA $2A
//	LDA $2B
//	ORA #$1F
//@UNKNOWN8:
//	ASL $2A
//	ASL
//	BCC @UNKNOWN8
//	JSR UNKNOWN_F1ED
//	AND $2A
//	BNE @UNKNOWN11
//	JSR UNKNOWN_13BB8C
//	LDX #$00
//@UNKNOWN9:
//	JSR UNKNOWN_D9F1
//	BCS @UNKNOWN10
//	STA $28
//	TXA
//	PHA
//	JSR UNKNOWN_13A979
//	PLA
//	TAX
//	BCC @UNKNOWN12
//@UNKNOWN10:
//	INX
//	CPX #$04
//	BCC @UNKNOWN9
//@UNKNOWN11:
//	JMP UNKNOWN_FDED
//@UNKNOWN12:
//	JSR UNKNOWN_CEDA
//	LDA #$06
//	STA UNKNOWN_07EF+2
//	LDA #$8C
//	JMP UNKNOWN_17A3F8

//UNKNOWN_DB40:
//	TAX
//	INX
//	STX $64
//	INX
//	STX $60
//	LDA #$00
//	STA $61
//	STA $62
//	JSR UNKNOWN_F109
//	JSR UNKNOWN_F109
//	JSR UNKNOWN_DCDF
//	LDY #$00
//	LDA ($68),Y
//	STA $64
//	JSR UNKNOWN_F109
//	LDA $61
//	STA $64
//	LDA $62
//	STA $65
//	LDA $63
//	STA $66
//	RTS

//UNKNOWN_DB6C:
//	LDY #$10
//	LDA ($38),Y
//	CMP #$63
//	BCC @UNKNOWN0
//	RTS
//@UNKNOWN0:
//	ADC #$01
//	STA ($38),Y
//	JSR UNKNOWN_C43F
//	JSR UNKNOWN_FDE7
//	LDA #$FF
//	JSR UNKNOWN_FD28
//	LDA #$1F
//	JSR UNKNOWN_FD28
//	LDA #$82
//	JSR $A3F8
//	JSR UNKNOWN_DCDF
//	LDY #$03
//@UNKNOWN1:
//	JSR UNKNOWN_F1ED
//	LSR
//	LSR
//	LSR
//	LSR
//	LSR
//	LSR
//	CLC
//	ADC ($68),Y
//	LSR
//	STA $0055,Y
//	INY
//	CPY #$08
//	BCC @UNKNOWN1
//	LDY #$0B
//@UNKNOWN2:
//	CLC
//	LDA ($38),Y
//	ADC $004D,Y
//	BCC @UNKNOWN3
//	SBC $004D,Y
//	EOR #$FF
//	STA $004D,Y
//	LDA #$FF
//@UNKNOWN3:
//	STA ($38),Y
//	LDA $004D,Y
//	BEQ @UNKNOWN4
//	TYA
//	PHA
//	CLC
//	ADC #$7B
//	JSR $A3F8
//	PLA
//	TAY
//@UNKNOWN4:
//	INY
//	CPY #$10
//	BCC @UNKNOWN2
//	LDY #$07
//	LDA $58
//	JSR UNKNOWN_DC64
//	LDY #$09
//	LDA $59
//	JSR UNKNOWN_DC64
//	LDY #$0E
//	LDA ($38),Y
//	STA $60
//	CLC
//	ADC #$14
//	BCC @UNKNOWN5
//	LDA #$FF
//@UNKNOWN5:
//	LDY #$03
//	JSR UNKNOWN_DC3F
//	LDA #$84
//	JSR UNKNOWN_DC38
//	LDA $28
//	CMP #$03
//	BCS @UNKNOWN6
//	LDY #$0F
//	LDA ($38),Y
//	STA $60
//	LSR
//	CLC
//	LDY #$05
//	JSR UNKNOWN_DC3F
//	LDA #$85
//	JSR UNKNOWN_DC38
//@UNKNOWN6:
//	CLC
//	RTS

//UNKNOWN_DC11:
//	CLC
//	LDA $4C
//	ADC $7400,X
//	STA $7400,X
//	LDA $4D
//	ADC $7401,X
//	STA $7401,X
//	LDA #$00
//	ADC $7402,X
//	STA $7402,X
//	BCC @UNKNOWN0
//	LDA #$FF
//	STA $7400,X
//	STA $7401,X
//	STA $7402,X
//@UNKNOWN0:
//	RTS

//UNKNOWN_DC38:
//	LDX $5D
//	BEQ UNKNOWN_DC64_1
//	JMP $A3F8

//UNKNOWN_DC3F:
//	CLC
//	ADC $60
//	STA $60
//	LDA #$00
//	ROL
//	STA $61
//	SEC
//	LDA $60
//	SBC ($38),Y
//	TAX
//	INY
//	LDA $61
//	SBC ($38),Y
//	BEQ @UNKNOWN0
//	LDX #$08
//	BCS @UNKNOWN0
//	LDX #$01
//@UNKNOWN0:
//	DEY
//	TXA
//	ASL
//	JSR UNKNOWN_DC71
//	STA $5D
//UNKNOWN_DC64:
//	CLC
//	ADC ($38),Y
//	STA ($38),Y
//	INY
//	LDA #$00
//	ADC ($38),Y
//	STA ($38),Y
//UNKNOWN_DC64_1:
//	RTS

//UNKNOWN_DC71:
//	CMP #$10
//	BCC @UNKNOWN0
//	LDA #$10
//@UNKNOWN0:
//	TAX
//	JSR UNKNOWN_F1ED
//	LSR
//	LSR
//	LSR
//	LSR
//	JSR UNKNOWN_F125
//	LSR
//	LSR
//	LSR
//	LSR
//	RTS

//UNKNOWN_DC87:
//	LDA $21
//	BNE @UNKNOWN2
//	JSR UNKNOWN_DCDF
//	LDY #$02
//	LDA ($68),Y
//	BEQ @UNKNOWN2
//	PHA
//	LDX #$C0
//@UNKNOWN0:
//	STX $29
//	JSR UNKNOWN_DCE6
//	PLA
//	PHA
//	TAY
//	LDA ($68),Y
//	LDY #$10
//	CMP ($38),Y
//	BCS @UNKNOWN1
//	JSR UNKNOWN_DCCD
//	AND ($38),Y
//	BNE @UNKNOWN1
//	JSR UNKNOWN_F1ED
//	AND #$C0
//	BNE @UNKNOWN1
//	LDA ($38),Y
//	ORA All_Bits,X
//	STA ($38),Y
//	LDA #$09
//	STA UNKNOWN_07EF+2
//	LDA #$83
//	JSR $A3F8
//@UNKNOWN1:
//	LDX $29
//	INX
//	BNE @UNKNOWN0
//	PLA
//@UNKNOWN2:
//	RTS

//UNKNOWN_DCCD:
//	LDA $29
//	CLC
//	ADC #$C0
//	ROR
//	LSR
//	LSR
//	TAY
//	LDA $29
//	AND #$07
//	TAX
//	LDA All_Bits,X
//	RTS

//UNKNOWN_DCDF:
//	CLC
//	LDA $28
//	ADC #$B8
//	BCC UNKNOWN_DCE6_0
//UNKNOWN_DCE6:
//	LDA $29
//UNKNOWN_DCE6_0:
//	ASL
//	ROL $69
//	ASL
//	ROL $69
//	ASL
//	ROL $69
//	CLC
//	ADC #$00
//	STA $68
//	LDA $69
//	AND #$07
//	ADC #$98
//	STA $69
//	JMP UNKNOWN_DE8B

/**
 * Original_Address: $(DOLLAR) $DD01, bank $1E
 */
void unknownDD01() @safe {
	//	JSR UNKNOWN_DD57
	//	JSR UNKNOWN_FDE7
	//@UNKNOWN1:
	//	LDY #$00
	//	LDA ($30),Y
	//	ASL
	//	BEQ @UNKNOWN3
	//	JSR UNKNOWN_E1BE
	//	BCS @UNKNOWN2
	//	LDY #$00
	//	LDA ($30),Y
	//	ORA #$80
	//	STA ($30),Y
	//	BMI @UNKNOWN3
	//@UNKNOWN2:
	//	LDY #$00
	//	LDA ($30),Y
	//	AND #$3F
	//	STA ($30),Y
	//	JSR UNKNOWN_E0F9
	//	JSR UNKNOWN_DEF9
	//@UNKNOWN3:
	//	JSR UNKNOWN_DD64
	//	INC $36
	//	BNE @UNKNOWN1
	//	LDA $20
	//	BNE @UNKNOWN4
	//	LDA $18
	//	AND #$C0
	//	ORA $078C
	//	LDX $19
	//	STA $7404
	//	STX $7405
	//	LDA $1A
	//	AND #$C0
	//	ORA $6795
	//	LDX $1B
	//	STA $7406
	//	STX $7407
	//@UNKNOWN4:
	//	JMP UNKNOWN_FDED
	//assert(0, "NYI");
}

//UNKNOWN_DD57:
//	LDA #$80
//	LDX #$67
//	STA $30
//	STX $31
//	LDX #$FC
//	STX $36
//	RTS

//UNKNOWN_DD64:
//	CLC
//	LDA $30
//	ADC #$20
//	STA $30
//	LDA $31
//	ADC #$00
//	STA $31
//	RTS

//UNKNOWN_DD72:
//	JSR UNKNOWN_DE29
//	JSR UNKNOWN_FDE7
//@UNKNOWN0:
//	JSR UNKNOWN_DE4B
//	JSR UNKNOWN_DD88
//	JSR UNKNOWN_DE5C
//	DEC $36
//	BNE @UNKNOWN0
//	JMP UNKNOWN_FDED

//UNKNOWN_DD88:
//	LDY #$01
//	LDA $15
//	STA ($30),Y
//	LDA $37
//	BNE @UNKNOWN2
//@UNKNOWN1:
//	LDY #$00
//	STA ($30),Y
//	RTS
//@UNKNOWN2:
//	LDY #$00
//	LDA ($32),Y
//	AND #$3F
//	BEQ @UNKNOWN1
//	JSR UNKNOWN_DE13
//	LDY #$02
//	LDA ($32),Y
//	AND #$3F
//	LDY #$15
//	STA ($30),Y
//	LDY #$04
//	LDA ($32),Y
//	LDY #$16
//	STA ($30),Y
//	LDY #$05
//	LDA ($32),Y
//	LDY #$17
//	STA ($30),Y
//	LDY #$00
//	LDA ($32),Y
//	AND #$C0
//	LDY #$04
//	STA ($30),Y
//	STA $AA
//	LDY #$01
//	LDA ($32),Y
//	LDY #$05
//	STA ($30),Y
//	STA $AB
//	LDY #$02
//	LDA ($32),Y
//	AND #$C0
//	LDY #$06
//	STA ($30),Y
//	STA $AC
//	LDY #$03
//	LDA ($32),Y
//	LDY #$07
//	STA ($30),Y
//	STA $AD
//	LDY #$02
//	LDA $32
//	STA ($30),Y
//	INY
//	LDA $33
//	STA ($30),Y
//	JSR UNKNOWN_D55D
//	LDY #$11
//	LDA $A1
//	STA ($30),Y
//	INY
//	LDA $A6
//	STA ($30),Y
//	INY
//	LDA $A7
//	STA ($30),Y
//	LDY #$18
//	LDX #$08
//	LDA #$00
//@UNKNOWN3:
//	STA ($30),Y
//	INY
//	DEX
//	BNE @UNKNOWN3
//	RTS

//UNKNOWN_DE13:
//	LDY #$00
//	STA ($30),Y
//	ASL
//	ASL
//	TAX
//	LDY #$08
//	LDA UNKNOWN_E105 + 2,X
//	STA ($30),Y
//	LDY #$14
//	LDA UNKNOWN_E105 + 3,X
//	STA ($30),Y
//	RTS

//UNKNOWN_DE29:
//	LDA $15
//	JSR UNKNOWN_DE6C
//	ASL
//	TAX
//	LDA OBJECTS_MAIN_POINTER_TABLE_1,X
//	STA $38
//	LDA OBJECTS_MAIN_POINTER_TABLE_1 + 1,X
//	STA $39
//	LDA #$02
//	STA $37
//UNKNOWN_DE3E:
//	LDA #<UNKNOWN_6800
//	LDX #>UNKNOWN_6800
//	STA $30
//	STX $31
//	LDX #$28
//	STX $36
//	RTS

//UNKNOWN_DE4B:
//	LDY #$01
//	LDA ($38),Y
//	BEQ @UNKNOWN0
//	STA $33
//	DEY
//	LDA ($38),Y
//	STA $32
//	RTS
//@UNKNOWN0:
//	STA $37
//	RTS

//UNKNOWN_DE5C:
//	CLC
//	LDA $38
//	ADC $37
//	STA $38
//	LDA $39
//	ADC #$00
//	STA $39
//	JMP UNKNOWN_DD64

//UNKNOWN_DE6C:
//	CMP #$2B
//	BCC @UNKNOWN0
//	LDX #$12
//	SBC #$2B
//	BCS @UNKNOWN2
//@UNKNOWN0:
//	CMP #$1A
//	BCC @UNKNOWN1
//	LDX #$11
//	SBC #$1A
//	BCS @UNKNOWN2
//@UNKNOWN1:
//	LDX #$10
//@UNKNOWN2:
//	PHA
//	TXA
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	PLA
//	RTS

//UNKNOWN_DE8B:
//	LDX #BANK::PRG8000
//	LDA #$00
//	JMP BANK_SWAP

//UNKNOWN_DE92:
//	LDX #BANK::PRG8000
//	LDA #$00
//	JMP BANK_SWAP

/**
 * Original_Address: $(DOLLAR) $DE99, bank $1E
 */
void B30_1e99() @safe {
	//	JSR UNKNOWN_DE29
	//	JSR UNKNOWN_FDE7
	//@UNKNOWN0:
	//	JSR UNKNOWN_DE4B
	//	LDY #$01
	//	LDA ($30),Y
	//	CMP $15
	//	BEQ @UNKNOWN2
	//	LDY #$00
	//	LDA ($30),Y
	//	ASL
	//	BEQ @UNKNOWN1
	//	JSR UNKNOWN_E1BE
	//	BCS @UNKNOWN3
	//@UNKNOWN1:
	//	JSR UNKNOWN_DD88
	//@UNKNOWN2:
	//	LDY #$00
	//	LDA ($30),Y
	//	ASL
	//	BEQ @UNKNOWN4
	//	JSR UNKNOWN_E1BE
	//	BCS @UNKNOWN3
	//	LDY #$00
	//	LDA ($30),Y
	//	ORA #$80
	//	STA ($30),Y
	//	BMI @UNKNOWN4
	//@UNKNOWN3:
	//	LDY #$00
	//	LDA ($30),Y
	//	AND #$3F
	//	STA ($30),Y
	//@UNKNOWN4:
	//	JSR UNKNOWN_DE5C
	//	DEC $36
	//	BNE @UNKNOWN0
	//	JSR UNKNOWN_DE3E
	//@UNKNOWN5:
	//	LDY #$00
	//	LDA ($30),Y
	//	BEQ @UNKNOWN6
	//	BMI @UNKNOWN6
	//	JSR UNKNOWN_E0F9
	//	JSR UNKNOWN_DEF9
	//@UNKNOWN6:
	//	JSR UNKNOWN_DD64
	//	DEC $36
	//	BNE @UNKNOWN5
	//	JMP UNKNOWN_FDED
	//assert(0, "NYI");
}

//UNKNOWN_DEF9:
//	LDY #$11
//	LDA ($30),Y
//	STA $69
//	INY
//	LDA ($30),Y
//	STA $6A
//	INY
//	LDA ($30),Y
//	STA $6B
//	LDY #$00
//	LDA ($30),Y
//	BPL @UNKNOWN7
//	JMP @UNKNOWN8
//@UNKNOWN7:
//	CLC
//	LDA $18
//	ADC #$60
//	STA $60
//	LDA $19
//	ADC #$00
//	STA $61
//	SEC
//	LDY #$04
//	LDA ($30),Y
//	SBC $60
//	STA $60
//	INY
//	LDA ($30),Y
//	SBC $61
//	STA $61
//	CLC
//	LDA $1A
//	ADC #$A4
//	STA $64
//	LDA $1B
//	ADC #$00
//	STA $65
//	SEC
//	LDY #$06
//	LDA ($30),Y
//	SBC $64
//	STA $64
//	INY
//	LDA ($30),Y
//	SBC $65
//	STA $65
//	LDY #$08
//	LDA $61
//	AND #$04
//	ASL
//	ASL
//	ASL
//	ASL
//	ASL
//	ORA ($30),Y
//	STA ($30),Y
//	INY
//	LDA $65
//	AND #$04
//	ASL
//	ASL
//	ASL
//	ASL
//	ASL
//	ORA ($30),Y
//	STA ($30),Y
//	INY
//	LDA $60
//	LSR $61
//	ROR
//	LSR $61
//	ROR
//	STA ($30),Y
//	INY
//	LDA $64
//	LSR $65
//	ROR
//	LSR $65
//	ROR
//	STA ($30),Y
//	LDA $3E
//	BMI @UNKNOWN9
//	LDY #$04
//	LDA $3A
//	STA ($30),Y
//	INY
//	LDA $3B
//	STA ($30),Y
//	LDY #$06
//	LDA $3C
//	STA ($30),Y
//	INY
//	LDA $3D
//	STA ($30),Y
//	LDY #$11
//	LDA $A1
//	STA ($30),Y
//	INY
//	LDA $A6
//	STA ($30),Y
//	INY
//	LDA $A7
//	STA ($30),Y
//	LDY $A1
//	LDA $36
//	STA ($A6),Y
//@UNKNOWN8:
//	LDY $69
//	LDA $36
//	EOR ($6A),Y
//	BEQ @UNKNOWN10
//	RTS
//@UNKNOWN9:
//	LDY $69
//	LDA $36
//@UNKNOWN10:
//	STA ($6A),Y
//	RTS

//UNKNOWN_DFBF:
//	LDY #$11
//	LDA ($30),Y
//	STA $A1
//	INY
//	LDA ($30),Y
//	STA $A6
//	INY
//	LDA ($30),Y
//	STA $A7
//	LDA #$00
//	LDY $A1
//	STA ($A6),Y
//	LDY #$00
//	STA ($30),Y
//	RTS

/**
 * Original_Address: $(DOLLAR) $DFDA, bank $1E
 */
void unknownDFDA() @safe {
	//	LDA $761F
	//	LSR
	//	LDA #$80
	//	LDX #$67
	//	LDY #$2C
	//	BCC @UNKNOWN0
	//	LDA #$00
	//	LDX #$68
	//	LDY #$28
	//@UNKNOWN0:
	//	STA $30
	//	STX $31
	//	STY $36
	//	LDA #$18
	//	STA $E3
	//	LDA #$00
	//	STA $0300
	//	LDX #$08
	//	JSR UNKNOWN_FDE7
	//assert(0, "NYI");
}


//UNKNOWN_E000: ;PRG0-$E000
//	LDY #$00
//	LDA ($30),Y
//	BEQ @UNKNOWN3
//	BMI @UNKNOWN3
//	LDY #$08
//	LDA ($30),Y
//	AND #$3F
//	BEQ @UNKNOWN3
//	LDY #$14
//	LDA ($30),Y
//	AND #$10
//	BEQ @UNKNOWN0
//	TXA
//	LDX #$00
//@UNKNOWN0:
//	STA $37
//	LDY #$10
//	TXA
//	STA ($30),Y
//	LDY #$08
//@UNKNOWN1:
//	LDA ($30),Y
//	STA $0300,X
//	INX
//	INY
//	CPY #$0E
//	BCC @UNKNOWN1
//	CLC
//	LDA $02FA,X
//	AND #$40
//	BEQ @UNKNOWN2
//	LDA #$04
//@UNKNOWN2:
//	ADC ($30),Y
//	STA $0300,X
//	INX
//	INY
//	LDA #$00
//	ADC ($30),Y
//	STA $0300,X
//	INX
//	BEQ @UNKNOWN5
//	LDA $37
//	BEQ @UNKNOWN3
//	TAX
//@UNKNOWN3:
//	JSR UNKNOWN_DD64
//	DEC $36
//	BNE UNKNOWN_E000
//@UNKNOWN4:
//	LDA #$00
//	STA $0300,X
//	CLC
//	TXA
//	ADC #$08
//	TAX
//	BCC @UNKNOWN4
//@UNKNOWN5:
//	JMP UNKNOWN_FDED

//UNKNOWN_E065: ;$E065
//	LDX #$00
//@UNKNOWN0:
//	LDA $0300,X
//	AND #$40
//	BEQ @UNKNOWN1
//	SEC
//	LDA $0306,X
//	SBC #$04
//	STA $0306,X
//	LDA $0307,X
//	SBC #$00
//	STA $0307,X
//@UNKNOWN1:
//	CLC
//	TXA
//	ADC #$08
//	TAX
//	BCC @UNKNOWN0
//	RTS

//UNKNOWN_E087: ;PRG0-$E087
//	JSR UNKNOWN_DD57
//	LDX #$04
//	STX $36
//	LDA #$00
//	STA $62
//	LDX #$08
//@UNKNOWNE094:
//	LDY #$00
//	LDA ($30),Y
//	BEQ @UNKNOWNE0E3
//	BMI @UNKNOWNE0E3
//	LDY $62
//	LDA ($60),Y
//	STA $0302,X
//	INY
//	LDA ($60),Y
//	STA $0303,X
//	INY
//	LDA ($60),Y
//	STA $63
//	INY
//	CLC
//	LDA ($60),Y
//	LDY #$16
//	ADC ($30),Y
//	STA $0306,X
//	INY
//	LDA #$00
//	ADC ($30),Y
//	STA $0307,X
//	LDY #$08
//	LDA ($30),Y
//	AND #$3F
//	ASL
//	ASL $63
//	ROR
//	STA $0300,X
//	LDA #$70
//	ASL $63
//	ROR
//	STA $0301,X
//	LDA #$00
//	STA $0304,X
//	STA $0305,X
//	CLC
//	TXA
//	ADC #$08
//	TAX
//@UNKNOWNE0E3:
//	CLC
//	LDA #$04
//	ADC $62
//	STA $62
//	JSR UNKNOWN_DD64
//	DEC $36
//	BNE @UNKNOWNE094
//	RTS

//UNKNOWN_E0F2: ;PRG0-$E0F2
//	AND #$3F
//	TAX
//	LDA $7400,X
//	RTS

//UNKNOWN_E0F9: ;PRG0-$E0F9
//	ASL
//	ASL
//	TAX
//	LDA UNKNOWN_E105 + 1,X
//	PHA
//	LDA UNKNOWN_E105,X
//	PHA
//	RTS

//UNKNOWN_E105: ;PRG0-$E105
//.WORD UNKNOWN_E1BD - 1
//.BYTE $00, $00

//.WORD UNKNOWN_E681 - 1
//.BYTE $00, $88

//.WORD UNKNOWN_E681 - 1
//.BYTE $00, $88

//.WORD UNKNOWN_E6CF - 1
//.BYTE $00, $88

//.WORD UNKNOWN_E678 - 1
//.BYTE $00, $08

//.WORD UNKNOWN_E1BD - 1
//.BYTE $00, $00

//.WORD UNKNOWN_E1BD - 1
//.BYTE $00, $00

//.WORD UNKNOWN_E83F - 1
//.BYTE $04, $A6

//.WORD UNKNOWN_E96C - 1
//.BYTE $04, $60

//.WORD UNKNOWN_EB3A - 1
//.BYTE $09, $20

//.WORD UNKNOWN_EB92 - 1
//.BYTE $09, $20

//.WORD UNKNOWN_E8DE - 1
//.BYTE $09, $20

//.WORD UNKNOWN_E905 - 1
//.BYTE $04, $60

//.WORD UNKNOWN_EA38 - 1
//.BYTE $09, $20

//.WORD UNKNOWN_EAC5 - 1
//.BYTE $09, $20

//.WORD UNKNOWN_EBCA - 1
//.BYTE $04, $20

//.WORD UNKNOWN_E7F5 - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E7CD - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E7BE - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E814 - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E808 - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E7C7 - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E7B8 - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E80E - 1
//.BYTE $04, $E6

//.WORD UNKNOWN_E720 - 1
//.BYTE $00, $C4

//.WORD UNKNOWN_E720 - 1
//.BYTE $04, $C6

//.WORD UNKNOWN_E720 - 1
//.BYTE $09, $46

//.WORD UNKNOWN_E720 - 1
//.BYTE $00, $44

//.WORD UNKNOWN_E71A - 1
//.BYTE $00, $C4

//.WORD UNKNOWN_E71A - 1
//.BYTE $04, $C6

//.WORD UNKNOWN_E71A - 1
//.BYTE $09, $46

//.WORD UNKNOWN_E71A - 1
//.BYTE $00, $44

//.WORD UNKNOWN_E756 - 1
//.BYTE $04, $88

//.WORD UNKNOWN_E6F1 - 1
//.BYTE $04, $C6

//.WORD UNKNOWN_E7BE - 1
//.BYTE $02, $E6

//.WORD UNKNOWN_E720 - 1
//.BYTE $0A, $56

//.WORD UNKNOWN_E720 - 1
//.BYTE $04, $56

//.WORD UNKNOWN_E720 - 1
//.BYTE $08, $C6

//.WORD UNKNOWN_E788 - 1
//.BYTE $04, $A6

//.WORD UNKNOWN_E6D9 - 1
//.BYTE $04, $C6

//.WORD UNKNOWN_E8D2 - 1
//.BYTE $09, $46

//.WORD UNKNOWN_E661 - 1
//.BYTE $00, $45

//.WORD UNKNOWN_E669 - 1
//.BYTE $00, $45

//.WORD UNKNOWN_E8F5 - 1
//.BYTE $0A, $C6

//.WORD UNKNOWN_E8E8 - 1
//.BYTE $09, $46

//.WORD UNKNOWN_E71A - 1
//.BYTE $04, $46

//UNKNOWN_E1BD: ;PRG0-$E1BD
//	RTS

//UNKNOWN_E1BE: ;PRG0-$E1BE
//	LDY #$04
//	LDA ($30),Y
//	STA $3A
//	INY
//	LDA ($30),Y
//	STA $3B
//	LDY #$06
//	LDA ($30),Y
//	STA $3C
//	INY
//	LDA ($30),Y
//	STA $3D
//UNKNOWN_E1D4:
//	SEC
//	LDA $3C
//	SBC $1A
//	STA $64
//	LDA $3D
//	SBC $1B
//	STA $65
//	SEC
//	LDA #$C0
//	SBC $64
//	LDA #$03
//	SBC $65
//	BCC @UNKNOWN0
//	LDA $18
//	SBC #$40
//	STA $60
//	LDA $19
//	SBC #$00
//	STA $61
//	SEC
//	LDA $3A
//	SBC $60
//	STA $60
//	LDA $3B
//	SBC $61
//	STA $61
//	SEC
//	LDA #$80
//	SBC $60
//	LDA #$04
//	SBC $61
//@UNKNOWN0:
//	RTS

//UNKNOWN_E20F:
//	JSR UNKNOWN_DD57
//	LDY #$15
//	LDA ($30),Y
//	ASL
//	ASL
//	ASL
//	TAX
//	LDA UNKNOWN_EBED+4,X
//	ASL
//	TAX
//	STA $3F
//	LDY #$11
//	LDA UNKNOWN_EBED+7,X
//	ASL
//	ASL
//	ASL
//	ASL
//	CLC
//	ADC ($30),Y
//	STA $A1
//	INY
//	LDA ($30),Y
//	STA $A6
//	INY
//	LDA ($30),Y
//	STA $A7
//	CLC
//	LDA $A1
//	ADC UNKNOWN_EBED+6,X
//	TAX
//	EOR $A1
//	AND #$F0
//	BEQ @UNKNOWN0
//	LDA $A1
//	AND #$F0
//	STA $A1
//	TXA
//	AND #$0F
//	ORA $A1
//	TAX
//	LDA $A7
//	EOR #$01
//	STA $A7
//@UNKNOWN0:
//	STX $A1
//	JSR UNKNOWN_E275
//UNKNOWN_E25D:
//	LDX $32
//	LDY $33
//	STX $30
//	STY $31
//	RTS

//UNKNOWN_E266:
//	LDA $21
//	AND #$7F
//	JSR UNKNOWN_E286
//	ASL $21
//	LDX #$00
//	STX $21
//	BEQ UNKNOWN_E25D
//UNKNOWN_E275:
//	LDY $A1
//	LDA ($A6),Y
//	BEQ UNKNOWN_E2A1
//	BMI @UNKNOWN1
//	SEC
//	LDA #$28
//	SBC ($A6),Y
//@UNKNOWN1:
//	CLC
//	ADC #$04
//	TAX
//UNKNOWN_E286:
//	STA $33
//	LDA #$00
//	LSR $33
//	ROR
//	LSR $33
//	ROR
//	LSR $33
//	ROR
//	ADC #$80
//	STA $32
//	LDA $33
//	ADC #$67
//	STA $33
//	LDY #$14
//	LDA ($32),Y
//UNKNOWN_E2A1:
//	RTS

//UNKNOWN_E2A2:
//	LDY #$14
//	LDA ($30),Y
//	AND #$20
//	BEQ UNKNOWN_E2A1
//	JSR UNKNOWN_FDE7
//	CLC
//	LDA $3F
//	ADC #$20
//	AND #$38
//	TAX
//	LDY #$15
//	LSR
//	LSR
//	LSR
//	STA ($30),Y
//	JSR UNKNOWN_FDED
//UNKNOWN_E2BF:
//	LDA UNKNOWN_EBED+4,X
//UNKNOWN_E2C2:
//	CLC
//	LDY #$16
//	ADC ($30),Y
//	STA $60
//	LDA #$00
//	INY
//	ADC ($30),Y
//	STA $61
//	LDA #$15
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDY #$10
//	LDA ($30),Y
//	TAY
//	LDA $0300,Y
//	AND #$3F
//	STA $3F
//	BEQ UNKNOWN_E2A1
//	LDA $60
//	STA $0306,Y
//	LDA $61
//	STA $0307,Y
//	LDA $0302,Y
//	STA $68
//	LDA $0303,Y
//	STA $69
//	LDA $0301,Y
//	ASL
//	ASL
//	TAX
//	LDY #$00
//	LDA ($60),Y
//	STA $64
//	INY
//	LDA ($60),Y
//	STA $65
//	INY
//	LDA ($60),Y
//	STA $6A
//	INY
//	LDA ($60),Y
//	STA $6B
//	SEC
//@UNKNOWN1:
//	BIT $E2
//	BVS @UNKNOWN1
//	ROR $E2
//	LDY #$00
//@UNKNOWN2:
//	LDA $0200,X
//	CMP #$F0
//	BEQ @UNKNOWN6
//	CLC
//	LDA ($64),Y
//	ADC $68
//	STA $0203,X
//	INY
//	CLC
//	LDA ($64),Y
//	ADC $69
//	STA $0200,X
//	INY
//	LDA ($64),Y
//	STA $60
//	LDA $6B
//	LSR $60
//	BCC @UNKNOWN3
//	LSR
//	LSR
//@UNKNOWN3:
//	LSR $60
//	BCC @UNKNOWN4
//	LSR
//	LSR
//	LSR
//	LSR
//@UNKNOWN4:
//	AND #$03
//	ASL $60
//	ASL $60
//	ORA $60
//	STA $0202,X
//	INY
//	CLC
//	AND #$10
//	BEQ @UNKNOWN5
//	LDA $6A
//@UNKNOWN5:
//	ADC ($64),Y
//	STA $0201,X
//	INY
//	BNE @UNKNOWN7
//@UNKNOWN6:
//	INY
//	INY
//	INY
//	INY
//@UNKNOWN7:
//	INX
//	INX
//	INX
//	INX
//	BEQ @UNKNOWN8
//	DEC $3F
//	BNE @UNKNOWN2
//@UNKNOWN8:
//	ASL $E2
//	RTS

//UNKNOWN_E376:
//	LDA $AD
//	LSR
//	LSR
//	LSR
//	LSR
//	AND #$0E
//	ORA #$01
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDA $AD
//	LSR
//	LSR
//	AND #$07
//	STA $69
//	LDA $AB
//	AND #$FC
//	CLC
//	STA $68
//	LDA $69
//	ADC #$98
//	STA $69
//	LDY #$01
//	LDA ($68),Y
//	AND #$3F
//	LDY #$01
//	CMP ($30),Y
//	BNE @UNKNOWN0
//	LDA $15
//	JSR UNKNOWN_DE6C
//	CLC
//	RTS
//@UNKNOWN0:
//    LDA $15
//    JSR UNKNOWN_DE6C
//    SEC
//    RTS

//UNKNOWN_E3B4:
//	LDA #$14
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDA $A6
//	STA $A2
//	LDA $3E
//	ASL
//	TAX
//	LDA UNKNOWN_E3CC + 1,X
//	PHA
//	LDA UNKNOWN_E3CC,X
//	PHA
//	RTS

//UNKNOWN_E3CC: ;PRG0-$E3CC
//	.WORD $E427
//	.WORD $E43B
//	.WORD UNKNOWN_E3DE - 1
//	.WORD $E4B1
//	.WORD UNKNOWN_E49E - 1
//	.WORD $E4DB
//	.WORD $E402
//	.WORD $E465
//	.WORD $E48F

//UNKNOWN_E3DE:
//	JSR UNKNOWN_E506
//	TAX
//	AND #$30
//	BEQ @UNKNOWN0
//	AND #$20
//	BEQ @UNKNOWN1
//	TXA
//	AND #$1C
//	BNE @UNKNOWN1
//@UNKNOWN0:
//	LDX #$FF
//	LDY #$00
//	JSR UNKNOWN_E510
//	TAX
//	AND #$20
//	BEQ @UNKNOWN3
//	TXA
//	AND #$03
//	BEQ @UNKNOWN3
//@UNKNOWN1:
//	JMP $E490
//	JSR UNKNOWN_E506
//	TAX
//	AND #$30
//	BEQ @UNKNOWN2
//	AND #$20
//	BEQ @UNKNOWN1
//	TXA
//	AND #$13
//	BNE @UNKNOWN1
//@UNKNOWN2:
//	LDX #$01
//	LDY #$00
//	JSR UNKNOWN_E510
//	TAX
//	AND #$20
//	BEQ @UNKNOWN3
//	TXA
//	AND #$0C
//	BNE @UNKNOWN1
//@UNKNOWN3:
//	JMP UNKNOWN_E4A8
//	JSR UNKNOWN_E506
//	AND #$16
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$10
//	JSR UNKNOWN_E510
//	AND #$09
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//	JSR UNKNOWN_E506
//	AND #$14
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$10
//	JSR UNKNOWN_E510
//	AND #$08
//	BNE UNKNOWN_E4A1
//	LDX #$FF
//	LDY #$00
//	JSR UNKNOWN_E510
//	AND #$02
//	BNE UNKNOWN_E4A1
//	LDX #$FF
//	LDY #$10
//	JSR UNKNOWN_E510
//	AND #$01
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//	JSR UNKNOWN_E506
//	AND #$12
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$10
//	JSR UNKNOWN_E510
//	AND #$01
//	BNE UNKNOWN_E4A1
//	LDX #$01
//	LDY #$00
//	JSR UNKNOWN_E510
//	AND #$04
//	BNE UNKNOWN_E4A1
//	LDX #$01
//	LDY #$10
//	JSR UNKNOWN_E510
//	AND #$08
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//UNKNOWN_E4A1:
//	LDA $15
//	JSR UNKNOWN_DE6C
//	SEC
//	RTS
//UNKNOWN_E4A8:
//	LDA $15
//	JSR UNKNOWN_DE6C
//	CLC
//	RTS

//UNKNOWN_E49E:
//	JSR UNKNOWN_E506
//	AND #$19
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$F0
//	JSR UNKNOWN_E510
//	AND #$06
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//	JSR UNKNOWN_E506
//	AND #$18
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$F0
//	JSR UNKNOWN_E510
//	AND #$04
//	BNE UNKNOWN_E4A1
//	LDX #$FF
//	LDY #$00
//	JSR UNKNOWN_E510
//	AND #$01
//	BNE UNKNOWN_E4A1
//	LDX #$FF
//	LDY #$F0
//	JSR UNKNOWN_E510
//	AND #$02
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//	JSR UNKNOWN_E506
//	AND #$11
//	BNE UNKNOWN_E4A1
//	LDX #$00
//	LDY #$F0
//	JSR UNKNOWN_E510
//	AND #$02
//	BNE UNKNOWN_E4A1
//	LDX #$01
//	LDY #$00
//	JSR UNKNOWN_E510
//	AND #$08
//	BNE UNKNOWN_E4A1
//	LDX #$01
//	LDY #$F0
//	JSR UNKNOWN_E510
//	AND #$04
//	BNE UNKNOWN_E4A1
//	BEQ UNKNOWN_E4A8
//UNKNOWN_E506:
//	LDX #$00
//	LDY #$00
//	JSR UNKNOWN_E510
//	STA $3F
//	RTS

//UNKNOWN_E510:
//	CLC
//	TYA
//	ADC $A1
//	STA $A3
//	CLC
//	TXA
//	ADC $A3
//	TAY
//	EOR $A3
//	AND #$F0
//	BEQ @UNKNOWN0
//	LDA $A3
//	AND #$F0
//	STA $A3
//	TYA
//	AND #$0F
//	ORA $A3
//	TAY
//	LDA #$01
//@UNKNOWN0:
//	EOR $A7
//	CLC
//	ADC #$FC
//	STA $A3
//	LDA #$00
//	STA $A4
//	LDA ($A2),Y
//	BMI @UNKNOWN1+1 ;???
//	LDA $10
//@UNKNOWN1:
//	BIT $12A5
//	LSR
//	ROR $A4
//	ADC #$80
//	STA $A5
//	LDA ($A2),Y
//	AND #$7F
//	TAY
//	LDA ($A4),Y
//	RTS

//UNKNOWN_E552:
//	JSR UNKNOWN_E607
//	LDY #$0C
//	LDA UNKNOWN_EBED+6,X
//	ASL
//	STA ($30),Y
//	INY
//	LDA UNKNOWN_EBED+7,X
//	ASL
//	STA ($30),Y
//	JMP $E577
//UNKNOWN_E567:
//	JSR UNKNOWN_E607
//	LDY #$0C
//	LDA UNKNOWN_EBED+6,X
//	STA ($30),Y
//	INY
//	LDA UNKNOWN_EBED+7,X
//	STA ($30),Y
//	LDY #$08
//	LDA ($30),Y
//	AND #$3F
//	ORA #$40
//	STA $60
//	LDA $3E
//	LSR
//	AND #$40
//	EOR $60
//	STA ($30),Y
//	LDY #$09
//	LDA #$38
//	STA ($30),Y
//	LDY #$15
//	LDA ($30),Y
//	ASL
//	ASL
//	ASL
//	TAX
//	LDA UNKNOWN_EBED+4,X
//UNKNOWN_E59B:
//	CLC
//	LDY #$16
//	ADC ($30),Y
//	LDY #$0E
//	STA ($30),Y
//	LDA #$00
//	LDY #$17
//	ADC ($30),Y
//	LDY #$0F
//	STA ($30),Y
//	RTS

//UNKNOWN_E5AF:
//	JSR UNKNOWN_E5EF
//	ASL $3A
//	ROL $3B
//	ASL $3C
//	ROL $3D
//	JMP UNKNOWN_E5C0
//UNKNOWN_E5BD:
//	JSR UNKNOWN_E5EF
//UNKNOWN_E5C0:
//	CLC
//	LDY #$04
//	LDA ($30),Y
//	ADC $3A
//	STA $3A
//	AND #$C0
//	STA $AA
//	INY
//	LDA ($30),Y
//	ADC $3B
//	STA $3B
//	STA $AB
//	CLC
//	LDY #$06
//	LDA ($30),Y
//	ADC $3C
//	STA $3C
//	AND #$C0
//	STA $AC
//	INY
//	LDA ($30),Y
//	ADC $3D
//	STA $3D
//	STA $AD
//	JMP UNKNOWN_D55D
//UNKNOWN_E5EF:
//	JSR UNKNOWN_E607
//	LDA UNKNOWN_EBED,X
//	STA $3A
//	LDA UNKNOWN_EBED+1,X
//	STA $3B
//	LDA UNKNOWN_EBED+2,X
//	STA $3C
//	LDA UNKNOWN_EBED+3,X
//	STA $3D
//	RTS

//UNKNOWN_E607:
//	LDA $3E
//	ASL
//	ASL
//	ASL
//	TAX
//	RTS

//UNKNOWN_E60E:
//	JSR UNKNOWN_E655
//	LDY #$14
//	LDA ($30),Y
//	AND #$0F
//	TAY
//	LDA ($32),Y
//	INY
//	CMP #$05
//	BEQ @UNKNOWN0
//	CMP #$06
//	BEQ @UNKNOWN2
//	BNE @UNKNOWN1
//@UNKNOWN0:
//	JSR UNKNOWN_E646
//	AND All_Bits,X
//	BNE @UNKNOWN3
//@UNKNOWN1:
//	CLC
//	RTS
//@UNKNOWN2:
//	JSR UNKNOWN_E646
//	AND All_Bits,X
//	BNE @UNKNOWN1
//@UNKNOWN3:
//	LDY #$00
//	LDA ($30),Y
//	ORA #$80
//	STA ($30),Y
//	SEC
//	RTS

//UNKNOWN_E641:
//	JSR UNKNOWN_E655
//	LDY #$04
//UNKNOWN_E646:
//	LDA ($32),Y
//	AND #$07
//	TAX
//	LDA ($32),Y
//	LSR
//	LSR
//	LSR
//	TAY
//	LDA $7600,Y
//	RTS

//UNKNOWN_E655:
//	LDY #$02
//	LDA ($30),Y
//	STA $32
//	INY
//	LDA ($30),Y
//	STA $33
//	RTS

//UNKNOWN_E661:
//	JSR UNKNOWN_E641
//	ORA All_Bits,X
//	BNE UNKNOWN_E672
//UNKNOWN_E669:
//	JSR UNKNOWN_E641
//	ORA All_Bits,X
//	EOR All_Bits,X
//UNKNOWN_E672:
//	STA $7600,Y
//	JMP UNKNOWN_E720

//UNKNOWN_E678:
//	LDY #$1B
//	LDA ($30),Y
//	BNE UNKNOWNE661_1
//	JMP UNKNOWN_E72E
//UNKNOWN_E681:
//	LDY #$15
//	LDA ($30),Y
//	ORA #$40
//	LDY #$1B
//	EOR ($30),Y
//	AND #$4F
//	BEQ UNKNOWNE661_1
//	JSR UNKNOWN_E72E
//	CLC
//	RTS
//UNKNOWNE661_1:
//	JSR UNKNOWN_E655
//	LDY #$04
//	JSR UNKNOWN_E6A1
//	JSR UNKNOWN_E72E
//	SEC
//	RTS

//UNKNOWN_E6A1:
//	LDA $32
//	STA $60
//	LDA $33
//	STA $61
//UNKNOWN_E6A9:
//	SEC
//	LDA ($60),Y
//	SBC #$00
//	STA $7404
//	INY
//	LDA ($60),Y
//	SBC #$02
//	STA $7405
//	INY
//	SEC
//	LDA ($60),Y
//	SBC #$C0
//	STA $7406
//	INY
//	LDA ($60),Y
//	SBC #$01
//	STA $7407
//	LDA #$40
//	STA $20
//	RTS

//UNKNOWN_E6CF:
//	JSR UNKNOWN_E681
//	BCC @UNKNOWN0
//	LDA #$01
//	STA $0E
//@UNKNOWN0:
//	RTS

//UNKNOWN_E6D9:
//	JSR UNKNOWN_E60E
//	BCC @UNKNOWN0
//	RTS
//@UNKNOWN0:
//	JSR UNKNOWN_E7FC
//	AND #$F0
//	LSR
//	LSR
//	LSR
//	CMP #$08
//	BCS UNKNOWN_E6FE
//	JSR UNKNOWN_E7DC
//	JMP UNKNOWN_E73D

//UNKNOWN_E6F1:
//	JSR UNKNOWN_E60E
//	BCC @UNKNOWN0
//	RTS
//@UNKNOWN0:
//	JSR UNKNOWN_E7FC
//	AND #$F0
//	BNE UNKNOWN_E720
//UNKNOWN_E6FE:
//	LDY #$0C
//	LDA #$3D
//	STA ($30),Y
//	INY
//	LDA #$EC
//	STA ($30),Y
//	JSR UNKNOWN_E73D
//	LDY #$09
//	LDA #$78
//	STA ($30),Y
//	LDA #$00
//	JSR UNKNOWN_E59B
//	JMP UNKNOWN_E72E

//UNKNOWN_E71A:
//	JSR UNKNOWN_E60E
//	BCC UNKNOWN_E720
//	RTS
//UNKNOWN_E720:
//	JSR UNKNOWN_E733
//	JSR UNKNOWN_E73D
//	JSR UNKNOWN_E746
//	LDA #$00
//	JSR UNKNOWN_E59B
//UNKNOWN_E72E:
//	LDA #$88
//	STA $3E
//	RTS

//UNKNOWN_E733:
//	LDA #$00
//	LDY #$0C
//	STA ($30),Y
//	INY
//	STA ($30),Y
//	RTS

//UNKNOWN_E73D:
//	LDY #$08
//	LDA ($30),Y
//	AND #$3F
//	STA ($30),Y
//	RTS

//UNKNOWN_E746:
//	LDY #$09
//	LDA #$38
//	STA ($30),Y
//	RTS

//UNKNOWN_E74D:
//	LDY #$08
//	LDA ($30),Y
//	ORA #$40
//	STA ($30),Y
//	RTS

//UNKNOWN_E756:
//	JSR UNKNOWN_E733
//	JSR UNKNOWN_E73D
//	JSR UNKNOWN_E746
//	JSR UNKNOWN_E655
//	JSR UNKNOWN_E772
//	AND All_Bits,X
//	BEQ @UNKNOWN0
//	LDA #$04
//@UNKNOWN0:
//	JSR UNKNOWN_E59B
//	JMP UNKNOWN_E72E
//UNKNOWN_E772:
//	LDY #$06
//	LDA ($32),Y
//	ASL
//	LDY #$07
//	LDA ($32),Y
//	AND #$07
//	TAX
//	LDA ($32),Y
//	ROR
//	LSR
//	LSR
//	TAY
//	LDA $7620,Y
//	RTS

//UNKNOWN_E788:
//	LDY #$1A
//	LDA ($30),Y
//	BNE @UNKNOWN0
//	LDA #$01
//	STA ($30),Y
//	LDY #$15
//	LDA ($30),Y
//	EOR #$04
//	AND #$0F
//	STA ($30),Y
//@UNKNOWN0:
//	LDY #$15
//	LDA ($30),Y
//	STA $3E
//	JSR UNKNOWN_E5AF
//	JSR UNKNOWN_E1D4
//	BCC @UNKNOWN1
//	LDA #$F8
//	STA $22
//	JMP $E552
//@UNKNOWN1:
//	LDA #$00
//	STA $22
//	JMP $E965

//UNKNOWN_E7B8:
//	JSR UNKNOWN_E60E
//	BCC UNKNOWN_E7BE
//	RTS
//UNKNOWN_E7BE:
//	JSR UNKNOWN_E7FC
//	AND #$E0
//	LSR
//	LSR
//	BCC UNKNOWN_E7D2
//UNKNOWN_E7C7:
//	JSR UNKNOWN_E60E
//	BCC UNKNOWN_E7CD
//	RTS
//UNKNOWN_E7CD:
//	JSR UNKNOWN_E7FC
//	AND #$F8
//UNKNOWN_E7D2:
//	LSR
//	LSR
//	CMP #$08
//	BCS UNKNOWN_E7F5
//	LDY #$15
//	STA ($30),Y
//UNKNOWN_E7DC:
//	STA $3E
//	JSR UNKNOWN_E5BD
//	JSR UNKNOWN_E376
//	BCS UNKNOWN_E7F5
//	JSR UNKNOWN_E1D4
//	BCC UNKNOWN_E7F5
//	JSR UNKNOWN_E275
//	BNE UNKNOWN_E7F5
//	JSR UNKNOWN_E3B4
//	BCC UNKNOWN_E788_6
//UNKNOWN_E7F5:
//	LDA #$88
//	STA $3E
//UNKNOWN_E788_6:
//	JMP UNKNOWN_E567
//UNKNOWN_E7FC:
//	LDA $25
//	BNE UNKNOWN_E788_7
//	JMP UNKNOWN_F1ED
//UNKNOWN_E788_7:
//	PLA
//	PLA
//	JMP UNKNOWN_E7F5
//UNKNOWN_E808:
//	JSR UNKNOWN_E60E
//	BCC UNKNOWN_E7F5
//	RTS

//UNKNOWN_E80E:
//	JSR UNKNOWN_E60E
//	BCC UNKNOWN_E814
//	RTS
//UNKNOWN_E814:
//	JSR UNKNOWN_E7FC
//	AND #$E0
//	LSR
//	LSR
//	LSR
//	LSR
//	CMP #$08
//	BCS UNKNOWN_E7F5
//	LDY #$15
//	STA ($30),Y
//	JSR UNKNOWN_E7F5
//	JMP UNKNOWN_E74D

//UNKNOWN_E82B:
//	CMP #$00
//	BNE UNKNOWN_E7F5
//	STA $22
//	LDY #$1D
//	LDA ($30),Y
//	AND #$7F
//	PHA
//	JSR UNKNOWN_DE13
//	PLA
//	JMP UNKNOWN_E0F9

//UNKNOWN_E83F:
//	LDY #$1A
//	LDA ($30),Y
//	BNE @UNKNOWN2
//	LDY #$1E
//	CLC
//	LDA ($30),Y
//	STA $32
//	ADC #$02
//	STA ($30),Y
//	INY
//	LDA ($30),Y
//	STA $33
//	ADC #$00
//	STA ($30),Y
//	LDY #$00
//	LDA ($32),Y
//	CMP #$10
//	BCC UNKNOWN_E82B
//	LDY #$19
//	STA ($30),Y
//	LDY #$01
//	LDA ($32),Y
//	LDY #$1A
//@UNKNOWN2:
//	SEC
//	SBC #$01
//	STA ($30),Y
//	BNE @UNKNOWN3
//	LDY #$1E
//	LDA ($30),Y
//	STA $32
//	INY
//	LDA ($30),Y
//	STA $33
//	LDY #$00
//	LDA ($32),Y
//	CMP #$10
//	BCS @UNKNOWN3
//	SEC
//	LDA #$28
//	SBC $36
//	CLC
//	ADC #$84
//	STA $21
//@UNKNOWN3:
//	LDY #$19
//	LDA ($30),Y
//	TAX
//	AND #$20
//	BEQ @UNKNOWN4
//	LDY #$1D
//	LDA ($30),Y
//	ASL
//	ASL
//	TAY
//	LDA UNKNOWN_E105+2,Y
//@UNKNOWN4:
//	LDY #$08
//	STA ($30),Y
//	TXA
//	AND #$08
//	BNE @UNKNOWN5
//	LDY #$15
//	TXA
//	AND #$07
//	STA ($30),Y
//@UNKNOWN5:
//	TXA
//	BMI @UNKNOWN6
//	PHA
//	AND #$07
//	STA $3E
//	JSR UNKNOWN_E5BD
//	PLA
//	TAX
//	BPL @UNKNOWN7
//@UNKNOWN6:
//	LDA #$88
//	STA $3E
//@UNKNOWN7:
//	TXA
//	AND #$40
//	ASL
//	ORA #$70
//	ORA $3E
//	STA $22
//	JMP UNKNOWN_E567
//UNKNOWN_E8D2:
//	JSR UNKNOWN_E60E
//	BCC @UNKNOWN8
//	RTS
//@UNKNOWN8:
//	JSR UNKNOWN_E7F5
//	JMP $E8E1
//UNKNOWN_E8DE:
//	JSR UNKNOWN_EB92
//	JSR UNKNOWN_E74D
//	LDA #$74
//	BNE UNKNOWN_E900
//UNKNOWN_E8E8:
//	JSR UNKNOWN_E60E
//	BCC @UNKNOWN9
//	RTS
//@UNKNOWN9:
//    JSR UNKNOWN_E7F5
//    LDA #$74
//    BNE UNKNOWN_E900
//UNKNOWN_E8F5:
//    JSR UNKNOWN_E60E
//    BCC @UNKNOWN10
//    RTS
//@UNKNOWN10:
//	JSR UNKNOWN_E7F5
//	LDA #$72
//UNKNOWN_E900:
//	LDX #BANK::CHR0800
//	JMP BANK_SWAP
//UNKNOWN_E905:
//	LDA $23
//	CLC
//	BNE UNKNOWN_E80E_15
//	LDA $3E
//	BMI @UNKNOWN12
//	LDY #$1D
//	LDA ($30),Y
//	TAX
//	LDA $0C
//	STA ($30),Y
//	TXA
//	LDY #$15
//	STA ($30),Y
//	STA $0C
//	LDY #$19
//	LDA ($30),Y
//	TAX
//	LDA $3E
//	STA ($30),Y
//	TXA
//	STA $3E
//	BMI @UNKNOWN12
//	JSR UNKNOWN_E5BD
//@UNKNOWN12:
//	JSR UNKNOWN_E567
//	JSR UNKNOWN_EA24
//	LDY #$08
//	LDA ($30),Y
//	AND #$0F
//	CMP #$0A
//	BEQ @UNKNOWN13
//	RTS
//@UNKNOWN13:
//	LDA $D5
//	ASL
//	AND #$02
//	ORA #$70
//	LDX #BANK::CHR0800
//	JMP BANK_SWAP
//UNKNOWN_E80E_14:
//	LDA #$88
//	STA $A0
//	LDA #$00
//	STA $E7
//	STA $E8
//	STA $E9
//	JSR UNKNOWN_E733
//UNKNOWN_E80E_15:
//	LDA #$00
//	STA $3E
//	STA $23
//	LDA #$10
//	BCS UNKNOWN_E80E_16
//	LDA #$80
//UNKNOWN_E80E_16:
//	LDY #$00
//	STA ($30),Y
//	RTS

//UNKNOWN_E96C:
//	LDA $23
//	ASL
//	BNE UNKNOWN_E80E_14
//	JSR UNKNOWN_E9CD
//	BMI @UNKNOWN3
//	LDY #$15
//	STA ($30),Y
//	STA $0C
//@UNKNOWN1:
//	STA $3E
//	JSR UNKNOWN_E5BD
//	LDA $25
//	CMP #$28
//	BCS @UNKNOWN4
//	JSR UNKNOWN_E9FA
//	BCS @UNKNOWN3
//	JSR UNKNOWN_E3B4
//	BCS @UNKNOWN3
//	BIT $3F
//	BPL @UNKNOWN4
//	BVS @UNKNOWN2
//	LDA $3E
//	SBC #$00
//	AND #$0F
//	BPL @UNKNOWN1
//@UNKNOWN2:
//	LDY #$15
//	LDA #$00
//	STA ($30),Y
//	STA $0C
//	BCC @UNKNOWN4
//@UNKNOWN3:
//	LDA #$88
//	STA $3E
//@UNKNOWN4:
//	JSR UNKNOWN_E567
//	JSR UNKNOWN_EA24
//UNKNOWN_E9B3:
//	LDA $3E
//	STA $A0
//	LDY #$09
//	LDA ($30),Y
//	AND #$40
//	ORA $1F
//	STA $E7
//	LDY #$0C
//	LDA ($30),Y
//	STA $E8
//	INY
//	LDA ($30),Y
//	STA $E9
//	RTS

//UNKNOWN_E9CD:
//	LDA $22
//	BEQ @UNKNOWN1
//	BPL @UNKNOWN0
//	RTS
//@UNKNOWN0:
//	LDY #$19
//	LDA ($30),Y
//	TAX
//	LDA $22
//	STA ($30),Y
//	TXA
//	AND #$8F
//	RTS
//@UNKNOWN1:
//;UNKNOWN_E9E1:
//	LDA $DE
//	AND #$0F
//	TAX
//	LDA $0D
//	BPL @UNKNOWN2
//	AND #$0F
//	CMP Direction_By_Input,X
//	BEQ @UNKNOWN3
//	STA $0D
//@UNKNOWN2:
//	LDA Direction_By_Input,X
//	RTS
//@UNKNOWN3:
//;UNKNOWN_E9F7:
//	LDA #$88
//	RTS

//UNKNOWN_E9FA:
//	JSR UNKNOWN_E275
//	BEQ @UNKNOWN3
//	ASL
//	LDA $3E
//	AND #$01
//	BEQ @UNKNOWN0
//	BCS @UNKNOWN2
//@UNKNOWN0:
//	LDA $0F
//	BNE @UNKNOWN1
//	LDY #$1B
//	LDA $3E
//	ORA #$40
//	STA ($32),Y
//	BIT $21
//	BMI @UNKNOWN1
//	STX $21
//@UNKNOWN1:
//	BCC @UNKNOWN4
//@UNKNOWN2:
//	LDA $22
//	AND #$10
//	BEQ @UNKNOWN4
//@UNKNOWN3:
//	CLC
//@UNKNOWN4:
//	RTS

//UNKNOWN_EA24:
//	JSR UNKNOWN_E655
//	LDY #$01
//	LDA ($32),Y
//	AND #$40
//	BEQ @UNKNOWN0
//	LDY #$08
//	LDA ($30),Y
//	AND #$3F
//	STA ($30),Y
//@UNKNOWN0:
//	RTS

//UNKNOWN_EA38:
//	LDY #$1A
//	LDA ($30),Y
//	BNE @UNKNOWN0
//	LDA $15
//	JSR UNKNOWN_DE6C
//	ASL
//	TAX
//	LDA $8000,X
//	STA $60
//	LDA $8001,X
//	STA $61
//	LDY #$1E
//	LDA ($30),Y
//	ASL
//	TAY
//	LDA ($60),Y
//	STA $32
//	INY
//	LDA ($60),Y
//	STA $33
//	LDY #$1F
//	LDA ($30),Y
//	TAY
//	LDA ($32),Y
//	CMP #$10
//	BCC @UNKNOWN1
//	PHA
//	INY
//	LDA ($32),Y
//	TAX
//	INY
//	TYA
//	LDY #$1F
//	STA ($30),Y
//	LDY #$19
//	PLA
//	STA ($30),Y
//	TXA
//	LDY #$1A
//@UNKNOWN0:
//	SEC
//	SBC #$01
//	STA ($30),Y
//	LDY #$19
//	LDA ($30),Y
//	BMI @UNKNOWN3
//	AND #$0F
//	STA $3E
//	LDY #$15
//	STA ($30),Y
//	JSR UNKNOWN_E5BD
//	JSR UNKNOWN_EB0B
//	JSR UNKNOWN_E59B
//	JMP UNKNOWN_E9B3
//@UNKNOWN1:
//	CMP #$00
//	BNE @UNKNOWN2
//	STA $23
//@UNKNOWN2:
//	INY
//	JSR UNKNOWN_E6A1
//	INY
//	TYA
//	LDY #$1F
//	STA ($30),Y
//	LDA $23
//	BNE @UNKNOWN3
//	LDA #$80
//	STA $23
//	JSR UNKNOWN_D9FA
//	LDX #$00
//	JSR UNKNOWN_CDAF
//@UNKNOWN3:
//	LDA #$88
//	STA $3E
//	JSR UNKNOWN_EB0B
//	JMP UNKNOWN_E9B3

//UNKNOWN_EAC5:
//	LDA $3E
//	BMI @UNKNOWN6
//	LDY #$19
//	LDA ($30),Y
//	TAX
//	LDA $3E
//	STA ($30),Y
//	TXA
//	BMI @UNKNOWN6
//	STA $3E
//	LDY #$15
//	EOR #$04
//	STA ($30),Y
//	LDY #$06
//	SEC
//	LDA $6786
//	SBC ($30),Y
//	INY
//	LDA $6787
//	SBC ($30),Y
//	LDY #$14
//	LDA ($30),Y
//	BCS @UNKNOWN4 + 1
//	ORA #$10
//@UNKNOWN4:
//	BIT $EF29
//	STA ($30),Y
//	JSR UNKNOWN_E5BD
//	JSR UNKNOWN_EB0B
//	CPX #$40
//	BCC @UNKNOWN5
//	SBC #$04
//@UNKNOWN5:
//	JMP UNKNOWN_E59B
//@UNKNOWN6:
//	LDA #$88
//	STA $3E
//UNKNOWN_EB0B:
//	JSR UNKNOWN_E607
//	LDY #$0C
//	LDA UNKNOWN_EBED+6,X
//	STA ($30),Y
//	INY
//	LDA UNKNOWN_EBED+7,X
//	STA ($30),Y
//	JSR UNKNOWN_E73D
//	JSR UNKNOWN_E746
//	LDA $3E
//	BMI UNKNOWN_EB39
//	LDY #$15
//	LDA ($30),Y
//	TAX
//	LDA ShakeTable,X
//	TAX
//	LDY #$08
//	AND #$40
//	ORA ($30),Y
//	STA ($30),Y
//	TXA
//	AND #$1F
//UNKNOWN_EB39:
//	RTS

//UNKNOWN_EB3A:
//	JSR UNKNOWN_E9CD
//	BMI @UNKNOWN2
//	LDY #$15
//	STA ($30),Y
//	STA $A0
//	TAX
//	LDY #$1A
//	LDA ($30),Y
//	BEQ @UNKNOWN1
//	BMI @UNKNOWN0
//	SEC
//	SBC #$01
//	STA ($30),Y
//	CMP #$05
//	BCS @UNKNOWN1
//	LDX #$07
//	BCC @UNKNOWN1
//@UNKNOWN0:
//	PHA
//	CLC
//	ADC #$01
//	STA ($30),Y
//	PLA
//	CMP #$FD
//	BCS @UNKNOWN1
//	LDX #$05
//@UNKNOWN1:
//	STX $3E
//	JSR UNKNOWN_E5BD
//	JMP $EB76
//@UNKNOWN2:
//	LDA #$88
//	STA $A0
//	STA $3E
//	JSR UNKNOWN_E567
//	JSR UNKNOWN_E74D
//	LDA $A0
//	STA $3E
//	JSR UNKNOWN_E607
//	LDA $1F
//	STA $E7
//	LDA UNKNOWN_EBED+6,X
//	STA $E8
//	LDA UNKNOWN_EBED+7,X
//	STA $E9
//	RTS

//UNKNOWN_EB92:
//	JSR UNKNOWN_E9CD
//	BMI @UNKNOWN0
//	LDY #$15
//	STA ($30),Y
//	STA $3E
//	JSR UNKNOWN_E5BD
//	JSR UNKNOWN_E9FA
//	BCS @UNKNOWN0
//	LDA $22
//	BNE @UNKNOWN1
//	LDA #$14
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	LDA $A6
//	STA $A2
//	JSR UNKNOWN_E506
//	LDA $15
//	JSR UNKNOWN_DE6C
//	BIT $3F
//	BVS @UNKNOWN1
//@UNKNOWN0:
//	LDA #$88
//	STA $3E
//@UNKNOWN1:
//	JSR UNKNOWN_E567
//	JMP UNKNOWN_E9B3

//UNKNOWN_EBCA:
//	JSR UNKNOWN_E9CD
//	STA $3E
//	BMI @UNKNOWN0
//	JSR UNKNOWN_E5BD
//@UNKNOWN0:
//	JSR UNKNOWN_E567
//	JSR UNKNOWN_E73D
//	JMP UNKNOWN_E9B3

//Direction_By_Input:
//	.BYTE $88, $02, $06, $88, $04, $03, $05, $88, $00, $01, $07, $88, $88, $88, $88, $88

//UNKNOWN_EBED:
//	.BYTE $00, $00, $C0, $FF
//	.BYTE $00, $00, $00, $FF
//	.BYTE $40, $00, $C0, $FF
//	.BYTE $00, $00, $01, $FF
//	.BYTE $40, $00, $00, $00
//	.BYTE $08, $00, $01, $00
//	.BYTE $40, $00, $40, $00
//	.BYTE $10, $00, $01, $01
//	.BYTE $00, $00, $40, $00
//	.BYTE $10, $00, $00, $01
//	.BYTE $C0, $FF, $40, $00
//	.BYTE $10, $00, $FF, $01
//	.BYTE $C0, $FF, $00, $00
//	.BYTE $18, $00, $FF, $00
//	.BYTE $C0, $FF, $C0, $FF
//	.BYTE $00, $00, $FF, $FF
//	.BYTE $00, $00, $00, $00
//	.BYTE $10, $00, $00, $00

Vector2B[] ShakeTable = [
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,1),
    Vector2B(cast(ubyte)-1,0),
    Vector2B(1,0),
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,1),
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,1),
    Vector2B(cast(ubyte)-1,0),
    Vector2B(1,0),
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,1),
    Vector2B(0,1),
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,cast(ubyte)-1),
    Vector2B(0,1),
];

//All_Bits:
//	.BYTE $80, $40, $20, $10
//	.BYTE $08, $04, $02, $01


//B31_0c65:
//	JSR OT0_DefaultTransition
//UNKNOWN_EC68:
//	LDX #$00
//	LDY #$08
//	JSR UNKNOWN_EECC
//	LDA #$EC
//	LDX #$EC
//	JSR UNKNOWN_CEE8
//	LDA #$01
//	STA MIRROR
//	LDA #$80
//	STA $07EF
//	LDA #$7C
//	STA $40
//	STA $41
//	STA $42
//	STA $43
//	LDA #$00
//	STA $46
//	LDA #$00
//	STA $45
//	LDX #$09
//@UNKNOWN0:
//	LDA UNKNOWN_ECF2,X
//	STA $0540,X
//	DEX
//	BPL @UNKNOWN0
//	JSR UNKNOWN_ED1A
//	JMP WaitNMI

//UNKNOWN_ECA3:
//	LDA #$C3
//	JSR UNKNOWN_C408
//	LDX #$1E
//	JSR WaitXFrames_Min1
//	JSR UNKNOWN_D8D3
//	BCS @UNKNOWN1
//	JSR UNKNOWN_DA48
//	CLC
//@UNKNOWN1:
//	PHP
//	JSR UNKNOWN_D977
//	LDX #$3C
//@UNKNOWN2:
//	JSR WaitNMI
//	LDA $DE
//	BNE @UNKNOWN3
//	DEX
//	BNE @UNKNOWN2
//@UNKNOWN3:
//	JSR PpuSync
//	JSR B31_0ddf
//	JSR UNKNOWN_EE7F
//	LDA #$60
//	LDX #BANK::CHR0000
//	JSR BANK_SWAP
//	LDA #$00
//	STA MIRROR
//	STA $EC
//	STA $70
//	STA $71
//	STA $48
//	STA $07EF
//	STA $D7
//	PLP
//	JMP WaitNMI

//UNKNOWN_ECEC:
//	.BYTE $78, $00, $7C, $7D, $7E, $7F

//UNKNOWN_ECF2:
//	.WORD UNKNOWN_ED22 - 1, UNKNOWN_ED62 - 1, UNKNOWN_ED22 - 1, UNKNOWN_ED9B - 1, $0000

//UNKNOWN_ECFC:
//	LDX #$FC
//	.BYTE $2C ;this + the following LDX is interpreted as BIT $04A2, which is effectively a no-op that allows us to skip the following LDX
//UNKNOWN_ECFF:
//	LDX #$04
//	JSR PpuSync
//	STX $E9
//	LDX #$14
//@UNKNOWN0:
//	LDA #$01
//	STA $E5
//	JSR PpuSync
//	JSR UNKNOWN_ED1A
//	DEX
//	BNE @UNKNOWN0
//	LDA #$00
//	STA $E9
//	RTS

//UNKNOWN_ED1A:
//	SEC
//	LDA #$59
//	SBC $FC
//	STA $EC
//	RTS

//UNKNOWN_ED22:
//	CLC
//	LDA #$02
//	ADC $46
//	JSR UNKNOWN_C218
//	BIT $45
//	BPL UNKNOWN_ED62_2
//UNKNOWN_ED22_2:
//	LDA $40
//	BPL @UNKNOWN0
//	LDA #$7C
//@UNKNOWN0:
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $41
//	BPL @UNKNOWN1
//	LDA #$7C
//@UNKNOWN1:
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $42
//	BPL @UNKNOWN2
//	LDA #$7C
//@UNKNOWN2:
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $43
//	BPL @UNKNOWN3
//	LDA #$7C
//@UNKNOWN3:
//	STX BANKSELECT
//	STA BANKDATA
//	RTS
//UNKNOWN_ED62:
//	SEC
//	LDA #$23
//	SBC $46
//	ASL
//	JSR UNKNOWN_C218
//	BIT $45
//	BVS UNKNOWN_ED22_2
//UNKNOWN_ED62_2:
//	LDA $40
//	AND #$7F
//	STX BANKSELECT
//UNKNOWN_ED62_3:
//	STA BANKDATA
//	INX
//	LDA $41
//	AND #$7F
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $42
//	AND #$7F
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $43
//	AND #$7F
//	STX BANKSELECT
//	STA BANKDATA
//	RTS

//UNKNOWN_ED9B:
//	LDA $44
//	STA $46
//	LDA #$C8
//	JSR UNKNOWN_C218
//	STA IRQDISABLE
//	LDA $F2
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $F3
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $F4
//	STX BANKSELECT
//	STA BANKDATA
//	INX
//	LDA $F5
//	STX BANKSELECT
//	STA BANKDATA
//	RTS

//B31_0dcb:
//	JSR UNKNOWN_C220
//	LDX #$24
//	LDA #$1F
//	BIT $2002
//	STX PPUADDR
//	STA PPUADDR
//	RTS

void OT0_DefaultTransition() @safe {
	BackupPalette();
	B31_0ddf:
	for(ubyte darken = 5; darken != 1; darken--){
		for(ubyte color = 0x1f; color != 0xff; color--){
			ubyte out_color = palette_queue[color];
			if (out_color > 0x10){
				out_color -= 0x10;
			} else {
				out_color = 0xf;
			}
			palette_queue[color] = out_color;
		}
		B31_0eb5(darken);
	}
	return;
}

//UNKNOWN_EDFE:
//	PHA
//	JSR BackupPalette
//	PLA
//UNKNOWN_EE03:
//	LDX #$1F
//@UNKNOWN0:
//	STA $0500,X
//	DEX
//	BPL @UNKNOWN0
//	JMP UNKNOWN_EEB3

//UNKNOWN_EE0E:
//	PHA
//	JSR PpuSync
//	PLA
//	LDX #$1F
//@UNKNOWN1:
//	DEX
//	DEX
//	DEX
//	STA $0500,X
//	DEX
//	BPL @UNKNOWN1
//	JMP UNKNOWN_EEB3

//UNKNOWN_EE21:
//	PHA
//	JSR PpuSync
//	PLA
//	LDX #$1F
//@UNKNOWN2:
//	STA $0520,X
//	DEX
//	BPL @UNKNOWN2
//	BMI UNKNOWN_EE33

void B31_0e30() @safe {
	PpuSync();
	B31_0e33:
	for (ubyte lighten = 5; lighten != 1; lighten--){
		for (ubyte color = 0x1f; color != 0xff; color--){
			ubyte working_color = cast(ubyte)(palette_queue[color] - palette_backup[color]);
			if (working_color == 0){
				continue;
			}
			working_color &= 0xf;
			if (working_color == 0){
				if (working_color < 0x80){
					working_color = cast(ubyte)(palette_queue[color] + 0x10);
				} else {
					working_color = cast(ubyte)(palette_queue[color] - 0x10);
					if (working_color < 0x80){
						working_color = 0xf;
					}
				}
			} else {
				if ((palette_backup[color] & 0xf) <= 0xd){
					working_color = cast(ubyte)(palette_backup[color] & 0xf);
					palette_queue[color] &= 0x30;
					working_color |= palette_queue[color];
				} else {
					working_color = cast(ubyte)(palette_queue[color] + 0x10);
				}
			}
			palette_queue[color] = working_color;
		}
		B31_0eb5(lighten);
	}
}

//UNKNOWN_EE7F:
//	JSR PpuSync
//	LDX #$1F
//@UNKNOWN0:
//	LDA $0520,X
//	STA $0500,X
//	DEX
//	BPL @UNKNOWN0
//	RTS

void BackupPalette() @safe {
	PpuSync();
	for (ubyte color = 0x1f; color != 0xff; color--){
		palette_backup[color] = palette_queue[color];
	}
}

//UNKNOWN_EE9D:
//	STA $60
//	STX $61
//	JSR PpuSync
//	LDY #$1F
//@UNKNOWN0:
//	LDA ($60),Y
//	STA $0500,Y
//	DEY
//	BPL @UNKNOWN0
//	BMI UNKNOWN_EEB3
//UNKNOWN_EEB0:
//	JSR UNKNOWN_EE7F
//UNKNOWN_EEB3:
//	LDX #$01

void B31_0eb5(ubyte count) @safe {
	//glorified QueuePaletteUpdate
	nmi_queue[0] = NMI_COMMANDS.UPDATE_PALETTE;
	nmi_queue[1] = 0;
	nmi_data_offset = 0;
	new_animation_timer = 0x80;

	return WaitXFrames_Min1(count);
}

//UNKNOWN_EEC8:
//	LDX #$00
//	LDY #$00
//UNKNOWN_EECC:
//	JSR PpuSync
//	LDA #$00
//	STA $E8
//	STA $E9
//	STA $EC
//	LDA #$FC
//	AND $FF
//	STA $FF
//	STX $FD
//	STY $FC
//	JMP WaitNMI

//UNKNOWN_EEE4:
//	JSR PpuSync
//	LDA #$04
//	EOR $FD
//	STA $FD
//	JMP WaitNMI


/**
 * Original_Address: $(DOLLAR) $EEF0, bank $1F
 */
bool B31_0ef0() @safe {
//	LDA $761F
//	AND #$F0
//	BEQ @UNKNOWN3
//	STA $60
//	ASL $60
//	BCC @UNKNOWN3
//	JSR UNKNOWN_F1ED
//	AND #$C0
//	BNE @UNKNOWN3
//	JSR BackupPalette
//	JSR UNKNOWN_EF1B
//	LDX #$0A
//@UNKNOWN2:
//	LDA #$07
//	STA UNKNOWN_07EF+1
//	JSR UNKNOWN_EEE4
//	DEX
//	BNE @UNKNOWN2
//	JSR UNKNOWN_EEB0
//@UNKNOWN3:
//	RTS
	//assert(0, "NYI");
	return false;
}

//UNKNOWN_EF1B:
//	LDX #$0F
//@UNKNOWN0:
//	CPX #$0E
//	BEQ @UNKNOWN2
//	SEC
//	LDA $0500,X
//	SBC #$10
//	BCS @UNKNOWN1
//	LDA #$0F
//@UNKNOWN1:
//	STA $0500,X
//@UNKNOWN2:
//	DEX
//	BPL @UNKNOWN0
//	JMP UNKNOWN_EEB3

//UNKNOWN_EF34:
//	LDY #$08
//	LDA ($80),Y
//	STA $84
//	INY
//	LDA ($80),Y
//	STA $85
//UNKNOWN_EF3F:
//	LDY #$06
//	LDA ($80),Y
//	STA $76
//	LDY #$07
//	LDA ($80),Y
//	STA $77
//UNKNOWN_EF4B:
//	LDY #$00
//	LDA ($80),Y
//	STA $86
//	TAX
//	LDY #$01
//	LDA ($80),Y
//	JSR UNKNOWN_F125
//	STA $82
//	LDY #$00
//	STY $87
//@UNKNOWN3:
//	LDA ($84),Y
//	BNE @UNKNOWN4
//	INY
//	CPY $82
//	BCC @UNKNOWN3
//	STA $82
//	STA $83
//	RTS
//@UNKNOWN4:
//	STY $82
//	TYA
//@UNKNOWN5:
//	CMP $86
//	BCC @UNKNOWN6
//	SBC $86
//	INC $87
//	BCS @UNKNOWN5
//@UNKNOWN6:
//	STA $86
//UNKNOWN_EF7C:
//	JSR PpuSync
//	LDY #$18
//	STY $65
//	LDA #$00
//	STA $0202
//@UNKNOWN6_:
//	LDY #$05
//	LDA ($80),Y
//	STA $0201
//	LDY #$02
//	LDA ($80),Y
//	LDX $86
//	JSR UNKNOWN_F125
//	CLC
//	ADC $76
//	ASL
//	ASL
//	ASL
//	STA $0203
//	LDY #$03
//	LDA ($80),Y
//	LDX $87
//	JSR UNKNOWN_F125
//	CLC
//	ADC $77
//	ASL
//	ASL
//	ASL
//	CLC
//	ADC #$07
//	STA $0200
//	LDY $65
//@UNKNOWN7:
//	LDX #$00
//	STX $DA
//@UNKNOWN8:
//	JSR UNKNOWN_F1ED
//	JSR WaitNMI
//	LDA $DA
//	BNE @UNKNOWN10
//	DEY
//	BNE @UNKNOWN8
//	LDY #$05
//	LDA ($80),Y
//	EOR $0201
//	STA $0201
//	LDA $DE
//	BNE @UNKNOWN9
//	LDY #$18
//	STY $65
//	BNE @UNKNOWN7
//@UNKNOWN9:
//	LDY #$06
//	STY $65
//@UNKNOWN10:
//	LDX #$00
//	STX $DA
//	TAX
//	LDY #$04
//	AND #$F0
//	AND ($80),Y
//	BEQ @UNKNOWN11
//	STA $83
//	LDA #$05
//	STA UNKNOWN_07EF+2
//@UNKNOWN10_:
//	LDA #$F0
//	STA $0200
//	RTS
//@UNKNOWN11:
//	TXA
//	AND #$0F
//	STA $83
//	TAY
//	LDX UNKNOWN_F0D1 + 8,Y
//	BMI @UNKNOWN6_
//	LDA $86
//	STA $68
//	LDA $87
//	STA $69
//	STX $6B
//@UNKNOWN11_:
//	CLC
//	LDA UNKNOWN_F0D1 + 25,X
//	ADC $69
//	LDY #$01
//	CMP ($80),Y
//	BCS @UNKNOWN13
//	STA $69
//	STA $60
//	CLC
//	LDA UNKNOWN_F0D1 + 24,X
//	ADC $68
//	LDY #$00
//	CMP ($80),Y
//	BCS @UNKNOWN13
//	STA $68
//	STA $6A
//	LDA ($80),Y
//	LDX $60
//	JSR UNKNOWN_F125
//	CLC
//	ADC $6A
//	STA $6A
//	TAY
//	LDA ($84),Y
//	BEQ @UNKNOWN14
//	LDA $68
//	STA $86
//	LDA $69
//	STA $87
//	LDA $6A
//	STA $82
//	LDA #$0D
//	STA UNKNOWN_07EF+2
//@UNKNOWN12:
//	JMP @UNKNOWN6_
//@UNKNOWN13:
//	LDY #$04
//	LDA $83
//	AND ($80),Y
//	BEQ @UNKNOWN12
//	STA $83
//	LDA #$0D
//	STA UNKNOWN_07EF+2
//	JMP @UNKNOWN10_
//@UNKNOWN14:
//	LDX $6B
//	LDY #$01
//	LDA $D6
//	BEQ @UNKNOWN15
//	INX
//	DEY
//@UNKNOWN15:
//	LDA UNKNOWN_F0D1 + 24,X
//	BEQ @UNKNOWN20
//@UNKNOWN16:
//	STA $6A
//	SEC
//	LDA $0068,Y
//	SBC $0086,Y
//	EOR #$FF
//	BPL @UNKNOWN17
//	CLC
//	ADC $0086,Y
//	STA $0068,Y
//	BPL @UNKNOWN19
//	BMI @UNKNOWN18
//@UNKNOWN17:
//	SEC
//	ADC $0086,Y
//	STA $0068,Y
//	CMP ($80),Y
//	BCC @UNKNOWN19
//@UNKNOWN18:
//	LDA #$00
//	CMP $6A
//	BNE @UNKNOWN16
//	BEQ @UNKNOWN13
//@UNKNOWN19:
//	TYA
//	EOR #$01
//	TAY
//	LDA $0086,Y
//	STA $0068,Y
//@UNKNOWN20:
//	LDX $6B
//	JMP @UNKNOWN11_

//UNKNOWN_F0B0:
//	PHA
//	LDY #$02
//	LDA ($80),Y
//	LDX $86
//	JSR UNKNOWN_F125
//	CLC
//	ADC $76
//	STA $76
//	LDY #$03
//	LDA ($80),Y
//	LDX $87
//	JSR UNKNOWN_F125
//	CLC
//	ADC $77
//	STA $77
//	PLA
//	JMP UNKNOWN_C68B

//UNKNOWN_F0D1:
//	.BYTE $01, $02, $03, $04, $05, $06, $07, $08, $88, $02, $06, $88, $04, $88, $88, $88, $00, $88, $88, $88, $88, $88, $88, $88, $00, $FF, $01, $00, $00, $01, $FF, $00

//UNKNOWN_F0F1:
//	LDA #$00
//	LDX #$10
//@UNKNOWN0:
//	ROR $61
//	ROR $60
//	BCC @UNKNOWN1
//	CLC
//	ADC $64
//@UNKNOWN1:
//	ROR
//	DEX
//	BNE @UNKNOWN0
//	STA $62
//	ROR $61
//	ROR $60
//	RTS

//UNKNOWN_F109:
//	LDA #$00
//	LDX #$18
//@UNKNOWN0:
//	ROR $62
//	ROR $61
//	ROR $60
//	BCC @UNKNOWN1
//	CLC
//	ADC $64
//@UNKNOWN1:
//	ROR
//	DEX
//	BNE @UNKNOWN0
//	STA $63
//	ROR $62
//	ROR $61
//	ROR $60
//	RTS

//UNKNOWN_F125:
//	STA $60
//	STX $64
//	LDA #$00
//	LDX #$08
//@UNKNOWN0:
//	ROR $60
//	BCC @UNKNOWN1
//	CLC
//	ADC $64
//@UNKNOWN1:
//	ROR
//	DEX
//	BNE @UNKNOWN0
//	TAX
//	LDA $60
//	ROR
//	RTS

//UNKNOWN_F13D:
//	LDA $64
//@UNKNOWN0:
//	BEQ @UNKNOWN0
//	LDA #$00
//	LDX #$18
//	ROL $60
//	ROL $61
//	ROL $62
//@UNKNOWN1:
//	ROL
//	BCS @UNKNOWN2
//	CMP $64
//	BCC @UNKNOWN3
//@UNKNOWN2:
//	SBC $64
//	SEC
//@UNKNOWN3:
//	ROL $60
//	ROL $61
//	ROL $62
//	DEX
//	BNE @UNKNOWN1
//	STA $68
//	RTS

//UNKNOWN_F161:
//	LDY #$08
//@UNKNOWN0:
//	DEY
//	LDA #$00
//	LDX #$18
//	ROL $60
//	ROL $61
//	ROL $62
//@UNKNOWN1:
//	ROL
//	CMP #$0A
//	BCC @UNKNOWN2
//	SBC #$0A
//@UNKNOWN2:
//	ROL $60
//	ROL $61
//	ROL $62
//	DEX
//	BNE @UNKNOWN1
//	TAX
//	LDA UNKNOWN_F19A,X
//	STA $0068,Y
//	LDA $60
//	ORA $61
//	ORA $62
//	BNE @UNKNOWN0
//	STY $63
//	LDA #$A0
//	BNE @UNKNOWN4
//@UNKNOWN3:
//	STA $0068,Y
//@UNKNOWN4:
//	DEY
//	BPL @UNKNOWN3
//	RTS

//UNKNOWN_F19A:
//	.BYTE $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9

//UNKNOWN_F1A4:
//	LDY #$00
//	STY $60
//	STY $61
//	STY $62
//	BEQ @UNKNOWN3
//@UNKNOWN0:
//	LDA #$00
//	LDX #$18
//@UNKNOWN1:
//	ROR $62
//	ROR $61
//	ROR $60
//	BCC @UNKNOWN2
//	ADC #$09
//@UNKNOWN2:
//	ROR
//	DEX
//	BNE @UNKNOWN1
//	ROR $62
//	ROR $61
//	ROR $60
//@UNKNOWN3:
//	LDA $0068,Y
//	CMP #$BA
//	BCS @UNKNOWN4+1
//	CMP #$B0
//	BCC @UNKNOWN4+1
//	SBC #$B0
//@UNKNOWN4:
//	BIT a:$00A9
//	CLC
//	ADC $60
//	STA $60
//	LDA #$00
//	ADC $61
//	STA $61
//	LDA #$00
//	ADC $62
//	STA $62
//	INY
//	CPY #$08
//	BCC @UNKNOWN0
//	RTS

//UNKNOWN_F1ED:
//	CLC
//	LDA $26
//	ADC $27
//	STA $27
//	CLC
//	LDA $26
//	ADC #$75
//	STA $26
//	LDA $27
//	ADC #$63
//	STA $27
//	RTS


/**
 * Original_Address: $(DOLLAR) $F202, bank $1F
 */
bool unknownF202() @safe {
//	JSR UNKNOWN_CEDA
//	JSR UNKNOWN_F239
//	JSR GetEnemyGroupPointer
//	LDX #$2C
//	LDY #$09
//	LDA ($5C),Y
//	AND #$F0
//	CMP #$50
//	BEQ @UNKNOWN0
//	LSR
//	LSR
//	LSR
//	LSR
//	TAX
//@UNKNOWN0:
//	TXA
//	JSR UNKNOWN_F255
//	JSR UNKNOWN_CEE1
//	JSR UNKNOWN_149630
//	JSR UNKNOWN_F239
//	JSR ClearSprites
//	JSR ClearTilemaps
//	JSR B31_0c65
//	JSR UNKNOWN_17A000
//	JSR UNKNOWN_ECA3
	//assert(0, "NYI");
	return false;
}

//UNKNOWN_F239:
//	PHA
//	TXA
//	PHA
//	LDA #$16
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	PLA
//	TAX
//	PLA
//	RTS

//UNKNOWN_F247:
//	PHA
//	TXA
//	PHA
//	LDA #$00
//	LDX #BANK::PRG8000
//	JSR BANK_SWAP
//	PLA
//	TAX
//	PLA
//	RTS

//UNKNOWN_F255:
//	CMP $078C
//	BEQ @UNKNOWN0
//	STA UNKNOWN_07F5
//@UNKNOWN0:
//	RTS

//UNKNOWN_F25E:
//	TXA
//	BEQ @UNKNOWN0
//	PHA
//	JSR WaitNMI
//	PLA
//	TAX
//	DEX
//	BNE UNKNOWN_F25E
//@UNKNOWN0:
//	RTS

//UNKNOWN_F26B:
//	INX
//@UNKNOWN0:
//	TXA
//	PHA
//	JSR UNKNOWN_F27C
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN0
//	JSR UNKNOWN_F27C
//	JMP UNKNOWN_F4B6

//UNKNOWN_F27C:
//	LDX #$2F
//@UNKNOWN1:
//	TXA
//	PHA
//	AND #$0F
//	LSR
//	TAX
//	LDA UNKNOWN_F296,X
//	JSR UNKNOWN_F4B8
//	JSR WaitNMI
//	JSR WaitNMI
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN1
//	RTS

//UNKNOWN_F296:
//	.BYTE $21, $22, $23, $24, $25, $24, $23, $22

//UNKNOWN_F29E:
//	LDX #$00
//	STX $DA
//@UNKNOWN0:
//	JSR WaitNMI
//	LDA $DA
//	STX $DA
//	AND #$C0
//	BEQ @UNKNOWN0
//	RTS

//UNKNOWN_F2AE:
//	ASL
//	TAY
//	INY
//	INY
//	INY
//	PLA
//	STA $60
//	PLA
//	STA $61
//	LDA ($60),Y
//	STA $62
//	INY
//	LDA ($60),Y
//	STA $63
//	LDY #$01
//	SEC
//	LDA ($60),Y
//	SBC #$01
//	TAX
//	INY
//	LDA ($60),Y
//	SBC #$00
//	PHA
//	TXA
//	PHA
//	JMP ($0062)

//UNKNOWN_F2D5:
//	ASL
//	TAY
//	INY
//	PLA
//	STA $60
//	PLA
//	STA $61
//	SEC
//	LDA ($60),Y
//	SBC #$01
//	TAX
//	INY
//	LDA ($60),Y
//	SBC #$00
//	PHA
//	TXA
//	PHA
//	RTS

//UNKNOWN_F2ED:
//	PHA
//	TXA
//	PHA
//	TYA
//	PHA
//	LDA $63
//	PHA
//	LDA $62
//	PHA
//	LDA $65
//	PHA
//	LDA $64
//	PHA
//	LDA $69
//	PHA
//	LDA $68
//	PHA
//	LDA $61
//	AND #$FC
//	PHA
//	LDX #$06
//@UNKNOWN0:
//	ASL $60
//	ROL $61
//	DEX
//	BNE @UNKNOWN0
//	STX $62
//	TXA
//	PHA
//	LDA $61
//	PHA
//	LDA $60
//	PHA
//	LDA #$64
//	STA $64
//	JSR UNKNOWN_F13D
//	JSR UNKNOWN_F1ED
//	LSR
//	PHP
//	TAX
//	LDA UNKNOWN_F37D,X
//	STA $64
//	JSR $F0F1
//	PLP
//	BCS @UNKNOWN1
//	PLA
//	ADC $60
//	STA $60
//	PLA
//	ADC $61
//	STA $61
//	PLA
//	ADC $62
//	STA $62
//	JMP $F355
//@UNKNOWN1:
//	PLA
//	SBC $60
//	STA $60
//	PLA
//	SBC $61
//	STA $61
//	PLA
//	SBC $62
//	STA $62
//	LDX #$06
//@UNKNOWN2:
//	LSR $62
//	ROR $61
//	ROR $60
//	DEX
//	BNE @UNKNOWN2
//	PLA
//	ORA $61
//	STA $61
//	PLA
//	STA $68
//	PLA
//	STA $69
//	PLA
//	STA $64
//	PLA
//	STA $65
//	PLA
//	STA $62
//	PLA
//	STA $63
//	PLA
//	TAY
//	PLA
//	TAX
//	PLA
//	RTS

//UNKNOWN_F37D:
//	.BYTE $00, $00, $00, $00, $00, $0C, $0C, $0C, $0C, $0C, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $05, $05, $05, $05, $05, $05, $05, $05, $05, $14, $06, $06, $06, $06, $06, $06, $06, $06, $06, $15, $07, $07, $07, $07, $07, $07, $07, $07, $11, $11, $08, $08, $08, $08, $08, $08, $08, $08, $12, $12, $09, $09, $09, $09, $09, $09, $09, $0F, $0F, $0F, $0A, $0A, $0A, $0A, $0A, $0A, $0D, $0D, $0D, $0D, $0B, $0B, $0B, $0B, $0B, $0B, $0E, $0E, $0E, $0E, $10, $10, $10, $13, $13, $16, $17, $18

//UNKNOWN_F3FD:
//	TAX
//	LDA $61
//	PHA
//	LDA $60
//	PHA
//	STX $60
//	LDA #$00
//	STA $61
//	JSR UNKNOWN_F2ED
//	LDA $61
//	BEQ @UNKNOWN0
//	LDA #$FF
//	STA $60
//@UNKNOWN0:
//	LDX $60
//	PLA
//	STA $60
//	PLA
//	STA $61
//	TXA
//	RTS

//UNKNOWN_F41F:
//	PHA
//	ASL
//	ASL
//	BEQ @UNKNOWN4
//	TAX
//	LDA $9EEA,X
//	STA $65
//	LDA $9EEB,X
//	STA $67
//	LDA $9EE9,X
//	CMP #$00
//	BNE @UNKNOWN0
//	LDA $65
//	STA UNKNOWN_07EF+1
//	JMP @UNKNOWN3
//@UNKNOWN0:
//	CMP #$01
//	BNE @UNKNOWN1
//	LDA $65
//	STA UNKNOWN_07EF+2
//	JMP @UNKNOWN3
//@UNKNOWN1:
//	CMP #$02
//	BNE @UNKNOWN2
//	LDA $65
//	STA UNKNOWN_07EF+4
//	JMP @UNKNOWN3
//@UNKNOWN2:
//	LDA $65
//	STA UNKNOWN_07EF+5
//@UNKNOWN3:
//	LDX $67
//	JSR UNKNOWN_F25E
//	JSR UNKNOWN_F239
//@UNKNOWN4:
//	PLA
//	RTS

//ErrBuzzer:
//	LDX #$0F
//@UNKNOWN0:
//	TXA
//	PHA
//	LDA #$05
//	STA UNKNOWN_07EF+2
//	LDX #$02
//	JSR UNKNOWN_F25E
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN0
//	RTS

//GetEnemyGroupPointer:
//	LDA $48
//	STA $60
//	LDA #$00
//	STA $61
//	LDA #$0A
//	STA $64
//	JSR $F0F1
//	CLC
//	LDA #$98
//	ADC $60
//	STA $5C
//	LDA #$8F
//	ADC $61
//	STA $5D
//	RTS

void LoadPaletteFrom(ubyte[] palette) @safe {
	PpuSync();

	for(ubyte i = 0x1f; i != 0xff; i--){
		palette_queue[i] = palette[i];
	}
	//fallthrough
	QueuePaletteUpdate();
}

void QueuePaletteUpdate() @safe {
	nmi_queue[0] = NMI_COMMANDS.UPDATE_PALETTE;
	nmi_queue[1] = 0;
	nmi_data_offset = 0;
	new_animation_timer = 0x80;
}

//UNKNOWN_F4B6:
//	LDA #$0F
//UNKNOWN_F4B8:
//	PHA
//	JSR PpuSync
//	PLA
//	LDY #$1C
//@UNKNOWN0:
//	STA $0500,Y
//	DEY
//	DEY
//	DEY
//	DEY
//	BPL @UNKNOWN0
//	JSR UNKNOWN_F4A3
//	JMP WaitNMI

//UNKNOWN_F4CE:
//	ASL
//	STA $60
//	TXA
//	PHA
//	TYA
//	PHA
//	JSR UNKNOWN_F247
//	LDY $60
//	LDA $8C00,Y
//	STA $60
//	LDA $8C01,Y
//	STA $61
//	LDY #$00
//	LDA ($60),Y
//	STA $66
//	INY
//	LDX $76
//	LDA ($60),Y
//	CMP #$FF
//	BEQ @UNKNOWN1
//	TAX
//@UNKNOWN1:
//	STX $62
//	INY
//	LDX $77
//	LDA ($60),Y
//	CMP #$FF
//	BEQ @UNKNOWN2
//	TAX
//@UNKNOWN2:
//	STX $63
//UNKNOWN_F502:
//	INY
//	LDA ($60),Y
//	LDX #$00
//	CMP #$FC
//	BEQ @UNKNOWN3
//	LDX #$01
//	CMP #$FD
//	BEQ @UNKNOWN3
//	LDX #$02
//	CMP #$FE
//	BEQ @UNKNOWN3
//	CMP #$FF
//	BEQ @UNKNOWN4
//	JSR UNKNOWN_F52E
//	JMP UNKNOWN_F502
//@UNKNOWN3:
//	STX $67
//	JMP UNKNOWN_F502
//@UNKNOWN4:
//	JSR UNKNOWN_F239
//	PLA
//	TAY
//	PLA
//	TAX
//	RTS

//UNKNOWN_F52E:
//	TAX
//	INY
//	LDA ($60),Y
//	STA $64
//	INY
//	LDA ($60),Y
//	STA $65
//@UNKNOWN0:
//	TXA
//	PHA
//	TYA
//	PHA
//	JSR PpuSync
//	LDA #$00
//	STA $70
//	LDA $62
//	STA $76
//	LDA $64
//	STA $74
//	LDA $65
//	STA $75
//	JSR UNKNOWN_F562
//	CLC
//	LDA $63
//	ADC $66
//	STA $63
//	PLA
//	TAY
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN0
//	RTS

//UNKNOWN_F562:
//	LDA $61
//	PHA
//	LDA $60
//	PHA
//	LDA $62
//	PHA
//	LDA $65
//	PHA
//	LDA $64
//	PHA
//	LDA $67
//	PHA
//	LDA $66
//	PHA
//	LDA $67
//	BEQ @UNKNOWN0
//	CMP #$01
//	BEQ @UNKNOWN1
//	LDA $63
//	STA $77
//	PHA
//	JSR DrawTilepack
//	PLA
//	STA $63
//	JMP @UNKNOWN2
//@UNKNOWN0:
//	CLC
//	LDA $63
//	ADC $66
//	STA $77
//	PHA
//	JSR UNKNOWN_C707
//	PLA
//	STA $63
//	JMP @UNKNOWN2
//@UNKNOWN1:
//	CLC
//	LDA $63
//	ADC $66
//	STA $77
//	PHA
//	JSR DrawTilepackClear
//	PLA
//	STA $63
//@UNKNOWN2:
//	PLA
//	STA $66
//	PLA
//	STA $67
//	PLA
//	STA $64
//	PLA
//	STA $65
//	PLA
//	STA $62
//	PLA
//	STA $60
//	PLA
//	STA $61
//	RTS

//UNKNOWN_F5C2:
//	LDA $5A
//	PHA
//	JSR UNKNOWN_F765
//	LDA #$DF
//	STA $84
//	LDA #$F5
//	STA $85
//	LDA #$DF
//	STA $80
//	LDA #$F5
//	STA $81
//	JSR UNKNOWN_EF4B
//	PLA
//	STA $5A
//	RTS

//UNKNOWN_F5DF:
//	.BYTE $01, $01, $00, $00, $C0, $5D

//UNKNOWN_F5E5:
//	PHA
//	TXA
//	PHA
//	TYA
//	PHA
//	JSR UNKNOWN_C406
//	JSR UNKNOWN_F614
//	PLA
//	TAY
//	PLA
//	TAX
//	PLA
//	SEC
//	RTS

//UNKNOWN_F5F7:
//	STA $62
//	LDA #$00
//	ASL $62
//	ROL
//	ASL $62
//	ROL
//	ASL $62
//	ROL
//	STA $63
//	CLC
//	LDA $62
//	ADC #$00
//	STA $62
//	LDA $63
//	ADC #$9E
//	STA $63
//	RTS

//UNKNOWN_F614:
//	JSR PpuSync
//	LDY #$E8
//	STY $68
//	LDA #$DF
//	STA $69
//	LDY $6707
//@UNKNOWN0:
//	SEC
//	LDA $69
//	SBC #$10
//	STA $69
//	DEY
//	BNE @UNKNOWN0
//	LDA #$00
//	STA $66
//@UNKNOWN1:
//	JSR PpuSync
//	LDY $66
//	LDA $0600,Y
//	BEQ @UNKNOWN3
//	LDA $0611,Y
//	AND #$06
//	EOR #$06
//	BEQ @UNKNOWN3
//	LDX #$02
//	LDA $0601,Y
//	AND #$80
//	BNE @UNKNOWN2
//	LDX #$01
//	JSR UNKNOWN_F673
//	BCC @UNKNOWN2
//	LDX #$00
//@UNKNOWN2:
//	TXA
//	JSR UNKNOWN_F6AA
//	CLC
//	LDA $68
//	ADC #$08
//	STA $68
//@UNKNOWN3:
//	CLC
//	LDA $69
//	ADC #$10
//	STA $69
//	CLC
//	LDA $66
//	ADC #$20
//	STA $66
//	CMP #$60
//	BNE @UNKNOWN1
//	RTS

//UNKNOWN_F673:
//	TYA
//	PHA
//	LDA $0618,Y
//	STA $60
//	LDA $0619,Y
//	STA $61
//	LDA $0603,Y
//	STA $64
//	LDA $0604,Y
//	STA $65
//	LDY #$03
//	LDA ($60),Y
//	STA $62
//	INY
//	LDA ($60),Y
//	AND #$03
//	STA $63
//	LSR $63
//	ROR $62
//	LSR $63
//	ROR $62
//	PLA
//	TAY
//	SEC
//	LDA $64
//	SBC $62
//	LDA $65
//	SBC $63
//	RTS

//UNKNOWN_F6AA:
//	PHA
//	JSR PpuSync
//	PLA
//	JSR UNKNOWN_F2AE
//	TSX
//	INC $BF,X
//	INC $C8,X
//	INC $F0,X
//	INC $A9,X
//	ORA ($85,X)
//	SBC $60
//	LDA #$00
//	LDX #$0C
//	LDY #$97
//	JMP UNKNOWN_F6F9
//	LDX $68
//	LDA $0300,X
//	PHA
//	LDA #$03
//	LDX #$0C
//	LDY #$97
//	JSR UNKNOWN_F6F9
//	PLA
//	CMP #$03
//	BEQ @UNKNOWN1
//	LDX #$04
//@UNKNOWN0:
//	TXA
//	PHA
//	LDA #$00
//	JSR UNKNOWN_F724
//	LDA #$03
//	JSR UNKNOWN_F724
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN0
//@UNKNOWN1:
//	RTS

//UNKNOWN_F6F0:
//	LDA #$03
//	LDX #$10
//	LDY #$97
//	JMP UNKNOWN_F6F9
//UNKNOWN_F6F9:
//	STX $60
//	STY $61
//	LDX $68
//	STA $0300,X
//	LDA #$08
//	STA $0301,X
//	LDA #$70
//	STA $0302,X
//	LDA $69
//	STA $0303,X
//	LDA #$00
//	STA $0304,X
//	STA $0305,X
//	LDA $60
//	STA $0306,X
//	LDA $61
//	STA $0307,X
//	RTS

//UNKNOWN_F724:
//	LDX $68
//	STA $0300,X
//	LDA #$01
//	STA $E5
//	LDX #$08
//	JMP UNKNOWN_F25E

void fill_nmi_with_pointer_data(ubyte[] addr) @safe {
	PpuSync();
	/* CANNOT USE: OOB
	for (ubyte count = 0x1f; count != 0xff; count--){
		nmi_queue[count] = addr[count];
	}*/
	for (ubyte i = 0; i < addr.length; i++){
		nmi_queue[i] = addr[i];
	}
	new_animation_timer = 0x80;
	nmi_data_offset = 0;
}

//UNKNOWN_F74C:
//	LDA #$6A
//	STA $D8
//	LDA #$F7
//	STA $D9
//	LDA #$4C
//	STA $D7
//	RTS

//UNKNOWN_F759:
//	LDA #$00
//	STA $D7
//	JMP WaitNMI

//UNKNOWN_F760:
//	LDA #$01
//	STA $5A
//	RTS

//UNKNOWN_F765:
//	LDA #$00
//	STA $5A
//	RTS

//UNKNOWN_F76A:
//	LDA $5A
//	BEQ @UNKNOWN0
//	JSR UNKNOWN_F772
//@UNKNOWN0:
//	RTS

//UNKNOWN_F772:
//	LDA $59
//	BEQ @UNKNOWN0
//	BIT $E2
//	BVS @UNKNOWN0
//	LDX #$00
//	LDA $DA
//	STX $DA
//	AND #$40
//	BEQ @UNKNOWN0
//	TXA
//	STA $59
//	STA $03E0
//	LDA $03E1
//	ASL
//	ASL
//	TAY
//	LDA #$F0
//	STA $0200,Y
//	STA $0204,Y
//	STA $0208,Y
//	STA $020C,Y
//@UNKNOWN0:
//	RTS

/**
 * Original_Address: $(DOLLAR) $F79F, bank $1F
 */
void NmiHandler() @safe {
	if (nmi_mode & 0x80){
		return;
	}
	//nes.OAMADDR = 0;
	//nes.OAMDMA = 2;
	nes.handleOAMDMA(shadow_oam, 0);

	nmi_y = nmi_data_offset;

	if (current_animation_timer != 0){
		if (new_animation_timer != 0) {
			goto NMI_ProcessCommands;
		} else {
			goto NMI_Schedule_IRQs;
		}
	} else {
		if (new_animation_timer != 0) {
			current_animation_timer = new_animation_timer & 0x7f;
			goto NMI_ProcessCommands;
		} else {
			goto NMI_Schedule_IRQs;
		}
	}

NMI_ProcessCommands:
	if (nmi_queue[nmi_y] == 0){
		//not technically right but you can only have a be 0
		//so whatever lol
		new_animation_timer = 0;
	} else if (nmi_queue[nmi_y] & 0x80){
		nmi_queue[nmi_y] &= 0x7f;
	} else {
		switch (nmi_queue[nmi_y]) {
			case NMI_COMMANDS.SKIP:
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.NOTHING:
				NMI_Nothing();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.BRANCH:
				NMI_Branch();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.GOTO:
				NMI_Goto();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.UPDATE_PALETTE:
				NMI_UpdatePalette();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.PPU_WRITE:
				NMI_PPUWrite();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.PPU_WRITE_32:
				NMI_PPUWrite32();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.PPU_WRITE_ADDRS:
				NMI_PPUWriteAddrs();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.PPU_WRITE_BYTE:
				NMI_PPUWriteByte();
				goto NMI_ProcessCommands;
			case NMI_COMMANDS.PPU_READ:
				NMI_PPURead();
				goto NMI_ProcessCommands;
			//version(original){
			//} else {
			case NMI_COMMANDS.PPU_READ_TEXT:
				NMI_PPUReadText();
				goto NMI_ProcessCommands;
			//}
			default:
				return;
		}
	}


NMI_Schedule_IRQs:
	if (irq_count != 0){
		//mmc3
		//nes.IRQLATCH = 0xff;
		//nes.IRQRELOAD = 0xff;
		nes.PPUADDR = 0;
		nes.PPUADDR = 0;
		nes.PPUADDR = 0x10;
		nes.PPUADDR = 0x10;
		nes.PPUADDR = 0;
		nes.PPUADDR = 0;
		nes.PPUADDR = 0x10;
		nes.PPUADDR = 0x10;
		nes.PPUADDR = 0;
		nes.PPUADDR = 0;
		//mmc3
		//nes.IRQLATCH = irq_count;
		//nes.IRQRELOAD = irq_count;
		//nes.IRQENABLE = irq_count;
		irq_latch = irq_count;
		irq_index = 0;
		nes.interruptsEnabled = true;
	}
	nes.PPUSCROLL = scroll_x;
	nes.PPUSCROLL = scroll_y;

	nes.PPUCTRL = ram_PPUCTRL;
	nes.PPUMASK = ram_PPUMASK;

	nmi_data_offset = nmi_y;

	nmi_mode = 0x80;

	ubyte old_bankswitch_mode = bankswitch_mode;
	ubyte old_prg_lo = current_banks[6];
	ubyte old_prg_hi = current_banks[7];

	//version(original){
	//} else {
		if (melody_timer != 0){
			bankSwap(((melody_timer >> 1) & 3) | 0x44, MMC3Bank.chr1000);
			bankSwap(((melody_timer >> 1) & 3) | 0x44, MMC3Bank.chr1400);
			melody_timer--;
		}
	//}

	BankswitchMusic();
	Music_Tick();

	if ((oam_and_300_clear_flag & 0x80) == 0){
		frameskip_this_frame = UNK_E7 & 0x3f;
		if (current_animation_timer == 0){
			FlickerSpritesInSet2();
		} else {
			if ((current_animation_timer - frameskip_this_frame) -1 < 0){
				frameskip_this_frame = (current_animation_timer - 1) & 0xff;
				current_animation_timer = 0;
			} else {
				current_animation_timer -= frameskip_this_frame + 1;
			}
			SpriteObjectsToOam();
		}
	}
	bankSwap(old_prg_hi, MMC3Bank.prgA000);
	bankSwap(old_prg_lo, MMC3Bank.prg8000);

	bankswitch_mode = old_bankswitch_mode;
	//mmc3
	//nes.BANKSELECT = bankswitch_mode | bankswitch_flags;

	ReadPads();

	pad1_forced |= pad1_press;
	pad2_forced |= pad2_press;

	//TickDadCallTimer();

	if (post_nmi_callback != null){
		post_nmi_callback();
	}

	nmi_mode = 0;
}

void NMI_Nothing() @safe {
	nmi_y++;
}

void NMI_Branch() @safe {
	nmi_y++;
	nmi_y += nmi_queue[nmi_y];
}

void NMI_Goto() @safe {
	nmi_y++;
	nmi_y = nmi_queue[nmi_y];
}

void NMI_UpdatePalette() @safe {
	nes.PPUADDR = 0x3F00 >> 8;
	nes.PPUADDR = (0x3F00) & 0xff;

	for (ubyte i = 0; i < 0x20; i++){
		nes.PPUDATA = palette_queue[i];
	}

	nes.PPUADDR = 0x3F00 >> 8;
	nes.PPUADDR = (0x3F00) & 0xff;

	nes.PPUADDR = 0;
	nes.PPUADDR = 0;

	nmi_y++;
}

void NMI_PPUWrite() @safe {
	do {
		NMI_WritePPUBytes();
	} while (nmi_queue[nmi_y] == NMI_COMMANDS.PPU_WRITE);
}

void NMI_PPUWrite32() @safe {
	nes.PPUCTRL = ram_PPUCTRL | 4;
	do {
		NMI_WritePPUBytes();
	} while (nmi_queue[nmi_y] == NMI_COMMANDS.PPU_WRITE_32);
	nes.PPUCTRL = ram_PPUCTRL;
}

void NMI_PPUWriteAddrs() @safe {
	nmi_y++;
	ubyte x = nmi_queue[nmi_y];
	nmi_y++;
	while (x > 0){
		nes.PPUADDR = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUADDR = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		x--;
	}
}

void NMI_PPUWriteByte() @safe {
	nmi_y++;
	ubyte x = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	ubyte a = nmi_queue[nmi_y];
	nmi_y++;
	while (x > 0){
		nes.PPUDATA = a;
		x--;
	}
}

void NMI_PPURead() @safe {
	nmi_y++;
	ubyte x = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	ubyte a = nes.PPUDATA;
	while (x > 0){
		nmi_queue[nmi_y] = nes.PPUDATA;
		nmi_y++;
		x--;
	}
}

//version(original){
//} else {
void NMI_PPUReadText() @safe {
	ubyte old_bankswitch_mode = bankswitch_mode;
	ubyte old_tileset1 = current_banks[4];
	ubyte old_tileset2 = current_banks[5];
	nmi_y++;
	bankSwap(nmi_queue[nmi_y], MMC3Bank.chr1800);
	bankSwap(cast(ubyte)(nmi_queue[nmi_y]+1), MMC3Bank.chr1c00);

	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;

	ubyte a = nes.PPUDATA;
	for (ubyte i = 0; i < text_data_buffer.length; i++){
		text_data_buffer[i] = nes.PPUDATA;
	}
	bankSwap(old_tileset2, MMC3Bank.chr1c00);
	bankSwap(old_tileset1, MMC3Bank.chr1800);
	bankswitch_mode = old_bankswitch_mode;
	//mmc3
	//nes.BANKSELECT = bankswitch_flags | bankswitch_mode;
}
//}

void NMI_WritePPUBytes() @safe {
	nmi_y++;
	UNK_C0[3] = nmi_queue[nmi_y];

	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;
	nes.PPUADDR = nmi_queue[nmi_y];
	nmi_y++;

	if (UNK_C0[3] & 1){
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
	}
	UNK_C0[3] >>= 1;
	if (UNK_C0[3] & 1){
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
	}
	UNK_C0[3] >>= 1;
	if (UNK_C0[3] & 1){
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
	}
	UNK_C0[3] >>= 1;
	while (UNK_C0[3] > 0){
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		nes.PPUDATA = nmi_queue[nmi_y];
		nmi_y++;
		UNK_C0[3]--;
	}
	return;
}

ubyte obj_count; //UNK_C0
void SpriteObjectsToOam() @safe {
	ubyte temp_oamslot; //UNK_C0+1
	ubyte spritetiles_attr; //UNK_C0+1
	ubyte oam_offset_scratch; //UNK_C0+2
	ubyte spritedef_base_tile; //UNK_C0+2
	ubyte spritedef_palettes; //UNK_C0+3
	SpriteTile[] spritetiles_pointer; //UNK_C0+4
	SpritePointerDef* spritedef_pointer; //UNK_C0+6
	ubyte wip_velx; //UNK_C0+8
	ubyte wip_value_x2; //UNK_C0+9
	ubyte wip_vely; //UNK_C0+10
	ubyte wip_value_y2; //UNK_C0+11
	ubyte current_sprite; //UNK_C0+12
	ubyte adder; //UNK_C0+13
	ubyte UNK_CE; //UNK_C0+14
	ubyte UNK_CF; //UNK_C0+15

	ubyte temp_a = 0;
	ubyte temp_y = 0;
	int full_num = 0;

    //swap to the sprite bank
	bankSwap(0x15, MMC3Bank.prg8000);

    UNK_CE = 0;
    UNK_CF = 0;

    //x = frameskip_this_frame
	ubyte temp_x = frameskip_this_frame;

    //if UNK_E7 & 0x40, then...
	if (UNK_E7 & 0x40){
		// The camera is in shake mode. shift_x and shift_y together form a 16-bit pointer
		// to a list of value pairs to add up.
		// Iterate through all frameskip_this_frame+1 value pairs of the list and add them up,
		// and put the results in UNK_CE and UNK_CF

		//TODO:... what? how? when?
		//prove this is used and then we can talk about implementing it
		// while(temp_x > 0x7F;){
		// 	clc
		// 	lda (shift_x), y
		// 	adc UNK_CE
		// 	sta UNK_CE
		// 	iny
		// 	clc
		// 	lda (shift_x), y
		// 	adc UNK_CF
		// 	sta UNK_CF
		// 	temp_y++;
		// 	temp_x--;
		// }
		// ; update shift_x to point to just after what we read and summed
		// clc
		// tya
		// adc shift_x
		// sta shift_x
		// lda #0
		// adc shift_y
		// sta shift_y
	} else {
		// otherwise, if (UNK_E7 & 0x40) == 0, the camera is in plain old velocity mode.
		// shift_x and shift_y are 8-bit constants.
		// Multiply them by frameskip_this_frame+1, and put the results in UNK_CE and UNK_CF
		while(temp_x != 0xFF){
			UNK_CE += shift_x;
			UNK_CF += shift_y;
			temp_x--;
		}
	}

	int scroll_mod = UNK_CE + scroll_x;
	bool ninth_bit = scroll_mod > 0xff;
    // if UNK_CE is non-negative...
	if (UNK_CE < 0x80){
		// then move scroll_x right by that much
		//and update PPUCTRL appropriately if that overflows into the "9th bit" of scrolling position
		if (ninth_bit){
			goto x_nametable_bit_wrong;
		}
	} else {
		// Otherwise, if we're scrolling left, the carry conditions are flipped.
		// If scroll_x is $ff and we move the scrolling position by -1, that will set carry,
		// because the result of the addition is 0xFF + 0xFF == 0x1FE.
		// If scroll_x is $00 and we move the scrolling position by -1, that won't set carry,
		// because the result of the addition is 0 + 0xFF == 0x0FF.
		// So we only change screens when the carry flag is clear
		if (!ninth_bit){
			x_nametable_bit_wrong:
			//flip base nametable addr
			ram_PPUCTRL ^= 1;
		}
	}
	scroll_x = cast(ubyte) scroll_mod;


	scroll_mod = UNK_CF + scroll_y;
	ninth_bit = scroll_mod > 0xff;
    // For scroll_y, we don't care about changing screens, but we do need to handle overflow
    // specially, because the height of the screen is 240 and our addition is mod 256.
	if (UNK_CF < 0x80){
		// UNK_CF is non-negative, so we're scrolling downward.
		// Set A to the correct value if an overflow past the height of the screen occurred,
		// and set carry to whether the overflow occurred.
		// (This first addition can never overflow and set the carry bit. UNK_CF is at most 0x7F.)

		scroll_mod += 0x10;
		ninth_bit = scroll_mod > 0xff;
		if (!ninth_bit){
			goto scroll_y_wrong;
		}
	} else {
		// UNK_CF is negative, so we're scrolling upward.
		// Set A to the correct value if an overflow past the height of the screen did *not* occur,
		// and set carry if no overflow occurred.
		// If scroll_y = 0 and UNK_CF = -1, carry will not be set (0 + 0xFF == 0x0FF)
		// If scroll_y = 1 and UNK_CF = -1, carry will be set (1 + 0xFF == 0x100)
		if (!ninth_bit){
			scroll_y_wrong:
			// The correction for both the up and down cases is the same.
			scroll_mod += 0xf0;
		}
	}
	scroll_y = cast(ubyte) scroll_mod;

    // Clear oam_and_300_clear_flag.6 and oam_and_300_clear_flag.7 to 0
    // Flip oam_and_300_clear_flag.5 too?
	oam_and_300_clear_flag &= 0x3f;
	oam_and_300_clear_flag ^= 0x20;

    //this is the current SPRITE_OBJECT
    current_sprite = 0;
    oam_set2_start = 0;

    //this is how much current_sprite will increment by
    adder = 8;

    // Reserve the first 4 sprites in OAM for system stuff
    temp_x = 4*4;
WriteSPRObjectsToOam:
    // Does this object has a nonzero number of sprites?
    temp_y = current_sprite;
    //lda SPRITE_OBJECTS+SpriteObject::count_flags, y
	temp_a = SPRITE_OBJECTS[temp_y/8].count_flags & SPRITE_OBJECT_COUNT_MASK;
    //if it is nonzero, process all of the hardware sprites
	if (temp_a == 0){
		//else, jump
		goto spriteobject_handled;
	}

    //obj_count = number of OBJs
    obj_count = temp_a;

    //oam_offset_scratch = x
    oam_offset_scratch = temp_x;

    // Replace this SpriteObject's OAM slot with the correct index, preserving flags in the upper bytes
    temp_a = SPRITE_OBJECTS[temp_y/8].oam_slot_flags;
    temp_a &= 0xC0;
    temp_oamslot = temp_a;
	temp_a = temp_x;
	temp_a >>= 2;
    temp_a |= temp_oamslot;
	SPRITE_OBJECTS[temp_y/8].oam_slot_flags = temp_a;

    wip_velx = cast(ubyte) -UNK_CE;
    wip_vely = cast(ubyte) -UNK_CF;

    temp_x = frameskip_this_frame;
    //if oam_slot & SPRITE_OBJECT_SHAKE_ENABLED, handle shaking
	if (temp_oamslot & SPRITE_OBJECT_SHAKE_ENABLED){
		//im gonna be so honest ill worry about this later.
		//i hate pointer math in compiled langauges
	// 	//get (shake) pointer to c4
	// 	lda SPRITE_OBJECTS+SpriteObject::shake_ptr, y
	// 	sta spritetiles_pointer
	// 	lda SPRITE_OBJECTS+SpriteObject::shake_ptr+1, y
	// 	sta spritetiles_pointer+1

	// 	ldy #0
	// @shake_loop_probably:
	// 	//wip_velx += spritetiles_pointer[y]
	// 	clc
	// 	lda (spritetiles_pointer), y
	// 	adc wip_velx
	// 	sta wip_velx
	// 	iny

	// 	//wip_vely += spritetiles_pointer[y]
	// 	clc
	// 	lda (spritetiles_pointer), y
	// 	adc wip_vely
	// 	sta wip_vely
	// 	iny

	// 	// Do this frameskip_this_frame+1 times
	// 	dex
	// 	bpl @shake_loop_probably

	// 	//add new y to SPRITE_OBJECTS[y].shakepointer
	// 	//this updates the pointer for next shake
	// 	clc
	// 	tya
	// 	adc spritetiles_pointer
	// 	ldy current_sprite
	// 	sta SPRITE_OBJECTS+SpriteObject::shake_ptr, y
	// 	lda #0
	// 	adc spritetiles_pointer+1
	// 	sta SPRITE_OBJECTS+SpriteObject::shake_ptr+1, y
	} else {
		while(temp_x != 0xff){
			wip_velx += SPRITE_OBJECTS[temp_y/8].velocity.x;
			wip_vely += SPRITE_OBJECTS[temp_y/8].velocity.y;
			temp_x--;
		}
	}

    // Restore X to its old value, we're done using it for loop counters
    temp_x = oam_offset_scratch;

    // if the total X velocity is positive or 0...
    temp_a = wip_velx;
	full_num = temp_a + SPRITE_OBJECTS[temp_y/8].position.x;
	ninth_bit = full_num > 0xff;
	if (temp_a < 0x80){
		// then, after we add this velocity to the sprite's position...
		// (and set wip_velx to the sprite's new X position)
		wip_velx = cast(ubyte) full_num;
		SPRITE_OBJECTS[temp_y/8].position.x = wip_velx;

		// the carry flag will be set if we overflowed the position out of the [0, 255] range
		if (ninth_bit){
			goto x_pos_wrong;
		}
	} else {
		// otherwise, if the total X velocity is negative,
		// then after we add this velocity to the sprite's position...
		// (and set wip_velx to the sprite's new X position)
		wip_velx = cast(ubyte) full_num;
		SPRITE_OBJECTS[temp_y/8].position.x = wip_velx;

		// the carry flag will be clear if we overflowed the position out of the [0, 255] range
		// (see previous bcc/bcs pairs for a worked example of the math)
		if (!ninth_bit){
			x_pos_wrong:
			// When the X position of the sprite object overflows, that means it's gone
			// from off-screen to on-screen, or vice versa.
			SPRITE_OBJECTS[temp_y/8].count_flags ^= SPRITE_OBJECT_OFFSCREEN_X_DIR;
		}
	}

    temp_a = wip_vely;
	full_num = temp_a + SPRITE_OBJECTS[temp_y/8].position.y;
	ninth_bit = full_num > 0xff;
	if (temp_a < 0x80){
    	// Y velocity is non-negative
		wip_vely = cast(ubyte) full_num;
		SPRITE_OBJECTS[temp_y/8].position.y = wip_vely;

    	// Carry clear means no overflow
		if (ninth_bit){
			goto y_pos_wrong;
		}
	} else {
    	// Y velocity is negative
		wip_vely = cast(ubyte) full_num;
		SPRITE_OBJECTS[temp_y/8].position.y = wip_vely;

    	// Carry set means no overflow
		if (!ninth_bit){
			y_pos_wrong:
    		// When the Y position of the sprite object overflows, that means it's gone
    		// from off-screen to on-screen, or vice versa.
			SPRITE_OBJECTS[temp_y/8].count_flags ^= SPRITE_OBJECT_OFFSCREEN_Y_DIR;
		}
	}

    // Isolate the "off-screen" conditions we just set
    wip_value_x2 = SPRITE_OBJECTS[temp_y/8].count_flags & SPRITE_OBJECT_OFFSCREEN_X_DIR;
    wip_value_y2 = SPRITE_OBJECTS[temp_y/8].oam_slot_flags & SPRITE_OBJECT_OFFSCREEN_Y_DIR;

    // Copy the sprite definition pointer, so that we can read through the sprite def
    spritedef_pointer = SPRITE_OBJECTS[temp_y/8].spriteDef;

    // First in the sprite def is the pointer to the sprite arrangement data
    spritetiles_pointer = *spritedef_pointer.pointer;

    // Then the ID of the sprite def's base tile ID, if any
    spritedef_base_tile = spritedef_pointer.base_tile_id;

    // Then information about palettes
    spritedef_palettes = cast(ubyte) ((spritedef_pointer.p1 << 6) |
	(spritedef_pointer.p2 << 4) |
	(spritedef_pointer.p3 << 2) |
	spritedef_pointer.p4);

    // Render out the sprite arrangements/spriteTile info to shadow OAM
    temp_y = 0;
	render_one_oam_entry:
    // First is the X position of the current sprite in the arrangement.
    // Set the OAM entry's X position based on the base position of the sprite
    // and the relative position in the spriteTile entry
	full_num = spritetiles_pointer[temp_y/4].position.x + wip_velx;
    temp_a = cast(ubyte) full_num;
    temp_y++;
    shadow_oam[temp_x/4].x = temp_a;
    // The last addition may have overflowed, changing whether or not that OAM entry
    // is off-screen or not.
    // Combine this with the 9th bit of the X position/previously calculated off-screen info,
    // to get off-screen info for this specific OAM entry
	ninth_bit = full_num > 0xff;
    temp_a = ((full_num & 0x100) >> 1) | (temp_a >> 1);
    temp_a ^= wip_value_x2;
	if (ninth_bit){
		goto is_offscreen;
	}

    // Next is the Y position of the current sprite in the arrangement.
    // Handle it similar to X position
	full_num = spritetiles_pointer[temp_y/4].position.y + wip_vely;
    temp_a = cast(ubyte) full_num;
    shadow_oam[temp_x/4].y = temp_a;
    // including the overflow/off-screen/9th-position-bit handling... but with an extra twist
	ninth_bit = full_num > 0xff;
    temp_a = ((full_num & 0x100) >> 1) | (temp_a >> 1);
    temp_a ^= wip_value_y2;
    // if the 9th bit of the position of the OAM entry is clear...
	if (ninth_bit){
		goto B31_1c1b;
	}
    // ...and the OAM entry's Y position is less than 0x1E0 (???), then the sprite is on-screen
    // XXX: Was there supposed to be a ROL after the BMI to restore the original low 8 bits?
    // Or, better yet, replacing the BMI with ROL BCS?
    // Checking that the OAM Y position is less than 240 makes sense, but I don't get this...
    // There are no real consequences to getting this wrong though, just extra CPU time)
	if (temp_a < 0xf0){
    	goto do_normal_spritetile;
	}
    // Otherwise, if bit 9 of the Y position is clear and the sprite's Y position is >= 0x1E0,
    // then it's off-screen
    goto is_offscreen;

	B31_1c1b:
    // Otherwise, if the 9th bit of the Y position of the OAM entry is set,
    // and the Y position is >= 0x1F2 (???), then the sprite is on-screen
    // XXX: This branch also seems affected by the "missing ROL"/bad branch condition
    // that doesn't restore A's value to be the original low 8 bits of the Y position?
    // Checking that the OAM Y position is >= 0x1F9 / -7 would make more conceptual sense... but,
    // the NES doesn't have a way to show sprites partially off the top of the screen anyway
	if (temp_a >= 0xf9){
    	goto do_normal_spritetile;
	}
    // Otherwise, the OAM entry is off-screen
	is_offscreen:
    // If the sprite is off-screen, we don't have to render it,
    // so skip the Y position and remaining 2 bytes.
    // We don't increment the offset into shadow OAM in this case.
    temp_y++;
    temp_y++;
    temp_y++;
    goto spritetile_handled;

	do_normal_spritetile:
    // We need to use the last two bytes of the spriteTile macro in order to render it.
    // First is the byte with sprite attribute info
    temp_y++;
	temp_a = cast(ubyte) ((spritetiles_pointer[temp_y/4].flipY << 7) |
	(spritetiles_pointer[temp_y/4].flipX << 6) |
	(spritetiles_pointer[temp_y/4].priority << 5) |
	((spritetiles_pointer[temp_y/4].tile_id_is_relative << 2) << 2) |
	spritetiles_pointer[temp_y/4].palette);

    spritetiles_attr = temp_a;

    // From here, we load all the palettes that this spritedef elected to use into A...
    temp_a = spritedef_palettes;
    // ...and select one of the palettes by shifting right by the attr palette * 2,
    // We do a form of long multiplication to accomplish that, by modifying spritetiles_attr
    // First, the 1's digit. If it's a 1, shift right by 1*2=2
	ninth_bit = spritetiles_attr & 1;
    spritetiles_attr >>= 1;
	if (ninth_bit){
		temp_a >>= 2;
	}
    // Then, the 2's digit. If it's a 1, shift right by 2*2=4
	ninth_bit = spritetiles_attr & 1;
    spritetiles_attr >>= 1;
	if (ninth_bit){
		temp_a >>= 4;
	}

    // Isolate the ID of the chosen palette
	temp_a &= 3;

    // now that the palette choosing is done, restore the original value of spritetiles_attr,
    // with the palette index cleared out...
    spritetiles_attr <<= 2;

    // and then OR in the actual chosen palette ID
    temp_a |= spritetiles_attr;

    // And that's the OAM attribute done... almost. There's only one more thing
    shadow_oam[temp_x/4].attributes = temp_a;

    temp_y++;
    // We have two ways of describing tile IDs (global in a CHR page, and relative to a base tile)
    // Which method to use is determined by the unused bit 4 of the attribute byte
    // If the BEQ here is taken, then a tile ID of 0 is used for the base tile ID.
    temp_a &= 0x10;
	if (temp_a != 0){
    	temp_a = spritedef_base_tile;
	}
	temp_a += spritetiles_pointer[temp_y/4].id;
    shadow_oam[temp_x/4].index = temp_a;

    // We've gotten through the entire spriteTile / OAM entry
    temp_y++;

    // We've put a valid sprite in OAM
    temp_x++;
    temp_x++;
    temp_x++;
    temp_x++;

    // If we've used every available sprite index in OAM, then our work is done
	if (temp_x == 0){
		return;
	}
    // otherwise...
	spritetile_handled:
    // if there are any more OBJs to potentially draw, try drawing them
    obj_count--;
	if (obj_count != 0){
		goto render_one_oam_entry;
	}
    // otherwise, we're done with this SpriteObject
	spriteobject_handled:
    // Let's move on to the next SpriteObject
    // If we're progressing forwards through the SpriteObject array...
    temp_a = adder;
	if (temp_a > 0x7f){
		goto progressing_backwards;
	}
    // then, after advancing to the next SpriteObject...
	temp_a += current_sprite;
    current_sprite = temp_a;
    // ...end if we've made it to the end of the SpriteObject page
	if (temp_a == 0){
		temp_x = ClearOam(temp_x);
		return;
	}
    //.assert <SPRITE_OBJECTS_END = 0, error, "SpriteObject rendering assumes SPRITE_OBJECTS ends at a page boundary"
    // Otherwise, if we're progressing forwards through the array and we've hit the
    // beginning of the second set of SpriteObjects, begin iterating backwards through them
	if (temp_a == sprite_object_set2_start){
		goto begin_second_half_of_sprite_objects;
	}
    // Otherwise, continue the loop
	goto WriteSPRObjectsToOam;

	progressing_backwards:
    // If we're progressing backwards, through the second set of SpriteObjects,
    // then, after advancing to the "previous" SpriteObject...
	temp_a += current_sprite;
    current_sprite = temp_a;
    // ...end if we've made it to the "beginning" of the second set of SpriteObjects
	if (temp_a < sprite_object_set2_start){
		temp_x = ClearOam(temp_x);
		return;
	}
    // Otherwise, continue the loop
    goto WriteSPRObjectsToOam;

	begin_second_half_of_sprite_objects:
    // Save the OAM offset that marks the dividing line between the two sets of SpriteObjects
    oam_set2_start = temp_x;
    // if oam_and_300_clear_flag & 0x20, render this second set of SpriteObjects starting from the beginning
    temp_a = oam_and_300_clear_flag;
    temp_a &= 0x20;

	if (temp_a == 0){
		// Otherwise, render them starting from the end (to implement sprite flickering)
		//.assert <SPRITE_OBJECTS_END = 0, error, "SpriteObject rendering assumes SPRITE_OBJECTS ends at a page boundary"
		temp_a = cast(ubyte) -8;
		current_sprite = temp_a;
		adder = temp_a;
	}
    // With everything set up, continue looping and rendering SpriteObjects to OAM
    goto WriteSPRObjectsToOam;
}

/**
 * Original_Address: $(DOLLAR) $FC8A, bank $1F
 */
ubyte ClearOam(ubyte x) @safe {
	for (ubyte i = x/4; i < shadow_oam.length; i++) {
		shadow_oam[i].y = 0xF0;
		x += 4;
	}
	return x;
}

void FlickerSpritesInSet2() @safe {
    oam_and_300_clear_flag ^= 0x40;

    ubyte temp_y = 0xfc;
    ubyte temp_x = oam_set2_start;

	if (oam_and_300_clear_flag == 0){
		return;
	}
	while (1){
		obj_count = temp_y;
		if (temp_x >= obj_count){
			break;
		}
		// swap first byte and increment
		ubyte stasher = shadow_oam[temp_x/4].y;
		shadow_oam[temp_x/4].y = shadow_oam[temp_y/4].y;
		shadow_oam[temp_y/4].y = stasher;
		temp_x++;
		temp_y++;
		// swap second byte and increment
		stasher = shadow_oam[temp_x/4].index;
		shadow_oam[temp_x/4].index = shadow_oam[temp_y/4].index;
		shadow_oam[temp_y/4].index = stasher;
		temp_x++;
		temp_y++;
		// swap third byte and increment
		stasher = shadow_oam[temp_x/4].attributes;
		shadow_oam[temp_x/4].attributes = shadow_oam[temp_y/4].attributes;
		shadow_oam[temp_y/4].attributes = stasher;
		temp_x++;
		temp_y++;
		// swap fourth byte
		stasher = shadow_oam[temp_x/4].x;
		shadow_oam[temp_x/4].x = shadow_oam[temp_y/4].x;
		shadow_oam[temp_y/4].x = stasher;
		// increment X to the next OAM entry, move Y back to the previous OAM entry
		temp_x++;
		temp_y -= 7;
	}
}

/**
 * Original_Address: $(DOLLAR) $FCEE, bank $1F
 */
void MemoryInit() @safe {
	//lol
	ClearOam(0);
	nes.PPUCTRL = 0x08;
	ram_PPUCTRL = 0x08;

	bankswitch_flags = 0x80; // enable A12 inversion, use fixed $C000 and swappable $8000
	//mmc3
	//nes.BANKSELECT = 0x80;

	nes.PPUMASK = 0x18;
	ram_PPUMASK = 0x18;

	nes.setNametableMirroring(MirrorType.vertical);
}

/**
 * Original_Address: $(DOLLAR) $FD14, bank $1F
 */
void MusicInit() @safe {
	//version(original) {
	//} else {
		music_bank = 0x1C;
	//}

	BankswitchMusic();
	return Music_Init();
}

/**
 * Original_Address: $(DOLLAR) $FD28, bank $1F
 */
void unknownFD28(ubyte a) @safe {
//	CMP $078C
//	BEQ @UNKNOWN1
//	STA UNKNOWN_07F5
//@UNKNOWN1:
//	JMP WaitNMI
	//assert(0, "NYI");
}

/**
 * Original_Address: $(DOLLAR) $FD33, bank $1F
 */
void PpuSync() @safe {
	//does this work????
	while((new_animation_timer | current_animation_timer) > 0){
		nes.wait();
	}
}

void WaitXFrames_Min1(ubyte count) @safe {
	while (count > 0){
		WaitNMI();
		count--;
	}
}

void WaitNMI() @safe {
	nmi_mode = 1;
	while (nmi_mode != 0){
		nes.wait();
	}
}

//UNKNOWN_FD4A:
//	LDA $EB
//	BNE UNKNOWN_FD4A
//	RTS

//UNKNOWN_FD4F:
//	LDA #$00
//	STA $DA
//@UNKNOWN0:
//	LDA $DA
//	BEQ @UNKNOWN0
//	PHA
//	LDA #$00
//	STA $DA
//	PLA
//	RTS

/**
 * Original_Address: $(DOLLAR) $FD5E, bank $1F
 */
void ClearSprites() @safe {
	PpuSync();

	oam_and_300_clear_flag = 0x80 | (oam_and_300_clear_flag >> 1);

	for (ubyte i = 0; i < shadow_oam.length; i += 2){
		SPRITE_OBJECTS[i/2].count_flags = 0;
		shadow_oam[i].y = 0xf0;
		shadow_oam[i+1].y = 0xf0;
	}
	oam_and_300_clear_flag <<= 1;
}

void ClearTilemaps() @safe {
	PpuSync();

	ushort ptr = 0x2000;
	nmi_queue[0] = NMI_COMMANDS.PPU_WRITE_BYTE;
	nmi_queue[1] = 0x80;
	nmi_queue[2] = ptr >> 8;
	nmi_queue[3] = ptr & 0xff;
	nmi_queue[4] = 0;
	nmi_queue[5] = 0;

	while(ptr < 0x2800){
		nmi_data_offset = 0;
		new_animation_timer = 0x80;

		PpuSync();

		ptr += 0x80;
		nmi_queue[2] = ptr >> 8;
		nmi_queue[3] = ptr & 0xff;
	}
}

//UNKNOWN_FDC0:
//	JSR PpuSync
//	LDA $E7
//	AND #$BF
//	STA $E7
//	LDA #$00
//	STA $E8
//	STA $E9
//	CLC
//@UNKNOWN0:
//	TAX
//	LDA $0301,X
//	AND #$BF
//	STA $0301,X
//	LDA #$00
//	STA $0304,X
//	STA $0305,X
//	TXA
//	ADC #$08
//	BCC @UNKNOWN0
//	RTS

//UNKNOWN_FDE7:
//	LDA #$80
//	STA PRGRAMPROTECT
//	RTS

/**
 * Original_Address: $(DOLLAR) $FDED, bank $1F
 */
void WriteProtectPRGRam() @safe {
	//mmc3
	//nes.PRGRAMPROTECT = 0x80;
}

//TempUpperBankswitch:
//	PHA
//	LDA #$FE
//	PHA
//	LDA #$0C
//	PHA
//	TYA
//	PHA
//	TXA
//	PHA
//	TSX
//	LDA $F7
//	LDY $0105,X
//	STA $0105,X
//	TYA
//	LDX #BANK::PRGA000
//	JMP BANK_SWAP
//	PLA
//	LDX #BANK::PRGA000
//	JMP BANK_SWAP

//IrqHandler:
//	PHA
//	TXA
//	PHA
//	TYA
//	PHA
//	LDA $EE
//	PHA
//	JSR $FE3A
//	PLA
//	ORA $EF
//	STA BANKSELECT
//	LDX $ED
//	INX
//	INX
//	STX $ED
//	LDA $0541,X
//	BNE @UNKNOWN0
//	STA IRQDISABLE
//	STA $EB
//@UNKNOWN0:
//	PLA
//	TAY
//	PLA
//	TAX
//	PLA
//	RTI

//GotoIRQPointer:
//	STA IRQDISABLE
//	LDX $ED
//	LDA $0541,X
//	PHA
//	LDA $0540,X
//	PHA
//	STA IRQENABLE
//	RTS

void ReadPads() @safe {
    //x is the controller number
    //1 == JOY2
    //0 == JOY1
    //they use , x just the programmatically index
    //like an array

	for(ubyte x = 1; x != 0xff; x--){
		ubyte results = 0;
		for (ubyte read = 1; read != 0xff; read--){
			//start poll
			nes.JOY1 = 1;
			//clear poll
			nes.JOY1 = 0;

			// read 8 bits of normal controller input
			for (ubyte bits = 8; bits != 0; bits--){
				ubyte input = 0;
				if (x == 0){
					input = nes.JOY1;
				} else {
					input = nes.JOY2;
				}
				// read both from the normal controller port (stored in UNK_C0)
				// and the Famicom's expansion ports (stored in UNK_C0+1)
				UNK_C0[0] = cast(ubyte) ((input & 1) | (UNK_C0[0] << 1));
				input >>= 1;
				UNK_C0[1] = cast(ubyte) ((input & 1) | (UNK_C0[1] << 1));
				input >>= 1;
			}
			// combine the results
			results = UNK_C0[0] | UNK_C0[1];
			// If we've only read the controller port once this frame, store our results
			// and read them again to account for potential DPCM conflict
			if (read == 1){
				if (x == 0){
					pad1_press = results;
				} else {
					pad2_press = results;
				}
			}
		}

		if (x == 0){
			// If the results are different this time, we ran into a DPCM conflict.
			// Throw away these inputs and use the inputs from last frame instead
			if (pad1_press != results){
				results = pad1_hold;
			}
			ubyte y_store = results;
			results ^= pad1_hold;
			results &= pad1_press;
			pad1_press = results;
			pad1_hold = y_store;
		} else {
			if (pad2_press != results){
				results = pad2_hold;
			}
			ubyte y_store = results;
			results ^= pad2_hold;
			results &= pad2_press;
			pad2_press = results;
			pad2_hold = y_store;
		}
	}
}

//UNKNOWN_FE86:
//	LDA $DC
//	BNE @UNKNOWN0
//	LDA $D3
//	CMP #$2A
//	BCC @UNKNOWN1
//	RTS
//@UNKNOWN0:
//	LDA #$00
//	STA $D3
//@UNKNOWN1:
//	INC $D0
//	BNE @UNKNOWN2
//	INC $D3
//	INC $D1
//	BNE @UNKNOWN2
//	INC $D2
//@UNKNOWN2:
//	RTS

/** Game's entry point, prepares hardware
 * Original_Address: $(DOLLAR) $FF40, bank $1F
 */
void Reset_Vector() @safe {
	nes.PPUCTRL = 0x08;
	nes.interruptsEnabled = false;
	nes.PPUMASK = 0x00;
	nes.SND_CHN = 0x00;
	nes.DMC_FREQ = 0x00;
	//mmc3
	//nes.IRQDISABLE = 0x00;
	nes.JOY2 = 0x40;
	//mmc3
	//nes.PRGRAMPROTECT = 0x40;
	for (ubyte frames = 2; frames != 0; frames--) {
		nes.wait();
	}

	//set the palette to all black(?)
	nes.PPUADDR = 0x3F;
	nes.PPUADDR = 0x00;
	for (ubyte bytes = 32; bytes != 0; bytes--) {
		nes.PPUDATA = 0x0F;
	};

	nes.PPUADDR = 0x3F;
	nes.PPUADDR = 0x00;
	nes.PPUADDR = 0x00; //work around hardware bug
	nes.PPUADDR = 0x00;
	nes.PPUMASK = 0x1E;
	ubyte ppuAddrWrite = 0x10;
	for (ubyte bytes = ppuAddrWrite; bytes != 0; bytes--) {
		nes.PPUADDR = ppuAddrWrite;
		nes.PPUADDR = ppuAddrWrite;
		ppuAddrWrite ^= 0x00; //pointless?
	}

	// initialize stack, mapper...
	//stack = 0xFF;
	//mmc3
	//nes.BANKSELECT = 0x00;

	MemoryInit();
	//MusicInit();

	bankSwap(0x13, MMC3Bank.prgA000);
	//0x10 isnt actual, ???
	ram_PPUCTRL |= 0x80 | 0x10;
	nes.PPUCTRL = ram_PPUCTRL;
	nes.interruptsEnabled = true;
	PostInit();
}

/**
 * Original_Address: $(DOLLAR) $FFC5, bank $1F
 */
void BankswitchMusic() @safe {
	//version(original){
	//	bankSwap(0x1C, MMC3Bank.prg8000); //$8000
	//} else {
		bankSwap(music_bank, MMC3Bank.prg8000); //$8000
	//}
	bankSwap(0x1D, MMC3Bank.prgA000); //$A000
}

/** Swaps PRG banks
 * Original_Address: $(DOLLAR) $FFD0, bank $1F
 */
void bankSwap(ubyte bank, ubyte flags) @safe {
	// This is more meaningful for an MMC3
	bankswitch_mode = flags;
	current_banks[flags] = bank;
	ubyte bankselect = flags | bankswitch_flags;
	ubyte bankdata = current_banks[flags];

	if ((flags & 7) >= MMC3Bank.prg8000){
		return;
	}

	//mmc3 chr bank handling
	ushort actual_vram = flags & 7;
	if (actual_vram < MMC3Bank.chr1000){
		actual_vram *= 0x800;
		writeToVRAM(get_chr_bank(bank), actual_vram);
		bank++;
		actual_vram += 0x400;
		writeToVRAM(get_chr_bank(bank), actual_vram);
	} else {
		actual_vram = cast(ushort) ((actual_vram - 2) * 0x400);
		actual_vram += 0x1000;
		writeToVRAM(get_chr_bank(bank), actual_vram);
	}
}

//fake function. merge into mmc3 or whatever
void writeToVRAM(const(ubyte)[] src, ushort dest) @safe {
	//tracef("Transferring %s bytes to %04X", src.length, dest);
	nes.PPUADDR = dest >> 8;
	nes.PPUADDR = dest & 0xFF;
	for (uint i = 0; i < src.length; i++){
		nes.PPUDATA = src[i];
	}
}