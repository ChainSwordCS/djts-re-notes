
// pseudocode

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