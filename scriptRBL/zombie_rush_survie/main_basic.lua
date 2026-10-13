--==================================================
-- NONAME HUB - BASIC
--==================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NonameHubBasic"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 300)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -10, 0, 32)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Text = "⚡ NONAME HUB ⚡  [H]"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Active = true
Title.Parent = MainFrame

-- Kéo thả
local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging, dragStart, startPos = true, input.Position, MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local d = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- H = ẩn/hiện UI
local uiVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        uiVisible = not uiVisible
        MainFrame.Visible = uiVisible
    end
end)

-- Hàm set ammo
local function updateAllAmmo()
    local char = player.Character or player.CharacterAdded:Wait()
    local function apply(tool)
        if not tool or not tool:IsA("Tool") then return end
        local info = tool:FindFirstChild("Info")
        local clip = info and info:FindFirstChild("Clip")
        if clip and (clip:IsA("IntValue") or clip:IsA("NumberValue")) then
            clip.Value = 999999999
        end
    end
    local bp = player:FindFirstChildOfClass("Backpack")
    if bp then for _, t in ipairs(bp:GetChildren()) do apply(t) end end
    for _, t in ipairs(char:GetChildren()) do apply(t) end
end

-- Tạo nút
local function createBtn(text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 34)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = Color3.new(0, 0, 0)
    btn.BorderColor3 = Color3.new(1, 1, 1)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(updateAllAmmo)
    return btn
end

createBtn("Ammo: M1911", 45)
createBtn("Ammo: Sawed-off", 83)
createBtn("Ammo: M1 Garand", 121)
createBtn("Ammo: MP5", 159)
createBtn("Ammo: AK-47", 197)
createBtn("Ammo: Minigun", 235)

print("NONAME HUB BASIC loaded | H = Hide/Show UI")
