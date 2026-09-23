
// pseudocode

#import "structs.cpp"
#import "cwsdk.cpp"
#import "CollisionBody.cpp"

u32 DAT_020fdfe0; // ?

/**
 *	unknown purpose
 */
uint* FUN_020c9eb8(int param_1, uint* param_2) {
	/* todo */
}

namespace Class_020f7edc {
	
	void Class_020f7edc(Class_020f7edc* this, undefined4* param_1) {
		FUN_0207de90(this, param_1);
		Class_020f7f5c::FUN_0207e36c(this->var_08);
		this->vptr = 0x020f7edc;
		(this->var_08).vptr = 0x020f7eec;
		return;
	}
	
	Class_020f7edc* new_Class_020f7edc(uint* param_1) {
		Class_020f7edc* pcVar1 = operator.new[](0xb0);
		if (pcVar1 != NULL) {
			uint* local_10 = FUN_020c9eb8(DAT_020fdfe0 - 0x2c, param_1);
			Class_020f7edc(pcVar1, &local_10);
		}
		return pcVar1;
	}
	
	void FUN_0207de90(Class_020f7edc* this, Class_020f7edc_04_substruct** param_2) {
		this->vptr = 0x020f7df4;
		this->var_04 = *param_2;
		this->vptr = 0x020f7e74;
		return;
	}
	
	/**
	 *	(for vtable at 0x020f7edc)
	 *	vtable[0]
	 */
	void FUN_0207da54(Class_020f7edc* this) {
		this->vptr = 0x020f7edc;
		(this->var_08).vptr = 0x020f7eec;
		if (this->var_a8 != NULL) {
			/* todo: this is incoherent */
			int* piVar2 = (int *)this->field3_0xa8;
			int* piVar3;
			do {
				piVar3 = (int *)piVar2[0xe];
				FUN_0207e124((int)&this->field2_0x8,(int)piVar2);
				if (piVar2 != NULL) {
					(**(code **)(*piVar2 + 4))();
				}
				piVar2 = piVar3;
			} while (piVar3 != NULL);
		}
		FUN_0207e25c(this->var_08);
		this->vptr = 0x020f7e74;
		this->vptr = 0x020f7df4;
		return;
	}
	/**
	 *	(for vtable at 0x020f7edc)
	 *	vtable[1]
	 */
	void FUN_0207d9b8(Class_020f7edc* this) {
		this->vptr = 0x020f7edc;
		(this->var_08).vptr = 0x020f7eec;
		if (this->var_a8 != NULL) {
			/* todo: this is incoherent */
			int* piVar2 = (int *)this->field3_0xa8;
			int* piVar3;
			do {
				piVar3 = (int *)piVar2[0xe];
				FUN_0207e124((int)&this->field2_0x8,(int)piVar2);
				if (piVar2 != NULL) {
					(**(code **)(*piVar2 + 4))();
				}
				piVar2 = piVar3;
			} while (piVar3 != NULL);
		}
		FUN_0207e25c(this->var_08);
		this->vptr = 0x020f7e74;
		this->vptr = 0x020f7df4;
		operator.delete[](this);
		return;
	}
}

/**
 *	extends CollisionBody_Base or whatever
 *	only ever exists in the context of Class_020f7edc, i think.
 *	(should this be moved somewhere else?)
 */
namespace Class_020f7eec {
	
	/**
	 *	vtable[0]
	 */
	//todo
	
	/**
	 *	vtable[1]
	 */
	//todo
	
	/**
	 *	vtable[2]
	 */
	void FUN_0207df74(Class_020f7eec* this) {
		Class_0208c524_Base:FUN_0208c1b0(this); // todo
		int local_30[7];
		local_30[0] = 0x7fffffff;
		local_30[1] = 0x7fffffff;
		local_30[2] = 0x7fffffff;
		local_30[3] = 0x80000000;
		local_30[4] = 0x80000000;
		local_30[5] = 0x80000000;
		//local_30[6] is undefined
		
		/* unsure what way of writing this makes most sense.
			cuz really doesn't this variable belong to the parent struct, Class_020f7edc??
		*/
		//void* piVar1 = (this->var_a0);
		//void* piVar1 = (parent->var_a8);
		void* piVar1 = (Class_020f7edc*)((uint)this - 8)->field3_0xa8;
		
		while (piVar1 != NULL) {
			if () {
				
			}
			piVar1 = 
		}
		FUN_020d9c4c(this->boundingBox, local_30, &(local_30[3]));
		return;
	}
}
