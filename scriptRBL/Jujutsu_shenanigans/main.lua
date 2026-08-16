loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript"))()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local switchDelay = 0.12 -- Tang nhe delay de tranh giat lag/tut FPS
local enabled = false
local currentTween = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LyingTeleportGUI"
screenGui.Parent = game.CoreGui

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 120, 0, 50)
toggleButton.Position = UDim2.new(0.5, -60, 0, 20)
toggleButton.Text = "OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextScaled = true

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    toggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local function setLyingDown(char, lie)
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local rootJoint = hrp:FindFirstChild("RootJoint") or (char:FindFirstChild("LowerTorso") and char.LowerTorso:FindFirstChild("Root"))
        if rootJoint then
            if lie then
                rootJoint.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
            else
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.RigType == Enum.HumanoidRigType.R15 then
                    rootJoint.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
                else
                    rootJoint.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(180))
                end
            end
        end
    end
end

-- Tat collision de khong bi ket vao dia hinh / nguoichoikhac gay lag
local function setCharacterCollision(char, canCollide)
    if not char then return end
    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = canCollide
        end
    end
end

local cameraAnchorPart = nil

local function setMobileCameraLock(state)
    local camera = workspace.CurrentCamera
    if not camera then return end

    if state then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if cameraAnchorPart then cameraAnchorPart:Destroy() end
            
            cameraAnchorPart = Instance.new("Part")
            cameraAnchorPart.Size = Vector3.new(1, 1, 1)
            cameraAnchorPart.CFrame = hrp.CFrame
            cameraAnchorPart.Anchored = true
            cameraAnchorPart.CanCollide = false
            cameraAnchorPart.Transparency = 1
            cameraAnchorPart.Parent = workspace

            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = cameraAnchorPart
        end
    else
        if cameraAnchorPart then
            cameraAnchorPart:Destroy()
            cameraAnchorPart = nil
        end
        
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = hum
        end
    end
end

toggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggleButton.Text = enabled and "ON" or "OFF"
    toggleButton.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(0, 100, 200)

    setMobileCameraLock(enabled)

    if not enabled then
        if currentTween then
            currentTween:Cancel()
            currentTween = nil
        end
        if LocalPlayer.Character then
            setLyingDown(LocalPlayer.Character, false)
            setCharacterCollision(LocalPlayer.Character, true)
        end
    end
end)

local function isAliveAndValid(player)
    if not player or player == LocalPlayer then return false end
    local char = player.Character
    if not char then return false end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    
    if hum and hrp and hum.Health > 0 and hum:GetState() ~= Enum.HumanoidStateType.Dead then
        return true, hrp
    end
    return false, nil
end

task.spawn(function()
    while true do
        if enabled then
            local myChar = LocalPlayer.Character
            local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")

            if myHRP and myHum and myHum.Health > 0 and myHum:GetState() ~= Enum.HumanoidStateType.Dead then
                setLyingDown(myChar, true)
                setCharacterCollision(myChar, false)

                local playerList = Players:GetPlayers()
                local hasTargets = false

                for _, player in ipairs(playerList) do
                    if not enabled then break end

                    local valid, targetHRP = isAliveAndValid(player)
                    if valid and targetHRP and targetHRP.Parent then
                        hasTargets = true
                        
                        local targetPos = targetHRP.Position - Vector3.new(0, 4, 0)
                        local targetCFrame = CFrame.lookAt(targetPos, targetHRP.Position)

                        if currentTween then
                            currentTween:Cancel()
                        end

                        local tweenInfo = TweenInfo.new(0.02, Enum.EasingStyle.Linear)
                        currentTween = TweenService:Create(myHRP, tweenInfo, {CFrame = targetCFrame})
                        currentTween:Play()

                        task.wait(switchDelay)
                    end
                end

                if not hasTargets then
                    task.wait(0.2)
                end
            else
                task.wait(0.5)
            end
        else
            if LocalPlayer.Character then
                setLyingDown(LocalPlayer.Character, false)
                setCharacterCollision(LocalPlayer.Character, true)
            end
            task.wait(0.2)
        end
    end
end)
