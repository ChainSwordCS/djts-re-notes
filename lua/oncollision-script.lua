-- tested in desmume 0.9.13 (x64) on Windows

-- feature enable flags
info_overlay=1
draw_collision_overlay=1 -- experimental
csv_style_logging=1

-- minor extra logging flags for testing
cb_x3y3z3=true
cb_vptr=true
cb_ptr=true


-- 3d viewport constants
-- aka "size of the 3D camera viewport, in in-game units"

-- for "not as high camera" code, "Camera pointed straight down" code, and "force-orthographic-projection.lua":
const_vp_h = 12.387
const_vp_w = const_vp_h * 4 / 3

-- for use with just the "Camera pointed straight down" AR code:
--const_vp_w = 4.67*2.0
--const_vp_h = 3.5*2.0


locNumContacts = 0x027E0A49
locContactListPtr = 0x027E0A4C
locContactList = 0x027E0808 -- common value (placeholder)
numContacts=0
locCamPtr = 0x0212118C

panic=0

print("hello world")
if csv_style_logging then
	print("csv_style_logging=1")
	line1 = ""
	if cb_ptr then
		line1 = line1 .. "CollisionBody ptr,"
	end
	line1 = line1 .. "collisionKey, x1, y1, z1, x2, y2, z2,"
	if cb_x3y3z3 then
		line1 = line1 .. "x3,y3,z3,"
	end
	if cb_vptr then
		line1 = line1 .. "vptr,"
	end
	print(line1)
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
-- this implementation should be good
function readfixedpoint2012(ptr)
	dword = memory.readdwordsigned(ptr)
	return (dword / 4096.0)
end

-- tracks whether the current frame of emulated nds execution is a new frame just rendered and presented by the 3D Engine,
-- (true)
-- or if it's just a duplicate (nds runs at 60 hz, this game redraws the 3D scene at 30 hz maximum), or a lag frame
-- (false)
-- not to be confused with desmume emulator GUI update frames
isNew3dEngineFrame = true
isNew3dEngineFrame2 = true -- one frame delayed
isNew3dEngineFrame3 = true -- two frames delayed
_frame_count_prev_value = -1
function checkIsNew3dEngineFrame()
	isNew3dEngineFrame3 = isNew3dEngineFrame2
	isNew3dEngineFrame2 = isNew3dEngineFrame
	-- potential bytes in memory to try, for tracking this
	-- (which increment on every new frame rendered and presented by the 3D Engine,
	-- and which do not increment on off-frames (30 fps) or lag frames.)
	-- (DJTS beta debug build only. offsets will be different from retail build.)
	--02106ab8
	--021090a8
	--02121194
	--021547d2
	--021548b2
	--02154992
	--02154a72
	--02266b68
	--02266f48
	--0227f9f8
	--02360da0
	--02360df8
	--02361380
	-- same as above, but paused during bottom-screen dialogue
	--021dcbec
	--023615dc
	--02361620
	--023616ac
	--023616f0
	--02361800
	--0236184c
	a = memory.readbyte(0x02106ab8)
	if a == _frame_count_prev_value then
		isNew3dEngineFrame = false
	else
		_frame_count_prev_value = a
		isNew3dEngineFrame = true
	end
	return
end

const_vp_x_fac = 256.0 / const_vp_w
const_vp_z_fac = 192.0 / const_vp_h

_drawCollision_prevFrameRectList = { {0,0,0,0}, {0,0,0,0} }
-- simple and hacky. only designed to work with certain camera hacks in play.
function drawOverlay()
	cam_ptr = memory.readdword(locCamPtr)
	if cam_ptr == 0 then
		-- probably not in-game; abort!
		return
	end
	gui.opacity(0.5)
	if isNew3dEngineFrame3 and not emu.paused then
		-- refresh
		_drawCollision_prevFrameRectList = { }
		cam_x = readfixedpoint2012(cam_ptr + 0x90)
		cam_z = readfixedpoint2012(cam_ptr + 0x98)
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
				--print(string.format("debug: drawrect(%.1f, %.1f, %.1f, %.1f)",x1,z1-192,x2,z2-192))
				table.insert(_drawCollision_prevFrameRectList, {x1, z1, x2, z2})
				
				if (cb_x3y3z3) then
					-- map onto new coord plane
					x3 = (c[8] * const_vp_x_fac) - (vp_topleft[1] * const_vp_x_fac)
					z3 = (c[10] * const_vp_z_fac) - (vp_topleft[2] * const_vp_z_fac)
					green = "#00FF00"
					gui.drawrect(x3-1, z3-192-1, x3+1, z3-192+1, green)
					table.insert(_drawCollision_prevFrameRectList,{x3-1,z3-1, x3+1, z3+1, green})
					--print(string.format("debug: drawrect(%.1f, %.1f, %.1f, %.1f)",x3-1,z3-193,x3+1,z3-191))
				end
			end
		end
	else
		-- redraw the same stuff we drew last frame
		for _, rect in pairs(_drawCollision_prevFrameRectList) do
			if (#rect == 5) then
				gui.drawrect(rect[1], rect[2]-192, rect[3], rect[4]-192, rect[5])
			else
				gui.drawrect(rect[1], rect[2]-192, rect[3], rect[4]-192)
			end
			--print(string.format("debug: drawrect(%.1f, %.1f, %.1f, %.1f)",x1,z1-192,x2,z2-192))
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
					
					x3 = readfixedpoint2012(locCollisionBody2 + 0x8C)
					y3 = readfixedpoint2012(locCollisionBody2 + 0x90)
					z3 = readfixedpoint2012(locCollisionBody2 + 0x94)
					vptr = memory.readdword(locCollisionBody2 + 0x00)
					
					-- logic to avoid excessive logging of duplicate data
					is_dupe = false
					for _, c in pairs(unique_contacts) do
						if collisionKey == c[1] and vtx_A_x == c[2] and vtx_A_y == c[3] and vtx_A_z == c[4] and vtx_B_x == c[5] and vtx_B_y == c[6] and vtx_B_z == c[7] then
							is_dupe = true
							break
						end
					end
					outstring = ""
					if not is_dupe then
						new_entry = {collisionKey,vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z}
						if cb_x3y3z3 then
							new_entry[8] = x3
							new_entry[9] = y3
							new_entry[10] = z3
						end
						--if cb_vptr then
						--	new_entry[11] = vptr
						--end
						table.insert(unique_contacts, new_entry)
						if(csv_style_logging == 1) then
							if cb_ptr then
								outstring = outstring .. string.format("\"%08X\",", locCollisionBody2)
							end
							outstring = outstring .. string.format("\"%08X\",% 8.3f,% 8.3f,% 8.3f,% 8.3f,% 8.3f,% 8.3f,",collisionKey,vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z)
							if cb_x3y3z3 then
								outstring = outstring .. string.format("% 8.3f,% 8.3f,% 8.3f,",x3,y3,z3)
							end
							if cb_vptr then
								outstring = outstring .. string.format(" \"%08X\",", vptr)
							end
						else
							outstring = outstring .. "contact " .. i .. ":\n"
							if cb_ptr then
								outstring = outstring .. string.format("cb_ptr=%08X , ", locCollisionBody2)
							end
							outstring = outstring .. string.format("collisionkey=%08X , ",collisionKey) .. string.format("vertices = (% 8.3f, % 8.3f, % 8.3f), (% 8.3f, % 8.3f, % 8.3f)",vtx_A_x,vtx_A_y,vtx_A_z,vtx_B_x,vtx_B_y,vtx_B_z)
							if cb_x3y3z3 then
								outstring = outstring .. string.format(", ( % 8.3f, % 8.3f, % 8.3f)",x3,y3,z3)
							end
							if cb_vptr then
								outstring = outstring .. string.format(", vptr=%08X", vptr)
							end
						end
					else
						if(csv_style_logging == 0) then
							--if last_logged_repeat_contacts[i] == collisionKey then
							--	if not has_just_printed_cont[i] then
							--		outstring = outstring .. "(cont.)"
							--		has_just_printed_cont[i] = true
							--	end
							--else
							outstring = outstring .. string.format("contact %i (REPEAT): collisionkey=%08X", i, collisionKey)
							--	has_just_printed_cont[i] = false
							--end
						else
							--outstring = outstring .. string.format("\"%08X\", \"(dupe)\",,,,,,", collisionKey)
						end
					end
					
					if not (outstring == "") then
						print(outstring)
						outstring = ""
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
	checkIsNew3dEngineFrame()
	update()
	emu.frameadvance()
end
