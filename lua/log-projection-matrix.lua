-- tested in desmume 0.9.13 (x64) on Windows

-- simple debugging tool

print("hello world");

function on3d()
	local evt = _G.registered3devent_which;
	local arg = _G.registered3devent_arg;
	--event types:
	--0: the projection matrix changed (argument is a matrix containing the projection matrix)
	print("proj. matrix:");
	print(string.format("| % .4f, % .4f, % .4f, % .4f |", arg[1], arg[2], arg[3], arg[4]));
	print(string.format("| % .4f, % .4f, % .4f, % .4f |", arg[5], arg[6], arg[7], arg[8]));
	print(string.format("| % .4f, % .4f, % .4f, % .4f |", arg[9], arg[10], arg[11], arg[12]));
	print(string.format("| % .4f, % .4f, % .4f, % .4f |", arg[13], arg[14], arg[15], arg[16]));
end

function exitcallback()
	emu.set3dtransform(0,nil);
end

emu.register3devent(on3d);
emu.registerexit(exitcallback);
emu.set3dtransform(1,nil);
