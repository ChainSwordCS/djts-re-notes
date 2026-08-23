

// example case:

this = 0x0236F8BC;
param_1 = 0x02313D58;
param_2 = 0x6000001F;
param_3 = 0x80000000;
retaddr = 0x020280C4;

void SaboteurEffect_cpp_FUN_02035d48(SaboteurEffect *this,undefined4 param_1,undefined4 param_2,uint param_3)

{
	undefined *puVar1;
	undefined *puVar2;
	int iVar3;
	undefined4 *puVar4;
	undefined4 uVar5;
	u16 auStack_50[4]; // local_50, local_4e, local_4c, local_4a
	undefined4 local_48;
	undefined4 auStack_44 [3];
	undefined4 auStack_38 [3];
	u16 auStack_2c [4];
	undefined4 local_24;
	undefined4 local_20;
	undefined4 local_1c;
	undefined4 local_18;
	undefined4 local_14;
	undefined4 local_10;
	
	FUN_02030f4c(this);
	
	this[4] = 0x020f6ad4; // ?
	this[5] = 0x020ed970; // ?
	this[0] = 0x020ed928; // ?
	this[4] = 0x020ed950; // ?
	this[5] = 0x020ed964; // ?
	//puVar2 = PTR_PTR_02035ed4;
	this[0] = 0x020f0c70;
	//puVar1 = PTR_PTR_02035ed8;
	this[4] = 0x020f0c98;
	this[5] = 0x020f0cac;
	this[6] = param_1;
	this[7] = 0;
	*(undefined1 *)(this + 9) = 1;
	if (this[6] == 0) {
		OS_VSNPrintf_wrapper_020bc870(PTR_print_buf_02035edc,0x300,PTR_s_Invalid_Owner__02035ee0);
		iVar3 = debug_FUN_0200664c();
		print_assert_error_02075850(iVar3,PTR_s_SaboteurEffect_cpp_02035ee4,0x11,PTR_print_buf_02035edc)
		;
	}
	
	auStack_50[0] = 0;
	auStack_50[1] = 0; // local_4e
	auStack_50[2] = 0; // local_4c
	auStack_50[3] = 0x1000; // local_4a
	
	local_48 = *(undefined4 *)PTR_DAT_02035ee8;
	
	local_18 = 0x1000;
	local_14 = 0x1000;
	local_10 = 0x1000;
	local_24 = 0;
	local_20 = 0;
	local_1c = 0;
	puVar4 = (undefined4 *)FUN_02010770();
	FUN_02010754(auStack_44,puVar4);
	puVar4 = (undefined4 *)FUN_02010770();
	FUN_02010754(auStack_38,puVar4);
	FUN_02010718(auStack_2c,auStack_50);
	uVar5 = createAgent__0207bc54(*(uint *)PTR_DAT_02035eec,&local_48,0);
	this[7] = uVar5;
	if (this[7] == 0) {
		OS_VSNPrintf_wrapper_020bc870
							(PTR_print_buf_02035edc,0x300,PTR_s_Failed_to_instantiate_Saboteur_E_02035ef0);
		iVar3 = debug_FUN_0200664c();
		print_assert_error_02075850(iVar3,PTR_s_SaboteurEffect_cpp_02035ee4,0x14,PTR_print_buf_02035edc)
		;
	}
	FUN_020105f0(*(int *)(*(int *)PTR_DAT_02035ef4 + 4) + 0x44,this[7]);
	return;
}

#pragma thumb off

/** reading return value may lead to undefined behavior, i think.
	(this function doesn't return anything. it doesn't touch r0, just bx lr.
*/
asm undefined4 FUN_02010770() {
	bx lr // return;
}

#pragma thumb reset
