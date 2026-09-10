-- force-orthographic-projection.lua
-- by ChainSwordCS, 2026
-- based on the reference implementation by zeromus, and the freelook demo by windwakr
-- https://github.com/TASEmulators/desmume/issues/130#issuecomment-426543155
-- https://forums.desmume.org/viewtopic.php?id=11217

-- NOTE:
-- you may have to change some constants for good results;
-- this hasn't been tested on many games.
-- also, this doesn't (currently) mess with camera rotation, you're on your own there, sorry.
--
-- additional note:
-- there are some polygon rendering-order issues, i'm not sure why,
-- and i haven't been able to resolve them as of yet.

function QuatFromYawPitchRollDeg(yaw, pitch, roll)
	--from monogame
	local halfRoll = math.rad(roll * 0.5);
	local halfPitch = math.rad(pitch * 0.5);
	local halfYaw = math.rad(yaw * 0.5);

	local sinRoll = math.sin(halfRoll);
	local cosRoll = math.cos(halfRoll);
	local sinPitch = math.sin(halfPitch);
	local cosPitch = math.cos(halfPitch);
	local sinYaw = math.sin(halfYaw);
	local cosYaw = math.cos(halfYaw);
	return {
		(cosYaw * sinPitch * cosRoll) + (sinYaw * cosPitch * sinRoll),
		(sinYaw * cosPitch * cosRoll) - (cosYaw * sinPitch * sinRoll),
		(cosYaw * cosPitch * sinRoll) - (sinYaw * sinPitch * cosRoll),
		(cosYaw * cosPitch * cosRoll) + (sinYaw * sinPitch * sinRoll)
	};
end

function MatrixFromQuat(quat)
	--from monogame
	local qx = quat[1];
	local qy = quat[2];
	local qz = quat[3];
	local qw = quat[4];
	local num9 = qx * qx;
	local num8 = qy * qy;
	local num7 = qz * qz;
	local num6 = qx * qy;
	local num5 = qz * qw;
	local num4 = qz * qx;
	local num3 = qy * qw;
	local num2 = qy * qz;
	local num = qx * qw;

	return {
		1.0 - (2.0 * (num8 + num7)),
		2.0 * (num6 + num5),
		2.0 * (num4 - num3),
		0.0,
		2.0 * (num6 - num5),
		1.0 - (2.0 * (num7 + num9)),
		2.0 * (num2 + num),
		0.0,
		2.0 * (num4 + num3),
		2.0 * (num2 - num),
		1.0 - (2.0 * (num8 + num9)),
		1.0,
		0.0,
		0.0,
		1.0,
		1.0
	};

end

function HardCodedMatrix()
	return {
		1.8186,
		0.0,
		0.0,
		0.0,
		
		0.0,
		2.4246,
		0.0,
		0.0,
		
		0.0,
		0.0,
		-1.0007,
		-1.0,
		
		0.0,
		0.0,
		-0.1001,
		-1.0
	};
end

identity = {
	1,0,0,0,
	0,1,0,0,
	0,0,1,0,
	0,0,0,1
};

mat = identity; --global
matAdjustment = {};

function on3d()
	local evt = _G.registered3devent_which;
	local arg = _G.registered3devent_arg;
	--event types:
	--0: the projection matrix changed (argument is a matrix containing the projection matrix)

	--here, you should check if the projection matrix is the desired perspective matrix
	--and then call set3dtransform at the appropriate time to set the modified matrix
	--or, you could use this to respond to any change of the projection matrix by providing an adjusted alternative
	
	if(mat[1] ~= arg[1] or mat[2] ~= arg[2] or mat[3] ~= arg[3] or mat[4] ~= arg[4] or mat[5] ~= arg[5] or mat[6] ~= arg[6] or mat[7] ~= arg[7] or mat[8] ~= arg[8] or mat[9] ~= arg[9] or mat[10] ~= arg[10] or mat[11] ~= arg[11] or mat[12] ~= arg[12] or mat[13] ~= arg[13] or mat[14] ~= arg[14] or mat[15] ~= arg[15] or mat[16] ~= arg[16]) then
		mat = arg;
		print("Projection Matrix changed:");
		print(string.format("| % .4f, % .4f, % .4f, % .4f |", mat[1], mat[2], mat[3], mat[4]));
		print(string.format("| % .4f, % .4f, % .4f, % .4f |", mat[5], mat[6], mat[7], mat[8]));
		print(string.format("| % .4f, % .4f, % .4f, % .4f |", mat[9], mat[10], mat[11], mat[12]));
		print(string.format("| % .4f, % .4f, % .4f, % .4f |", mat[13], mat[14], mat[15], mat[16]));
	end
	

--ortho matrix should look like this:
	--* * 0 0
	--* * 0 0
	--* 0 * 0
	--* 0 * 1
	--perspective matrix should look like this:
	--* * 0 0
	--* * 0 0
	--* 0 0 1
	--* 0 * 0

  --so, let's check the final entry for nonzero, and assume that means ortho
	if(arg[16] == 0) then
		emu.set3dtransform(3,matAdjustment);
		--emu.set3dtransform(3,mat);
	else 
		--emu.set3dtransform(3,matAdjustment);
		emu.set3dtransform(1,nil);
	end

end


emu.register3devent(on3d);

local timer = 0;
while true do

	--timer = 10;
	--local yaw = math.sin(math.rad(timer/1.5))*10;
	--local pitch = math.sin(math.rad(timer/3))*10;
	--local quat = QuatFromYawPitchRollDeg(yaw,pitch,0);
	
	--set globally on purpose
	--matAdjustment = MatrixFromQuat(quat); 
	--matAdjustment = HardCodedMatrix();
	
	--matAdjustment = mat;
--	for i, v in ipairs(mat) do
--		matAdjustment[i] = v;
--	end
	
	matAdjustment = {
		(mat[1] / 50), 0.0, 0.0, 0.0,	-- mat[1] is basically viewport width
		0.0, (mat[6] / 50), 0.0, 0.0,	-- mat[6] is basically viewport height
		0.0, 0.0, (mat[11] / 17.15), 0.0,  -- mat[11] is (inverse of?) distance from the camera to the Far-Clip Plane
		0.0, 0.0, (mat[15] * 10), 1.0	-- mat[15] is (inverse of?) distance from the camera to the Near-Clip Plane
	};
	--matAdjustment[11] = -0.01;
	--matAdjustment[1] = 0.0078;
	--matAdjustment[6] = 0.0105;
	--matAdjustment[11] = -0.0012;
	--matAdjustment[12] = 0.0;
	--matAdjustment[15] = -1.1892;
	--matAdjustment[16] = 1.0;
	--matAdjustment[4] = 0.0;
	--matAdjustment[8] = 0.0;
	--matAdjustment[11] = -1.0 * matAdjustment[11];
	--matAdjustment[12] = 0.0;
	--matAdjustment[15] = -0.1001;
	--matAdjustment[15] = -1.0 * matAdjustment[15];
	--matAdjustment[16] = 1.0;

	--0: disable freelook entirely; no 3d events
	--1: enable freelook, but receive only 3d events
	--2: enable freelook and combine the provided matrix with the projection matrix
	--3: enable freelook and use the provided matrix instead of the projection matrix
    emu.set3dtransform(3,matAdjustment);
    --emu.set3dtransform(1,nil);

	emu.frameadvance()
end