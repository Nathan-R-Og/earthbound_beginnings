module earthboundbeginnings.music;

import earthboundbeginnings.external;
import earthboundbeginnings.ram;
import replatform64.nes.hardware.registers;
import std.stdio;
import std.range;

ubyte[] a_stash = [];
ubyte a_reg = 0;
ubyte x_reg = 0;
ubyte y_reg = 0;
string current_instrument = "";



//TODO: replatform64 is messed up???? needs work.
//all of the registers seem to be in order...
//more testing please!
//skipping sfx stuff for now. get music working!!


void Music_Tick() @safe {
	//return ActualMusicTick();
}

void B28_0003() @safe {
    return B28_0299();
}

/**
 * Original_Address: $(DOLLAR) $8006, bank $1C
 */
void Music_Init() @safe {
	return ActualMusicInit();
}

//UNKNOWN_1C8009:
//	.WORD UNKNOWN_1C83FA
//	.WORD UNKNOWN_1C843A
//	.WORD UNKNOWN_1C8393
//	.WORD UNKNOWN_1C83DC
//	.WORD UNKNOWN_1C8420
//	.WORD UNKNOWN_1C835C
//	.WORD UNKNOWN_1C8346
//	.WORD UNKNOWN_1C8328
//	.WORD UNKNOWN_1C847D
//	.WORD UNKNOWN_1C8321
//	.WORD UNKNOWN_1C8401
//	.WORD UNKNOWN_1C8441
//	.WORD UNKNOWN_1C83A1
//	.WORD UNKNOWN_1C83E3
//	.WORD UNKNOWN_1C8427
//	.WORD UNKNOWN_1C8374
//	.WORD UNKNOWN_1C8410
//	.WORD UNKNOWN_1C832F
//	.WORD UNKNOWN_1C8484
//	.WORD UNKNOWN_1C8410
//UNKNOWN_1C8031:
//	.WORD UNKNOWN_1C86C4
//	.WORD UNKNOWN_1C8772
//	.WORD UNKNOWN_1C8747
//	.WORD UNKNOWN_1C867C
//	.WORD UNKNOWN_1C8726
//	.WORD UNKNOWN_1C87A9
//	.WORD UNKNOWN_1C875E
//	.WORD UNKNOWN_1C8610
//	.WORD UNKNOWN_1C8829
//	.WORD UNKNOWN_1C85EB
//	.WORD UNKNOWN_1C85E6
//	.WORD UNKNOWN_1C8699
//	.WORD UNKNOWN_1C85DF
//	.WORD UNKNOWN_1C866E
//	.WORD UNKNOWN_1C85A4
//	.WORD UNKNOWN_1C8733
//	.WORD UNKNOWN_1C860D
//	.WORD UNKNOWN_1C8962
//	.WORD UNKNOWN_1C86CB
//	.WORD UNKNOWN_1C877F
//	.WORD UNKNOWN_1C8752
//	.WORD UNKNOWN_1C8683
//	.WORD UNKNOWN_1C870F
//	.WORD UNKNOWN_1C87B7
//	.WORD UNKNOWN_1C8769
//	.WORD UNKNOWN_1C861E
//	.WORD UNKNOWN_1C880E
//	.WORD UNKNOWN_1C85F2
//	.WORD UNKNOWN_1C85AF
//	.WORD UNKNOWN_1C86A0
//	.WORD UNKNOWN_1C8683
//	.WORD UNKNOWN_1C8683
//	.WORD UNKNOWN_1C8683
//	.WORD UNKNOWN_1C873E
//	.WORD UNKNOWN_1C861E
//	.WORD UNKNOWN_1C896C
//UNKNOWN_1C8079:
//	.WORD UNKNOWN_1C885E
//	.WORD UNKNOWN_1C884E
//	.WORD UNKNOWN_1C88D4
//	.WORD UNKNOWN_1C88E5
//	.WORD UNKNOWN_1C887E
//	.WORD UNKNOWN_1C88B4
//	.WORD UNKNOWN_1C88BA
//	.WORD UNKNOWN_1C88EC
//UNKNOWN_1C8089:
//	.WORD UNKNOWN_1C84F6
//	.WORD UNKNOWN_1C854D
//	.WORD UNKNOWN_1C8542
//	.WORD UNKNOWN_1C8509
//	.WORD UNKNOWN_1C8559
//	.WORD UNKNOWN_1C8559

void SetSQ1Registers() @safe {
    a_reg = 0;
    return B28_00a3();
}
void SetTRIRegisters() @safe {
    a_reg = 8;
    return B28_00a3();
}
void SetNOISERegisters() @safe {
    a_reg = 12;
    return B28_00a3();
}
void SetSQ2Registers() @safe {
    a_reg = 4;
    return B28_00a3();
}
//sfx related
void B28_00a3() @safe {
    unk_b0 = a_reg;
    a_reg = 0x40;
    unk_b1 = a_reg;
    unk_b2 = y_reg;
    a_reg = 0x81;
    unk_b3 = a_reg;
    y_reg = 0;
    while (y_reg != 4){
    //	LDA ($B2),Y
    //	STA ($B0),Y
        y_reg++;
    }
}

void TickRNG() @safe {
    unk_7ff = unk_bb[0] & 2;
    a_reg = unk_bb[1] & 2;
    a_reg ^= unk_7ff;
    unk_bb[1] >>= 1;
    unk_bb[1] |= unk_bb[0] >> 7;
    unk_bb[0] >>= 1;
    if (a_reg != 0){
        unk_bb[0] |= 0x80;
    }
}

//UNKNOWN_1C80D3:
//	LDX $BD
//	INC UNKNOWN_07DA,X
//	LDA UNKNOWN_07DA,X
//	CMP UNKNOWN_07D5,X
//	BNE @UNKNOWN0
//	LDA #$00
//	STA UNKNOWN_07DA,X
//@UNKNOWN0:
//	RTS

//UNKNOWN_1C80E6:
//	.WORD UNKNOWN_1C9353
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.WORD UNKNOWN_1C9342
//	.BYTE $00, $00

//UNKNOWN_1C80FA:
//	.BYTE $A4, $AC, $A3, $AC, $A4, $AC, $16, $7F, $0E, $80

//UNKNOWN_1C8104:
//	.BYTE $3E, $7F, $0E, $08
//UNKNOWN_1C8108:
//	.BYTE $1F, $7F, $0F, $C0
//UNKNOWN_1C810C:
//	.BYTE $3F, $7F, $00, $B0
//UNKNOWN_1C8110:
//	.BYTE $11, $7F, $0E, $30
//UNKNOWN_1C8114:
//	.BYTE $9B, $7F, $0C, $28
//UNKNOWN_1C8118:
//	.BYTE $10, $7F, $87, $B0
//UNKNOWN_1C811C:
//	.BYTE $0A, $7F, $0F, $08
//UNKNOWN_1C8120:
//	.BYTE $B0, $7F, $1C, $40
//UNKNOWN_1C8124:
//	.BYTE $B0, $7F, $32, $40
//UNKNOWN_1C8128:
//	.BYTE $B1, $7F, $40, $40
//UNKNOWN_1C812C:
//	.BYTE $B1, $7F, $42, $40
//UNKNOWN_1C8130:
//	.BYTE $B1, $8E, $A0, $47
//UNKNOWN_1C8134:
//	.BYTE $B1, $7F, $FF, $47
//UNKNOWN_1C8138:
//	.BYTE $1F, $7F, $30, $08
//UNKNOWN_1C813C:
//	.BYTE $1F, $BB, $D4, $08
//UNKNOWN_1C8140:
//	.BYTE $81, $A7, $E1, $88
//UNKNOWN_1C8144:
//	.BYTE $99, $7F, $15, $88
//UNKNOWN_1C8148:
//	.BYTE $9B, $7F, $1F, $88
//UNKNOWN_1C814C:
//	.BYTE $D8, $7F, $20, $28
//UNKNOWN_1C8150:
//	.BYTE $D1, $7F, $20, $28
//UNKNOWN_1C8154:
//	.BYTE $D9, $7F, $54, $28
//UNKNOWN_1C8158:
//	.BYTE $9E, $9D, $C0, $08
//UNKNOWN_1C815C:
//	.BYTE $9C, $9A, $E8, $08
//UNKNOWN_1C8160:
//	.BYTE $9E, $7F, $40, $08
//UNKNOWN_1C8164:
//	.BYTE $94, $C6, $67, $28
//UNKNOWN_1C8168:
//	.BYTE $96, $CE, $47, $28
//UNKNOWN_1C816C:
//	.BYTE $D9, $A5, $7B, $F9
//UNKNOWN_1C8170:
//	.BYTE $D6, $A5, $90, $F9
//UNKNOWN_1C8174:
//	.BYTE $DA, $96, $46, $F9
//UNKNOWN_1C8178:
//	.BYTE $96, $7F, $76, $20
//UNKNOWN_1C817C:
//	.BYTE $82, $7F, $27, $F8
//UNKNOWN_1C8180:
//	.BYTE $94, $A5, $89, $48
//UNKNOWN_1C8184:
//	.BYTE $96, $AD, $7A, $58
//UNKNOWN_1C8188:
//	.BYTE $93, $A5, $99, $28
//UNKNOWN_1C818C:
//	.BYTE $9F, $84, $80, $FA
//UNKNOWN_1C8190:
//	.BYTE $94, $84, $24, $18
//UNKNOWN_1C8194:
//	.BYTE $94, $7F, $94, $18
//UNKNOWN_1C8198:
//	.BYTE $95, $B4, $57, $F8
//UNKNOWN_1C819C:
//	.BYTE $02, $7F, $67, $09
//UNKNOWN_1C81A0:
//	.BYTE $7F, $7F, $E1, $0A
//UNKNOWN_1C81A4:
//	.BYTE $7F, $7F, $21, $09
//UNKNOWN_1C81A8:
//	.BYTE $04, $7F, $5D, $28
//UNKNOWN_1C81AC:
//	.BYTE $03, $7F, $38, $28

//HandleTriangleSFX:
//	LDX #$03
//	LDA #.LOBYTE(UNKNOWN_1C8079)
//	LDY #$81
//	BNE UNKNOWN0_1C81D3
//HandlePulseGroup1SFX:
//	LDX #$04
//	LDA #.LOBYTE(UNKNOWN_1C8089)
//	LDY #$8F
//	BNE UNKNOWN0_1C81D3
//HandlePulseGroup0SFX:
//	LDA UNKNOWN_07F8+4
//	BNE UNKNOWN_1C81B0_RET
//	LDX #$01
//	LDA #.LOBYTE(UNKNOWN_1C8031)
//	LDY #$55
//	BNE UNKNOWN0_1C81D3
//HandleNoiseSFX:
//	LDX #$00
//	LDA #.LOBYTE(UNKNOWN_1C8009)
//	LDY #$1D
//UNKNOWN0_1C81D3:
//	STA $B0
//	STX $BD
//	LDA UNKNOWN_07EF+1,X
//	BEQ UNKNOWN_1C820D
//UNKNOWN0_1C81DC:
//	STA $BF
//	STA $B2
//	LDY #$80
//	STY $B1
//	AND #$07
//	TAY
//	LDA UNKNOWN_1C8205,Y
//	TAY
//	DEC $B2
//	LDA $B2
//	AND #$F8
//	STA $B2
//	ASL $B2
//	TYA
//	ORA $B2
//	TAY
//	LDA ($B0),Y
//	STA $B2
//	INY
//	LDA ($B0),Y
//	STA $B3
//	JMP ($00B2)

//UNKNOWN_1C8205:
//	.BYTE $0E, $00, $02, $04, $06, $08, $0A, $0C

//UNKNOWN_1C820D:
//	LDA UNKNOWN_07F8,X
//	BEQ UNKNOWN_1C81B0_RET
//	STY $B0
//	BNE UNKNOWN0_1C81DC

void ActualMusicInit() @safe {
    nes.SND_CHN = 0xf;
    unk_bb[0] = 0x55;

    currptr_pulse1_blank = [0,0];
    currptr_triangle_blank = [0,0];

    //copy Ocarina_Missing_List to ntbl_xc
    // ubyte y_reg = 0;
    // @copy:
    // lda Ocarina_Missing_List, y
    // sta ntbl_xc, y
    // iny
    // tya
    // cmp #10*2
    // bne @copy

    return B28_0299();
}


//UNKNOWN_1C8238:
//	.WORD UNKNOWN_1C935A
//	.WORD UNKNOWN_1C9365
//	.WORD UNKNOWN_1C9370
//	.WORD UNKNOWN_1C937C
//	.WORD UNKNOWN_1C9388
//	.WORD UNKNOWN_1C9391
//	.WORD UNKNOWN_1C939E
//	.WORD UNKNOWN_1C93AA

void B28_0248() @safe{
	//ocarina handler probably
    // unk_b0 = learned_melodies;
	// ubyte y_reg = 0;
    // goto B28_025d
    // @B28_0251:
    // lda #<mus_ocarina_missing
    // sta ntbl_xe, y
    // iny
    // lda #>mus_ocarina_missing
    // sta ntbl_xe, y
    // iny
    // B28_025d:
    // tya
    // cmp #$10
    // beq @B28_0276
    // lsr unk_b0
    // bcc @B28_0251
    // lda B28_0238, y
    // sta ntbl_xe, y
    // iny
    // lda B28_0238, y
    // sta ntbl_xe, y
    // iny
    // bne @B28_025d
    // @B28_0276:
}

//	LDA $761E
//UNKNOWN_1C824B:
//	STA $B0
//	LDY #$00
//	BEQ @UNKNOWN1
//@UNKNOWN0:
//	LDA #$42
//	STA $076E,Y
//	INY
//	LDA #$93
//	STA $076E,Y
//	INY
//@UNKNOWN1:
//	TYA
//	CMP #$10
//	BEQ @UNKNOWN2
//	LSR $B0
//	BCC @UNKNOWN0
//	LDA UNKNOWN_1C8238,Y
//	STA $076E,Y
//	INY
//	LDA UNKNOWN_1C8238,Y
//	STA $076E,Y
//	INY
//	BNE @UNKNOWN1
//@UNKNOWN2:
//	RTS

void ActualMusicTick() @safe {
    a_reg = 0xc0;
	//APU "frame counter". Select "one 5-step sequence" (whatever that means) and clear interrupt flag
    nes.JOY2 = a_reg;

    TickRNG();
    //HandleNoiseSFX();
    //HandlePulseGroup1SFX();
    //HandleTriangleSFX();
    //HandlePulseGroup0SFX();
    HandleMusic();

	soundqueue_noise = 0;
	soundqueue_pulseg0 = 0;
	soundactive_unk = 0;
	soundqueue_triangle = 0;
	soundqueue_pulseg1 = 0;
	soundqueue_track = 0;
    a_reg = 0;
    x_reg = 0;
}

void B28_0299() @safe {
    B28_02a8();
	return VolEnvInit();
}
//fallthrough
void VolEnvInit() @safe {
    VolInit();
    nes.DMC_RAW = 0;
    ME_Envelopes0[2] = 0;
}

void B28_02a8() @safe {
    unk_7c7[1] = 0;
    unk_7c7[2] = 0;
    unk_7c7[3] = 0;

    current_music = 0;
    currptr_triangle_blank = [0,0];
    // Set all sounds and music to be inactive

	soundqueue_noise = 0;
	soundqueue_pulseg0 = 0;
	soundactive_unk = 0;
	soundqueue_triangle = 0;
	soundqueue_pulseg1 = 0;
	soundqueue_track = 0;
}

void VolInit() @safe {
    nes.DMC_RAW = 0;
    nes.SQ1_VOL = 0x10;
    nes.SQ2_VOL = 0x10;
    nes.NOISE_VOL = 0x10;
    nes.TRI_LINEAR = 0;
}

//UNKNOWN_1C82DC:
//	LDX $BD
//	STA UNKNOWN_07D5,X
//	TXA
//	STA UNKNOWN_07C7,X
//	TYA
//	BEQ UNKNOWN_1C830A
//	TXA
//	BEQ UNKNOWN_1C8309
//	CMP #$01
//	BEQ UNKNOWN_1C82F8
//	CMP #$02
//	BEQ UNKNOWN_1C82FD
//	CMP #$03
//	BEQ UNKNOWN_1C8304
//	RTS

//UNKNOWN_1C82F8:
//	JSR SetSQ1Registers
//	BEQ UNKNOWN_1C830A
//UNKNOWN_1C82FD:
//	JSR SetSQ2Registers
//	BEQ UNKNOWN_1C830A
//UNKNOWN_1C8304:
//	JSR SetTRIRegisters
//	BEQ UNKNOWN_1C830A
//UNKNOWN_1C8309:
//	JSR SetNOISERegisters
//UNKNOWN_1C830A:
//	LDA $BF
//	STA UNKNOWN_07F8,X
//	LDA #$00
//	STA UNKNOWN_07DA,X
//UNKNOWN_1C8314:
//	STA UNKNOWN_07DF,X
//	STA UNKNOWN_07E3,X
//	STA UNKNOWN_07E7,X
//	STA $078A
//UNKNOWN_1C8320:
//	RTS

//UNKNOWN_1C8321:
//	  LDA #$30
//	  LDY #.LOBYTE(UNKNOWN_1C811C)
//	  JMP UNKNOWN_1C82DC
//UNKNOWN_1C8328:
//	  LDA #$0C
//	  LDY #.LOBYTE(UNKNOWN_1C8114)
//	  JMP UNKNOWN_1C82DC
//UNKNOWN_1C832F:
//	  JSR UNKNOWN_1C80D3
//	  BNE UNKNOWN_1C8320
//	  LDY #$14
//	  JSR SetNOISERegisters
//	  INC UNKNOWN_07DF
//	  LDA UNKNOWN_07DF
//	  CMP #$04
//	  BNE UNKNOWN_1C8320
//	  JMP UNKNOWN_1C8415
//UNKNOWN_1C8346:
//	  LDA #$04
//	  LDY #.LOBYTE(UNKNOWN_1C8114)
//	  JSR UNKNOWN_1C82DC
//	  LDA #$02
//	  STA UNKNOWN_07EF+4
//	  LDA $BB
//	  AND #$F7
//UNKNOWN_1C8356:
//	  AND #$0F
//	  STA NOISE_LO
//	  RTS

//UNKNOWN_1C835C:
//	LDA #$06
//	LDY #.LOBYTE(UNKNOWN_1C8118)
//	JSR UNKNOWN_1C82DC
//	LDA UNKNOWN_1C8118 + 2
//	STA UNKNOWN_07DF
//	LDA UNKNOWN_1C8118
//	STA UNKNOWN_07E3
//UNKNOWN_1C836F:
//	RTS

//UNKNOWN_1C8370:
//	LDA #$86
//	BNE UNKNOWN_1C8390
//UNKNOWN_1C8374:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C836F
//	INC UNKNOWN_07DF
//	INC UNKNOWN_07E3
//	LDA UNKNOWN_07E3
//	CMP #$19
//	BNE @UNKNOWN1
//	JMP UNKNOWN_1C8415
//@UNKNOWN1:
//	STA NOISE_VOL
//	LDA UNKNOWN_07DF
//UNKNOWN_1C8390:
//	STA NOISE_LO
//	RTS

//UNKNOWN_1C8393:
//	LDA #$05
//	LDY #.LOBYTE(UNKNOWN_1C810C)
//	JSR UNKNOWN_1C82DC
//	LDA UNKNOWN_1C810C + 2
//	STA UNKNOWN_07DF
//UNKNOWN_1C83A0:
//	RTS

//UNKNOWN_1C83A1:
//	LDA UNKNOWN_07E7
//	CMP #$02
//	BEQ UNKNOWN_1C83B1
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C83A0
//	INC UNKNOWN_07E7
//	RTS
//UNKNOWN_1C83B1:
//	JSR UNKNOWN_1C80D3
//	BNE @UNKNOWN1
//	DEC UNKNOWN_07DF
//	DEC UNKNOWN_07DF
//	DEC UNKNOWN_07DF
//	INC UNKNOWN_07E3
//	LDA UNKNOWN_07E3
//	CMP #$0F
//	BNE UNKNOWN_1C83A0
//	JMP UNKNOWN_1C8436
//@UNKNOWN1:
//	INC UNKNOWN_07DF
//	LDA UNKNOWN_07DF
//UNKNOWN_1C83D2:
//	STA NOISE_LO
//UNKNOWN_1C83D5:
//	RTS

//UNKNOWN_1C83D6:
//	JSR UNKNOWN_1C845C
//	JMP UNKNOWN_1C83D2
//UNKNOWN_1C83DC:
//	LDA #$03
//	LDY #.LOBYTE(UNKNOWN_1C8110)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C83E3:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C83D5
//	INC UNKNOWN_07DF
//	LDA UNKNOWN_07DF
//	ORA #$10
//	STA NOISE_VOL
//	CMP #$10
//	BNE UNKNOWN_1C83D5
//	JMP UNKNOWN_1C8415
//UNKNOWN_1C83FA:
//	LDA #$10
//	LDY #.LOBYTE(UNKNOWN_1C8108)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C8401:
//	JSR UNKNOWN_1C80D3
//	BEQ UNKNOWN_1C8415
//	LDX #$81
//	JSR UNKNOWN_1C83D6
//	LDX #$89
//	JMP UNKNOWN_1C8450
//UNKNOWN_1C8410:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C841F
//UNKNOWN_1C8415:
//	LDA #$00
//	STA UNKNOWN_07F8
//	LDA #$10
//	STA NOISE_VOL
//UNKNOWN_1C841F:
//	RTS

//UNKNOWN_1C8420:
//	LDA #$20
//	LDY #.LOBYTE(UNKNOWN_1C8108)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C8427:
//	JSR UNKNOWN_1C80D3
//	BEQ UNKNOWN_1C8415
//	LDX #$91
//	JSR UNKNOWN_1C83D6
//	LDX #$A1
//	JMP UNKNOWN_1C8450
//UNKNOWN_1C8436:
//	LDA #$02
//	STA $BF
//UNKNOWN_1C843A:
//	LDA #$40
//	LDY #.LOBYTE(UNKNOWN_1C8108)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C8441:
//	JSR UNKNOWN_1C80D3
//	BNE @UNKNOWN1
//	JMP UNKNOWN_1C8415
//@UNKNOWN1:
//	LDX #$B1
//	JSR UNKNOWN_1C83D6
//	LDX #$D1
//UNKNOWN_1C8450:
//	JSR UNKNOWN_1C845C
//	ORA #$10
//	STA NOISE_VOL
//	INC UNKNOWN_07DF
//	RTS

//UNKNOWN_1C845C:
//	STX $B0
//	LDY #$C1
//	STY $B1
//	LDX UNKNOWN_07DF
//	TXA
//	LSR
//	TAY
//	LDA ($B0),Y
//	STA $B4
//	TXA
//	AND #$01
//	BEQ @UNKNOWN0
//	LDA $B4
//	AND #$0F
//	RTS
//@UNKNOWN0:
//	LDA $B4
//	LSR
//	LSR
//	LSR
//	LSR
//UNKNOWN_1C847C:
//	RTS

//UNKNOWN_1C847D:
//	LDA #$08
//	LDY #.LOBYTE(UNKNOWN_1C8104)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C8484:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C847C
//	LDA UNKNOWN_07DF
//	INC UNKNOWN_07DF
//	CMP #$28
//	BEQ @UNKNOWN5
//	CMP #$10
//	BEQ @UNKNOWN3
//	CMP #$18
//	BEQ @UNKNOWN2
//	CMP #$20
//	BEQ @UNKNOWN1
//	CMP #$10
//	BCS UNKNOWN_1C847C
//	JMP UNKNOWN_1C8356
//@UNKNOWN1:
//	LDA #$31
//	BNE @UNKNOWN4
//@UNKNOWN2:
//	LDA #$32
//	BNE @UNKNOWN4
//@UNKNOWN3:
//	LDA #$33
//@UNKNOWN4:
//	STA NOISE_VOL
//	LDA #$0F
//	STA NOISE_LO
//	RTS
//@UNKNOWN5:
//	JMP UNKNOWN_1C8415

//UNKNOWN_1C84BC:
//	STA UNKNOWN_07D5+4
//	JSR SetSQ2Registers
//	LDA $BF
//	STA UNKNOWN_07F8+4
//	LDX #$01
//	STX UNKNOWN_07C7+1
//	INX
//	STX UNKNOWN_07C7+2
//	LDA #$00
//	STA UNKNOWN_07DA+4
//	STA UNKNOWN_07F8+1
//	LDX #$01
//	JMP UNKNOWN_1C8314

//UNKNOWN_1C84DD:
//	JSR UNKNOWN_1C8688
//	JSR UNKNOWN_1C8840
//	INC $078A
//	LDA #$00
//	STA UNKNOWN_07F8+4
//	LDX #$01
//	LDA #$7F
//UNKNOWN_1C84EF:
//	STA SQ1,X
//	STA SQ2,X
//	RTS

//UNKNOWN_1C84F6:
//	LDY #$24
//	JSR SetSQ1Registers
//	LDA #$0A
//	LDY #$20
//	JSR UNKNOWN_1C84BC
//	LDA UNKNOWN_1C8120
//	STA UNKNOWN_07DF+1
//UNKNOWN_1C8508:
//	RTS

//UNKNOWN_1C8509:
//	JSR UNKNOWN_1C80D3
//	BNE @UNKNOWN3
//	LDA UNKNOWN_07E3+1
//	BEQ @UNKNOWN0
//	DEC UNKNOWN_07DF+1
//	BNE @UNKNOWN1
//@UNKNOWN0:
//	INC UNKNOWN_07DF+1
//@UNKNOWN1:
//	LDA UNKNOWN_07DF+1
//	CMP #$B0
//	BNE @UNKNOWN2
//	JMP UNKNOWN_1C84DD
//@UNKNOWN2:
//	STA SQ1_VOL
//	STA SQ2_VOL
//	CMP #$BF
//	BNE UNKNOWN_1C8508
//	INC UNKNOWN_07E3+1
//	RTS
//@UNKNOWN3:
//	LDY #$1A
//	LDA UNKNOWN_07DA+4
//	AND #$01
//	BNE @UNKNOWN4
//	LDY #$1B
//@UNKNOWN4:
//	STY SQ1_LO
//	RTS

//UNKNOWN_1C8542:
//	LDY #$30
//	JSR SetSQ1Registers
//	LDA #$08
//	LDY #$34
//	BNE UNKNOWN_1C8556
//UNKNOWN_1C854D:
//	LDY #$2C
//	JSR SetSQ1Registers
//	LDA #$03
//	LDY #$28
//UNKNOWN_1C8556:
//	JMP UNKNOWN_1C84BC

//UNKNOWN_1C8559:
//	JSR UNKNOWN_1C857E
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C857E
//	LDX #$00
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$12
//	BEQ @UNKNOWN0
//	CMP #$0E
//	BCC @UNKNOWN1
//	LDA #$BE
//	JMP UNKNOWN_1C84EF
//@UNKNOWN0:
//	JMP UNKNOWN_1C84DD
//@UNKNOWN1:
//	ORA #$B0
//	JMP UNKNOWN_1C84EF
//UNKNOWN_1C857E:
//	INC UNKNOWN_07E3+1
//	LDA UNKNOWN_07E3+1
//	AND #$07
//	TAY
//	LDA UNKNOWN_1C859C,Y
//	CLC
//	ADC UNKNOWN_1C8128 + 2
//	STA SQ1_LO
//	LDA UNKNOWN_1C859C,Y
//	CLC
//	ADC UNKNOWN_1C812C + 2
//	STA SQ2_LO
//UNKNOWN_1C859B:
//	RTS

//UNKNOWN_1C859C:
//	.BYTE $00, $01, $02, $01, $00, $FF, $FE, $FF

//UNKNOWN_1C85A4:
//	LDA #$0A
//	LDY #.LOBYTE(UNKNOWN_1C8198)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C85AB:
//	.BYTE $14, $93, $94, $D3

//UNKNOWN_1C85AF:
//	LDA UNKNOWN_07E3+1
//	BEQ @UNKNOWN1
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$16
//	BNE UNKNOWN_1C859B
//	JMP UNKNOWN_1C8688
//@UNKNOWN1:
//	LDA UNKNOWN_07DF+1
//	AND #$03
//	TAY
//	LDA UNKNOWN_1C85AB,Y
//	STA SQ1_VOL
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$08
//	BNE UNKNOWN_1C859B
//	INC UNKNOWN_07E3+1
//	LDY #$7C
//	JMP SetSQ1Registers
//UNKNOWN_1C85DF:
//	LDA #$02
//	LDY #.LOBYTE(UNKNOWN_1C8190)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C85E6:
//	LDY #.LOBYTE(UNKNOWN_1C8178)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C85EB:
//	LDA #$04
//	LDY #.LOBYTE(UNKNOWN_1C8164)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C85F2:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C866D
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$01
//	BEQ @UNKNOWN2
//	CMP #$04
//	BNE UNKNOWN_1C866D
//	JMP UNKNOWN_1C8688
//@UNKNOWN2:
//	LDY #$68
//	JMP SetSQ1Registers

//UNKNOWN_1C860D:
//	INC $078B
//UNKNOWN_1C8610:
//	LDA #$0F
//	LDY #.LOBYTE(UNKNOWN_1C8144)
//	JSR UNKNOWN_1C82DC
//	LDA UNKNOWN_1C8144 + 2
//UNKNOWN_1C861A:
//	STA UNKNOWN_07E7+1
//UNKNOWN_1C861D:
//	RTS

//UNKNOWN_1C861E:
//	JSR UNKNOWN_1C80D3
//	BNE @UNKNOWN7
//	INC UNKNOWN_07E3+1
//	LDA UNKNOWN_07E3+1
//	CMP #$08
//	BEQ @UNKNOWN6
//	CMP #$24
//	BEQ @UNKNOWN4
//@UNKNOWN1:
//	AND #$01
//	BEQ @UNKNOWN2
//	LDA UNKNOWN_1C8148 + 2
//	LDY #$48
//	BNE @UNKNOWN3
//@UNKNOWN2:
//	LDA UNKNOWN_1C8144 + 2
//	LDY #$44
//@UNKNOWN3:
//	PHA
//	JSR SetSQ1Registers
//	PLA
//	BNE UNKNOWN_1C861A
//@UNKNOWN4:
//	LDA $078B
//	BEQ @UNKNOWN5
//	LDA #$00
//	STA $078B
//	LDA #$25
//	STA UNKNOWN_07F5
//@UNKNOWN5:
//	JMP UNKNOWN_1C8688
//@UNKNOWN6:
//	LDA #$02
//	STA UNKNOWN_07D5+1
//	BNE @UNKNOWN1
//@UNKNOWN7:
//	DEC UNKNOWN_07E7+1
//	DEC UNKNOWN_07E7+1
//	LDA UNKNOWN_07E7+1
//	STA SQ1_LO
//UNKNOWN_1C866D:
//	RTS

//UNKNOWN_1C866E:
//	LDA UNKNOWN_07F8+1
//	CMP #$07
//	BEQ UNKNOWN_1C866D
//	LDA #$02
//	LDY #.LOBYTE(UNKNOWN_1C8194)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C867C:
//	LDA #$10
//	LDY #.LOBYTE(UNKNOWN_1C818C)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C8683:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C8698
//UNKNOWN_1C8688:
//	LDA #$10
//	STA SQ1_VOL
//	LDA #$00
//	STA UNKNOWN_07C7+1
//	STA UNKNOWN_07F8+1
//	INC $078A
//UNKNOWN_1C8698:
//	RTS

//UNKNOWN_1C8699:
//	LDA #$06
//	LDY #.LOBYTE(UNKNOWN_1C8180)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C86A0:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C8698
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$01
//	BEQ @UNKNOWN1
//	CMP #$02
//	BEQ @UNKNOWN2
//	CMP #$03
//	BNE UNKNOWN_1C8698
//	JMP UNKNOWN_1C8688
//@UNKNOWN1:
//	LDY #$84
//	JMP SetSQ1Registers
//@UNKNOWN2:
//	LDY #$88
//	JMP SetSQ1Registers
//UNKNOWN_1C86C4:
//	LDA #$08
//	LDY #.LOBYTE(UNKNOWN_1C816C)
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C86CB:
//	JSR UNKNOWN_1C80D3
//	BEQ @UNKNOWN4
//	LDA UNKNOWN_07E7+1
//	CMP #$02
//	BNE @UNKNOWN3
//	LDA #$00
//	STA UNKNOWN_07E7+1
//	LDY UNKNOWN_07E3+1
//	INC UNKNOWN_07E3+1
//	LDA UNKNOWN_1C80FA,Y
//	STA SQ1_SWEEP
//	RTS
//@UNKNOWN3:
//	INC UNKNOWN_07E7+1
//	RTS
//@UNKNOWN4:
//	LDA #$00
//	STA UNKNOWN_07E3+1
//	LDA UNKNOWN_07DF+1
//	BEQ @UNKNOWN5
//	CMP #$01
//	BEQ @UNKNOWN6
//	CMP #$02
//	BNE UNKNOWN_1C870E
//	JMP UNKNOWN_1C8688
//@UNKNOWN5:
//	LDY #$70
//	BNE @UNKNOWN7
//@UNKNOWN6:
//	LDY #$74
//@UNKNOWN7:
//	JSR SetSQ1Registers
//	INC UNKNOWN_07DF+1
//UNKNOWN_1C870E:
//	RTS

//UNKNOWN_1C870F:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C870E
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_07DF+1
//	CMP #$02
//	BNE UNKNOWN_1C8721
//	JMP UNKNOWN_1C8688
//UNKNOWN_1C8721:
//	LDY #$50
//	JMP SetSQ1Registers
//UNKNOWN_1C8726:
//	LDA UNKNOWN_07F8+1
//	CMP #$07
//	BEQ UNKNOWN_1C870E
//	LDA #$03
//	LDY #$4C
//	BNE UNKNOWN_1C875B
//UNKNOWN_1C8733:
//	LDA #$10
//	LDY #$3C
//	JSR UNKNOWN_1C875B
//	LDA #$18
//	BNE UNKNOWN_1C877B
//UNKNOWN_1C873E:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C877E
//	LDY #$3C
//	BNE UNKNOWN_1C8786
//UNKNOWN_1C8747:
//	LDA #$06
//	LDY #$58
//	JSR UNKNOWN_1C875B
//	LDA #$10
//	BNE UNKNOWN_1C877B
//UNKNOWN_1C8752:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C877E
//	LDY #$58
//	BNE UNKNOWN_1C8786
//UNKNOWN_1C875B:
//	JMP UNKNOWN_1C82DC
//UNKNOWN_1C875E:
//	LDA #$05
//	LDY #$5C
//	JSR UNKNOWN_1C875B
//	LDA #$08
//	BNE UNKNOWN_1C877B
//UNKNOWN_1C8769:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C877E
//	LDY #$5C
//	BNE UNKNOWN_1C8786
//UNKNOWN_1C8772:
//	LDA #$06
//	LDY #$60
//	JSR UNKNOWN_1C875B
//	LDA #$00
//UNKNOWN_1C877B:
//	STA UNKNOWN_07E3+1
//UNKNOWN_1C877E:
//	RTS
//UNKNOWN_1C877F:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C877E
//	LDY #$60
//UNKNOWN_1C8786:
//	JSR SetSQ1Registers
//	CLC
//	LDA UNKNOWN_07E3+1
//	ADC UNKNOWN_07DF+1
//	TAY
//	LDA UNKNOWN_1C87EE,Y
//	STA SQ1_LO
//	LDY UNKNOWN_07DF+1
//	LDA UNKNOWN_1C87E5,Y
//	STA SQ1_VOL
//	BNE @UNKNOWN6
//	JMP UNKNOWN_1C8688
//@UNKNOWN6:
//	INC UNKNOWN_07DF+1
//UNKNOWN_1C87A8:
//	RTS

//UNKNOWN_1C87A9:
//	LDA #$04
//	LDY #.LOBYTE(UNKNOWN_1C8154)
//	JSR UNKNOWN_1C82DC
//	LDA UNKNOWN_1C8154 + 2
//	STA UNKNOWN_07DF+1
//	RTS

//UNKNOWN_1C87B7:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C87A8
//	INC UNKNOWN_07E3+1
//	LDA UNKNOWN_07E3+1
//	CMP #$05
//	BNE @UNKNOWN0
//	JMP UNKNOWN_1C8688
//@UNKNOWN0:
//	LDA UNKNOWN_07DF+1
//	LSR
//	LSR
//	LSR
//	STA UNKNOWN_07E7+1
//	LDA UNKNOWN_07DF+1
//	CLC
//	SBC UNKNOWN_07E7+1
//	STA UNKNOWN_07DF+1
//	STA SQ1_LO
//	LDA #$28
//UNKNOWN_1C87E1:
//	STA SQ1_HI
//UNKNOWN_1C87E3:
//	RTS

//UNKNOWN_1C87E5:
//	.BYTE $9E, $9B, $99, $96, $94, $93, $92, $91, $00

//UNKNOWN_1C87EE:
//	.BYTE $20, $40, $20, $40, $20, $40, $20, $40, $90, $60, $90, $90, $60, $80, $90, $60, $B0, $79, $A8, $58, $90, $40, $80, $30, $76, $9F, $58, $76, $42, $58, $31, $42

//UNKNOWN_1C880E:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C87E3

//UNKNOWN_1C8813:
//	LDY UNKNOWN_07DF+1
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_1C8830,Y
//	BEQ @UNKNOWN0
//	STA SQ1_LO
//	LDA #$88
//	JMP UNKNOWN_1C87E1
//@UNKNOWN0:
//	JMP UNKNOWN_1C8688

//UNKNOWN_1C8829:
//	LDA #$04
//	LDY #.LOBYTE(UNKNOWN_1C8140)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C8830:
//	.BYTE $A8, $96, $70, $53, $4A, $37, $29, $E1, $A8, $96, $70, $53, $4A, $37, $29, $00

//UNKNOWN_1C8840:
//	LDA #$10
//	STA SQ2_VOL
//	LDA #$00
//	STA UNKNOWN_07C7+2
//	STA UNKNOWN_07F8+2
//	RTS

//UNKNOWN_1C884E:
//	LDA #$04
//	LDY #.LOBYTE(UNKNOWN_1C81A0)
//	JSR UNKNOWN_1C82DC
//	LDA $BB
//	STA TRI_LO
//	LDA #$0A
//	BNE UNKNOWN_1C88B0
//UNKNOWN_1C885E:
//	LDA #$04
//	LDY #.LOBYTE(UNKNOWN_1C819C)
//	JSR UNKNOWN_1C82DC
//	LDA #$08
//	STA UNKNOWN_07E3+3
//	RTS

//UNKNOWN_1C886B:
//	.BYTE $31, $3A, $42, $4A, $58, $63, $76, $85, $96, $B2, $C8, $EE, $00, $0C, $2D, $67, $93, $DF, $FF

//UNKNOWN_1C887E:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C88B3
//UNKNOWN_1C8883:
//	LDY UNKNOWN_07DF+3
//	LDA UNKNOWN_1C886B,Y
//	BEQ @UNKNOWN0
//	CMP #$FF
//	BEQ UNKNOWN_1C88A3
//	INC UNKNOWN_07DF+3
//	STA TRI_LO
//	LDA UNKNOWN_07E3+3
//	JMP UNKNOWN_1C88B0
//@UNKNOWN0:
//	INC UNKNOWN_07E3+3
//	INC UNKNOWN_07DF+3
//	BNE UNKNOWN_1C8883
//UNKNOWN_1C88A3:
//	LDA #$00
//	STA TRI_LINEAR
//	STA UNKNOWN_07C7+3
//	STA UNKNOWN_07F8+3
//	LDA #$18
//UNKNOWN_1C88B0:
//	STA TRI_HI
//UNKNOWN_1C88B3:
//	RTS

//UNKNOWN_1C88B4:
//	JSR UNKNOWN_1C80D3
//	BEQ UNKNOWN_1C88A3
//UNKNOWN_1C88B9:
//	RTS

//UNKNOWN_1C88BA:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C88B9
//	LDY UNKNOWN_07DF+3
//	INC UNKNOWN_07DF+3
//	LDA UNKNOWN_1C88DB,Y
//	BEQ UNKNOWN_1C88A3
//	STA TRI_LO
//	LDA UNKNOWN_1C81A4 + 3
//	STA TRI_HI
//	RTS

//UNKNOWN_1C88D4:
//	LDA #$03
//	LDY #.LOBYTE(UNKNOWN_1C81A4)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C88DB:
//	.BYTE $3F, $48, $52, $6D, $78, $84, $91, $AE, $BD, $00

//UNKNOWN_1C88E5:
//	LDA #$08
//	LDY #.LOBYTE(UNKNOWN_1C81A8)
//	JMP UNKNOWN_1C82DC

//UNKNOWN_1C88EC:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C88B3
//	INC UNKNOWN_07DF+3
//	LDA UNKNOWN_07DF+3
//	CMP #$02
//	BNE @UNKNOWN0
//	JMP UNKNOWN_1C88A3
//@UNKNOWN0:
//	LDY #$AC
//	JMP SetTRIRegisters

void MusMelody() @safe {
    B28_0248();
    current_music = 1;
    a_reg = 1;
    SetMusic_ID();
}

void MusInvalid() @safe {
    return B28_0299();
}

void HandleMusic() @safe {
	a_reg = soundqueue_track;
	y_reg = a_reg;
	if (a_reg >= 0x3f){
		return MusInvalid();
	}
	if (a_reg == 1){
		return MusMelody();
	}
	a_reg = y_reg;
	if (a_reg == 0){
		return MusZero();
	}
	current_music = a_reg;
	if (a_reg >= 0x19){
		unk_bf = a_reg;
		a_reg -= 0x19;
		music_id = a_reg;
		return SetMusic_ID_post();
	}
    //if playing pollyanna, check if need to play bein friends instead
	if (a_reg != 6){
		return SetMusic_ID();
	}
    //if party count != 1, play bein friends
    if (pc_count == 1){
        a_reg = 7;
		return SetMusic_ID();
	}
    a_reg = y_reg;
	return SetMusic_ID();
}

void SetMusic_ID() @safe {
    unk_bf = a_reg;
    music_id = a_reg;
    music_id--;
	return SetMusic_ID_post();
}

void SetMusic_ID_post() @safe {
    a_reg = 0x7f;
    UNK_7C0[0] = a_reg;
    UNK_7C0[1] = a_reg;
    LoadMusicHeader();
	return B28_0959();
}

void B28_0959() @safe {
	return B28_0c7b();
}

void MusZero() @safe {
	if (soundactive_track != 0){
		return B28_0959();
	}
	return;
}

//UNKNOWN_1C8962:
//	LDA #$03
//	LDY #.LOBYTE(UNKNOWN_1C8138)
//	JSR UNKNOWN_1C82DC
//	JMP UNKNOWN_1C8971

//UNKNOWN_1C896C:
//	JSR UNKNOWN_1C80D3
//	BNE UNKNOWN_1C8995
//UNKNOWN_1C8971:
//	LDA UNKNOWN_07DF+1
//	AND #$07
//	TAY
//	LDA UNKNOWN_07DF+1
//	LSR
//	LSR
//	LSR
//	TAX
//	INC UNKNOWN_07DF+1
//	LDA UNKNOWN_1C89A1,X
//	BEQ UNKNOWN_1C8996
//	STA SQ1_VOL
//	LDA UNKNOWN_1C8999,Y
//	STA SQ1_LO
//	LDA UNKNOWN_1C8138 + 3
//	STA SQ1_HI
//UNKNOWN_1C8995:
//	RTS
//UNKNOWN_1C8996:
//	JMP UNKNOWN_1C8688

//UNKNOWN_1C8999:
//	.BYTE $2C, $24, $28, $20, $24, $1C, $20, $18
//UNKNOWN_1C89A1:
//	.BYTE $1F, $19, $14, $12, $11, $00

ubyte[] Noise_Instruments = [
0x00,0x10,0x01,
0x18,0x00,0x01,
0x38,0x00,0x03,
0x40,0x00,0x06,
0x58,0x01,0x03,
0x40,0x02,0x04,
0x40,0x13,0x05,
0x40,0x14,0x0A,
0x40,0x14,0x08,
0x40,0x12,0x0E,
0x08,0x16,0x0E,
0x28,0x16,0x0B,
0x18,
];

void B28_09cc() @safe {
    a_reg = soundactive_track;
    if (a_reg == 1){
        return;
    }
    a_reg = x_reg;
    if (a_reg == 3){
        return;
    }
    a_reg = ME_Envelopes0[x_reg];
    a_reg &= 0xe0;
    if (a_reg == 0){
        return;
    }
    unk_b0 = a_reg;
    a_reg = unk_7c3[x_reg];
    if (a_reg == 2){
        unk_7d1[x_reg]++;
        return;
    }
    y_reg = unk_be;
    switch (y_reg/2){
        case 0:
            a_reg = currptr_pulse0[y_reg%2];
            break;
        case 1:
            a_reg = currptr_pulse0_blank[y_reg%2];
            break;
        case 2:
            a_reg = currptr_pulse1[y_reg%2];
            break;
        case 3:
            a_reg = currptr_pulse1_blank[y_reg%2];
            break;
        case 4:
            a_reg = currptr_triangle[y_reg%2];
            break;
        case 5:
            a_reg = currptr_triangle_blank[y_reg%2];
            break;
        default:
            break;
    }
    unk_b1 = a_reg;
    B28_0a33();
    unk_7d1[x_reg]++;
}

void UNKNOWN_1C89F6() @safe {
    a_reg = unk_b2;
    if (a_reg == 0x31){
        a_reg = 0x27;
    }
    y_reg = a_reg;
    a_reg = cast(ubyte) Pitch_Envelope_4_6[y_reg];
    a_stash ~= a_reg;
    a_reg = unk_7c3[x_reg];
    if (a_reg == 0x46){
        a_reg = a_stash.front;
	    a_stash.popFront();
        a_reg = 0;
    } else {
        a_reg = a_stash.front;
	    a_stash.popFront();
    }
    return UNKNOWN_1C8A6D();
}

void UNKNOWN_1C8A13() @safe {
    a_reg = unk_b2;
    y_reg = a_reg;
    if (a_reg < 0x10){
        a_reg = Pitch_Envelope_2[y_reg];
    } else {
        a_reg = 0xF6;
    }
    return UNKNOWN_1C8A73();
}

void UNKNOWN_1C8A24() @safe {
    a_reg = unk_7c3[x_reg];
    if (a_reg >= 0x4c){
        a_reg = 0xfe;
    } else {
        a_reg = 0xfe;
    }
    return UNKNOWN_1C8A73();
}

void B28_0a33() @safe {
    a_reg = unk_7d1[x_reg];
    unk_b2 = a_reg;
    a_reg = unk_b0;
    if (a_reg == 0x20){
        a_reg = unk_b2;
        if (a_reg == 0xa){
            a_reg = 0;
        }
        y_reg = a_reg;
        a_reg = cast(ubyte) Pitch_Envelope_1_7[y_reg];
        return UNKNOWN_1C8A6D();
    }
    if (a_reg == 0xA0){
        a_reg = unk_b2;
        if (a_reg >= 0x2b){
            a_reg = 0x21;
        }
        y_reg = a_reg;
        //debug
        if (y_reg < Pitch_Envelope_5.length){
            a_reg = cast(ubyte) Pitch_Envelope_5[y_reg];
        } else {
            a_reg = cast(ubyte) Pitch_Envelope_1_7[y_reg - Pitch_Envelope_5.length];
        }
        return;
    }
    if (a_reg == 0x60){
        return UNKNOWN_1C8A24();
    }
    if (a_reg == 0x40){
        return UNKNOWN_1C8A13();
    }
    if (a_reg == 0x80){
        return UNKNOWN_1C89F6();
    }
    if (a_reg == 0xc0){
        return UNKNOWN_1C89F6();
    }
}

void UNKNOWN_1C8A6D() @safe {
    a_stash ~= a_reg;
    a_reg = y_reg;
    unk_7d1[x_reg] = a_reg;
    a_reg = a_stash.front;
    a_stash.popFront();
    return UNKNOWN_1C8A73();
}

void UNKNOWN_1C8A73() @safe {
    a_stash ~= a_reg;
    a_reg = unk_7c7[x_reg+1];
    if (a_reg == 0){
        a_reg += unk_b1;
        y_reg = unk_be;
        nes.writeRegisterPlatform(Register.SQ1_LO + y_reg, a_reg);
    } else {
        a_reg = a_stash.front;
	    a_stash.popFront();
    }
}

byte[] Pitch_Envelope_4_6 = [
9,8,7,6,5,4,3,2,2,1,1,0
];
byte[] Pitch_Envelope_5 = [
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
0,0,0,0,-1,0,0,0,0,1,1,0,0,0,-1,-1,
0
];
byte[] Pitch_Envelope_1_7 = [
0,1,1,2,1,0,-1,-1,-2,-1
];
byte[] Pitch_Envelope_2 = [
0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-10,-9,-10,-11 // -10 hardcoded
];

void B28_0acc() @safe {
    a_reg = music_id;
    y_reg = a_reg;
    //a_reg = Music_Table_2_Ids[Y]
//	TAY
//	LDX #$00
//@UNKNOWN0:
//	LDA UNKNOWN_1C91FE,Y
//	STA $0790,X
//	INY
//	INX
//	TXA
//	CMP #$0A
//	BNE @UNKNOWN0
}

//UNKNOWN_1C8AE4:
//	LDA #$FF
//	STA UNKNOWN_07A0,X
//	JMP UNKNOWN_1C8B65

//B28_0aec
void LoadMusicHeader() @safe {
	VolEnvInit();
	a_reg = unk_bf;
    soundactive_track = a_reg;
	if (a_reg == 0x32){
		while(x_reg != 10){
			//lda Path_To_Giegue_BGM_header, y
			//sta MusicHeader, x
			y_reg++;
			x_reg++;
			a_reg = x_reg;
		}
	} else if (a_reg >= 0x19){
		B28_0acc();
	} else {
        MusicHeader = *Music_Table_Ids[music_id];
	}
    MusicChannel_NoteLengthCounter = [1,1,1,1];
    unk_ba = 0;

    ME_CurrentPulse1Phrase = null;
    ME_CurrentPulse2Phrase = null;
    ME_CurrentTrianglePhrase = null;
    ME_CurrentNoisePhrase = null;

    x_reg = 0;
    while(x_reg != 8){
        switch(x_reg){
            case 0:
                unk_b6_pointer = MusicHeader.pulse1;
                break;
            case 2:
                unk_b6_pointer = MusicHeader.pulse2;
                break;
            case 4:
                unk_b6_pointer = MusicHeader.triangle;
                break;
            case 6:
                unk_b6_pointer = MusicHeader.noise;
                break;
            default:
                break;
        }
        if ((*unk_b6_pointer)[GetInstrumentTrack(x_reg/2)].f == -1){
            a_reg = 0xff;
            switch(x_reg){
                case 0:
                    ME_CurrentPulse1Phrase = null;
                    break;
                case 2:
                    ME_CurrentPulse2Phrase = null;
                    break;
                case 4:
                    ME_CurrentTrianglePhrase = null;
                    break;
                case 6:
                    ME_CurrentNoisePhrase = null;
                    break;
                default:
                    break;
            }
        } else {
            switch(x_reg){
                case 0:
                    y_reg = ME_Pulse1Index;
                    ME_CurrentPulse1Phrase = unk_b6_pointer;
                    break;
                case 2:
                    y_reg = ME_Pulse2Index;
                    ME_CurrentPulse2Phrase = unk_b6_pointer;
                    break;
                case 4:
                    y_reg = ME_TriangleIndex;
                    ME_CurrentTrianglePhrase = unk_b6_pointer;
                    break;
                case 6:
                    y_reg = ME_NoiseIndex;
                    ME_CurrentNoisePhrase = unk_b6_pointer;
                    break;
                default:
                    break;
            }
        }
        y_reg++;

        x_reg++;
        x_reg++;
    }
}

void B28_0b70() @safe {
    a_reg = currptr_triangle_blank[0];
    if (a_reg == 0){
        return;
    }
    if (a_reg != 1){
        a_reg = 0x7f;
        nes.SQ2_SWEEP = a_reg;
        a_reg = currptr_pulse1[0];
        nes.SQ2_LO = a_reg;
        a_reg = currptr_pulse1[1];
        nes.SQ2_HI = a_reg;
    } else {
        a_reg = 0x7f;
        nes.SQ1_SWEEP = a_reg;
        a_reg = currptr_pulse0[0];
        nes.SQ1_LO = a_reg;
        a_reg = currptr_pulse0[1];
        nes.SQ1_HI = a_reg;
        a_reg = 0;
        currptr_triangle_blank[0] = a_reg;
    }
}

void B28_0ba1() @safe {
    a_reg = x_reg;
    if (a_reg >= 2){
        return;
    }
    a_reg = ME_Envelopes0[x_reg];
    a_reg &= 0x1f;
    if (a_reg == 0){
        goto UNKNOWN6;
    }
    unk_b1 = a_reg;
    a_reg = unk_7c3[x_reg];
    if (a_reg == 2){
        goto UNKNOWN9;
    }
    y_reg = 0;
    UNKNOWN1:
    unk_b1--;
    if (unk_b1 == 0){
        goto UNKNOWN2;
    }
    y_reg++;
    y_reg++;
    if (y_reg != 0){
        goto UNKNOWN1;
    }
    UNKNOWN2:
    unk_b2_pointer = Volume_Envelope_Table[y_reg/2];

    a_reg = unk_7cd[x_reg];
    a_reg >>= 1;
    y_reg = a_reg;
    unk_b4 = (*unk_b2_pointer)[y_reg/2];
    if (a_reg == 0xff){
        goto UNKNOWN7;
    }
    if (a_reg == 0xf0){
        goto UNKNOWN8;
    }
    a_reg = unk_7cd[x_reg];
    a_reg &= 1;
    if (a_reg != 0){
        goto UNKNOWN3;
    }
    unk_b4 >>= 4;
    UNKNOWN3:
    unk_b0 = unk_b4 & 0xf;
    a_reg = (ME_Envelopes1[x_reg] & 0xf0) | unk_b0;
    y_reg = a_reg;
    UNKNOWN4:
    unk_7cd[x_reg]++;
    UNKNOWN5:
    a_reg = unk_7c7[x_reg+1];
    if (a_reg != 0){
        goto UNKNOWN6;
    }
    a_reg = y_reg;
    y_reg = unk_be;
    switch(y_reg){
        case 0:
            nes.SQ1_VOL = a_reg;
            break;
        case 4:
            nes.SQ2_VOL = a_reg;
            break;
        case 8:
            nes.TRI_LINEAR = a_reg;
            break;
        case 12:
            nes.NOISE_VOL = a_reg;
            break;
        default:
            break;
    }
    UNKNOWN6:
    return;
    UNKNOWN7:
    y_reg = ME_Envelopes1[x_reg];
    if (y_reg != 0){
        goto UNKNOWN5;
    }
    UNKNOWN8:
    y_reg = 0x10;
    goto UNKNOWN5;
    UNKNOWN9:
    y_reg = 0x10;
    goto UNKNOWN4;
}

//ran when a loop point is found in a list of phrases
void DoLoop() @safe {
    //get 'loop point' address
    //must be directly after -1
    y_reg++;
    y_reg++;

    //????
    //y_reg = (*unk_b6_pointer)[y_reg/2].f;
//	LDA ($B6),Y
//	STA UNKNOWN_0792,X
//	INY
//	LDA ($B6),Y
//	STA UNKNOWN_0792+1,X
//	LDA UNKNOWN_0792,X
//	STA $B6
//	LDA UNKNOWN_0792+1,X
//	STA $B7

    // a_reg = 0;
    // y_reg = a_reg;
    switch(x_reg){
        case 0:
            ME_Pulse1Index = cast(ubyte) ((*unk_b6_pointer)[(GetInstrumentTrack(x_reg/2))+1].f*2);
            break;
        case 2:
            ME_Pulse2Index = cast(ubyte) ((*unk_b6_pointer)[(GetInstrumentTrack(x_reg/2))+1].f*2);
            break;
        case 4:
            ME_TriangleIndex = cast(ubyte) ((*unk_b6_pointer)[(GetInstrumentTrack(x_reg/2))+1].f*2);
            break;
        case 6:
            ME_NoiseIndex = cast(ubyte) ((*unk_b6_pointer)[(GetInstrumentTrack(x_reg/2))+1].f*2);
            break;
        default:
            break;
    }
    a_reg = x_reg;
    a_reg >>= 1;
    x_reg = a_reg;
    a_reg = 0;
    y_reg = a_reg;
    return UNKNOWN_1C8C53();
}

void UNKNOWN_1C8C36() @safe {
    B28_0299();
}

//Next Phrase?
void B28_0c3a() @safe {
    a_reg = x_reg;
    a_reg <<= 1;
    x_reg = a_reg;
    switch(x_reg){
        case 0:
            unk_b6_pointer = MusicHeader.pulse1;
            break;
        case 2:
            unk_b6_pointer = MusicHeader.pulse2;
            break;
        case 4:
            unk_b6_pointer = MusicHeader.triangle;
            break;
        case 6:
            unk_b6_pointer = MusicHeader.noise;
            break;
        default:
            break;
    }
    a_reg = x_reg;
    a_reg >>= 1;
    x_reg = a_reg;
    switch(x_reg){
        case 0:
            ME_Pulse1Index += 2;
            y_reg = ME_Pulse1Index;
            break;
        case 1:
            ME_Pulse2Index += 2;
            y_reg = ME_Pulse2Index;
            break;
        case 2:
            ME_TriangleIndex += 2;
            y_reg = ME_TriangleIndex;
            break;
        case 3:
            ME_NoiseIndex += 2;
            y_reg = ME_NoiseIndex;
            break;
        default:
            break;
    }
    return UNKNOWN_1C8C53();
}

void UNKNOWN_1C8C53() @safe {
    a_reg = x_reg;
    a_reg <<= 1;
    x_reg = a_reg;
    a_reg = cast(ubyte) (*unk_b6_pointer)[GetInstrumentTrack(x_reg/2)].f;
    switch(x_reg){
        case 0:
            //MusicHeader.pulse1 = (*unk_b6_pointer)[y_reg].pointer;
            break;
        case 2:
            //MusicHeader.pulse2 = (*unk_b6_pointer)[y_reg].pointer;
            break;
        case 4:
            //MusicHeader.triangle = (*unk_b6_pointer)[y_reg].pointer;
            break;
        case 6:
            //MusicHeader.noise = (*unk_b6_pointer)[y_reg].pointer;
            break;
        default:
            break;
    }
    if (a_reg == 0){
        return UNKNOWN_1C8C36();
    }
    if ((cast(byte) a_reg) == -1){
        return DoLoop();
    }
    a_reg = x_reg;
    a_reg >>= 1;
    x_reg = a_reg;
    a_reg = 0;
    MusicChannel_Counter[x_reg] = a_reg;
    a_reg = 1;
    MusicChannel_NoteLengthCounter[x_reg] = a_reg;
    return UNKNOWN_1C8C95();
}

void B28_0c78() @safe {
    return B28_0c3a();
}

void B28_0c7b() @safe {
    B28_0b70();
    a_reg = 0;
    x_reg = 0;
    unk_be = a_reg;
    if (a_reg == 0){
        return UNKNOWN_1C8C95();
    }
    return UNKNOWN_1C8C85();
}

void UNKNOWN_1C8C85() @safe {
    a_reg = x_reg;
    a_reg >>= 1;
    x_reg = a_reg;
    return NextInstrumentProbably();
}

void NextInstrumentProbably() @safe {
    x_reg++;
    a_reg = x_reg;
    if (a_reg == 4){
        return;
    }
    a_reg = unk_be;
    a_reg += 4;
    unk_be = a_reg;
    return UNKNOWN_1C8C95();
}
void UNKNOWN_1C8C95() @safe {
    a_reg = x_reg;
    a_reg <<= 1;
    x_reg = a_reg;
    switch(x_reg){
        case 0:
            unk_b6_pointer = ME_CurrentPulse1Phrase;
            break;
        case 2:
            unk_b6_pointer = ME_CurrentPulse2Phrase;
            break;
        case 4:
            unk_b6_pointer = ME_CurrentTrianglePhrase;
            break;
        case 6:
            unk_b6_pointer = ME_CurrentNoisePhrase;
            break;
        default:
            break;
    }
    if ((*unk_b6_pointer)[GetInstrumentTrack(x_reg/2)].f == 0xff){
        return UNKNOWN_1C8C85();
    }
    a_reg = x_reg;
    a_reg >>= 1;
    x_reg = a_reg;
    MusicChannel_NoteLengthCounter[x_reg]--;
    if (MusicChannel_NoteLengthCounter[x_reg] != 0){
        return StillPlaying();
    }
    a_reg = 0;
    unk_7cd[x_reg] = a_reg;
    unk_7d1[x_reg] = a_reg;
    return CmdInterpret();
}

//B28_0cb9
void CmdInterpret() @safe {
    start:
    //interpret music commands
    a_reg = ReadByte();
    //debug
    //writeln(a_reg, " this byte is for");
    switch(x_reg){
        case 0:
            current_instrument = "pulse1";
            break;
        case 1:
            current_instrument = "pulse2";
            break;
        case 2:
            current_instrument = "triangle";
            break;
        case 3:
            current_instrument = "noise";
            break;
        default:
            break;
    }
    if (a_reg == 0){
        return B28_0c78();
    }
    if (a_reg == 0x9f){
        Set_Timbre();
        goto start;
    }
    if (a_reg == 0x9e){
        SetNLT();
        goto start;
    }
    if (a_reg == 0x9c){
        SetTranspose();
        goto start;
    }
    y_reg = a_reg;
    if (a_reg == 0xff){
        EndRepeat();
        goto start;
    }
    a_reg &= 0xc0;
    if (a_reg == 0xc0){
        StartRepeat();
        goto start;
    }
    return NotACommand();
}

// Command FF, end repeat section
void EndRepeat() @safe {
    a_reg = MusicChannel_LoopCounter[x_reg];
    if (a_reg == 0){
        return;
    }
    MusicChannel_LoopCounter[x_reg]--;
    MusicChannel_Counter[x_reg] = MusicChannel_LSOffset[x_reg];
}

// Commands C0-FE, repeat until FF
void StartRepeat() @safe {
    a_reg &= 0x3f;
    MusicChannel_LoopCounter[x_reg] = a_reg;
    MusicChannel_LoopCounter[x_reg]--;
    MusicChannel_LSOffset[x_reg] = MusicChannel_Counter[x_reg];
}

// Note is still playing
void StillPlaying() @safe {
    B28_0ba1();
    B28_09cc();
    return NextInstrumentProbably();
}

// Play noise note
void PlayNoiseNote() @safe {
    return UNKNOWN_1C8E17();
}

// Set triangle note length
void TriangleSetLength() @safe {
    return B28_0ded();
}

// Command 9F, set envelope
void Set_Timbre() @safe {
    ME_Envelopes0[x_reg] = ReadByte();
    ME_Envelopes1[x_reg] = ReadByte();
}

// Unreachable command, consume 2 bytes and do nothing
void B28_0d18() @safe {
    ReadByte();
    ReadByte();
}

// Command 9E, set notelength table offset
void SetNLT() @safe {
    a_reg = ReadByte();
    switch(a_reg){
        case 0x00:
            MusicHeader.note_lengths = &NLT_00;
            break;
        case 0x0C:
            MusicHeader.note_lengths = &NLT_0C;
            break;
        case 0x18:
            MusicHeader.note_lengths = &NLT_18;
            break;
        case 0x28:
            MusicHeader.note_lengths = &NLT_28;
            break;
        case 0x35:
            MusicHeader.note_lengths = &NLT_35;
            break;
        case 0x43:
            MusicHeader.note_lengths = &NLT_43;
            break;
        case 0x4C:
            MusicHeader.note_lengths = &NLT_4C;
            break;
        case 0x5a:
            MusicHeader.note_lengths = &NLT_5A;
            break;
        default:
            MusicHeader.note_lengths = null;
            break;
    }
}

// Command 9C, set transpose
void SetTranspose() @safe {
    MusicHeader.transpose = ReadByte();
}

void NotACommand() @safe {
    a_reg = y_reg;
    a_reg &= 0xb0;
    if (a_reg == 0xb0){
    // Command B0-BF, set notelength and play note
        a_reg = y_reg;
        a_reg &= 0xf;
        a_reg = (*MusicHeader.note_lengths)[a_reg];
        MusicChannel_NewNoteLength[x_reg] = a_reg;
        y_reg = a_reg;
        a_reg = x_reg;
        if (a_reg == 2){
            return TriangleSetLength();
        }
        return PulseSetLengthAndPlay();
    } else {
        return PlayNote();
    }
}

void PulseSetLengthAndPlay() @safe {
    a_reg = ReadByte();
    y_reg = a_reg;
    return PlayNote();
}

// Play note
void PlayNote() @safe {
    a_reg = y_reg;
    unk_7c3[x_reg] = a_reg;
    a_reg = x_reg;
    if (a_reg == 3){
        return PlayNoiseNote();
    }
    a_stash ~= a_reg;
    x_reg = unk_be;
    a_reg = PitchTable[y_reg/2] & 0xff;
    if(a_reg != 0){
        a_reg = MusicHeader.transpose;
        if (a_reg > 0x7f){
            a_reg &= 0x7f;
            unk_b3 = a_reg;
            y_reg = a_reg;
            a_reg -= unk_b3;
            return B28_0d78();
        } else {
            return B28_0d73();
        }
    } else {
        return B28_0d87();
    }
}

void B28_0d73() @safe {
    a_reg = y_reg;
    a_reg += MusicHeader.transpose;
    return B28_0d78();
}
void B28_0d78() @safe {
    y_reg = a_reg;
    a_reg = PitchTable[y_reg/2] & 0xff;
    switch(x_reg){
        case 0:
            currptr_pulse0[0] = a_reg;
            break;
        case 4:
            currptr_pulse1[0] = a_reg;
            break;
        case 8:
            currptr_triangle[0] = a_reg;
            break;
        default:
            break;
    }
    a_reg = PitchTable[y_reg/2] >> 8;
    a_reg |= 8;
    switch(x_reg){
        case 0:
            currptr_pulse0[1] = a_reg;
            break;
        case 4:
            currptr_pulse1[1] = a_reg;
            break;
        case 8:
            currptr_triangle[1] = a_reg;
            break;
        default:
            break;
    }
    return B28_0d87();
}
void B28_0d87() @safe {
    y_reg = a_reg;
    a_reg = a_stash.front;
    a_stash.popFront();
    x_reg = a_reg;
    a_reg = y_reg;
    if (a_reg == 0){
        a_reg = 0;
        unk_b0 = a_reg;
        a_reg = x_reg;
        if (a_reg != 2){
            a_reg = 0x10;
            unk_b0 = a_reg;
        }
    } else {
        a_reg = ME_Envelopes1[x_reg];
        unk_b0 = a_reg;
    }
    a_reg = x_reg;
    unk_7c7[1+x_reg]--;
    if (a_reg == unk_7c7[1+x_reg]) {
        return UNKNOWN_1C8DE7();
    }
    unk_7c7[1+x_reg]++;
    y_reg = unk_be;
    a_reg = x_reg;
    if (a_reg == 2){
        goto UNKNOWN_1C8DC7;
    }
    a_reg = ME_Envelopes0[x_reg];
    a_reg &= 0x1f;
    if (a_reg == 0){
        goto UNKNOWN_1C8DC7;
    }
    a_reg = unk_b0;
    if (a_reg == 0x10){
        goto UNKNOWN_1C8DC9;
    }
    a_reg &= 0xf0;
    a_reg |= 0; //?
    if (a_reg != 0){
        goto UNKNOWN_1C8DC9;
    }
    UNKNOWN_1C8DC7:
    a_reg = unk_b0;
    UNKNOWN_1C8DC9:
    switch(y_reg){
        case 0:
            nes.SQ1_VOL = a_reg;
            break;
        case 4:
            nes.SQ2_VOL = a_reg;
            break;
        case 8:
            nes.TRI_LINEAR = a_reg;
            break;
        default:
            break;
    }
    a_reg = UNK_7C0[x_reg];
    switch(y_reg){
        case 0:
            nes.SQ1_SWEEP = a_reg;
            nes.SQ1_LO = currptr_pulse0[0];
            nes.SQ1_HI = currptr_pulse0[1];
            break;
        case 4:
            nes.SQ2_SWEEP = a_reg;
            nes.SQ2_LO = currptr_pulse1[0];
            nes.SQ2_HI = currptr_pulse1[1];
            break;
        case 8:
            nes.TRI_LO = currptr_triangle[0];
            nes.TRI_HI = currptr_triangle[1] & 7;
            break;
        default:
            break;
    }
    return UNKNOWN_1C8DDE();
}
void UNKNOWN_1C8DDE() @safe {
    a_reg = MusicChannel_NewNoteLength[x_reg];
    MusicChannel_NoteLengthCounter[x_reg] = a_reg;
    return NextInstrumentProbably();
}
void UNKNOWN_1C8DE7() @safe {
    unk_7c7[x_reg+1]++;
    return UNKNOWN_1C8DDE();
}

void B28_0ded() @safe {
    a_reg = ME_Envelopes0[2];
    a_reg &= 0x1f;
    if (a_reg != 0){
        goto UNKNOWN_1C8E11;
    }
    a_reg = ME_Envelopes0[2];
    a_reg &= 0xc0;
    if (a_reg != 0){
        goto UNKNOWN_1C8DFE;
    }
    UNKNOWN_1C8DFB:
    a_reg = y_reg;
    if (a_reg != 0){
        goto UNKNOWN_1C8E06;
    }
    UNKNOWN_1C8DFE:
    if (a_reg == 0xc0){
        goto UNKNOWN_1C8DFB;
    }
    a_reg = 0xff;
    if (a_reg != 0){
        goto UNKNOWN_1C8E11;
    }
    UNKNOWN_1C8E06:
    a_reg += 0xff;
    a_reg <<= 2;
    if (a_reg < 0x3c){
        goto UNKNOWN_1C8E11;
    }
    a_reg = 0x3c;
    UNKNOWN_1C8E11:
    ME_Envelopes1[2] = a_reg;
    return PulseSetLengthAndPlay();
}
void UNKNOWN_1C8E17() @safe {
    a_reg = y_reg;
    a_stash ~= a_reg;
    B28_0e3e();
    a_reg = a_stash.front;
    a_stash.popFront();
    a_reg &= 0x3f;
    y_reg = a_reg;
    UNKNOWN_1C8E26();
    return UNKNOWN_1C8DDE();
}

void UNKNOWN_1C8E26() @safe {
    a_reg = soundactive_noise;
    if (a_reg != 0){
        return;
    }
    nes.NOISE_VOL = Noise_Instruments[y_reg];
    nes.NOISE_LO = Noise_Instruments[y_reg+1];
    nes.NOISE_HI = Noise_Instruments[y_reg+2];
}

void B28_0e3e() @safe {
    a_reg = y_reg;
    a_reg &= 0xc0;
    if (a_reg == 0x40){
        //is kick
        return B28_0e4a();
    } else if (a_reg == 0x80) {
        //is snare
        return B28_0e54();
    }
}

void B28_0e4a() @safe {
    //kick drum
    a_reg = 0xe;
    unk_b1 = a_reg;
    //lda #dmc_samplelen sample_kick, B30_0071
    a_reg = 0x7;
    //ldy #dmc_sampleaddr sample_kick
    y_reg = 0x0;
    return B28_0e5c();
}

void B28_0e54() @safe {
    //snare drum
    a_reg = 0xe;
    unk_b1 = a_reg;
    //lda #dmc_samplelen sample_snare, B30_0171
    a_reg = 0xf;
    //ldy #dmc_sampleaddr sample_snare
    y_reg = 0x2;
    return B28_0e5c();
}
void B28_0e5c() @safe {
    //dmc isnt actually supported yet.
    //i cant imagine why :)
    nes.DMC_LEN = a_reg;
    nes.DMC_START = y_reg;
    a_reg = disable_dmc;
    if (a_reg != 0){
        return;
    }
    nes.DMC_FREQ = unk_b1;
    nes.SND_CHN = 0xf;
    nes.DMC_RAW = 0;
    nes.SND_CHN = 0x1f;
    a_reg = 0x1f;
}

//fake function, for pointer math
int GetInstrumentTrack(ubyte x) @safe {
    switch(x){
        case 0:
            return ME_Pulse1Index/2;
        case 1:
            return ME_Pulse2Index/2;
        case 2:
            return ME_TriangleIndex/2;
        case 3:
            return ME_NoiseIndex/2;
        default:
            return 0;
    }
}

ubyte ReadByte() @trusted {
    y_reg = MusicChannel_Counter[x_reg];
    MusicChannel_Counter[x_reg]++;
    return (*(*unk_b6_pointer)[GetInstrumentTrack(x_reg)].pointer)[y_reg];
}

shared(ubyte[])*[] Volume_Envelope_Table = [
&Volume_Envelope_0, // 00
&Volume_Envelope_1, // 01
&Volume_Envelope_2, // 02
&Volume_Envelope_3, // 03
&Volume_Envelope_4, // 04
&Volume_Envelope_5, // 05
&Volume_Envelope_6, // 06
&Volume_Envelope_7, // 07
&Volume_Envelope_8, // 08
&Volume_Envelope_9, // 09
&Volume_Envelope_10, // 0A
&Volume_Envelope_11, // 0B
&Volume_Envelope_12, // 0C
&Volume_Envelope_13, // 0D
&Volume_Envelope_14, // 0E
&Volume_Envelope_15, // 0F
&Volume_Envelope_16, // 10
&Volume_Envelope_17, // 11
&Volume_Envelope_18, // 12
&Volume_Envelope_19, // 13
&Volume_Envelope_20, // 14
&Volume_Envelope_21, // 15
&Volume_Envelope_22, // 16
&Volume_Envelope_23, // 17
&Volume_Envelope_24, // 18
&Volume_Envelope_25, // 19
&Volume_Envelope_26, // 1A
&Volume_Envelope_27, // 1B
];

// Envelope divider/volume table
shared ubyte[] Volume_Envelope_21 = [0x76,0x11,0x11,0x14,0x31,0xff];
shared ubyte[] Volume_Envelope_26 = [0x33,0x45,0x66,0xff];
shared ubyte[] Volume_Envelope_25 = [0x91,0x91,0x91,0x91,0x91,0x91,0x91,0x91,0x91,0x91,0xf0];
shared ubyte[] Volume_Envelope_24 = [0x23,0x33,0x32,0x22,0x22,0x22,0xff];
shared ubyte[] Volume_Envelope_23 = [0x98,0x76,0x63,0x22,0x87,0x76,0x53,0x11,0xf0];
shared ubyte[] Volume_Envelope_6 = [0x23,0x56,0x78,0x88,0x88,0x87,0xff];
shared ubyte[] Volume_Envelope_0 = [0x23,0x34,0x56,0x77,0x65,0x54,0xff];
shared ubyte[] Volume_Envelope_1 = [0x5a,0x98,0x88,0x77,0x66,0x66,0x65,0x55,0x55,0xff];
shared ubyte[] Volume_Envelope_22 = [0x11,0x11,0x22,0x22,0x33,0x33,0x44,0x44,0x44,0x45,0x55,0x55,0x55,0x66,0x66,0x77,0x78,0x88,0x76,0x54,0x32,0xff];
shared ubyte[] Volume_Envelope_27 = [0x11,0x11,0x22,0xff];
shared ubyte[] Volume_Envelope_2 = [0x11,0x11,0x22,0x22,0x33,0x33,0x44,0x44,0x44,0x45,0x55,0x55,0x55,0x66,0x66,0x77,0x78,0x88,0xff];
shared ubyte[] Volume_Envelope_3 = [0xf9,0x87,0x77,0x77,0x66,0x65,0x55,0x44,0xff];
shared ubyte[] Volume_Envelope_4 = [0xa8,0x76,0xff];
shared ubyte[] Volume_Envelope_9 = [0x74,0x32,0xff];
shared ubyte[] Volume_Envelope_5 = [0x99,0xff];
shared ubyte[] Volume_Envelope_7 = [0xdc,0xba,0x99,0x88,0x87,0x76,0x55,0x44,0xff];
shared ubyte[] Volume_Envelope_8 = [0x23,0x44,0x33,0x33,0x33,0x33,0x33,0x32,0xff];
shared ubyte[] Volume_Envelope_10 = [0x77,0x76,0x65,0x55,0x44,0x43,0x32,0x21,0xf0];
shared ubyte[] Volume_Envelope_11 = [0x44,0x43,0x33,0x32,0x22,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_12 = [0x33,0x33,0x22,0x22,0x11,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_13 = [0x22,0x22,0x22,0x11,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_14 = [0x11,0x11,0x11,0x11,0x11,0x11,0x01,0x00,0xf0];
shared ubyte[] Volume_Envelope_15 = [0x99,0x88,0x77,0x76,0x66,0x55,0x54,0x44,0x33,0x33,0x33,0x32,0x22,0x22,0x22,0x22,0x21,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_18 = [0x65,0x55,0x54,0x44,0x33,0x33,0x33,0x33,0x22,0x22,0x22,0x22,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_20 = [0xfb,0xba,0xaa,0x99,0x99,0x99,0x98,0x88,0x77,0x77,0x77,0x66,0x66,0x66,0x55,0x54,0x44,0x44,0x43,0x33,0x33,0x22,0x22,0x22,0x22,0x11,0x11,0x11,0xf0];
shared ubyte[] Volume_Envelope_16 = [0x23,0x45,0x55,0x44,0x33,0x33,0x22,0xff];
shared ubyte[] Volume_Envelope_17 = [0x87,0x65,0x43,0x21,0x44,0x33,0x21,0x11,0x32,0x21,0x11,0x11,0x21,0x11,0x11,0x11,0x11,0x11,0x11,0xff];
shared ubyte[] Volume_Envelope_19 = [0x66,0x65,0x42,0x21,0x32,0x21,0x11,0x11,0x21,0x11,0x11,0x11,0x11,0x11,0x11,0xff];


//pitch table
ushort[] PitchTable = [
    0x07F0,0x0000,0x06AE,0x064E,0x05F3,0x059E,0x054D,0x0501,
    0x04B9,0x0475,0x0435,0x03F8,0x03BF,0x0389,0x0357,0x0327,
    0x02F9,0x02CF,0x02A6,0x0280,0x025C,0x023A,0x021A,0x01FC,
    0x01DF,0x01C4,0x01AB,0x0193,0x017C,0x0167,0x0152,0x013F,
    0x012D,0x011C,0x010C,0x00FD,0x00EE,0x00E1,0x00D4,0x00C8,
    0x00BD,0x00B2,0x00A8,0x009F,0x0096,0x008D,0x0085,0x007E,
    0x0076,0x0070,0x0069,0x0063,0x005E,0x0058,0x0053,0x004F,
    0x004A,0x0046,0x0042,0x003E,0x003A,0x0037,0x0034,0x0031,
    0x002E,0x002B,0x0029,0x000A,0x0001
];

// tempo note length offsets
shared ubyte[] NLT_00 = [
0x04,0x08,0x10,0x20,0x40,0x18,0x30,0x0c,
0x0a,0x05,0x02,0x01
];
shared ubyte[] NLT_0C = [
0x05,0x0a,0x14,0x28,0x50,0x1e,0x3c,0x0f,
0x0c,0x06,0x03,0x02
];
shared ubyte[] NLT_18 = [
0x06,0x0c,0x18,0x30,0x60,0x24,0x48,0x12,
0x10,0x08,0x03,0x01,0x04,0x02,0x00,0x90
];
shared ubyte[] NLT_28 = [
0x07,0x0e,0x1c,0x38,0x70,0x2a,0x54,0x15,
0x12,0x09,0x03,0x01,0x02
];
shared ubyte[] NLT_35 = [
0x08,0x10,0x20,0x40,0x80,0x30,0x60,0x18,
0x15,0x0a,0x04,0x01,0x02,0xc0
];
shared ubyte[] NLT_43 = [
0x09,0x12,0x24,0x48,0x90,0x36,0x6c,0x1b,
0x18
];
shared ubyte[] NLT_4C = [
0x0a,0x14,0x28,0x50,0xa0,0x3c,0x78,0x1e,
0x1a,0x0d,0x05,0x01,0x02,0x17
];
shared ubyte[] NLT_5A = [
0x0b,0x16,0x2c,0x58,0xb0,0x42,0x84,0x21,
0x1d,0x0e,0x05,0x01,0x02,0x17
];

shared(MusHeader)*[] Music_Table_Ids = [
null, //&Ocarina_header,
null, //&Flippant_Battle_header,
null, //&Dangerous_Battle_header,
null, //&Hippie_Battle_header,
null, //&Win_Battle_header,
null, //&Pollyanna_header,
null, //&Bein_Friends_header,
null, //&Yucca_Desert_header,
null, //&Magicant_BGM_header,
null, //&Snowman_BGM_header,
null, //&Mt_Itoi_BGM_header,
null, //&Factory_BGM_header,
null, //&Ghastly_Site_header,
null, //&Twinkle_Elementary_BGM_header,
null, //&Humoresque_Of_A_Little_Dog_header,
null, //&Poltergeist_header,
null, //&Underground_BGM_header,
null, //&Home_BGM_header,
null, //&Approaching_Mt_Itoi_header,
null, //&Paradise_Line_BGM_header,
null, //&Fallin_Love_header,
&Mother_Earth_header,
null, //&Tank_BGM_header,
null, //&Monkey_Cave_BGM_header,
];
MusHeader*[] Music_Table_2_Ids = [
//&Queen_Marys_Song_header,
//&Wisdom_Of_The_World_header,
//&Tombstone_BGM_header,
//&Game_Over_BGM_header,
//&Big_Victory_BGM_header,
//&Airplane_BGM_header,
//&Level_Up_BGM_header,
//&Recovery_BGM_header,
//&Fanfare_BGM_header,
//&Live_House_BGM_header,
//&All_That_I_Needed_Was_You_header,

//&Melody_1_header,
//&Melody_2_header,
//&Melody_3_header,
//&Melody_4_header,
//&Melody_5_header,
//&Melody_6_header,
//&Melody_7_header,
//&Melody_8_header,

//&VS_Giegue_BGM_header,
//&Ending_JP_BGM_header,
//&Zoo_BGM_header,
//&Phone_BGM_header,
//&Youngtown_BGM_header,
//&Cave_Of_The_Tail_BGM_header,
];

//     .ifndef VER_JP
//     .byte 0
//     .endif

// Music_Table:

// Ocarina_header:
// .byte $18
// .byte NLT_18-Tempo_Lengths
// .addr -1
// .addr -1
// .addr ntbl_xc
// .addr -1

// Flippant_Battle_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_b_flippant_pulse1
// .addr mus_b_flippant_pulse2
// .addr mus_b_flippant_triangle
// .addr mus_b_flippant_noise

// Dangerous_Battle_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_b_dangerous_pulse1
// .addr mus_b_dangerous_pulse2
// .addr mus_b_dangerous_triangle
// .addr mus_b_dangerous_noise

// Hippie_Battle_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_b_hippie_pulse1
// .addr mus_b_hippie_pulse2
// .addr mus_b_hippie_triangle
// .addr mus_b_hippie_noise

// Win_Battle_header:
// .byte $00
// .byte NLT_00-Tempo_Lengths
// .addr mus_b_win_pulse1
// .addr mus_b_win_pulse2
// .addr mus_b_win_triangle
// .addr -1

// Bein_Friends_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_bein_friends_pulse1
// .addr mus_bein_friends_pulse2
// .addr mus_bein_friends_triangle
// .addr mus_bein_friends_noise

// Pollyanna_header:
// .byte $00
// .byte NLT_35-Tempo_Lengths
// .addr mus_pollyanna_pulse1
// .addr mus_pollyanna_pulse2
// .addr mus_pollyanna_triangle
// .addr mus_pollyanna_noise

// Yucca_Desert_header:
// .byte $81
// .byte NLT_0C-Tempo_Lengths
// .addr mus_yucca_desert_pulse1
// .addr mus_yucca_desert_pulse2
// .addr mus_yucca_desert_triangle
// .addr mus_yucca_desert_noise

// Magicant_BGM_header:
// .byte $00
// .byte NLT_4C-Tempo_Lengths
// .addr mus_magicant_pulse1
// .addr mus_magicant_pulse2
// .addr mus_magicant_triangle
// .addr mus_magicant_noise

// Snowman_BGM_header:
// .byte $00
// .byte NLT_35-Tempo_Lengths
// .addr mus_snowman_pulse1
// .addr mus_snowman_pulse2
// .addr mus_snowman_triangle
// .addr -1

// Mt_Itoi_BGM_header:
// .byte $00
// .byte NLT_4C-Tempo_Lengths
// .addr mus_mt_itoi_pulse1
// .addr mus_mt_itoi_pulse2
// .addr mus_mt_itoi_triangle
// .addr mus_mt_itoi_noise

// Factory_BGM_header:
// .byte $00
// .byte NLT_35-Tempo_Lengths
// .addr mus_factory_pulse1
// .addr mus_factory_pulse2
// .addr mus_factory_triangle
// .addr mus_factory_noise

// Ghastly_Site_header:
// .byte $00
// .byte NLT_35-Tempo_Lengths
// .addr mus_ghastly_site_pulse1
// .addr mus_ghastly_site_pulse2
// .addr mus_ghastly_site_triangle
// .addr mus_ghastly_site_noise

// Twinkle_Elementary_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr mus_twinkle_elementary_pulse1
// .addr mus_twinkle_elementary_pulse2
// .addr mus_twinkle_elementary_triangle
// .addr mus_twinkle_elementary_noise

// Humoresque_Of_A_Little_Dog_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr mus_humoresque_of_a_little_dog_pulse1
// .addr mus_humoresque_of_a_little_dog_pulse2
// .addr mus_humoresque_of_a_little_dog_triangle
// .addr mus_humoresque_of_a_little_dog_noise

// Poltergeist_header:
// .byte $87   ; Transpose
// .byte NLT_18-Tempo_Lengths   ; Note length table offset
// .addr mus_poltergeist_pulse1 ; Pulse1 phrase pointers
// .addr mus_poltergeist_pulse2 ; Pulse2 phrase pointers
// .addr mus_poltergeist_triangle ; Triangle phrase pointers
// .addr mus_poltergeist_noise ; Noise phrase pointers

// Underground_BGM_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_underground_pulse1
// .addr mus_underground_pulse2
// .addr mus_underground_triangle
// .addr mus_underground_noise

// Home_BGM_header:
// .byte $02
// .byte NLT_43-Tempo_Lengths
// .addr mus_home_pulse1
// .addr mus_home_pulse2
// .addr mus_home_triangle
// .addr mus_home_noise

// Approaching_Mt_Itoi_header:
// .byte $00
// .byte NLT_35-Tempo_Lengths
// .addr mus_approaching_mt_itoi_pulse1
// .addr mus_approaching_mt_itoi_pulse2
// .addr mus_approaching_mt_itoi_triangle
// .addr mus_approaching_mt_itoi_noise

// Paradise_Line_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr mus_paradise_line_pulse1
// .addr mus_paradise_line_pulse2
// .addr mus_paradise_line_triangle
// .addr mus_paradise_line_noise

// Fallin_Love_header:
// .byte $00
// .byte NLT_43-Tempo_Lengths
// .addr mus_fallin_love_pulse1
// .addr mus_fallin_love_pulse2
// .addr mus_fallin_love_triangle
// .addr mus_fallin_love_noise

shared MusHeader Mother_Earth_header = {
    0,
    &NLT_28,
    &mus_mother_earth_pulse1,
    &mus_mother_earth_pulse2,
    &mus_mother_earth_triangle,
    &mus_mother_earth_noise,
};

// Tank_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr mus_tank_pulse1
// .addr mus_tank_pulse2
// .addr mus_tank_triangle
// .addr mus_tank_noise

// Monkey_Cave_BGM_header:
// .byte $00
// .byte NLT_0C-Tempo_Lengths
// .addr mus_monkey_cave_pulse1
// .addr mus_monkey_cave_pulse2
// .addr mus_monkey_cave_triangle
// .addr -1

// Music_Table_2:

// Queen_Marys_Song_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B29_0E84
// .addr B29_0E6C
// .addr -1
// .addr -1

// Wisdom_Of_The_World_header:
// .byte $00
// .byte NLT_5A-Tempo_Lengths
// .addr B29_0EFB
// .addr B29_0F01
// .addr B29_0F07
// .addr -1

// Tombstone_BGM_header:
// .byte $18
// .byte NLT_4C-Tempo_Lengths
// .addr B29_0FFF
// .addr B29_0FF7
// .addr -1
// .addr -1

// Game_Over_BGM_header:
// .byte $00
// .byte NLT_4C-Tempo_Lengths
// .addr B29_1012
// .addr B29_101A
// .addr B29_1022
// .addr -1

// Big_Victory_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr mus_big_victory_pulse1
// .addr mus_big_victory_pulse2
// .addr mus_big_victory_triangle
// .addr -1

// Airplane_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr B29_1992
// .addr B29_1998
// .addr B29_199E
// .addr B29_19B0

// Level_Up_BGM_header:
// .byte $06
// .byte NLT_00-Tempo_Lengths
// .addr mus_level_up_pulse1_intro
// .addr mus_level_up_pulse2_intro
// .addr mus_level_up_triangle_intro
// .addr -1

// Recovery_BGM_header:
// .byte $83
// .byte NLT_18-Tempo_Lengths
// .addr B29_0E98
// .addr B29_0E9C
// .addr B29_0E9E
// .addr -1

// Fanfare_BGM_header:
// .byte $83
// .byte NLT_43-Tempo_Lengths
// .addr B29_1438
// .addr B29_143C
// .addr B29_143E
// .addr -1

// Live_House_BGM_header:
// .byte $87
// .byte NLT_18-Tempo_Lengths
// .addr B29_109E
// .addr B29_10A4
// .addr B29_10B0
// .addr B29_10BC

// All_That_I_Needed_Was_You_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr B29_113C
// .addr B29_1152
// .addr B29_1162
// .addr B29_1174

// Melody_1_header:
// .byte $30
// .byte NLT_28-Tempo_Lengths
// .addr B28_1302
// .addr B28_1306
// .addr -1
// .addr -1

// Melody_2_header:
// .byte $18
// .byte NLT_28-Tempo_Lengths
// .addr B28_130A
// .addr B28_130E
// .addr -1
// .addr -1

// Melody_3_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B28_1312
// .addr B28_1316
// .addr -1
// .addr -1

// Melody_4_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B28_131A
// .addr B28_131E
// .addr -1
// .addr -1

// Melody_5_header:
// .byte $30
// .byte NLT_28-Tempo_Lengths
// .addr B28_1322
// .addr B28_1326
// .addr -1
// .addr -1

// Melody_6_header:
// .byte $18
// .byte NLT_28-Tempo_Lengths
// .addr B28_132A
// .addr B28_132E
// .addr -1
// .addr -1

// Melody_7_header:
// .byte $30
// .byte NLT_28-Tempo_Lengths
// .addr B28_1332
// .addr B28_1336
// .addr -1
// .addr -1

// Melody_8_header:
// .byte $18
// .byte NLT_28-Tempo_Lengths
// .addr B28_133A
// .addr B28_133E
// .addr -1
// .addr -1

// VS_Giegue_BGM_header:
// .byte $00
// .byte NLT_43-Tempo_Lengths
// .addr B29_1461
// .addr B29_1467
// .addr -1
// .addr -1

// Ending_JP_BGM_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr mus_epiloguejp_pulse1_start
// .addr mus_epiloguejp_pulse2_start
// .addr mus_epiloguejp_triangle_start
// .addr mus_epiloguejp_noise_start

// Zoo_BGM_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B29_1479
// .addr B29_147F
// .addr B29_0827
// .addr B29_082F

// Phone_BGM_header:
// .byte $00
// .byte NLT_18-Tempo_Lengths
// .addr -1
// .addr B29_1495
// .addr -1
// .addr -1

// Youngtown_BGM_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B29_14A3
// .addr B29_14A9
// .addr B29_14AF
// .addr -1

// Cave_Of_The_Tail_BGM_header:
// .byte $00
// .byte NLT_28-Tempo_Lengths
// .addr B29_1556
// .addr B29_155E
// .addr -1
// .addr -1

// Path_To_Giegue_BGM_header:
// .byte $00
// .byte NLT_43-Tempo_Lengths
// .addr B29_1580
// .addr B29_1588
// .addr B29_1590
// .addr B29_1596

shared MusPattern[] mus_mother_earth_pulse2 = [
{pointer: &mus_mother_earth_pulse2_t1},
{f: -1},
{f: 0},
];

shared MusPattern[] mus_mother_earth_pulse1 = [
{pointer: &mus_mother_earth_pulse1_t1},
{f: -1},
{f: 0},
];

shared MusPattern[] mus_mother_earth_triangle = [
{pointer: &mus_mother_earth_triangle_t1},
{f: -1},
{f: 0},
];

shared MusPattern[] mus_mother_earth_noise = [
{pointer: &mus_mother_earth_noise_t1},
{f: -1},
{f: 0},
];

shared ubyte[] mus_mother_earth_pulse2_t1 = [
0x9F, 0xA7, 0xB3, 0xC8, 0xB4, 0x02, 0xFF, 0xC2, 0xB4, 0x4A, 0x50, 0xB6, 0x5A, 0xB2, 0x5E, 0xB4, 0x5A, 0xFF, 0x9F, 0xA7, 0xF4, 0xC2, 0xB3, 0x4A, 0xB2, 0x4C, 0x50, 0xB4, 0x50, 0xB3, 0x46, 0xB2, 0x4A, 0x4C, 0xB4, 0x4A, 0x42, 0x42, 0xB3, 0x40, 0x3C, 0x38, 0x34, 0xFF, 0xC2, 0xB3, 0x4A, 0xB2, 0x4C, 0x50, 0xB3, 0x50, 0x54, 0xB3, 0x46, 0xB2, 0x4A, 0x4C, 0xB4, 0x4A, 0xB3, 0x42, 0xB2, 0x46, 0x3C, 0xB2, 0x40, 0x42, 0x46, 0x4A, 0xB3, 0x40, 0x3C, 0x38, 0x34, 0xFF, 0x9F, 0xA1, 0xB4, 0xC2, 0xB4, 0x32, 0xB3, 0x2E, 0x38, 0xFF, 0x00
];

shared ubyte[] mus_mother_earth_pulse1_t1 = [
0x9F, 0xB4, 0xF1, 0xC4, 0xB2, 0x02, 0x62, 0xB3, 0x68, 0xB2, 0x02, 0x62, 0xB3, 0x68, 0xB2, 0x02, 0x62, 0xB3, 0x68, 0xB2, 0x02, 0x5A, 0xB3, 0x62, 0xFF, 0xC2, 0xB2, 0x02, 0x4A, 0xB3, 0x50, 0xB2, 0x02, 0x4A, 0xB3, 0x50, 0xB2, 0x02, 0x4A, 0xB3, 0x50, 0xB2, 0x02, 0x4A, 0xB3, 0x50, 0xB2, 0x02, 0x42, 0xB3, 0x4C, 0xB2, 0x02, 0x46, 0xB3, 0x4E, 0xB2, 0x02, 0xB1, 0x46, 0xB5, 0x50, 0xB1, 0x46, 0xB5, 0x50, 0xB1, 0x46, 0xB5, 0x50, 0xB1, 0x46, 0x50, 0xFF, 0x9F, 0xB2, 0xF1, 0xC2, 0xB2, 0x4A, 0x38, 0x50, 0x38, 0x46, 0x38, 0x50, 0x38, 0x46, 0x38, 0x50, 0x38, 0x42, 0x38, 0x50, 0x38, 0x42, 0x3C, 0x4C, 0x3C, 0x46, 0x3C, 0x4E, 0x3C, 0x40, 0x50, 0x3C, 0x50, 0x38, 0x50, 0x34, 0x50, 0xFF, 0xC2, 0x4A, 0x42, 0x4A, 0x50, 0x5A, 0x50, 0x46, 0x4C, 0xFF, 0x00
];

shared ubyte[] mus_mother_earth_triangle_t1 = [
0x9F, 0xA0, 0x00, 0xC2, 0xB4, 0x5A, 0x58, 0x56, 0x54, 0xFF, 0xC2, 0x42, 0x40, 0x3E, 0x3C, 0xFF, 0xC2, 0xB4, 0x42, 0x40, 0x3E, 0x3C, 0x34, 0x36, 0xB3, 0x38, 0x34, 0x32, 0x2E, 0xFF, 0xC2, 0xB4, 0x2A, 0x28, 0x26, 0x24, 0x34, 0x36, 0xB3, 0x38, 0x34, 0x32, 0x2E, 0xFF, 0xC2, 0xB4, 0x2A, 0x26, 0xFF, 0x00
];

shared ubyte[] mus_mother_earth_noise_t1 = [
0xB3, 0x01, 0x04, 0x01, 0x04, 0x00
];