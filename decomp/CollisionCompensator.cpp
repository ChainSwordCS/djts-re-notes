
// pseudocode

void OnCollision(param1_struct*, void*);
void arraycopy_u16_x10_FUN_0207ccd4(u16*, u16*);
int* FUN_0207cd98(s16*, s32*);
void FUN_0207cde8();
void FUN_0207cdec(s32*, s32*);
void FUN_0208c1ec(Avatar_collision_body*);
void FUN_020b68e4(s32*, s32*, u32*);

namespace CollisionCompensator {
	
	/**
		?
	 */
	void* getParent_FUN_02018140(void* param_1) {
		return (void*)((uint)param_1 - 16);
	}
	
	
	/* param_3 seems to be unused */
	void OnCollision(CollisionCompensator* this, OnCollision_param2_struct* param_2, CollisionBody* param_3) {
		// this    = 0x0237D2D0 (static.)
		// param_2 = 0x027E0A48 (static; this ptr doesnt change depending on collision body.)
		// param_2->substruct = 0x027E0808 (static)
		// param_3 = 0x022609B0 ?
		// agent = 0x021DBBF0
		// avatar_collision_body = 0x021DCBBC
		// return_addr (r14) = 0x0202eb78
		
		uint a;
		uint b;
		
		/* insert other local variable declarations here */
		
		uint num_contacts = (uint)(param_2->num_contacts); // 1
		
		// vector
		uint local_90[3];
		local_90[0] = 0; // local_90
		local_90[1] = 0; // local_8c
		local_90[2] = 0; // local_88
		// vector
		uint local_84[3];
		local_84[0] = 0; // local_84
		local_84[1] = 0; // local_80
		local_84[2] = 0; // local_7c
		
		{
			a = this->38_Avatar_collision_body; // 0x021DCBBC
			b = *(uint*)a; // 0x020f80c8
			func = ((uint*)b)[3]; // 0x0208c1ec
			(*func)(a); // FUN_0208c1ec(a);
		}
		
		u32* c = (this->var_38_Avatar_collision_body)->var_78.var_14;
		u32 vec_movementThisFrame[];
		vec_movementThisFrame[0] = c[0] - this->var_24[0];
		vec_movementThisFrame[1] = c[1] - this->var_24[1];
		vec_movementThisFrame[2] = c[2] - this->var_24[2];
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ds00", 
			"/////// CollisionCompensator::OnCollision () /////// :: FRAME ", 
			*(uint *)(*(int *)0x020fb4e4 - 0x18)); // 925
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"Xs00",
			"--- For agent:  ",
			*(uint *)(this + 0x34)); // 0x021DBBF0
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"Movement this frame: ",
			vector_toString_02072b44(vec_movementThisFrame)); 
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ds00",
			"Contacts to analyze: ",
			num_contacts);
		
		if (num_contacts != 0) {
			for (contact_index = 0; contact_index < num_contacts; contact_index++) {
				DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ds00",
					"> Analyzing contact ",
					contact_index);
				
				param2_sub = ((contact_index & 0xFF) * 0x24 + *(int*)(param_2 + 4));
				
				DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"Xs00",
					"Collision key:     ",
					param2_sub->collision_key;
				
				DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
					"Contact point:     ",
					vector_toString_02072b44(param2_sub->contact_point));
				
				DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ds00",
					"Contact type:      ",
					(u32)(param2_sub->contact_type);
				
				if ( ((int)((uint)param2_sub->v_13 << 0x1d) < 0) || // ????
					(param2_sub->v_1c_collisionbody != this->var38_avatar_collision_body) ) {
					
					DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"s000",
						"Intangible, or not the body of interest.");
					
				} else {
					local_154 = vec_movementThisFrame[0]; // happens earlier in the decompiled code, moved for relevance.
					local_150 = vec_movementThisFrame[2]; // happens earlier in the decompiled code, moved for relevance.
					local_138 = -(int)(param2_sub->v_0c[2]);
					local_13c = -(int)(param2_sub->v_0c[0]);
					
					// i'm just gonna leave these copied over verbatim for now.
					local_14c = (uint)((longlong)local_13c * (longlong)(int)local_154) >> 12 |
						(int)((ulonglong)((longlong)local_13c * (longlong)(int)local_154) >> 32) << 20;
					local_94 = local_14c +
						((uint)((longlong)local_138 * (longlong)local_150) >> 12 |
						(int)((ulonglong)((longlong)local_138 * (longlong)local_150) >> 32) << 20);
					
					u32 local_60[3];
					local_60[0] = (int)(param2_sub->v_0c[0]);
					local_60[1] = (int)(param2_sub->v_0c[1]);
					local_60[2] = (int)(param2_sub->v_0c[2]);
					
					DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
						"Contact normal:   ",
						vector_toString_02072b44(local_60));
					DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
						"Contact depth:    ",
						fixedpoint_toString(param2_sub->v_14));
					DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
						"Dot product, (-normal) * movement: ",
						fixedpoint_toString(local_94));
					
					if (local_94 < 0) {
						iVar8 = (int)(short)param2_sub->v_14;
						u32 local_6c[3]; // local_6c, local_68, and local_64, respectively.
						local_6c[2] = param2_sub->v_0c[2] * iVar8 * 16 >> 16;
						local_6c[1] = 0;
						local_6c[0] = param2_sub->v_0c[0] * iVar8 * 16 >> 16;
						
						DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
							"Push vector: ",
							vector_toString(local_6c));
						
						if (param2_sub->contact_type == 2)
							puVar9 = local_90;
						else
							puVar9 = local_84;
						
						u32 local_48[3]; // local_48, local_44, local_40
						local_48[0] = puVar9[0] + local_6c[0];
						local_48[1] = puVar9[1] + local_6c[1];
						local_48[2] = puVar9[2] + local_6c[2];
						puVar9[0] = local_48[0];
						puVar9[1] = local_48[1];
						puVar9[2] = local_48[2];
					}
				}
				// continue FOR loop
			}
		}
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"s000",
			">> All contacts analyzed.");
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"Aggregate face push vector:",
			vector_toString(local_90));
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"Aggr. non-face push vector:",
			vector_toString(local_84));
		
		if (local_154 != 0 || local_150 != 0 || local_90[0] != 0 || local_90[1] != 0 || local_90[2] != 0) {
			
			/* TODO */
			/* lots of math */
			
		}
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"=> Push vector applied (face):    ",
			vector_toString(local_90));
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"=> Push vector applied (non-face):",
			vector_toString(local_84));
		
		local_3c[0] = this->var3C[0] + local_90[0];
		local_3c[1] = this->var3C[1] + local_90[1];
		local_3c[2] = this->var3C[2] + local_90[2];
		
		this->var3C[0] = local_3c[0];
		this->var3C[1] = local_3c[1];
		this->var3C[2] = local_3c[2];
		
		this->var3C[0] = this->var3C[0] + local_84[0];
		this->var3C[1] = this->var3C[1] + local_84[1];
		this->var3C[2] = this->var3C[2] + local_84[2];
		
		DebugLog.cpp_printDebugString(0x020fdfac, 1, 0x10000, (uint)"ss00",
			"*** Compensation so far this frame: ",
			vector_toString(this->var3C));
		
		return;
	}

}

/** does exactly what it sounds like. */
void arraycopy_u16_x10_FUN_0207ccd4(u16* dst, u16* src) {
	/* snip */
}

int* FUN_0207cd98(s16* src, s32* dst) {
	dst[0] = (s32)src[0];
	dst[1] = (s32)src[1];
	dst[2] = (s32)src[2];
	dst[3] = (s32)src[3];
	dst[4] = (s32)src[4];
	dst[5] = (s32)src[5];
	dst[6] = (s32)src[6];
	dst[7] = (s32)src[7];
	dst[8] = (s32)src[8];
	return dst;
}

// ?
void FUN_0207cde8() {
	return;
}

// ?
void FUN_0207cdec(s32* dst, s32* param_2) {
	dst[0] = src[0];
	dst[1] = src[1];
	dst[2] = src[2];
	dst[0] = src[0];
	dst[1] = src[1];
	dst[2] = src[2];
	return;
}

/** dude....	*/
void FUN_020a5974(s16* dst, s16* src) {
	if ((src[9] & 0x01) != 0) {
		return;
	}
	if (dst[9] & 0x01) == 0) {
		
		// i forget the order of operations with regard to the ">>" (bitshift right) operator,
		// so i've just copied what Ghidra output basically 1:1
		// better not make any typos :)
		
		dst[6] = (s16)((s32)src[0] * (s32)dst[6] >> 12) +
			(s16)(src[3] * (s32)dst[7] >> 12) +
			(s16)((u32)(src[6] * (s32)dst[8] * 16) >> 16);
		
		dst[7] = (s16)((s32)src[1] * (s32)dst[6] >> 12) +
			(s16)(src[4] * (s32)dst[7] >> 12) +
			(s16)((u32)(src[7] * (s32)dst[8] * 16) >> 16);
		
		dst[8] = (s16)((s32)src[2] * (s32)dst[6] >> 12) +
			(s16)(src[5] * (s32)dst[7] >> 12) +
			(s16)((u32)(src[8] * (s32)dst[8] * 16) >> 16);
		
		dst[0] = (s16)((s32)src[0] * (s32)dst[0] >> 12) +
			(s16)(src[3] * (s32)dst[1] >> 12) +
			(s16)((u32)(src[6] * (s32)dst[2] * 16) >> 16);
		
		dst[1] = (s16)((s32)src[1] * (s32)dst[0] >> 12) +
			(s16)(src[4] * (s32)dst[1] >> 12) +
			(s16)((u32)(src[7] * (s32)dst[2] * 16) >> 16);
		
		dst[2] = (s16)((s32)src[2] * (s32)dst[0] >> 12) +
			(s16)(src[5] * (s32)dst[1] >> 12) +
			(s16)((u32)(src[8] * (s32)dst[2] * 16) >> 16);
		
		dst[3] = (s16)((s32)src[0] * (s32)dst[3] >> 12) +
			(s16)(src[3] * (s32)dst[4] >> 12) +
			(s16)((u32)(src[6] * (s32)dst[5] * 16) >> 16);
		
		dst[4] = (s16)((s32)src[1] * (s32)dst[3] >> 12) +
			(s16)(src[4] * (s32)dst[4] >> 12) +
			(s16)((u32)(src[7] * (s32)dst[5] * 16) >> 16);
		
		dst[5] = (s16)((s32)src[2] * (s32)dst[3] >> 12) +
			(s16)(src[5] * (s32)dst[4] >> 12) +
			(s16)((u32)(src[8] * (s32)dst[5] * 16) >> 16);
		
		return;
	}
	
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
	return;
}

void FUN_020b68e4(s32* srcA, s32* srcB, u32* dst) {
	s64 lVar1;
	
	lVar1 = (s64)srcB[6] * (s64)srcA[2] + (s64)srcB[0] * (s64)srcA[0] + (s64)srcA[1] * (s64)srcB[3];
	dst[0] = (u32)lVar1 >> 12 | (s32)((u64)lVar1 >> 0x32) << 20;
	
	lVar1 = (s64)srcB[7] * (s64)srcA[2] + (s64)srcB[1] * (s64)srcA[0] + (s64)srcA[1] * (s64)srcB[4];
	dst[1] = (u32)lVar1 >> 12 | (s32)((u64)lVar1 >> 0x32) << 20;
	
	lVar1 = (s64)srcB[8] * (s64)srcA[2] + (s64)srcB[2] * (s64)srcA[0] + (s64)srcA[1] * (s64)srcB[5];
	dst[2] = (u32)lVar1 >> 12 | (s32)((u64)lVar1 >> 0x32) << 20;
	
	return;
}
