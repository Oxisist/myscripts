local S = setmetatable({}, {["__index"] = function(self, index) return game:GetService(index) end})

pcall(function() _G["poohub"]:Disconnect() end)

if getfenv().rconsoleprint then
	getfenv().rconsoleprint("\n\nThank you for using PooHub!")
	getfenv().rconsoleprint([[
	
	.id - Shows you the ID being played
	.bp - Plays audio through your backpack client
	.rj - Rejoins
	.tp - Sets the time position
	.tpa - Restarts audio
	.re - Refreshes your avatar
	.off - Turns off lowhold
	.mute - Mutes the server
	.gtools - Grabs tools
	.hop - Serverhops (NOT WORKING)
	.lowhold - Low hold for boombox gears
	]])
end

local LocalPlayer; LocalPlayer = S.Players.LocalPlayer
_G["poohub"] = LocalPlayer.Chatted:connect(function(message)
	local PlayerGui = LocalPlayer:FindFirstChildWhichIsA("BasePlayerGui")
	local Backpack = LocalPlayer:FindFirstChildWhichIsA("Backpack")
	local PlayerScripts = LocalPlayer:FindFirstChildWhichIsA("PlayerScripts")
	local Character = LocalPlayer.Character

	assert(PlayerGui and Backpack and PlayerScripts and Character, "Missing player asset.")

	local args = string.split(message, " ")
	table.remove(args, 1)
	local id

	if string.sub(message, 1, 3) == ".id" then
		id = string.sub(message,5)
		local args = message:split(" ")
		for _,v in pairs(Backpack:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v.Parent = Character end
		end
		task.wait(0.1)
		local id = args[2]
		local zeros = 199950
		for _,v in pairs(Character:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", ("0"):rep(zeros)..id, 1, 0, 0) end
		end 
	elseif string.sub(message,1,3) == ".bp" then
		id = string.sub(message,5)
		for _,v in pairs(Backpack:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v.Parent = Character end
		end
		for _,v in pairs(Character:GetChildren()) do
			local zeros = 199950
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", ("0"):rep(zeros)..id, 1, 0, 0) end
		end
		wait(.6)
		for _,v in pairs(Character:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then Character.Humanoid:UnequipTools() end
		end
		wait(.6)
		for _,v in pairs(Backpack:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
				v.Handle.Sound.TimePosition = 0
				v.Handle.Sound.Playing = true
			end
		end
	elseif string.sub(message,1,3) == ".rj" then
		S.TeleportService:Teleport(game.PlaceId, LocalPlayer);
	elseif string.sub(message, 1, 3) == ".tp" then
		for _,v in pairs(Character:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
				v.Handle.Sound.TimePosition = args[2]
			end
		end
		for _,v in pairs(Backpack:GetChildren()) do
			if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
				v.Handle.Sound.TimePosition = args[2]
			end
		end
	elseif string.sub(message,1,4) == ".tpa" then
		for _,v in pairs(S.Players:GetPlayers()) do
			if v ~= LocalPlayer then
				for _,v2 in pairs(workspace[v.Name]:GetChildren()) do
					if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then 
						v2.Handle.Sound.TimePosition = args[2]
					end
				end
				for _,v2 in pairs(v.Backpack:GetChildren()) do
					if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then 
						v2.Handle.Sound.TimePosition = args[2]
					end
				end
			end
		end
	elseif string.sub(message,1,3) == ".re" then
		return S.Players.Character:BreakJoints()
	elseif string.sub(message,1,4) == ".off" then
		for _,v in pairs(S.Players:GetPlayers()) do
			if v ~= LocalPlayer then
				for _,v2 in pairs(workspace[v.Name]:GetChildren()) do
					if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.Playing = false; end
				end
				for _,v2 in pairs(v.Backpack:GetChildren()) do
					if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.Playing = false; end
				end
			end
		end
	elseif string.sub(message,1,5) == ".mute" then
		while wait(.03) do
			for _,v in pairs(S.Players:GetPlayers()) do
				if v ~= LocalPlayer then
					for _,v2 in pairs(workspace[v.Name]:GetChildren()) do
						if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.TimePosition = 0 end
					end
					for _,v2 in pairs(v.Backpack:GetChildren()) do
						if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.TimePosition = 0 end
					end
				end
			end
		end
	elseif string.sub(message,1,7) == ".gtools" then 
		for _,v in pairs(workspace:GetChildren()) do
			if v:IsA("Tool") then
				v.Handle.CFrame = Character.Head.CFrame
			end
		end
	elseif string.sub(message, 1, 3) == ".hop" then 
		local x = {}
		local data;
		local success, response = pcall(function()
			local json = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
			
			return S.HttpService:JSONDecode(json)
		end)
		
		if success ~= true then
			if getfenv().rconsoleprint then
				getfenv().rconsoleprint("\nCould not get serverlist data.")
			end
		else
			data = response["data"]
		end
		
		if data and type(data) == "table" then
			for _, v in ipairs(data) do
				if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
					x[#x + 1] = v.id
				end
			end
			if #x > 0 then
				S.TeleportService:TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
			end
		else
			return error("no data????")
		end
	elseif string.sub(message,1,8) == ".lowhold" then
		if Character:FindFirstChild("Animate").Disabled == true then return end
		Character.Humanoid:UnequipTools()

		Character:FindFirstChild("Animate"):FindFirstChild("toolnone"):FindFirstChild("ToolNoneAnim").AnimationId = "nil"		
		Character.Humanoid:UnequipTools()

		for _,t in pairs(Backpack:GetChildren()) do
			if t:IsA("Tool") and t:FindFirstChild("Handle") and t:FindFirstChild("Handle"):FindFirstChild("Sound") then
				t.GripForward = Vector3.new(-0, -1, 0)
				t.GripPos = Vector3.new(0.02, 0.71, 0)
				t.GripRight = Vector3.new(0, 0, 1)
				t.GripUp = Vector3.new(1, -0, 0)
				t.Handle.Massless = true
				t.Parent = Character
			end
		end	
	end
end)
