-- tested in desmume 0.9.13 (x64) on Windows

print("hello world")

-- Fixed Point 20.12 (32-bit)
-- highest bit is +/- sign
-- next highest 19 bits are the integer component
-- lowest 12 bits are the decimal/fractional component
--
-- this implementation should be good
function readfixedpoint2012(ptr)
	dword = memory.readdwordsigned(ptr)
	return (dword / 4096.0)
end

function dothing(r7, r8)
	print("h");
	mtx = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	if (r8 ~= 0) and (r7 ~= 0) then
		for i,_ in pairs(mtx) do
			mtx[i] = memory.readdword(r8 + 4 * (i-1));
		end
		print("mtx = {");
		print(string.format("%08X %08X %08X %08X", mtx[1], mtx[2], mtx[3], mtx[4]));
		print(string.format("%08X %08X %08X %08X", mtx[5], mtx[6], mtx[7], mtx[8]));
		print(string.format("%08X %08X %08X %08X", mtx[9], mtx[10], mtx[11], mtx[12]));
		print(string.format("%08X %08X %08X %08X", mtx[13], mtx[14], mtx[15], mtx[16]));
		print("}");
	end
	emu.pause();
end

function FUN_020ba32c_callback()
	--r7 = memory.getregister("r7");
	r8 = memory.getregister("r8");
	dothing(1, r8);
end

function FUN_020ba13c_callback()
	r5 = memory.getregister("r5");
	
	dothing(1, r5);
end

function FUN_020b9e40_callback()
	r6 = memory.getregister("r6");
	
	dothing(1, r6);
end

--memory.registerexec(0x020ba600, FUN_020ba32c_callback);
memory.registerexec(0x020ba310, FUN_020ba13c_callback);
--memory.registerexec(0x020ba120, FUN_020b9e40_callback);
