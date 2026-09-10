-- tested in desmume 0.9.13 (x64) on Windows

info_overlay=1

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
	-- todo: this variable in memory isn't always updated, such as when OnCollision isn't run for a given frame. (?)
	-- so sometimes it's still set to 1 when it should probably be 0.
	-- try to find a workaround
	numContacts = memory.readbyte(locNumContacts)
	
	if(numContacts >= 1) then
		locContactList = memory.readdword(locContactListPtr)
		if(sanityCheckPtr(locContactList)) then
			i = 0
			while(i < numContacts) do
				--locCollisionBody1 = memory.readdword(locContactList + i * 0x24 + 0x1C)
				locCollisionBody2 = memory.readdword(locContactList + i * 0x24 + 0x20)
				if(sanityCheckPtr(locCollisionBody2)) then
					-- todo: check vptr to determine what kind of CollisionBody this is?
					vtx_A_x = readfixedpoint2012(locCollisionBody2 + 0x04)
					vtx_A_y = readfixedpoint2012(locCollisionBody2 + 0x08)
					vtx_A_z = readfixedpoint2012(locCollisionBody2 + 0x0C)
					vtx_B_x = readfixedpoint2012(locCollisionBody2 + 0x10)
					vtx_B_y = readfixedpoint2012(locCollisionBody2 + 0x14)
					vtx_B_z = readfixedpoint2012(locCollisionBody2 + 0x18)
					print("contact " .. i)
					print("vtx_A=(" .. vtx_A_x .. "," .. vtx_A_y .. "," .. vtx_A_z .. ")")
					print("vtx_B=(" .. vtx_B_x .. "," .. vtx_B_y .. "," .. vtx_B_z .. ")")
					if(info_overlay == 1) then
						gui.text(0,24*i+2,("contact " .. i))
						gui.text(0,24*i+10,("vtx_A=(" .. vtx_A_x .. "," .. vtx_A_y .. "," .. vtx_A_z .. ")"))
						gui.text(0,24*i+18,("vtx_B=(" .. vtx_B_x .. "," .. vtx_B_y .. "," .. vtx_B_z .. ")"))
					end
				else
					panic=1
					print("error, locCollisionBody=")
					print(locCollisionBody)
				end
				i = i + 1
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
