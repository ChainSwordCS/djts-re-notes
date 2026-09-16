-- designed for desmume 0.9.13 (Windows x64)

-- compatible rom:
-- Drake and Josh - Talent Showdown (USA) (En,Fr).nds		(CRC32 = 67cbc9ed)

function readstring(ptr)
	outstr = "";
	i = 0;
	c = memory.readbyte(ptr);
	while not (c == 0x00) do
		outstr = outstr .. string.char(c);
		i = i + 1;
		c = memory.readbyte(ptr+i);
	end
	-- ?
	return outstr;
end

-- returns: just a table of the varargs...
-- args:
-- 	s is the string passed to whatever string-format-like function.
-- 	registerOffs is the index of the register to treat as the first vararg in the list
--  (where a value of 1 means register r1, etc.)
function getVarargsForStringFormat(st, registerOffs)
	varargs = { }; -- dict-style table
	varg_index = 1;
	pos = 1;
	while (varg_index < 5) do
		pos = string.find(st, "%", pos, true);
		if (pos) then
			a = string.sub(st, pos+1, pos+1);
			-- this logic is good enough
			if (a == "s") or (a == "S") then
				varargs[varg_index] = readstring(memory.getregister("r"..varg_index));
				
			--elseif (...) then
				-- there are more complex rules we could match for,
				-- but why bother when they're not used in the game?
				
			--elseif (a == "%") then
				--pos = pos + 2
			else
				varargs[varg_index] = memory.getregister("r"..varg_index);
			end
			pos = pos + 2;
			varg_index = varg_index + 1;
		else
			break;
		end
	end
	
	return varargs;
end

-- this hooks into an snprintf-like function
function HOOK_FUN_0209eebc()
	r0 = memory.getregister("r0");
	r0_str = readstring(r0);
	varargs = getVarargsForStringFormat(r0_str, 0);
	-- no array index out of bounds error cuz this is lua.
	-- and string.format() handles it fine when there are extra args passed, they just go unused.
	print(string.format(r0_str, varargs[1], varargs[2], varargs[3], varargs[4]));
	return;
end

-- NOTE: this overlaps with FUN_0209eebc
function HOOK_FUN_0209f050()
	-- i'm feeling lazy, so here's a quick proof of concept
	r2 = readstring(memory.getregister("r2"));
	-- r3 is a pointer to a list of 3 32-bit values, those are the varargs.
	-- todo: write code for that.
	print(r2);
	return;
end

-- todo: investigate FUN_0209e220

memory.registerexec(0x0209eebc, HOOK_FUN_0209eebc);
memory.registerexec(0x0209f050, HOOK_FUN_0209f050);

print(string.format("Hello World! %i %i %i", 1, 2, 3, 4));
