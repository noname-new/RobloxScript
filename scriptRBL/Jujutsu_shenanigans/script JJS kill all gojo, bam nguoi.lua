-- ============================================================
-- PLAYER TELEPORT CONTROL
-- Sweep All + Auto Loop Until Bypass
-- H = Hide / Show UI
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- CLEANUP INSTANCE CŨ
-- ============================================================

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

-- ============================================================
-- CONFIG
-- ============================================================

local TELEPORT_THRESHOLD = 10
local BYPASS_CHECK_TIME = 3
local BYPASS_CHECK_DELAY = 0.1

local FOLLOW_DISTANCE = 4

local SWEEP_DISTANCE = 500
local SWEEP_OFFSET = 2.5
local SWEEP_TIME = 0.01

local RESET_DELAY = 0.5

local HIDE_KEY = Enum.KeyCode.H

-- ============================================================
-- STATE
-- ============================================================

local lyingEnabled = false

local sweepAllEnabled = false
local autoLoopEnabled = false

local uiVisible = true

local selectedPlayer = nil

local followConnection = nil

local sweepRunning = false
local bypassRunning = false

local resetCount = 0

local originalRootJoint = nil
local originalRootC0 = nil

local collisionBackup = {}

-- ============================================================
-- CHARACTER
-- ============================================================

local function getCharacter()
    return LocalPlayer.Character
end

local function getHumanoid(character)
    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

local function getHRP(character)
    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
end

-- ============================================================
-- ROOT JOINT
-- ============================================================

local function getRootJoint(character)
    if not character then
        return nil
    end

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

local function saveRootJoint(character)
    local joint = getRootJoint(character)

    if not joint then
        return nil
    end

    if originalRootJoint ~= joint then
        originalRootJoint = joint
        originalRootC0 = joint.C0
    end

    return joint
end

local function setLying(character, state)
    if not character then
        return
    end

    local joint = saveRootJoint(character)

    if not joint then
        return
    end

    if state then
        joint.C0 =
            CFrame.new(0, 0, 0)
            * CFrame.Angles(
                math.rad(-90),
                0,
                math.rad(180)
            )
    else
        if joint == originalRootJoint and originalRootC0 then
            joint.C0 = originalRootC0
        end
    end
end

local function restoreRootJoint()
    if originalRootJoint and originalRootC0 then
        pcall(function()
            if originalRootJoint.Parent then
                originalRootJoint.C0 = originalRootC0
            end
        end)
    end

    originalRootJoint = nil
    originalRootC0 = nil
end

-- ============================================================
-- COLLISION
-- ============================================================

local function setCollision(character, enabled)
    if not character then
        return
    end

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

-- ============================================================
-- CAMERA
-- ============================================================

local function restoreCamera()
    local camera = Workspace.CurrentCamera

    if not camera then
        return
    end

    local character = getCharacter()
    local humanoid = getHumanoid(character)

    pcall(function()
        camera.CameraType = Enum.CameraType.Custom

        if humanoid then
            camera.CameraSubject = humanoid
        end
    end)
end

-- ============================================================
-- GUI
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PlayerTeleportMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
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

-- ============================================================
-- TITLE
-- ============================================================

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Teleport Control [H]"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- ============================================================
-- PLAYER LIST
-- ============================================================

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

-- ============================================================
-- STATUS
-- ============================================================

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

-- ============================================================
-- REFRESH
-- ============================================================

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

-- ============================================================
-- LYING FOLLOW
-- ============================================================

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

-- ============================================================
-- SWEEP ALL
-- ============================================================

local SweepButton = Instance.new("TextButton")
SweepButton.Parent = Main
SweepButton.Position = UDim2.new(0.07, 0, 0, 294)
SweepButton.Size = UDim2.new(0.86, 0, 0, 38)
SweepButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SweepButton.Text = "Sweep All: OFF"
SweepButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SweepButton.TextSize = 14
SweepButton.Font = Enum.Font.SourceSansBold

local SweepCorner = Instance.new("UICorner")
SweepCorner.CornerRadius = UDim.new(0, 6)
SweepCorner.Parent = SweepButton

-- ============================================================
-- AUTO LOOP UNTIL BYPASS
-- ============================================================

local AutoButton = Instance.new("TextButton")
AutoButton.Parent = Main
AutoButton.Position = UDim2.new(0.07, 0, 0, 338)
AutoButton.Size = UDim2.new(0.86, 0, 0, 38)
AutoButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AutoButton.Text = "Auto Loop Until Bypass: OFF"
AutoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoButton.TextSize = 14
AutoButton.Font = Enum.Font.SourceSansBold

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 6)
AutoCorner.Parent = AutoButton

-- ============================================================
-- SWEEP TIME
-- ============================================================

local TimeBox = Instance.new("TextBox")
TimeBox.Parent = Main
TimeBox.Position = UDim2.new(0.07, 0, 0, 382)
TimeBox.Size = UDim2.new(0.86, 0, 0, 32)
TimeBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TimeBox.Text = tostring(SWEEP_TIME)
TimeBox.PlaceholderText = "Sweep Time"
TimeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TimeBox.TextSize = 13
TimeBox.Font = Enum.Font.SourceSans
TimeBox.ClearTextOnFocus = false

local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0, 6)
TimeCorner.Parent = TimeBox

-- ============================================================
-- DRAG
-- ============================================================

local dragging = false
local dragStart = nil
local startPosition = nil

addConnection(Main.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

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

    if not dragging then
        return
    end

    if not dragStart or not startPosition then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
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

-- ============================================================
-- PLAYER LIST
-- ============================================================

local function clearPlayerList()

    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            pcall(function()
                child:Destroy()
            end)
        end
    end
end

local function refreshPlayerList()

    clearPlayerList()

    for _, player in ipairs(Players:GetPlayers()) do

        if player ~= LocalPlayer then

            local button = Instance.new("TextButton")
            button.Parent = PlayerList
            button.Size = UDim2.new(1, -5, 0, 28)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

            button.Text =
                player.DisplayName ..
                "  @" ..
                player.Name

            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.TextSize = 12
            button.Font = Enum.Font.SourceSans

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 5)
            corner.Parent = button

            addConnection(button.MouseButton1Click:Connect(function()

                selectedPlayer = player

                Status.Text =
                    "Selected: " ..
                    player.DisplayName

                for _, other in ipairs(PlayerList:GetChildren()) do
                    if other:IsA("TextButton") then
                        other.BackgroundColor3 =
                            Color3.fromRGB(60, 60, 60)
                    end
                end

                button.BackgroundColor3 =
                    Color3.fromRGB(50, 150, 80)

            end))
        end
    end

    task.defer(function()

        pcall(function()
            PlayerList.CanvasSize =
                UDim2.new(
                    0,
                    0,
                    0,
                    ListLayout.AbsoluteContentSize.Y + 8
                )
        end)

    end)
end

addConnection(
    RefreshButton.MouseButton1Click:Connect(refreshPlayerList)
)

refreshPlayerList()

-- ============================================================
-- FOLLOW
-- ============================================================

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

    followConnection =
        RunService.Heartbeat:Connect(function()

            if destroyed or not lyingEnabled then
                return
            end

            local target = selectedPlayer

            if not target or not target.Parent then
                return
            end

            local character = getCharacter()
            local targetCharacter = target.Character

            if not character or not targetCharacter then
                return
            end

            local hrp = getHRP(character)
            local targetHRP = getHRP(targetCharacter)

            if hrp and targetHRP then

                pcall(function()
                    hrp.CFrame =
                        targetHRP.CFrame *
                        CFrame.new(
                            0,
                            0,
                            FOLLOW_DISTANCE
                        )
                end)
            end
        end)
end

-- ============================================================
-- FIND RESET REMOTE
-- ============================================================

local function getResetRemote()

    local knit = ReplicatedStorage:FindFirstChild("Knit")

    if not knit then
        return nil
    end

    local knit2 = knit:FindFirstChild("Knit")

    if not knit2 then
        return nil
    end

    local services = knit2:FindFirstChild("Services")

    if not services then
        return nil
    end

    local joinService =
        services:FindFirstChild("JoinService")

    if not joinService then
        return nil
    end

    local re = joinService:FindFirstChild("RE")

    if not re then
        return nil
    end

    return re:FindFirstChild("Reset")
end

-- ============================================================
-- GET SWEEP TARGETS
-- PLAYER + DUMMY
-- ============================================================

local function getSweepTargets()

    local targets = {}

    local character = getCharacter()
    local myHRP = getHRP(character)

    if not myHRP then
        return targets
    end

    -- PLAYER

    for _, player in ipairs(Players:GetPlayers()) do

        if player ~= LocalPlayer
            and player.Character then

            local humanoid =
                getHumanoid(player.Character)

            local hrp =
                getHRP(player.Character)

            if humanoid
                and humanoid.Health > 0
                and hrp then

                if
                    (hrp.Position - myHRP.Position).Magnitude
                    <= SWEEP_DISTANCE
                then

                    table.insert(targets, hrp)
                end
            end
        end
    end

    -- DUMMY

    for _, obj in ipairs(Workspace:GetDescendants()) do

        if obj:IsA("Model")
            and string.lower(obj.Name) == "dummy" then

            local humanoid =
                obj:FindFirstChildOfClass("Humanoid")

            local hrp =
                obj:FindFirstChild("HumanoidRootPart")
                or obj:FindFirstChild("Torso")

            if humanoid
                and humanoid.Health > 0
                and hrp then

                if
                    (hrp.Position - myHRP.Position).Magnitude
                    <= SWEEP_DISTANCE
                then

                    table.insert(targets, hrp)
                end
            end
        end
    end

    return targets
end

-- ============================================================
-- TELEPORT SAU LƯNG
-- ============================================================

local function teleportBehind(targetHRP)

    if not targetHRP or not targetHRP.Parent then
        return false
    end

    local character = getCharacter()
    local myHRP = getHRP(character)
    local humanoid = getHumanoid(character)

    if not myHRP
        or not humanoid
        or humanoid.Health <= 0 then

        return false
    end

    pcall(function()

        myHRP.CFrame =
            targetHRP.CFrame *
            CFrame.new(
                0,
                0,
                SWEEP_OFFSET
            )

    end)

    return true
end

-- ============================================================
-- CHECK BỊ KÉO VỀ
-- ============================================================

local function checkTeleportedBack(
    startPosition,
    oldCharacter
)

    local timer = 0

    while timer < BYPASS_CHECK_TIME do

        if destroyed then
            return false, "DESTROYED"
        end

        if not autoLoopEnabled then
            return false, "STOPPED"
        end

        task.wait(BYPASS_CHECK_DELAY)

        timer =
            timer +
            BYPASS_CHECK_DELAY

        local character =
            getCharacter()

        local humanoid =
            getHumanoid(character)

        local hrp =
            getHRP(character)

        if not character
            or character ~= oldCharacter then

            return true, "RESET"
        end

        if not humanoid
            or humanoid.Health <= 0 then

            return false, "DEAD"
        end

        if not hrp then
            return false, "NO_HRP"
        end

        local distance =
            (hrp.Position - startPosition).Magnitude

        -- Bị kéo về gần vị trí cũ
        if distance < TELEPORT_THRESHOLD then
            return true, "TELEPORTED_BACK"
        end
    end

    -- Hết 3 giây mà vẫn ở xa
    return false, "BYPASS_SUCCESS"
end

-- ============================================================
-- AUTO BYPASS - MỘT LẦN THỬ
-- ============================================================

local function tryBypass(targetHRP)

    local character = getCharacter()
    local hrp = getHRP(character)
    local humanoid = getHumanoid(character)

    if not character
        or not hrp
        or not humanoid
        or humanoid.Health <= 0 then

        return false, "INVALID_CHARACTER"
    end

    local startPosition = hrp.Position
    local oldCharacter = character

    -- TP SAU LƯNG
    if not teleportBehind(targetHRP) then
        return false, "TELEPORT_FAILED"
    end

    Status.Text = "Checking bypass..."

    local failed, reason =
        checkTeleportedBack(
            startPosition,
            oldCharacter
        )

    if reason == "BYPASS_SUCCESS" then

        return true, "BYPASS_SUCCESS"
    end

    if reason == "TELEPORTED_BACK" then

        Status.Text =
            "Teleport blocked - resetting..."

        -- Reset chỉ 1 lần rồi quay lại thử tiếp
        local resetRemote =
            getResetRemote()

        if resetRemote then

            pcall(function()
                resetRemote:FireServer()
                resetCount =
                    resetCount + 1
            end)

            task.wait(RESET_DELAY)
        end

        return false, "TELEPORTED_BACK"
    end

    return false, reason
end

-- ============================================================
-- AUTO LOOP UNTIL BYPASS
-- ============================================================

local function startAutoLoop()

    if bypassRunning then
        return
    end

    bypassRunning = true

    task.spawn(function()

        while not destroyed
            and autoLoopEnabled do

            local character = getCharacter()
            local humanoid = getHumanoid(character)
            local hrp = getHRP(character)

            if not character
                or not humanoid
                or humanoid.Health <= 0
                or not hrp then

                task.wait(0.5)
                continue
            end

            -- Lấy target mới mỗi vòng
            local targets =
                getSweepTargets()

            if #targets == 0 then

                Status.Text =
                    "No target within " ..
                    SWEEP_DISTANCE

                task.wait(0.5)
                continue
            end

            -- Thử từng target
            for _, targetHRP in ipairs(targets) do

                if destroyed
                    or not autoLoopEnabled then
                    break
                end

                if targetHRP
                    and targetHRP.Parent then

                    local success, reason =
                        tryBypass(targetHRP)

                    if success
                        and reason == "BYPASS_SUCCESS" then

                        autoLoopEnabled = false
                        sweepAllEnabled = false

                        AutoButton.Text =
                            "Auto Loop Until Bypass: OFF"

                        AutoButton.BackgroundColor3 =
                            Color3.fromRGB(
                                70,
                                70,
                                70
                            )

                        SweepButton.Text =
                            "Sweep All: OFF"

                        SweepButton.BackgroundColor3 =
                            Color3.fromRGB(
                                70,
                                70,
                                70
                            )

                        Status.Text =
                            "BYPASS SUCCESS!"

                        break
                    end

                    task.wait(SWEEP_TIME)
                end
            end

            if autoLoopEnabled then
                task.wait(0.05)
            end
        end

        bypassRunning = false
    end)
end

-- ============================================================
-- SWEEP ALL - ĐÚNG LOGIC CODE GỐC
-- ============================================================

local function runSweepOnce()

    if sweepRunning then
        return
    end

    sweepRunning = true

    task.spawn(function()

        local character = getCharacter()
        local myHRP = getHRP(character)
        local humanoid = getHumanoid(character)

        if myHRP
            and humanoid
            and humanoid.Health > 0 then

            local targets =
                getSweepTargets()

            if #targets == 0 then

                Status.Text =
                    "No targets within " ..
                    SWEEP_DISTANCE

            else

                local count = 0

                for _, targetHRP in ipairs(targets) do

                    if not sweepAllEnabled
                        or destroyed then
                        break
                    end

                    if targetHRP
                        and targetHRP.Parent then

                        teleportBehind(targetHRP)

                        count = count + 1

                        Status.Text =
                            "Sweep: " ..
                            count ..
                            "/" ..
                            #targets

                        task.wait(SWEEP_TIME)
                    end
                end

                Status.Text =
                    "Sweep completed: " ..
                    count ..
                    " targets"
            end
        end

        sweepRunning = false
    end)
end

-- ============================================================
-- SWEEP BUTTON
-- ============================================================

addConnection(
    SweepButton.MouseButton1Click:Connect(function()

        sweepAllEnabled =
            not sweepAllEnabled

        if sweepAllEnabled then

            SweepButton.Text =
                "Sweep All: ON"

            SweepButton.BackgroundColor3 =
                Color3.fromRGB(
                    50,
                    180,
                    70
                )

            Status.Text =
                "Sweep All started"

            -- Nếu Auto đang ON thì Auto Loop tự quản lý
            if not autoLoopEnabled then
                runSweepOnce()
            end

        else

            SweepButton.Text =
                "Sweep All: OFF"

            SweepButton.BackgroundColor3 =
                Color3.fromRGB(
                    70,
                    70,
                    70
                )

            Status.Text =
                "Sweep All stopped"
        end
    end)
)

-- ============================================================
-- AUTO LOOP BUTTON
-- ============================================================

addConnection(
    AutoButton.MouseButton1Click:Connect(function()

        autoLoopEnabled =
            not autoLoopEnabled

        if autoLoopEnabled then

            sweepAllEnabled = true

            AutoButton.Text =
                "Auto Loop Until Bypass: ON"

            AutoButton.BackgroundColor3 =
                Color3.fromRGB(
                    50,
                    180,
                    70
                )

            SweepButton.Text =
                "Sweep All: ON"

            SweepButton.BackgroundColor3 =
                Color3.fromRGB(
                    50,
                    180,
                    70
                )

            resetCount = 0

            Status.Text =
                "Auto Bypass started"

            startAutoLoop()

        else

            autoLoopEnabled = false
            sweepAllEnabled = false

            AutoButton.Text =
                "Auto Loop Until Bypass: OFF"

            AutoButton.BackgroundColor3 =
                Color3.fromRGB(
                    70,
                    70,
                    70
                )

            SweepButton.Text =
                "Sweep All: OFF"

            SweepButton.BackgroundColor3 =
                Color3.fromRGB(
                    70,
                    70,
                    70
                )

            Status.Text =
                "Auto Bypass stopped"
        end
    end)
)

-- ============================================================
-- SWEEP TIME
-- ============================================================

addConnection(
    TimeBox.FocusLost:Connect(function()

        local value =
            tonumber(TimeBox.Text)

        if value and value >= 0 then

            SWEEP_TIME = value

            TimeBox.Text =
                tostring(SWEEP_TIME)

            Status.Text =
                "Sweep Time: " ..
                tostring(SWEEP_TIME)

        else

            TimeBox.Text =
                tostring(SWEEP_TIME)
        end
    end)
)

-- ============================================================
-- LYING FOLLOW
-- ============================================================

addConnection(
    LyingButton.MouseButton1Click:Connect(function()

        if lyingEnabled then

            stopFollow()

            local character =
                getCharacter()

            if character then

                setLying(
                    character,
                    false
                )

                setCollision(
                    character,
                    true
                )
            end

            restoreCamera()

            LyingButton.Text =
                "Lying Follow: OFF"

            LyingButton.BackgroundColor3 =
                Color3.fromRGB(
                    70,
                    70,
                    70
                )

            Status.Text =
                "Lying stopped"

            return
        end

        if not selectedPlayer then

            Status.Text =
                "Please select a player first!"

            return
        end

        if not selectedPlayer.Parent then

            Status.Text =
                "Player is no longer in server"

            return
        end

        lyingEnabled = true

        local character =
            getCharacter()

        if character then

            setLying(
                character,
                true
            )

            setCollision(
                character,
                false
            )
        end

        LyingButton.Text =
            "Lying Follow: ON"

        LyingButton.BackgroundColor3 =
            Color3.fromRGB(
                50,
                180,
                70
            )

        Status.Text =
            "Following: " ..
            selectedPlayer.DisplayName

        startFollow()
    end)
)

-- ============================================================
-- H = HIDE / SHOW UI
-- ============================================================

addConnection(
    UserInputService.InputBegan:Connect(
        function(input, gameProcessed)

            -- Không dùng gameProcessed để H luôn hoạt động
            if input.KeyCode == HIDE_KEY then

                uiVisible =
                    not uiVisible

                ScreenGui.Enabled =
                    uiVisible
            end
        end
    )
)

-- ============================================================
-- CHARACTER ADDED
-- ============================================================

addConnection(
    LocalPlayer.CharacterAdded:Connect(function(character)

        originalRootJoint = nil
        originalRootC0 = nil
        collisionBackup = {}

        task.wait(0.5)

        if destroyed then
            return
        end

        if lyingEnabled then

            setLying(
                character,
                true
            )

            setCollision(
                character,
                false
            )

            if selectedPlayer then
                startFollow()
            end
        end
    end)
)

-- ============================================================
-- PLAYER JOIN
-- ============================================================

addConnection(
    Players.PlayerAdded:Connect(function()

        task.wait(0.2)

        if not destroyed then
            refreshPlayerList()
        end
    end)
)

-- ============================================================
-- PLAYER LEAVE
-- ============================================================

addConnection(
    Players.PlayerRemoving:Connect(function(player)

        if player == selectedPlayer then

            selectedPlayer = nil

            if lyingEnabled then

                stopFollow()

                local character =
                    getCharacter()

                if character then

                    setLying(
                        character,
                        false
                    )

                    setCollision(
                        character,
                        true
                    )
                end

                restoreCamera()
            end

            Status.Text =
                "Target has left the server"
        end

        refreshPlayerList()
    end)
)

-- ============================================================
-- CLEANUP
-- ============================================================

if getgenv then

    getgenv().PlayerTeleportMenuCleanup =
        function()

            if destroyed or isCleaning then
                return
            end

            isCleaning = true
            destroyed = true

            lyingEnabled = false
            sweepAllEnabled = false
            autoLoopEnabled = false

            if followConnection then

                pcall(function()
                    followConnection:Disconnect()
                end)

                followConnection = nil
            end

            bypassRunning = false
            sweepRunning = false

            restoreRootJoint()
            restoreCollision()
            restoreCamera()

            disconnectAll()

            if ScreenGui then

                pcall(function()
                    ScreenGui:Destroy()
                end)

            end

            isCleaning = false
        end
end

-- ============================================================
-- READY
-- ============================================================

Status.Text = "Status: Ready"

print("======================================")
print("Player Teleport Control loaded")
print("H = Hide / Show UI")
print("Sweep All = TP behind every target")
print("Auto Loop = retry until teleport stays")
print("======================================")
