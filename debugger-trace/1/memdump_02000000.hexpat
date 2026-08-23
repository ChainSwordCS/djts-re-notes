// remember:
// Right Click -> Set Base Address -> set to 0x02000000

#pragma endian little

//import std.core;
//import std.io;
import std.mem;
//import std.string;
import type.base;
using Hex<T> = type::Hex<T>;

using Agent;
using Avatar;
using collision_substruct_58;
using Avatar_collision_body;
using OnCollision_param1_struct;

struct Agent {
    Hex<u32> vptr;
    Hex<u32> v_04;
    u32 v_08;
    Hex<u32> v_0c;
    u32 v_10;
    u32 v_14;
    u32 v_18;
    u32 v_1c;
    u32 v_20;
    u32 v_24;
    Hex<u32> v_28;
    Hex<u32> v_2c;
    u32 v_30;
    Hex<u32> v_34;
    Hex<u32> v_38;
    Hex<u32> v_3c;
    Hex<u32> v_40;
    u16 v_44;
    u16 v_46;
    u16 v_48;
    u16 v_4a;
    u16 v_4c;
    u16 v_4e;
    Hex<u32> v_50_collisionBody;
    Hex<u32> v_54;
    Hex<u32> v_58;
    Hex<u32> v_5c;
    Hex<u32> v_60;
    Hex<u32> v_64;
    Hex<u32> v_68;
    Hex<u32> v_6c;
    Hex<u32> v_70;
    u32 v_74;
    u32 v_78;
    u32 v_7c;
    u32 v_80;
    u32 v_84;
    u32 v_88;
    u32 v_8c;
    u32 v_90;
    u32 v_94;
    Hex<u32> v_98;
    u32 v_9c;
    u32 v_a0;
    u32 v_a4;
    u32 v_a8;
    u32 v_ac;
    u32 v_b0;
    u32 v_b4;
    Hex<u32> v_b8;
    Hex<u32> v_bc_collisionCompensator;
};

struct Avatar {
    Hex<u32> v_00;
    Hex<u32> v_04;
    Hex<u32> v_08;
    Hex<u32> v_0c;
    Hex<u32> v_10;
    Hex<u32> v_14;
    Hex<u32> v_18;
    Hex<u32> v_1c;
    Hex<u32> v_20;
    Hex<u32> v_24;
    Hex<u32> v_28;
    Hex<u32> v_2c;
    Hex<u32> v_30;
    Hex<u32> v_34;
    Hex<u32> v_38;
    Hex<u32> v_3c;
    Hex<u32> v_40;
    Hex<u32> v_44;
    Hex<u32> v_48;
    Hex<u32> v_4c;
    Hex<u32> v_50;
    Hex<u32> v_54_Avatar_collision_body_ptr;
    Hex<u32> v_58;
    Hex<u32> v_5c;
    Hex<u32> v_60;
    Hex<u32> v_64;
    Hex<u32> v_68;
    Hex<u32> v_6c;
    Hex<u32> v_70;
    Hex<u32> v_74;
    Hex<u32> v_78;
    Hex<u32> v_7c;
    Hex<u32> v_80;
    Hex<u32> v_84;
    Hex<u32> v_88;
    Hex<u32> v_8c;
    Hex<u32> v_90;
    Hex<u32> v_94;
    Hex<u32> v_98;
    Hex<u32> v_9c;
    Hex<u32> v_a0;
    Hex<u32> v_a4;
    Hex<u32> v_a8;
    Hex<u32> v_ac;
    Hex<u32> v_b0;
    Hex<u32> v_b4;
    Hex<u32> v_b8;
    Hex<u32> v_bc;
    Hex<u32> v_c0;
    Hex<u32> v_c4;
    Hex<u32> v_c8;
    Hex<u32> v_cc;
    Hex<u16> v_d0[10];
    Hex<u32> v_e4;
    Hex<u32> v_ec;
    Hex<u32> v_f0;
    Hex<u32> v_f4;
    Hex<u32> v_f8;
    Hex<u32> v_fc;
    Hex<u32> v_100;
    Hex<u32> v_104;
    Hex<u32> v_108;
    Hex<u32> v_10c;
    Hex<u32> v_110;
    Hex<u32> v_114;
    Hex<u32> v_118;
    Hex<u32> v_11c;
    Hex<u32> v_120_Avatar_collision_body_ptr;
};

struct collision_substruct_58 {
    Hex<u16> v_00[10];
    Hex<u32> v_14;
    Hex<u32> v_18;
    Hex<u32> v_1c;
};
//struct Avatar_collision_body {
struct CollisionBody {
    Hex<u32> v_00;
    Hex<u32> v_04;
    Hex<u32> v_08;
    Hex<u32> v_0c;
    Hex<u32> v_10;
    Hex<u32> v_14;
    Hex<u32> v_18;
    Hex<u32> v_1c;
    Hex<u32> v_20;
    Hex<u32> v_24;
    Hex<u32> v_28;
    Hex<u32> v_2c;
    Hex<u32> v_30;
    Hex<u32> v_34;
    Hex<u32> v_38;
    Hex<u32> v_3c;
    Hex<u32> v_40_Agent_ptr;
    //Agent v_40_Agent @ v_40_Agent_ptr;
    Hex<u32> v_44;
    Hex<u32> v_48;
    Hex<u32> v_4c;
    Hex<u32> v_50;
    Hex<u32> v_54;
    collision_substruct_58 v_58_sub;
    collision_substruct_58 v_78_sub;
    Hex<u32> v_98;
    Hex<u8> v_9c;
    Hex<u8> v_9d;
    Hex<u8> v_9e;
    Hex<u8> v_9f;
};

struct OnCollision_param1 {
    Hex<u32> v_00;
    Hex<u32> v_04;
    Hex<u32> v_08;
    Hex<u32> v_0c;
    Hex<u32> v_10;
    Hex<u32> v_14;
    Hex<u32> v_18;
    Hex<u32> v_1c;
    Hex<u32> v_20;
    Hex<u32> pos_lastframe[3];
    //Hex<u32> v_28;
    //Hex<u32> v_2c;
    Hex<u32> v_30;
    Hex<u32> v_34_Agent_ptr;
    //Agent v_34_Agent @ v_34_Agent_ptr;
    Hex<u32> v_38_Avatar_collision_body_ptr;
    //Avatar_collision_body v_38_Avatar_collision_body @ v_38_Avatar_collision_body_ptr;
    Hex<u32> v_3c;
    Hex<u32> v_40;
    Hex<u32> v_44;
    Hex<u32> v_48;
    Hex<u32> v_4c;
    Hex<u32> v_50;
};

struct param2_struct {
    Hex<u32> v_00;
    Hex<u32> v_04;
};

// exactly 0x24 bytes long.
// is sometimes followed by one or more instances of this struct.
struct param2_substruct {
    Hex<u32> contact_point[3];
    Hex<u16> v_0c[3];
    Hex<u8>  contact_type;
    Hex<u8>  v_13;
    Hex<u32> v_14;
    Hex<u32> collision_key;
    Hex<u32> v_1c_collisionbody;
    Hex<u32> v_20;
};

Hex<u32> function_table_1[6] @ 0x020F80C8;

OnCollision_param1 OnCollision_param1 @ 0x0237D2D0;

Avatar Avatar @ 0x021DBB60;

CollisionBody Avatar_collision_body @ OnCollision_param1.v_38_Avatar_collision_body_ptr;
// 0x021DCBBC

Agent Agent @ Avatar_collision_body.v_40_Agent_ptr;
// 0x021DBBF0

param2_struct param2 @ 0x027E0A48;

param2_substruct param2_sub[1] @ 0x027E0808;

u32 placeholder @ 0x02260A60;

Agent Josh @ 0x021DBCC0;



//Hex<u32> _1 @ 0x021DBC44;
Hex<u32> _2 @ 0x021DBD10;
Hex<u32> _3 @ 0x0237D378;