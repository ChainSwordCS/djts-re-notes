-- untested

locNumContacts = 0x027E0A49
locContactListPtr = 0x027E0A4C
locContactList = 0x027E0808 -- common value (placeholder)
numContacts=0

panic=0

print("hello world")

-- returns true if the pointer seems valid
function sanityCheckPtr(ptr)
	if(ptr > 0x02000000) and (ptr < 0x02800000) then
		return true
	end
	return false
end

-- Fixed Point 20.12 (32-bit)
-- highest bit is +/- sign
-- next highest 19 bits are the integer component
-- lowest 12 bits are the decimal/fractional component
--
-- additional note: not sure i've implemented this correctly!
function readfixedpoint2012(ptr)
	dword = memory.readdword(ptr)
	result = 0.0
	deci = 1.0 * (dword % 0x1000)
	inte = dword / 0x1000 -- result is(?) implicitly rounded down to nearest integer here
	inte = inte % 0x100000
	if(dword > 0x8000000) then
		deci = (4096.0 - deci) / 4096.0
		inte = (inte - 0xfffff) - 1
		result = deci + inte
	else
		deci = deci / 4096.0
		result = deci + inte
	end
	return result
end

function update()
	if (panic == 1) then
		return
	end
	numContacts = memory.readbyte(locNumContacts)
	
	if(numContacts > 0) then
		locContactList = memory.readdword(locContactListPtr)
		if(sanityCheckPtr(locContactList)) then
			-- lazy; only care about contact 1
			locCollisionBody = memory.readdword(locContactList + 0x20)
			if(sanityCheckPtr(locCollisionBody)) then
				-- todo: check vptr to determine what kind of CollisionBody this is?
				corner_A_x = readfixedpoint2012(locCollisionBody + 0x04)
				corner_A_y = readfixedpoint2012(locCollisionBody + 0x08)
				corner_A_z = readfixedpoint2012(locCollisionBody + 0x0C)
				corner_B_x = readfixedpoint2012(locCollisionBody + 0x10)
				corner_B_y = readfixedpoint2012(locCollisionBody + 0x14)
				corner_B_z = readfixedpoint2012(locCollisionBody + 0x18)
				print("current collisionbody:")
				print("corner_A=(" .. corner_A_x .. "," .. corner_A_y .. "," .. corner_A_z .. ")")
				print("corner_B=(" .. corner_B_x .. "," .. corner_B_y .. "," .. corner_B_z .. ")")
			else
				panic=1
				print("error, locCollisionBody=")
				print(locCollisionBody)
			end
		else
			panic=1
			print("error, locContactList=")
			print(locContactList)
		end
	end
end

-- Main loop ----------------------------------------------------------------------------------------------------------
while true do
	update()
	emu.frameadvance()
end
