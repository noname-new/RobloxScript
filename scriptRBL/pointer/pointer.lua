-- Roblox LocalScript: Blox Fruits Portal Dimensional Rift
-- 1. Upload arrow/hand PNG to Roblox (Create > Decals/Images)
-- 2. Replace rbxassetid://0 with your asset IDs

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ARROW_IMAGE = "https://cdn.custom-cursors.com/uploads/blox_fruits_portal_dimensional_rift_arrow_128_09d3520c76.png" -- or "rbxassetid://YOUR_ARROW_ID"
local HAND_IMAGE = "https://cdn.custom-cursors.com/uploads/blox_fruits_portal_dimensional_rift_hand_128_ad7da0bd67.png"   -- or "rbxassetid://YOUR_HAND_ID"
local CURSOR_SIZE = 48

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Simple follow-mouse ImageLabel fallback (works in Roblox Studio preview)
local gui = Instance.new("ScreenGui")
gui.Name = "CustomCursorGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("ImageLabel")
label.Name = "CursorFollower"
label.BackgroundTransparency = 1
label.Size = UDim2.fromOffset(CURSOR_SIZE, CURSOR_SIZE)
label.Image = ARROW_IMAGE
label.ZIndex = 9999
label.Parent = gui

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = input.Position
        label.Position = UDim2.fromOffset(pos.X - CURSOR_SIZE / 2, pos.Y - CURSOR_SIZE / 2)
    end
end)

-- Optional: swap to hand image when hovering clickable parts
mouse.Button1Down:Connect(function()
    label.Image = HAND_IMAGE
end)
mouse.Button1Up:Connect(function()
    label.Image = ARROW_IMAGE
end)