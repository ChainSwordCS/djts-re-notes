-- untested

locNumContacts = 0x027E0A49
locContactListPtr = 0x027E0A4C
locContactList = 0x027E0808 -- common value (placeholder)
numContacts=0

panic=0

-- returns true if the pointer seems valid
function sanityCheckPtr(ptr)
	if(ptr > 0x02000000) and (ptr < 0x02800000) then
		return true
	end
	return false
end

function update()
	if panic then
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
				corner_A_x = 1.0 * memory.readdword(locCollisionBody + 0x04)
				corner_A_y = 1.0 * memory.readdword(locCollisionBody + 0x08)
				corner_A_z = 1.0 * memory.readdword(locCollisionBody + 0x0C)
				corner_B_x = 1.0 * memory.readdword(locCollisionBody + 0x10)
				corner_B_y = 1.0 * memory.readdword(locCollisionBody + 0x14)
				corner_B_z = 1.0 * memory.readdword(locCollisionBody + 0x18)
				-- unsigned -> signed
				if(corner_A_x > 0x8000000) then corner_A_x = (corner_A_x - 0xffffffff) - 1 end
				if(corner_A_y > 0x8000000) then corner_A_y = (corner_A_y - 0xffffffff) - 1 end
				if(corner_A_z > 0x8000000) then corner_A_z = (corner_A_z - 0xffffffff) - 1 end
				if(corner_B_x > 0x8000000) then corner_B_x = (corner_B_x - 0xffffffff) - 1 end
				if(corner_B_y > 0x8000000) then corner_B_y = (corner_B_y - 0xffffffff) - 1 end
				if(corner_B_z > 0x8000000) then corner_B_z = (corner_B_z - 0xffffffff) - 1 end
				print("test")
				print("corner_A=(" .. corner_A_x .. "," .. ")")
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