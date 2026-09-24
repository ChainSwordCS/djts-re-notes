
// pseudocode

struct Class_020f8058_Base_vtable {
	func vtable[6];
};

/**
	size = 0xA0 (?)
 */
struct Class_020f8058_Base {
	Class_020f8058_Base_vtable* vptr;
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
	CollisionBody* var_44; // ?
	void*		var_48; // backref to parent Agent maybe? (like 0x021dbcc0)
	undefined4	var_4c;
	s16*		var_50; // ptr to parent's collisionbody's var_78 (?) (like 0x021DBC30)
	s32*		var_54; // ptr to parent's collisionbody's posnew (?) (like 0x021DBC18)
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
 *	side = 0xB4
 */
struct Class_020f8038 {
	Class_020f8058_Base Base; // whatever
	undefined4	var_a0;
	undefined4	var_a4;
	vec16		var_a8;
	vec16		var_ac;
};


// TODO: refactor

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

