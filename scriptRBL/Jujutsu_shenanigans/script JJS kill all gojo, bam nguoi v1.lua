--========================================================
-- PLAYER TELEPORT CONTROL - COMPLETE VERSION
-- Press H to hide/show UI
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--========================================================
-- CLEANUP INSTANCE CŨ
--========================================================

if getgenv and getgenv().PlayerTeleportMenuCleanup then
    pcall(getgenv().PlayerTeleportMenuCleanup)
end

local destroyed = false
local connections = {}
local isCleaning = false

local function addConnection(connection)
    if connection then
        table.insert(connections, connection)
    end
    return connection
end

local function disconnectAll()
    for _, connection in ipairs(connections) do
        pcall(function()
            if connection and connection.Disconnect then
                connection:Disconnect()
            end
        end)
    end
    connections = {}
end

--========================================================
-- SETTINGS
--========================================================

local TELEPORT_THRESHOLD = 10
local CHECK_DELAY = 0.3
local RETRY_DELAY = 0.5
local FOLLOW_DISTANCE = 4
local TELE_ALL_DELAY = 0.2
local MAX_TELEPORT_RETRIES = 5
local MAX_TELE_ALL_CYCLES = 50
local HIDE_KEY = Enum.KeyCode.H  -- Phím H để ẩn/hiện UI

--========================================================
-- STATE
--========================================================

local lyingEnabled = false
local teleAllEnabled = false
local autoResetEnabled = false
local uiVisible = true

local selectedPlayer = nil

local followConnection = nil
local teleAllCoroutine = nil

local teleportBusy = false
local retryCount = 0

local originalRootJoint = nil
local originalRootC0 = nil

local cameraAnchor = nil
local cameraLockedForTeleAll = false

--========================================================
-- CHARACTER HELPERS
--========================================================

local function getCharacter()
    return LocalPlayer.Character
end

local function getHumanoid(character)
    if not character then return nil end
    return character:FindFirstChildOfClass("Humanoid")
end

local function getHRP(character)
    if not character then return nil end
    return character:FindFirstChild("HumanoidRootPart")
end

local function getRootJoint(character)
    if not character then return nil end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local joint = hrp:FindFirstChild("RootJoint")
        if joint and joint:IsA("Motor6D") then
            return joint
        end
    end
    
    local lowerTorso = character:FindFirstChild("LowerTorso")
    if lowerTorso then
        local joint = lowerTorso:FindFirstChild("Root")
        if joint and joint:IsA("Motor6D") then
            return joint
        end
    end
    
    return nil
end

--========================================================
-- ROOT JOINT
--========================================================

local function saveRootJoint(character)
    local joint = getRootJoint(character)
    if not joint then return nil end
    
    if originalRootJoint ~= joint then
        originalRootJoint = joint
        originalRootC0 = joint.C0
    end
    
    return joint
end

local function setLying(character, state)
    if not character then return end
    
    local joint = saveRootJoint(character)
    if not joint then return end
    
    if state then
        joint.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
    else
        if joint == originalRootJoint and originalRootC0 then
            joint.C0 = originalRootC0
        end
    end
end

local function restoreRootJoint()
    if originalRootJoint and originalRootC0 then
        pcall(function()
            if originalRootJoint and originalRootJoint.Parent then
                originalRootJoint.C0 = originalRootC0
            end
        end)
    end
    originalRootJoint = nil
    originalRootC0 = nil
end

--========================================================
-- COLLISION
--========================================================

local collisionBackup = {}

local function setCollision(character, enabled)
    if not character then return end
    
    for _, object in ipairs(character:GetDescendants()) do
        if object:IsA("BasePart") then
            if collisionBackup[object] == nil then
                collisionBackup[object] = object.CanCollide
            end
            pcall(function()
                object.CanCollide = enabled
            end)
        end
    end
end

local function restoreCollision()
    for part, oldValue in pairs(collisionBackup) do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = oldValue
            end)
        end
    end
    collisionBackup = {}
end

--========================================================
-- CAMERA
--========================================================

local function restoreCamera()
    local camera = workspace.CurrentCamera
    
    if cameraAnchor then
        pcall(function()
            cameraAnchor:Destroy()
        end)
        cameraAnchor = nil
        cameraLockedForTeleAll = false
    end
    
    if camera then
        local character = getCharacter()
        local humanoid = getHumanoid(character)
        
        pcall(function()
            camera.CameraType = Enum.CameraType.Custom
            if humanoid then
                camera.CameraSubject = humanoid
            end
        end)
    end
end

local function lockCamera()
    local camera = workspace.CurrentCamera
    local character = getCharacter()
    local hrp = getHRP(character)
    
    if not camera or not hrp then return end
    
    if cameraAnchor then
        pcall(function()
            cameraAnchor:Destroy()
        end)
    end
    
    cameraAnchor = Instance.new("Part")
    cameraAnchor.Name = "TeleportCameraAnchor"
    cameraAnchor.Size = Vector3.new(1, 1, 1)
    cameraAnchor.CFrame = hrp.CFrame
    cameraAnchor.Anchored = true
    cameraAnchor.CanCollide = false
    cameraAnchor.Transparency = 1
    cameraAnchor.Parent = workspace
    
    pcall(function()
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = cameraAnchor
    end)
end

--========================================================
-- HIDE/SHOW UI
--========================================================

local function toggleUI()
    uiVisible = not uiVisible
    
    if ScreenGui and ScreenGui.Parent then
        ScreenGui.Enabled = uiVisible
    end
    
    if uiVisible then
        Status.Text = "Status: Ready"
    else
        Status.Text = "[UI Hidden] Press H to show"
    end
end

--========================================================
-- GUI
--========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerTeleportMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 300, 0, 430)
Main.Position = UDim2.new(0.5, -150, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

--========================================================
-- TITLE
--========================================================

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Teleport Control [H to hide]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

--========================================================
-- PLAYER LIST
--========================================================

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = Main
PlayerList.Position = UDim2.new(0.07, 0, 0, 48)
PlayerList.Size = UDim2.new(0.86, 0, 0, 120)
PlayerList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 5
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = PlayerList
ListLayout.Padding = UDim.new(0, 3)

local ListPadding = Instance.new("UIPadding")
ListPadding.Parent = PlayerList
ListPadding.PaddingTop = UDim.new(0, 4)
ListPadding.PaddingLeft = UDim.new(0, 4)
ListPadding.PaddingRight = UDim.new(0, 4)

--========================================================
-- STATUS
--========================================================

local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Position = UDim2.new(0.07, 0, 0, 172)
Status.Size = UDim2.new(0.86, 0, 0, 35)
Status.BackgroundTransparency = 1
Status.Text = "Status: Ready"
Status.TextColor3 = Color3.fromRGB(180, 180, 180)
Status.TextSize = 13
Status.Font = Enum.Font.SourceSans
Status.TextWrapped = true

--========================================================
-- REFRESH
--========================================================

local RefreshButton = Instance.new("TextButton")
RefreshButton.Parent = Main
RefreshButton.Position = UDim2.new(0.07, 0, 0, 210)
RefreshButton.Size = UDim2.new(0.86, 0, 0, 32)
RefreshButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
RefreshButton.Text = "Refresh Player List"
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.TextSize = 14
RefreshButton.Font = Enum.Font.SourceSansBold

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 6)
RefreshCorner.Parent = RefreshButton

--========================================================
-- LYING FOLLOW
--========================================================

local LyingButton = Instance.new("TextButton")
LyingButton.Parent = Main
LyingButton.Position = UDim2.new(0.07, 0, 0, 250)
LyingButton.Size = UDim2.new(0.86, 0, 0, 38)
LyingButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
LyingButton.Text = "Lying Follow: OFF"
LyingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LyingButton.TextSize = 14
LyingButton.Font = Enum.Font.SourceSansBold

local LyingCorner = Instance.new("UICorner")
LyingCorner.CornerRadius = UDim.new(0, 6)
LyingCorner.Parent = LyingButton

--========================================================
-- TELE ALL
--========================================================

local TeleAllButton = Instance.new("TextButton")
TeleAllButton.Parent = Main
TeleAllButton.Position = UDim2.new(0.07, 0, 0, 294)
TeleAllButton.Size = UDim2.new(0.86, 0, 0, 38)
TeleAllButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TeleAllButton.Text = "Teleport All: OFF"
TeleAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleAllButton.TextSize = 14
TeleAllButton.Font = Enum.Font.SourceSansBold

local TeleAllCorner = Instance.new("UICorner")
TeleAllCorner.CornerRadius = UDim.new(0, 6)
TeleAllCorner.Parent = TeleAllButton

--========================================================
-- AUTO RESET
--========================================================

local AutoResetButton = Instance.new("TextButton")
AutoResetButton.Parent = Main
AutoResetButton.Position = UDim2.new(0.07, 0, 0, 338)
AutoResetButton.Size = UDim2.new(0.86, 0, 0, 38)
AutoResetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AutoResetButton.Text = "Auto Reset: OFF"
AutoResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoResetButton.TextSize = 14
AutoResetButton.Font = Enum.Font.SourceSansBold

local AutoResetCorner = Instance.new("UICorner")
AutoResetCorner.CornerRadius = UDim.new(0, 6)
AutoResetCorner.Parent = AutoResetButton

--========================================================
-- DRAG
--========================================================

local dragging = false
local dragStart = nil
local startPosition = nil

addConnection(Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end))

addConnection(UserInputService.InputChanged:Connect(function(input)
    if not dragging or not dragStart or not startPosition then return end
    
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    
    local delta = input.Position - dragStart
    
    Main.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end))

--========================================================
-- PLAYER LIST FUNCTIONS
--========================================================

local function clearPlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            pcall(function() child:Destroy() end)
        end
    end
end

local function refreshPlayerList()
    clearPlayerList()
    
    local players = Players:GetPlayers()
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            local button = Instance.new("TextButton")
            button.Parent = PlayerList
            button.Size = UDim2.new(1, -5, 0, 28)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Text = player.DisplayName .. "  @" .. player.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 12
            button.Font = Enum.Font.SourceSans
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 5)
            corner.Parent = button
            
            addConnection(button.MouseButton1Click:Connect(function()
                selectedPlayer = player
                Status.Text = "Selected: " .. player.DisplayName
                
                for _, other in ipairs(PlayerList:GetChildren()) do
                    if other:IsA("TextButton") then
                        other.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end
                end
                
                button.BackgroundColor3 = Color3.fromRGB(50, 150, 80)
            end))
        end
    end
    
    task.defer(function()
        pcall(function()
            PlayerList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 8)
        end)
    end)
end

addConnection(RefreshButton.MouseButton1Click:Connect(refreshPlayerList))
refreshPlayerList()

--========================================================
-- FOLLOW FUNCTIONS
--========================================================

local function stopFollow()
    lyingEnabled = false
    
    if followConnection then
        pcall(function()
            followConnection:Disconnect()
        end)
        followConnection = nil
    end
end

local function startFollow()
    if followConnection then
        pcall(function()
            followConnection:Disconnect()
        end)
        followConnection = nil
    end
    
    followConnection = RunService.Heartbeat:Connect(function()
        if destroyed or not lyingEnabled then return end
        
        local target = selectedPlayer
        if not target or not target.Parent then return end
        
        local character = getCharacter()
        local targetCharacter = target.Character
        if not character or not targetCharacter then return end
        
        local hrp = getHRP(character)
        local targetHRP = getHRP(targetCharacter)
        
        if hrp and targetHRP then
            pcall(function()
                hrp.CFrame = targetHRP.CFrame * CFrame.new(0, -2.5, FOLLOW_DISTANCE)
            end)
        end
    end)
end

--========================================================
-- RESET FUNCTIONS
--========================================================

local function resetCharacter()
    local character = getCharacter()
    local humanoid = getHumanoid(character)
    
    if not humanoid or humanoid.Health <= 0 then
        return false
    end
    
    restoreCamera()
    restoreCollision()
    restoreRootJoint()
    
    pcall(function()
        humanoid.Health = 0
    end)
    return true
end

local function waitForRespawn(oldCharacter)
    local timeout = 10
    local elapsed = 0
    
    while not destroyed and elapsed < timeout do
        local currentCharacter = LocalPlayer.Character
        
        if currentCharacter and currentCharacter ~= oldCharacter then
            local humanoid = currentCharacter:FindFirstChild("Humanoid")
            local hrp = currentCharacter:FindFirstChild("HumanoidRootPart")
            
            if humanoid and hrp then
                task.wait(0.5)
                return currentCharacter
            end
        end
        
        task.wait(0.1)
        elapsed = elapsed + 0.1
    end
    
    return nil
end

--========================================================
-- CHECK TELEPORT
--========================================================

local function checkTeleport(oldPosition, oldCharacter)
    task.wait(CHECK_DELAY)
    
    if destroyed then return false, "DESTROYED" end
    
    local currentCharacter = getCharacter()
    if not currentCharacter or currentCharacter ~= oldCharacter then
        return false, "RESET"
    end
    
    local hrp = getHRP(currentCharacter)
    if not hrp then
        return false, "NO_HRP"
    end
    
    local distance = (hrp.Position - oldPosition).Magnitude
    
    if distance >= TELEPORT_THRESHOLD then
        return true, distance
    end
    
    return false, distance
end

--========================================================
-- TELEPORT ONE PLAYER
--========================================================

local function teleportToPlayer(target)
    if teleportBusy or destroyed then
        return false
    end
    
    if not target or target == LocalPlayer or not target.Parent then
        return false
    end
    
    local targetCharacter = target.Character
    local targetHRP = getHRP(targetCharacter)
    local targetHumanoid = getHumanoid(targetCharacter)
    
    if not targetHRP or not targetHumanoid or targetHumanoid.Health <= 0 then
        return false
    end
    
    local character = getCharacter()
    local hrp = getHRP(character)
    
    if not character or not hrp then
        return false
    end
    
    teleportBusy = true
    
    local oldPosition = hrp.Position
    local oldCharacter = character
    
    local targetPosition = targetHRP.Position - Vector3.new(0, 4, 0)
    local targetCFrame = CFrame.lookAt(targetPosition, targetHRP.Position)
    
    pcall(function()
        hrp.CFrame = targetCFrame
    end)
    
    task.wait(0.15)
    
    local success, result = checkTeleport(oldPosition, oldCharacter)
    
    teleportBusy = false
    
    if success then
        retryCount = 0
        Status.Text = "TELE SUCCESS ✓ " .. math.floor(result) .. " studs"
        return true
    end
    
    if result == "RESET" or result == "NO_HRP" or result == "DESTROYED" then
        return false
    end
    
    Status.Text = "Fake Tele • " .. math.floor(result) .. " studs"
    
    if not autoResetEnabled then
        return false
    end
    
    local retryAttempts = 0
    
    while autoResetEnabled and not destroyed and not success and retryAttempts < MAX_TELEPORT_RETRIES do
        retryAttempts = retryAttempts + 1
        retryCount = retryCount + 1
        
        Status.Text = "Fake Tele → Reset #" .. retryCount
        
        local resetCharacterObject = getCharacter()
        if not resetCharacterObject then
            task.wait(0.5)
        end
        
        if not resetCharacter() then
            task.wait(0.5)
        end
        
        Status.Text = "Resetting..."
        
        local newCharacter = waitForRespawn(resetCharacterObject)
        
        if destroyed then
            return false
        end
        
        if not newCharacter then
            task.wait(0.5)
        end
        
        Status.Text = "Retrying teleport..."
        task.wait(RETRY_DELAY)
        
        if not autoResetEnabled or destroyed then
            return false
        end
        
        local newHRP = getHRP(newCharacter)
        if not newHRP then
            task.wait(0.5)
        end
        
        local targetChar = target.Character
        local targetHRP2 = getHRP(targetChar)
        local targetHumanoid2 = getHumanoid(targetChar)
        
        if not targetHRP2 or not targetHumanoid2 or targetHumanoid2.Health <= 0 then
            return false
        end
        
        local beforeRetry = newHRP.Position
        local retryCFrame = CFrame.lookAt(targetHRP2.Position - Vector3.new(0, 4, 0), targetHRP2.Position)
        
        pcall(function()
            newHRP.CFrame = retryCFrame
        end)
        
        task.wait(0.15)
        
        local afterRetry = newHRP.Position
        local retryDistance = (afterRetry - beforeRetry).Magnitude
        
        if retryDistance >= TELEPORT_THRESHOLD then
            Status.Text = "TELE SUCCESS ✓ " .. math.floor(retryDistance) .. " studs"
            retryCount = 0
            return true
        end
        
        Status.Text = "Fake Tele again → retry " .. retryAttempts .. "/" .. MAX_TELEPORT_RETRIES
        success = false
        
        task.wait(RETRY_DELAY)
    end
    
    return false
end

--========================================================
-- LYING BUTTON
--========================================================

addConnection(LyingButton.MouseButton1Click:Connect(function()
    if lyingEnabled then
        stopFollow()
        
        local character = getCharacter()
        if character then
            setLying(character, false)
            setCollision(character, true)
        end
        
        restoreCamera()
        
        LyingButton.Text = "Lying Follow: OFF"
        LyingButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Status.Text = "Lying stopped"
        
        return
    end
    
    if not selectedPlayer then
        Status.Text = "Please select a player first!"
        return
    end
    
    if not selectedPlayer.Parent then
        Status.Text = "Player is no longer in server"
        return
    end
    
    lyingEnabled = true
    
    local character = getCharacter()
    if character then
        setLying(character, true)
        setCollision(character, false)
        -- KHÔNG khóa camera cho Lying Follow
    end
    
    LyingButton.Text = "Lying Follow: ON"
    LyingButton.BackgroundColor3 = Color3.fromRGB(50, 180, 70)
    Status.Text = "Following: " .. selectedPlayer.DisplayName
    
    startFollow()
end))

--========================================================
-- TELEPORT ALL
--========================================================

local function stopTeleAll()
    teleAllEnabled = false
    retryCount = 0
    
    -- Chỉ restore camera nếu Tele All đang khóa camera
    if cameraLockedForTeleAll then
        restoreCamera()
    end
    
    if teleAllCoroutine then
        teleAllCoroutine = nil
    end
end

local function runTeleportAll()
    local cycles = 0
    
    -- Khóa camera khi bắt đầu Tele All
    lockCamera()
    cameraLockedForTeleAll = true
    
    while teleAllEnabled and not destroyed and cycles < MAX_TELE_ALL_CYCLES do
        cycles = cycles + 1
        
        local players = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Parent then
                local character = player.Character
                local humanoid = getHumanoid(character)
                local hrp = getHRP(character)
                
                if humanoid and hrp and humanoid.Health > 0 then
                    table.insert(players, player)
                end
            end
        end
        
        if #players == 0 then
            Status.Text = "No valid players found"
            break
        end
        
        for _, player in ipairs(players) do
            if not teleAllEnabled or destroyed then
                break
            end
            
            if player.Parent then
                teleportToPlayer(player)
                task.wait(TELE_ALL_DELAY)
            end
        end
        
        if teleAllEnabled and not destroyed then
            task.wait(0.5)
        end
    end
    
    -- Mở khóa camera khi kết thúc Tele All
    if cameraLockedForTeleAll then
        restoreCamera()
        cameraLockedForTeleAll = false
    end
    
    if not destroyed then
        teleAllEnabled = false
        TeleAllButton.Text = "Teleport All: OFF"
        TeleAllButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Status.Text = "Teleport All completed"
    end
end

addConnection(TeleAllButton.MouseButton1Click:Connect(function()
    if teleAllEnabled then
        stopTeleAll()
        TeleAllButton.Text = "Teleport All: OFF"
        TeleAllButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Status.Text = "Teleport All stopped"
        return
    end
    
    teleAllEnabled = true
    retryCount = 0
    
    TeleAllButton.Text = "Teleport All: ON"
    TeleAllButton.BackgroundColor3 = Color3.fromRGB(50, 180, 70)
    Status.Text = "Teleporting all..."
    
    teleAllCoroutine = coroutine.wrap(runTeleportAll)
    teleAllCoroutine()
end))

--========================================================
-- AUTO RESET BUTTON
--========================================================

addConnection(AutoResetButton.MouseButton1Click:Connect(function()
    autoResetEnabled = not autoResetEnabled
    
    if autoResetEnabled then
        AutoResetButton.Text = "Auto Reset: ON"
        AutoResetButton.BackgroundColor3 = Color3.fromRGB(50, 180, 70)
        retryCount = 0
        Status.Text = "Auto Reset enabled"
    else
        AutoResetButton.Text = "Auto Reset: OFF"
        AutoResetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        retryCount = 0
        Status.Text = "Auto Reset disabled"
    end
end))

--========================================================
-- KEYBIND HIDE/SHOW UI
--========================================================

addConnection(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == HIDE_KEY then
        toggleUI()
    end
end))

-- Click vào Status để ẩn/hiện UI
addConnection(Status.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        task.wait(0.15)
        if input.UserInputState == Enum.UserInputState.End then
            toggleUI()
        end
    end
end))

--========================================================
-- CHARACTER ADDED
--========================================================

addConnection(LocalPlayer.CharacterAdded:Connect(function(character)
    originalRootJoint = nil
    originalRootC0 = nil
    collisionBackup = {}
    
    task.wait(0.5)
    
    if destroyed then return end
    
    if lyingEnabled then
        setLying(character, true)
        setCollision(character, false)
        -- KHÔNG khóa camera cho Lying Follow khi respawn
        
        if selectedPlayer then
            startFollow()
        end
    else
        -- Chỉ restore camera nếu không phải đang Tele All
        if not cameraLockedForTeleAll then
            restoreCamera()
        end
    end
end))

--========================================================
-- PLAYER JOIN / LEAVE
--========================================================

addConnection(Players.PlayerAdded:Connect(function()
    task.wait(0.2)
    if not destroyed then
        refreshPlayerList()
    end
end))

addConnection(Players.PlayerRemoving:Connect(function(player)
    if player == selectedPlayer then
        selectedPlayer = nil
        
        if lyingEnabled then
            stopFollow()
            local character = getCharacter()
            if character then
                setLying(character, false)
                setCollision(character, true)
            end
            restoreCamera()
        end
        
        Status.Text = "Target has left the server"
    end
    
    refreshPlayerList()
end))

--========================================================
-- GLOBAL CLEANUP
--========================================================

if getgenv then
    getgenv().PlayerTeleportMenuCleanup = function()
        if destroyed or isCleaning then return end
        isCleaning = true
        destroyed = true
        
        lyingEnabled = false
        teleAllEnabled = false
        autoResetEnabled = false
        
        if followConnection then
            pcall(function() followConnection:Disconnect() end)
            followConnection = nil
        end
        
        teleAllCoroutine = nil
        
        restoreRootJoint()
        restoreCollision()
        restoreCamera()
        
        disconnectAll()
        
        if ScreenGui then
            pcall(function() ScreenGui:Destroy() end)
        end
        
        isCleaning = false
    end
end

--========================================================
-- READY
--========================================================

Status.Text = "Status: Ready"
print("Teleport Control loaded successfully!")
print("Press H to hide/show UI")
