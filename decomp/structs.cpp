// pseudocode

typedef u32 uint;
typedef s32 int;
typedef u16 ushort;
typedef s16 short;
typedef u8 char;
typedef undefined4 u32;
typedef undefined2 u16;
typedef undefined1 u8;
typedef func void;

struct vec16 {
	s16 x;
	s16 y;
	s16 z;
};

struct vec32 {
	// 20.12 fixed-point 32-bit numbers
	s32 x;
	s32 y;
	s32 z;
};

/** all of these structs are a work in progress.
	most of their fields/variables, i don't know what they're used for.
*/

struct Agent {
	func*		vptr;
	void*		var_04;
	undefined4	var_08;
	void*		var_0c;
	undefined1 padding_10[24]; // todo
	void*		var_28;
	void*		var_2c;
	undefined4	var_30;
	void*		var_34;
	void*		var_38;
	void*		var_3c;
	void*		var_40;
	undefined2	var_44;
	undefined2	var_46;
	undefined2	var_48;
	undefined2	var_4a;
	undefined2	var_4c;
	undefined2	var_4e;
	CollisionBody* v_50_collisionBody;
	void*		var_54;
	void*		var_58;
	void*		var_5c;
	void*		var_60;
	void*		var_64;
	void*		var_68;
	void*		var_6c;
	void*		var_70;
	undefined1 padding_74[36]; // todo
	void*		var_98;
	undefined1 padding_9c[28]; // todo
	void*		var_b8;
	CollisionCompensator* var_bc_collisionCompensator;
};

struct CollisionBody_vtable {
	func vtable[6];
};

/**
	size = 0xA0 (?)
 */
struct CollisionBody {
	CollisionBody_vtable* vptr; // like 0x020f80c8
	vec32 boundingBox[2]; // two points; corners
	void*		var_1c;
	undefined4	var_20;
	undefined4	var_24;
	u32			var_28;
	void*		var_2c;
	undefined4	var_30;
	void*		var_34;
	undefined4	var_38;
	undefined4	var_3c;
	void*		var_40; // backref to parent Agent maybe? (like 0x021dbbf0)
	CollisionBody* var_44_collisionbody; // ?
	void*		var_48; // backref to parent Agent maybe? (like 0x021dbcc0)
	undefined4	var_4c;
	s16*		var_50_collisionbody_v78_ptr; // ptr to parent's collisionbody's var_78 (?) (like 0x021DBC30)
	s32*		var_54_collisionbody_posnew_ptr; // ptr to parent's collisionbody's posnew (?) (like 0x021DBC18)
	collision_substruct_58 var_58;
	collision_substruct_58 var_78;
	u8			var_98;
	u8			var_99;
	s16			var_9a;
	u8			var_9c;
	u8			var_9d;
	u8			var_9e;
	u8			var_9f;
};

/**
 *	size = 0x20
 */
struct collision_substruct_58 {
	// 3 vectors and an extra u16...
	vec16 point[3];
	u16 var_12;
	u32 pos[3];
};

/**
 *	size = 0x4C?
 */
struct cb_substruct_2c {
	vec32		var_00;
	vec32		var_0c;
	void*		var_18;
	// not sure if these are part of this struct
	undefined4	var_1c;
	void*		var_20;
	void*		var_24;
	void*		var_28;
	undefined4	var_2c;
	undefined4	var_30;
	void*		var_34;
	void*		var_38;
	undefined4	var_3c;
	undefined4	var_40;
	void*		var_44;
	void*		var_48;
};

/**
	size = 0xA0 (?)
 */
struct Class_020f7eec {
	CollisionBody collisionBody;
};

struct Class_020f7edc_vtable {
	func vtable[2];
};

/** 
	aka collision_pivar4_struct (?)
	class struct size = 0xB0
	vptr = 020f7edc
	constructor function is at 0207dae8
	
 */
struct Class_020f7edc {
	Class_020f7edc_vtable* vptr;
	Class_020f7edc_04_substruct* var_04;
	Class_020f7eec Class_020f7eec;
	CollisionBody* var_a8; // ?
	CollisionBody* var_ac; // ?
};

// unknown purpose
struct Class_020f7edc_04_substruct {
	u32 var_00;
	u32 var_04;
};



struct CollisionCompensator_vtable {
	func vtable[8];
};

struct CollisionCompensator {
	CollisionCompensator_vtable* vptr;
	CollisionCompensator* nextCollisionCompensator // ?
	undefined4	var_08;
	undefined4	var_0c;
	void*		var_10;
	void*		var_14;
	void*		var_18;
	void*		var_1c;
	void*		var_20;
	u32			pos_lastFrame[3]; // vector
	undefined4	var_30;
	Agent*		var_34_agent;
	CollisionBody*	var_38_avatarCollisionBody;
	u32*		var_3c;
};

struct OnCollision_param2_struct {
	undefined field_0x00;
	u8 num_contacts;
	undefined field_0x02;
	undefined field_0x03;
	OnCol_param2_substruct* field_0x04;
};

struct OnCol_param2_substruct {
	u32	contact_point[3]; // vector
	s16	v_0c[3]; // vector
	u8	contact_type;
	u8	v_13;
	undefined4 v_14;
	u32	collision_key;
	CollisionBody* v_1c_collisionbody;
	void* v_20;
};

// ?
struct SaboteurEffect_vtable_1 {
	func vtable[8];
};

struct SaboteurEffect {
	SaboteurEffect_vtable_1* vptr;
	undefined4	var_04;
	undefined4	var_08;
	undefined4	var_0c;
	void*		var_10;
	void*		var_14;
	void*		owner;
	s32			var_1c;
	undefined4	var_20;
};

