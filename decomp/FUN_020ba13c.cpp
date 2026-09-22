
// pseudocode

#pragma once

#include "io_registers.h"

void FUN_02097ed4(int param_1, int param_2) {
	/* snip */
	FUN_020ba13c(*(uint *)(param_1 + 0x38), *(uint *)(param_1 + 0x3c), 
		(int)*(short *)(param_1 + 0x40), *(int *)(param_1 + 0x44), *(int *)(param_1 + 0x48), 
		0x1000, 0, 0x020fff88);
	/* snip */
}

/** For context, this function gets called from seemingly only 1 place:
	FUN_02097ed4.
	these are (basically?) always the same args passed:
	param_1=     61A
	param_2=     ECB
	param_3=    1555
	param_4=      CD
	param_5=   96000
	param_6=    1000
	param_7=       0
	param_8=020FFF88
 */
void FUN_020ba13c(undefined4 param_1, undefined4 param_2, undefined4 param_3, int param_4, int param_5, int param_6, int param_7, uint* param_8)
{
	uint uVar4 = FUN_020b792c(param_2, param_1);
	
	// this function is (or can be) used to set the projection matrix (?)
	
	// i don't care enough to transcribe ghidra's decompiled output right now lol.
	// go look at ortho-test.lua
}
