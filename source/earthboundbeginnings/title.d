module earthboundbeginnings.title;

import earthboundbeginnings.constant;
import earthboundbeginnings.external;
import earthboundbeginnings.ram;
import earthboundbeginnings.defs;
import earthboundbeginnings.sprites;
import earthboundbeginnings.antipiracy;
import std.stdio;

/**
 * Original_Address: $(DOLLAR) $9400, bank $14
 */
void intro() @safe {
	BANKSET_H13();
	Title_Screen();
	//fallthrough
	return exited_naming_sequence();
}
void exited_naming_sequence() @safe {
    ClearSprites(); //clear sprites
    ClearTilemaps(); //clear tilemap 0
    LoadNamingScreen2(); //self explanatory
    PpuSync();
    LoadNamingScreen1();

    // jsr ResetScroll

    // ;load graphics
    // BankswitchCHR_Address naming_screen_chr_table
    // ;load palettes
    // LoadPalette_Address naming_screen_palettes

    // B20_142C:
    // ldx #(6*2)
    // jsr B20_1505
    // jsr B20_14d7
    // jsr B20_150e ;wait for input

    // B20_1437:
    // lda #0
    // sta UNK_D6

    // ;get offset
    // ldy menucursor_pos
    // lda (UNK_84), y
    // asl a
    // tax

    // ;stash pointer into stack
    // lda unk_pointers+1, x
    // pha
    // lda unk_pointers, x
    // pha

    // tya
    // lsr a
    // lsr a
}

//UNKNOWN_14944D: ;-1 because we're using RTS to jump
//	.WORD UNKNOWN_13BE88 - 1
//	.WORD UNKNOWN_14948C - 1
//	.WORD UNKNOWN_149472 - 1
//	.WORD UNKNOWN_149455 - 1

//UNKNOWN_149455:
//	PHA
//	JSR UNKNOWN_FDE7
//	LDA #$18
//	LDX #BANK::PRGA000
//	JSR BANK_SWAP
//	PLA
//	JSR $6041
//	JSR UNKNOWN_FDED
//	JSR BANKSET_H13
//	JSR UNKNOWN_149A4D
//	BCS UNKNOWN_149406
//	JMP UNKNOWN_13BE57

//UNKNOWN_149472:
//	JSR UNKNOWN_1494C0
//	BNE @UNKNOWN1
//	LDA $7402
//	JSR $BEBB
//	JSR UNKNOWN_FDE7
//	LDY #$03
//	LDA #$00
//	STA ($68),Y
//	JSR UNKNOWN_FDED
//@UNKNOWN1:
//	JMP UNKNOWN_14942C

//UNKNOWN_14948C:
//	STA $36
//	LDX #$10
//	JSR UNKNOWN_149505
//	LDA $36
//	SEC
//	ROL
//	ASL
//	TAX
//	JSR UNKNOWN_14950B
//	BIT $83
//	BVS @UNKNOWN3
//	LDA $82
//	STA $37
//	JSR UNKNOWN_1494C0
//	BCS @UNKNOWN2
//	BNE @UNKNOWN3
//@UNKNOWN2:
//	LDA $36
//	JSR $BE88
//	JSR UNKNOWN_FDE7
//	LDA $37
//	ORA #$B0
//	STA $7402
//	JSR UNKNOWN_13BE57
//@UNKNOWN3:
//	JMP UNKNOWN_14942C

//UNKNOWN_1494C0:
//	JSR $BE88
//	SEC
//	BNE @UNKNOWN4
//	LDX #$0E
//	JSR $601E
//	JSR UNKNOWN_C67A
//	LDX #$0E
//	JSR UNKNOWN_14950B
//	CLC
//	LDA $82
//@UNKNOWN4:
//	RTS

//UNKNOWN_1494D7:
//	LDA #$00
//@UNKNOWN0:
//	STA $37
//	LSR
//	LSR
//	JSR $BE88
//	BEQ @UNKNOWN1
//	LDA #$04
//@UNKNOWN1:
//	STA $36
//	LDX $37
//	JSR $6000
//	LDA $36
//	LSR
//	ADC $37
//	TAX
//	JSR UNKNOWN_149505
//	CLC
//	LDA $37
//	ADC #$04
//	CMP #$0C
//	BCC @UNKNOWN0
//	LDX #$0C
//	JSR $6029
//	JMP $6034
//UNKNOWN_149505:
//	JSR $601E
//	JMP UNKNOWN_C67A
//UNKNOWN_14950B:
//	JSR $6029
//UNKNOWN_14950E:
//	JSR UNKNOWN_EF34
//	LDA #$FF
//	JMP UNKNOWN_F0B0

/**
 * Original_Address: $(DOLLAR) $9516, bank $14
 */
void unknown149516() @safe {
	//	LDA $48
	//	ORA $20
	//	ORA $21
	//	ORA $22
	//	ORA $23
	//	ORA $25
	//	BNE @UNKNOWN2
	//	BIT $A0
	//	BMI @UNKNOWN2
	//	JSR UNKNOWN_1495D3
	//	LDX $15
	//	LDA UNKNOWN_149593,X
	//@UNKNOWN1__:
	//	BNE @UNKNOWN3
	//	STA $24
	//@UNKNOWN1_:
	//	LDA #$00
	//	STA $48
	//@UNKNOWN2:
	//	RTS
	//@UNKNOWN3:
	//	TAY
	//	AND #$07
	//	BNE @UNKNOWN4
	//	TYA
	//	LSR
	//	LSR
	//	LSR
	//	JSR UNKNOWN_E0F2
	//	JMP @UNKNOWN1__
	//@UNKNOWN4:
	//	CLC
	//	ADC $24
	//	CMP #$09
	//	BCC @UNKNOWN5
	//	LDA #$08
	//@UNKNOWN5:
	//	TAX
	//	JSR UNKNOWN_F1ED
	//	CMP UNKNOWN_14958A,X
	//	BCS @UNKNOWN1_
	//	LDX $24
	//	INX
	//	CPX #$03
	//	BCC @UNKNOWN6
	//	LDX #$02
	//@UNKNOWN6:
	//	STX $24
	//	TYA
	//	AND #$F8
	//	STA $68
	//	LDA #$00
	//	ASL $68
	//	ROL
	//	ADC #$92
	//	STA $69
	//@UNKNOWN7:
	//	JSR UNKNOWN_F1ED
	//	LSR
	//	LSR
	//	LSR
	//	LSR
	//	TAY
	//	LDA ($68),Y
	//	BEQ @UNKNOWN7
	//	STA $48
	//	LDA #$19
	//	LDX #$A6
	//	LDY #$A4
	//	JSR TempUpperBankswitch
	//UNKNOWN_14958A:
	//	RTS
	//assert(0, "NYI");
}

//UNKNOWN_14958B:
//	.BYTE $20, $15, $10, $0D, $0A, $08, $06, $05
//UNKNOWN_149593:
//	.BYTE $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0C, $11, $E8, $26, $2D, $34, $3D, $43, $4D, $55, $5D, $65, $00, $00, $00, $00, $00, $6C, $74, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $E0, $00, $00, $8D, $95, $9C, $A7, $00, $AD, $00, $00, $B5, $BD, $C5, $CD, $00, $00, $D6, $00, $00, $00, $DC, $00

//UNKNOWN_1495D3:
//	LDX #$00
//@UNKNOWN0:
//	LDA $7408,X
//	BEQ @UNKNOWN4
//	JSR UNKNOWN_C665
//	LDY #$01
//	LDA ($60),Y
//	LSR
//	BCC @UNKNOWN1
//	LDA #$07
//	BNE @UNKNOWN2
//@UNKNOWN1:
//	LSR
//	BCC @UNKNOWN4
//	LDA #$07
//@UNKNOWN2:
//	STA $64
//	CLC
//	TXA
//	ADC $D5
//	AND $64
//	BNE @UNKNOWN4
//	JSR UNKNOWN_FDE7
//	SEC
//	LDY #$14
//	LDA ($60),Y
//	SBC #$01
//	STA $64
//	INY
//	LDA ($60),Y
//	SBC #$00
//	STA $65
//	BCC @UNKNOWN3
//	LDA $64
//	ORA $65
//	BEQ @UNKNOWN3
//	LDA $65
//	STA ($60),Y
//	DEY
//	LDA $64
//	STA ($60),Y
//@UNKNOWN3:
//	JSR UNKNOWN_FDED
//	TXA
//	PHA
//	LDA #$16
//	JSR UNKNOWN_EDFE
//	JSR UNKNOWN_EEB0
//	PLA
//	TAX
//@UNKNOWN4:
//	INX
//	CPX #$04
//	BCC @UNKNOWN0
//	RTS

//UNKNOWN_149630:
//	LDA $48
//	CMP #$A2
//	BEQ UNKNOWN_149684
//	LDA #$30
//	JSR UNKNOWN_EDFE
//	JSR UNKNOWN_EEB0
//	JSR Refresh_SpriteObjects
//UNKNOWN_149641:
//	LDA #$07
//	STA $0400
//	LDA #$00
//	STA $0401
//	STA $60
//@UNKNOWN0:
//	LDX $60
//	LDA UNKNOWN_1496F1,X
//	CMP #$FF
//	BEQ @UNKNOWN1
//	LSR
//	LSR
//	LSR
//	LSR
//	STA $61
//	LDA UNKNOWN_1496F1,X
//	AND #$0F
//	STA $62
//	JSR UNKNOWN_149685
//	LDX $61
//	LDY $62
//	STY $61
//	STX $62
//	JSR UNKNOWN_149685
//	INC $60
//	BNE @UNKNOWN0
//@UNKNOWN1:
//	LDA $0401
//	CMP #$00
//	BEQ UNKNOWN_149684
//	LDA #$00
//	STA $E6
//	LDA #$01
//	STA $E5
//UNKNOWN_149684:
//	RTS

//UNKNOWN_149685:
//	LDA #$0E
//	SEC
//	SBC $62
//	BCS @UNKNOWN0
//	LDA #$00
//@UNKNOWN0:
//	STA $77
//	PHA
//	LDA #$0F
//	SEC
//	SBC $61
//	STA $76
//	JSR UNKNOWN_1496B8
//	LDA #$0F
//	CLC
//	ADC $62
//	CMP #$1E
//	BCC @UNKNOWN1
//	LDA #$1D
//@UNKNOWN1:
//	STA $77
//	JSR UNKNOWN_1496B8
//	LDA #$10
//	CLC
//	ADC $61
//	STA $76
//	JSR UNKNOWN_1496B8
//	PLA
//	STA $77

//UNKNOWN_1496B8:
//	LDA $0401
//	CMP #$14
//	BCC @UNKNOWN2
//	LDA #$00
//	STA $E6
//	LDA #$01
//	STA $E5
//	JSR PpuSync
//	LDA #$00
//	STA $0401
//@UNKNOWN2:
//	JSR CalculateNTAddr
//	LDA $0401
//	ASL
//	CLC
//	ADC $0401
//	TAX
//	LDA $78
//	STA $0402,X
//	LDA $79
//	STA $0403,X
//	LDA #$00
//	STA $0404,X
//	STA $0405,X
//	INC $0401
//	RTS

//UNKNOWN_1496F1:
//	.BYTE $00, $FE, $10, $FD, $EE, $11, $FB, $FC, $ED, $20, $21, $EC, $DD, $30, $31, $22, $F9, $FA, $EB, $DC, $40, $41, $32, $33, $F7, $F8, $E9, $EA, $DB, $CC, $42, $DA, $50, $51, $52, $43, $F4, $F5, $F6, $E7, $E8, $D9, $CA, $CB, $60, $61, $62, $53, $44, $BB, $F0, $F1, $F2, $F3, $54, $E4, $E5, $E6, $D7, $D8, $C9, $BA, $70, $71, $72, $63, $64, $55, $C8, $80, $E0, $81, $E1, $82, $E2, $73, $E3, $74, $D4, $65, $D5, $D6, $C7, $B8, $A9, $B9, $AA, $D0, $D1, $D2, $D3, $C4, $C5, $66, $C6, $B7, $A8, $99, $90, $91, $92, $83, $84, $75, $76, $B6, $C0, $C1, $C2, $93, $C3, $B4, $85, $B5, $A6, $A7, $88, $98, $A0, $A1, $A2, $A3, $94, $95, $86, $77, $97, $B0, $B1, $B2, $B3, $A4, $A5, $96, $87, $FF

/**
 * Original_Address: $(DOLLAR) $9779, bank $14
 */
void unknown149779() @safe {
	//LDA #$38
	//JSR UNKNOWN_EE21
	//LDA #$05
	//JSR UNKNOWN_149920
	//LDA #$C2
	//LDX #$99
	//JSR UNKNOWN_1497D6
	//LDA #$FF
	//JSR UNKNOWN_FD28
	//LDX #$B4
	//JSR WaitXFrames_Min1
	//LDA #$0F
	//JSR UNKNOWN_EDFE
	//LDA #$00
	//STA $EC
	//JSR LoadNamingScreen2
	//JMP UNKNOWN_D674
	//assert(0, "NYI");
}

/**
 * Original_Address: $(DOLLAR) $97A3, bank $14
 */
void unknown1497A3() @safe {
	//LDA #$0E
	//JSR UNKNOWN_149920
	//LDA #$D5
	//LDX #$99
	//JSR UNKNOWN_1497D6
	//LDA #$FF
	//JSR UNKNOWN_FD28
	//LDA #$E0
	//LDX #$99
	//JSR UNKNOWN_1497D6
	//LDA #$09
	//STA $07F0
	//LDA #$01
	//STA $07F4
	//LDA #$E9
	//LDX #$99
	//JSR UNKNOWN_1497D6
	//LDA #$1A
	//LDX #BANK::PRGA000
	//JSR BANK_SWAP
	//JMP $A000
	//assert(0, "NYI");
}

//UNKNOWN_1497D6:
//	STA $68
//	STX $69
//	LDY #$00
//	STY $6B
//@UNKNOWN0:
//	LDA ($68),Y
//	BEQ @UNKNOWN7
//	STA $6C
//	INY
//	LDA ($68),Y
//	STA $6D
//	INY
//	AND #$20
//	BEQ @UNKNOWN1
//	SEC
//	ROL $6B
//@UNKNOWN1:
//	TYA
//	PHA
//	LDA $6D
//	AND #$03
//	BEQ @UNKNOWN2
//	TAX
//	LDA UNKNOWN_149A05,X
//	JSR UNKNOWN_EE0E
//	JSR WaitNMI
//	LDA #$0F
//	JSR UNKNOWN_EE0E
//@UNKNOWN2:
//	JSR WaitNMI
//	LDA $6B
//	BNE @UNKNOWN3
//	LDA $6C
//	AND #$03
//	BNE @UNKNOWN5
//@UNKNOWN3:
//	LSR
//@UNKNOWN4:
//	PHA
//	JSR UNKNOWN_14983D
//	PLA
//	SEC
//	SBC #$01
//	BPL @UNKNOWN4
//@UNKNOWN5:
//	LDA $6C
//	ASL
//	ASL
//	AND $6D
//	AND #$04
//	BEQ @UNKNOWN6
//	LSR
//	EOR $FD
//	STA $FD
//	LDA #$0A
//	STA $07F0
//@UNKNOWN6:
//	DEC $6C
//	BNE @UNKNOWN2
//	PLA
//	TAY
//	BNE @UNKNOWN0
//@UNKNOWN7:
//	RTS

//UNKNOWN_14983D:
//	BIT $6D
//	BPL @UNKNOWN5
//	BVC @UNKNOWN1
//	JSR UNKNOWN_149878
//	BNE @UNKNOWN0
//	DEX
//	CPX #$05
//	BCC @UNKNOWN5
//	TXA
//	JSR UNKNOWN_149883
//@UNKNOWN0:
//	SEC
//	LDA $FC
//	SBC #$01
//	JMP @UNKNOWN3
//@UNKNOWN1:
//	JSR UNKNOWN_149878
//	EOR #$0F
//	BNE @UNKNOWN2
//	INX
//	CPX #$3C
//	BCS @UNKNOWN5
//	TXA
//	CLC
//	ADC #$0A
//	JSR UNKNOWN_149883
//@UNKNOWN2:
//	CLC
//	LDA $FC
//	ADC #$11
//@UNKNOWN3:
//	BCS @UNKNOWN4
//	SBC #$0F
//@UNKNOWN4:
//	STA $FC
//@UNKNOWN5:
//	RTS

//UNKNOWN_149878:
//	JSR PpuSync
//	LDX $6A
//	CLC
//	LDA $FC
//	AND #$0F
//	RTS

//UNKNOWN_149883:
//	STX $6A
//	JSR UNKNOWN_14988D
//	LDA #$80
//	STA $E5
//	RTS

//UNKNOWN_14988D:
//	LDX #$24
//UNKNOWN_14988F:
//	STX $62
//	LDX #$00
//@UNKNOWN0:
//	CMP #$0F
//	BCC @UNKNOWN1
//	SBC #$0F
//	INX
//	BCS @UNKNOWN0
//@UNKNOWN1:
//	ASL
//	ASL
//	STA $6E
//	TXA
//	LSR
//	ROR
//	ROR
//	AND #$C0
//	ORA $6E
//	STA $60
//	LDA #$06
//	ASL $60
//	ROL
//	ASL $60
//	ROL
//	ASL $60
//	ROL
//	ASL $60
//	ROL
//	STA $61
//	ORA #$03
//	STA $65
//	LDA $6E
//	AND #$38
//	ORA #$C0
//	STA $64
//	JSR PpuSync
//	LDA #$05
//	LDY #$40
//	STA $0400
//	STY $0401
//	LDY #$08
//	STA $0444
//	STY $0445
//	LDA $61
//	LDY $60
//	AND #$03
//	ORA $62
//	STA $0402
//	STY $0403
//	LDA $65
//	LDY $64
//	AND #$03
//	ORA $62
//	STA $0446
//	STY $0447
//	LDY #$3F
//@UNKNOWN2:
//	LDA ($60),Y
//	JSR UNKNOWN_149919
//	STA $0404,Y
//	DEY
//	BPL @UNKNOWN2
//	LDY #$07
//@UNKNOWN3:
//	LDA ($64),Y
//	JSR UNKNOWN_149919
//	STA $0448,Y
//	DEY
//	BPL @UNKNOWN3
//	LDA #$00
//	STA $0450
//	STA $E6
//	RTS

//UNKNOWN_149919:
//	CPX #$04
//	BCC @UNKNOWN0
//	LDA #$00
//@UNKNOWN0:
//	RTS

//UNKNOWN_149920:
//	STA $6A
//	LDA #$0B
//	JSR UNKNOWN_FD28
//	JSR UNKNOWN_1499A3
//	JSR UNKNOWN_EECC
//	JSR ClearSprites
//	JSR PpuSync
//	LDX #$0F
//@UNKNOWN0:
//	LDA UNKNOWN_149A3D,X
//	STA $0340,X
//	DEX
//	BPL @UNKNOWN0
//	LDA #$2D
//	LDX #$9A
//	STA $60
//	STX $61
//	JSR UNKNOWN_E087
//	LDA #$54
//	JSR UNKNOWN_1499AD
//	LDA #$F9
//	LDX #$99
//	JSR UNKNOWN_CEE8
//	LDA #$01
//	STA $E5
//	LDY #$04
//@UNKNOWN1:
//	TYA
//	PHA
//	LDX #$20
//	JSR UNKNOWN_14988F
//	LDA #$80
//	STA $E5
//	PLA
//	TAY
//	DEY
//	BPL @UNKNOWN1
//	JSR UNKNOWN_14998B
//	LDX #$03
//@UNKNOWN2:
//	LDA UNKNOWN_149A09,X
//	STA $0540,X
//	DEX
//	BPL @UNKNOWN2
//	LDA #$9F
//	STA $EC
//	LDX #$1F
//@UNKNOWN3:
//	LDA UNKNOWN_149A0D,X
//	STA $0520,X
//	DEX
//	BPL @UNKNOWN3
//	JMP B31_0e30

//UNKNOWN_14998B:
//	CLC
//	LDA $6A
//	ADC #$0B
//@UNKNOWN4:
//	PHA
//	JSR UNKNOWN_14988D
//	LDA #$80
//	STA $E5
//	PLA
//	SEC
//	SBC #$01
//	BCC @UNKNOWN5
//	CMP $6A
//	BCS @UNKNOWN4
//@UNKNOWN5:
//	RTS

//UNKNOWN_1499A3:
//	LDA $6A
//	ASL
//	ASL
//	ASL
//	ASL
//	TAY
//	LDX #$FC
//	RTS

//UNKNOWN_1499AD:
//	PHA
//	TAY
//	LDA #$00
//	LDX #$60
//	JSR UNKNOWN_CE08
//	PLA
//	CLC
//	ADC #$02
//	TAY
//	LDA #$00
//	LDX #$68
//	JMP UNKNOWN_CE08

//UNKNOWN_1499C2:
//	.BYTE $80, $00, $80, $80, $80, $82, $20, $83, $20, $82, $C0, $81, $80, $82, $20, $83, $20, $82, $00, $80, $C0, $20, $C3, $20, $C2, $80, $C1, $80, $C3, $00, $40, $02, $10, $07, $20, $06, $50, $05, $00, $08, $23, $08, $22, $F0, $A1, $F0, $00, $00, $04, $80, $00, $A9, $A9, $AB, $AA, $76, $70, $50, $51, $52, $53, $76, $70, $48, $49, $4A, $4B
//UNKNOWN_149A05:
//	.BYTE $0F, $38, $21, $34
//UNKNOWN_149A09:
//	.BYTE $CA, $ED, $00, $00
//UNKNOWN_149A0D:
//	.BYTE $0F, $12, $30, $00, $0F, $10, $30, $00, $0F, $17, $37, $16, $0F, $38, $30, $00, $0F, $0F, $00, $30, $0F, $0F, $16, $37, $0F, $0F, $24, $37, $0F, $0F, $12, $37, $68, $78, $00, $00, $58, $88, $00, $00, $78, $88, $00, $00, $68, $98, $00, $00
//UNKNOWN_149A3D:
//	.BYTE $86, $00, $F4, $76, $00, $00, $C0, $99, $06, $00, $E4, $76, $00, $00, $C4, $99

//UNKNOWN_149A4D:
//	JSR UNKNOWN_149B2A
//@UNKNOWN0:
//	LDA #$06
//	STA $56
//	LDA #$CA
//	LDX #$62
//	JSR UNKNOWN_149B7D
//	BCS @UNKNOWN5
//@UNKNOWN1:
//	LDA #$06
//	STA $56
//	LDA #$D0
//	LDX #$62
//	JSR UNKNOWN_149B7D
//	BCS @UNKNOWN0
//@UNKNOWN2:
//	LDA #$06
//	STA $56
//	LDA #$D6
//	LDX #$62
//	JSR UNKNOWN_149B7D
//	BCS @UNKNOWN1
//@UNKNOWN3:
//	LDA #$06
//	STA $56
//	LDA #$DC
//	LDX #$62
//	JSR UNKNOWN_149B7D
//	BCS @UNKNOWN2
//	LDA #$0A
//	STA $56
//	LDA #$E2
//	LDX #$62
//	JSR UNKNOWN_149B7D
//	BCS @UNKNOWN3
//	JSR UNKNOWN_149D50
//	JSR UNKNOWN_149AD5
//	JSR B31_0e30
//	JSR UNKNOWN_149B00
//	BCC @UNKNOWN4
//	JMP UNKNOWN_149A4D
//@UNKNOWN4:
//	JSR UNKNOWN_149D50
//	LDX #$3C
//	JSR UNKNOWN_F25E
//	JSR B31_0e30
//	LDA #$02
//	STA $76
//	LDA #$03
//	STA $77
//	LDX #$D0
//	LDY #$64
//	JSR UNKNOWN_149B13
//	LDA #$FF
//	STA $07F5
//	JSR B31_0e30
//	LDA #$06
//	STA $76
//	LDA #$0A
//	STA $77
//	LDX #$7D
//	LDY #$66
//	JSR UNKNOWN_149B13
//	CLC
//@UNKNOWN5:
//	RTS

//UNKNOWN_149AD5:
//	LDA #$8B
//	LDX #$6C
//	JSR UNKNOWN_149AF9
//	LDA #$C0
//	LDX #$6C
//	JSR UNKNOWN_149AF9
//	JSR $6286
//	LDY #$00
//@UNKNOWN0:
//	JSR UNKNOWN_149AF3
//	JSR $629B
//	CMP #$20
//	BNE @UNKNOWN0
//	RTS

//UNKNOWN_149AF3:
//	JSR PpuSync
//	JMP $625B

//UNKNOWN_149AF9:
//	STA $74
//	STX $75
//	JMP UNKNOWN_C67A

//UNKNOWN_149B00:
//	LDA #$F0
//	LDX #$62
//	STA $80
//	STX $81
//	JSR UNKNOWN_EF34
//	LDA $82
//	BEQ UNKNOWN_149B11
//	SEC
//	RTS

//UNKNOWN_149B11:
//	CLC
//	RTS

//UNKNOWN_149B13:
//	LDA #$00
//	STA $70
//	STX $74
//	STY $75
//@UNKNOWN0:
//	JSR UNKNOWN_C707
//	DEC $77
//	CMP #$00
//	BNE @UNKNOWN0
//	JSR UNKNOWN_F29E
//	JMP UNKNOWN_149D50

//UNKNOWN_149B2A:
//	JSR UNKNOWN_149D50
//	JSR UNKNOWN_EEC8
//	LDA #$2D
//	LDX #$6C
//	JSR UNKNOWN_149AF9
//	JSR UNKNOWN_149B40
//	JSR UNKNOWN_149B76
//	JMP B31_0e30

//UNKNOWN_149B40:
//	LDA #$70
//	STA $64
//	LDA #$64
//	STA $65
//	LDA #$0E
//	STA $63
//	LDX #$04
//@UNKNOWN1:
//	TXA
//	PHA
//	LDA #$08
//	STA $62
//	LDA $62
//	STA $76
//	LDA $63
//	STA $77
//	LDA $64
//	STA $74
//	LDA $65
//	STA $75
//	JSR DrawTilepackClear
//	JSR $62B5
//	PLA
//	TAX
//	DEX
//	BNE @UNKNOWN1
//	LDA #$66
//	LDX #$6C
//	JMP UNKNOWN_149AF9

//UNKNOWN_149B76:
//	LDA #$00
//	LDX #$6C
//	JMP UNKNOWN_149AF9

//UNKNOWN_149B7D:
//	STA $5C
//	STX $5D
//	LDY #$00
//	JSR UNKNOWN_149BED
//	ORA $60
//	BEQ @UNKNOWN2
//	LDA #$22
//	STA $62
//	LDA #$FF
//	STA $63
//	LDA #$80
//	STA $64
//	LDY #$00
//	JSR UNKNOWN_149AF3
//@UNKNOWN2:
//	JSR UNKNOWN_149BF7
//	LDA #$24
//	LDX #$6C
//	JSR UNKNOWN_149AF9
//	LDY #$04
//	JSR UNKNOWN_149BED
//	LDY $56
//	LDA #$00
//	STA $70
//	STA $0581,Y
//	STY $55
//@UNKNOWN3:
//	LDA ($60),Y
//	BNE @UNKNOWN4
//	STY $55
//	LDA #$A2
//@UNKNOWN4:
//	STA $0580,Y
//	DEY
//	BPL @UNKNOWN3
//	JSR UNKNOWN_149C1C
//	BCS @UNKNOWN7
//	LDY #$04
//	JSR UNKNOWN_149BED
//	JSR UNKNOWN_FDE7
//	LDY $56
//@UNKNOWN5:
//	LDA $0580,Y
//	CMP #$A2
//	BNE @UNKNOWN6
//	LDA #$00
//@UNKNOWN6:
//	STA ($60),Y
//	DEY
//	BPL @UNKNOWN5
//	JSR UNKNOWN_FDED
//	JSR ClearSprites
//	CLC
//	RTS
//@UNKNOWN7:
//	JSR ClearSprites
//	SEC
//	RTS

//UNKNOWN_149BED:
//	LDA ($5C),Y
//	STA $60
//	INY
//	LDA ($5C),Y
//	STA $61
//	RTS

//UNKNOWN_149BF7:
//	JSR UNKNOWN_149B76
//	LDX #$08
//	JSR UNKNOWN_F25E
//	LDY #$02
//	JSR UNKNOWN_149BED
//UNKNOWN_149C04:
//	LDA $60
//	STA $74
//	LDA $61
//	STA $75
//	LDA #$09
//	STA $76
//	LDA #$03
//	STA $77
//@UNKNOWN0:
//	JSR DrawTilepackClear
//	CMP #$00
//	BNE @UNKNOWN0
//	RTS

//UNKNOWN_149C1C:
//	JSR UNKNOWN_149D0A
//	LDA #$E8
//	LDX #$62
//	STA $80
//	STX $81
//	LDA #$70
//	LDX #$64
//	STA $84
//	STX $85
//	LDA #$01
//	STA $D6
//UNKNOWN_149C33:
//	JSR UNKNOWN_EF3F
//	JMP UNKNOWN_149C3F

//UNKNOWN_149C39:
//	JSR UNKNOWN_149D0A
//	JSR UNKNOWN_EF7C
//UNKNOWN_149C3F:
//	BIT $83
//	BVS UNKNOWN_149C70
//	BMI @UNKNOWN0
//	LDA $83
//	AND #$10
//	BNE UNKNOWN_149C8B
//	JMP UNKNOWN_149C33
//@UNKNOWN0:
//	LDX $82
//	LDA $6470,X
//	CMP #$A1
//	BEQ UNKNOWN_149C70
//	CMP #$A2
//	BEQ UNKNOWN_149C8B
//	CMP #$A3
//	BEQ @UNKNOWN2
//	LDX $55
//	STA $0580,X
//	CPX $56
//	BEQ @UNKNOWN1
//	INX
//	STX $55
//@UNKNOWN1:
//	JMP UNKNOWN_149C39
//@UNKNOWN2:
//	SEC
//	RTS

//UNKNOWN_149C70:
//	LDA #$A2
//	LDX $55
//	CPX $56
//	BNE @UNKNOWN0
//	CMP $0580,X
//	BNE @UNKNOWN1
//@UNKNOWN0:
//	STA $0580,X
//	DEX
//	BMI @UNKNOWN2
//	STX $55
//@UNKNOWN1:
//	STA $0580,X
//@UNKNOWN2:
//	JMP UNKNOWN_149C39

//UNKNOWN_149C8B:
//	LDY $55
//@UNKNOWN3:
//	LDA $0580,Y
//	CMP #$A2
//	BEQ @UNKNOWN4
//	CMP #$A0
//	BNE @UNKNOWN5
//	LDA #$A2
//	STA $0580,Y
//@UNKNOWN4:
//	DEY
//	BPL @UNKNOWN3
//@UNKNOWN5:
//	CPY $56
//	BEQ @UNKNOWN6
//	INY
//@UNKNOWN6:
//	STY $55
//	CPY #$00
//	BEQ UNKNOWN_149CCF_END
//	LDX #$00
//@UNKNOWN7:
//	LDY #$00
//@UNKNOWN8:
//	LDA $63F8,X
//	BEQ @UNKNOWN10
//	CMP #$01
//	BEQ UNKNOWN_149CCF
//	INX
//	INY
//	CMP $057F,Y
//	BEQ @UNKNOWN8
//@UNKNOWN9:
//	LDA $63F8,X
//	INX
//	CMP #$01
//	BNE @UNKNOWN9
//	BEQ @UNKNOWN7
//@UNKNOWN10:
//	LDA #$00
//	STA $D6
//	CLC
//	RTS

//UNKNOWN_149CCF:
//	JSR ErrBuzzer
//	JSR UNKNOWN_149B76
//	LDA #$7F
//	LDX #$63
//	STA $60
//	STX $61
//	JSR UNKNOWN_149C04
//	LDA $0580
//	CMP #$A0
//	BEQ @UNKNOWN1
//	LDA #$98
//	LDX #$63
//	STA $74
//	STX $75
//	LDX #$08
//	LDY #$0E
//	STX $76
//	STY $77
//@UNKNOWN0:
//	JSR DrawTilepackClear
//	CMP #$00
//	BNE @UNKNOWN0
//@UNKNOWN1:
//	JSR UNKNOWN_F29E
//	JSR UNKNOWN_149B40
//	JSR UNKNOWN_149BF7
//UNKNOWN_149CCF_END:
//	JMP UNKNOWN_149C1C

//UNKNOWN_149D0A:
//	LDA $76
//	PHA
//	LDA $77
//	PHA
//	JSR WaitNMI
//	SEC
//	LDA #$00
//	SBC $56
//	SEC
//	ROR
//	CLC
//	ADC #$0F
//	TAY
//	LDA #$59
//	STA $0204
//	CLC
//	TYA
//	ADC $55
//	ASL
//	ASL
//	ASL
//	STA $0207
//	LDA #$01
//	STA $0205
//	LDA #$00
//	STA $0206
//	TYA
//	STA $76
//	LDA #$0A
//	STA $77
//	LDA #$80
//	STA $74
//	LDA #$05
//	STA $75
//	JSR DrawTilepackClear
//	PLA
//	STA $77
//	PLA
//	STA $76
//	RTS

//UNKNOWN_149D50:
//	JSR OT0_DefaultTransition
//	JSR ClearSprites
//	JSR ClearTilemaps
//	LDX #$FD
//	LDY #$62
//	JMP fill_nmi_with_pointer_data

void Title_Screen() @safe {

	ClearSprites();
	ClearTilemaps();



	ram_PPUCTRL &= 0xFE;
	scroll_x = 0;
	scroll_y = 0;

    BankswitchCHRFromTable(Title_CHR_Old);

    LoadPaletteFrom(Title_Palette_Old);

	OT0_DefaultTransition();

    if (current_music != 0x16){
    	soundqueue_track = 0x16;
	}

    fill_nmi_with_pointer_data(nmi_fill_map_with_palette_2);

    DoIntroTransition(produced_by_tiles);

    fill_nmi_with_pointer_data(nmi_fill_map_with_palette_2);

    DoIntroTransition(presented_by_tiles);

    LoadPaletteFrom(Title_Palette);

	OT0_DefaultTransition();

	//mmc1 fix
	ram_PPUCTRL &= ~8;
	nes.PPUCTRL = ram_PPUCTRL;
    BankswitchCHRFromTable(Title_CHR);

	load_tilemap_into_queue(title_screen_tiles);

	UNK_60 = 0;
	SpriteObject new_earth = {
		16,
		0,
		{88, 87},
		{0, 0},
		[],
		&SPRITEDEF_EARTH[UNK_60]
	};
	SPRITE_OBJECTS[28] = new_earth;

    //reset input?
	pad1_forced = 0;

	while(1){
		SPRITE_OBJECTS[28].spriteDef = &SPRITEDEF_EARTH[UNK_60];

		new_animation_timer = 10;

		UNK_60++;
		if (UNK_60 == 7){
			UNK_60 = 0;
		}
		bool breaker = false;
		while((new_animation_timer | current_animation_timer) != 0){
			//check if start pressed at title
			if (pad1_forced & PAD_START){
				breaker = true;
				break;
			}
			nes.wait();
		}
		if (breaker){
			break;
		}
	}

	pad1_forced = 0;
	OT0_DefaultTransition();
	//mmc1 unfix
	ram_PPUCTRL |= 8;
	nes.PPUCTRL = ram_PPUCTRL;
	TITLE_ANTI_PIRACY();
}

void DoIntroTransition(ubyte[] tiles) @safe {
	load_tilemap_into_queue(tiles);
	AdvanceIfPressStart(255);
  	AdvanceIfPressStart(64);
	OT0_DefaultTransition();
	//version(original){
  	//	AdvanceIfPressStart(80);
	//} else {
  		AdvanceIfPressStart(64);
	//}
	return ClearTilemaps();
}

void load_tilemap_into_queue(ubyte[] tiles) @safe {
	tilepack_ptr = tiles;
	while(DrawTilepack() != 0){
		ntbl_y--;
	}
	return B31_0e30();
}

void AdvanceIfPressStart(ubyte count) @safe {
	while(count > 0){
		WaitNMI();
		if (((pad1_hold & (1 << 4)) ^ (1 << 4)) == 0){
			return;
		}
		count--;
	}
}

ubyte[] Title_CHR_Old = [0x42, 0x72, 0x7c, 0x7c, 0x40, 0x41];

ubyte[] Title_CHR = [0x42, 0x72, 0x7C, 0x41, 0xD8, 0xD9];

ubyte[] Title_Palette_Old = [
	0x0F, 0x28, 0x30, 0x18,
	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x16, 0x30, 0x12,
	0x0F, 0x3A, 0x30, 0x12,

	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
];

ubyte[] Title_Palette = [
	0x0F, 0x21, 0x30, 0x16,
	0x0F, 0x21, 0x30, 0x16,
	0x0F, 0x21, 0x30, 0x16,
	0x0F, 0x21, 0x30, 0x16,

	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
	0x0F, 0x21, 0x30, 0x12,
];

ubyte[] nmi_fill_map_with_palette_2 = [
	NMI_COMMANDS.PPU_WRITE_BYTE,
	0x40,
	0x23,0xC0,
	0xAA,
	0x00,
];

ubyte[] B20_1EB5 = [
	NMI_COMMANDS.PPU_WRITE_ADDRS,
	0x04,
	0x23,0xD2,
	0x40,
	0x23,0xD3,
	0x10,
	0x23,0xDA,
	0x04,
	0x23,0xDB,
	0x01,
	0x00,
];

ubyte[] produced_by_tiles = [
0x20, 0x0D, 0x0B,
0xC8, 0xC9, 0xCA, 0xCB, 0xCD, 0xCE, 0xCF,
0x01,
0x20, 0x0D, 0x0C,
0xD8,
0x01,
0x20, 0x13, 0x0C,
0xDF,
0x01,

0x20, 0x0D, 0x0D,
0x22, 0xCC, 0x13,
0x01,

0x20, 0x0D, 0x0F,
0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8,
0x00
];

ubyte[] presented_by_tiles = [
0x20, 0x0D, 0x0B,
0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xCE, 0xCF,
0x01,
0x20, 0x0D, 0x0C,
0xD8,
0x01,
0x20, 0x14, 0x0C,
0xDF,
0x01,

0x20, 0x00, 0x0D,
0x22, 0xCC, 0x15,
0x01,

0x20, 0x08, 0x0F,
0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF,
0x00
];

ubyte[] title_screen_tiles = [
0x20, 0x08, 0x07,
0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x9B, 0x9C,
0x01,
0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xAB, 0xAC,
0x01,
0xB0, 0xB1, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF,
0x01,
0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF,
0x01,
0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE,
0x01,
0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE,
0x01,
0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE,
0x01,

0x20, 0x07, 0x17,
0x43, 0x44, 0x45, 0x46, 0x47, 0x70,
0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x53, 0x54, 0x55, 0x56, 0x57,
0x00
];
