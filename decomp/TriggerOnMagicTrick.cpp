
// pseudocode

namespace TriggerOnMagicTrick {
	
	/* TriggerOnMagicTrick_vtable
		FUN_020370ec
		FUN_02037078
		getClassName
		FUN_return_void_02018088
		FUN_return_void_0201808c
		FUN_02037158
		FUN_return_void_0201812c
		FUN_02037234
	*/
	
	/* vtable_020f0f60:
		FUN_02037368
		FUN_02037348
		FUN_02037358
	*/
	
	/* vtable_020f0f74:
		FUN_return_void_02018160
	*/
	
	/**
	 *	TriggerOnMagicTrick_vtable[0]
	 */
	void FUN_020370ec(TriggerOnMagicTrick* this, undefined4 param_1, undefined4 param_2, undefined* param_3) {
		this->vptr = 0x020f0f38; // TriggerOnMagicTrick_vtable
		this->var_10 = 0x020f0f60; // vtable_020f0f60
		this->var_14 = 0x020f0f74; // vtable_020f0f74
		this->vptr = 0x020ed928; // vtable_020ed928 (SaboteurEffect_vtable??)
		this->var_10 = 0x020ed950; // vtable_020ed950
		this->var_14 = 0x020ed964; // vtable_020ed964
		
		// related to Messenger.cpp
		FUN_02073f40(&(this->var_10), 0x020ed964, 0x020f0f38, param_3);
		
		this->vptr = 0x020ed428; // vtable_020ed428
	}
	
	/**
	 *	TriggerOnMagicTrick_vtable[2]
	 */
	char* getClassName() {
		// "TriggerOnMagicTrick"
		// 0x020fc9e0
		return gClassNamePtr_TriggerOnMagicTrick;
	}
	
	/**
	 *	TriggerOnMagicTrick_vtable[5]
	 */
	void FUN_02037158(TriggerOnMagicTrick* this, undefined4 param_1, undefined4 param_2, int param_3) {
		// example input:
		// this		= 0x0236C9D4;
		// param_1	= 0x021DAA48;
		// param_2	= 0x00000005;
		// param_3	= 0x0000001B;
		// retaddr	= 0x0202EBE4; // r14
		
		if (param_3 == 0x1B) {
			if ((*this->var_18 & 8) != 0) {
				this->var_20 = 1;
				*this->var_18 = *this->var_18 | 4;
				return;
			}
			return;
		} else if (param_3 != 0x1D) {
			if (param_3 == 0x1E) {
				this->var_20 = 0;
				*this->var_18 = *this->var_18 & 0xFFFFFFFB;
				return;
			}
			return;
		} else if (this->var_21 != 0) {
			return;
		} else if (this->var_20 != 0) {
			FUN_020735fc(this->var_1c, 0x0F, 0x3EC, this->var_24);
			*this->var_18 = *this->var_18 | 0x8000;
			this->var_21 = 1;
			return;
		} else {
			return;
		}
	}
	
}
