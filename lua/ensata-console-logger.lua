-- designed for desmume 0.9.13 (Windows x64)

const_charOutEnsata = 0x04FFF000;
const_charOutNocash = 0x04FFFA1C;


-- char format is ASCII
log_string = ""

-- args:
-- c is the char value (type: number)
-- console indicates whether this is...
--  1 = charOutEnsata
--  2 = charOutNocash
-- (currently unused)
function logChar(c, console)
	if (c == 0x0A) then
		--print("[debug] string is '\\n' terminated");
		print(log_string);
		log_string = "";
	--elseif (c == 0x00) then -- (this doesn't appear to happen in real practice.)
	--	if not (log_string == "") then
	--		--print("[debug] string is $00 terminated");
	--		print(log_string);
	--		log_string = "";
	--	end
	else
		log_string = log_string .. string.char(c);
	end
end

function readCharEnsata(address, size, value)
	if value then
		--c = memory.readbyte(const_charOutEnsata); -- THIS DOESN'T WORK!!
		logChar(value, 1);
	else
		-- why is this value always nil??
		-- you tell me to refer to the fceux lua api docs 
		-- and then you don't even adhere to that.
		
		-- whatever.
		
		-- hack: this memory address is only written to in one line of assembly,
		-- in the nitro sdk's OS_PutStringAris function,
		-- in which (usually...?) the char is copied from the r2 register,
		-- so just read that i guess.
		r2 = memory.getregister("r2");
		-- interesting, but don't bother logging with an error message, cuz this is just a quirk inherent to this way of doing it.
		--if (c > 255) then print(string.format("ensata-console-logger.lua error: char value is %08X (for char %02X aka '%s')", c, c%256, string.char(c%256))) end
		logChar(r2 % 256, 1);
	end
	--print(string.format("[debug] readCharEnsata(_,_,'%s'", string.char(value)))
end

function readCharNocash(address, size, value)
	if value then
		--c = memory.readbyte(const_charOutNocash); -- THIS DOESN'T WORK!!
		logChar(value, 2);
	else
		-- refer to readCharEnsata()
		r2 = memory.getregister("r2");
		r2 = r2 % 256;
		logChar(r2, 2);
	end
	--print(string.format("[debug] readCharNocash(_,_,'%s'", string.char(value)))
end

function exit()
	if not (log_string == "") then
		print(log_string);
	end
end

memory.registerwrite(const_charOutEnsata, 1, readCharEnsata);
memory.registerwrite(const_charOutNocash, 1, readCharNocash);
emu.registerexit(exit);



-- Main loop ------------------------------------------------------------------
while true do
	emu.frameadvance()
end
