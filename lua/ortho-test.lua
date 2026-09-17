-- tested in desmume 0.9.13 (x64) on Windows

-- stupid, hacky, but hopefully should be portable to bizhawk

-- for DJTS Beta build only

print("hello world")

-- (doesn't work :P)

-- hack param_7 to set it to 1, not 0
function mtx_callback0()
	--memory.setregister("r6", 1);
	sp = memory.getregister("r13");
	memory.writedword(sp + 0x08, 1);
	print("param_7="..memory.readdword(sp + 0x08));
end

function mtx_callback1()
	--print("hi");
	mtx_1 = memory.getregister("r0");
	memory.setregister("r0", mtx_1 / (15.0 * 4096.0));
	mtx_6 = memory.getregister("r7");
	memory.setregister("r7", mtx_6 / (15.0 * 4096.0));
end

function mtx_callback2()
	mtx_11 = memory.getregister("r7");
	memory.setregister("r7", mtx_11 / (17.15 * 4096.0));
	--mtx_12 = memory.getregister("r6");
	memory.setregister("r6", (0.00025 * 4096.0)); -- the game's code multiplies this by -1, btw
	mtx_15 = memory.getregister("r2");
	memory.setregister("r2", mtx_15 * (10 * 4096.0));
end

function mtx_callback3()
	mtx_16 = memory.getregister("r0");
	memory.setregister("r0", (1.0 * 4096.0));
	
	-- is this necessary?
	r5 = memory.getregister("r5");
	memory.writedword(r5 + 0x3c, (1.0 * 4096.0));
end

memory.registerexec(0x020ba13c, mtx_callback0);
memory.registerexec(0x020ba21c, mtx_callback1);
memory.registerexec(0x020ba2e8, mtx_callback2);
memory.registerexec(0x020ba300, mtx_callback3);
