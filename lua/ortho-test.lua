-- tested in desmume 0.9.13 (x64) on Windows

-- stupid, hacky, but hopefully should be portable to bizhawk

-- for DJTS Beta build only

print("hello world")

-- (doesn't work :P)

function mtx_callback1()
	print("hi");
	mtx_1 = memory.getregister("r0");
	memory.setregister("r0", mtx_1 / (15.0 * 12));
	mtx_6 = memory.getregister("r7");
	memory.setregister("r7", mtx_6 / (15.0 * 12));
end

function mtx_callback2()
	mtx_11 = memory.getregister("r7");
	memory.setregister("r7", mtx_11 / (17.15 * 12));
	--mtx_12 = memory.getregister("r6");
	memory.setregister("r6", (0.00025 * 12)); -- the game's code multiplies this by -1, btw
	mtx_15 = memory.getregister("r2");
	memory.setregister("r2", mtx_15 * (10 * 12));
end

function mtx_callback3()
	mtx_16 = memory.getregister("r0");
	memory.setregister("r0", (1.0 * 12));
end

memory.registerexec(0x020ba220, mtx_callback1);
memory.registerexec(0x020ba2ec, mtx_callback2);
memory.registerexec(0x020ba304, mtx_callback3);
