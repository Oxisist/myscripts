game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "PooHub",
            Text = "Prefix is ., Check console for commands"
        }
    )
local plr = game:GetService("Players").LocalPlayer
local charr = game:GetService("Players").LocalPlayer.Character
local players = game:GetService("Players"):GetPlayers()
local gameid = game.PlaceId

print("\nYour script executed, Commands are rj bp gtools id tpa re off mute lowhold :)")

plr.Chatted:connect(function(message)
    if message:sub(1,3) == ".id" then
        id = message:sub(5)
        local args = message:split(" ")
        
        for _,v in pairs(plr.Backpack:GetChildren()) do
            if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v.Parent = plr.Character end
        end
        
        wait(.1)
        
        local id = args[2]
        
        local zeros = 199950
        for _,v in pairs(plr.Character:GetChildren()) do
            if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", ("0"):rep(zeros)..id, 1, 0, 0) end
        end 
    end
    
    if message:sub(1,3) == ".bp" then
        
    id = message:sub(5)
    
            for _,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v.Parent = plr.Character end
    end
    
    for _,v in pairs(plr.Character:GetChildren()) do
        local zeros = 199950
        if v:IsA("Tool") and string.lower(v.Name) == "boombox" then v:FindFirstChildOfClass("RemoteEvent"):FireServer("PlaySong", ("0"):rep(zeros)..id, 1, 0, 0) end
    end
    
    wait(.6)
    
    for _,v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Tool") and string.lower(v.Name) == "boombox" then plr.Character.Humanoid:UnequipTools() end
    end
    
    wait(.6)
    
    for _,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
            v.Handle.Sound.TimePosition = 0
            v.Handle.Sound.Playing = true
        end
    end
    
    end
    if message:sub(1,3) == ".rj" then
        game:GetService("TeleportService"):Teleport(gameid, plr);
    end
    
    if message:sub(1,3) == ".tp" then 
        
        local args = message:split(" ")
        
         for _,v in pairs(plr.Character:GetChildren()) do
            if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
                v.Handle.Sound.TimePosition = args[2]
            end
         end
         
        for _,v in pairs(plr.Backpack:GetChildren()) do
            if v:IsA("Tool") and string.lower(v.Name) == "boombox" then
                v.Handle.Sound.TimePosition = args[2]
            end
        end
         
    end
    if message:sub(1,4) == ".tpa" then
        
    local args = message:split(" ")
    
    for _,v in pairs(game.Players:GetPlayers()) do
    
        if v.Name ~= plr.Name then
            for _,v2 in pairs(game.Workspace[v.Name]:GetChildren()) do
                if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then 
                    v2.Handle.Sound.TimePosition = args[2] end
                end
                for _,v2 in pairs(v.Backpack:GetChildren()) do
                if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then 
                    v2.Handle.Sound.TimePosition = args[2] end
                end
            end
        end
    end
    
    if message:sub(1,3) == ".re" then
        charr:BreakJoints()
    end

    if message:sub(1,4) == ".off" then
        for _,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                -- Character
                for _,v2 in pairs(game.Workspace[v.Name]:GetChildren()) do
                    if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.Playing = false; end
                end
                
                -- Backpack
                for _,v2 in pairs(v.Backpack:GetChildren()) do
                    if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.Playing = false; end
                end
            end
        end
    end
    
    if message:sub(1,5) == ".mute" then
        while wait(.03) do
            for _,v in pairs(game.Players:GetPlayers()) do
                if v.Name ~= plr.Name then
                -- Character
                for _,v2 in pairs(game.Workspace[v.Name]:GetChildren()) do
                    if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.TimePosition = 0 end
                end
                
                -- Backpack
                for _,v2 in pairs(v.Backpack:GetChildren()) do
                    if v2:IsA("Tool") and string.lower(v2.Name) == "boombox" then v2.Handle.Sound.TimePosition = 0 end
                end
                end
            end
        end
    end
    
    if message:sub(1,7) == ".gtools" then 
        for _,v in pairs(game.workspace:GetChildren()) do
            if v:IsA("Tool") then
                v.Handle.CFrame = plr.Character.Head.CFrame
            end
        end
    end
    
    if message:sub(1,8) == ".lowhold" then
    	if plr.Character:FindFirstChild("Animate").Disabled == true then return end
    	plr.Character.Humanoid:UnequipTools()
    	
    	plr.Character:FindFirstChild("Animate"):FindFirstChild("toolnone"):FindFirstChild("ToolNoneAnim").AnimationId = "nil"		
    	plr.Character.Humanoid:UnequipTools()
    	
    	for _,t in pairs(plr.Backpack:GetChildren()) do
    		if t:IsA("Tool") and t:FindFirstChild("Handle") and t:FindFirstChild("Handle"):FindFirstChild("Sound") then
    			t.GripForward = Vector3.new(-0, -1, 0)
    			t.GripPos = Vector3.new(0.02, 0.71, 0)
    			t.GripRight = Vector3.new(0, 0, 1)
    			t.GripUp = Vector3.new(1, -0, 0)
    			t.Handle.Massless = true
    			t.Parent = plr.Character
    		end
    	end	
    end
end)
-- rj bp gtools id tpa re off mute lowhold
