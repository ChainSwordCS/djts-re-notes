
// pseudocode

#import "CollisionBody.hpp"

void* DAT_020fe018; // at 0x020fe018

// sometimes i call this "CollisionBody_Base"
namespace Class_020f8058_Base {
	
	/**
	 *	vtable[0]
	 */
	void FUN_0208c454(Class_020f8058_Base* this) {
		this->vptr = 0x020f8058;
		if (this->var_4c != 0) {
			FUN_020c97d8(this->var_4c);
		}
		if (this->var_44 != 0) {
			FUN_0207e124(this->var_44, this);
		}
		FUN_0208b68c(DAT_020fe018 - 0x2C, this);
		//FUN_020d9d80(); // does nothing
		return;
	}
	
	/**
	 *	vtable[1]
	 */
	void FUN_0208c3ec(Class_020f8058_Base* this) {
		this->vptr = 0x020f8058;
		if (this->var_4c != 0) {
			FUN_020c97d8(this->var_4c);
		}
		if (this->var_44 != 0) {
			FUN_0207e124(this->var_44, this);
		}
		FUN_0208b68c(DAT_020fe018 - 0x2C, this);
		//FUN_020d9d80(); // does nothing
		operator.delete[](this);
		return;
	}
	
	/**
	 *	vtable[2]
	 */
	void FUN_0208c1b0(Class_020f8058_Base* this) {
		if ((this->var_9d & 1) == 1) {
			this->vptr->vtable[3]();
		}
		this->var_9d = this->var_9d & 0xFD;
		return;
	}
	
	/**
	 *	vtable[3]
	 */
	void FUN_0208c1ec(Class_020f8058_Base* this) {
		short local_70[10];
		int local_50[3];
		short* psVar4 = (short *)(this->var_50);
		if ((psVar4 == NULL) || (this->var_54 == 0)) {
			(this->var_78).point[2].x = (this->var_58).point[2].x;
			(this->var_78).point[2].y = (this->var_58).point[2].y;
			(this->var_78).point[2].z = (this->var_58).point[2].z;
			(this->var_78).point[0].x = (this->var_58).point[0].x;
			(this->var_78).point[0].y = (this->var_58).point[0].y;
			(this->var_78).point[0].z = (this->var_58).point[0].z;
			(this->var_78).point[1].x = (this->var_58).point[1].x;
			(this->var_78).point[1].y = (this->var_58).point[1].y;
			(this->var_78).point[1].z = (this->var_58).point[1].z;
			(this->var_78).var_12 = (this->var_58).var_12;
			(this->var_78_.pos.x = (this->var_58).pos.x;
			(this->var_78_.pos.y = (this->var_58).pos.y;
			(this->var_78_.pos.z = (this->var_58).pos.z;
		} else {
			arraycopy_u16_x10_FUN_0207ccd4(local_70, &this->var_58);
			FUN_020a5974(local_70, psVar4);
			(this->var_78).point[2].x = local_70[6];
			(this->var_78).point[2].y = local_70[7];
			(this->var_78).point[2].z = local_70[8];
			(this->var_78).point[0].x = local_70[0];
			(this->var_78).point[0].y = local_70[1];
			(this->var_78).point[0].z = local_70[2];
			(this->var_78).point[1].x = local_70[3];
			(this->var_78).point[1].y = local_70[4];
			(this->var_78).point[1].z = local_70[5];
			(this->var_78).var_12 = local_70[9];
			psVar4 = (short *)this->var_50;
			piVar5 = this->var_54;
			if ((psVar4[9] & 1) == 0) {
				//FUN_0207cde8(); // does nothing
				int aiStack_38[10];
				uint auStack_44[3];
				int* srcB = FUN_0207cd98(psVar4, aiStack_38);
				FUN_020b68e4(&(this->var_58.pos), srcB, auStack_44);
				FUN_0207cdec(local_50, auStack_44);
			} else {
				FUN_0207cdec(local_50, &(this->var_58.pos));
			}
			(this->var_78).pos.x = local_50[0] + piVar5[0];
			(this->var_78).pos.y = local_50[1] + piVar5[1];
			(this->var_78).pos.z = local_50[2] + piVar5[2];
		}
		this->var_9d = this->var_9d & 0xFE;
		return;
	}
	
	/**
	 *	vtable[4]
	 */
	void FUN_0208c174(Class_020f8058_Base* this) {
		if (this->var_44 == 0) {
			FUN_020d9d50(this->boundingBox);
		}
		(*this->vptr->vtable[5])(this);
		this->var_9d = this->var_9d | 1;
		return;
	}
	
	/**
	 *	vtable[5]
	 */
	void FUN_0208c128(Class_020f8058_Base* this) {
		this->var_9d = this->var_9d | 2;
		CollisionBody* pcvar1 = this->var_44;
		if (pcvar1 == nullptr) {
			return;
		}
		if ((pcvar1->var_9d & 2) != 2) {
			(*pcvar1->vptr->vtable[5])();
			return;
		}
		return;
	}
}

namespace Class_020f8038 : Class_020f8058_Base {
	
	/**
	 *	vtable[0]
	 */
	void FUN_0208c000(Class_020f8038* this) {
		this->Base.vptr = 0x020f8038;
		Class_020f8058_Base::Class_020f8058_Base(this);
		return;
	}
	
	/**
	 *	vtable[1]
	 */
	void FUN_0208bfd8(Class_020f8038* this) {
		this->Base.vptr = 0x020f8038;
		Class_020f8058_Base::Class_020f8058_Base(this);
		operator.delete[](this);
		return;
	}
	
	/**
	 *	vtable[2]
	 */
	void FUN_0208bbac(Class_020f8038* this) {
		Class_020f8058_Base::FUN_0208c1b0(this);
		vec32 local_e8;
		local_e8.x = ((int)(short)(this->var_ac.x - this->var_a8.x) >> 1) << 2;
		local_e8.y = ((int)(short)(this->var_ac.y - this->var_a8.y) >> 1) << 2;
		local_e8.z = ((int)(short)(this->var_ac.z - this->var_a8.z) >> 1) << 2;
		longlong lVar1;
		vec32 local_dc;
		lVar1 = (longlong)(int)(this->Base).var_78.point[0].x * (longlong)local_e8.x;
		local_dc.x = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[0].y * (longlong)local_e8.x;
		local_dc.y = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[0].z * (longlong)local_e8.x;
		local_dc.z = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		vec32 local_d0;
		lVar1 = (longlong)(int)(this->Base).var_78.point[1].x * (longlong)local_e8.y;
		local_d0.x = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[1].y * (longlong)local_e8.y;
		local_d0.y = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[1].z * (longlong)local_e8.y;
		local_d0.z = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		vec32 local_c4;
		lVar1 = (longlong)(int)(this->Base).var_78.point[2].x * (longlong)local_e8.z;
		local_c4.x = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[2].y * (longlong)local_e8.z;
		local_c4.y = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		lVar1 = (longlong)(int)(this->Base).var_78.point[2].z * (longlong)local_e8.z;
		local_c4.z = (uint)lVar1 >> 12 | (int)((ulonglong)lVar1 >> 32) << 20;
		vec32 local_88;
		local_88.x = local_dc.x;
		local_88.y = local_dc.y;
		local_88.z = local_dc.z;
		vec32 iStack_10c;
		FUN_0207b368(&iStack_10c.x,&local_dc.x);
		FUN_0207b35c(&local_dc.x,&iStack_10c.x);
		FUN_0207b368(&iStack_10c.y,&local_dc.y);
		FUN_0207b35c(&local_dc.y,&iStack_10c.y);
		FUN_0207b368(&iStack_10c.z,&local_dc.z);
		FUN_0207b35c(&local_dc.z,&iStack_10c.z);
		vec32 iStack_100;
		FUN_0207b368(&iStack_100.x,&local_d0.x);
		FUN_0207b35c(&local_d0.x,&iStack_100.x);
		FUN_0207b368(&iStack_100.y,&local_d0.y);
		FUN_0207b35c(&local_d0.y,&iStack_100.y);
		FUN_0207b368(&iStack_100.z,&local_d0.z);
		FUN_0207b35c(&local_d0.z,&iStack_100.z);
		vec32 iStack_f4;
		FUN_0207b368(&iStack_f4.x,&local_c4.x);
		FUN_0207b35c(&local_c4.x,&iStack_f4.x);
		FUN_0207b368(&iStack_f4.y,&local_c4.y);
		FUN_0207b35c(&local_c4.y,&iStack_f4.y);
		FUN_0207b368(&iStack_f4.z,&local_c4.z);
		FUN_0207b35c(&local_c4.z,&iStack_f4.z);
		local_b8.x = ((int)(short)((this->var_ac).x + (this->var_a8).x) >> 1) << 2;
		local_b8.y = ((int)(short)((this->var_ac).y + (this->var_a8).y) >> 1) << 2;
		local_b8.z = ((int)(short)((this->var_ac).z + (this->var_a8).z) >> 1) << 2;
		local_dc.x = local_dc.x + local_d0.x + local_c4.x;
		local_dc.y = local_dc.y + local_d0.y + local_c4.y;
		local_dc.z = local_dc.z + local_d0.z + local_c4.z;
		if (((this->Base).var_78.var_12 & 1) == 0) {
			FUN_0207cde8();
			srcB = FUN_0207cd98((short *)&(this->Base).var_78,aiStack_4c);
			FUN_020b68e4(&local_b8.x,srcB,auStack_58);
			FUN_0207cdec(&local_a0.x,auStack_58);
		}
		else {
			FUN_0207cdec(&local_a0.x,&local_b8.x);
		}
		local_ac.x = (this->Base).var_78.pos.x + local_a0.x;
		local_ac.y = (this->Base).var_78.pos.y + local_a0.y;
		local_ac.z = (this->Base).var_78.pos.z + local_a0.z;
		local_94.x = local_dc.x << 1;
		local_94.y = local_dc.y << 1;
		local_94.z = local_dc.z << 1;
		FUN_020d9c84(&(this->Base).boundingBox[0].x,&local_ac,&local_94);
		return;
	}
	
}


// TODO: many stupid overlapping classes that extend and act similar to CollisionBody

namespace CollisionBody {
	
	void FUN_0208f068(CollisionBody * this, CollisionBody * param_2) {
		// example input:
		// param_1 = 0x021DCBBC
		// param_2 = 0x022609B0
		// param_2 (alt) = 0x022F5D04
		// retaddr (r14) = 0x0208F5C0
		
		/* snip */
		// this line of code calls Agent_FUN_0202eb40()
		(*(code*)(this->var_48_agent->vptr->vtable[0]))(this->var_48_agent, iVar1, param_2);
		/* snip */
	}
	
	void FUN_0208c1ec(CollisionBody* this) {
		//u16* psVar7 = this->var_50;
		if ((this->var_50 == nullptr) || (this->var_54 == nullptr)) {
			u16* dst = (this->var_78).var_00;
			u16* src = (this->var_58).var_00;
			dst[0] = src[0];
			dst[1] = src[1];
			dst[2] = src[2];
			dst[3] = src[3];
			dst[4] = src[4];
			dst[5] = src[5];
			dst[6] = src[6];
			dst[7] = src[7];
			dst[8] = src[8];
			dst[9] = src[9];
			(this->var_78).var_14 = (this->var_58).var_14;
			(this->var_78).var_18 = (this->var_58).var_18;
			(this->var_78).var_1c = (this->var_58).var_1c;
		} else {
			u16* src = (this->var_58).var_00;
			u16 local_70[10];
			arraycopy_u16_x10_FUN_0207ccd4(local_70, src);
			FUN_020a5974(local_70, this->var_50);
			u16* dst = (this->var_78).var_00;
			dst[0] = local_70[0];
			dst[1] = local_70[1];
			dst[2] = local_70[2];
			dst[3] = local_70[3];
			dst[4] = local_70[4];
			dst[5] = local_70[5];
			dst[6] = local_70[6];
			dst[7] = local_70[7];
			dst[8] = local_70[8];
			dst[9] = local_70[9];
			s32 local_50[3];
			if ((this->var_50[9] & 0x01) == 0) {
				u32 auStack_44[3];
				s32 aiStack_38[10];
				FUN_0207cde8();
				piVar2 = FUN_0207cd98(this->var_50, aiStack_38);
				FUN_020b68e4((this->var_58).var_14, piVar2, auStack_44);
				FUN_0207cdec(local_50, auStack_44);
			} else {
				FUN_0207cdec(local_50, (this0>var_58).var_14);
			}
			(this->var_78).var_14[0] = local_50[0] + this->var_54[0];
			(this->var_78).var_14[1] = local_50[1] + this->var_54[1];
			(this->var_78).var_14[2] = local_50[2] + this->var_54[2];
		}
		this->var_9d = this->var_9d & 0xFE;
		return;
	}
}

namespace Class_020f7f5c { // extends CollisionBody_Base(?) class
	
	void FUN_0207e36c(CollisionBody* this) {
		Class_0208c524::FUN_0208c524(this); /* todo */
		this->vptr = 0x020f7f5c;
		this->var_a0 = 0; // u32
		this->var_a4 = 0; // u32
		this->var_98 = 0; // u8
		return;
	}
	
}

// why
void FUN_0207b35c(int* a, int* b) {
	a[0] = b[0];
	return;
}

void FUN_0207b368(int* a, int* b) {
	int local_8[2];
	if (b[0] < 0) {
		local_8[0] = -param_2[0];
		param_2 = local_8; // ??
	}
	a[0] = b[0];
	return;
}

void FUN_020d9d50(void* param_1) {
	// unsure how best to write this
	Class_020f8058_Base* cb = (int)param_1 - 4;
	if (cb->var_2c != nullptr) {
		int iVar1 = (cb->var_2c)->var_18;
		// whatever
		if (cb->var_30 != *(int *)(iVar1 + 8)) {
			cb->var_30 = *(int *)(iVar1 + 8);
			cb->var_34 = *(undefined4 *)(iVar1 + 0x5c);
			*(int *)(iVar1 + 0x5c) = param_1;
		}
	}
	return;
}

