module earthboundbeginnings.sprites;

import earthboundbeginnings.ram;


shared(SpritePointerDef)[] SPRITEDEF_EARTH = [
    SpritePointerDef(&SPRITE_EARTH, 4, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 8, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 0xc, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 0x40, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 0x44, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 0x48, 0, 0, 0, 0),
    SpritePointerDef(&SPRITE_EARTH, 0x4c, 0, 0, 0, 0),
];

shared SpriteTile[] SPRITE_EARTH = [
SpriteTile(Vector2B(0x00, 0x00), 0, 1, 0, 0, 0, 0x00),
SpriteTile(Vector2B(0x08, 0x00), 0, 1, 0, 0, 0, 0x01),
SpriteTile(Vector2B(0x10, 0x00), 0, 1, 0, 0, 0, 0x02),
SpriteTile(Vector2B(0x18, 0x00), 0, 1, 0, 0, 0, 0x03),
SpriteTile(Vector2B(0x00, 0x08), 0, 1, 0, 0, 0, 0x10),
SpriteTile(Vector2B(0x08, 0x08), 0, 1, 0, 0, 0, 0x11),
SpriteTile(Vector2B(0x10, 0x08), 0, 1, 0, 0, 0, 0x12),
SpriteTile(Vector2B(0x18, 0x08), 0, 1, 0, 0, 0, 0x13),
SpriteTile(Vector2B(0x00, 0x10), 0, 1, 0, 0, 0, 0x20),
SpriteTile(Vector2B(0x08, 0x10), 0, 1, 0, 0, 0, 0x21),
SpriteTile(Vector2B(0x10, 0x10), 0, 1, 0, 0, 0, 0x22),
SpriteTile(Vector2B(0x18, 0x10), 0, 1, 0, 0, 0, 0x23),
SpriteTile(Vector2B(0x00, 0x18), 0, 1, 0, 0, 0, 0x30),
SpriteTile(Vector2B(0x08, 0x18), 0, 1, 0, 0, 0, 0x31),
SpriteTile(Vector2B(0x10, 0x18), 0, 1, 0, 0, 0, 0x32),
SpriteTile(Vector2B(0x18, 0x18), 0, 1, 0, 0, 0, 0x33),
];