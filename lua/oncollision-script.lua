-- tested in desmume 0.9.13 (x64) on Windows

info_overlay=1
draw_collision_overlay=0 -- experimental
csv_style_logging=1

locNumContacts = 0x027E0A49
locContactListPtr = 0x027E0A4C
locContactList = 0x027E0808 -- common value (placeholder)
numContacts=0
locCamPtr = 0x0212118C

panic=0

print("hello world")
if csv_style_logging then
	print("csv_style_logging=1")
	print("collisionKey, x1, y1, z1, x2, y2, z2")
end
unique_contacts = {
	{ -1, 0, 0, 0, 0, 0, 0 }
}

-- (unused)
last_logged_repeat_contacts = { 0, 0, 0 }
has_just_printed_cont = { false, false, false }

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
	inte = dword / 0x1000 -- float division cuz lua 5.1
	inte = inte % 0x100000 -- result is implicitly rounded down to nearest integer here anyways
	if(dword >= 0x80000000) then
		deci = (4096.0 - deci) / 4096.0
		inte = (inte - 0xfffff) - 1
		result = deci + inte
	else
		deci = deci / 4096.0
		result = deci + inte
	end
	return result
end


-- 3d viewport constants
-- (inexplicable magic numbers are asspulls fyi)

-- for use with just the "Camera pointed straight down" AR code:
const_vp_w = 4.67*2.0
const_vp_h = 3.5*2.0

const_vp_x_fac = 256.0 / const_vp_w
const_vp_z_fac = 192.0 / const_vp_h

-- simple and hacky. only designed to work with certain camera hacks in play.
function drawOverlay()
	cam_ptr = memory.readdword(locCamPtr)
	if cam_ptr == 0 then
		-- probably not in-game; abort!
		return
	end
	
	gui.opacity(0.5)
	
	cam_x = readfixedpoint2012(cam_ptr + 0x90)
	cam_z = readfixedpoint2012(cam_ptr + 0x98)
	
	-- 4:3 aspect
	-- "vp" stands for "viewport" btw
	vp_topleft  = { cam_x-const_vp_w/2.0, cam_z-const_vp_h/2.0 }
	vp_botright = { cam_x+const_vp_w/2.0, cam_z+const_vp_h/2.0 }
	
	for _, c in pairs(unique_contacts) do
		-- test that both points are within view
		--if (1 == 1) then
		if (c[2] > vp_topleft[1] and c[2] < vp_botright[1]) -- x1
		and (c[4] > vp_topleft[2] and c[4] < vp_botright[2]) -- z1
		and (c[5] > vp_topleft[1] and c[5] < vp_botright[1]) -- x2
		and (c[7] > vp_topleft[2] and c[7] < vp_botright[2]) then -- z2
			-- map onto new coord plane
			x1 = (c[2] * const_vp_x_fac) - (vp_topleft[1] * const_vp_x_fac)
			z1 = (c[4] * const_vp_z_fac) - (vp_topleft[2] * const_vp_z_fac)
			x2 = (c[5] * const_vp_x_fac) - (vp_topleft[1] * const_vp_x_fac)
			z2 = (c[7] * const_vp_z_fac) - (vp_topleft[2] * const_vp_z_fac)
			-- subtract 192 from the y value to draw on the top screen
			gui.drawrect(x1, z1-192, x2, z2-192)
			print(string.format("debug: drawrect(%.1f, %.1f, %.1f, %.1f)",x1,z1-192,x2,z2-192))
		end
	end
	
	gui.opacity(1.0) -- return to normal afterwards
	return
end

function update()
	-- todo
end

function onCollisionCallback()
	if (panic == 1) then
		return
	end
	param_2_ptr = memory.getregister("r1")
	numContacts = memory.readbyte(param_2_ptr + 1)
	if(numContacts >= 1) then
		locContactList = memory.readdword(param_2_ptr + 4)
		if(sanityCheckPtr(locContactList)) then
			--print("numContacts=" .. numContacts)
			i = 0
			while(i < numContacts) do
				collisionKey = memory.readdword(locContactList + i * 0x24 + 0x18)
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
					
					-- logic to avoid excessive logging of duplicate data
					is_dupe = false
					for _, c in pairs(unique_contacts) do
						if collisionKey == c[1] and vtx_A_x == c[2] and vtx_A_y == c[3] and vtx_A_z == c[4] and vtx_B_x == c[5] and vtx_B_y == c[6] and vtx_B_z == c[7] then
							is_dupe = true
							break
						end
					end
					if not is_dupe then
						table.insert(unique_contacts, {collisionKey,vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z})
						if(csv_style_logging == 1) then
							print(string.format("\"%08X\", % 8.3f, % 8.3f, % 8.3f, % 8.3f, % 8.3f, % 8.3f",collisionKey,vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z))
						else
							print("contact " .. i .. ":")
							print(string.format("collisionkey=%08X , ",collisionKey) .. string.format("vertices = (% 8.3f, % 8.3f, % 8.3f), (% 8.3f, % 8.3f, % 8.3f)",vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z))
						end
					else
						if(csv_style_logging == 0) then
							--if last_logged_repeat_contacts[i] == collisionKey then
							--	if not has_just_printed_cont[i] then
							--		print("(cont.)")
							--		has_just_printed_cont[i] = true
							--	end
							--else
							print(string.format("contact %i (REPEAT): collisionkey=%08X", i, collisionKey))
							--	has_just_printed_cont[i] = false
							--end
						end
					end
					
					-- todo: this part has some kinks to work out still. (flickering, mainly.)
					if(info_overlay == 1) then
						gui.text(0,24*i+2,string.format("contact %i; collisionkey=%08X", i, collisionKey))
						gui.text(0,24*i+10,string.format("vtx_A=(% 8.3f, % 8.3f, % 8.3f)",vtx_A_x,vtx_A_y,vtx_A_z))
						gui.text(0,24*i+18,string.format("vtx_B=(% 8.3f, % 8.3f, % 8.3f)",vtx_B_x,vtx_B_y,vtx_B_z))
					end
				else
					panic=1
					print(string.format("error: locCollisionBody=%08X", locCollisionBody))
				end
				i = i + 1
			end
		else
			panic=1
			print(string.format("error: locContactList=%08X", locContactList))
		end
	end
end

memory.registerexec(0x02031e2c, onCollisionCallback)
if(draw_collision_overlay == 1) then
	gui.register(drawOverlay)
end

-- Main loop ----------------------------------------------------------------------------------------------------------
while true do
	update()
	emu.frameadvance()
end
