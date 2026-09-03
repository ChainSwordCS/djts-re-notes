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
using CollisionBody;
using CollisionCompensator;
using OnCollision_param2_struct;
using OnCol_param2_substruct;

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
    Hex<u32> pos_new[3]; // vector
};
//struct Avatar_collision_body {
struct CollisionBody {
    Hex<u32> vptr;
    Hex<u32> vtable[6] @ vptr;
    Hex<u32> v_04;
    Hex<u32> v_08;
    Hex<u32> v_0c;
    Hex<u32> v_10;
    Hex<u32> v_14;
    Hex<u32> v_18;
    Hex<u32> v_1c_collisionbody_plus_4; // ?
    Hex<u32> v_20;
    Hex<u32> v_24;
    Hex<u32> v_28;
    Hex<u32> v_2c;
    Hex<u32> v_30;
    Hex<u32> v_34_collisionbody_plus_4; // ?
    Hex<u32> v_38;
    Hex<u32> v_3c;
    Hex<u32> v_40_Agent_parent;
    //Agent agent_parent @ v_40_Agent_parent;
    Hex<u32> v_44_collisionbody; // ?
    Hex<u32> v_48_agent; // ?
    Hex<u32> v_4c;
    Hex<u32> v_50_collisionbody_v78_ptr; // ?
    Hex<u32> v_54_collisionbody_posnew_ptr; // ?
    collision_substruct_58 v_58_sub;
    collision_substruct_58 v_78_sub;
    Hex<u8> v_98;
    Hex<u8> v_99;
    Hex<s16> v_9a;
    Hex<u8> v_9c;
    Hex<u8> v_9d;
    Hex<u8> v_9e;
    Hex<u8> v_9f;
};

struct CollisionCompensator {
    Hex<u32> vptr;
    Hex<u32> vtable[8] @ vptr;
    Hex<u32> nextCollisionCompensator; // ?
    Hex<u32> var_08;
    Hex<u32> var_0c;
    Hex<u32> var_10;
    Hex<u32> var_14;
    Hex<u32> var_18;
    Hex<u32> var_1c;
    Hex<u32> var_20;
    Hex<u32> pos_lastFrame[3]; // vector
    Hex<u32> v_30;
    Hex<u32> v_34_Agent_ptr;
    //Agent v_34_Agent @ v_34_Agent_ptr;
    Hex<u32> v_38_Avatar_collision_body_ptr;
    //Avatar_collision_body v_38_Avatar_collision_body @ v_38_Avatar_collision_body_ptr;
    Hex<u32> v_3c;
    /*
    Hex<u32> v_40;
    Hex<u32> v_44;
    Hex<u32> v_48;
    Hex<u32> v_4c;
    Hex<u32> v_50;
    */
};

struct OnCollision_param2_struct {
    Hex<u8> field_0x00;
    Hex<u8> num_contacts;
    Hex<u8> field_0x02;
    Hex<u8> field_0x03;
    Hex<u32> field_0x04;
    OnCol_param2_substruct oncol_param2_substruct[num_contacts] @ field_0x04;
};

// exactly 0x24 bytes long.
// is sometimes followed by one or more instances of this struct.
struct OnCol_param2_substruct {
    Hex<u32> contact_point[3];
    Hex<u16> v_0c[3];
    Hex<u8>  contact_type;
    Hex<u8>  v_13;
    Hex<u32> v_14;
    Hex<u32> collision_key;
    Hex<u32> v_1c_collisionbody;
    //CollisionBody collisionBody @ v_1c_collisionbody;
    Hex<u32> v_20_collisionbody;
};

//Hex<u32> function_table_1[6] @ 0x020F80C8;

//CollisionCompensator CollisionCompensator @ 0x0237D2D0;

//Avatar Avatar @ 0x021DBB60;

//CollisionBody Avatar_collision_body @ CollisionCompensator.v_38_Avatar_collision_body_ptr;
// 0x021DCBBC

//Agent Agent @ Avatar_collision_body.v_40_Agent_ptr;
// 0x021DBBF0

//Agent Josh @ 0x021DBCC0;

u32 arg_param_1 = 0x0237D2D0;
u32 arg_param_2 = 0x027E0A48;
u32 arg_param_3 = 0x022609B0;


// oncollision_02
CollisionCompensator param_1 @ arg_param_1;
OnCollision_param2_struct param_2 @ arg_param_2;
CollisionBody param_3 @ arg_param_3;

Agent agent @ param_1.v_34_Agent_ptr;
CollisionBody agent_collisionbody @ param_1.v_38_Avatar_collision_body_ptr;
//CollisionBody agent_collisionbody @ param_2.oncol_param2_substruct[0].v_1c_collisionbody;

CollisionBody unk_collisionbody_1 @ param_2.oncol_param2_substruct[0].v_20_collisionbody;

if (arg_param_3 != unk_collisionbody_1.v_44_collisionbody)
    CollisionBody unk_collisionbody_2 @ unk_collisionbody_1.v_44_collisionbody;

if (param_3.v_44_collisionbody != 0)
    CollisionBody unk_collisionbody_3 @ param_3.v_44_collisionbody;
