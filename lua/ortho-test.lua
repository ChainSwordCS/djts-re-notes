-- tested in desmume 0.9.13 (x64) on Windows

-- stupid, hacky, but hopefully should be portable to bizhawk

-- for DJTS Beta build only

print("hello world")

-- (doesn't work :P)

function mtx_callbackM1()
	r0 = memory.getregister("r0");
	print(string.format("mtx_callbackM1 variable = %08X", r0));
	print(string.format("param_1=%08X", memory.readdword(r0 + 0x38)));
	print(string.format("param_2=%08X", memory.readdword(r0 + 0x3c)));
	print(string.format("param_3=    %04X", memory.readword(r0 + 0x40)));
	print(string.format("param_4=%08X", memory.readdword(r0 + 0x44)));
	print(string.format("param_5=%08X", memory.readdword(r0 + 0x48)));
end

-- written weird to work around some odd behavior
function printregisters()
	print(string.format("class_instance_ptr=%08X", memory.getregister("r4")));
	print(string.format("param_1=%08X", memory.getregister("r0")));
	print(string.format("param_2=%08X", memory.getregister("r1")));
	print(string.format("param_3=%08X", memory.getregister("r2")));
	print(string.format("param_4=%08X", memory.getregister("r3")));
	--r4 = memory.getregister("r4");
	--print(string.format("param_5=%08X", memory.readdword(r4 + 0x48)));
	sp = memory.getregister("r13");
	print(string.format("param_5=%08X", memory.readdword(sp + 0x00)));
	print(string.format("param_6=%08X", memory.readdword(sp + 0x04)));
	print(string.format("param_7=%08X", memory.readdword(sp + 0x08)));
	print(string.format("param_8=%08X", memory.readdword(sp + 0x0c)));
	
	print(string.format("sp=%08X", memory.getregister("r13")));
	print(string.format("lr=%08X", memory.getregister("r14")));
	print(string.format("pc=%08X", memory.getregister("r15")));--why is it apparently off by 8?
end

-- hack param_7 to set it to 1, not 0
function mtx_callback0()
	print("");
	print("FUN_020ba13c");
	printregisters();
	print("mtx_callback0");
	sp = memory.getregister("r13");
	param_7 = memory.readdword(sp + 0x08);
	if (param_7 == 0) then
		const_enable = 1;
		--memory.setregister("r6", const_enable);
		memory.writedword(sp + 0x08, const_enable);
	end
end

function mtx_callback1()
	print("1");
	mtx_1 = memory.getregister("r0");
	a = math.ceil(((mtx_1 / 4096.0) / 15.0) * 4096.0);
	memory.setregister("r0", a);
	
	mtx_6 = memory.getregister("r7");
	b = math.ceil(((mtx_6 / 4096.0) / 15.0) * 4096.0);
	memory.setregister("r7", b);
end

function mtx_callback2()
	print("2");
	mtx_11 = memory.getregister("r7");
	c = math.ceil(((mtx_11 / 4096.0) / 17.15) * 4096.0);
	memory.setregister("r7", c);
	
	--mtx_12 = memory.getregister("r6");
	d = math.ceil(0.00025 * 4096.0);
	memory.setregister("r6", d); -- the game's code multiplies this by -1, btw
	
	mtx_15 = memory.getregister("r2");
	e = math.ceil(((mtx_15 / 4096.0) * 10) * 4096.0);
	memory.setregister("r2", e);
end

function mtx_callback3()
	print("3");
	--mtx_16 = memory.getregister("r0");
	f = math.ceil(1.0 * 4096.0);
	memory.setregister("r0", f);
	
	-- is this necessary?
	r5 = memory.getregister("r5");
	memory.writedword(r5 + 0x3c, f);
end

--memory.registerexec(0x02097ed4, mtx_callbackM1);
memory.registerexec(0x020ba13c, mtx_callback0);
memory.registerexec(0x020ba220, mtx_callback1);
memory.registerexec(0x020ba2ec, mtx_callback2);
memory.registerexec(0x020ba304, mtx_callback3);
