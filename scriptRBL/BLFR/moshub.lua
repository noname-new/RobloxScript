getgenv().Key = "NO_KEY_NEEDED"
getgenv().__BANANA_SCRIPT_ROUTE = "kaigod"
Config = {
    Team = "Pirates",
    FastTween = true,
    AutoHop = false,
    HopWhenIdle = false,
    AutoRerunAfterHop = true,
    -- Required: set this to the RAW URL of the hosted loadstring4 script.
    -- Example: "https://raw.githubusercontent.com/USER/REPO/branch/loadstring4.lua"
    RerunUrl = "https://raw.githubusercontent.com/noname-new/RobloxScript/refs/heads/main/scriptRBL/BLFR/moshub.lua",
    FpsBoost = true,
    FpsCap = 60,
  RemoveSFX = true,
    BlockAcc = true,
    BlackScreen = false,
  ["Buy Haki"] = {
    Skyjump = true,
    Buso = true,
    Soru = true,
    Observation = true
  },
    CursedDualKatana = false,
    SoulGuitar = false,
    FarmBoneForx2EXP = false,
    WebhookEnabled = false,
    WebhookUrl = "",
    WebhookIntervalMinutes = 5
}

-- Safe initialization & Environment Polyfills
repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

-- Auto re-run after server teleport (pattern adapted from Noname Hub).
-- A teleport queue can only re-execute this script if its source is hosted at a stable URL
-- (or saved at a known executor file path). No source URL is assumed or invented here.
do
    local env = (type(getgenv) == "function" and getgenv()) or _G
    local queueFn

    if type(queue_on_teleport) == "function" then
        queueFn = queue_on_teleport
    elseif type(queueonteleport) == "function" then
        queueFn = queueonteleport
    elseif type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
        queueFn = syn.queue_on_teleport
    elseif type(env.queue_on_teleport) == "function" then
        queueFn = env.queue_on_teleport
    end

    local function getRerunSource()
        local url = Config and Config.RerunUrl
        if type(url) ~= "string" or url:gsub("%s", "") == "" then
            url = env.BananaCatLoaderURL
        end
        if type(url) == "string" then
            url = url:gsub("^%s+", ""):gsub("%s+$", "")
            if url:match("^https?://") then
                return string.format("loadstring(game:HttpGet(%q))()", url)
            end
        end

        local filePath = env.BananaCatLoaderFile
        if type(filePath) == "string" and filePath:gsub("%s", "") ~= "" then
            return string.format("loadstring(readfile(%q))()", filePath)
        end
        return nil
    end

    local queuedAt = -math.huge
    local function queueRerun()
        if Config.AutoRerunAfterHop == false then
            return false
        end
        if os.clock() - queuedAt < 15 then
            return true
        end
        if type(queueFn) ~= "function" then
            warn("[MosHub] Auto re-run unavailable: executor has no queue_on_teleport.")
            return false
        end

        local loader = getRerunSource()
        if not loader then
            warn("[MosHub] Auto re-run is enabled, but Config.RerunUrl is empty. Set it to the RAW hosted script URL.")
            return false
        end

        local code = table.concat({
            "local env = (type(getgenv) == 'function' and getgenv()) or _G",
            "if env.__MOSHUB_RERUN_JOB == game.JobId then return end",
            "env.__MOSHUB_RERUN_JOB = game.JobId",
            "task.spawn(function()",
            "  if not game:IsLoaded() then game.Loaded:Wait() end",
            "  task.wait(2)",
            "  local ok, err = pcall(function() " .. loader .. " end)",
            "  if not ok then warn('[MosHub] re-run failed: ' .. tostring(err)) end",
            "end)"
        }, "\n")

        local ok, err = pcall(queueFn, code)
        if ok then
            queuedAt = os.clock()
            return true
        end
        warn("[MosHub] queue_on_teleport failed: " .. tostring(err))
        return false
    end

    -- Covers server hops initiated by this script and teleports initiated by the game.
    LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Started or state == Enum.TeleportState.InProgress then
            queueRerun()
        end
    end)

    -- Expose a manual hook for any custom teleport path added later.
    env.MosHubQueueRerun = queueRerun
end

local isfolder = isfolder or function() return false end
local makefolder = makefolder or function() end
local isfile = isfile or function() return false end
local readfile = readfile or function() return "" end
local writefile = writefile or function() end
local setfpscap = setfpscap or function() end
local firesignal = firesignal or function() end
local getconnections = getconnections or function() return {} end
local gethui = gethui or function()
  local ok, res = pcall(function() return game:GetService("CoreGui") end)
  if ok and res then return res end
  return LocalPlayer:FindFirstChild("PlayerGui")
end

local bananaScriptRoute = getgenv().__BANANA_SCRIPT_ROUTE
getgenv().__BANANA_SCRIPT_ROUTE = nil
local str = "[MosHub] "
local genv = getgenv()

if true then
  if true then

    local v = nil
    local flag = false
    local connection = nil
    local tbl2 = {}
    local n = 0
    local fn = nil
    local v2 = nil
    local v3 = nil

    local function fn2()
      local ok, result = pcall(function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local localPlayer = Players.LocalPlayer

        if localPlayer then
          local playerGui = localPlayer:WaitForChild("PlayerGui")
          local kind = type(gethui)

          if kind == "function" then
            local ok, result = pcall(gethui)

            if ok then
              if typeof(result) == "Instance" then
                playerGui = result
              end
            end
          end

          local chuoiHubWhitelistLoader = playerGui:FindFirstChild("MosHubWhitelistLoader")

          if chuoiHubWhitelistLoader then
            chuoiHubWhitelistLoader:Destroy()
          end

          local function fn3(arg, arg2, parent)
            local instance = Instance.new(arg)

            for k, v4 in pairs(arg2) do
              instance[k] = v4
            end

            instance.Parent = parent
            return instance
          end

          local ScreenGui = fn3("ScreenGui", {Name = "MosHubWhitelistLoader", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 1000000, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, playerGui)
          local Frame = fn3("Frame", {Name = "Backdrop", Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(2, 3, 8), BackgroundTransparency = 0.2, BorderSizePixel = 0, Active = true}, ScreenGui)
          local tbl = {}
          local tbl3 = {}
          local v4 = ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 6, 12))
          local v5 = ColorSequenceKeypoint.new(0.55, Color3.fromRGB(8, 8, 14))
          local v6 = table.pack(ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 10, 14)))
          tbl3[1] = v4
          tbl3[2] = v5
          tbl3[3] = table.unpack(v6, 1, v6.n)
          tbl.Color = ColorSequence.new(tbl3)
          tbl.Rotation = 125
          fn3("UIGradient", tbl, Frame)
          local Frame2 = fn3("Frame", {Name = "LoaderCard", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 18), Size = UDim2.new(0, 530, 0, 350), BackgroundColor3 = Color3.fromRGB(10, 12, 20), BackgroundTransparency = 0.04, BorderSizePixel = 0, ClipsDescendants = true}, Frame)
          fn3("UICorner", {CornerRadius = UDim.new(0, 22)}, Frame2)
          fn3("UIStroke", {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.72, Thickness = 1}, Frame2)
          local tbl4 = {}
          local tbl5 = {}
          local v7 = ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 20, 30))
          local v8 = ColorSequenceKeypoint.new(0.58, Color3.fromRGB(10, 12, 20))
          tbl5[1] = v7
          tbl5[2] = v8
          tbl5[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 16, 26))
          tbl4.Color = ColorSequence.new(tbl5)
          tbl4.Rotation = 135
          fn3("UIGradient", tbl4, Frame2)
          local UIScale = fn3("UIScale", {Scale = 0.9}, Frame2)

          local function fn4()
            local currentCamera = workspace.CurrentCamera
            local viewportSize

            if currentCamera then
              viewportSize = currentCamera.ViewportSize or Vector2.new(800, 600)
            else
              viewportSize = Vector2.new(800, 600)
              UIScale.Scale = math.clamp(math.min(viewportSize.X / 610, viewportSize.Y / 430), 0.58, 1)
              return
            end

            UIScale.Scale = math.clamp(math.min(viewportSize.X / 610, viewportSize.Y / 430), 0.58, 1)
          end

          fn4()
          local currentCamera = workspace.CurrentCamera

          if currentCamera then
            connection = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn4)
          end

          local Frame3 = fn3("Frame", {Name = "BrandMark", Position = UDim2.new(0, 27, 0, 24), Size = UDim2.new(0, 42, 0, 42), BackgroundColor3 = Color3.fromRGB(235, 235, 235), BorderSizePixel = 0}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(0, 13)}, Frame3)
          fn3("UIGradient", {Color = ColorSequence.new(Color3.fromRGB(245, 245, 245), Color3.fromRGB(190, 190, 190)), Rotation = 135}, Frame3)
          fn3("TextLabel", {Name = "Letter", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "M", TextColor3 = Color3.fromRGB(10, 10, 14), Font = Enum.Font.GothamBold, TextSize = 21}, Frame3)
          fn3("TextLabel", {Name = "Title", Position = UDim2.new(0, 83, 0, 23), Size = UDim2.new(0, 275, 0, 25), BackgroundTransparency = 1, Text = "MosHub-MinhNg222", TextColor3 = Color3.fromRGB(247, 248, 252), Font = Enum.Font.GothamBold, TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left}, Frame2)
          fn3("TextLabel", {Name = "Subtitle", Position = UDim2.new(0, 84, 0, 48), Size = UDim2.new(0, 295, 0, 18), BackgroundTransparency = 1, Text = "MOSHUB  /  KAITUN", TextColor3 = Color3.fromRGB(137, 143, 163), Font = Enum.Font.GothamMedium, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left}, Frame2)
          local Frame4 = fn3("Frame", {Name = "SecureBadge", Position = UDim2.new(1, -133, 0, 31), Size = UDim2.new(0, 84, 0, 25), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, Frame4)
          fn3("UIStroke", {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.6}, Frame4)
          fn3("TextLabel", {Name = "BadgeText", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "PROTECTED", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold, TextSize = 9}, Frame4)
          local TextButton = fn3("TextButton", {Name = "CloseButton", Position = UDim2.new(1, -40, 0, 28), Size = UDim2.new(0, 27, 0, 27), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94, BorderSizePixel = 0, AutoButtonColor = false, Text = "×", TextColor3 = Color3.fromRGB(171, 176, 194), Font = Enum.Font.GothamMedium, TextSize = 19}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, TextButton)
          fn3("Frame", {Name = "Divider", Position = UDim2.new(0, 27, 0, 82), Size = UDim2.new(1, -54, 0, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.91, BorderSizePixel = 0}, Frame2)
          local TextLabel = fn3("TextLabel", {Name = "CurrentStatus", Position = UDim2.new(0, 27, 0, 98), Size = UDim2.new(1, -120, 0, 25), BackgroundTransparency = 1, Text = "Connecting to whitelist server...", TextColor3 = Color3.fromRGB(237, 239, 247), Font = Enum.Font.GothamSemibold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, Frame2)
          local TextLabel2 = fn3("TextLabel", {Name = "ProgressPercent", Position = UDim2.new(1, -85, 0, 98), Size = UDim2.new(0, 58, 0, 25), BackgroundTransparency = 1, Text = "0%", TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Right}, Frame2)
          local Frame5 = fn3("Frame", {Name = "ProgressTrack", Position = UDim2.new(0, 27, 0, 131), Size = UDim2.new(1, -54, 0, 7), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.91, BorderSizePixel = 0, ClipsDescendants = true}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, Frame5)
          local Frame6 = fn3("Frame", {Name = "ProgressFill", Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0}, Frame5)
          fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, Frame6)
          local tbl6 = {}
          local tbl7 = {}
          local v9 = ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 190, 190))
          local v10 = ColorSequenceKeypoint.new(0.55, Color3.fromRGB(255, 255, 255))
          tbl7[1] = v9
          tbl7[2] = v10
          tbl7[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))
          tbl6.Color = ColorSequence.new(tbl7)
          fn3("UIGradient", tbl6, Frame6)
          local Frame7 = fn3("Frame", {Name = "ActivityCard", Position = UDim2.new(0, 27, 0, 157), Size = UDim2.new(1, -54, 0, 145), BackgroundColor3 = Color3.fromRGB(3, 5, 10), BackgroundTransparency = 0.28, BorderSizePixel = 0, ClipsDescendants = true}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(0, 14)}, Frame7)
          fn3("UIStroke", {Color = Color3.new(1, 1, 1), Transparency = 0.92}, Frame7)
          fn3("TextLabel", {Name = "ActivityTitle", Position = UDim2.new(0, 16, 0, 10), Size = UDim2.new(1, -32, 0, 17), BackgroundTransparency = 1, Text = "LIVE ACTIVITY", TextColor3 = Color3.fromRGB(116, 123, 145), Font = Enum.Font.GothamBold, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left}, Frame7)
          local Frame8 = fn3("Frame", {Name = "LogRows", Position = UDim2.new(0, 16, 0, 33), Size = UDim2.new(1, -32, 1, -41), BackgroundTransparency = 1}, Frame7)
          fn3("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom}, Frame8)
          local Frame9 = fn3("Frame", {Name = "ConnectionIndicator", Position = UDim2.new(0, 28, 0, 324), Size = UDim2.new(0, 7, 0, 7), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0}, Frame2)
          fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, Frame9)
          local TextLabel3 = fn3("TextLabel", {Name = "ConnectionText", Position = UDim2.new(0, 42, 0, 317), Size = UDim2.new(1, -70, 0, 21), BackgroundTransparency = 1, Text = "Encrypted connection active", TextColor3 = Color3.fromRGB(116, 123, 145), Font = Enum.Font.GothamMedium, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left}, Frame2)
          local n2 = 0
          local tween = nil

          local function fn5(arg, text, arg2)
            if flag then
              return
            end

            if ScreenGui.Parent then
              n2 = math.max(n2, math.clamp(tonumber(arg) or 0, 0, 100))

              if text then
                TextLabel.Text = text
              end

              TextLabel2.Text = tostring(math.floor(n2 + 0.5)) .. "%"

              if arg2 ~= "success" then
                if arg2 == "warning" then
                  TextLabel.TextColor3 = Color3.fromRGB(255, 153, 147)
                  TextLabel2.TextColor3 = Color3.fromRGB(255, 134, 127)
                  Frame9.BackgroundColor3 = Color3.fromRGB(255, 119, 114)
                  TextLabel3.Text = "Execution error captured"
                end
              else
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Frame9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel3.Text = "Whitelist session verified"
              end

              if tween then
                tween:Cancel()
              end

              tween = TweenService:Create(Frame6, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.fromScale(n2 / 100, 1)})
              tween:Play()
              return
            end
          end

          v2 = fn5

          local function fn6(arg, arg2)
            if flag then
              return
            end

            if ScreenGui.Parent then
              while #tbl2 >= 5 do
                local v11 = table.remove(tbl2, 1)

                if v11 then
                  v11:Destroy()
                end
              end

              n += 1
              local color

              if arg2 ~= "success" then
                if arg2 ~= "warning" then
                  color = Color3.fromRGB(255, 195, 86)
                else
                  color = Color3.fromRGB(255, 119, 114)
                end
              else
                color = Color3.fromRGB(101, 224, 168)
              end

              local Frame10 = fn3("Frame", {Name = "ActivityRow", Size = UDim2.new(1, 0, 0, 17), BackgroundTransparency = 1, LayoutOrder = n}, Frame8)
              local Frame11 = fn3("Frame", {Position = UDim2.new(0, 0, 0, 6), Size = UDim2.new(0, 6, 0, 6), BackgroundColor3 = color, BorderSizePixel = 0}, Frame10)
              fn3("UICorner", {CornerRadius = UDim.new(1, 0)}, Frame11)
              local tbl8 = {Position = UDim2.new(0, 15, 0, 0), Size = UDim2.new(1, -15, 1, 0), BackgroundTransparency = 1, Text = tostring(arg)}
              local color2 = ((arg2 ~= "warning") and Color3.fromRGB(184, 190, 207)) or Color3.fromRGB(255, 153, 147)
              tbl8.TextColor3 = color2
              tbl8.TextTruncate = Enum.TextTruncate.AtEnd
              tbl8.Font = Enum.Font.Code
              tbl8.TextSize = 11
              tbl8.TextXAlignment = Enum.TextXAlignment.Left
              fn3("TextLabel", tbl8, Frame10)
              table.insert(tbl2, Frame10)
              return
            end
          end

          v3 = fn6

          fn = function(arg)
            if flag then
              return
            end

            task.delay(math.max(0, tonumber(arg) or 0), function()
              if flag then
                return
              end

              if ScreenGui.Parent then
                flag = true

                if connection then
                  connection:Disconnect()
                  connection = nil
                end

                local tbl8 = {Scale = UIScale.Scale * 0.92}
                TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), tbl8):Play()
                TweenService:Create(Frame2, TweenInfo.new(0.18), {BackgroundTransparency = 1}):Play()
                TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()

                local function fn7()
                  if ScreenGui then
                    ScreenGui:Destroy()
                    return
                  end
                end

                task.delay(0.22, fn7)
                return
              end
            end)
          end

          TextButton.MouseButton1Click:Connect(function()
            fn(0)
          end)

          local tbl8 = {Scale = UIScale.Scale / 0.9}
          TweenService:Create(UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl8):Play()
          TweenService:Create(Frame2, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
          return ScreenGui
        end

        return nil
      end)

      if ok then
        v = result
        return
      end
    end

    fn2()

    local function fn3(arg, arg2)
      if v then
        if flag then
          return
        end

        pcall(function()
          local str2 = tostring(arg)
          local n2, str3

          if string.find(str2, "starting", 1, true) then
            n2 = 20
            str3 = "Initializing whitelist"
          elseif string.find(str2, "Verifying", 1, true) then
            n2 = 60
            str3 = "Verifying credentials"
          else
            n2 = nil

            if string.find(str2, "successfully", 1, true) then
              arg2 = "success"
              n2 = 100
              str3 = "Ready — whitelist authorized"
            else
              str3 = str2
            end
          end

          v2(n2 or 0, str3, arg2)
          v3(str2, arg2)
        end)

        return
      end
    end

    local function fn4(arg)
      fn3(arg, "info")
    end

    local function fn5(arg)
      warn(str .. tostring(arg))
      fn3(arg, "warning")
    end

    local now = os.clock()
    fn4("Whitelist v5.0 starting...")

    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer

    local handlers = {}
    local tbl4 = {}
    local v4 = request
    local v5 = http_request
    local request_ = syn and syn.request
    local request_2 = http and http.request
    tbl4[1] = v4
    tbl4[2] = v5
    tbl4[3] = request_
    tbl4[4] = request_2

    for _, v6 in ipairs(tbl4) do
      if type(v6) == "function" then
        local flag2 = false

        for _, handler in ipairs(handlers) do
          if handler == v6 then
            flag2 = true
            break
          end
        end

        if not flag2 then
          handlers[#handlers + 1] = v6
        end
      end
    end

    if true then
      local function fn10(arg)
        return handlers[1](arg)
      end

      local function fn11(arg)
        local ok, result = pcall(fn10, arg)
        return ok, result
      end

      local function fn12(arg, arg2)
        return fn11(arg2)
      end

      local v6

      if type(gethwid) ~= "function" then
        v6 = nil
      else
        v6 = gethwid or nil
      end

      local v7

      if type(getfingerprint) ~= "function" then
        v7 = nil
      else
        v7 = getfingerprint or nil
      end

      local function fn13()
        if v6 then
          return v6()
        end

        if v7 then
          return v7()
        end
        return HttpService:GenerateGUID(false)
      end

      local v8 = fn13()
      local key_ = getgenv().Key
      local name

      if not key_ then
        key_ = _G.Key
      end

      if localPlayer then
        name = localPlayer.Name or "unknown"
      else
        name = "unknown"
      end

      fn4("Initialized successfully (" .. (string.format("%.2f", os.clock() - now) .. "s)."))
      if type(fn) == "function" then
        pcall(fn, 0.5)
      end
      local v12 = key_
      local userId

      if localPlayer then
        userId = localPlayer.UserId or 0
      else
        userId = 0
      end

      local str3 = tostring(userId)
      local v13 = name
      local tbl5 = Config

      if not tbl5 then
        tbl5 = {Team = "Pirates", FastTween = true, AutoHop = true, HopWhenIdle = true, FpsBoost = true, FpsCap = 25, RemoveSFX = true, BlockAcc = false, BlackScreen = false, ["Buy Haki"] = {Skyjump = true, Buso = true, Soru = true, Observation = true}, CursedDualKatana = false, SoulGuitar = false, FarmBoneForx2EXP = false, WebhookEnabled = false, WebhookUrl = "", WebhookIntervalMinutes = 5}
      end
      do
        if not tbl5.RemoveSFX then return end
        local function destroyIfNeeded(instance)
          if instance:IsA("Sound") then
            task.defer(function()
              if instance and instance.Parent then
                instance:Destroy()
              end
            end)
          end
        end

        workspace.DescendantAdded:Connect(destroyIfNeeded)

        for _, descendant in workspace:GetDescendants() do
          destroyIfNeeded(descendant)
        end

      end

      while true do
        Config = tbl5
        local genv2

        if type(getgenv) ~= "function" then
          genv2 = _G
        else
          genv2 = getgenv() or _G
        end

        -- Re-execution blocker removed: allows clean reload
        if genv2.BananaCat and genv2.BananaCat.HUD then
          pcall(function() genv2.BananaCat.HUD:Destroy() end)
        end

        genv2.BananaCat = {executed = true, at = os.time(), JobId = game.JobId}

        if Config.FarmBoneForx2EXP == nil then
          Config.FarmBoneForx2EXP = true
        end

        _G.NR = Config.BlackScreen == true

        local function fn14()
          game:GetService("RunService"):Set3dRenderingEnabled(not _G.NR)
        end

        pcall(fn14)

        if Config.FpsCap then
          if type(setfpscap) == "function" then
            pcall(setfpscap, Config.FpsCap)
          end
        end

        local function fn15()
          local str4 = ((Config.Team ~= "Marines") and "Pirates") or "Marines"

          pcall(function()
            local remotes = game.ReplicatedStorage:WaitForChild("Remotes", 3)

            if remotes then
              local commF = remotes:WaitForChild("CommF_", 3)
              if commF then
                commF:InvokeServer("SetTeam", str4)
                return
              end
            end
          end)

          pcall(function()
            local guiButton = game.Players.LocalPlayer.PlayerGui["Main (minimal)"].ChooseTeam.Container[str4].Frame:FindFirstChildWhichIsA("GuiButton")

            if guiButton then
              if firesignal then
                pcall(firesignal, guiButton.Activated)
                pcall(firesignal, guiButton.MouseButton1Click)
              end

              if getconnections then
                for _, v14 in ipairs({guiButton.Activated, guiButton.MouseButton1Click}) do
                  for _, v15 in ipairs(getconnections(v14)) do
                    pcall(v15.Function)
                    break
                  end
                end

                return
              end
            end
          end)
        end

        if not game:IsLoaded() then
          pcall(function()
            game.Loaded:Wait()
          end)
        end

        local localPlayer2 = game:GetService("Players").LocalPlayer
        local waterWalk = workspace:FindFirstChild("WaterWalk")
        local part

        if waterWalk then
          if waterWalk:IsA("BasePart") then
            part = waterWalk
          elseif waterWalk then
            waterWalk:Destroy()
            part = Instance.new("Part")
          else
            part = Instance.new("Part")
          end
        else
          part = Instance.new("Part")
        end

        part.Name = "WaterWalk"
        part.Size = Vector3.new(math.huge, 1, math.huge)
        part.Transparency = 1
        part.Anchored = true
        part.CanCollide = false
        part.Parent = workspace

        task.spawn(function()
          while task.wait() do
            local character = localPlayer2.Character
            local humanoidRootPart, y, flag2

            if character then
              humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
              local humanoid = character:FindFirstChildOfClass("Humanoid")

              if humanoidRootPart then
                y = humanoidRootPart.Position.Y
                flag2 = (((y and (y >= -120)) and (y <= 0)) and humanoid) and not humanoid.Sit
              else
                y = humanoidRootPart
                flag2 = y
              end
            else
              humanoidRootPart = character
              y = humanoidRootPart
              flag2 = y
            end

            part.CanCollide = flag2 == true

            if flag2 then
              part.Position = Vector3.new(humanoidRootPart.Position.X, -5, humanoidRootPart.Position.Z)
            end
          end
        end)

        local now2 = os.clock()

        while game.Players.LocalPlayer and not game.Players.LocalPlayer.Team do
          if (os.clock() - now2) < 6 then
            if game.Players.LocalPlayer:FindFirstChild("PlayerGui") then
              fn15()
            end

            task.wait(0.15)
            continue
          end

          break
        end

        pcall(function()
          local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")

          if playerGui then
            local mainMinimal = playerGui:FindFirstChild("Main (minimal)")

            if mainMinimal then
              mainMinimal.Enabled = false
              mainMinimal:Destroy()
              return
            end
          end
        end)

        _G.NR = Config.BlackScreen == true
        tbl5 = pcall

        local function fn16()
          game:GetService("RunService"):Set3dRenderingEnabled(not _G.NR)
        end

        hasBoughtSkyjump = false
        hasBoughtBuso = false
        hasBoughtSoru = false
        hasBoughtObservation = false

        tbl5(fn16)
          local flag2 = os.time() >= 1756319996
          local flag3 = false

          local function fn17()
            if flag3 then
              return
            end
            flag3 = true

            task.spawn(function()
              while true do
                pcall(function()
                  game:GetService("TeleportService"):TeleportReconnect()
                end)

                task.wait(1)
              end
            end)

            task.spawn(function()
              local serverBrowser = game:GetService("ReplicatedStorage"):FindFirstChild("__ServerBrowser")
              local serverBrowser2

              if serverBrowser then
                serverBrowser2 = serverBrowser
              else
                serverBrowser2 = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser", 5)
                if not serverBrowser2 then
                  return
                end
              end

              while true do
                pcall(function()
                  local n3 = math.random(1, 10)
                  local response = serverBrowser2:InvokeServer(n3)

                  if type(response) == "table" then
                    local tbl = {}

                    for k, v14 in pairs(response) do
                      if type(v14) == "table" then
                        if tostring(k) ~= tostring(game.JobId) then
                          table.insert(tbl, k)
                        end
                      end
                    end

                    local n4 = #tbl

                    if n4 then
                      if n4 > 0 then
                        serverBrowser2:InvokeServer("teleport", tbl[math.random(1, #tbl)])
                        return
                      end
                    end
                  end
                end)

                task.wait(1.5)
              end
            end)
          end

          UnifiedReconnect = fn17

          CheckKick = function(arg)
            local ok, name = pcall(function()
              return arg.Name
            end)
            if not ok or (name ~= "ErrorPrompt") then
              return
            end
            task.wait(1)
            UnifiedReconnect("ErrorPrompt")

            pcall(function()
              arg:Destroy()
            end)
          end

          game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(CheckKick)
          local flag4 = false

          game:GetService("LogService").MessageOut:Connect(function(arg)
            local securityKickOrErrorLog = ((type(arg) ~= "string") and "") or (arg:lower() or "")

            if not flag4 then
              if not securityKickOrErrorLog:find("security kick, please rejoin", 1, true) then
                if securityKickOrErrorLog:find("server kick message:", 1, true) then
                  if not securityKickOrErrorLog:find("security kick", 1, true) then
                    if securityKickOrErrorLog:find("security kick", 1, true) then
                      if not securityKickOrErrorLog:find("rejoin", 1, true) then
                        if securityKickOrErrorLog:find("error code: 267", 1, true) then
                          if not securityKickOrErrorLog:find("security kick", 1, true) then
                            if not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                              if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                                return
                              end
                            end
                          end
                        elseif not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                          if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                            return
                          end
                        end
                      end
                    elseif securityKickOrErrorLog:find("error code: 267", 1, true) then
                      if not securityKickOrErrorLog:find("security kick", 1, true) then
                        if not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                          if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                            return
                          end
                        end
                      end
                    elseif not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                      if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                        return
                      end
                    end
                  end
                elseif securityKickOrErrorLog:find("security kick", 1, true) then
                  if not securityKickOrErrorLog:find("rejoin", 1, true) then
                    if securityKickOrErrorLog:find("error code: 267", 1, true) then
                      if not securityKickOrErrorLog:find("security kick", 1, true) then
                        if not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                          if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                            return
                          end
                        end
                      end
                    elseif not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                      if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                        return
                      end
                    end
                  end
                elseif securityKickOrErrorLog:find("error code: 267", 1, true) then
                  if not securityKickOrErrorLog:find("security kick", 1, true) then
                    if not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                      if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                        return
                      end
                    end
                  end
                elseif not securityKickOrErrorLog:find("you have been kicked", 1, true) then
                  if not securityKickOrErrorLog:find("teleport failed", 1, true) then
                    return
                  end
                end
              end

              flag4 = true
              UnifiedReconnect("Security kick or error log: " .. securityKickOrErrorLog)
              return
            end
          end)

          local now3 = os.time()
          local tbl6 = {}

          local function fn18(arg)
            if tbl6[arg] then
              return
            end
            tbl6[arg] = true
            warn(arg)
          end

          Report = fn18

          Notify = function(arg)
            require(game.ReplicatedStorage:WaitForChild("Notification")).new(arg):Display()
          end

          local function fn19(arg)
            local num = tonumber(arg)
            if num then
              local v14, v15, v16 = string.match(tostring(math.floor(num)), "^([^%d]*%d)(%d*)(.-)$")
              return v14 .. (v15:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v16)
            end

            if arg then
              return tostring(arg)
            end
            return tostring(0)
          end

          local function fn20(arg)
            arg = arg or {}
            local startTime = arg.StartTime or os.time()
            local oldSessionTime = arg.OldSessionTime or 0
            local localPlayer3 = game:GetService("Players").LocalPlayer
            local playerGui = (type(gethui) == "function" and gethui()) or (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui")) or localPlayer3:WaitForChild("PlayerGui")
            local TweenService = game:GetService("TweenService")
            local UserInputService = game:GetService("UserInputService")
            local Lighting_ = game:GetService("Lighting")
            local Workspace = game:GetService("Workspace")
            local currentCamera = Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera")
            local flag5 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
            local tbl = {Target = "rbxassetid://10734977012", Shield = "rbxassetid://10734951847", Cpu = "rbxassetid://10709813383", Crown = "rbxassetid://10709818626", Coins = "rbxassetid://10709811110", Gem = "rbxassetid://10723396000", Swords = "rbxassetid://10734975692", ChevronDown = "rbxassetid://10709790948", Minus = "rbxassetid://10734896206"}
            local tbl7 = {IslandBg = Color3.fromRGB(5, 8, 16), DashboardBg = Color3.fromRGB(5, 8, 16), DeckBg = Color3.fromRGB(10, 14, 24), CardGlow = Color3.fromRGB(18, 24, 40), BorderGlass = Color3.fromRGB(150, 150, 150), ChampagneGold = Color3.fromRGB(255, 255, 255), GoldDark = Color3.fromRGB(90, 90, 90), EmeraldMint = Color3.fromRGB(255, 255, 255), AmberGold = Color3.fromRGB(245, 245, 245), VividPurple = Color3.fromRGB(235, 235, 235), CrystalCyan = Color3.fromRGB(255, 255, 255), TextPure = Color3.new(1, 1, 1), TextSub = Color3.fromRGB(255, 255, 255), TextDim = Color3.fromRGB(190, 190, 190), ErrorRed = Color3.fromRGB(244, 63, 94), FontTitle = Enum.Font.GothamBold, FontBody = Enum.Font.GothamMedium, FontNumbers = Enum.Font.GothamBold, SpringExpand = TweenInfo.new(0.48, Enum.EasingStyle.Back, Enum.EasingDirection.Out), SpringCollapse = TweenInfo.new(0.44, Enum.EasingStyle.Back, Enum.EasingDirection.In), SpringBouncy = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), Quick = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)}
            local state = {IsOpen = false, ActiveTweens = setmetatable({}, {__mode = "k"}), Labels = {}, CurrentIslandTask = "", IslandTransitionId = 0, LastIslandTransitionAt = 0}
            local tbl8 = {Instances = {}}

            local function fn21(arg2, arg3, arg4)
              if state.ActiveTweens[arg2] then
                state.ActiveTweens[arg2]:Cancel()
              end

              local tween = TweenService:Create(arg2, arg4 or tbl7.Quick, arg3)
              state.ActiveTweens[arg2] = tween
              tween:Play()
              return tween
            end

            local function fn22(arg2)
              local v14 = state.ActiveTweens[arg2]

              if v14 then
                state.ActiveTweens[arg2] = nil
                v14:Cancel()
                return
              end
            end

            local function fn23(arg2, arg3, arg4)
              local connection2

              connection2 = arg2.Completed:Connect(function(playbackState)
                connection2:Disconnect()

                if playbackState == Enum.PlaybackState.Completed then
                  if not arg3 then
                    arg4()
                    return
                  end

                  if arg3 == state.IslandTransitionId then
                    arg4()
                    return
                  end
                end
              end)
            end

            local function fn24(arg2, arg3)
              local instance = Instance.new(arg2)

              for k, v14 in pairs(arg3) do
                if type(k) ~= "number" then
                  instance[k] = v14
                else
                  v14.Parent = instance
                end
              end

              return instance
            end

            pcall(function()
              game:GetService("CoreGui"):FindFirstChild("BananaCat_HUD"):Destroy()
            end)

            pcall(function()
              playerGui:FindFirstChild("BananaCat_HUD"):Destroy()
            end)

            if Lighting_:FindFirstChild("BananaCatBlur") then
              Lighting_.BananaCatBlur:Destroy()
            end

            local ScreenGui = fn24("ScreenGui", {Name = "BananaCat_HUD", Parent = playerGui, DisplayOrder = 999999, IgnoreGuiInset = true, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
            if genv2 and type(genv2) == "table" and genv2.BananaCat then genv2.BananaCat.HUD = ScreenGui end

            local BlurEffect = fn24("BlurEffect", {Name = "BananaCatBlur", Parent = Lighting_, Size = 0})
            local n4, n5

            if flag5 then
              n4 = 280
              n5 = 35
            else
              n4 = 310
              n5 = 38
            end

            local udim2 = UDim2.fromOffset(n4, n5)
            local tbl9 = {Name = "DynamicIsland", Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0)}
            local n6 = (flag5 and 10) or 14
            tbl9.Position = UDim2.new(0.5, 0, 0, n6)
            tbl9.Size = udim2
            tbl9.BackgroundColor3 = tbl7.IslandBg
            tbl9.BackgroundTransparency = 0.12
            tbl9.Text = ""
            tbl9.AutoButtonColor = false
            tbl9.ClipsDescendants = false
            tbl9.ZIndex = 80
            tbl9[1] = fn24("UICorner", {CornerRadius = UDim.new(1, 0)})
            local TextButton = fn24("TextButton", tbl9)
            local tbl10 = {Parent = fn24("UIStroke", {Parent = TextButton, Color = Color3.new(1, 1, 1), Thickness = 1.4, Transparency = 0.22}), Rotation = 45}
            local tbl11 = {}
            local v14 = ColorSequenceKeypoint.new(0, tbl7.ChampagneGold)
            local v15 = ColorSequenceKeypoint.new(0.5, tbl7.CrystalCyan)
            local borderGlass = tbl7.BorderGlass
            tbl11[1] = v14
            tbl11[2] = v15
            tbl11[3] = ColorSequenceKeypoint.new(1, borderGlass)
            tbl10.Color = ColorSequence.new(tbl11)
            local UIGradient = fn24("UIGradient", tbl10)
            local Frame = fn24("Frame", {Parent = TextButton, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.new(0, 9, 0, 9), BackgroundColor3 = tbl7.EmeraldMint, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 79, (fn24("UICorner", {CornerRadius = UDim.new(1, 0)}))})
            local Frame2 = fn24("Frame", {Parent = TextButton, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.new(0, 9, 0, 9), BackgroundColor3 = tbl7.EmeraldMint, BorderSizePixel = 0, ZIndex = 81, (fn24("UICorner", {CornerRadius = UDim.new(1, 0)}))})
            local tbl12 = {Parent = TextButton, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 28, 0.5, 0), Size = UDim2.new(0, 64, 0, 22), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "BANANA", TextColor3 = tbl7.ChampagneGold}
            local textSize = (flag5 and 12) or 13
            tbl12.TextSize = textSize
            tbl12.TextXAlignment = Enum.TextXAlignment.Left
            tbl12.ZIndex = 81
            fn24("TextLabel", tbl12)
            local tbl13 = {Name = "CompactTaskLabel", Parent = fn24("Frame", {Parent = TextButton, Position = UDim2.new(0, 96, 0, 0), Size = UDim2.new(1, -124, 1, 0), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 81}), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "LevelFarm • Active", TextColor3 = tbl7.TextPure}
            local textSize2 = (flag5 and 11.5) or 12.5
            tbl13.TextSize = textSize2
            tbl13.TextTruncate = Enum.TextTruncate.AtEnd
            tbl13.TextXAlignment = Enum.TextXAlignment.Left
            tbl13.ZIndex = 82
            local TextLabel = fn24("TextLabel", tbl13)
            local ImageLabel = fn24("ImageLabel", {Parent = TextButton, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(0, 14, 0, 14), BackgroundTransparency = 1, Image = tbl.ChevronDown, ImageColor3 = tbl7.ChampagneGold, Rotation = 0, ZIndex = 82})

            local function fn25(backgroundColor3)
              Frame.BackgroundColor3 = backgroundColor3 or Frame2.BackgroundColor3
              Frame.Size = UDim2.new(0, 9, 0, 9)
              Frame.BackgroundTransparency = 0.35
              fn21(Frame, {Size = UDim2.new(0, 26, 0, 26), BackgroundTransparency = 1}, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
            end

            local function fn26()
              UIGradient.Rotation = 45
              fn21(UIGradient, {Rotation = 225}, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
            end

            local function fn27(arg2, backgroundColor3)
              local currentIslandTask = tostring(arg2 or "Active")

              if state.CurrentIslandTask ~= currentIslandTask then
                state.CurrentIslandTask = currentIslandTask
                state.IslandTransitionId = state.IslandTransitionId + 1
                local islandTransitionId = state.IslandTransitionId
                local now4 = os.clock()
                local flag6 = (state.LastIslandTransitionAt > 0) and ((now4 - state.LastIslandTransitionAt) < 0.65)
                state.LastIslandTransitionAt = now4

                if flag6 then
                  fn22(TextLabel)
                  fn22(TextButton)
                  fn22(Frame2)
                  fn22(Frame)
                  fn22(UIGradient)
                  TextLabel.Text = currentIslandTask
                  TextLabel.Position = UDim2.new(0, 0, 0.5, 0)
                  TextLabel.TextTransparency = 0
                  TextButton.Size = udim2
                  Frame2.Size = UDim2.new(0, 9, 0, 9)
                  backgroundColor3 = backgroundColor3 or tbl7.EmeraldMint
                  Frame2.BackgroundColor3 = backgroundColor3
                  Frame.Size = UDim2.new(0, 9, 0, 9)
                  Frame.BackgroundTransparency = 1
                  return
                end

                local function fn28()
                  TextLabel.Text = currentIslandTask
                  TextLabel.Position = UDim2.new(0, 0, 0.5, 18)
                  fn21(TextLabel, {Position = UDim2.new(0, 0, 0.5, 0), TextTransparency = 0}, tbl7.SpringBouncy)
                end

                fn23(fn21(TextLabel, {Position = UDim2.new(0, 0, 0.5, -18), TextTransparency = 1}, tbl7.Quick), islandTransitionId, fn28)

                local function fn29()
                  fn23(fn21(TextButton, {Size = UDim2.fromOffset(n4 - 6, n5 + 3)}, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)), islandTransitionId, function()
                    fn21(TextButton, {Size = udim2}, tbl7.SpringBouncy)
                  end)
                end

                fn23(fn21(TextButton, {Size = UDim2.fromOffset(n4 + 24, n5 - 4)}, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)), islandTransitionId, fn29)
                fn25(backgroundColor3)
                fn26()

                if backgroundColor3 then
                  local function fn30()
                    fn21(Frame2, {Size = UDim2.new(0, 9, 0, 9)}, tbl7.SpringBouncy)
                  end

                  fn23(fn21(Frame2, {BackgroundColor3 = backgroundColor3, Size = UDim2.new(0, 12, 0, 12)}, tbl7.Quick), islandTransitionId, fn30)
                  return
                end

                return
              end
            end

            local n7 = (flag5 and 28) or 33
            local udim22 = UDim2.new(0.5, 0, 0, n7)
            local udim23 = UDim2.new(0.5, 0, 0.5, 40)
            local Frame3 = fn24("Frame", {Name = "Dashboard", Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0.5), Position = udim23, Size = UDim2.new(0, 600, 0, 440), BackgroundColor3 = tbl7.DashboardBg, BackgroundTransparency = 0.18, ClipsDescendants = true, Visible = true, ZIndex = 50})
            local UIScale = fn24("UIScale", {Parent = Frame3, Scale = 1})

            local function fn28()
              local viewportSize = Vector2.new(1280, 720)

              if currentCamera then
                viewportSize = currentCamera.ViewportSize or viewportSize
              end

              local scale = math.min(1, viewportSize.X / 620, (viewportSize.Y - 90) / 440)
              UIScale.Scale = math.clamp(scale, 0.4, 1)
            end

            if currentCamera then
              currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn28)
              fn28()
            end

            local UICorner = fn24("UICorner", {Parent = Frame3, CornerRadius = UDim.new(0, 8)})
            local tbl14 = {Parent = Frame3, Color = Color3.new(1, 1, 1), Thickness = 1.4, Transparency = 0.22}
            local tbl15 = {}
            local tbl16 = {}
            local v16 = ColorSequenceKeypoint.new(0, tbl7.ChampagneGold)
            local v17 = ColorSequenceKeypoint.new(0.5, tbl7.CrystalCyan)
            local borderGlass2 = tbl7.BorderGlass
            tbl16[1] = v16
            tbl16[2] = v17
            tbl16[3] = ColorSequenceKeypoint.new(1, borderGlass2)
            tbl15.Color = ColorSequence.new(tbl16)
            tbl15.Rotation = 45
            tbl14[1] = fn24("UIGradient", tbl15)
            fn24("UIStroke", tbl14)
            local tbl17 = {Parent = Frame3, Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.93, BorderSizePixel = 0, ZIndex = 50}
            local UICorner2 = fn24("UICorner", {CornerRadius = UDim.new(0, 8)})
            local tbl18 = {}
            local tbl19 = {}
            local v18 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
            local v19 = ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255))
            tbl19[1] = v18
            tbl19[2] = v19
            tbl19[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 8, 16))
            tbl18.Color = ColorSequence.new(tbl19)
            local tbl20 = {}
            local v20 = NumberSequenceKeypoint.new(0, 0.78)
            local v22 = NumberSequenceKeypoint.new(0.35, 0.92)
            tbl20[1] = v20
            tbl20[2] = v22
            tbl20[3] = NumberSequenceKeypoint.new(1, 1)
            tbl18.Transparency = NumberSequence.new(tbl20)
            tbl18.Rotation = 65
            local UIGradient2 = fn24("UIGradient", tbl18)
            tbl17[1] = UICorner2
            tbl17[2] = UIGradient2
            local Frame4 = fn24("Frame", tbl17)
            local tbl21 = {Parent = Frame3, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 50}
            local UICorner3 = fn24("UICorner", {CornerRadius = UDim.new(0, 7)})
            local tbl22 = {Color = Color3.new(1, 1, 1), Thickness = 1, Transparency = 0.78}
            local tbl23 = {}
            local tbl24 = {}
            local v23 = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
            local v24 = ColorSequenceKeypoint.new(0.4, Color3.fromRGB(220, 220, 220))
            tbl24[1] = v23
            tbl24[2] = v24
            tbl24[3] = ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 48))
            tbl23.Color = ColorSequence.new(tbl24)
            tbl23.Rotation = 90
            tbl22[1] = fn24("UIGradient", tbl23)
            local UIStroke = fn24("UIStroke", tbl22)
            tbl21[1] = UICorner3
            tbl21[2] = UIStroke
            local Frame5 = fn24("Frame", tbl21)
            local tbl25 = {Parent = Frame3, Size = UDim2.new(1, 0, 0, 46), BackgroundColor3 = tbl7.DeckBg, BackgroundTransparency = 0.5, ZIndex = 52}
            local UICorner4 = fn24("UICorner", {CornerRadius = UDim.new(0, 8)})
            local deckBg = tbl7.DeckBg
            local UIGradient3 = fn24("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, tbl7.CardGlow), ColorSequenceKeypoint.new(1, deckBg)}), Rotation = 90})
            tbl25[1] = UICorner4
            tbl25[2] = UIGradient3
            local Frame6 = fn24("Frame", tbl25)
            fn24("TextLabel", {Parent = Frame6, Position = UDim2.new(0, 90, 0, 0), Size = UDim2.new(1, -180, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "MosHub-MinhNg222 - Tracker", TextColor3 = tbl7.TextPure, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 53})
            local tbl26 = {Parent = Frame6, Position = UDim2.new(0, 12, 0.5, -11), Size = UDim2.new(0, 80, 0, 22), BackgroundColor3 = Color3.fromRGB(18, 22, 34), BackgroundTransparency = 0.3, ZIndex = 53}
            local UICorner5 = fn24("UICorner", {CornerRadius = UDim.new(1, 0)})
            local UIStroke2 = fn24("UIStroke", {Color = tbl7.EmeraldMint, Thickness = 1, Transparency = 0.4})
            local Frame7 = fn24("Frame", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 9, 0.5, 0), Size = UDim2.new(0, 6, 0, 6), BackgroundColor3 = tbl7.EmeraldMint, BorderSizePixel = 0, ZIndex = 54, (fn24("UICorner", {CornerRadius = UDim.new(1, 0)}))})
            local TextLabel2 = fn24("TextLabel", {Position = UDim2.new(0, 20, 0, 0), Size = UDim2.new(1, -24, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "ACTIVE", TextColor3 = tbl7.EmeraldMint, TextSize = 10.5, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 54})
            tbl26[1] = UICorner5
            tbl26[2] = UIStroke2
            tbl26[3] = Frame7
            tbl26[4] = TextLabel2
            fn24("Frame", tbl26)
            local tbl27 = {Parent = Frame6, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.new(0, 28, 0, 28), BackgroundColor3 = tbl7.DeckBg, BackgroundTransparency = 0.3, Text = "", AutoButtonColor = false, ZIndex = 54}
            local UICorner6 = fn24("UICorner", {CornerRadius = UDim.new(1, 0)})
            local UIStroke3 = fn24("UIStroke", {Color = tbl7.BorderGlass, Thickness = 1, Transparency = 0.4})
            local ImageLabel2 = fn24("ImageLabel", {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 13, 0, 13), BackgroundTransparency = 1, Image = tbl.Minus, ImageColor3 = tbl7.TextPure, ZIndex = 55})
            tbl27[1] = UICorner6
            tbl27[2] = UIStroke3
            tbl27[3] = ImageLabel2
            local TextButton2 = fn24("TextButton", tbl27)

            TextButton2.MouseEnter:Connect(function()
              fn21(TextButton2, {BackgroundColor3 = tbl7.GoldDark}, tbl7.Quick)
            end)

            TextButton2.MouseLeave:Connect(function()
              fn21(TextButton2, {BackgroundColor3 = tbl7.DeckBg}, tbl7.Quick)
            end)

            local flag6 = false
            local v25 = nil
            local v26 = nil
            local v27 = nil

            Frame6.InputBegan:Connect(function(input)
              if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
                if input.UserInputType ~= Enum.UserInputType.Touch then
                  return
                end
              end

              local position = input.Position
              local position2 = Frame3.Position
              flag6 = true
              v26 = position
              v27 = position2

              input.Changed:Connect(function()
                if input.UserInputState ~= Enum.UserInputState.End then
                  return
                end
                flag6 = false
              end)
            end)

            local inputChanged = Frame6.InputChanged
            local connect = inputChanged.Connect

            local function fn29(arg2)
              if arg2.UserInputType ~= Enum.UserInputType.MouseMovement then
                if arg2.UserInputType ~= Enum.UserInputType.Touch then
                  return
                end
                v25 = arg2
                return
              end

              v25 = arg2
            end

            connect(inputChanged, fn29)

            UserInputService.InputChanged:Connect(function(input)
              if input == v25 then
                if flag6 then
                  if state.IsOpen then
                    local n9 = input.Position - v26
                    Frame3.Position = UDim2.new(v27.X.Scale, v27.X.Offset + n9.X, v27.Y.Scale, v27.Y.Offset + n9.Y)
                    return
                  end
                end
              end
            end)

            local function fn30(arg2, arg3, arg4, arg5)
              local tbl28 = {Parent = arg2, Position = arg3, Size = arg4, BackgroundColor3 = tbl7.DeckBg, BackgroundTransparency = 0.45, ZIndex = 52}
              local UICorner7 = fn24("UICorner", {CornerRadius = UDim.new(0, 4)})
              local tbl29 = {Name = "Stroke", Color = Color3.new(1, 1, 1), Thickness = 1.1, Transparency = 0.4}
              local tbl30 = {}
              local tbl31 = {}
              local v28 = ColorSequenceKeypoint.new(0, arg5)
              local borderGlass3 = tbl7.BorderGlass
              tbl31[1] = v28
              tbl31[2] = ColorSequenceKeypoint.new(1, borderGlass3)
              tbl30.Color = ColorSequence.new(tbl31)
              tbl30.Rotation = 45
              tbl29[1] = fn24("UIGradient", tbl30)
              local UIStroke4 = fn24("UIStroke", tbl29)
              local deckBg2 = tbl7.DeckBg
              local tbl32 = {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, tbl7.CardGlow), ColorSequenceKeypoint.new(1, deckBg2)}), Rotation = 90}
              tbl28[1] = UICorner7
              tbl28[2] = UIStroke4
              tbl28[3] = fn24("UIGradient", tbl32)
              return fn24("Frame", tbl28)
            end

            local v28 = fn30(Frame3, UDim2.new(0, 14, 0, 52), UDim2.new(1, -28, 0, 36), tbl7.BorderGlass)
            local tbl28 = {Parent = v28, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.new(0, 26, 0, 26), BackgroundTransparency = 1, Image = "rbxthumb://type=AvatarHeadShot&id=" .. (tostring(localPlayer3.UserId) .. "&w=150&h=150"), ZIndex = 53}
            local UICorner7 = fn24("UICorner", {CornerRadius = UDim.new(1, 0)})
            local UIStroke4 = fn24("UIStroke", {Color = tbl7.ChampagneGold, Thickness = 1, Transparency = 0.5})
            tbl28[1] = UICorner7
            tbl28[2] = UIStroke4
            fn24("ImageLabel", tbl28)
            fn24("TextLabel", {Parent = v28, Position = UDim2.new(0, 38, 0, 0), Size = UDim2.new(0, 230, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = tostring(localPlayer3.DisplayName) .. (" (@" .. (tostring(localPlayer3.Name) .. ")")), TextColor3 = tbl7.TextPure, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53})
            local TextLabel3 = fn24("TextLabel", {Parent = v28, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.new(0, 270, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "Uptime: 00:00:00", TextColor3 = tbl7.ChampagneGold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 53})
            local v29 = fn30(Frame3, UDim2.new(0, 14, 0, 154), UDim2.new(0, 340, 0, 126), tbl7.ChampagneGold)
            local tbl29 = {Parent = v29, Position = UDim2.new(0, 12, 0, 10), Size = UDim2.new(0, 138, 0, 20), BackgroundColor3 = Color3.fromRGB(18, 22, 34), BackgroundTransparency = 0.3, ZIndex = 53}
            local UICorner8 = fn24("UICorner", {CornerRadius = UDim.new(1, 0)})
            local UIStroke5 = fn24("UIStroke", {Color = tbl7.ChampagneGold, Thickness = 1, Transparency = 0.4})
            local ImageLabel3 = fn24("ImageLabel", {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.new(0, 12, 0, 12), BackgroundTransparency = 1, Image = tbl.Target, ImageColor3 = tbl7.ChampagneGold, ZIndex = 54})
            local TextLabel4 = fn24("TextLabel", {Position = UDim2.new(0, 24, 0, 0), Size = UDim2.new(1, -26, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "MISSION CONTROL", TextColor3 = tbl7.ChampagneGold, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 54})
            tbl29[1] = UICorner8
            tbl29[2] = UIStroke5
            tbl29[3] = ImageLabel3
            tbl29[4] = TextLabel4
            fn24("Frame", tbl29)
            local TextLabel5 = fn24("TextLabel", {Parent = v29, Position = UDim2.new(0, 12, 0, 36), Size = UDim2.new(1, -24, 0, 84), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "...", TextColor3 = tbl7.TextPure, TextSize = 13.5, TextWrapped = true, RichText = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 53})
            local Frame8 = fn24("Frame", {Parent = Frame3, Position = UDim2.new(0, 366, 0, 90), Size = UDim2.new(0, 220, 0, 322), BackgroundTransparency = 1, ZIndex = 52})
            local v30 = fn30(Frame8, UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 150), tbl7.CrystalCyan)
            fn24("ImageLabel", {Parent = v30, Position = UDim2.new(0, 10, 0, 7), Size = UDim2.new(0, 13, 0, 13), BackgroundTransparency = 1, Image = tbl.Shield, ImageColor3 = tbl7.CrystalCyan, ZIndex = 53})
            fn24("TextLabel", {Parent = v30, Position = UDim2.new(0, 28, 0, 6), Size = UDim2.new(1, -38, 0, 14), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "AUXILIARY TASK", TextColor3 = tbl7.CrystalCyan, TextSize = 10.5, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53})
            local TextLabel6 = fn24("TextLabel", {Parent = v30, Position = UDim2.new(0, 10, 0, 24), Size = UDim2.new(1, -20, 0, 118), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "None", TextColor3 = tbl7.TextSub, TextSize = 12.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 53})
            local v31 = fn30(Frame8, UDim2.new(0, 0, 0, 158), UDim2.new(1, 0, 0, 164), tbl7.EmeraldMint)
            fn24("ImageLabel", {Parent = v31, Position = UDim2.new(0, 10, 0, 7), Size = UDim2.new(0, 13, 0, 13), BackgroundTransparency = 1, Image = tbl.Cpu, ImageColor3 = tbl7.EmeraldMint, ZIndex = 53})
            fn24("TextLabel", {Parent = v31, Position = UDim2.new(0, 28, 0, 6), Size = UDim2.new(1, -38, 0, 14), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "ENGINE CONTROLLER", TextColor3 = tbl7.EmeraldMint, TextSize = 10.5, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53})
            local TextLabel7 = fn24("TextLabel", {Parent = v31, Position = UDim2.new(0, 10, 0, 24), Size = UDim2.new(1, -20, 0, 132), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "Idle", TextColor3 = tbl7.TextSub, TextSize = 12.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 53})
            local Frame9 = fn24("Frame", {Parent = Frame3, Position = UDim2.new(0, 14, 0, 90), Size = UDim2.new(0, 340, 0, 56), BackgroundTransparency = 1, ZIndex = 52})

            local function fn31(arg2, arg3, arg4, arg5, arg6)
              local v32 = fn30(Frame9, UDim2.new(0, arg2, 0, 0), UDim2.new(0, 108, 1, 0), arg3)
              fn24("ImageLabel", {Parent = v32, Position = UDim2.new(0, 10, 0, 8), Size = UDim2.new(0, 13, 0, 13), BackgroundTransparency = 1, Image = arg4, ImageColor3 = arg3, ZIndex = 53})
              fn24("TextLabel", {Parent = v32, Position = UDim2.new(0, 28, 0, 8), Size = UDim2.new(1, -38, 0, 14), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = arg5, TextColor3 = arg3, TextSize = 10.5, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53})
              return fn24("TextLabel", {Parent = v32, Position = UDim2.new(0, 10, 0, 24), Size = UDim2.new(1, -18, 0, 26), BackgroundTransparency = 1, Font = tbl7.FontNumbers, Text = arg6, TextColor3 = tbl7.TextPure, TextSize = 15, TextScaled = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53, (fn24("UITextSizeConstraint", {MaxTextSize = 15, MinTextSize = 8}))})
            end

            local playerLevel = fn31(0, tbl7.EmeraldMint, tbl.Crown, "LEVEL", "0")
            local beliWealth = fn31(116, tbl7.AmberGold, tbl.Coins, "BELI", "$ 0")
            local fragments = fn31(232, tbl7.VividPurple, tbl.Gem, "FRAGS", "0")
            local v32 = fn30(Frame3, UDim2.new(0, 14, 0, 288), UDim2.new(0, 340, 0, 124), tbl7.VividPurple)
            fn24("ImageLabel", {Parent = v32, Position = UDim2.new(0, 12, 0, 8), Size = UDim2.new(0, 14, 0, 14), BackgroundTransparency = 1, Image = tbl.Swords, ImageColor3 = tbl7.VividPurple, ZIndex = 53})
            fn24("TextLabel", {Parent = v32, Position = UDim2.new(0, 32, 0, 8), Size = UDim2.new(1, -44, 0, 14), BackgroundTransparency = 1, Font = tbl7.FontTitle, Text = "COMBAT MASTERY / ARSENAL", TextColor3 = tbl7.VividPurple, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 53})
            local TextLabel8 = fn24("TextLabel", {Parent = v32, Position = UDim2.new(0, 14, 0, 26), Size = UDim2.new(1, -28, 0, 92), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "Scanning melee data...", TextColor3 = tbl7.TextPure, TextSize = 16, TextWrapped = true, RichText = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 53})

            for _, v33 in ipairs({v29, v30, v31, v32}) do
              v33.MouseEnter:Connect(function()
                fn21(v33, {BackgroundTransparency = 0.28}, tbl7.Quick)
              end)

              v33.MouseLeave:Connect(function()
                fn21(v33, {BackgroundTransparency = 0.45}, tbl7.Quick)
              end)
            end

            state.Labels.Task1 = {Lbl = TextLabel5, Card = v29}
            state.Labels.MainTextLabel = state.Labels.Task1
            state.Labels.Task2 = {Lbl = TextLabel6, Card = v30}
            state.Labels.DebugLine = {Lbl = TextLabel7, Card = v31}
            state.Labels.Currencies = {Lbl = playerLevel, Card = Frame9}
            state.Labels.Melees = {Lbl = TextLabel8, Card = v32}
            state.Labels.LiveTime = {Lbl = TextLabel3, Card = v28}
            tbl8.Instances.Task1 = TextLabel5
            tbl8.Instances.MainTextLabel = TextLabel5
            tbl8.Instances.Task2 = TextLabel6
            tbl8.Instances.DebugLine = TextLabel7
            tbl8.Instances.Currencies = playerLevel
            tbl8.Instances.Melees = TextLabel8
            tbl8.Instances.LiveTime = TextLabel3

            local function fn32(isOpen)
              state.IsOpen = isOpen

              if isOpen then
                Frame3.Visible = true
                Frame3.Position = udim22
                Frame3.Size = udim2
                Frame3.BackgroundTransparency = 0.18
                local uiCorner = Frame4.UICorner
                local uiCorner2 = Frame5.UICorner
                UICorner.CornerRadius = UDim.new(1, 0)
                uiCorner.CornerRadius = UDim.new(1, 0)
                uiCorner2.CornerRadius = UDim.new(1, 0)
                fn21(ImageLabel, {Rotation = 180}, tbl7.SpringBouncy)
                fn25(tbl7.ChampagneGold)
                fn26()
                fn21(Frame3, {Position = udim23, Size = UDim2.new(0, 600, 0, 440)}, tbl7.SpringExpand)
                fn21(UICorner, {CornerRadius = UDim.new(0, 8)}, tbl7.SpringExpand)
                fn21(Frame4.UICorner, {CornerRadius = UDim.new(0, 8)}, tbl7.SpringExpand)
                fn21(Frame5.UICorner, {CornerRadius = UDim.new(0, 7)}, tbl7.SpringExpand)
                fn21(BlurEffect, {Size = 24}, tbl7.Quick)

                local function fn33()
                  local tbl30 = {Size = udim2}
                  fn21(TextButton, tbl30, tbl7.SpringExpand)
                end

                fn23(fn21(TextButton, {Size = UDim2.fromOffset(n4 + 18, n5 + 4)}, tbl7.Quick), nil, fn33)
                return
              end

              fn21(ImageLabel, {Rotation = 0}, tbl7.SpringBouncy)
              local v33 = fn21(Frame3, {Position = udim22, Size = udim2}, tbl7.SpringCollapse)
              fn21(UICorner, {CornerRadius = UDim.new(1, 0)}, tbl7.SpringCollapse)
              fn21(Frame4.UICorner, {CornerRadius = UDim.new(1, 0)}, tbl7.SpringCollapse)
              fn21(Frame5.UICorner, {CornerRadius = UDim.new(1, 0)}, tbl7.SpringCollapse)
              fn21(BlurEffect, {Size = 0}, tbl7.Quick)

              local function fn33()
                if state.IsOpen then
                  return
                end
                Frame3.Visible = false

                fn23(fn21(TextButton, {Size = UDim2.fromOffset(n4 + 22, n5 + 4)}, tbl7.Quick), nil, function()
                  fn21(TextButton, {Size = udim2}, tbl7.SpringExpand)
                end)

                fn25(tbl7.EmeraldMint)
                fn26()
              end

              fn23(v33, nil, fn33)
            end

            local function toggleUI(arg2)
              if arg2 == nil then
                local isOpen = state.IsOpen
                local flag7 = not isOpen

                if not isOpen then
                  arg2 = flag7
                end
              end

              fn32(arg2)
            end

            TextButton.MouseButton1Down:Connect(function()
              fn21(TextButton, {Size = UDim2.fromOffset(n4 - 14, n5 - 4)}, tbl7.Quick)
            end)

            TextButton.MouseButton1Click:Connect(function()
              fn21(TextButton, {Size = udim2}, tbl7.SpringBouncy)
              toggleUI()
            end)

            TextButton.MouseEnter:Connect(function()
              fn21(TextButton, {Size = UDim2.fromOffset(n4 + 14, n5 + 2)}, tbl7.SpringBouncy)
              fn21(ImageLabel, {Position = UDim2.new(1, -10, 0.5, 2)}, tbl7.Quick)
              fn26()
            end)

            TextButton.MouseLeave:Connect(function()
              fn21(TextButton, {Size = udim2}, tbl7.SpringBouncy)
              fn21(ImageLabel, {Position = UDim2.new(1, -10, 0.5, 0)}, tbl7.Quick)
            end)

            TextButton2.MouseButton1Click:Connect(function()
              toggleUI(false)
            end)

            do
              local u = {}
              pcall(function() TextButton.Visible = false end)

              u.m = fn24("TextButton", {Name = "MosToggle", Parent = ScreenGui, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.25, 0), Size = UDim2.fromOffset(48, 48), BackgroundColor3 = tbl7.IslandBg, BackgroundTransparency = 0.1, AutoButtonColor = false, Text = "M", Font = Enum.Font.Arcade, TextSize = 30, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Center, TextYAlignment = Enum.TextYAlignment.Center, BorderSizePixel = 0, Active = true, ZIndex = 90})
              fn24("UICorner", {Parent = u.m, CornerRadius = UDim.new(1, 0)})
              fn24("UIStroke", {Parent = u.m, Color = Color3.new(1, 1, 1), Thickness = 2, Transparency = 0})
              pcall(function() u.m.Draggable = true end)

              u.m.MouseEnter:Connect(function()
                fn21(u.m, {Size = UDim2.fromOffset(54, 54)}, tbl7.SpringBouncy)
              end)

              u.m.MouseLeave:Connect(function()
                fn21(u.m, {Size = UDim2.fromOffset(48, 48)}, tbl7.SpringBouncy)
              end)

              u.m.MouseButton1Click:Connect(function()
                toggleUI()
              end)

              u.box = fn24("Frame", {Name = "StatusBox", Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 24), Size = UDim2.fromOffset(430, 46), BackgroundColor3 = tbl7.IslandBg, BackgroundTransparency = 0.1, BorderSizePixel = 0, ZIndex = 80})
              fn24("UICorner", {Parent = u.box, CornerRadius = UDim.new(0, 4)})
              fn24("UIStroke", {Parent = u.box, Color = Color3.new(1, 1, 1), Thickness = 1.5, Transparency = 0.1})
              tbl8.Instances.StatusMain = fn24("TextLabel", {Parent = u.box, Position = UDim2.new(0, 8, 0, 5), Size = UDim2.new(1, -16, 0, 17), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "Status Main : Starting...", TextColor3 = tbl7.TextPure, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 81})
              tbl8.Instances.StatusTask = fn24("TextLabel", {Parent = u.box, Position = UDim2.new(0, 8, 0, 24), Size = UDim2.new(1, -16, 0, 17), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "Status Task : None", TextColor3 = tbl7.TextPure, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 81})

              fn24("TextLabel", {Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 5), Size = UDim2.fromOffset(430, 16), BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "https://discord.gg/qSK4ej9vN", TextColor3 = tbl7.TextSub, TextSize = 12, ZIndex = 80})

              fn24("TextLabel", {Parent = Frame6, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -50, 0, 0), Size = UDim2.new(0, 90, 1, 0), BackgroundTransparency = 1, Font = tbl7.FontBody, Text = "[RightCtrl]", TextColor3 = tbl7.TextDim, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 54})

              u.d = fn24("TextButton", {Name = "DiscordLink", Parent = Frame3, Position = UDim2.new(0, 14, 0, 416), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, AutoButtonColor = false, Text = "https://discord.gg/qSK4ej9vN  (tap to copy)", Font = tbl7.FontBody, TextSize = 12, TextColor3 = tbl7.CrystalCyan, ZIndex = 60})

              u.d.MouseButton1Click:Connect(function()
                pcall(function() setclipboard("https://discord.gg/qSK4ej9vN") end)
                u.d.Text = "Copied!"
                task.delay(1.5, function()
                  u.d.Text = "https://discord.gg/qSK4ej9vN  (tap to copy)"
                end)
              end)
            end


            UserInputService.InputBegan:Connect(function(input, gameProcessed)
              if not gameProcessed then
                if input.KeyCode == Enum.KeyCode.RightControl then
                  toggleUI()
                  return
                end

                if input.KeyCode == Enum.KeyCode.Insert then
                  toggleUI()
                  return
                end
              end
            end)

            local function fn33(arg2, arg3)
              local v33 = tbl8.Instances[arg2]

              if v33 then
                if v33.Text ~= tostring(arg3 or "n/a") then
                  v33.Text = tostring(arg3 or "n/a")
                  return
                end
                return
              end
            end

            local function fn34(arg2)
              local value

              pcall(function()
                local data = localPlayer3
                local v33

                if localPlayer3 then
                  data = localPlayer3:FindFirstChild("Data")

                  if data then
                    v33 = data:FindFirstChild(arg2)
                    if v33 then
                      value = v33.Value
                      return
                    end
                  end
                elseif data then
                  v33 = data:FindFirstChild(arg2)
                  if v33 then
                    value = v33.Value
                    return
                  end
                end
              end)

              local playerData

              if value ~= nil then
                playerData = value

                if not playerData then
                  playerData = ScriptStorage

                  if playerData then
                    playerData = ScriptStorage.PlayerData
                    if playerData then
                      return ScriptStorage.PlayerData[arg2]
                    end
                  end
                end
              else
                playerData = ScriptStorage

                if playerData then
                  playerData = ScriptStorage.PlayerData
                  if playerData then
                    return ScriptStorage.PlayerData[arg2]
                  end
                end
              end

              return playerData
            end

            local n9 = 0

            local function syncRuntimeUI()
              local n11 = math.max(0, os.time() - (startTime or os.time()))
              local n12 = n11 + (oldSessionTime or 0)
              local now4 = os.time()

              if (now4 - n9) >= 10 then
                n9 = now4

                pcall(function()
                  writefile("MosHubKaitun/.tdif-" .. localPlayer3.Name, tostring(n12))
                end)
              end

              local str4 = tostring(n11) .. "s"

              if type(DispTime) == "function" then
                local ok, result = pcall(DispTime, n11, true)

                if ok then
                  str4 = result or str4
                end
              end

              local str5 = tostring(n12) .. "s"

              if type(DispTime) == "function" then
                local ok, result = pcall(DispTime, n12, true)

                if ok then
                  str5 = result or str5
                end
              end

              fn33("LiveTime", "Session: " .. (str4 .. (" | Total: " .. str5)))
              playerLevel.Text = fn19(fn34("Level") or 0)
              beliWealth.Text = "$ " .. fn19(fn34("Beli") or 0)
              fragments.Text = fn19(fn34("Fragments") or 0)

              if (Config["Buy Haki"] and Config["Buy Haki"].Skyjump) and (not hasBoughtSkyjump) and (tonumber(fn34("Beli") or 0) >= 10000) then
                local buyresult = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
                if (buyresult == 1) or (buyresult == 2) then hasBoughtSkyjump = true end
              end

              if (Config["Buy Haki"] and Config["Buy Haki"].Buso) and (not hasBoughtBuso) and (tonumber(fn34("Beli") or 0) >= 25000) then
                local buyresult = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
                if (buyresult == 1) or (buyresult == 2) then hasBoughtBuso = true end
              end

              if (Config["Buy Haki"] and Config["Buy Haki"].Soru) and (not hasBoughtSoru) and (tonumber(fn34("Beli") or 0) >= 100000) then
                local buyresult = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
                if (buyresult == 1) or (buyresult == 2) then hasBoughtSoru = true end
              end

              if (Config["Buy Haki"] and Config["Buy Haki"].Observation) and (not hasBoughtObservation) and (tonumber(fn34("Beli") or 0) >= 750000) then
                local buyresult = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
                if (buyresult == 1) or (buyresult == 2) then hasBoughtObservation = true end
              end

              if ScriptStorage then
                local task_ = ScriptStorage.Task or {}
                local str6 = tostring(task_.MainTask or "Idle")

                if task_.QuestDebug then
                  if task_.QuestDebug ~= "" then
                    str6 ..= "\n<font color=\"#FFFFFF\">" .. (tostring(task_.QuestDebug) .. "</font>")
                  end
                end

                fn33("Task1", str6)
                fn33("Task2", tostring(task_.SideTask or "None"))
                fn33("StatusMain", "Status Main : " .. (tostring(task_.MainTask or "Idle"):gsub("<[^>]+>", ""):gsub("[\r\n]+", " ")))
                fn33("StatusTask", "Status Task : " .. (tostring(task_.SideTask or "None"):gsub("<[^>]+>", ""):gsub("[\r\n]+", " ")))
                local str7 = tostring(task_.MainTask or "Active")
                local str8 = str7:lower()
                local emeraldMint = tbl7.EmeraldMint

                if str8:find("error") then
                  emeraldMint = tbl7.ErrorRed
                elseif str8:find("loi") then
                  emeraldMint = tbl7.ErrorRed
                elseif str8:find("fail") then
                  emeraldMint = tbl7.ErrorRed
                elseif str8:find("danger") then
                  emeraldMint = tbl7.ErrorRed
                elseif str8:find("die") then
                  emeraldMint = tbl7.ErrorRed
                elseif str8:find("raid") then
                  emeraldMint = tbl7.VividPurple
                elseif str8:find("boss") then
                  emeraldMint = tbl7.VividPurple
                elseif str8:find("mirage") then
                  emeraldMint = tbl7.VividPurple
                elseif str8:find("kitsune") then
                  emeraldMint = tbl7.VividPurple
                elseif str8:find("v4") then
                  emeraldMint = tbl7.VividPurple
                elseif str8:find("hop") then
                  emeraldMint = tbl7.AmberGold
                elseif str8:find("wait") then
                  emeraldMint = tbl7.AmberGold
                elseif str8:find("server") then
                  emeraldMint = tbl7.AmberGold
                elseif str8:find("loading") then
                  emeraldMint = tbl7.AmberGold
                end

                fn27(str7, emeraldMint)
                local stroke = v29:FindFirstChild("Stroke")

                if stroke then
                  local errorRed

                  if str8:find("error") then
                    errorRed = tbl7.ErrorRed

                    if not errorRed then
                      if str8:find("waiting") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      elseif str8:find("loading") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      else
                        errorRed = Color3.new(1, 1, 1)
                      end
                    end
                  elseif str8:find("loi") then
                    errorRed = tbl7.ErrorRed

                    if not errorRed then
                      if str8:find("waiting") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      elseif str8:find("loading") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      else
                        errorRed = Color3.new(1, 1, 1)
                      end
                    end
                  elseif str8:find("fail") then
                    errorRed = tbl7.ErrorRed

                    if not errorRed then
                      if str8:find("waiting") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      elseif str8:find("loading") then
                        errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                      else
                        errorRed = Color3.new(1, 1, 1)
                      end
                    end
                  elseif str8:find("waiting") then
                    errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                  elseif str8:find("loading") then
                    errorRed = tbl7.AmberGold or Color3.new(1, 1, 1)
                  else
                    errorRed = Color3.new(1, 1, 1)
                  end

                  stroke.Color = errorRed
                end

                local v33 = nil

                pcall(function()
                  if type(RefreshMelees) ~= "function" then
                    return
                  end
                  v33 = RefreshMelees(true)
                end)

                if v33 then
                  if v33 ~= "" then
                    fn33("Melees", tostring(v33))
                  end
                end

                return
              end
            end

            local function setText(arg2, arg3)
              local v33, v34, labels, str4, match, str5, emeraldMint, stroke, v35, errorRed
              v33 = arg2
              v34 = arg3

              if not state.Labels[v33] then
                labels = state.Labels

                if v33 == "MainTextLabel" then
                  str4 = "Task1"
                else
                  str4 = v33
                end

                if not labels[str4] then
                  return
                end
              end

              if v34 and ((v34 ~= "") and (v34 ~= "n/a")) then
                fn33(v33, v34)

                if v33 ~= "Task1" then
                  if v33 ~= "MainTextLabel" then
                    return
                  end
                end

                match = tostring(v34):gsub("<[^>]+>", ""):match("^[^\n]+")

                if not match then
                  match = tostring(v34)
                end

                str5 = tostring(v34):lower()
                emeraldMint = tbl7.EmeraldMint

                if str5:find("error") or (str5:find("loi") or (str5:find("fail") or (str5:find("danger") or str5:find("die")))) then
                  emeraldMint = tbl7.ErrorRed
                elseif str5:find("raid") or (str5:find("boss") or (str5:find("mirage") or (str5:find("kitsune") or str5:find("v4")))) then
                  emeraldMint = tbl7.VividPurple
                elseif str5:find("hop") or (str5:find("wait") or (str5:find("server") or str5:find("loading"))) then
                  emeraldMint = tbl7.AmberGold
                end

                fn27(match, emeraldMint)
                stroke = v29:FindFirstChild("Stroke")

                if stroke then
                  if str5:find("error") or (str5:find("loi") or str5:find("fail")) then
                    v35 = tbl7

                    if v35 then
                      errorRed = v35.ErrorRed
                      if errorRed then
                        stroke.Color = errorRed
                        return
                      end
                    end
                  end

                  if str5:find("waiting") or str5:find("loading") then
                    errorRed = tbl7.AmberGold
                    if errorRed then
                      stroke.Color = errorRed
                      return
                    end
                  end

                  errorRed = Color3.new(1, 1, 1)
                  stroke.Color = errorRed
                end
              else
                syncRuntimeUI()
              end

              return
            end

            fn32(true)
            tbl8.SetText = setText
            tbl8.SyncRuntimeUI = syncRuntimeUI
            tbl8.ToggleUI = toggleUI
            tbl8.ToggleInterface = toggleUI
            tbl8.BlurManager = {}
            tbl8.State = state
            tbl8.GUI = ScreenGui
            return tbl8
          end

          local function fn21()
            local lastIdleTick, runtimeUI, fn22, ItemReplicationService, fn23, submergedWaitTick, canUseBypass, checkBypassCond, getBypassSpawn, v15
            local cframe, n4, cframe2, questAllowMap, questNameOverrides, normQuestName, matchQuestTitle, stripQuestSpaces, resetCurrentQuest, QuestController

            do
              _G.Stop = false

              if not isfolder("MosHubKaitun") then
                makefolder("MosHubKaitun")
              end

              now3 = os.time()
              lastIdleTick = os.time()
              local n5

              if isfile("MosHubKaitun" .. ("/.tdif-" .. game.Players.LocalPlayer.Name)) then
                n5 = tonumber(readfile("MosHubKaitun" .. ("/.tdif-" .. game.Players.LocalPlayer.Name))) or 0
              else
                n5 = 0
              end

              OldSessionTime = n5
              runtimeUI = fn20({StartTime = now3, OldSessionTime = OldSessionTime})
              while not game.Players.LocalPlayer.Character do
                task.wait(0.1)
              end

              if Config.DisableIslandLOD == true then
                spawn(function()
                  game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("NewIslandLOD", 9999):Destroy()
                  LocalPlayer.PlayerScripts:WaitForChild("IslandLOD", 9999):Destroy()
                end)
              end

              StartTick = tick()
              ScriptStorage = {IsInitalized = false, PlayerData = {}, Melees = {}, MeleesOwned = {}, TargetMelee = nil, MeleesLiveScanDone = false, CurrentMeleeData = {}, Enemies = {}, Tools = {}, Backpack = {}, IgnoreStoreFruits = {}, Connections = {LocalPlayer = {}}, Task = {}, Tracebacks = {}, TaskController = {}, TracebackUpdater = {}, Interface = runtimeUI, NPCs = {}, Map = {}}
              Players = game.Players
              LocalPlayer = Players.LocalPlayer
              Character = LocalPlayer.Character
              Humanoid = Character:WaitForChild("Humanoid")
              HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
              PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
              Lighting = game:GetService("Lighting")
              Services = {}

              setmetatable(Services, {__index = function(arg, arg2)
                return game:GetService(arg2)
              end})

              if Config.FpsBoost then
                if not _G.FPSB then
                  _G.FPSB = true

                  local obj = setmetatable({}, {__index = function(arg, arg2)
                    local ok, result = pcall(game.GetService, game, arg2)
                    if ok then
                      rawset(arg, arg2, result)
                      return result
                    end
                  end})

                  obj.RunService:Set3dRenderingEnabled(not _G.NR)
                  obj.Lighting.GlobalShadows = false
                  obj.Lighting.FogEnd = 9000000000
                  obj.Lighting.FogStart = 9000000000
                  obj.Lighting.Brightness = 1
                  obj.Lighting.ClockTime = 14
                  obj.Lighting.EnvironmentDiffuseScale = 0
                  obj.Lighting.EnvironmentSpecularScale = 0

                  pcall(function()
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                  end)

                  pcall(function()
                    sethiddenproperty(obj.Lighting, "Technology", 2)
                  end)

                  pcall(function()
                    local terrain = workspace.Terrain
                    terrain.WaterWaveSize = 0
                    terrain.WaterWaveSpeed = 0
                    terrain.WaterReflectance = 0
                    terrain.WaterTransparency = 0
                    terrain.Decoration = false
                  end)

                  for _, descendant in ipairs(obj.Lighting:GetDescendants()) do
                    pcall(function()
                      if descendant:IsA("Sky") then
                        descendant.SkyboxBk = ""
                        descendant.SkyboxDn = ""
                        descendant.SkyboxFt = ""
                        descendant.SkyboxLf = ""
                        descendant.SkyboxRt = ""
                        descendant.SkyboxUp = ""
                        descendant.StarCount = 0
                        descendant.MoonSize = 0
                        descendant.SunAngularSize = 0
                        return
                      end

                      if descendant:IsA("Atmosphere") then
                        descendant.Density = 0
                        descendant.Glare = 0
                        descendant.Haze = 0
                        return
                      end

                      if descendant:IsA("Clouds") then
                        descendant.Enabled = false
                        return
                      end

                      if descendant:IsA("PostEffect") then
                        descendant.Enabled = false
                        return
                      end
                    end)
                  end

                  local function fn30(arg)
                    local model = arg:FindFirstAncestorWhichIsA("Model")

                    if model then
                      local humanoid = model:FindFirstChildOfClass("Humanoid")
                      if humanoid then
                        return humanoid
                      end
                      local flag6 = model.Name == "Characters"
                      if flag6 then
                        return flag6
                      end
                      local flag7 = model.Name == "Enemies"
                      if flag7 then
                        return flag7
                      end
                      return model.Name == "NPCs"
                    end

                    return model
                  end

                  local function fn31(arg)
                    local players, v16 = obj.Players:GetPlayers()

                    for _, v17 in next, players, v16 do
                      if v17.Character then
                        if arg:IsDescendantOf(v17.Character) then
                          return true
                        end
                      end
                    end

                    return false
                  end

                  local function fn32(arg)
                    if arg then
                      if arg.Parent then
                        pcall(function()
                          if not arg:IsA("Humanoid") then
                            if not arg:IsA("ProximityPrompt") then
                              if not arg:IsA("ClickDetector") then
                                if not arg:IsA("Camera") then
                                  if not arg:IsA("SpawnLocation") then
                                    if not arg:IsA("Tool") then
                                      if not arg:IsA("BaseScript") then
                                        if not arg:IsA("RemoteEvent") then
                                          if not arg:IsA("RemoteFunction") then
                                            if arg:IsA("BillboardGui") then
                                              return
                                            end

                                            if arg:IsA("ScreenGui") then
                                              return
                                            end

                                            if arg:IsA("SurfaceGui") then
                                              return
                                            end

                                            if fn31(arg) then
                                              return
                                            end

                                            if arg:IsA("ParticleEmitter") then
                                              arg.Enabled = false
                                              arg.Rate = 0
                                              arg.Lifetime = NumberRange.new(0, 0)
                                              return
                                            end

                                            if not arg:IsA("Fire") then
                                              if not arg:IsA("Smoke") then
                                                if not arg:IsA("Sparkles") then
                                                  if arg:IsA("Trail") then
                                                    arg.Enabled = false
                                                    return
                                                  end

                                                  if arg:IsA("Beam") then
                                                    arg.Enabled = false
                                                    return
                                                  end

                                                  if arg:IsA("Highlight") then
                                                    arg.Enabled = false
                                                    return
                                                  end

                                                  if arg:IsA("SelectionBox") then
                                                    arg.Enabled = false
                                                    return
                                                  end

                                                  if arg:IsA("Explosion") then
                                                    arg.Visible = false
                                                    return
                                                  end

                                                  if arg:IsA("Light") then
                                                    arg.Enabled = false
                                                    return
                                                  end

                                                  if arg:IsA("Decal") then
                                                    arg.Transparency = 1
                                                    return
                                                  end

                                                  if arg:IsA("Texture") then
                                                    arg.Transparency = 1
                                                    return
                                                  end

                                                  if arg:IsA("Sound") then
                                                    local str4 = arg.Name:lower()

                                                    if not str4:find("ambient") then
                                                      if not str4:find("music") then
                                                        if not str4:find("wind") then
                                                          if not str4:find("water") then
                                                            if not str4:find("bgm") then
                                                              if not str4:find("background") then
                                                                if not str4:find("ocean") then
                                                                  if str4:find("rain") then
                                                                    arg.Volume = 0
                                                                    arg.Playing = false
                                                                    return
                                                                  end

                                                                  return
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end

                                                    arg.Volume = 0
                                                    arg.Playing = false
                                                    return
                                                  end

                                                  if arg:IsA("BasePart") then
                                                    if not arg:FindFirstAncestor("FX") then
                                                      if not arg:FindFirstAncestor("Effects") then
                                                        if not arg:FindFirstAncestor("Debris") then
                                                          if fn30(arg) then
                                                            return
                                                          end

                                                          if arg.Name == "HumanoidRootPart" then
                                                            return
                                                          end

                                                          if arg.Name == "Head" then
                                                            return
                                                          end
                                                        end
                                                      end
                                                    end

                                                    arg.Transparency = 1
                                                    arg.CastShadow = false
                                                    arg.Reflectance = 0
                                                    arg.Material = Enum.Material.SmoothPlastic

                                                    if arg:IsA("MeshPart") then
                                                      pcall(function()
                                                        arg.TextureID = ""
                                                      end)
                                                    end

                                                    return
                                                  end

                                                  return
                                                end
                                              end
                                            end

                                            arg.Enabled = false
                                            return
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end)

                        return
                      end
                    end
                  end

                  task.spawn(function()
                    local descendants = workspace:GetDescendants()

                    for i = 1, #descendants do
                      fn32(descendants[i])

                      if (i % 300) == 0 then
                        task.wait()
                      end
                    end

                    for _, descendant in ipairs(obj.ReplicatedStorage:GetDescendants()) do
                      pcall(function()
                        if descendant:IsA("ParticleEmitter") then
                          descendant.Enabled = false
                          descendant.Rate = 0
                          descendant.Lifetime = NumberRange.new(0, 0)
                          return
                        end

                        if descendant:IsA("Fire") then
                          descendant.Enabled = false
                          return
                        end

                        if descendant:IsA("Smoke") then
                          descendant.Enabled = false
                          return
                        end

                        if descendant:IsA("Sparkles") then
                          descendant.Enabled = false
                          return
                        end

                        if descendant:IsA("Trail") then
                          descendant.Enabled = false
                          return
                        end

                        if descendant:IsA("Beam") then
                          descendant.Enabled = false
                          return
                        end
                      end)
                    end
                  end)

                  if _G.FPSBConn then
                    pcall(function()
                      _G.FPSBConn:Disconnect()
                    end)
                  end

                  _G.FPSBConn = workspace.DescendantAdded:Connect(function(descendant)
                    task.defer(fn32, descendant)
                  end)
                end
              end

              shared.BananaEnemyWeaponCleanupVersion = (shared.BananaEnemyWeaponCleanupVersion or 0) + 1

              setmetatable(ScriptStorage.Enemies, {__index = function(arg, arg2)
                local v16 = Services.Workspace.Enemies:FindFirstChild(arg2)
                if v16 then
                  return v16
                end
                return (Services.ReplicatedStorage:FindFirstChild(arg2))
              end})

              setmetatable(ScriptStorage.Map, {__index = function(arg, arg2)
                local v16 = Services.Workspace.Map:FindFirstChild(arg2)
                if v16 then
                  return v16
                end
                return (Services.Workspace:FindFirstChild(arg2))
              end})

              setmetatable(ScriptStorage.Tools, {__index = function(arg, arg2)
                local character = LocalPlayer.Character
                local backpack = LocalPlayer:FindFirstChild("Backpack")

                if character then
                  local v16 = character:FindFirstChild(arg2)
                  if v16 then
                    return v16
                  end
                end

                if backpack then
                  return (backpack:FindFirstChild(arg2))
                end
                return backpack
              end})

              MeleeDataFile = "MosHubKaitun" .. ("/" .. (tostring(LocalPlayer.Name) .. "MeleeData"))

              setmetatable(ScriptStorage.NPCs, {__index = function(arg, arg2)
                local npCs, v16, v17

                if workspace:FindFirstChild("NPCs") then
                  npCs = workspace.NPCs:FindFirstChild(arg2, true)

                  if npCs then
                    if not npCs then
                      v16 = workspace

                      if v16:FindFirstChild("Map") then
                        npCs = workspace.Map:FindFirstChild(arg2, true)
                        if npCs then
                          return npCs
                        end
                      end

                      v17 = workspace
                      return (v17:FindFirstChild(arg2, true))
                    end
                  else
                    npCs = game.ReplicatedStorage:FindFirstChild("NPCs")

                    if npCs then
                      npCs = game.ReplicatedStorage.NPCs:FindFirstChild(arg2, true)

                      if not npCs then
                        v16 = workspace

                        if v16:FindFirstChild("Map") then
                          npCs = workspace.Map:FindFirstChild(arg2, true)
                          if npCs then
                            return npCs
                          end
                        end

                        v17 = workspace
                        return (v17:FindFirstChild(arg2, true))
                      end
                    elseif not npCs then
                      v16 = workspace

                      if v16:FindFirstChild("Map") then
                        npCs = workspace.Map:FindFirstChild(arg2, true)
                        if npCs then
                          return npCs
                        end
                      end

                      v17 = workspace
                      return (v17:FindFirstChild(arg2, true))
                    end
                  end
                else
                  npCs = game.ReplicatedStorage:FindFirstChild("NPCs")

                  if npCs then
                    npCs = game.ReplicatedStorage.NPCs:FindFirstChild(arg2, true)

                    if not npCs then
                      v16 = workspace

                      if v16:FindFirstChild("Map") then
                        npCs = workspace.Map:FindFirstChild(arg2, true)
                        if npCs then
                          return npCs
                        end
                      end

                      v17 = workspace
                      return (v17:FindFirstChild(arg2, true))
                    end
                  elseif not npCs then
                    if workspace:FindFirstChild("Map") then
                      npCs = workspace.Map:FindFirstChild(arg2, true)
                      if npCs then
                        return npCs
                      end
                    end

                    return (workspace:FindFirstChild(arg2, true))
                  end
                end

                return npCs
              end})

              local function fn30(arg, arg2)
                local v16 = DispTime
                table.insert(ScriptStorage.Tracebacks, GetCurrentDateTime() .. (" ( " .. (v16(os.time() - now3, true) .. (" ) after execution | " .. (arg .. (" | " .. arg2))))))
                if #ScriptStorage.Tracebacks > 30 then
                  table.remove(ScriptStorage.Tracebacks, 1)
                  return
                end
              end

              CreateTraceback = fn30

              task.spawn(function()
                while task.wait(60) do
                  if not _G.Stop then
                    pcall(function()
                      local debris = workspace:FindFirstChild("Debris")

                      if debris then
                        for _, child in ipairs(debris:GetChildren()) do
                          pcall(function()
                            child:Destroy()
                          end)
                        end
                      end

                      local cutParts = workspace:FindFirstChild("CutParts")

                      if cutParts then
                        for _, child in ipairs(cutParts:GetChildren()) do
                          pcall(function()
                            child:Destroy()
                          end)
                        end
                      end

                      for _, child in ipairs(workspace:GetChildren()) do
                        if child:IsA("ParticleEmitter") then
                          pcall(function()
                            child:Destroy()
                          end)
                        elseif child:IsA("Beam") then
                          pcall(function()
                            child:Destroy()
                          end)
                        elseif child:IsA("Trail") then
                          pcall(function()
                            child:Destroy()
                          end)
                        elseif child:IsA("Explosion") then
                          pcall(function()
                            child:Destroy()
                          end)
                        end
                      end
                    end)

                    if ScriptStorage then
                      if ScriptStorage.Tracebacks then
                        if #ScriptStorage.Tracebacks > 30 then
                          while #ScriptStorage.Tracebacks > 20 do
                            table.remove(ScriptStorage.Tracebacks, 1)
                          end
                        end
                      end
                    end

                    continue
                  end

                  break
                end
              end)

              SetTask = function(arg, arg2)
                if arg2 ~= nil then
                  if ScriptStorage.Task[arg] ~= tostring(arg2) then
                    ScriptStorage.Task[arg] = tostring(arg2)
                    return
                  end
                  return
                end
              end

              Remotes = {}

              setmetatable(Remotes, {__index = function(arg, arg2)
                if arg2 ~= "CommF_" then
                  return Services.ReplicatedStorage.Remotes[arg2]
                end

                return {InvokeServer = function(...)
                  return Services.ReplicatedStorage.Remotes.CommF_:InvokeServer(select(2, ...))
                end}
              end})

              Tasks = {}

              AwaitUntilPlayerLoaded = function(arg)
                repeat
                  task.wait()
                until arg.Character

                arg.Character:WaitForChild("Humanoid")

                repeat
                  task.wait()
                until arg.Character.Humanoid.Health > 0
              end

              AddPoint = function()
                if LocalPlayer:FindFirstChild("Data") then
                  local points = LocalPlayer.Data:FindFirstChild("Points")

                  if points then
                    local num = tonumber(points.Value)

                    if num then
                      if num <= 0 then
                        return
                      end
                      local stats = LocalPlayer.Data:FindFirstChild("Stats")

                      if stats then
                        local tbl9 = {Defense = 0, Melee = 0, Sword = 0}

                        for _, v16 in stats:GetChildren() do
                          if v16:FindFirstChild("Level") then
                            tbl9[v16.Name] = v16.Level.Value
                          end
                        end

                        local level = ScriptStorage.PlayerData.Level

                        if not level then
                          if LocalPlayer.Data:FindFirstChild("Level") then
                            level = LocalPlayer.Data.Level.Value or 0
                          else
                            level = 0
                          end
                        end

                        local str4, n6, fn31

                        if tbl9.Defense < MaxLevel then
                          if tbl9.Defense < (level / 80) then
                            str4 = "Defense"
                          elseif (MaxLevel - tbl9.Melee) < 100 then
                            str4 = "Defense"

                            fn31 = function()
                              Remotes.CommF_:InvokeServer("AddPoint", str4, num)
                            end

                            pcall(fn31)
                            return
                          elseif tbl9.Melee < MaxLevel then
                            str4 = "Melee"
                          else
                            str4 = "Sword"
                          end
                        elseif tbl9.Melee < MaxLevel then
                          str4 = "Melee"
                        else
                          str4 = "Sword"
                        end

                        fn31 = function()
                          Remotes.CommF_:InvokeServer("AddPoint", str4, num)
                        end

                        pcall(fn31)
                        return
                      end

                      return
                    end
                  end
                end
              end

              GetLiveLevel = function()
                local ok, result = pcall(function()
                  return LocalPlayer.Data.Level.Value
                end)

                if ok then
                  if tonumber(result) then
                    return result
                  end
                end

                local level = ScriptStorage.PlayerData.Level
                if level then
                  return level
                end
                return 0
              end

              RefreshPlayerData = function()
                local data = LocalPlayer:FindFirstChild("Data")

                if data then
                  for _, v16 in data:GetChildren() do
                    pcall(function()
                      ScriptStorage.PlayerData[v16.Name] = v16.Value
                    end)
                  end

                  ScriptStorage.PlayerData.Level = GetLiveLevel()
                  return
                end
              end

              local function fn31(arg)
                if arg then
                  if arg:IsA("ValueBase") then
                    ScriptStorage.PlayerData[arg.Name] = arg.Value

                    if ScriptStorage.Interface then
                      if ScriptStorage.Interface.SyncRuntimeUI then
                        pcall(ScriptStorage.Interface.SyncRuntimeUI)
                        return
                      end
                    end

                    return
                  end

                  return
                end
              end

              fn22 = function(child)
                if child then
                  if child:IsA("ValueBase") then
                    fn31(child)
                    local str4 = "Data_" .. child.Name

                    if ScriptStorage.Connections.LocalPlayer[str4] then
                      pcall(function()
                        ScriptStorage.Connections.LocalPlayer[str4]:Disconnect()
                      end)
                    end

                    ScriptStorage.Connections.LocalPlayer[str4] = child.Changed:Connect(function()
                      fn31(child)
                    end)

                    return
                  end
                end
              end

              local function fn32()
                ScriptStorage.PlayerData.RaceLevel = 1
                if LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                  ScriptStorage.PlayerData.RaceLevel = 4
                  return
                end
              end

              RefreshRace = fn32
              local ReplicatedStorage = game:GetService("ReplicatedStorage")

              if pcall(function()
                return require(ReplicatedStorage.ItemReplicationService)
              end) then
                ItemReplicationService = require(ReplicatedStorage.ItemReplicationService) or nil
              else
                ItemReplicationService = nil
              end

              local ItemId

              if pcall(function()
                return require(ReplicatedStorage.Economy.ItemId)
              end) then
                ItemId = require(ReplicatedStorage.Economy.ItemId) or nil
              else
                ItemId = nil
              end

              local tbl9 = {}
              local n6 = 0

              fn23 = function(arg)
                if arg then
                  if (os.clock() - n6) > 300 then
                    pcall(function()
                      local response = Remotes.CommF_:InvokeServer("GetFruits")
                      if type(response) ~= "table" then
                        return
                      end

                      for _, v16 in ipairs(response) do
                        if v16 then
                          if v16.Name then
                            if v16.Price then
                              tbl9[v16.Name] = v16.Price
                              local v17 = string.gsub(v16.Name, "%-.*", "")
                              tbl9[v17] = v16.Price
                              tbl9[v17 .. " Fruit"] = v16.Price
                            end
                          end
                        end
                      end

                      n6 = os.clock()
                    end)
                  elseif not next(tbl9) then
                    pcall(function()
                      local response = Remotes.CommF_:InvokeServer("GetFruits")
                      if type(response) ~= "table" then
                        return
                      end

                      for _, v16 in ipairs(response) do
                        if v16 then
                          if v16.Name then
                            if v16.Price then
                              tbl9[v16.Name] = v16.Price
                              local v17 = string.gsub(v16.Name, "%-.*", "")
                              tbl9[v17] = v16.Price
                              tbl9[v17 .. " Fruit"] = v16.Price
                            end
                          end
                        end
                      end

                      n6 = os.clock()
                    end)
                  end

                  local str4 = tostring(arg)
                  if tbl9[str4] then
                    return tbl9[str4]
                  end
                  local v16 = tbl9[string.gsub(string.gsub(str4, " Fruit", ""), "%-.*", "")]

                  if not v16 then
                    v16 = tbl9[str4]
                    if not v16 then
                      return 0
                    end
                  end

                  return v16
                end

                return 0
              end

              local function fn33()
                local backpack = {}

                if not ItemId then
                  pcall(function()
                    ItemId = require(ReplicatedStorage.Economy.ItemId)
                  end)
                end

                if not ItemReplicationService then

                  local function fn34()
                    ItemReplicationService = require(ReplicatedStorage.ItemReplicationService)
                  end

                  pcall(fn34)
                end

                if ItemId then
                  if ItemReplicationService then
                    local ok, result = pcall(function()
                      return ItemId._IDS:unwrap()
                    end)

                    if ok then
                      if type(result) == "table" then
                        local n7, storageKey, v16

                        for _, v17 in ipairs(result) do
                          local id = v17 and v17.Id
                          local v18, type_, n8, tbl10, v19, flag6

                          if not ((type(id) ~= "table") or not id.ItemId) then
                            n7 = tonumber(ItemReplicationService:ReadItem(ItemReplicationService.KEYS.QUANTITY, id.ItemId)) or 0

                            if ItemReplicationService:ReadItem(ItemReplicationService.KEYS.IS_OWNED, id.ItemId) == true then
                              storageKey = (id.StorageKey or v17.Name) or tostring(id.ItemId)
                              v18 = tostring
                              type_ = id.Type or "Material"
                              v16 = v18(type_)

                              if v16 ~= "PhysicalMoveset" then
                                n8 = n7
                              else
                                n8 = fn23(storageKey)
                                flag6 = n8 > 0

                                if flag6 then
                                  n8 = n8 or 1
                                else
                                  n8 = 1
                                end
                              end

                              tbl10 = {Name = storageKey, Count = n7, Value = n8, Amount = n7, Type = v16, ItemId = id.ItemId}
                              backpack[storageKey] = tbl10

                              if v16 ~= "PhysicalMoveset" then
                              elseif FruitIdToName then
                                if pcall(FruitIdToName, storageKey) then
                                  v19 = FruitIdToName(storageKey)

                                  if v19 then
                                    if v19 ~= storageKey then
                                      backpack[v19] = tbl10
                                    end
                                  end
                                end
                              end
                            elseif (n7 > 0) or (n7 > 0) then
                              storageKey = (id.StorageKey or v17.Name) or tostring(id.ItemId)
                              v18 = tostring
                              type_ = id.Type or "Material"
                              v16 = v18(type_)

                              if v16 ~= "PhysicalMoveset" then
                                n8 = n7
                                tbl10 = {Name = storageKey, Count = n7, Value = n8, Amount = n7, Type = v16, ItemId = id.ItemId}
                                backpack[storageKey] = tbl10

                                if not ((v16 ~= "PhysicalMoveset") or not (FruitIdToName and pcall(FruitIdToName, storageKey))) then
                                  v19 = FruitIdToName(storageKey)

                                  if v19 then
                                    if v19 ~= storageKey then
                                      backpack[v19] = tbl10
                                    end
                                  end
                                end
                              else
                                n8 = fn23(storageKey)
                                flag6 = n8 > 0

                                if flag6 then
                                  if n8 then
                                    tbl10 = {Name = storageKey, Count = n7, Value = n8, Amount = n7, Type = v16, ItemId = id.ItemId}
                                    backpack[storageKey] = tbl10

                                    if not ((v16 ~= "PhysicalMoveset") or not (FruitIdToName and pcall(FruitIdToName, storageKey))) then
                                      v19 = FruitIdToName(storageKey)

                                      if v19 then
                                        if v19 ~= storageKey then
                                          backpack[v19] = tbl10
                                        end
                                      end
                                    end
                                  else
                                    break
                                  end
                                else
                                  n8 = 1
                                  tbl10 = {Name = storageKey, Count = n7, Value = n8, Amount = n7, Type = v16, ItemId = id.ItemId}
                                  backpack[storageKey] = tbl10

                                  if not ((v16 ~= "PhysicalMoveset") or not (FruitIdToName and pcall(FruitIdToName, storageKey))) then
                                    v19 = FruitIdToName(storageKey)

                                    if v19 then
                                      if v19 ~= storageKey then
                                        backpack[v19] = tbl10
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end

                pcall(function()
                  local response = Remotes.CommF_:InvokeServer("getInventoryWeapons")
                  if type(response) ~= "table" then
                    return
                  end

                  for _, v16 in ipairs(response) do
                    if v16 then
                      if v16.Name then
                        local name2 = v16.Name
                        local tbl10 = backpack[v16.Name]

                        if not tbl10 then
                          tbl10 = {Name = v16.Name, Count = 1, Value = 1, Amount = 1, Type = v16.Type or "Weapon", Rarity = v16.Rarity or 1}
                        end

                        backpack[name2] = tbl10
                      end
                    end
                  end
                end)

                pcall(function()
                  local response = Remotes.CommF_:InvokeServer("getInventoryFruits")
                  if type(response) ~= "table" then
                    return
                  end

                  for _, v16 in ipairs(response) do
                    if v16 then
                      if v16.Name then
                        local price = (v16.Price or fn23(v16.Name)) or 1
                        local tbl10 = {Name = v16.Name, Count = v16.Count or 1, Value = price, Amount = v16.Count or 1, Type = "Blox Fruit", Price = price, Rarity = v16.Rarity or 1}
                        backpack[v16.Name] = backpack[v16.Name] or tbl10
                        local str4 = v16.Name:gsub("%-.*", "")
                        backpack[str4 .. " Fruit"] = backpack[str4 .. " Fruit"] or tbl10
                        backpack[str4] = backpack[str4] or tbl10
                      end
                    end
                  end
                end)

                if LocalPlayer then
                  if LocalPlayer:FindFirstChild("Backpack") then
                    for _, child in ipairs(LocalPlayer.Backpack:GetChildren()) do
                      backpack[child.Name] = backpack[child.Name] or {Name = child.Name, Count = 1, Value = 1, Amount = 1, Type = child.ClassName}
                    end
                  end
                end

                if LocalPlayer then
                  if LocalPlayer.Character then
                    for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
                      if child:IsA("Tool") then
                        backpack[child.Name] = backpack[child.Name] or {Name = child.Name, Count = 1, Value = 1, Amount = 1, Type = child.ClassName}
                      end
                    end
                  end
                end

                pcall(function()
                  local response = Remotes.CommF_:InvokeServer("getInventory")
                  if type(response) ~= "table" then
                    return
                  end

                  for _, v16 in ipairs(response) do
                    if v16 then
                      if v16.Name then
                        backpack[v16.Name] = backpack[v16.Name] or v16
                      end
                    end
                  end
                end)

                ScriptStorage.Backpack = backpack
              end

              RefreshInventory = fn33

              ResearchMoves = function(arg)
                if arg then
                  if tostring(arg) == "V" then
                    if ScriptStorage.Connections.BurstCheck then
                      ScriptStorage.Connections.BurstCheck:Disconnect()
                      task.wait(1)
                    end

                    ScriptStorage.Connections.BurstCheck = arg.Cooldown:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                      if EnablingBurstDebounce then
                        local v16 = EnablingBurstDebounce
                        if (os.time() - v16) < 10 then
                          return
                        end
                      end

                      if arg.Cooldown.AbsoluteSize.X < 3 then
                        EnablingBurstDebounce = os.time()
                        task.wait(5)
                        SendKey("V", 0)
                        return
                      end
                    end)

                    return
                  end
                end
              end

              CheckMeleeBurstMove = function(arg)
                if arg.Name ~= "Black Leg" then
                  if arg.Name ~= "Death Step" then
                    return
                  end
                end

                ResearchMoves(PlayerGui.Main.Skills:WaitForChild(arg.Name, 9):WaitForChild("V"))
              end

              local function fn34(arg)
                if ItemId then
                  local ok, result = pcall(function()
                    return ItemId.getId(arg, "NonFruitItem"):unwrap()
                  end)

                  if ok then
                    if result then
                      return result
                    end
                  end

                  return nil
                end

                return nil
              end

              local function fn35(arg)
                if ItemReplicationService then
                  local v16 = fn34(arg)

                  if v16 then
                    local n7 = tonumber(ItemReplicationService:ReadItem(ItemReplicationService.KEYS.MASTERY, v16)) or 0
                    local flag6 = ItemReplicationService:ReadItem(ItemReplicationService.KEYS.IS_OWNED, v16) == true
                    if flag6 then
                      return n7, flag6, v16
                    end
                    return n7, n7 > 0, v16
                  end

                  return 0, false
                end

                return 0, false
              end

              RefreshMelees = function(arg)
                if ApplyMeleeDerivedProgress then
                  pcall(ApplyMeleeDerivedProgress)
                end

                local str4 = ""

                for k, melee in pairs(ScriptStorage.Melees) do
                  if ScriptStorage.MeleesOwned[k] then
                    str4 ..= k .. (": " .. (melee .. " "))
                  else
                    local num = tonumber(melee)

                    if num then
                      if num > 0 then
                        str4 ..= k .. (": " .. (melee .. " "))
                      end
                    end
                  end
                end

                if str4 == "" then
                  str4 = "[0]"
                end

                if arg then
                  return str4
                end
              end

              LoadMeleeData = function()
                if MeleesTable then
                  for _, v16 in ipairs(MeleesTable) do
                    local v17, v18 = fn35(v16)

                    if v18 or (v17 > 0) then
                      local v19 = (NormalizeMeleeName and NormalizeMeleeName(v16)) or v16
                      ScriptStorage.Melees[v19] = math.max(tonumber(ScriptStorage.Melees[v19]) or 0, v17)
                      ScriptStorage.MeleesOwned[v19] = true
                    end
                  end
                end
              end

              MeleeNameAliases = {["Dark Step"] = "Black Leg", ["Water Kung Fu"] = "Fishman Karate", ["Water Kung-fu"] = "Fishman Karate", Electric = "Electro", ["Dragon Breath"] = "Dragon Claw"}

              NormalizeMeleeName = function(arg)
                local str4 = tostring(arg or "")
                local v16 = MeleeNameAliases[str4]
                if v16 then
                  return v16
                end
                return str4
              end

              MeleeDerivedProgress = {["Death Step"] = {{"Black Leg", 400}}, ["Electric Claw"] = {{"Electro", 400}}, ["Sharkman Karate"] = {{"Fishman Karate", 400}}, ["Dragon Talon"] = {{"Dragon Claw", 400}}, Godhuman = {{"Black Leg", 400}, {"Electro", 400}, {"Fishman Karate", 400}, {"Dragon Claw", 400}, {"Superhuman", 400}, {"Death Step", 400}, {"Electric Claw", 400}, {"Sharkman Karate", 400}, {"Dragon Talon", 400}}}

              ApplyMeleeDerivedProgress = function()
                for k, melee in pairs(ScriptStorage.Melees) do
                  if tonumber(melee) then
                    if tonumber(melee) > 0 then
                      ScriptStorage.MeleesOwned[k] = true
                    end
                  end
                end

                for k, v16 in pairs(MeleeDerivedProgress) do
                  local num = tonumber(ScriptStorage.Melees[k])

                  if num and (num > 0) then
                    ScriptStorage.MeleesOwned[k] = true

                    for _, v17 in ipairs(v16) do
                      local v18 = v17[1]
                      local v19 = v17[2]
                      local num2 = tonumber(ScriptStorage.Melees[v18])

                      if num2 then
                        if num2 < v19 then
                          ScriptStorage.Melees[v18] = v19
                        end
                      elseif v19 > 0 then
                        ScriptStorage.Melees[v18] = v19
                      end

                      ScriptStorage.MeleesOwned[v18] = true
                    end
                  else
                    continue
                  end

                  break
                end
              end

              MeleeCheck = function(arg)
                local v16, v17, level, melees, n7
                v16 = arg

                if v16 and ((typeof(v16) == "Instance") and v16:IsA("Tool")) then
                  if v16.ToolTip ~= "Melee" then
                    if string.find(tostring(v16), "Fruit") then
                      task.spawn(function()
                        local ignoreStoreFruits = ScriptStorage.IgnoreStoreFruits
                        if table.find(ignoreStoreFruits, v16:GetAttribute("OriginalName")) then
                          return
                        end
                        Remotes.CommF_:InvokeServer("StoreFruit", v16:GetAttribute("OriginalName"), v16)
                      end)
                    end
                  else
                    if ScriptStorage.Connections.Melees then
                      ScriptStorage.Connections.Melees:Disconnect()
                    end

                    v17 = NormalizeMeleeName(v16.Name)
                    ScriptStorage.CurrentMeleeData.Name = v17

                    pcall(function()
                      ScriptStorage.Connections.Melees:Destroy()
                    end)

                    level = v16:FindFirstChild("Level")

                    if not level then
                      if LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild(v16.Name) then
                        level = LocalPlayer.Backpack[v16.Name]:FindFirstChild("Level")

                        if not level then
                          level = LocalPlayer.Character

                          if level then
                            level = LocalPlayer.Character:FindFirstChild(v16.Name)

                            if level then
                              level = LocalPlayer.Character[v16.Name]:FindFirstChild("Level")

                              if level then
                                if level:IsA("ValueBase") then
                                  local function fn36(arg2)
                                    ScriptStorage.Melees[v17] = arg2
                                    ScriptStorage.MeleesOwned[v17] = true
                                    RefreshMelees()

                                    if ScriptStorage.Interface then
                                      if ScriptStorage.Interface.SyncRuntimeUI then
                                        pcall(ScriptStorage.Interface.SyncRuntimeUI)
                                        return
                                      end
                                    end
                                  end

                                  ScriptStorage.Connections.Melees = level.Changed:Connect(fn36)
                                  ScriptStorage.Melees[v17] = level.Value
                                  ScriptStorage.MeleesOwned[v17] = true
                                  RefreshMelees()

                                  if ScriptStorage.Interface then
                                    if ScriptStorage.Interface.SyncRuntimeUI then
                                      pcall(ScriptStorage.Interface.SyncRuntimeUI)
                                    end
                                  end

                                  return
                                end
                              end

                              melees = ScriptStorage.Melees
                              n7 = ScriptStorage.Melees[v17]

                              if not n7 then
                                n7 = 0
                              end

                              melees[v17] = n7
                              ScriptStorage.MeleesOwned[v17] = true
                              RefreshMelees()

                              if ScriptStorage.Interface then
                                if ScriptStorage.Interface.SyncRuntimeUI then
                                  pcall(ScriptStorage.Interface.SyncRuntimeUI)
                                end
                              end

                              return
                            end
                          end
                        end
                      else
                        level = LocalPlayer.Character

                        if level then
                          level = LocalPlayer.Character:FindFirstChild(v16.Name)

                          if level then
                            level = LocalPlayer.Character[v16.Name]:FindFirstChild("Level")

                            if level then
                              if level:IsA("ValueBase") then
                                local function fn36(arg2)
                                  ScriptStorage.Melees[v17] = arg2
                                  ScriptStorage.MeleesOwned[v17] = true
                                  RefreshMelees()

                                  if ScriptStorage.Interface then
                                    if ScriptStorage.Interface.SyncRuntimeUI then
                                      pcall(ScriptStorage.Interface.SyncRuntimeUI)
                                      return
                                    end
                                  end
                                end

                                ScriptStorage.Connections.Melees = level.Changed:Connect(fn36)
                                ScriptStorage.Melees[v17] = level.Value
                                ScriptStorage.MeleesOwned[v17] = true
                                RefreshMelees()

                                if ScriptStorage.Interface then
                                  if ScriptStorage.Interface.SyncRuntimeUI then
                                    pcall(ScriptStorage.Interface.SyncRuntimeUI)
                                  end
                                end

                                return
                              end
                            end

                            melees = ScriptStorage.Melees
                            n7 = ScriptStorage.Melees[v17]

                            if not n7 then
                              n7 = 0
                            end

                            melees[v17] = n7
                            ScriptStorage.MeleesOwned[v17] = true
                            RefreshMelees()

                            if ScriptStorage.Interface then
                              if ScriptStorage.Interface.SyncRuntimeUI then
                                pcall(ScriptStorage.Interface.SyncRuntimeUI)
                              end
                            end

                            return
                          end
                        end
                      end
                    end

                    if level then
                      if level:IsA("ValueBase") then
                        local function fn36(arg2)
                          ScriptStorage.Melees[v17] = arg2
                          ScriptStorage.MeleesOwned[v17] = true
                          RefreshMelees()

                          if ScriptStorage.Interface then
                            if ScriptStorage.Interface.SyncRuntimeUI then
                              pcall(ScriptStorage.Interface.SyncRuntimeUI)
                              return
                            end
                          end
                        end

                        ScriptStorage.Connections.Melees = level.Changed:Connect(fn36)
                        ScriptStorage.Melees[v17] = level.Value
                        ScriptStorage.MeleesOwned[v17] = true
                        RefreshMelees()

                        if ScriptStorage.Interface then
                          if ScriptStorage.Interface.SyncRuntimeUI then
                            pcall(ScriptStorage.Interface.SyncRuntimeUI)
                          end
                        end

                        return
                      end
                    end

                    melees = ScriptStorage.Melees
                    n7 = ScriptStorage.Melees[v17]

                    if not n7 then
                      n7 = 0
                    end

                    melees[v17] = n7
                    ScriptStorage.MeleesOwned[v17] = true
                    RefreshMelees()

                    if ScriptStorage.Interface then
                      if ScriptStorage.Interface.SyncRuntimeUI then
                        pcall(ScriptStorage.Interface.SyncRuntimeUI)
                      end
                    end
                  end
                end

                return
              end

              SyncLiveMeleeTools = function()
                local tbl10 = {LocalPlayer.Character, LocalPlayer.Backpack}
                local flag6 = false
                local flag7 = false

                for _, v16 in ipairs(tbl10) do
                  if v16 then
                    for _, child in ipairs(v16:GetChildren()) do
                      if child:IsA("Tool") then
                        if child.ToolTip == "Melee" then
                          local v17 = NormalizeMeleeName(child.Name)
                          local level = child:FindFirstChild("Level")
                          local n7

                          if level then
                            n7 = (tonumber(level.Value) or tonumber(ScriptStorage.Melees[v17])) or 0
                          else
                            n7 = tonumber(ScriptStorage.Melees[v17]) or 0
                          end

                          if (tonumber(ScriptStorage.Melees[v17]) or 0) ~= n7 then
                            ScriptStorage.Melees[v17] = n7
                            ScriptStorage.MeleesOwned[v17] = true
                            flag7 = true
                          elseif not ScriptStorage.MeleesOwned[v17] then
                            ScriptStorage.Melees[v17] = n7
                            ScriptStorage.MeleesOwned[v17] = true
                            flag7 = true
                          end
                        end
                      end
                    end

                    flag6 = true
                  end
                end

                if MeleesTable then
                  local v16

                  for _, v17 in ipairs(MeleesTable) do
                    local v18, v19 = fn35(v17)

                    if not v19 then
                      local n7, melees, max, n8

                      if v18 > 0 then
                        if NormalizeMeleeName then
                          v16 = NormalizeMeleeName(v17)

                          if v16 then
                            n7 = tonumber(ScriptStorage.Melees[v16]) or 0

                            if (n7 < v18) or not ScriptStorage.MeleesOwned[v16] then
                              melees = ScriptStorage.Melees
                              max = math.max
                              n8 = tonumber(ScriptStorage.Melees[v16]) or 0
                              melees[v16] = max(n8, v18)
                              ScriptStorage.MeleesOwned[v16] = true
                              flag7 = true
                            end
                          else
                            v16 = v17
                            n7 = tonumber(ScriptStorage.Melees[v16]) or 0

                            if (n7 < v18) or not ScriptStorage.MeleesOwned[v16] then
                              melees = ScriptStorage.Melees
                              max = math.max
                              n8 = tonumber(ScriptStorage.Melees[v16]) or 0
                              melees[v16] = max(n8, v18)
                              ScriptStorage.MeleesOwned[v16] = true
                              flag7 = true
                            end
                          end
                        else
                          v16 = v17
                          n7 = tonumber(ScriptStorage.Melees[v16]) or 0

                          if (n7 < v18) or not ScriptStorage.MeleesOwned[v16] then
                            melees = ScriptStorage.Melees
                            max = math.max
                            n8 = tonumber(ScriptStorage.Melees[v16]) or 0
                            melees[v16] = max(n8, v18)
                            ScriptStorage.MeleesOwned[v16] = true
                            flag7 = true
                          end
                        end
                      end
                    end
                  end

                  if flag6 then
                    ScriptStorage.MeleesLiveScanDone = true

                    if flag7 then
                      pcall(ApplyMeleeDerivedProgress)

                      if MeleeBuyRefreshCache then
                        MeleeBuyRefreshCache.CheckedAt = 0
                        MeleeBuyRefreshCache.Result = nil
                      end

                      RefreshMelees()

                      if ScriptStorage.Interface then
                        if ScriptStorage.Interface.SyncRuntimeUI then
                          pcall(ScriptStorage.Interface.SyncRuntimeUI)
                          return flag7
                        end
                      end
                    end
                  elseif flag7 then
                    pcall(ApplyMeleeDerivedProgress)

                    if MeleeBuyRefreshCache then
                      MeleeBuyRefreshCache.CheckedAt = 0
                      MeleeBuyRefreshCache.Result = nil
                    end

                    RefreshMelees()

                    if ScriptStorage.Interface then
                      if ScriptStorage.Interface.SyncRuntimeUI then
                        pcall(ScriptStorage.Interface.SyncRuntimeUI)
                        return flag7
                      end
                    end
                  end
                elseif flag6 then
                  ScriptStorage.MeleesLiveScanDone = true

                  if flag7 then
                    pcall(ApplyMeleeDerivedProgress)

                    if MeleeBuyRefreshCache then
                      MeleeBuyRefreshCache.CheckedAt = 0
                      MeleeBuyRefreshCache.Result = nil
                    end

                    RefreshMelees()

                    if ScriptStorage.Interface then
                      if ScriptStorage.Interface.SyncRuntimeUI then
                        pcall(ScriptStorage.Interface.SyncRuntimeUI)
                        return flag7
                      end
                    end
                  end
                elseif flag7 then
                  pcall(ApplyMeleeDerivedProgress)

                  if MeleeBuyRefreshCache then
                    MeleeBuyRefreshCache.CheckedAt = 0
                    MeleeBuyRefreshCache.Result = nil
                  end

                  RefreshMelees()

                  if ScriptStorage.Interface then
                    if ScriptStorage.Interface.SyncRuntimeUI then
                      pcall(ScriptStorage.Interface.SyncRuntimeUI)
                      return flag7
                    end
                  end
                end

                return flag7
              end

              LoadMeleeData()
              RefreshMelees()
              SetTask("MainTask", "Refreshing Player Data")
              MeleeCheck(LocalPlayer.Character:FindFirstChildOfClass("Tool"))
              SyncLiveMeleeTools()
              RefreshPlayerData()

              RegisterLocalPlayerEventsConnection = function()
                for _, v16 in ipairs(LocalPlayerEventsConnections or {}) do
                  pcall(function()
                    v16:Disconnect()
                  end)
                end

                AwaitUntilPlayerLoaded(LocalPlayer)
                LocalPlayer:SetAttribute("IsAvailable", true)
                local data = LocalPlayer:FindFirstChild("Data")

                if data then
                  for _, v16 in data:GetChildren() do
                    fn22(v16)
                  end

                  ScriptStorage.Connections.LocalPlayer.DataChildAdded = data.ChildAdded:Connect(fn22)
                end

                local function fn36()
                  local health = LocalPlayer.Character.Humanoid.Health
                  LocalPlayer:SetAttribute("IsAvailable", health > 10)
                  ScriptStorage.LocalPlayerHealth = health
                end

                ScriptStorage.Connections.LocalPlayer.HealthCheck = LocalPlayer.Character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(fn36)
                ScriptStorage.Connections.LocalPlayer.Melee = LocalPlayer.Character.ChildAdded:Connect(MeleeCheck)
                ScriptStorage.Connections.LocalPlayer.Fruit = LocalPlayer.Backpack.ChildAdded:Connect(MeleeCheck)

                local function fn37(arg, arg2)
                  MeleeCheck(arg2)
                end

                table.foreach(LocalPlayer.Backpack:GetChildren(), fn37)
                LastIdleCheck = os.time()

                ScriptStorage.Connections.LocalPlayer.PositionChecker = LocalPlayer.Character.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
                  local v16 = LastIdleCheck

                  if os.time() ~= v16 then
                    LastIdleCheck = os.time()

                    if oldPos then
                      if (LocalPlayer.Character.HumanoidRootPart.CFrame.p - oldPos).magnitude < 2 then
                        return
                      end
                    end

                    oldPos = LocalPlayer.Character.HumanoidRootPart.CFrame.p
                    lastIdleTick = os.time()
                    return
                  end
                end)

                local points = LocalPlayer.Data:WaitForChild("Points")

                local function fn38()
                  local value = points.Value

                  if OldPointValue ~= value then
                    if value <= 0 then
                      return
                    end
                    OldPointValue = value
                    AddPoint()
                    return
                  end
                end

                ScriptStorage.Connections.LocalPlayer.PointConnection = points:GetPropertyChangedSignal("Value"):Connect(fn38)
              end

              RegisterLocalPlayerEventsConnection(LocalPlayer)

              game.Players.LocalPlayer.CharacterAdded:Connect(function()
                RegisterLocalPlayerEventsConnection(LocalPlayer)
              end)

              task.spawn(function()
                while true do
                  local character = LocalPlayer.Character

                  if character then
                    if not character:FindFirstChild("HasBuso") then
                      pcall(function()
                        Remotes.CommF_:InvokeServer("Buso")
                      end)
                    end
                  end

                  task.wait(2)
                end
              end)

              submergedWaitTick = 0
              canUseBypass = false

              checkBypassCond = function()
                submergedWaitTick = 0
                canUseBypass = false
              end

              HasLightningBolt = function(arg)
                if ScriptStorage then
                  if ScriptStorage.Backpack then
                    if ScriptStorage.Backpack["Lightning Bolt"] then
                      return true
                    end

                    if ScriptStorage.Backpack["Material-1588"] then
                      return true
                    end
                  end
                end

                if ScriptStorage then
                  if ScriptStorage.Tools then
                    if ScriptStorage.Tools["Lightning Bolt"] then
                      return true
                    end
                  end
                end

                if LocalPlayer then
                  if LocalPlayer:FindFirstChild("Backpack") then
                    if LocalPlayer.Backpack:FindFirstChild("Lightning Bolt") then
                      return true
                    end
                  end
                end

                if LocalPlayer then
                  if LocalPlayer.Character then
                    if LocalPlayer.Character:FindFirstChild("Lightning Bolt") then
                      return true
                    end
                  end
                end

                if ItemReplicationService then
                  local ok, result = pcall(function()
                    return ItemReplicationService:ReadItem(ItemReplicationService.KEYS.QUANTITY, 1588)
                  end)

                  if ok then
                    if tonumber(result) then
                      if tonumber(result) > 0 then
                        return true
                      end
                    end
                  end

                  local ok2, result2 = pcall(function()
                    return ItemReplicationService:ReadItem(ItemReplicationService.KEYS.IS_OWNED, 1588)
                  end)

                  if ok2 then
                    if result2 == true then
                      return true
                    end
                  end
                end

                local n7, fn36, ok, result

                if canUseBypass then
                  if not arg then
                    return true
                  end

                  if (os.clock() - submergedWaitTick) >= 0.5 then
                    submergedWaitTick = os.clock()

                    fn36 = function()
                      return Remotes.CommF_:InvokeServer("ElectroQuestState")
                    end

                    ok, result = pcall(fn36)
                    ok = ok and (((result == 2) or (result == 3)) or (result == 4))
                    canUseBypass = ok
                  end
                elseif arg then
                  if (os.clock() - submergedWaitTick) >= 0.5 then
                    submergedWaitTick = os.clock()

                    fn36 = function()
                      return Remotes.CommF_:InvokeServer("ElectroQuestState")
                    end

                    ok, result = pcall(fn36)
                    canUseBypass = ok and (((result == 2) or (result == 3)) or (result == 4))
                  end
                end

                return canUseBypass
              end

              IsMeleePurchaseComplete = function(arg)
                local n7 = tonumber((ScriptStorage and ScriptStorage.Melees) and ScriptStorage.Melees[arg]) or 0
                local flag6, v16, character

                if ScriptStorage then
                  if ScriptStorage.MeleesOwned then
                    flag6 = ScriptStorage.MeleesOwned[arg]

                    if not flag6 then
                      flag6 = n7 > 0

                      if not flag6 then
                        if ScriptStorage then
                          if ScriptStorage.Tools then
                            flag6 = ScriptStorage.Tools[arg]

                            if not flag6 then
                              if LocalPlayer then
                                v16 = LocalPlayer

                                if v16:FindFirstChild("Backpack") then
                                  flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                                  if not flag6 then
                                    flag6 = LocalPlayer

                                    if flag6 then
                                      flag6 = LocalPlayer.Character
                                      if flag6 then
                                        character = LocalPlayer.Character
                                        return (character:FindFirstChild(arg))
                                      end
                                    end
                                  end
                                else
                                  flag6 = LocalPlayer

                                  if flag6 then
                                    flag6 = LocalPlayer.Character
                                    if flag6 then
                                      character = LocalPlayer.Character
                                      return (character:FindFirstChild(arg))
                                    end
                                  end
                                end
                              else
                                flag6 = LocalPlayer

                                if flag6 then
                                  flag6 = LocalPlayer.Character
                                  if flag6 then
                                    character = LocalPlayer.Character
                                    return (character:FindFirstChild(arg))
                                  end
                                end
                              end
                            end
                          elseif LocalPlayer then
                            v16 = LocalPlayer

                            if v16:FindFirstChild("Backpack") then
                              flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                              if not flag6 then
                                flag6 = LocalPlayer

                                if flag6 then
                                  flag6 = LocalPlayer.Character
                                  if flag6 then
                                    character = LocalPlayer.Character
                                    return (character:FindFirstChild(arg))
                                  end
                                end
                              end
                            else
                              flag6 = LocalPlayer

                              if flag6 then
                                flag6 = LocalPlayer.Character
                                if flag6 then
                                  character = LocalPlayer.Character
                                  return (character:FindFirstChild(arg))
                                end
                              end
                            end
                          else
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        elseif LocalPlayer then
                          v16 = LocalPlayer

                          if v16:FindFirstChild("Backpack") then
                            flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                            if not flag6 then
                              flag6 = LocalPlayer

                              if flag6 then
                                flag6 = LocalPlayer.Character
                                if flag6 then
                                  character = LocalPlayer.Character
                                  return (character:FindFirstChild(arg))
                                end
                              end
                            end
                          else
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        else
                          flag6 = LocalPlayer

                          if flag6 then
                            flag6 = LocalPlayer.Character
                            if flag6 then
                              character = LocalPlayer.Character
                              return (character:FindFirstChild(arg))
                            end
                          end
                        end
                      end
                    end
                  else
                    flag6 = n7 > 0

                    if not flag6 then
                      if ScriptStorage then
                        if ScriptStorage.Tools then
                          flag6 = ScriptStorage.Tools[arg]

                          if not flag6 then
                            if LocalPlayer then
                              v16 = LocalPlayer

                              if v16:FindFirstChild("Backpack") then
                                flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                                if not flag6 then
                                  flag6 = LocalPlayer

                                  if flag6 then
                                    flag6 = LocalPlayer.Character
                                    if flag6 then
                                      character = LocalPlayer.Character
                                      return (character:FindFirstChild(arg))
                                    end
                                  end
                                end
                              else
                                flag6 = LocalPlayer

                                if flag6 then
                                  flag6 = LocalPlayer.Character
                                  if flag6 then
                                    character = LocalPlayer.Character
                                    return (character:FindFirstChild(arg))
                                  end
                                end
                              end
                            else
                              flag6 = LocalPlayer

                              if flag6 then
                                flag6 = LocalPlayer.Character
                                if flag6 then
                                  character = LocalPlayer.Character
                                  return (character:FindFirstChild(arg))
                                end
                              end
                            end
                          end
                        elseif LocalPlayer then
                          v16 = LocalPlayer

                          if v16:FindFirstChild("Backpack") then
                            flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                            if not flag6 then
                              flag6 = LocalPlayer

                              if flag6 then
                                flag6 = LocalPlayer.Character
                                if flag6 then
                                  character = LocalPlayer.Character
                                  return (character:FindFirstChild(arg))
                                end
                              end
                            end
                          else
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        else
                          flag6 = LocalPlayer

                          if flag6 then
                            flag6 = LocalPlayer.Character
                            if flag6 then
                              character = LocalPlayer.Character
                              return (character:FindFirstChild(arg))
                            end
                          end
                        end
                      elseif LocalPlayer then
                        v16 = LocalPlayer

                        if v16:FindFirstChild("Backpack") then
                          flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                          if not flag6 then
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        else
                          flag6 = LocalPlayer

                          if flag6 then
                            flag6 = LocalPlayer.Character
                            if flag6 then
                              character = LocalPlayer.Character
                              return (character:FindFirstChild(arg))
                            end
                          end
                        end
                      else
                        flag6 = LocalPlayer

                        if flag6 then
                          flag6 = LocalPlayer.Character
                          if flag6 then
                            character = LocalPlayer.Character
                            return (character:FindFirstChild(arg))
                          end
                        end
                      end
                    end
                  end
                else
                  flag6 = n7 > 0

                  if not flag6 then
                    if ScriptStorage then
                      if ScriptStorage.Tools then
                        flag6 = ScriptStorage.Tools[arg]

                        if not flag6 then
                          if LocalPlayer then
                            v16 = LocalPlayer

                            if v16:FindFirstChild("Backpack") then
                              flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                              if not flag6 then
                                flag6 = LocalPlayer

                                if flag6 then
                                  flag6 = LocalPlayer.Character
                                  if flag6 then
                                    character = LocalPlayer.Character
                                    return (character:FindFirstChild(arg))
                                  end
                                end
                              end
                            else
                              flag6 = LocalPlayer

                              if flag6 then
                                flag6 = LocalPlayer.Character
                                if flag6 then
                                  character = LocalPlayer.Character
                                  return (character:FindFirstChild(arg))
                                end
                              end
                            end
                          else
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        end
                      elseif LocalPlayer then
                        v16 = LocalPlayer

                        if v16:FindFirstChild("Backpack") then
                          flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                          if not flag6 then
                            flag6 = LocalPlayer

                            if flag6 then
                              flag6 = LocalPlayer.Character
                              if flag6 then
                                character = LocalPlayer.Character
                                return (character:FindFirstChild(arg))
                              end
                            end
                          end
                        else
                          flag6 = LocalPlayer

                          if flag6 then
                            flag6 = LocalPlayer.Character
                            if flag6 then
                              character = LocalPlayer.Character
                              return (character:FindFirstChild(arg))
                            end
                          end
                        end
                      else
                        flag6 = LocalPlayer

                        if flag6 then
                          flag6 = LocalPlayer.Character
                          if flag6 then
                            character = LocalPlayer.Character
                            return (character:FindFirstChild(arg))
                          end
                        end
                      end
                    elseif LocalPlayer then
                      if LocalPlayer:FindFirstChild("Backpack") then
                        flag6 = LocalPlayer.Backpack:FindFirstChild(arg)

                        if not flag6 then
                          flag6 = LocalPlayer

                          if flag6 then
                            flag6 = LocalPlayer.Character
                            if flag6 then
                              character = LocalPlayer.Character
                              return (character:FindFirstChild(arg))
                            end
                          end
                        end
                      else
                        flag6 = LocalPlayer

                        if flag6 then
                          flag6 = LocalPlayer.Character
                          if flag6 then
                            character = LocalPlayer.Character
                            return (character:FindFirstChild(arg))
                          end
                        end
                      end
                    else
                      flag6 = LocalPlayer

                      if flag6 then
                        flag6 = LocalPlayer.Character
                        if flag6 then
                          return (LocalPlayer.Character:FindFirstChild(arg))
                        end
                      end
                    end
                  end
                end

                return flag6
              end

              MeleesTable = {"Black Leg", "Electro", "Fishman Karate", "Dragon Claw", "Superhuman", "Death Step", "Sharkman Karate", "Electric Claw", "Dragon Talon", "Godhuman", "SanguineArt"}
              MeleesId = {"BlackLeg", "Electro", "FishmanKarate", "DragonClaw", "Superhuman", "DeathStep", "SharkmanKarate", "ElectricClaw", "DragonTalon", "Godhuman", "SanguineArt"}

              local function fn36()
                return true
              end

              MeleePrices = {["Black Leg"] = {Price = {Beli = 150000}, Id = "BlackLeg", NextLevelRequirement = 400, Requirements = function()
                return true
              end, Buy = function(arg)
                return BuyMelee("BlackLeg", arg)
              end}, Electro = {Price = {Beli = 500000}, Id = "Electro", NextLevelRequirement = 400, Requirements = function()
                return HasLightningBolt(true)
              end, Buy = function(arg)
                if arg then
                  local response = Remotes.CommF_:InvokeServer("BuyElectro", true)
                  local flag6 = response == 1
                  if flag6 then
                    return flag6, response
                  end
                  return response == true, response
                end

                return Remotes.CommF_:InvokeServer("BuyElectro")
              end}, ["Fishman Karate"] = {Price = {Beli = 750000}, NextLevelRequirement = 400, Requirements = fn36, Buy = function(arg)
                return BuyMelee("FishmanKarate", arg)
              end}, ["Dragon Claw"] = {Price = {Fragments = 1500}, NextLevelRequirement = 400, Requirements = function()
                return (ScriptStorage.PlayerData.Fragments or 0) >= 1500
              end, Buy = function(arg)
                if arg then
                  local response = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                  local flag6 = response == true

                  if not flag6 then
                    flag6 = response == 1
                    if not flag6 then
                      return response == 2, response
                    end
                  end

                  return flag6, response
                end

                return Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
              end}, Superhuman = {Price = {Beli = 3000000}, NextLevelRequirement = 400, Requirements = function()
                local flag6 = (tonumber(ScriptStorage.Melees["Black Leg"]) or 0) >= 300

                if flag6 then
                  flag6 = (tonumber(ScriptStorage.Melees.Electro) or 0) >= 300

                  if flag6 then
                    flag6 = (tonumber(ScriptStorage.Melees["Fishman Karate"]) or 0) >= 300
                    if flag6 then
                      return (tonumber(ScriptStorage.Melees["Dragon Claw"]) or 0) >= 300
                    end
                  end
                end

                return flag6
              end, Buy = function(arg)
                return BuyMelee("Superhuman", arg)
              end}, ["Death Step"] = {Price = {Beli = 2500000, Fragments = 5000}, NextLevelRequirement = 400, Requirements = function()
                local flag6 = (tonumber(ScriptStorage.Melees["Black Leg"]) or 0) >= 400
                if flag6 then
                  return (ScriptStorage.PlayerData.Fragments or 0) >= 5000
                end
                return flag6
              end, Buy = function(arg)
                return BuyMelee("DeathStep", arg)
              end}, ["Electric Claw"] = {Price = {Beli = 2500000, Fragments = 5000}, NextLevelRequirement = 400, Requirements = function()
                local flag6 = SeaIndex == 3

                if flag6 then
                  flag6 = (tonumber(ScriptStorage.Melees.Electro) or 0) >= 400
                  if flag6 then
                    return (ScriptStorage.PlayerData.Fragments or 0) >= 5000
                  end
                end

                return flag6
              end, Buy = function(arg)
                return BuyMelee("ElectricClaw", arg)
              end}, ["Sharkman Karate"] = {Price = {Beli = 2500000, Fragments = 5000}, NextLevelRequirement = 400, Requirements = function()
                local flag6 = (tonumber(ScriptStorage.Melees["Fishman Karate"]) or 0) >= 400
                if flag6 then
                  return (ScriptStorage.PlayerData.Fragments or 0) >= 5000
                end
                return flag6
              end, Buy = function(arg)
                return BuyMelee("SharkmanKarate", arg)
              end}, ["Dragon Talon"] = {Price = {Beli = 3000000, Fragments = 5000}, NextLevelRequirement = 400, Requirements = function()
                local flag6 = SeaIndex == 3

                if flag6 then
                  flag6 = (tonumber(ScriptStorage.Melees["Dragon Claw"]) or 0) >= 400
                  if flag6 then
                    return (ScriptStorage.PlayerData.Fragments or 0) >= 5000
                  end
                end

                return flag6
              end, Buy = function(arg)
                return BuyMelee("DragonTalon", arg)
              end}, Godhuman = {Price = {Beli = 5000000, Fragments = 5000}, NextLevelRequirement = 350, Requirements = function()
                local flag6 = SeaIndex == 3

                if flag6 then
                  flag6 = (tonumber(ScriptStorage.Melees.Superhuman) or 0) >= 400

                  if flag6 then
                    flag6 = (tonumber(ScriptStorage.Melees["Death Step"]) or 0) >= 400

                    if flag6 then
                      flag6 = (tonumber(ScriptStorage.Melees["Sharkman Karate"]) or 0) >= 400

                      if flag6 then
                        flag6 = (tonumber(ScriptStorage.Melees["Electric Claw"]) or 0) >= 400

                        if flag6 then
                          flag6 = (tonumber(ScriptStorage.Melees["Dragon Talon"]) or 0) >= 400
                          if flag6 then
                            return (ScriptStorage.PlayerData.Fragments or 0) >= 5000
                          end
                        end
                      end
                    end
                  end
                end

                return flag6
              end, Buy = function(arg)
                return BuyMelee("Godhuman", arg)
              end}}

              GodhumanMaterials = {["Fish Tail"] = {20, 3, {"Fishman Raider", "Fishman Captain"}, {"DeepForestIsland3", 1, 1775, "Turtle Adventure Quest Giver"}}, ["Dragon Scale"] = {10, 3, {"Dragon Crew Warrior", "Dragon Crew Archer"}, {"DragonCrewQuest", 1, 1575, "Dragon Crew Quest Giver"}}, ["Magma Ore"] = {20, 2, {"Magma Ninja"}, {"FireSideQuest", 1, 1100, "Fire Quest Giver"}}, ["Mystic Droplet"] = {10, 2, {"Sea Soldier", "Water Fighter"}, {"ForgottenQuest", 2, 1425, "Forgotten Quest Giver"}}}
              SeaIndexes = {"Main", "Dressrosa", "Zou"}
              TasksOrder = {"CannonBuyController", "MeleeBuyController", "SpecialBossesTask", "RaidController", "Trevor", "UtillyItemsActivitation", "ColosseumPuzzle", "Wenlocktoad", "ThirdSeaPuzzle", "PirateRaid", "SecondSeaPuzzle", "ThirdSeaPuzzle", "CollectDrops", "BossesTask", "LevelFarm"}
              MaxLevel = 2800
              placeId = game.PlaceId

              if placeId ~= 2753915549 then
                if placeId ~= 85211729168715 then
                  if placeId ~= 4442272183 then
                    if placeId ~= 79091703265657 then
                      if placeId ~= 7449423635 then
                        if placeId ~= 100117331123089 then
                          warn("Unknown PlaceId, defaulting SeaIndex=1:", placeId)
                          Sea = "Main"
                          SeaIndex = 1
                        else
                          Sea = "Zou"
                          SeaIndex = 3
                        end
                      else
                        Sea = "Zou"
                        SeaIndex = 3
                      end
                    else
                      Sea = "Dressrosa"
                      SeaIndex = 2
                    end
                  else
                    Sea = "Dressrosa"
                    SeaIndex = 2
                  end
                else
                  Sea = "Main"
                  SeaIndex = 1
                end
              else
                Sea = "Main"
                SeaIndex = 1
              end

              getBypassSpawn = function()
                local worldOrigin = workspace:FindFirstChild("_WorldOrigin")

                if worldOrigin then
                  local playerSpawns = worldOrigin:FindFirstChild("PlayerSpawns")

                  if playerSpawns then
                    if LocalPlayer.Team then
                      local name2 = LocalPlayer.Team.Name

                      if name2 then
                        if playerSpawns:FindFirstChild(name2) then
                          return playerSpawns[name2]
                        end
                      end
                    end

                    local pirates = playerSpawns:FindFirstChild("Pirates")
                    if pirates then
                      return pirates
                    end
                    return (playerSpawns:FindFirstChild("Marines"))
                  end
                end

                return nil
              end

              v15 = getBypassSpawn()
              Portals = ({{Vector3.new(-7894.6201171875, 5545.4917, -380.246337890625), Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625), Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875), Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)}, {Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312), Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625), Vector3.new(923.2125244140625, 126.97600555419922, 32852.83203125), Vector3.new(-6508.55810546875, 89.03499603271484, -132.83953857421875)}, {}})[SeaIndex]
              Sea3Entrances = {mansion = {pos = Vector3.new(-12500, 337, -7480), item_required = "Valkyrie Helm", island = "Mansion", verified = true, direct_radius = 3600, spawn_groups = {"BigMansion", "PineappleTown"}}, hydra = {pos = Vector3.new(5710, 1015, -255), item_required = "Valkyrie Helm", island = "Hydra Island", verified = true, direct_radius = 3600, spawn_groups = {"Hydra1", "Hydra2", "Hydra3"}}, sea_castle = {pos = Vector3.new(-5050, 315, -3150), item_required = "Valkyrie Helm", island = "Castle on the Sea", verified = true, direct_radius = 2600, spawn_groups = {"SeaCastle"}}, great_tree = {pos = Vector3.new(3000, 2295, -7325), island = "Great Tree", direct_radius = 3000, spawn_groups = {"GreatTree"}}, tiki = {pos = Vector3.new(-16800, 60, 290), item_required = "Feathered Visage", island = "Tiki Outpost", direct_radius = 3600, spawn_groups = {"Tiki"}}, submarine = {pos = Vector3.new(11520, 0, 9830), item_required = "Feathered Visage", island = "Submerged Island", direct_radius = 3600, spawn_groups = {"SubmergedIsland"}}}
              local vector = Vector3.new(11256, -2138, 9888)
              local n7 = 4200
              cframe = CFrame.new(-16269.4082, 23.9799957, 1371.66235, -0.999388933, 0, -0.0349550731, 0, 1, 0, 0.0349550731, 0, -0.999388933)
              n4 = 0
              cframe2 = CFrame.new(11427, -2157, 9726)
              questAllowMap = {SubmergedQuest1 = true, SubmergedQuest2 = true, SubmergedQuest3 = true}
              questNameOverrides = {SubmergedQuest1 = "Submerged Quest Giver 1", SubmergedQuest2 = "Submerged Quest Giver 2", SubmergedQuest3 = "Submerged Quest Giver 3"}
              BossesOrder = {"Awakened Ice Admiral", "Tide Keeper", "Deandre", "Urban", "Diablo", "Soul Reaper", "Cake Prince"}
              BossesOrderLevel = {["Awakened Ice Admiral"] = 700, ["Tide Keeper"] = 700, Deandre = 1500, Urban = 1500, Diablo = 1500, ["Cake Prince"] = 1500, ["Soul Reaper"] = 1500}
              BossesOrderWL = {Deandre = 1500, Urban = 1500, Diablo = 1500, ["Cake Prince"] = 1500, ["Don Swan"] = 1100, ["Awakened Ice Admiral"] = 700, ["Tide Keeper"] = 700}
              SpecialBossesOrder = {Core = 700, Darkbeard = 700, ["rip_indra True Form"] = 1500, ["Dough King"] = 1500}
              BlankTablets = {"Segment6", "Segment2", "Segment8", "Segment9", "Segment5"}
              Trophy = {Segment1 = "Trophy1", Segment3 = "Trophy2", Segment4 = "Trophy3", Segment7 = "Trophy4", Segment10 = "Trophy5"}
              Pipes = {Part1 = "Really black", Part2 = "Really black", Part3 = "Dusty Rose", Part4 = "Storm blue", Part5 = "Really black", Part6 = "Parsley green", Part7 = "Really black", Part8 = "Dusty Rose", Part9 = "Really black", Part10 = "Storm blue"}

              GenerateUUID = function()
                return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(c)
                  local n8 = (c == "x") and math.random(0, 15) or math.random(8, 11)
                  return string.format("%x", n8)
                end)
              end

              CheckIsPlayerAlive = function(arg)
                if not arg then
                  arg = LocalPlayer
                  if not arg then
                    return arg
                  end
                end

                local character = arg.Character

                if character then
                  character = arg.Character.Humanoid

                  if character then
                    character = arg.Character.HumanoidRootPart

                    if character then
                      character = arg.Character.Head
                      if character then
                        return arg.Character.Humanoid.Health > 0
                      end
                    end
                  end
                end

                return character
              end

              ConvertTo = function(arg, arg2)
                return arg.new(arg2.X, arg2.Y, arg2.Z)
              end

              CaculateDistance = function(arg, arg2)
                if arg then
                  arg2 = arg2 or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                  return (ConvertTo(Vector3, arg) - ConvertTo(Vector3, arg2)).magnitude
                end
                return 0
              end

              normQuestName = function(arg)
                if SeaIndex ~= 3 then
                  return false
                end

                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  return (arg - vector).Magnitude <= n7
                end

                return false
              end

              matchQuestTitle = function(arg, arg2)
              if ScriptStorage and ScriptStorage.NPCs then
                local v16 = ScriptStorage.NPCs[arg]
                if v16 then
                  local ok, result = pcall(function()
                    if v16:IsA("Model") then
                      return v16:GetModelCFrame() or v16:GetPivot() or (v16:FindFirstChild("HumanoidRootPart") and v16.HumanoidRootPart.CFrame) or v16.CFrame
                    end
                    return (v16:FindFirstChild("HumanoidRootPart") and v16.HumanoidRootPart.CFrame) or v16.CFrame
                  end)
                  if ok and result then
                    return result
                  end
                end
              end

              if workspace:FindFirstChild("NPCs") then
                local targetName = tostring(arg):lower()
                for _, child in ipairs(workspace.NPCs:GetChildren()) do
                  local cname = child.Name:lower()
                  if cname == targetName or cname:find(targetName, 1, true) then
                    local ok, result = pcall(function()
                      if child:IsA("Model") then
                        return child:GetModelCFrame() or child:GetPivot() or child.CFrame
                      end
                      return child.CFrame
                    end)
                    if ok and result then
                      return result
                    end
                  end
                end
              end

              return arg2
            end

              stripQuestSpaces = function()
                if LocalPlayer then
                  local character = LocalPlayer.Character

                  if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      local v16 = normQuestName(humanoidRootPart.Position)
                      if v16 then
                        return v16
                      end
                    end
                  end
                end

                return false
              end

              DispTime = function(arg, arg2)
                local num = tonumber(arg)

                if num then
                  local n8 = math.floor(num / 86400)
                  local n9 = math.floor(math.fmod(num, 86400) / 3600)
                  local n10 = math.floor(math.fmod(num, 3600) / 60)
                  local n11 = math.floor(math.fmod(num, 60))
                  if arg2 then
                    return n8 .. ("day, " .. (n9 .. ("hrs, " .. (n10 .. ("min, " .. (n11 .. "sec."))))))
                  end
                  return n8 .. ("day, " .. (n9 .. "hrs."))
                end

                return "[err]"
              end

              GetCurrentDateTime = function()
                local v16 = os.date("*t")
                local day = v16.day
                local month = v16.month
                local year = v16.year
                local v17 = ({"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"})[v16.wday]
                return string.format("%02d:%02d ", v16.hour, v16.min) .. string.format("%s, %s %d %d", v17, ({"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"})[month], day, year)
              end

              RandomArguments = function(...)
                local tbl10 = {...}
                return tbl10[math.random(0, #tbl10)]
              end

              RoundVector3Down = function(arg)
                return Vector3.new(math.floor(arg.X / 10) * 10, math.floor(arg.Y / 10) * 10, math.floor(arg.Z / 10) * 10)
              end

              local n8 = 30
              lastChange = tick()

              CaculateCircreDirection = function(arg)
                local v16 = n8

                if v16 > 50000 then
                  (not v16)[0] = nil
                end

                local v17 = n8
                local v18 = lastChange
                local n9 = (((tick() - v18) > 0.4) and 80) or 0
                n8 = v17 + n9
                local v19 = lastChange

                if (tick() - v19) > 0.4 then
                  lastChange = tick()
                end

                return CFrame.new(RoundVector3Down((arg + Vector3.new(math.cos(math.rad(n8)) * 40, 0, math.sin(math.rad(n8)) * 40)).p))
              end

              GetMonAsSortedRange = function()
                local tbl10 = {}
                local enemies = Services.Workspace:FindFirstChild("Enemies")
                local flag6 = false

                pcall(function()
                  if SeaIndex ~= 1 then
                    local character = LocalPlayer.Character

                    if character then
                      character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                      if character then
                        character = (math.abs(character.Position.X) > 40000) or (math.abs(character.Position.Z) > 40000)
                      end
                    end

                    flag6 = character
                    return
                  end
                end)

                if enemies then
                  for _, child in ipairs(enemies:GetChildren()) do
                    local humanoid = child:FindFirstChild("Humanoid")
                    local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
                    if child:FindFirstChild("Ignored") then continue end
                    if humanoid then
                      if humanoidRootPart then
                        if humanoid.Health > 0 then
                          local flag7 = flag6 and (humanoidRootPart.Position.Y < -5)
                          local flag8 = not flag6
                          local n9

                          if not flag8 then
                            flag8 = math.abs(humanoidRootPart.Position.X) > 40000

                            if not flag8 then
                              flag8 = math.abs(humanoidRootPart.Position.Z) > 40000
                            end
                          end

                          if flag7 then
                          elseif flag8 then
                            n9 = #tbl10 + 1
                            tbl10[n9] = child
                          end
                        end
                      end
                    end
                  end
                end

                local ReplicatedStorage2 = game:GetService("ReplicatedStorage")

                if not flag6 then
                  if ReplicatedStorage2 then
                    for _, child in ipairs(ReplicatedStorage2:GetChildren()) do
                      local humanoid = child:FindFirstChild("Humanoid")
                      local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
                      if child:FindFirstChild("Ignored") then continue end
                      if humanoid then
                        if humanoidRootPart then
                          if humanoid.Health > 0 then
                            tbl10[#tbl10 + 1] = child
                          end
                        end
                      end
                    end
                  end
                end

                local position, n9, fn37

                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    position = humanoidRootPart.Position or Vector3.new(0, 0, 0)
                  else
                    position = Vector3.new(0, 0, 0)

                    fn37 = function(arg, arg2)
                      local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")
                      local humanoidRootPart3 = arg2:FindFirstChild("HumanoidRootPart")

                      if humanoidRootPart2 then
                        if humanoidRootPart3 then
                          return (humanoidRootPart2.Position - position).Magnitude < (humanoidRootPart3.Position - position).Magnitude
                        end
                        return false
                      end

                      return false
                    end

                    table.sort(tbl10, fn37)
                    return tbl10
                  end
                else
                  position = Vector3.new(0, 0, 0)

                  fn37 = function(arg, arg2)
                    local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
                    local humanoidRootPart2 = arg2:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      if humanoidRootPart2 then
                        return (humanoidRootPart.Position - position).Magnitude < (humanoidRootPart2.Position - position).Magnitude
                      end
                      return false
                    end

                    return false
                  end

                  table.sort(tbl10, fn37)
                  return tbl10
                end

                fn37 = function(arg, arg2)
                  local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
                  local humanoidRootPart2 = arg2:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    if humanoidRootPart2 then
                      return (humanoidRootPart.Position - position).Magnitude < (humanoidRootPart2.Position - position).Magnitude
                    end
                    return false
                  end

                  return false
                end

                table.sort(tbl10, fn37)
                return tbl10
              end

              GetMeleeIdByName = function(arg)
                for k, v16 in pairs(MeleesTable) do
                  if v16 ~= arg then
                    continue
                  end
                  return MeleesId[k]
                end
              end

              BuyMelee = function(arg, arg2)
                if arg2 then
                  local response = Remotes.CommF_:InvokeServer("Buy" .. arg, true)
                  local flag6 = response == 1
                  if flag6 then
                    return flag6, response
                  end
                  return response == true, response
                end

                local response = Remotes.CommF_:InvokeServer("Buy" .. arg)

                if response ~= 2 then
                  if response ~= "2" then
                    return response
                  end
                end

                return (Remotes.CommF_:InvokeServer("Buy" .. arg, true))
              end

              SendKey = function(arg, arg2)
                local function fn37()
                  game:GetService("VirtualInputManager"):SendKeyEvent(true, arg, false, game)
                  task.wait(arg2)
                  game:GetService("VirtualInputManager"):SendKeyEvent(false, arg, false, game)
                end

                fn37()
              end

              local function fn37(arg)
                return string.match(arg, "(((%u)%-?)([^-.]+))$") .. " Fruit"
              end

              FruitIdToName = fn37

              Split = function(arg, arg2)
                if arg2 == nil then
                  arg2 = "%s"
                end

                local tbl10 = {}

                for match in string.gmatch(arg, "([^" .. (arg2 .. "]+)")) do
                  table.insert(tbl10, match)
                end

                return tbl10
              end

              FruitNameToId = function(arg)
                local v16 = Split(arg)[1]
                return v16 .. ("-" .. v16)
              end

              local tbl10 = {}

              resetCurrentQuest = function(arg, ...)
                local now5 = os.clock()

                if tbl10[arg] then
                  if (now5 - tbl10[arg]) < 5 then
                    return
                  end
                end

                tbl10[arg] = now5
                warn(...)
              end

              QuestController = {CurrentLevel = 2, DoubleQuest = true, CurrentQuests = {}, BlacklistedQuestIds = {BartiloQuest = 1, CitizenQuest = 1, ImpelQuest = 1}}
              local npcList = require(game.ReplicatedStorage.GuideModule).Data.NPCList

              while true do
                task.wait(0.05)

                if not game.Players.LocalPlayer:FindFirstChild("Data") then
                  if not game.Players.LocalPlayer.DataLoaded then
                    continue
                  end
                end

                if not ScriptStorage then
                  continue
                end
                break
              end

              QuestController.Quests = require(game.ReplicatedStorage.Quests)
              local tbl11 = {}

              QuestController.Set = function(arg, arg2, arg3)
                arg[arg2] = arg3
              end

              QuestController.RefreshQuest = function(arg)
                local now5 = os.clock()
                local flag6, pos

                while true do
                  local v16 = GetLiveLevel()
                  local flag7 = not v16

                  if v16 then
                    if GetLiveLevel() == 0 then
                      while (os.clock() - now5) < 2 do
                        task.wait(0.05)
                        local exitTo5 = nil

                        while true do
                          v16 = GetLiveLevel()
                          flag7 = not v16

                          if v16 then
                            exitTo5 = 1
                          else
                            if flag7 then
                              if (os.clock() - now5) < 2 then
                                task.wait(0.05)
                                continue
                              end
                            end
                          end

                          break
                        end

                        if exitTo5 == 1 then
                          if GetLiveLevel() == 0 then
                            continue
                          end
                        end

                        break
                      end
                    end

                    local level = GetLiveLevel()

                    if level then
                      if level == 0 then
                        level = 1
                      end
                    else
                      level = 1
                    end

                    ScriptStorage.PlayerData.Level = level
                    local name2

                    if LocalPlayer.Team then
                      name2 = LocalPlayer.Team.Name

                      if not name2 then
                        if Config.Team ~= "Marines" then
                          name2 = "Pirates"
                        else
                          name2 = "Marines"
                        end
                      end
                    elseif Config.Team ~= "Marines" then
                      name2 = "Pirates"
                    else
                      name2 = "Marines"
                    end

                    local flag8 = level < 10
                    local str4

                    if flag8 then
                      if name2 ~= "Marines" then
                        str4 = "bandit"
                      else
                        str4 = "trainee"
                      end
                    else
                      str4 = flag8
                    end

                    local function fn38(arg2)
                      if str4 then
                        local task_ = arg2[1].Task or {}

                        for k in pairs(task_) do
                          if tostring(k):lower():find(str4, 1, true) then
                            return true
                          end
                        end

                        return false
                      end

                      return true
                    end

                    local v17 = nil
                    local n9 = -1
                    local v18 = nil
                    local v19 = nil

                    for k, v20 in pairs(QuestController.Quests) do
                    if not QuestController.BlacklistedQuestIds[k] and v20[1] and v20[1].LevelReq <= level then
                      if n9 < v20[1].LevelReq and fn38(v20) then
                        if level < 1500 or SeaIndex ~= 2 or k ~= "ForgottenQuest" then
                          n9 = v20[1].LevelReq
                          v18 = k
                          v19 = v20
                        end
                      end
                    end
                  end

                  if v19 then
                      local n10 = #v19
                      local v20 = v19[n10]

                      if v20 then
                        if v20.Task then
                          for _, v22 in pairs(v20.Task) do
                            if v22 == 1 then
                              table.remove(v19, #v19)
                              break
                            end
                          end
                        end
                      end

                      arg.CurrentQuestId = v18
                      arg.CurrentQuests = v19
                      arg.LastRefreshLevel = level
                      local n11 = 1

                      for i, v22 in ipairs(v19) do
                        if v22 then
                          local levelReq = v22.LevelReq

                          if levelReq then
                            if levelReq <= level then
                              n11 = i
                            end
                          elseif level >= 0 then
                            n11 = i
                          end
                        end
                      end

                      local v22 = v19[n11]
                      v22 = v22 or v19[#v19]
                      local levelReq = v22.LevelReq
                      local name3 = v22.Name or "?"
                      local str5 = tostring(v18)
                      local str6 = str5 .. ("_" .. tostring(v22.LevelReq or ""))

                      local function fn39(arg2)
                        if ScriptStorage then
                          if ScriptStorage.MobRegions then
                            if ScriptStorage.MobRegions[arg2] then
                              if ScriptStorage.MobRegions[arg2][1] then
                                local v23 = ScriptStorage.MobRegions[arg2][1]

                                if typeof(v23) == "CFrame" then
                                  local position = v23.Position
                                  if position then
                                    return position
                                  end
                                end

                                return v23
                              end
                            end
                          end
                        end

                        local fortBuilderReplicatedSpawnPositi = game:GetService("ReplicatedStorage"):FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")

                        if fortBuilderReplicatedSpawnPositi then
                          if fortBuilderReplicatedSpawnPositi:FindFirstChild(arg2) then
                            local v23 = fortBuilderReplicatedSpawnPositi[arg2]
                            local position

                            if v23:IsA("BasePart") then
                              position = v23.Position

                              if not position then
                                position = v23:IsA("Model")
                                if position then
                                  return v23:GetPivot().Position
                                end
                              end
                            else
                              position = v23:IsA("Model")
                              if position then
                                return v23:GetPivot().Position
                              end
                            end

                            return position
                          end
                        end

                        if workspace:FindFirstChild("_WorldOrigin") then
                          local enemySpawns = workspace._WorldOrigin:FindFirstChild("EnemySpawns")

                          if enemySpawns then
                            for _, child in ipairs(enemySpawns:GetChildren()) do
                              if child.Name:find(arg2, 1, true) then
                                local position

                                if child:IsA("BasePart") then
                                  position = child.Position

                                  if not position then
                                    position = child:IsA("Model")
                                    if position then
                                      return child:GetPivot().Position
                                    end
                                  end
                                else
                                  position = child:IsA("Model")
                                  if position then
                                    return child:GetPivot().Position
                                  end
                                end

                                return position
                              end
                            end

                            return nil
                          end
                        end

                        return nil
                      end

                      local GuideModule = require(game.ReplicatedStorage.GuideModule)

                  if n10 then
                    local npcList2 = GuideModule.Data.NPCList
                    flag6 = false

                    if npcList2 then
                      local position = fn39(v22.Name)
                      local character = LocalPlayer.Character
                      if character then
                        character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                      end
                      position = position or (character and character.Position)
                      local huge = math.huge
                      local v23 = nil

                      for k, v24 in pairs(npcList2) do
                        if v24 and v24.Levels and table.find(v24.Levels, v22.LevelReq) then
                          local cf
                          if typeof(k) == "Instance" then
                            if k:IsA("BasePart") then
                              cf = k.CFrame
                            elseif k:IsA("Model") then
                              cf = k:GetPivot() or (k.PrimaryPart and k.PrimaryPart.CFrame) or (k:FindFirstChild("HumanoidRootPart") and k.HumanoidRootPart.CFrame)
                    end
                  end
                  if cf then
                    local dist = position and (cf.Position - position).Magnitude or 0
                    if dist < huge then
                      huge = dist
                      v23 = cf
                    end
            end
            end
          end

              if not v23 then
                for _, v24 in ipairs(v19) do
                  local pos2 = fn39(v24.Name) or (character and character.Position)
                  for k, v25 in pairs(npcList2) do
                    if v25 and v25.Levels and table.find(v25.Levels, v24.LevelReq) then
                      local cf
                      if typeof(k) == "Instance" then
                        if k:IsA("BasePart") then
                          cf = k.CFrame
                        elseif k:IsA("Model") then
                          cf = k:GetPivot() or (k.PrimaryPart and k.PrimaryPart.CFrame) or (k:FindFirstChild("HumanoidRootPart") and k.HumanoidRootPart.CFrame)
                end
              end
              if cf then
                local dist = pos2 and (cf.Position - pos2).Magnitude or 0
                if dist < huge then
                  huge = dist
                  v23 = cf
                end
            end
          end
        end
          if v23 then break end
        end
      end

      if v23 then
        arg.CurrentNpc = v23
        flag6 = true
      end
    end
  end

  if questNameOverrides then
                        if questNameOverrides[v18] then
                          local v23 = matchQuestTitle(questNameOverrides[v18])

                          if v23 then
                            arg.CurrentNpc = v23
                            flag6 = true

                            if flag6 then
                              if arg.CurrentNpc then
                                tbl11[str6] = arg.CurrentNpc
                              end
                            elseif tbl11[str6] then
                              arg.CurrentNpc = tbl11[str6]
                              flag6 = true
                            end
                          elseif flag6 then
                            if flag6 then
                              if arg.CurrentNpc then
                                tbl11[str6] = arg.CurrentNpc
                              end
                            elseif tbl11[str6] then
                              arg.CurrentNpc = tbl11[str6]
                              flag6 = true
                            end
                          elseif v18 then
                            local str7 = tostring(v18):gsub("SideQuest", ""):gsub("Quest", ""):gsub("(%d+)", " %1"):lower()
                            local str8 = str7:gsub("%d+", "")
                            local replicatedStorage = game.ReplicatedStorage
                            local findFirstChild = replicatedStorage.FindFirstChild
                            local tbl12 = {workspace:FindFirstChild("NPCs"), findFirstChild(replicatedStorage, "NPCs")}

                            for _, v24 in ipairs(tbl12) do
                              local exitTo6 = nil
                              local str9

                              for _, child in ipairs(v24:GetChildren()) do
                                str9 = child.Name:lower()

                                if str9:find("quest") then
                                  pos = str9:find(str7, 1, true)

                                  if pos then
                                    exitTo6 = 2
                                  elseif str9:find(str8, 1, true) then
                                    exitTo6 = 3
                                  end
                                else
                                  pos = str9:find("giver")

                                  if pos then
                                    pos = str9:find(str7, 1, true)

                                    if pos then
                                      exitTo6 = 2
                                    elseif str9:find(str8, 1, true) then
                                      exitTo6 = 3
                                    else
                                      break
                                    end
                                  else
                                    exitTo6 = 1
                                  end
                                end
                              end

                              if not flag6 then
                                continue
                              end
                              break
                            end

                            if flag6 then
                              if arg.CurrentNpc then
                                tbl11[str6] = arg.CurrentNpc
                              end
                            elseif tbl11[str6] then
                              arg.CurrentNpc = tbl11[str6]
                              flag6 = true
                            end
                          elseif flag6 then
                            if arg.CurrentNpc then
                              tbl11[str6] = arg.CurrentNpc
                            end
                          elseif tbl11[str6] then
                            arg.CurrentNpc = tbl11[str6]
                            flag6 = true
                          end
                        else
                          break
                        end
                      else
                        break
                      end

                      local flag9 = not flag6

                      if flag6 then
                        if flag9 then
                          for _, v23 in ipairs(v19) do
                            local name4 = v23.Name

                            if name4 then
                              name4 = flag9:FindFirstChild(v23.Name)

                              if name4 then
                                if name4:IsA("BasePart") then
                                  arg.CurrentNpc = name4.CFrame + Vector3.new(0, 35, 0)
                                  flag6 = true
                                  break
                                end
                              end
                            end
                          end
                        end
                      else
                        flag9 = workspace:FindFirstChild("_WorldOrigin")

                        if flag9 then
                          flag9 = workspace._WorldOrigin:FindFirstChild("EnemySpawns")
                          if flag9 then
                            break
                          end
                        else
                          break
                        end
                      end

                      if flag6 then
                        return
                      end
                      resetCurrentQuest("quest_npc_lastreq_nomatch", "[Quest.Refresh] NPCList≠LastReq " .. (tostring(levelReq) .. (" picked=" .. (tostring(v18) .. (" sub=" .. tostring(name3))))))
                      return
                    end

                    return
                  else
                    if flag7 then
                      if (os.clock() - now5) < 2 then
                        task.wait(0.05)
                        continue
                      end
                    end

                    break
                  end
                end
              end

              QuestController.GetCurrentQuest = function(arg)
                local v16 = GetLiveLevel()
                ScriptStorage.PlayerData.Level = v16

                if (not arg.CurrentQuests or not arg.LastRefreshLevel) or (math.abs(v16 - arg.LastRefreshLevel) >= 1) then
                  pcall(function()
                    arg:RefreshQuest()
                  end)
                end

                if not arg.CurrentQuests or (#arg.CurrentQuests == 0) then
                  return
                end
                local currentLevel = 1

                for i, currentQuest in ipairs(arg.CurrentQuests) do
                  if currentQuest and ((currentQuest.LevelReq or 0) <= v16) then
                    currentLevel = i
                  end
                end

                arg.CurrentLevel = currentLevel
                local huge = math.huge
                local str4 = "n/a"

                for k, quest in pairs(QuestController.Quests) do
                  if ((not QuestController.BlacklistedQuestIds[k] and quest[1]) and (v16 < quest[1].LevelReq)) and (quest[1].LevelReq < huge) then
                    huge = quest[1].LevelReq
                    str4 = k
                  end
                end

                if ScriptStorage and ScriptStorage.Task then
                  local nextLvl = ((huge ~= math.huge) and huge) or "Max"
                  ScriptStorage.Task.QuestDebug = "Quest: " .. (tostring(arg.CurrentQuests[currentLevel].Name or "n/a") .. (" | Next: " .. (tostring(str4) .. (" | Picked: " .. (tostring(arg.CurrentQuestId or "n/a") .. (" (Lvl " .. (tostring(nextLvl) .. ")")))))))
                end

                for monName in pairs(arg.CurrentQuests[currentLevel].Task) do
                  return monName, arg.CurrentNpc, arg.CurrentQuestId, currentLevel, arg.CurrentQuests[currentLevel].Name
                end
              end

              QuestController.GetNextQuestId = function(arg, arg2)
                local v16 = arg2 or GetLiveLevel()
                local v17 = nil
                local huge = math.huge
                local str4 = "n/a"

                for k, v18 in pairs(QuestController.Quests) do
                  if not QuestController.BlacklistedQuestIds[k] then
                    if v18[1] then
                      if v16 < v18[1].LevelReq then
                        if v18[1].LevelReq < huge then
                          huge = v18[1].LevelReq
                          str4 = k
                        end
                      end
                    end
                  end
                end

                return str4, huge
              end

              QuestController.IsUnderWaterQuest = function(arg)
                local v16 = GetLiveLevel()

                if arg.CurrentQuestId then
                  if arg.LastRefreshLevel then
                    if math.abs(v16 - arg.LastRefreshLevel) >= 1 then
                      pcall(function()
                        arg:RefreshQuest()
                      end)
                    end
                  else
                    pcall(function()
                      arg:RefreshQuest()
                    end)

                    return questAllowMap[tostring(arg.CurrentQuestId)] == true
                  end
                else
                  pcall(function()
                    arg:RefreshQuest()
                  end)

                  return questAllowMap[tostring(arg.CurrentQuestId)] == true
                end

                return questAllowMap[tostring(arg.CurrentQuestId)] == true
              end

              QuestController.MarkAsCompleted = function()
              end

              QuestController.AbandonQuest = function()
                Remotes.CommF_:InvokeServer("AbandonQuest")
              end

              local function getCurrentClaimQuest()
                local playerGui, trackedQuestFrame, description, header, text, text2, main, quest, text3, str4, v16, str5, v17
                playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                if not playerGui then
                  return nil, nil
                end
                trackedQuestFrame = playerGui:FindFirstChild("TrackedQuestFrame")

                if not (trackedQuestFrame and (trackedQuestFrame.Enabled and (trackedQuestFrame:FindFirstChild("Frame") and trackedQuestFrame.Frame.Visible))) then
                  main = playerGui:FindFirstChild("Main")

                  if main then
                    quest = main:FindFirstChild("Quest")

                    if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                      text3 = quest.Container.QuestTitle.Title.Text

                      if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                        str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                        if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                          if type(str4) ~= "string" then
                            return str4, text3
                          else
                            v16 = string.gsub(str4, "Military ", "Mil. ")

                            if v16 then
                              return v16, text3
                            else
                              return str4, text3
                            end
                          end
                        else
                          return nil, nil
                        end
                      else
                        return nil, nil
                      end
                    else
                      return nil, nil
                    end
                  else
                    return nil, nil
                  end
                end

                description = trackedQuestFrame.Frame:FindFirstChild("description")
                header = trackedQuestFrame.Frame:FindFirstChild("header")

                if header then
                  header = trackedQuestFrame.Frame.header:FindFirstChild("textLabel")

                  if header then
                    if header:FindFirstChild("textLabel") then
                      text = header.textLabel.Text

                      if text then
                        header = text

                        if description then
                          if description.Text ~= "" then
                            text2 = description.Text

                            if text2 then
                              if text2 ~= "" then
                                str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                                if type(str5) ~= "string" then
                                  v17 = str5
                                else
                                  v17 = string.gsub(str5, "Military ", "Mil. ")

                                  if not v17 then
                                    v17 = str5
                                  end
                                end

                                if header then
                                  return v17, header
                                else
                                  return v17, str5
                                end
                              end

                              main = playerGui:FindFirstChild("Main")

                              if main then
                                quest = main:FindFirstChild("Quest")

                                if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                                  text3 = quest.Container.QuestTitle.Title.Text

                                  if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                                    str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                                    if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                                      if type(str4) ~= "string" then
                                        return str4, text3
                                      else
                                        v16 = string.gsub(str4, "Military ", "Mil. ")

                                        if v16 then
                                          return v16, text3
                                        else
                                          return str4, text3
                                        end
                                      end
                                    else
                                      return nil, nil
                                    end
                                  else
                                    return nil, nil
                                  end
                                else
                                  return nil, nil
                                end
                              else
                                return nil, nil
                              end
                            end

                            if header then
                              text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                              if not text2 then
                                text2 = header:match("[Dd]efeat%s*(.-)$")

                                if not text2 then
                                  text2 = header
                                end
                              end

                              if text2 ~= "" then
                                str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                                if type(str5) ~= "string" then
                                  v17 = str5
                                else
                                  v17 = string.gsub(str5, "Military ", "Mil. ")

                                  if not v17 then
                                    v17 = str5
                                  end
                                end

                                if header then
                                  return v17, header
                                else
                                  return v17, str5
                                end
                              end
                            end
                          elseif header then
                            text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                            if not text2 then
                              text2 = header:match("[Dd]efeat%s*(.-)$")

                              if not text2 then
                                text2 = header
                              end
                            end

                            if text2 ~= "" then
                              str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                              if type(str5) ~= "string" then
                                v17 = str5
                              else
                                v17 = string.gsub(str5, "Military ", "Mil. ")

                                if not v17 then
                                  v17 = str5
                                end
                              end

                              if header then
                                return v17, header
                              else
                                return v17, str5
                              end
                            end

                            main = playerGui:FindFirstChild("Main")

                            if main then
                              quest = main:FindFirstChild("Quest")

                              if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                                text3 = quest.Container.QuestTitle.Title.Text

                                if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                                  str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                                  if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                                    if type(str4) ~= "string" then
                                      return str4, text3
                                    else
                                      v16 = string.gsub(str4, "Military ", "Mil. ")

                                      if v16 then
                                        return v16, text3
                                      else
                                        return str4, text3
                                      end
                                    end
                                  else
                                    return nil, nil
                                  end
                                else
                                  return nil, nil
                                end
                              else
                                return nil, nil
                              end
                            else
                              return nil, nil
                            end
                          end
                        elseif header then
                          text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                          if not text2 then
                            text2 = header:match("[Dd]efeat%s*(.-)$")

                            if not text2 then
                              text2 = header
                            end
                          end

                          if text2 ~= "" then
                            str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                            if type(str5) ~= "string" then
                              v17 = str5
                            else
                              v17 = string.gsub(str5, "Military ", "Mil. ")

                              if not v17 then
                                v17 = str5
                              end
                            end

                            if header then
                              return v17, header
                            else
                              return v17, str5
                            end
                          end
                        end

                        main = playerGui:FindFirstChild("Main")

                        if main then
                          quest = main:FindFirstChild("Quest")

                          if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                            text3 = quest.Container.QuestTitle.Title.Text

                            if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                              str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                              if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                                if type(str4) ~= "string" then
                                  return str4, text3
                                else
                                  v16 = string.gsub(str4, "Military ", "Mil. ")

                                  if v16 then
                                    return v16, text3
                                  else
                                    return str4, text3
                                  end
                                end
                              else
                                return nil, nil
                              end
                            else
                              return nil, nil
                            end
                          else
                            return nil, nil
                          end
                        else
                          return nil, nil
                        end
                      end
                    end

                    header = header.Text

                    if description then
                      if description.Text ~= "" then
                        text2 = description.Text

                        if text2 then
                          if text2 ~= "" then
                            str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                            if type(str5) ~= "string" then
                              v17 = str5
                            else
                              v17 = string.gsub(str5, "Military ", "Mil. ")

                              if not v17 then
                                v17 = str5
                              end
                            end

                            if header then
                              return v17, header
                            else
                              return v17, str5
                            end
                          end

                          main = playerGui:FindFirstChild("Main")

                          if main then
                            quest = main:FindFirstChild("Quest")

                            if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                              text3 = quest.Container.QuestTitle.Title.Text

                              if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                                str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                                if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                                  if type(str4) ~= "string" then
                                    return str4, text3
                                  else
                                    v16 = string.gsub(str4, "Military ", "Mil. ")

                                    if v16 then
                                      return v16, text3
                                    else
                                      return str4, text3
                                    end
                                  end
                                else
                                  return nil, nil
                                end
                              else
                                return nil, nil
                              end
                            else
                              return nil, nil
                            end
                          else
                            return nil, nil
                          end
                        end

                        if header then
                          text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                          if not text2 then
                            text2 = header:match("[Dd]efeat%s*(.-)$")

                            if not text2 then
                              text2 = header
                            end
                          end

                          if text2 ~= "" then
                            str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                            if type(str5) ~= "string" then
                              v17 = str5
                            else
                              v17 = string.gsub(str5, "Military ", "Mil. ")

                              if not v17 then
                                v17 = str5
                              end
                            end

                            if header then
                              return v17, header
                            else
                              return v17, str5
                            end
                          end
                        end
                      elseif header then
                        text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                        if not text2 then
                          text2 = header:match("[Dd]efeat%s*(.-)$")

                          if not text2 then
                            text2 = header
                          end
                        end

                        if text2 ~= "" then
                          str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                          if type(str5) ~= "string" then
                            v17 = str5
                          else
                            v17 = string.gsub(str5, "Military ", "Mil. ")

                            if not v17 then
                              v17 = str5
                            end
                          end

                          if header then
                            return v17, header
                          else
                            return v17, str5
                          end
                        end

                        main = playerGui:FindFirstChild("Main")

                        if main then
                          quest = main:FindFirstChild("Quest")

                          if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                            text3 = quest.Container.QuestTitle.Title.Text

                            if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                              str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                              if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                                if type(str4) ~= "string" then
                                  return str4, text3
                                else
                                  v16 = string.gsub(str4, "Military ", "Mil. ")

                                  if v16 then
                                    return v16, text3
                                  else
                                    return str4, text3
                                  end
                                end
                              else
                                return nil, nil
                              end
                            else
                              return nil, nil
                            end
                          else
                            return nil, nil
                          end
                        else
                          return nil, nil
                        end
                      end
                    elseif header then
                      text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                      if not text2 then
                        text2 = header:match("[Dd]efeat%s*(.-)$")

                        if not text2 then
                          text2 = header
                        end
                      end

                      if text2 ~= "" then
                        str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                        if type(str5) ~= "string" then
                          v17 = str5
                        else
                          v17 = string.gsub(str5, "Military ", "Mil. ")

                          if not v17 then
                            v17 = str5
                          end
                        end

                        if header then
                          return v17, header
                        else
                          return v17, str5
                        end
                      end
                    end

                    main = playerGui:FindFirstChild("Main")

                    if main then
                      quest = main:FindFirstChild("Quest")

                      if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                        text3 = quest.Container.QuestTitle.Title.Text

                        if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                          str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                          if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                            if type(str4) ~= "string" then
                              return str4, text3
                            else
                              v16 = string.gsub(str4, "Military ", "Mil. ")

                              if v16 then
                                return v16, text3
                              else
                                return str4, text3
                              end
                            end
                          else
                            return nil, nil
                          end
                        else
                          return nil, nil
                        end
                      else
                        return nil, nil
                      end
                    else
                      return nil, nil
                    end
                  end
                end

                if description then
                  if description.Text ~= "" then
                    text2 = description.Text

                    if text2 then
                      if text2 ~= "" then
                        str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                        if type(str5) ~= "string" then
                          v17 = str5
                        else
                          v17 = string.gsub(str5, "Military ", "Mil. ")

                          if not v17 then
                            v17 = str5
                          end
                        end

                        if header then
                          return v17, header
                        else
                          return v17, str5
                        end
                      end

                      main = playerGui:FindFirstChild("Main")

                      if main then
                        quest = main:FindFirstChild("Quest")

                        if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                          text3 = quest.Container.QuestTitle.Title.Text

                          if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                            str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                            if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                              if type(str4) ~= "string" then
                                return str4, text3
                              else
                                v16 = string.gsub(str4, "Military ", "Mil. ")

                                if v16 then
                                  return v16, text3
                                else
                                  return str4, text3
                                end
                              end
                            else
                              return nil, nil
                            end
                          else
                            return nil, nil
                          end
                        else
                          return nil, nil
                        end
                      else
                        return nil, nil
                      end
                    end

                    if header then
                      text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                      if not text2 then
                        text2 = header:match("[Dd]efeat%s*(.-)$")

                        if not text2 then
                          text2 = header
                        end
                      end

                      if text2 ~= "" then
                        str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                        if type(str5) ~= "string" then
                          v17 = str5
                        else
                          v17 = string.gsub(str5, "Military ", "Mil. ")

                          if not v17 then
                            v17 = str5
                          end
                        end

                        if header then
                          return v17, header
                        else
                          return v17, str5
                        end
                      end
                    end
                  elseif header then
                    text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                    if not text2 then
                      text2 = header:match("[Dd]efeat%s*(.-)$")

                      if not text2 then
                        text2 = header
                      end
                    end

                    if text2 ~= "" then
                      str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                      if type(str5) ~= "string" then
                        v17 = str5
                      else
                        v17 = string.gsub(str5, "Military ", "Mil. ")

                        if not v17 then
                          v17 = str5
                        end
                      end

                      if header then
                        return v17, header
                      else
                        return v17, str5
                      end
                    end

                    main = playerGui:FindFirstChild("Main")

                    if main then
                      quest = main:FindFirstChild("Quest")

                      if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                        text3 = quest.Container.QuestTitle.Title.Text

                        if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                          str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                          if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                            if type(str4) ~= "string" then
                              return str4, text3
                            else
                              v16 = string.gsub(str4, "Military ", "Mil. ")

                              if v16 then
                                return v16, text3
                              else
                                return str4, text3
                              end
                            end
                          else
                            return nil, nil
                          end
                        else
                          return nil, nil
                        end
                      else
                        return nil, nil
                      end
                    else
                      return nil, nil
                    end
                  end
                elseif header then
                  text2 = header:match("[Dd]efeat%s*%d*%s*(.-)$")

                  if not text2 then
                    text2 = header:match("[Dd]efeat%s*(.-)$")

                    if not text2 then
                      text2 = header
                    end
                  end

                  if text2 ~= "" then
                    str5 = text2:gsub("%s*%b()", ""):gsub("^%s*(.-)%s*$", "%1")

                    if type(str5) ~= "string" then
                      v17 = str5
                    else
                      v17 = string.gsub(str5, "Military ", "Mil. ")

                      if not v17 then
                        v17 = str5
                      end
                    end

                    if header then
                      return v17, header
                    else
                      return v17, str5
                    end
                  end
                end

                main = playerGui:FindFirstChild("Main")

                if main then
                  quest = main:FindFirstChild("Quest")

                  if quest and (quest.Visible and (quest:FindFirstChild("Container") and (quest.Container:FindFirstChild("QuestTitle") and quest.Container.QuestTitle:FindFirstChild("Title")))) then
                    text3 = quest.Container.QuestTitle.Title.Text

                    if text3 and ((text3 ~= "") and (text3 ~= "QUEST")) then
                      str4 = text3:gsub("%s*[Dd]efeat%s*(%d*)%s*(.-)%s*%b()", "%2")

                      if str4 and ((str4 ~= "") and (str4 ~= text3)) then
                        if type(str4) ~= "string" then
                          return str4, text3
                        else
                          v16 = string.gsub(str4, "Military ", "Mil. ")

                          if v16 then
                            return v16, text3
                          else
                            return str4, text3
                          end
                        end
                      else
                        return nil, nil
                      end
                    else
                      return nil, nil
                    end
                  else
                    return nil, nil
                  end
                else
                  return nil, nil
                end
              end

              QuestController.GetCurrentClaimQuest = getCurrentClaimQuest

              QuestController.StartQuest = function(arg, arg2)
                return Remotes.CommF_:InvokeServer("StartQuest", arg, arg2)
              end
            end

            ScriptStorage.MobRegions = {}
            ScriptStorage.SpecialClusterMobs = {["Dangerous Prisoner"] = true, Gladiator = true, Raider = true, Mercenary = true}

            do
              local function fn30(arg)
                if not arg then return end
                for _, child in ipairs(arg:GetChildren()) do
                  local cFrame
                  if child:IsA("BasePart") then
                    cFrame = child.CFrame
                  elseif child:IsA("Model") then
                    cFrame = child:GetPivot() or child:GetModelCFrame()
                  end
                  if cFrame then
                    local str4 = tostring(child.Name)
                    ScriptStorage.MobRegions[str4] = ScriptStorage.MobRegions[str4] or {}
                    table.insert(ScriptStorage.MobRegions[str4], cFrame)
                    local str5 = str4:gsub("%s*%[.-%]", ""):gsub("%s+$", "")
                    if str5 ~= str4 and str5 ~= "" then
                      ScriptStorage.MobRegions[str5] = ScriptStorage.MobRegions[str5] or {}
                      table.insert(ScriptStorage.MobRegions[str5], cFrame)
                    end
                  end
                end
              end

              fn30(game:GetService("ReplicatedStorage"):FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder"))
              local worldOrigin = workspace:FindFirstChild("_WorldOrigin")
              worldOrigin = worldOrigin and workspace._WorldOrigin:FindFirstChild("EnemySpawns")
              fn30(worldOrigin)
            end

            do
              local function fn30(arg)
                if arg:find("Part") then
                  return
                end

                if arg:find("Root") then
                  return
                end
                local v16 = ScriptStorage.MobRegions[arg]

                if v16 then
                  if #v16 < 4 then
                    return
                  end
                  local v17 = v16[1]
                  local huge = math.huge

                  for _, v18 in ipairs(v16) do
                    local position

                    if typeof(v18) == "CFrame" then
                      position = v18.Position or v18
                    else
                      position = v18
                    end

                    local v19, v20, v22 = ipairs(v16)
                    local n5 = 0

                    for _, v23 in ipairs(v16) do
                      local position2

                      if typeof(v23) == "CFrame" then
                        position2 = v23.Position or v23
                      else
                        position2 = v23
                      end

                      n5 += (position - position2).Magnitude
                    end

                    if n5 < huge then
                      huge = n5
                      v17 = position
                    end
                  end

                  local n5 = 0
                  local n6 = 0

                  for _, v18 in ipairs(v16) do
                    local position

                    if typeof(v18) == "CFrame" then
                      position = v18.Position or v18
                    else
                      position = v18
                    end

                    local magnitude = (position - v17).Magnitude

                    if n5 < magnitude then
                      n5 = magnitude

                      if magnitude > 350 then
                        n6 += 1
                      end
                    elseif magnitude > 350 then
                      n6 += 1
                    end
                  end

                  if n6 >= 2 then
                    if n5 > 350 then
                      ScriptStorage.SpecialClusterMobs[arg] = true
                      return
                    end
                  end

                  return
                end
              end

              for k, mobRegion in pairs(ScriptStorage.MobRegions) do
                local v16 = mobRegion[1]

                if v16 then
                  local y = ((typeof(v16) == "CFrame") and v16.Position.Y) or ((typeof(v16) == "Vector3") and v16.Y)

                  if y and (y > -500) then
                    fn30(k)
                  end
                else
                  fn30(k)
                end
              end
            end

            TweenController = {}
            local tweenTargetInstance
            tweenTargetInstance = nil
            local n5
            n5 = 0
            TweenController.HeartbeatConn = nil
            TweenController.Playing = false
            TweenController.Hovering = false
            TweenController.HoverCFrame = nil
            TweenController.CollisionPrepared = false
            TweenController.CollisionCharacter = nil
            TweenController.CollisionConnection = nil
            TweenController.CollisionParts = {}
            local fn30, stopTween, fn32
            local n6 = 0

            fn30 = function()
              local character = LocalPlayer.Character

              if character then
                if TweenController.CollisionCharacter ~= character then
                  if TweenController.CollisionConnection then
                    TweenController.CollisionConnection:Disconnect()
                  end

                  TweenController.CollisionCharacter = character
                  TweenController.CollisionPrepared = false
                  table.clear(TweenController.CollisionParts)
                  local descendantAdded = character.DescendantAdded
                  local connect = descendantAdded.Connect

                  local function fn33(arg)
                    if arg:IsA("BasePart") then
                      table.insert(TweenController.CollisionParts, arg)
                      if TweenController.CollisionPrepared then
                        arg.CanCollide = false
                        return
                      end
                    end
                  end

                  TweenController.CollisionConnection = connect(descendantAdded, fn33)
                end

                if TweenController.CollisionPrepared then
                  return
                end
                TweenController.CollisionPrepared = true
                table.clear(TweenController.CollisionParts)

                for _, descendant in ipairs(character:GetDescendants()) do
                  if descendant:IsA("BasePart") then
                    table.insert(TweenController.CollisionParts, descendant)
                    descendant.CanCollide = false
                  end
                end

                return
              end
            end

            stopTween = function(arg)
              if TweenController.HeartbeatConn then
                pcall(function()
                  TweenController.HeartbeatConn:Disconnect()
                end)

                TweenController.HeartbeatConn = nil
              end

              TweenController.Playing = false

              if not arg then
                TweenController.Hovering = false
                TweenController.HoverCFrame = nil
              end

              if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                if humanoid then
                  humanoid.AutoRotate = true
                end
              end

              if TweenInstance then
                pcall(function()
                  TweenInstance:Cancel()
                  TweenInstance:Destroy()
                end)

                TweenInstance = nil
                return
              end
            end

            fn32 = function(arg, arg2, arg3)
              local now5 = os.clock()

              if arg2 then
                if arg3 then
                  if (arg2 - arg):Dot(arg3) > 8 then
                    n6 = now5 + 5
                  end
                end
              end

              if now5 < n6 then
                return 220
              end
              return 300
            end

            do
              local connection2 = nil

              local function fn33()
                if connection2 then
                  return
                end

                connection2 = Services.RunService.Stepped:Connect(function()
                  if LocalPlayer.Character then
                    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      if not TweenController.Playing then
                        if not TweenController.Hovering then
                          return
                        end
                      end

                      humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                      humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                      if TweenController.Hovering then
                        if TweenController.HoverCFrame then
                          if not TweenController.Playing then
                            humanoidRootPart.CFrame = TweenController.HoverCFrame
                          end
                        end
                      end

                      for i = #TweenController.CollisionParts, 1, -1 do
                        local v17 = TweenController.CollisionParts[i]

                        if v17 then
                          if v17.Parent then
                            if v17.CanCollide then
                              v17.CanCollide = false
                            end
                          else
                            table.remove(TweenController.CollisionParts, i)
                          end
                        else
                          table.remove(TweenController.CollisionParts, i)
                        end
                      end

                      return
                    end

                    return
                  end
                end)
              end

              fn33()

              TweenController.Update = function()
                local humanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

                if CaculateDistance(humanoidRootPart.CFrame) > 250 then
                  stopTween()
                  TweenDebounce = true
                  humanoidRootPart.CFrame = HumanoidRootPart.CFrame
                  TweenDebounce = false
                end

                HumanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 3, 0)
              end

              TweenController.Tween2 = function(arg, arg2)
                if TweenInstance2 then
                  pcall(function()
                    TweenInstance2:Cancel()
                    TweenInstance2:Destroy()
                  end)

                  TweenInstance2 = nil
                end

                TweenInstance2 = Services.TweenService:Create(arg, TweenInfo.new(CaculateDistance(arg.CFrame, arg2) / 50, Enum.EasingStyle.Linear), {CFrame = ConvertTo(CFrame, arg2) - Vector3.new(0, 0, 0)})
                TweenInstance2:Play()
              end

              local function clearGhost()
                stopTween(false)
                tweenTargetInstance = nil
                TweenController.CollisionPrepared = false
                local character = LocalPlayer.Character

                if character then
                  local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    local muse = humanoidRootPart:FindFirstChild("muse")

                    if muse then
                      muse:Destroy()
                    end

                    humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                  end

                  local head = character:FindFirstChild("Head")

                  if head then
                    local muse = head:FindFirstChild("muse")

                    if muse then
                      muse:Destroy()
                    end
                  end

                  local humanoid = character:FindFirstChildOfClass("Humanoid")

                  if humanoid then
                    pcall(function()
                      humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end)
                  end

                  for _, child in ipairs(character:GetChildren()) do
                    if child:IsA("BasePart") then
                      if child.Name ~= "HumanoidRootPart" then
                        if child.Name:find("Torso") then
                          child.CanCollide = true
                        end
                      else
                        child.CanCollide = true
                      end
                    end
                  end

                  return
                end
              end

              TweenController.ClearGhost = clearGhost

              LocalPlayer.CharacterAdded:Connect(function(character)
                TweenController.ClearGhost()
                fn33()

                task.spawn(function()
                  local humanoid = character:WaitForChild("Humanoid", 4)
                  local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 4)

                  if humanoid then
                    if humanoidRootPart then
                      repeat
                        task.wait()
                      until humanoid.Health > 0

                      task.wait(0.15)
                      if RefreshTasksData then
                        pcall(RefreshTasksData)
                        return
                      end
                    end
                  end
                end)
              end)
            end

            GetBypassSpawn = function(arg)
              local character = LocalPlayer.Character
              if not character or not character:FindFirstChild("HumanoidRootPart") then
                warn("No character/HRP found")
                return nil, math.huge
              end
              local position = character.HumanoidRootPart.Position
              local magnitude = (arg - position).Magnitude
              if magnitude < 3000 then
                warn("Distance to target < 3000, no bypass needed")
                return nil, math.huge
              end
              local v17 = (getBypassSpawn and getBypassSpawn()) or v15
              if not v17 then
                warn(" Spawns folder not found")
                return nil, math.huge
              end
              local attribute = character:GetAttribute("SpawnPoint")
              local huge = math.huge
              local v18 = nil

              for _, child in ipairs(v17:GetChildren()) do
                local part2 = (child:FindFirstChild("Part") or child:FindFirstChildWhichIsA("BasePart")) or (child:IsA("BasePart") and child)

                if part2 then
                  local magnitude2 = (part2.Position - position).Magnitude
                  local magnitude3 = (part2.Position - arg).Magnitude

                  if (((magnitude2 <= 10000) and (magnitude3 < magnitude)) and (child.Name ~= attribute)) and (magnitude3 < huge) then
                    huge = magnitude3
                    v18 = child
                  end
                end
              end

              if not v18 then
                warn("No spawn satisfies conditions")
              end

              return v18, huge
            end

            local fn33

            do
              local function fn34(arg)
                if arg then
                  local part2 = arg:FindFirstChild("Part")
                  if part2 then
                    return part2
                  end
                  return (arg:FindFirstChildWhichIsA("BasePart", true))
                end

                return nil
              end

              local function fn35(arg, arg2)
                if arg then
                  if arg2 then
                    local huge = math.huge

                    for _, descendant in ipairs(arg:GetDescendants()) do
                      if descendant:IsA("BasePart") then
                        huge = math.min(huge, (descendant.Position - arg2).Magnitude)
                      end
                    end

                    return huge
                  end

                  return math.huge
                end

                return math.huge
              end

              fn33 = function(arg)
                if arg then
                  local itemRequired = arg.item_required

                  if not itemRequired then
                    itemRequired = arg.time_required
                    if not itemRequired then
                      return true
                    end
                  end

                  local flag6 = ScriptStorage.Backpack[itemRequired] ~= nil

                  if not flag6 then
                    flag6 = ScriptStorage.Tools[itemRequired] ~= nil

                    if not flag6 then
                      if LocalPlayer.Character then
                        flag6 = LocalPlayer.Character:FindFirstChild(itemRequired) ~= nil

                        if not flag6 then
                          flag6 = LocalPlayer.Backpack
                          if flag6 then
                            local backpack = LocalPlayer.Backpack
                            return backpack:FindFirstChild(itemRequired) ~= nil
                          end
                        end
                      else
                        flag6 = LocalPlayer.Backpack
                        if flag6 then
                          return LocalPlayer.Backpack:FindFirstChild(itemRequired) ~= nil
                        end
                      end
                    end
                  end

                  return flag6
                end

                return false
              end

              local function fn36(arg, arg2)
                if arg then
                  if arg2 then
                    if arg.spawn_groups then
                      for _, spawnGroup in ipairs(arg.spawn_groups) do
                        if spawnGroup ~= arg2 then
                          continue
                        end
                        return true
                      end

                      return false
                    end

                    return false
                  end

                  return false
                end

                return false
              end

              local function fn37(arg, arg2, arg3)
                if arg then
                  if arg2 then
                    local magnitude = (arg.pos - arg2).Magnitude
                    local v17, v18

                    if arg.spawn_groups then
                      if v15 then
                        for _, spawnGroup in ipairs(arg.spawn_groups) do
                          magnitude = math.min(magnitude, fn35(v15:FindFirstChild(spawnGroup), arg2))
                        end

                        if arg3 then
                          if fn36(arg, arg3.Name) then
                            v17 = fn34
                            v18 = fn34(arg3)
                            if v18 then
                              return (math.min(magnitude, (arg.pos - v18.Position).Magnitude))
                            end
                          end
                        end
                      elseif arg3 then
                        if fn36(arg, arg3.Name) then
                          v17 = fn34
                          v18 = fn34(arg3)
                          if v18 then
                            return (math.min(magnitude, (arg.pos - v18.Position).Magnitude))
                          end
                        end
                      end
                    elseif arg3 then
                      if fn36(arg, arg3.Name) then
                        v17 = fn34
                        v18 = fn34(arg3)
                        if v18 then
                          return (math.min(magnitude, (arg.pos - v18.Position).Magnitude))
                        end
                      end
                    end

                    return magnitude
                  end

                  return math.huge
                end

                return math.huge
              end

              GetSea3EntranceCandidate = function(arg, arg2, arg3)
                if SeaIndex ~= 3 then
                  return nil, math.huge
                end

                if arg then
                  local character = LocalPlayer.Character

                  if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      local magnitude = (arg - humanoidRootPart.Position).Magnitude
                      local n7 = math.min(magnitude, arg3 or math.huge)
                      local v17 = nil
                      local v18 = nil

                      for _, v19 in pairs(Sea3Entrances) do
                        if v19.verified then
                          if fn33(v19) then
                            local magnitude2 = (v19.pos - humanoidRootPart.Position).Magnitude
                            local v20 = fn37(v19, arg, arg2)

                            if magnitude2 >= 450 then
                              if v20 < (n7 - 300) then
                                if v20 < (magnitude - 500) then
                                  if v17 then
                                    if v20 < v17 then
                                      v17 = v20
                                      v18 = v19
                                    end
                                  else
                                    v17 = v20
                                    v18 = v19
                                  end
                                end
                              end
                            end
                          end
                        end
                      end

                      if v18 then
                        return v18, v17
                      end
                      return nil, math.huge
                    end
                  end

                  return nil, math.huge
                end

                return nil, math.huge
              end
            end

            local n7
            n7 = 0
            local safeInvokeRemote, trySubmarineTravel, isSubmergedPos

            do
              local v17 = nil

              safeInvokeRemote = function(arg, arg2, ...)
                if not arg then
                  return false
                end
                local tbl9 = {...}
                local flag6 = false
                local flag7 = false
                local v18 = nil

                task.spawn(function()
                  local ok, result = pcall(function()
                    return arg:InvokeServer(table.unpack(tbl9))
                  end)

                  flag7 = ok
                  v18 = result
                  flag6 = true
                end)

                local now5 = os.clock()

                while not flag6 do
                  local n8 = os.clock() - now5

                  if arg2 then
                    if n8 < arg2 then
                      task.wait()
                      continue
                    end
                  elseif n8 < 3 then
                    task.wait()
                    continue
                  end

                  break
                end

                return flag6 and flag7, v18
              end

              local function fn37(arg)
                local Net

                pcall(function()
                  Net = require(game.ReplicatedStorage.Modules.Net)
                end)

                local modules

                if Net then
                  modules = Net:RemoteFunction(arg)

                  if not modules then
                    modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")

                    if modules then
                      modules = game.ReplicatedStorage.Modules:FindFirstChild("Net")
                      if modules then
                        return (modules:FindFirstChild("RF/" .. arg))
                      end
                    end
                  end
                else
                  modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")

                  if modules then
                    modules = game.ReplicatedStorage.Modules:FindFirstChild("Net")
                    if modules then
                      return (modules:FindFirstChild("RF/" .. arg))
                    end
                  end
                end

                return modules
              end

              local function fn38(arg)
                local SubmarineTransportation = fn37("SubmarineTransportation")

                if SubmarineTransportation then
                  local getAvailableLocations, v18 = safeInvokeRemote(SubmarineTransportation, 4, "GetAvailableLocations")

                  if getAvailableLocations then
                    if v18 ~= -1 then
                      if typeof(v18) ~= "table" then
                        return false
                      end

                      if typeof(arg) == "CFrame" then
                        arg = arg.Position or arg
                      end

                      local v19, v20, v22 = ipairs(v18)
                      local huge = math.huge
                      local v23 = nil

                      for _, v24 in v19, v20, v22 do
                        local endLocation = v24 and v24.EndLocation
                        local position

                        if typeof(endLocation) == "CFrame" then
                          position = endLocation.Position or endLocation
                        else
                          position = endLocation
                        end

                        if typeof(position) == "Vector3" then
                          local magnitude

                          if arg then
                            magnitude = (position - arg).Magnitude

                            if not magnitude then
                              magnitude = math.huge
                            end
                          else
                            magnitude = math.huge
                          end

                          if magnitude < huge then
                            huge = magnitude
                            v23 = v24
                          end
                        end
                      end

                      if v23 then
                        local initiateTeleport, v24 = safeInvokeRemote(SubmarineTransportation, 4, "InitiateTeleport", v23.Name)

                        if initiateTeleport then
                          if typeof(v24) == "table" then
                            return true
                          end
                        end
                      end

                      local initiateTeleport, v24 = safeInvokeRemote(SubmarineTransportation, 4, "InitiateTeleport", "Tiki Outpost")

                      if initiateTeleport then
                        if typeof(v24) == "table" then
                          return true
                        end
                      end

                      return false
                    end

                    return false
                  end

                  return false
                end

                return false
              end

              trySubmarineTravel = function(arg)
                if SeaIndex ~= 3 then
                  return false
                end

                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local v18 = normQuestName(arg)

                  if v18 ~= stripQuestSpaces() then
                    if v18 then
                      SetTask("MainTask", "Level Farming | Under Water | Entering Submerged")
                      if CaculateDistance(cframe) >= 8 then
                        TweenController.Create(cframe)
                        return true
                      end
                      local modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")

                      if modules then
                        local net = modules:FindFirstChild("Net")

                        if net then
                          local rfSubmarineWorkerSpeak = net:FindFirstChild("RF/SubmarineWorkerSpeak")

                          if rfSubmarineWorkerSpeak then
                            if n4 <= os.clock() then
                              n4 = os.clock() + 5

                              pcall(function()
                                rfSubmarineWorkerSpeak:InvokeServer("TravelToSubmergedIsland")
                              end)

                              pcall(function()
                                Remotes.CommF_:InvokeServer("SetLastSpawnPoint", "SubmergedIsland")
                              end)

                              stopTween(false)
                              return true
                            end
                          end
                        end
                      end

                      return true
                    end

                    SetTask("MainTask", "Level Farming | Under Water | Leaving Submerged")
                    local submarineWorker2 = matchQuestTitle("Submarine Worker2", cframe2)
                    if CaculateDistance(submarineWorker2) > 25 then
                      TweenController.Create(submarineWorker2 + Vector3.new(0, 5, 3))
                      return true
                    end

                    if stripQuestSpaces() then
                      local v19 = fn38(arg)
                      task.wait(2)

                      if stripQuestSpaces() then
                        local v20 = fn38(arg)

                        if not v19 then
                          if not v20 then
                            SetTask("MainTask", "Submerged | Surface travel unavailable or in combat")
                            return true
                          end
                        end
                      end
                    end

                    return true
                  end

                  return false
                end

                return false
              end

              local function fn39(arg)
                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local flag6 = arg.X > 50000
                  if flag6 then
                    return arg.X < 70000
                  end
                  return flag6
                end

                return false
              end

              local function fn40()
                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    local v18 = fn39(humanoidRootPart.Position)
                    if v18 then
                      return v18
                    end
                  end
                end

                return false
              end

              local cframe3 = CFrame.new(4050.31, 5, -1814.12)
              local cframe4 = CFrame.new(61170.05, 5, 1952.83)
              local cframe5 = CFrame.new(61726.28, 528, -1559.27)

              local function fn41(arg, arg2)
                if arg then
                  if arg2 then
                    pcall(function()
                      if typeof(firetouchinterest) ~= "function" then
                        return
                      end
                      firetouchinterest(arg, arg2, 0)
                      firetouchinterest(arg, arg2, 1)
                    end)

                    pcall(function()
                      if typeof(firesignal) ~= "function" then
                        return
                      end
                      firesignal(arg2.Touched, arg)
                    end)

                    pcall(function()
                      if typeof(getconnections) ~= "function" then
                        return
                      end

                      for _, v18 in ipairs(getconnections(arg2.Touched)) do
                        if v18.Function then
                          v18.Function(arg)
                        else
                          v18:Fire(arg)
                        end
                      end
                    end)

                    return
                  end
                end
              end

              local function fn42(arg)
                if SeaIndex ~= 1 then
                  return false
                end

                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local v18 = fn39(arg)
                  if v18 == fn40() then
                    return false
                  end

                  if LocalPlayer.Character then
                    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      if v18 then
                        SetTask("MainTask", "Entering Underwater Island (Whirlpool)")
                        if (humanoidRootPart.Position - cframe3.Position).Magnitude > 25 then
                          TweenController.Create(cframe3)
                          return true
                        end
                        fn41(humanoidRootPart, workspace.Map:FindFirstChild("TeleportSpawn") and workspace.Map.TeleportSpawn:FindFirstChild("Entrance"))

                        pcall(function()
                          Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.75, 1819.780029296875))
                        end)

                        task.wait(1.5)
                        return true
                      end

                      SetTask("MainTask", "Leaving Underwater Island")

                      if humanoidRootPart.Position.Y > 300 then
                        if humanoidRootPart.Position.X > 61500 then
                          if (humanoidRootPart.Position - cframe5.Position).Magnitude > 25 then
                            TweenController.Create(cframe5)
                            return true
                          end
                          fn41(humanoidRootPart, (workspace.Map:FindFirstChild("Fishmen") and workspace.Map.Fishmen:FindFirstChild("FishmanCavern")) and workspace.Map.Fishmen.FishmanCavern:FindFirstChild("Entrance"))
                          task.wait(1.5)
                          return true
                        end
                      end

                      if (humanoidRootPart.Position - cframe4.Position).Magnitude > 25 then
                        TweenController.Create(cframe4)
                        return true
                      end
                      fn41(humanoidRootPart, workspace.Map:FindFirstChild("TeleportSpawn") and workspace.Map.TeleportSpawn:FindFirstChild("Exit"))

                      pcall(function()
                        Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(3864.679931640625, 6.74, -1926.2099609375))
                      end)

                      task.wait(1.5)
                      return true
                    end
                  end

                  return false
                end

                return false
              end

              local function fn43(arg)
                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local flag6 = arg.Y > 3000

                  if flag6 then
                    flag6 = arg.X < -5000
                    if flag6 then
                      return arg.X > -9000
                    end
                  end

                  return flag6
                end

                return false
              end

              local function fn44()
                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    local v18 = fn43(humanoidRootPart.Position)
                    if v18 then
                      return v18
                    end
                  end
                end

                return false
              end

              CFrame.new(-4208.15, 1089.88, -373.05)
              CFrame.new(-6022.23, 5470.49, 2217.33)

              local function fn45(arg)
                if SeaIndex ~= 1 then
                  return false
                end

                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local v18 = fn43(arg)

                  if v18 ~= fn44() then
                    if LocalPlayer.Character then
                      if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        if v18 then
                          SetTask("MainTask", "Entering Upper Skylands")
                          TweenController.Create(CFrame.new(arg), true)
                          return true
                        end

                        SetTask("MainTask", "Leaving Upper Skylands")
                        TweenController.Create(CFrame.new(arg), true)
                        return true
                      end

                      return false
                    end

                    return false
                  end

                  return false
                end

                return false
              end

              isSubmergedPos = function(arg)
                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  local flag6 = arg.Z > 25000

                  if flag6 then
                    flag6 = arg.X > -2000
                    if flag6 then
                      return arg.X < 3000
                    end
                  end

                  return flag6
                end

                return false
              end

              local cframe6 = CFrame.new(-6496.89, 89.03, -116.51)
              local cframe7 = CFrame.new(920.48, 154.9, 32838.96)

              local function fn46(arg)
                if typeof(arg) == "CFrame" then
                  arg = arg.Position or arg
                end

                if typeof(arg) ~= "Vector3" then
                  return false
                end

                if workspace:FindFirstChild("Map") then
                  local ghostShipInterior = workspace.Map:FindFirstChild("GhostShipInterior")

                  if ghostShipInterior then
                    if ghostShipInterior:IsA("Model") then
                      local ok, result, result2 = pcall(function()
                        return ghostShipInterior:GetBoundingBox()
                      end)

                      if ok then
                        local v18 = result:PointToObjectSpace(arg)
                        local n8 = (result2.X / 2) + 60
                        local flag6 = math.abs(v18.X) <= n8

                        if flag6 then
                          local n9 = (result2.Y / 2) + 60
                          flag6 = math.abs(v18.Y) <= n9
                          if flag6 then
                            local n10 = (result2.Z / 2) + 60
                            return math.abs(v18.Z) <= n10
                          end
                        end

                        return flag6
                      end
                    end
                  end
                end

                return (arg - cframe7.Position).Magnitude <= 1000
              end

              local function fn47(arg)
                if SeaIndex ~= 2 then
                  return false
                end

                if arg then
                  if typeof(arg) == "CFrame" then
                    arg = arg.Position or arg
                  end

                  if LocalPlayer.Character then
                    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      local v18 = fn46(arg)

                      if v18 ~= fn46(humanoidRootPart.Position) then
                        if v18 then
                          SetTask("MainTask", "Entering Cursed Ship")
                          if (humanoidRootPart.Position - cframe6.Position).Magnitude > 25 then
                            TweenController.Create(cframe6)
                            return true
                          end
                          fn41(humanoidRootPart, workspace.Map:FindFirstChild("GhostShip") and workspace.Map.GhostShip:FindFirstChild("Teleport"))

                          pcall(function()
                            Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.2100219726562, 126.97000122070312, 32852.828125))
                          end)

                          task.wait(1.5)
                          return true
                        end

                        SetTask("MainTask", "Leaving Cursed Ship")
                        if (humanoidRootPart.Position - cframe7.Position).Magnitude > 25 then
                          TweenController.Create(cframe7)
                          return true
                        end
                        fn41(humanoidRootPart, workspace.Map:FindFirstChild("GhostShipInterior") and workspace.Map.GhostShipInterior:FindFirstChild("Teleport"))

                        pcall(function()
                          Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5498046875, 89.02999877929688, -132.83999633789062))
                        end)

                        task.wait(1.5)
                        return true
                      end

                      return false
                    end
                  end

                  return false
                end

                return false
              end

              GetSea3DirectEntrance = function(arg)
                if SeaIndex ~= 3 then
                  return nil
                end

                if arg then
                  if normQuestName(arg) then
                    return nil
                  end

                  if stripQuestSpaces() then
                    return nil
                  end
                  local character = LocalPlayer.Character

                  if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      local magnitude = (arg - humanoidRootPart.Position).Magnitude
                      local v18 = nil
                      local v19 = nil

                      for _, v20 in pairs(Sea3Entrances) do
                        local directRadius = v20.direct_radius

                        if v20.verified then
                          if directRadius then
                            if fn33(v20) then
                              local magnitude2 = (arg - v20.pos).Magnitude
                              local magnitude3 = (v20.pos - humanoidRootPart.Position).Magnitude

                              if magnitude2 <= directRadius then
                                if magnitude3 >= 450 then
                                  if magnitude > 3000 then
                                    if v18 then
                                      if magnitude2 < v18 then
                                        v18 = magnitude2
                                        v19 = v20
                                      end
                                    else
                                      v18 = magnitude2
                                      v19 = v20
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end

                      return v19
                    end
                  end

                  return nil
                end

                return nil
              end

              TrySea3DirectEntrance = function(arg)
                local v18 = GetSea3DirectEntrance(arg)
                if not v18 then
                  return false
                end
                local str4 = tostring(v18.island or v18.pos)

                if v17 == str4 then
                  if (os.clock() - n7) < 1.5 then
                    return true
                  end
                end

                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    local magnitude = (arg - humanoidRootPart.Position).Magnitude
                    local magnitude2 = (v18.pos - humanoidRootPart.Position).Magnitude

                    local ok = pcall(function()
                      Remotes.CommF_:InvokeServer("requestEntrance", v18.pos)
                    end)

                    task.wait(0.25)
                    local character = LocalPlayer.Character

                    if character then
                      character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                      if ok then
                        n7 = os.clock()
                        v17 = str4
                        warn("requestEntrance direct -> " .. str4)
                        return true
                      end
                    elseif ok then
                      n7 = os.clock()
                      v17 = str4
                      warn("requestEntrance direct -> " .. str4)
                      return true
                    end

                    if character then
                      local magnitude3 = (arg - character.Position).Magnitude

                      if (v18.pos - character.Position).Magnitude >= math.min(magnitude2 - 250, 650) then
                        if magnitude3 >= (magnitude - 250) then
                          warn("requestEntrance direct failed -> " .. str4)
                          return false
                        end
                      end

                      n7 = os.clock()
                      v17 = str4
                      warn("requestEntrance direct -> " .. str4)
                      return true
                    end

                    warn("requestEntrance direct failed -> " .. str4)
                    return false
                  end
                end

                return false
              end

              TrySea3EntranceBridge = function(arg, arg2, arg3)
                if normQuestName(arg) then
                  return false
                end

                if stripQuestSpaces() then
                  return false
                end
                local v18 = GetSea3EntranceCandidate(arg, arg2, arg3)
                if not v18 then
                  return false
                end
                local magnitude

                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    magnitude = (arg - humanoidRootPart.Position).Magnitude or math.huge
                  else
                    magnitude = math.huge
                  end
                else
                  magnitude = math.huge
                end

                local ok = pcall(function()
                  Remotes.CommF_:InvokeServer("requestEntrance", v18.pos)
                end)

                task.wait(0.25)
                local magnitude2, v19

                if LocalPlayer.Character then
                  local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                  local island, v20, v22, island2

                  if humanoidRootPart then
                    magnitude2 = (arg - humanoidRootPart.Position).Magnitude

                    if not magnitude2 then
                      magnitude2 = math.huge
                    end
                  else
                    magnitude2 = math.huge
                  end

                  if ok then
                    if magnitude2 < (magnitude - 250) then
                      n7 = os.clock()
                      v19 = tostring
                      island = v18.island or v18.pos
                      v17 = v19(island)
                      v20 = warn
                      v22 = tostring
                      island2 = v18.island or v18.pos
                      v20("requestEntrance bridge -> " .. v22(island2))
                      return true
                    end
                  end
                else
                  magnitude2 = math.huge

                  if ok then
                    if magnitude2 < (magnitude - 250) then
                      n7 = os.clock()
                      v19 = tostring
                      v17 = v19(v18.island or v18.pos)
                      warn("requestEntrance bridge -> " .. tostring(v18.island or v18.pos))
                      return true
                    end
                  end
                end

                return false
              end

              GetPortalCandidate = function(arg)
                local v18 = nil
                local n8 = 9000000000
                local v19 = nil

                for _, v20 in ipairs(Portals) do
                  local v22 = CaculateDistance(v20, arg)

                  if v22 < (CaculateDistance(arg) - 300) then
                    if v22 < n8 then
                      n8 = v22
                      v19 = v20
                    end
                  end
                end

                return v19, n8
              end

              GetPortal = function(arg)
                local n8 = 9000000000
                local v18

                for _, v19 in ipairs(Portals) do
                  local v20 = CaculateDistance(v19, arg)

                  if v20 < (CaculateDistance(arg) - 300) then
                    if v20 < n8 then
                      n8 = v20
                      v18 = v19
                    end
                  end
                end

                if v18 then
                  Remotes.CommF_:InvokeServer("requestEntrance", v18)
                  return task.wait()
                end
              end

              TweenController.Create = function(arg, arg2, arg3)
                local v18, v19, v20, v22, character, humanoidRootPart, flag6, position, flag7, muse, head, cframe8, position2, v23, v24, humanoid
                v18 = arg
                v19 = arg2
                v20 = arg3

                if v18 then
                  if not TweenDebounce then
                    if typeof(v18) ~= "CFrame" then
                      v22 = ConvertTo(CFrame, v18)

                      if v22 then
                        v18 = v22
                      end
                    end

                    character = LocalPlayer.Character

                    if character then
                      humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    else
                      humanoidRootPart = character
                    end

                    if not not humanoidRootPart then
                      flag6 = SeaIndex ~= 1

                      if flag6 then
                        flag6 = CombatController.IsRaidActive()
                      end

                      if typeof(v18) ~= "CFrame" then
                        position = v18
                      else
                        position = v18.Position

                        if not position then
                          position = v18
                        end
                      end

                      flag7 = math.abs(position.X) < 25000

                      if flag7 then
                        flag7 = math.abs(position.Z) < 25000
                      end

                      if flag6 then
                        if flag7 then
                          return
                        end
                      end

                      if TweenController.Playing then
                        if tweenTargetInstance then
                          if (tweenTargetInstance.Position - v18.Position).Magnitude < 8 then
                            return
                          end
                        end
                      end

                      stopTween()
                      tweenTargetInstance = v18
                      n5 = os.clock()
                      muse = humanoidRootPart:FindFirstChild("muse")

                      if not muse then
                        muse = Instance.new("BodyVelocity")
                      end

                      muse.Name = "muse"
                      muse.MaxForce = Vector3.new(0, math.huge, 0)
                      muse.Velocity = Vector3.new(0, 0, 0)
                      muse.Parent = humanoidRootPart
                      head = LocalPlayer.Character:FindFirstChild("Head")

                      if head then
                        if head:FindFirstChild("muse") then
                          head.muse:Destroy()
                        end
                      end

                      humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                      humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                      if not v19 then
                        if trySubmarineTravel(v18.Position) then
                          return
                        end

                        if fn42(v18.Position) then
                          return
                        end

                        if fn45(v18.Position) then
                          return
                        end

                        if fn47(v18.Position) then
                          return
                        end
                      end

                      cframe8 = CFrame.new(v18.Position)
                      position2 = cframe8.Position
                      v23 = nil
                      v24 = nil
                      TweenController.Playing = true
                      fn30()

                      if LocalPlayer.Character then
                        humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                        if humanoid then
                          humanoid.AutoRotate = false
                        end
                      end

                      local function fn48(deltaTime)
                        if TweenController.Playing then
                          if humanoidRootPart then
                            if humanoidRootPart.Parent then
                              if LocalPlayer.Character then
                                local position3 = humanoidRootPart.Position
                                local n8 = position2 - position3
                                local magnitude = n8.Magnitude
                                local n9

                                if Config.FastTween then
                                  n9 = fn32(position3, v23, v24)

                                  if magnitude < 18 then
                                    n9 = 25
                                  end
                                elseif Config.TweenFast then
                                  n9 = fn32(position3, v23, v24)

                                  if magnitude < 18 then
                                    n9 = 25
                                  end
                                elseif magnitude < 18 then
                                  n9 = 100
                                elseif magnitude <= 80 then
                                  n9 = 160
                                else
                                  n9 = 220
                                end

                                local n10 = n9 * math.min(deltaTime, 0.07)

                                if magnitude <= math.max(n10, 1.5) then
                                  humanoidRootPart.CFrame = cframe8
                                  if v20 then
                                    stopTween(false)
                                    return
                                  end
                                  TweenController.Hovering = true
                                  TweenController.HoverCFrame = cframe8
                                  stopTween(true)
                                  return
                                end

                                local unit = n8.Unit
                                local n11 = position3 + (unit * n10)
                                v23 = n11
                                v24 = unit
                                humanoidRootPart.CFrame = CFrame.new(n11, position2)
                                return
                              end

                              stopTween(false)
                              return
                            end

                            stopTween(false)
                            return
                          end

                          stopTween(false)
                          return
                        end

                        stopTween(false)
                      end

                      TweenController.HeartbeatConn = Services.RunService.Heartbeat:Connect(fn48)
                    end
                  end
                end

                return
              end

              TweenController.CreateDirect = function(arg, arg2, arg3)
                if arg then
                  if TweenDebounce then
                    return
                  end

                  if typeof(arg) ~= "CFrame" then
                    arg = ConvertTo(CFrame, arg) or arg
                  end

                  if LastDirectTweenAt then
                    local v18 = LastDirectTweenAt

                    if (os.clock() - v18) < 0.06 then
                      if LastDirectTweenPosition then
                        if CaculateDistance(LastDirectTweenPosition, arg) < 3 then
                          return
                        end
                      end
                    end
                  end

                  LastDirectTweenAt = os.clock()
                  LastDirectTweenPosition = arg
                  tweenTargetInstance = arg
                  stopTween()
                  local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                  if not humanoidRootPart then
                    return
                  end
                  local flag6 = (SeaIndex ~= 1) and CombatController.IsRaidActive()
                  local flag7 = math.abs(arg.Position.X) < 25000
                  local muse, v18, position, v19, v20, humanoid, n8, fn48

                  if flag7 then
                    flag7 = math.abs(arg.Position.Z) < 25000
                  end

                  if not flag6 then
                    if not arg2 then
                      if trySubmarineTravel(arg.Position) then
                        return
                      end

                      if fn42(arg.Position) then
                        return
                      end

                      if fn45(arg.Position) then
                        return
                      end

                      if fn47(arg.Position) then
                        return
                      end
                    end

                    muse = humanoidRootPart:FindFirstChild("muse") or Instance.new("BodyVelocity")
                    muse.Name = "muse"
                    muse.MaxForce = Vector3.new(0, math.huge, 0)
                    muse.Velocity = Vector3.new(0, 0, 0)
                    muse.Parent = humanoidRootPart
                    humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    v18 = arg
                    position = arg.Position
                    v19 = nil
                    v20 = nil
                    TweenController.Playing = true
                    fn30()

                    if LocalPlayer.Character then
                      humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                      if humanoid then
                        humanoid.AutoRotate = false
                      end
                    end

                    fn48 = function(deltaTime)
                      if TweenController.Playing then
                        if humanoidRootPart then
                          if humanoidRootPart.Parent then
                            if LocalPlayer.Character then
                              local position2 = humanoidRootPart.Position
                              local n9 = position - position2
                              local magnitude = n9.Magnitude
                              local n10

                              if Config.FastTween then
                                n10 = fn32(position2, v19, v20)

                                if magnitude < 18 then
                                  n10 = 25
                                end
                              elseif Config.TweenFast then
                                n10 = fn32(position2, v19, v20)

                                if magnitude < 18 then
                                  n10 = 25
                                end
                              elseif magnitude < 18 then
                                n10 = 100
                              elseif magnitude <= 80 then
                                n10 = 160
                              else
                                n10 = 220
                              end

                              local n11 = n10 * math.min(deltaTime, 0.07)

                              if magnitude <= math.max(n11, 1.5) then
                                humanoidRootPart.CFrame = v18
                                if arg3 then
                                  stopTween(false)
                                  return
                                end
                                TweenController.Hovering = true
                                TweenController.HoverCFrame = v18
                                stopTween(true)
                                return
                              end

                              local unit = n9.Unit
                              local n12 = position2 + (unit * n11)
                              v19 = n12
                              v20 = unit
                              humanoidRootPart.CFrame = CFrame.new(n12, position)
                              return
                            end

                            stopTween(false)
                            return
                          end

                          stopTween(false)
                          return
                        end

                        stopTween(false)
                        return
                      end

                      stopTween(false)
                    end

                    TweenController.HeartbeatConn = Services.RunService.Heartbeat:Connect(fn48)
                    return
                  end

                  if flag7 then
                    return
                  end

                  if not arg2 then
                    if trySubmarineTravel(arg.Position) then
                      return
                    end

                    if fn42(arg.Position) then
                      return
                    end

                    if fn45(arg.Position) then
                      return
                    end

                    if fn47(arg.Position) then
                      return
                    end
                  end

                  muse = humanoidRootPart:FindFirstChild("muse") or Instance.new("BodyVelocity")
                  muse.Name = "muse"
                  muse.MaxForce = Vector3.new(0, math.huge, 0)
                  muse.Velocity = Vector3.new(0, 0, 0)
                  muse.Parent = humanoidRootPart
                  humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                  humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                  v18 = arg
                  position = arg.Position
                  v19 = nil
                  v20 = nil
                  TweenController.Playing = true
                  fn30()

                  if LocalPlayer.Character then
                    humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                    if humanoid then
                      humanoid.AutoRotate = false
                    end
                  end

                  fn48 = function(arg4)
                    if TweenController.Playing then
                      if humanoidRootPart then
                        if humanoidRootPart.Parent then
                          if LocalPlayer.Character then
                            local position2 = humanoidRootPart.Position
                            local n9 = position - position2
                            local magnitude = n9.Magnitude
                            local n10

                            if Config.FastTween then
                              n10 = fn32(position2, v19, v20)

                              if magnitude < 18 then
                                n10 = 25
                              end
                            elseif Config.TweenFast then
                              n10 = fn32(position2, v19, v20)

                              if magnitude < 18 then
                                n10 = 25
                              end
                            elseif magnitude < 18 then
                              n10 = 100
                            elseif magnitude <= 80 then
                              n10 = 160
                            else
                              n10 = 220
                            end

                            local n11 = n10 * math.min(arg4, 0.07)

                            if magnitude <= math.max(n11, 1.5) then
                              humanoidRootPart.CFrame = v18
                              if arg3 then
                                stopTween(false)
                                return
                              end
                              TweenController.Hovering = true
                              TweenController.HoverCFrame = v18
                              stopTween(true)
                              return
                            end

                            local unit = n9.Unit
                            local n12 = position2 + (unit * n11)
                            v19 = n12
                            v20 = unit
                            humanoidRootPart.CFrame = CFrame.new(n12, position)
                            return
                          end

                          stopTween(false)
                          return
                        end

                        stopTween(false)
                        return
                      end

                      stopTween(false)
                      return
                    end

                    stopTween(false)
                  end

                  TweenController.HeartbeatConn = Services.RunService.Heartbeat:Connect(fn48)
                  return
                end
              end
            end

            local FastAttack
            FastAttack = {}
            local PlayersService
            PlayersService = game:GetService("Players")
            local VirtualInputMgr

            do
              local ReplicatedStorage = game:GetService("ReplicatedStorage")
              local Workspace = game:GetService("Workspace")
              VirtualInputMgr = game:GetService("VirtualInputManager")
              local localPlayer3 = PlayersService.LocalPlayer
              local modules = ReplicatedStorage:WaitForChild("Modules")
              local net = modules:WaitForChild("Net")
              local reRegisterAttack = net:WaitForChild("RE/RegisterAttack")
              local reRegisterHit = net:WaitForChild("RE/RegisterHit")
              local reShootGunEvent = net:WaitForChild("RE/ShootGunEvent")
              local validator2 = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Validator2")
              local tbl10 = {AttackDistance = 65, AttackMobs = true, AttackPlayers = true, AttackCooldown = 0.01, ComboResetTime = 0.01, MaxCombo = 2, HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"}, AutoClickEnabled = true}
              local index = {}
              index.__index = index

              index.new = function()
                local obj = setmetatable({Debounce = 0, ComboDebounce = 0, ShootDebounce = 0, M1Combo = 0, EnemyRootPart = nil, Connections = {}, Overheat = {Dragonstorm = {MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 350, Shooting = false}}, ShootsPerTarget = {["Dual Flintlock"] = 2}, SpecialShoots = {["Skull Guitar"] = "TAP", Bazooka = "Position", Cannon = "Position", Dragonstorm = "Overheat"}}, index)

                pcall(function()
                  obj.CombatFlags = require(modules.Flags).COMBAT_REMOTE_THREAD
                  local localScript = localPlayer3:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")

                  if localScript then
                    if getsenv then
                      obj.HitFunction = getsenv(localScript)._G.SendHitsToServer
                      return
                    end
                  end
                end)

                task.spawn(function()
                  pcall(function()
                    local combatController = ReplicatedStorage:WaitForChild("Controllers", 10):WaitForChild("CombatController", 10)
                    local module = require(combatController)
                    local v17

                    if module then
                      if module.Attack then
                        v17 = getupvalue(module.Attack, 9) or nil
                      else
                        v17 = nil
                        obj.ShootFunction = v17
                        return
                      end
                    else
                      v17 = nil
                      obj.ShootFunction = v17
                      return
                    end

                    obj.ShootFunction = v17
                  end)
                end)

                return obj
              end

              index.IsEntityAlive = function(arg, arg2)
                if arg2 then
                  arg2 = arg2:FindFirstChild("Humanoid")
                  if arg2 then
                    return arg2.Health > 0
                  end
                end

                return arg2
              end

              index.CheckStun = function(arg, arg2, arg3, arg4)
                local stun = arg2:FindFirstChild("Stun")
                local busy = arg2:FindFirstChild("Busy")

                if arg3.Sit then
                  if arg4 == "Sword" then
                    return false
                  end

                  if arg4 == "Melee" then
                    return false
                  end

                  if arg4 == "Blox Fruit" then
                    return false
                  end
                end

                if stun then
                  if stun.Value > 0 then
                    return false
                  end

                  if busy then
                    if busy.Value then
                      return false
                    end
                  end
                elseif busy then
                  if busy.Value then
                    return false
                  end
                end

                return true
              end

              index.GetBladeHits = function(arg, arg2, arg3)
                local position = arg2:GetPivot().Position
                local tbl11 = {}
                local attackDistance = arg3 or tbl10.AttackDistance

                local function fn37(arg4)
                  for _, child in ipairs(arg4:GetChildren()) do
                    pcall(function()
                      if child ~= arg2 then
                        if arg:IsEntityAlive(child) then
                          local humanoidRootPart = child:FindFirstChild(tbl10.HitboxLimbs[math.random(#tbl10.HitboxLimbs)])
                          local v17, insert, tbl12

                          if humanoidRootPart then
                            if (position - humanoidRootPart.Position).Magnitude <= attackDistance then
                              if arg.EnemyRootPart then
                                v17 = tbl11
                                table.insert(tbl11, {child, humanoidRootPart})
                                insert = table.insert
                                tbl12 = {}
                                if nil <= nil then
                                  insert(tbl11, tbl12)
                                  return
                                end
                                return
                              end

                              arg.EnemyRootPart = humanoidRootPart
                              return
                            end
                          else
                            humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

                            if humanoidRootPart then
                              if (position - humanoidRootPart.Position).Magnitude <= attackDistance then
                                if arg.EnemyRootPart then
                                  v17 = tbl11
                                  table.insert(tbl11, {child, humanoidRootPart})
                                  insert = table.insert
                                  tbl12 = {}
                                  if nil <= nil then
                                    insert(tbl11, tbl12)
                                    return
                                  end
                                  return
                                end

                                arg.EnemyRootPart = humanoidRootPart
                                return
                              end
                            end
                          end
                        end

                        return
                      end
                    end)
                  end
                end

                if tbl10.AttackMobs then
                  pcall(fn37, Workspace.Enemies)
                end

                if tbl10.AttackPlayers then
                  pcall(fn37, Workspace.Characters, true)
                  return tbl11
                end
                return tbl11
              end

              index.GetClosestEnemy = function(arg, arg2, arg3)
                local bladeHits = arg:GetBladeHits(arg2, arg3)
                local huge = math.huge
                local v17 = nil

                for _, bladeHit in ipairs(bladeHits) do
                  local position = bladeHit[2].Position
                  local magnitude = (arg2:GetPivot().Position - position).Magnitude

                  if magnitude < huge then
                    v17 = bladeHit[2]
                    huge = magnitude
                  end
                end

                return v17
              end

              index.GetCombo = function(arg)
                local comboDebounce = arg.ComboDebounce
                local m1Combo

                if (tick() - comboDebounce) <= tbl10.ComboResetTime then
                  m1Combo = arg.M1Combo or 0
                else
                  m1Combo = 0
                end

                local m1Combo2 = ((tbl10.MaxCombo <= m1Combo) and 1) or (m1Combo + 1)
                arg.ComboDebounce = tick()
                arg.M1Combo = m1Combo2
                return m1Combo2
              end

              index.ShootInTarget = function(arg, arg2)
                local character = localPlayer3.Character

                if arg:IsEntityAlive(character) then
                  local tool = character:FindFirstChildOfClass("Tool")

                  if tool then
                    if tool.ToolTip ~= "Gun" then
                      return
                    end
                    local n8

                    if tool:FindFirstChild("Cooldown") then
                      n8 = tool.Cooldown.Value or 0.3
                    else
                      n8 = 0.3
                    end

                    local shootDebounce = arg.ShootDebounce
                    if (tick() - shootDebounce) < n8 then
                      return
                    end
                    local str4 = arg.SpecialShoots[tool.Name]

                    if str4 then
                      local v17, setAttribute, attribute

                      if str4 ~= "Position" then
                        if str4 == "TAP" then
                          if tool:FindFirstChild("RemoteEvent") then
                            v17 = tool
                            setAttribute = tool.SetAttribute
                            attribute = tool:GetAttribute("LocalTotalShots") or 0
                            setAttribute(v17, "LocalTotalShots", attribute + 1)
                            validator2:FireServer(arg:GetValidator2())

                            if str4 ~= "TAP" then
                              reShootGunEvent:FireServer(arg2)
                            else
                              tool.RemoteEvent:FireServer("TAP", arg2)
                            end

                            arg.ShootDebounce = tick()
                            return
                          end
                        end

                        VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        task.wait(0.05)
                        VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        arg.ShootDebounce = tick()
                        return
                      end

                      v17 = tool
                      setAttribute = tool.SetAttribute
                      attribute = tool:GetAttribute("LocalTotalShots") or 0
                      setAttribute(v17, "LocalTotalShots", attribute + 1)
                      validator2:FireServer(arg:GetValidator2())

                      if str4 ~= "TAP" then
                        reShootGunEvent:FireServer(arg2)
                      else
                        tool.RemoteEvent:FireServer("TAP", arg2)
                      end

                      arg.ShootDebounce = tick()
                      return
                    end

                    str4 = "Normal"

                    if str4 == "TAP" then
                      if tool:FindFirstChild("RemoteEvent") then
                        tool:SetAttribute("LocalTotalShots", (tool:GetAttribute("LocalTotalShots") or 0) + 1)
                        validator2:FireServer(arg:GetValidator2())

                        if str4 ~= "TAP" then
                          reShootGunEvent:FireServer(arg2)
                        else
                          tool.RemoteEvent:FireServer("TAP", arg2)
                        end

                        arg.ShootDebounce = tick()
                        return
                      end
                    end

                    VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.05)
                    VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    arg.ShootDebounce = tick()
                    return
                  end

                  return
                end
              end

              local function getValidator2(arg)
                if arg.ShootFunction then
                  local v17 = getupvalue(arg.ShootFunction, 15)
                  local v18 = getupvalue(arg.ShootFunction, 13)
                  local v19 = getupvalue(arg.ShootFunction, 16)
                  local v20 = getupvalue(arg.ShootFunction, 17)
                  local v22 = getupvalue(arg.ShootFunction, 14)
                  local v23 = getupvalue(arg.ShootFunction, 12)
                  local v24 = getupvalue(arg.ShootFunction, 18)
                  local n8 = (((((v22 * v18) + (v23 * v17)) % v19) * v19) + (v23 * v18)) % v20
                  local n9 = math.floor(n8 / v19)
                  local n10 = n8 - (n9 * v19)
                  local n11 = v24 + 1
                  setupvalue(arg.ShootFunction, 15, v17)
                  setupvalue(arg.ShootFunction, 13, v18)
                  setupvalue(arg.ShootFunction, 16, v19)
                  setupvalue(arg.ShootFunction, 17, v20)
                  setupvalue(arg.ShootFunction, 14, n9)
                  setupvalue(arg.ShootFunction, 12, n10)
                  setupvalue(arg.ShootFunction, 18, n11)
                  return math.floor((n8 / v20) * 16777215), n11
                end

                return 0, 0
              end

              index.GetValidator2 = getValidator2

              index.UseNormalClick = function(arg, arg2, arg3, arg4)
                arg.EnemyRootPart = nil
                local bladeHits = arg:GetBladeHits(arg2)

                if arg.EnemyRootPart then
                  reRegisterAttack:FireServer(arg4)

                  if arg.CombatFlags then
                    if arg.HitFunction then
                      arg.HitFunction(arg.EnemyRootPart, bladeHits)
                      return
                    end
                  end

                  reRegisterHit:FireServer(arg.EnemyRootPart, bladeHits)
                  return
                end
              end

              index.UseFruitM1 = function(arg, arg2, arg3, arg4)
                local bladeHits = arg:GetBladeHits(arg2)
                if bladeHits[1] then
                  arg3.LeftClickRemote:FireServer((bladeHits[1][2].Position - arg2:GetPivot().Position).Unit, arg4)
                  return
                end
              end

              index.Attack = function(arg)
                if tbl10.AutoClickEnabled then
                  local debounce = arg.Debounce
                  if (tick() - debounce) < tbl10.AttackCooldown then
                    return
                  end
                  local character = localPlayer3.Character

                  if character then
                    if arg:IsEntityAlive(character) then
                      local humanoid = character.Humanoid
                      local tool = character:FindFirstChildOfClass("Tool")

                      if tool then
                        local toolTip = tool.ToolTip

                        if table.find({"Melee", "Blox Fruit", "Sword", "Gun"}, toolTip) then
                          local attackCooldown

                          if tool:FindFirstChild("Cooldown") then
                            attackCooldown = tool.Cooldown.Value or tbl10.AttackCooldown
                          else
                            attackCooldown = tbl10.AttackCooldown
                          end

                          if arg:CheckStun(character, humanoid, toolTip) then
                            local combo = arg:GetCombo()
                            local n8 = ((tbl10.MaxCombo <= combo) and 0.05) or 0
                            local n9 = attackCooldown + n8
                            local now5

                            if tbl10.MaxCombo <= combo then
                              if toolTip ~= "Gun" then
                                now5 = (tick() + 0.05) or tick()
                              else
                                now5 = tick()
                              end
                            else
                              now5 = tick()
                            end

                            arg.Debounce = now5

                            if toolTip == "Blox Fruit" then
                              if tool:FindFirstChild("LeftClickRemote") then
                                arg:UseFruitM1(character, tool, combo)
                                return
                              end
                            end

                            if toolTip == "Gun" then
                              local closestEnemy = arg:GetClosestEnemy(character, 120)
                              if closestEnemy then
                                arg:ShootInTarget(closestEnemy.Position)
                                return
                              end
                              return
                            end

                            arg:UseNormalClick(character, humanoid, n9)
                            return
                          end

                          return
                        end

                        return
                      end

                      return
                    end

                    return
                  end

                  return
                end
              end

              pcall(function()
                local net2 = game.ReplicatedStorage.Modules.Net
                net2:WaitForChild("RE/RegisterHit")
                net2:WaitForChild("RE/RegisterAttack")
                local tbl11 = {}

                local function fn37()
                  local tbl12 = {}
                  local character = LocalPlayer.Character
                  local position

                  if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      position = humanoidRootPart.Position or Vector3.new(0, 0, 0)
                    else
                      position = Vector3.new(0, 0, 0)
                    end
                  else
                    position = Vector3.new(0, 0, 0)
                  end

                  local enemies = Services.Workspace:FindFirstChild("Enemies")

                  if enemies then
                    for _, child in ipairs(enemies:GetChildren()) do
                      local humanoid = child:FindFirstChild("Humanoid")
                      local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

                      if humanoid then
                        if humanoidRootPart then
                          if humanoid.Health > 0 then
                            if (humanoidRootPart.Position - position).Magnitude <= 75 then
                              table.insert(tbl12, child)
                            end
                          end
                        end
                      end
                    end

                    return tbl12
                  end

                  return tbl12
                end

                GetAllBladeHits = fn37

                local function fn38()
                  local tbl12 = {}
                  local character = LocalPlayer.Character
                  local position

                  if character then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      position = humanoidRootPart.Position or Vector3.new(0, 0, 0)
                    else
                      position = Vector3.new(0, 0, 0)
                    end
                  else
                    position = Vector3.new(0, 0, 0)
                  end

                  local characters = Services.Workspace:FindFirstChild("Characters")

                  if characters then
                    for _, child in ipairs(characters:GetChildren()) do
                      if child ~= character then
                        if child:FindFirstChild("Humanoid") then
                          if child:FindFirstChild("HumanoidRootPart") then
                            if child.Humanoid.Health > 0 then
                              if (child.HumanoidRootPart.Position - position).Magnitude <= 75 then
                                table.insert(tbl12, child)
                              end
                            end
                          end
                        end
                      end
                    end

                    return tbl12
                  end

                  return tbl12
                end

                Getplayerhit = fn38
                local net3 = Services.ReplicatedStorage.Modules.Net
                local RegisterAttack = require(net3):RemoteEvent("RegisterAttack", true)
                local RegisterHit = require(net3):RemoteEvent("RegisterHit", true)

                local function attack()
                  local tbl12 = {}

                  for _, v17 in ipairs(GetAllBladeHits()) do
                    table.insert(tbl12, v17)
                  end

                  for _, v17 in ipairs(Getplayerhit()) do
                    table.insert(tbl12, v17)
                  end

                  if #tbl12 ~= 0 then
                    local v17 = tbl12[1]

                    if v17 then
                      local head = v17:FindFirstChild("Head")
                      local humanoidRootPart

                      if head then
                        humanoidRootPart = head
                      else
                        humanoidRootPart = v17:FindFirstChild("HumanoidRootPart")
                        if not humanoidRootPart then
                          return
                        end
                      end

                      local tbl13 = {humanoidRootPart, {}, [4] = "078da341"}

                      for _, v18 in ipairs(tbl12) do
                        local humanoidRootPart2 = v18:FindFirstChild("HumanoidRootPart")

                        if humanoidRootPart2 then
                          table.insert(tbl13[2], {v18, humanoidRootPart2})
                          table.insert(tbl13[2], v18)
                        end
                      end

                      RegisterAttack:FireServer(0)
                      RegisterHit:FireServer(unpack(tbl13))
                      return
                    end

                    return
                  end
                end

                tbl11.Attack = attack

                if _G.BananaAttackWorkerThread then
                  pcall(task.cancel, _G.BananaAttackWorkerThread)
                  _G.BananaAttackWorkerThread = nil
                end

                local bananaAttackWorkerToken = {}
                _G.BananaAttackWorkerToken = bananaAttackWorkerToken

                _G.BananaAttackWorkerThread = task.spawn(function()
                  while _G.BananaAttackWorkerToken == bananaAttackWorkerToken do
                    if _G.FastAttackTick then
                      local fastAttackTick = _G.FastAttackTick

                      if (os.clock() - fastAttackTick) < 0.35 then
                        pcall(function()
                          tbl11:Attack()
                        end)

                        task.wait(0.025)
                      else
                        task.wait(0.05)
                      end
                    else
                      task.wait(0.05)
                    end
                  end
                end)
              end)

              FastAttack.Attack = function()
                _G.FastAttackTick = os.clock()
                _G.FastAttack = os.time()
                lastIdleTick = os.time()
              end

              local tbl11 = {GRAB = true, GRAB_DISTANCE = 350, BRING_LIMIT = 6, BRING_FOLLOW_DISTANCE = 45, MAX_ATTACK_DURATION = 3, MAX_ATTACK_DURATION_2 = 30, LEVITATE_TIME = 1, CurrentIndex = 1, FixedAnchors = {}, BringSessions = {}}
              tbl11.SpecialClusterMobs = ScriptStorage.SpecialClusterMobs or {["Dangerous Prisoner"] = true, Gladiator = true, Raider = true, Mercenary = true}
              CombatController = tbl11
              CombatController.Special1 = CombatController.SpecialClusterMobs
              CombatController.BRING_TEST_VERSION = 3
              LastFound = os.time()
              local tbl12 = {FarmingVelocity = true, FarmingPosition = true}

              CombatController.ReleaseGrab = function(arg)
                if arg then
                  local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
                  local exitTo, v17

                  if humanoidRootPart then
                    for k in pairs(tbl12) do
                      exitTo = nil
                      v17 = humanoidRootPart:FindFirstChild(k)

                      if v17 then
                        v17:Destroy()
                      end
                    end
                  else
                    humanoidRootPart = arg.PrimaryPart

                    if humanoidRootPart then
                      for k in pairs(tbl12) do
                        exitTo = nil
                        v17 = humanoidRootPart:FindFirstChild(k)

                        if v17 then
                          v17:Destroy()
                        end
                      end
                    end
                  end

                  arg:SetAttribute("IsGrabbed", nil)
                  arg:SetAttribute("MidPoint", nil)
                  return
                end
              end

              CombatController.FreezeMob = function(arg, cFrame)
                if arg then
                  if arg.Parent then
                    local humanoid = arg:FindFirstChildOfClass("Humanoid")
                    local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")

                    if not humanoidRootPart then
                      humanoidRootPart = arg.PrimaryPart
                      if not humanoidRootPart then
                        return
                      end
                    end

                    if humanoid then
                      if humanoid.Health <= 0 then
                        return
                      end

                      for _, child in ipairs(arg:GetChildren()) do
                        if child:IsA("BasePart") then
                          child.CanCollide = false
                        end
                      end

                      humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                      humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                      local farmingVelocity = humanoidRootPart:FindFirstChild("FarmingVelocity")

                      if not farmingVelocity then
                        farmingVelocity = Instance.new("BodyVelocity")
                        farmingVelocity.Name = "FarmingVelocity"
                        farmingVelocity.Parent = humanoidRootPart
                      end

                      farmingVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                      farmingVelocity.Velocity = Vector3.new(0, 0, 0)
                      if cFrame then
                        humanoidRootPart.CFrame = cFrame
                        return
                      end
                      return
                    end

                    return
                  end

                  return
                end
              end

              CombatController.CleanupGrabbed = function(arg)
                local character = LocalPlayer.Character
                character = character and character:FindFirstChild("HumanoidRootPart")
                local n8 = CombatController.GRAB_DISTANCE + 25

                for _, v17 in Services.Workspace.Enemies:GetChildren() do
                  if arg and (v17.Name ~= arg) then
                    if v17:GetAttribute("IsGrabbed") then
                      CombatController.ReleaseGrab(v17)
                    end
                  elseif v17:GetAttribute("IsGrabbed") then
                    local humanoid = v17:FindFirstChild("Humanoid")
                    local humanoidRootPart = v17:FindFirstChild("HumanoidRootPart") or v17.PrimaryPart
                    local attribute = v17:GetAttribute("FailureCount")

                    if (humanoid and (humanoid.Health <= 0)) or v17:GetAttribute("IgnoreGrab") or (attribute and (attribute > 5)) or (character and humanoidRootPart and (n8 < (character.Position - humanoidRootPart.Position).Magnitude)) then
                      CombatController.ReleaseGrab(v17)
                    end
                  end

                  if not v17:GetAttribute("IsGrabbed") then
                    local humanoidRootPart2 = v17:FindFirstChild("HumanoidRootPart") or v17.PrimaryPart

                    if humanoidRootPart2 then
                      for k in pairs(tbl12) do
                        local v18 = humanoidRootPart2:FindFirstChild(k)

                        if v18 then
                          v18:Destroy()
                        end
                      end
                    end
                  end
                end
              end

              local function fn37()
                if MeleeBuyBusy then
                  return
                end

                if LocalPlayer then
                  local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

                  if playerGui then
                    pcall(function()
                      require(game.ReplicatedStorage.DialogueController).close()
                    end)

                    local dogHouse = playerGui:FindFirstChild("DogHouse")

                    if dogHouse then
                      if not dogHouse.Enabled then
                        if dogHouse:FindFirstChild("Frame") then
                          if dogHouse.Frame.Visible then
                            pcall(function()
                              dogHouse.Enabled = false

                              for _, descendant in ipairs(dogHouse:GetDescendants()) do
                                if descendant:IsA("GuiObject") then
                                  if descendant.Visible then
                                    descendant.Visible = false
                                  end
                                end
                              end
                            end)

                            return
                          end
                        end

                        return
                      end

                      pcall(function()
                        dogHouse.Enabled = false

                        for _, descendant in ipairs(dogHouse:GetDescendants()) do
                          if descendant:IsA("GuiObject") then
                            if descendant.Visible then
                              descendant.Visible = false
                            end
                          end
                        end
                      end)

                      return
                    end

                    return
                  end
                end
              end

              shared.BananaGrabCleanupVersion = (shared.BananaGrabCleanupVersion or 0) + 1
              local bananaGrabCleanupVersion = shared.BananaGrabCleanupVersion

              task.spawn(function()
                while shared.BananaGrabCleanupVersion == bananaGrabCleanupVersion do
                  if not _G.Stop then
                    CombatController.CleanupGrabbed()
                    fn37()
                    task.wait(1)
                    continue
                  end

                  break
                end
              end)

              CombatController.SetSimulationRadius = function()
                pcall(function()
                  setscriptable(LocalPlayer, "SimulationRadius", true)
                  sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                end)
              end

              CombatController.GetAliveMob = function(arg)
                if arg then
                  local humanoid = arg:FindFirstChild("Humanoid")
                  local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")

                  if humanoid then
                    if humanoidRootPart then
                      if humanoid.Health > 0 then
                        return humanoid, humanoidRootPart
                      end
                    end
                  end

                  return
                end
              end

              CombatController.CanGrabRoot = function(arg)
                return arg ~= nil and arg:IsA("BasePart")
              end

              CombatController.GetSpawnAnchor = function(arg)
                local str4 = tostring(arg)
                if CombatController.SpecialClusterMobs[str4] then
                  return nil
                end

                if CombatController.Special1 then
                  local special1 = CombatController.Special1

                  if str4 then
                    if special1[str4] then
                      return nil
                    end

                    if CombatController.FixedAnchors[str4] then
                      return CombatController.FixedAnchors[str4]
                    end
                  end
                elseif CombatController.FixedAnchors[str4] then
                  return CombatController.FixedAnchors[str4]
                end

                local mobRegions = ScriptStorage.MobRegions and ScriptStorage.MobRegions[str4]
                local character = LocalPlayer.Character
                character = character and character:FindFirstChild("HumanoidRootPart")
                local v17 = nil

                if mobRegions then
                  local tbl13 = {}

                  for _, mobRegion in ipairs(mobRegions) do
                    local n8 = #tbl13 + 1
                    local cframe3

                    if typeof(mobRegion) == "CFrame" then
                      cframe3 = mobRegion or CFrame.new(mobRegion)
                    else
                      cframe3 = CFrame.new(mobRegion)
                    end

                    tbl13[n8] = cframe3
                  end

                  local v18 = nil
                  local v19 = nil
                  v17 = nil

                  for _, v20 in ipairs(tbl13) do
                    local v22, v23, v24 = ipairs(tbl13)
                    local n8 = 0

                    for _, v25 in ipairs(tbl13) do
                      n8 += (v20.Position - v25.Position).Magnitude
                    end

                    local magnitude

                    if character then
                      magnitude = (v20.Position - character.Position).Magnitude

                      if not magnitude then
                        magnitude = 0
                      end
                    else
                      magnitude = 0
                    end

                    if v18 then
                      if n8 < v18 then
                        v18 = n8
                        v19 = magnitude
                        v17 = v20
                      elseif math.abs(n8 - v18) < 0.001 then
                        if v19 then
                          if magnitude < v19 then
                            v18 = n8
                            v19 = magnitude
                            v17 = v20
                          end
                        elseif magnitude < math.huge then
                          v18 = n8
                          v19 = magnitude
                          v17 = v20
                        end
                      end
                    else
                      v18 = n8
                      v19 = magnitude
                      v17 = v20
                    end
                  end

                  if v17 then
                    CombatController.FixedAnchors[str4] = v17
                    return v17
                  end
                elseif v17 then
                  CombatController.FixedAnchors[str4] = v17
                  return v17
                end

                local enemies = Services.Workspace:FindFirstChild("Enemies")

                if enemies then
                  for _, child in ipairs(enemies:GetChildren()) do
                    if child.Name ~= str4 then
                      continue
                    end

                    if child:GetAttribute("IgnoreGrab") then
                      continue
                    end
                    local v18, v19 = CombatController.GetAliveMob(child)
                    if v19 then
                      CombatController.FixedAnchors[str4] = v19.CFrame
                      return v19.CFrame
                    end
                  end
                end

                return CombatController.FixedAnchors[str4]
              end

              local function fn38()
                if ScriptStorage then
                  if ScriptStorage.PlayerData then
                    local devilFruit = ScriptStorage.PlayerData.DevilFruit

                    if devilFruit then
                      if devilFruit ~= "" then
                        if devilFruit ~= "None" then
                          return true
                        end
                      end
                    end
                  end
                end

                local data = LocalPlayer:FindFirstChild("Data")

                if data then
                  local devilFruit = data:FindFirstChild("DevilFruit")

                  if devilFruit then
                    if devilFruit.Value then
                      if devilFruit.Value == "" then
                        return false
                      end

                      if devilFruit.Value ~= "None" then
                        return true
                      end
                    end
                  end
                end

                return false
              end

              CombatController.GetAttackOffset = function(arg)
                local height = _G.FarmHeight or 15
                if CombatController.IsRaidActive() then
                  return CFrame.new(0, math.max(height, 20), 0)
                end
                return CFrame.new(0, height, 0)
              end
            end

            CombatController.GetStandbyFrame = function(arg, arg2)
              local anchor

              if arg2 then
                anchor = arg2.Anchor

                if not anchor then
                  anchor = CombatController.GetSpawnAnchor(arg)
                  if not anchor then
                    return anchor
                  end
                end
              else
                anchor = CombatController.GetSpawnAnchor(arg)
                if not anchor then
                  return anchor
                end
              end

              return anchor * CombatController.GetAttackOffset(anchor)
            end

            CombatController.HasAliveMob = function(arg)
              local enemies = Services.Workspace:FindFirstChild("Enemies")

              if enemies then
                for _, child in ipairs(enemies:GetChildren()) do
                  if child.Name ~= arg then
                    continue
                  end

                  if CombatController.GetAliveMob(child) then
                    return true
                  end
                end

                return false
              end

              return false
            end

            local function shouldKeepBringMob(arg, arg2)
              local v17, v18 = CombatController.GetAliveMob(arg)

              if v18 then
                if arg2 then
                  if arg2.Anchor then
                    local magnitude = (v18.Position - arg2.Anchor.Position).Magnitude
                    if CombatController.GRAB_DISTANCE < magnitude then
                      return false
                    end
                    local flag6 = magnitude <= CombatController.BRING_FOLLOW_DISTANCE
                    if flag6 then
                      return flag6
                    end
                    return (CombatController.CanGrabRoot(v18))
                  end

                  return false
                end

                return false
              end

              return false
            end

            CombatController.ShouldKeepBringMob = shouldKeepBringMob

            CombatController.GetBringSession = function(arg)
              local str4 = tostring(arg)
              local v17 = CombatController.BringSessions[str4]
              local flag6 = false

              if v17 then
                local n8 = #v17.Mobs
                local n9 = 1
                local v18

                for i = n8, n9, -1 do
                  if CombatController.ShouldKeepBringMob(v17.Mobs[i], v17) then
                    flag6 = true
                  else
                    table.remove(v17.Mobs, i)
                  end
                end
              end

              local v18 = CombatController.SpecialClusterMobs[str4]
              local tbl10

              if v17 then
                if not flag6 then
                  if #v17.Mobs == 0 then
                    tbl10 = {Anchor = CombatController.GetSpawnAnchor(str4), Mobs = {}}
                    CombatController.BringSessions[str4] = tbl10
                    return tbl10
                  end
                end

                if v17.Anchor then
                  if v18 then
                    if not CombatController.HasAliveMobNearAnchor(str4, v17.Anchor) then
                      v17.Anchor = CombatController.GetSpawnAnchor(str4)
                      return v17
                    end
                  end

                  return v17
                end

                v17.Anchor = CombatController.GetSpawnAnchor(str4)
                return v17
              end

              tbl10 = {Anchor = CombatController.GetSpawnAnchor(str4), Mobs = {}}
              CombatController.BringSessions[str4] = tbl10
              return tbl10
            end

            CombatController.RefreshBringTargets = function(arg, arg2)
              if arg2 then
                arg2.Mobs = arg2.Mobs or {}

                for i = #arg2.Mobs, 1, -1 do
                  if not CombatController.ShouldKeepBringMob(arg2.Mobs[i], arg2) then
                    table.remove(arg2.Mobs, i)
                  end
                end

                local tbl10 = {}
                local enemies = Services.Workspace:FindFirstChild("Enemies")

                if enemies then
                  local v17 = CombatController.SpecialClusterMobs[arg]

                  if arg2.Anchor then
                    if v17 then
                      if not CombatController.HasAliveMobNearAnchor(arg, arg2.Anchor) then
                        arg2.Anchor = CombatController.GetSpawnAnchor(arg)
                      end
                    end
                  else
                    arg2.Anchor = CombatController.GetSpawnAnchor(arg)
                  end

                  if arg2.Anchor then
                    if #arg2.Mobs >= CombatController.BRING_LIMIT then
                      return
                    end
                    local v18, magnitude, flag6

                    for _, child in ipairs(enemies:GetChildren()) do
                      if child.Name == arg then
                        local n8

                        if not child:GetAttribute("IgnoreGrab") then
                          local attribute = child:GetAttribute("FailureCount")
                          local v19

                          if attribute then
                            if not ((attribute > 7) or table.find(arg2.Mobs, child)) then
                              v19, v18 = CombatController.GetAliveMob(child)

                              if v18 then
                                magnitude = (v18.Position - arg2.Anchor.Position).Magnitude
                                flag6 = magnitude <= CombatController.GRAB_DISTANCE

                                if flag6 then
                                  flag6 = magnitude <= CombatController.BRING_FOLLOW_DISTANCE

                                  if flag6 then
                                    if flag6 then
                                      n8 = #tbl10 + 1
                                      tbl10[n8] = {Mob = child, Distance = magnitude}
                                    end
                                  elseif CombatController.CanGrabRoot(v18) then
                                    n8 = #tbl10 + 1
                                    tbl10[n8] = {Mob = child, Distance = magnitude}
                                  end
                                elseif flag6 then
                                  n8 = #tbl10 + 1
                                  tbl10[n8] = {Mob = child, Distance = magnitude}
                                end
                              end
                            end
                          elseif not table.find(arg2.Mobs, child) then
                            v19, v18 = CombatController.GetAliveMob(child)

                            if v18 then
                              magnitude = (v18.Position - arg2.Anchor.Position).Magnitude
                              flag6 = magnitude <= CombatController.GRAB_DISTANCE

                              if flag6 then
                                flag6 = magnitude <= CombatController.BRING_FOLLOW_DISTANCE

                                if flag6 then
                                  if flag6 then
                                    n8 = #tbl10 + 1
                                    tbl10[n8] = {Mob = child, Distance = magnitude}
                                  end
                                elseif CombatController.CanGrabRoot(v18) then
                                  n8 = #tbl10 + 1
                                  tbl10[n8] = {Mob = child, Distance = magnitude}
                                end
                              elseif flag6 then
                                n8 = #tbl10 + 1
                                tbl10[n8] = {Mob = child, Distance = magnitude}
                              end
                            end
                          end
                        end
                      end
                    end

                    local function fn37(arg3, arg4)
                      return arg3.Distance < arg4.Distance
                    end

                    table.sort(tbl10, fn37)

                    for _, v19 in ipairs(tbl10) do
                      if #arg2.Mobs >= CombatController.BRING_LIMIT then
                        break
                      else
                        local v20, v22 = CombatController.GetAliveMob(v19.Mob)

                        if v22 then
                          v19.Mob:SetAttribute("OldPosition", v19.Mob:GetAttribute("OldPosition") or v22.Position)
                          arg2.Mobs[#arg2.Mobs + 1] = v19.Mob
                        end
                      end
                    end

                    return
                  end

                  return
                end

                return
              end
            end

            CombatController.GetCurrentBringTarget = function(arg)
              local v17 = CombatController.GetBringSession(arg)
              CombatController.RefreshBringTargets(arg, v17)

              if v17 then
                if v17.Anchor then
                  for _, mob in ipairs(v17.Mobs) do
                    if CombatController.GetAliveMob(mob) then
                      return mob, v17
                    end
                  end

                  return
                end

                return
              end
            end

            CombatController.GetDistantBringMob = function(arg)
              if arg then
                if arg.Anchor then
                  for _, mob in ipairs(arg.Mobs) do
                    local v17, v18 = CombatController.GetAliveMob(mob)

                    if v18 then
                      if CombatController.BRING_FOLLOW_DISTANCE < (v18.Position - arg.Anchor.Position).Magnitude then
                        return mob, v18
                      end
                    end
                  end

                  return
                end

                return
              end
            end

            CombatController.Grab = function(arg, arg2)
              if CombatController.GRAB then
                if arg then
                  if GrabDebounce then
                    local v17 = GrabDebounce
                    if (os.clock() - v17) < 0.08 then
                      return
                    end
                  end

                  GrabDebounce = os.clock()
                  CombatController.SetSimulationRadius()
                  CombatController.CleanupGrabbed(arg)
                  arg2 = arg2 or CombatController.GetBringSession(arg)
                  CombatController.RefreshBringTargets(arg, arg2)

                  if arg2 then
                    local anchor = arg2.Anchor

                    if anchor then
                      local mobs = arg2.Mobs
                      mobs = mobs or {}

                      for _, mob in ipairs(mobs) do
                        local v17, v18 = CombatController.GetAliveMob(mob)

                        if v18 then
                          if v17 then
                            if CombatController.CanGrabRoot(v18) then
                              if (v18.Position - anchor.Position).Magnitude <= CombatController.GRAB_DISTANCE then
                                CombatController.FreezeMob(mob, anchor)
                                mob:SetAttribute("IsGrabbed", true)
                                mob:SetAttribute("MidPoint", anchor)
                              end
                            end
                          end
                        end
                      end

                      return
                    end
                  end

                  return
                end

                return
              end
            end

            CombatController.GrabSpecial = function(arg, arg2)
              pcall(function()
                setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
              end)

              if CombatController.GRAB then
                if arg then
                  if arg2 then
                    if GrabDebounce then
                      local v17 = GrabDebounce
                      if (os.clock() - v17) < 0.08 then
                        return
                      end
                    end

                    GrabDebounce = os.clock()
                    CombatController.CleanupGrabbed(arg)
                    local position = arg2.Position
                    local tbl10 = {}
                    local enemies = Services.Workspace:FindFirstChild("Enemies")

                    if enemies then
                      for _, child in ipairs(enemies:GetChildren()) do
                        if child.Name ~= arg then
                          continue
                        else
                          local humanoid = child:FindFirstChild("Humanoid")
                          local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

                          if not humanoid or (not humanoidRootPart or ((humanoid.Health <= 0) or child:GetAttribute("IgnoreGrab"))) then
                            continue
                          else
                            local attribute = child:GetAttribute("FailureCount")
                            local position2, v17, flag6, v18, primaryPart, v19, setAttribute, attribute2, n8

                            if not attribute or (attribute <= 7) then
                              position2 = humanoidRootPart.Position

                              if position2 then
                                if (position2 - position).Magnitude < CombatController.GRAB_DISTANCE then
                                  v19 = child
                                  setAttribute = child.SetAttribute
                                  attribute2 = child:GetAttribute("OldPosition") or position2
                                  setAttribute(v19, "OldPosition", attribute2)
                                  n8 = #tbl10 + 1
                                  tbl10[n8] = {Mon = child, Root = humanoidRootPart, Humanoid = humanoid, Position = position2, Distance = (position2 - position).Magnitude}
                                else
                                  continue
                                end
                              else
                                continue
                              end
                            else
                              continue
                            end
                          end
                        end
                      end

                      if #tbl10 <= 0 then
                        return
                      end

                      local function fn37(arg3, arg4)
                        return arg3.Distance < arg4.Distance
                      end

                      table.sort(tbl10, fn37)
                      local tbl11 = {}
                      local n8 = 0
                      local n9 = math.min(5, #tbl10)
                      local n10 = 1
                      local vector = Vector3.new(0, 0, 0)
                      local v17, v18, n11

                      for i = n10, n9 do
                        v18 = tbl10[i]
                        vector += v18.Position
                        n8 += 1
                        n11 = #tbl11 + 1
                        tbl11[n11] = v18
                      end

                      local cframe3 = CFrame.new(vector / n8)

                      for i = 1, #tbl11 do
                        local mon = tbl11[i].Mon
                        local root = tbl11[i].Root
                        local humanoid = tbl11[i].Humanoid

                        if ((mon and root) and humanoid) and (humanoid.Health > 0) then
                          if not mon:GetAttribute("DefaultMidPoint") then
                            mon:SetAttribute("DefaultMidPoint", cframe3)
                          end

                          local attribute = mon:GetAttribute("OriginPosition")

                          if not attribute then
                            attribute = root.CFrame
                            mon:SetAttribute("OriginPosition", attribute)
                          end

                          humanoid.WalkSpeed = 0
                          humanoid.JumpPower = 0
                          humanoid.AutoRotate = false
                          root.CanCollide = false
                          root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                          root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                          if (root.Position - cframe3.Position).Magnitude > 140 then
                            cframe3 = attribute
                            mon:SetAttribute("FailureCount", (mon:GetAttribute("FailureCount") or 0) + 1)
                          end

                          local farmingPosition = root:FindFirstChild("FarmingPosition")

                          if not farmingPosition then
                            farmingPosition = Instance.new("BodyPosition")
                            farmingPosition.Name = "FarmingPosition"
                            farmingPosition.Parent = root
                          end

                          farmingPosition.MaxForce = Vector3.new(100000, 100000, 100000)
                          farmingPosition.P = 1250
                          farmingPosition.D = 50
                          farmingPosition.Position = cframe3.Position
                          root.CFrame = cframe3
                          mon:SetAttribute("IsGrabbed", true)
                          mon:SetAttribute("MidPoint", cframe3)
                        end
                      end

                      return
                    end

                    return
                  end

                  return
                end

                return
              end
            end

            Sort1 = function(arg)
              if arg then
                local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                  return (math.floor(CaculateDistance(arg.HumanoidRootPart.CFrame)))
                end
                return humanoidRootPart
              end

              return arg
            end

            CombatController.Search = function(arg)
              local tbl10 = {}
              local flag6 = false

              for _, v17 in GetMonAsSortedRange() do
                if table.find(arg, v17.Name) then
                  if v17:FindFirstChild("Humanoid") then
                    if v17.Humanoid.Health > 0 then
                      local attribute = v17:GetAttribute("FailureCount")

                      if attribute then
                        if attribute < 3 then
                          table.insert(tbl10, v17)
                          flag6 = true
                        end
                      else
                        table.insert(tbl10, v17)
                        flag6 = true
                      end
                    end
                  end
                end
              end

              table.sort(tbl10, function(arg2, arg3)
                return Sort1(arg2) < Sort1(arg3)
              end)

              if flag6 then
                return tbl10[1]
              end

              if CombatController.IsRaidActive() then
                return
              end

              for _, v17 in ipairs(arg) do
                local v18 = game.ReplicatedStorage:FindFirstChild(v17)
                if CombatController.GetAliveMob(v18) then
                  return v18
                end
              end
            end

            local tbl10 = {["Cake Prince"] = true, ["Dough King"] = true}

            CombatController.IsCakeBossTarget = function(arg)
              for _, v17 in ipairs(arg) do
                if tbl10[tostring(v17)] then
                  return true
                end
              end

              return false
            end

            CombatController.IsBossTarget = function(arg)
              local str4 = tostring(arg)
              if BossesOrderLevel[str4] then
                return true
              end

              if BossesOrderWL[str4] then
                return true
              end

              if SpecialBossesOrder[str4] then
                return true
              end

              for _, v17 in ipairs(BossesOrder) do
                if v17 ~= str4 then
                  continue
                end
                return true
              end

              return false
            end

            CombatController.IsRaidActive = function()
              if SeaIndex ~= 1 then
                local character = LocalPlayer.Character

                if character then
                  local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    local position = humanoidRootPart.Position
                    if math.abs(position.X) > 40000 then
                      return true
                    end

                    if math.abs(position.Z) > 40000 then
                      return true
                    end

                    if LocalPlayer:FindFirstChild("PlayerGui") then
                      local main = LocalPlayer.PlayerGui:FindFirstChild("Main")

                      if main then
                        if main:FindFirstChild("Timer") then
                          if main.Timer.Visible then
                            if Services.Workspace:FindFirstChild("_WorldOrigin") then
                              local locations = Services.Workspace._WorldOrigin:FindFirstChild("Locations")

                              if locations then
                                for _, child in ipairs(locations:GetChildren()) do
                                  if string.find(child.Name, "Island ") then
                                    if (child.Position - Vector3.new(0, 0, 0)).Magnitude > 7000 then
                                      if (child.Position - humanoidRootPart.Position).Magnitude < 3000 then
                                        return true
                                      end
                                    end
                                  end
                                end

                                return false
                              end
                            end

                            return false
                          end

                          return false
                        end

                        return false
                      end
                    end

                    return false
                  end
                end

                return false
              end

              return false
            end

            CombatController.FindCakeBigMirror = function()
              local v17 = nil
              local tbl11 = nil

              for _, v18 in ipairs({Services.Workspace:FindFirstChild("Map"), Services.Workspace}) do
                if v18 then
                  for _, descendant in ipairs(v18:GetDescendants()) do
                    local v19 = string.lower(tostring(descendant.Name))
                    local v20 = string.gsub(v19, "%W", "")

                    if v20 == "bigmirror" then
                      local tbl12 = {}
                      local n8 = 0

                      if descendant:IsA("BasePart") then
                        table.insert(tbl12, descendant)
                        n8 = (descendant:FindFirstChildWhichIsA("TouchTransmitter") and 20) or 5
                      elseif descendant:IsA("Model") then
                        for _, descendant2 in ipairs(descendant:GetDescendants()) do
                          if descendant2:IsA("BasePart") then
                            table.insert(tbl12, descendant2)
                            n8 += ((descendant2:FindFirstChildWhichIsA("TouchTransmitter") and 20) or 1)
                          end
                        end
                      end

                      if #tbl12 > 0 then
                        local n9 = n8 + (((v19 == "bigmirror") and 50) or 10)

                        if not v17 or (n9 > v17) then
                          tbl11 = {Instance = descendant, TouchParts = tbl12, CFrame = (descendant:IsA("Model") and descendant:GetModelCFrame()) or descendant.CFrame}
                          v17 = n9
                        end
                      end
                    end
                  end
                end
              end

              return tbl11
            end

            CombatController.GetCakeBigMirrorFallbackCFrame = function()
              if ScriptStorage.NPCs then
                local cakeScientist = ScriptStorage.NPCs["Cake Scientist"]

                if cakeScientist then
                  local ok, result = pcall(function()
                    return cakeScientist:GetModelCFrame()
                  end)

                  if ok then
                    if result then
                      return result
                    end
                  end
                end
              end

              local worldOrigin = Services.Workspace:FindFirstChild("_WorldOrigin")

              if worldOrigin then
                worldOrigin = Services.Workspace._WorldOrigin:FindFirstChild("PlayerSpawns")

                if worldOrigin then
                  local v17 = worldOrigin
                  local findFirstChild = worldOrigin.FindFirstChild
                  local str4 = ((Config.Team ~= "Marines") and "Pirates") or "Marines"
                  worldOrigin = findFirstChild(v17, tostring(str4))

                  if worldOrigin then
                    local loaf = worldOrigin:FindFirstChild("Loaf")

                    if loaf then
                      local ok, result = pcall(function()
                        if loaf:IsA("Model") then
                          local modelCFrame = loaf:GetModelCFrame()
                          if modelCFrame then
                            return modelCFrame
                          end
                        end

                        return loaf.CFrame
                      end)

                      if ok then
                        if result then
                          return result
                        end
                      end
                    end
                  end

                  return CFrame.new(-2711, 63, -12896)
                end
              end

              return CFrame.new(-2711, 63, -12896)
            end

            CombatController.GetCakeMirrorDimensionCFrame = function()
              local map = Services.Workspace:FindFirstChild("Map")

              if map then
                local mirrorDimension = map:FindFirstChild("MirrorDimension")

                if mirrorDimension then
                  local main = mirrorDimension:FindFirstChild("MAIN", true)

                  if main then
                    if main:IsA("BasePart") then
                      return main.CFrame, main:GetFullName()
                    end
                  end
                end
              end

              if Services.Workspace:FindFirstChild("_WorldOrigin") then
                local locations = Services.Workspace._WorldOrigin:FindFirstChild("Locations")

                if locations then
                  local dimensionalShift = locations:FindFirstChild("Dimensional Shift")

                  if dimensionalShift then
                    if dimensionalShift:IsA("BasePart") then
                      return dimensionalShift.CFrame, dimensionalShift:GetFullName()
                    end
                  end
                end
              end
            end

            CombatController.UseCakeBigMirrorPortal = function(arg)
              if SeaIndex ~= 3 then
                return false, "wrong-sea"
              end
              local v17 = CombatController.FindCakeBigMirror()

              if v17 then
                if arg then
                  local instance = v17.Instance
                  local position = v17.CFrame.Position
                  return true, instance:GetFullName(), position
                end

                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                  return false, "missing-root"
                end
                SetTask("MainTask", "Auto Farm Boss - Entering BigMirror")
                TweenController.Create(v17.CFrame + Vector3.new(0, 4, 0))

                if CaculateDistance(v17.CFrame) < 35 then
                  for _, v18 in ipairs(v17 or {}) do
                    pcall(function()
                      firetouchinterest(humanoidRootPart, v18, 0)
                      task.wait()
                      firetouchinterest(humanoidRootPart, v18, 1)
                    end)
                  end
                end

                local instance = v17.Instance
                local position = v17.CFrame.Position
                return true, instance:GetFullName(), position
              end

              if arg then
                return true, "loading-bigmirror", CombatController.GetCakeBigMirrorFallbackCFrame().Position
              end
              local v18 = CombatController.GetCakeBigMirrorFallbackCFrame()
              SetTask("MainTask", "Auto Farm Boss - Loading BigMirror")
              TweenController.Create(v18 + Vector3.new(0, 5, 0))
              return true, "loading-bigmirror", v18.Position
            end

            local function fn37(arg, arg2, arg3, arg4, arg5)
              local tbl11, v17, v18, v19, kind, v20, v22, specialClusterMobs, v23, tbl12, flag6, v24, str4, v25, v26, flag7, num, now5, n8, v27, position, targetInstance, enemies, flag8, humanoidRootPart, flag9, now6, stopCondition, n9, n10, character, humanoid, humanoid2, humanoidRootPart2, flag10, flag11, specialClusterMobs2, n11, v28, v29, n12, now7, humanoid3, humanoidRootPart3, attribute, attribute2, v30, setAttribute, attribute3, v31, call, str5, flag12, v32, now8, v33, v34
              tbl11 = arg
              v17 = tonumber(arg3) or 500
              v18 = arg4
              v19 = arg5
              kind = type(tbl11)

              if kind == "string" then
                tbl11 = {tbl11}
              end

              v20 = tbl11[1]

              if v20 then
                v22 = CombatController.IsBossTarget(tostring(v20))

                if v22 then
                  v20 = v22
                else
                  specialClusterMobs = CombatController.SpecialClusterMobs

                  if specialClusterMobs then
                    v20 = CombatController.SpecialClusterMobs[tostring(v20)]
                  else
                    v20 = specialClusterMobs
                  end
                end
              end

              if MeleeEquipBusyName then
                SetTask("MainTask", "Melee | Loading " .. tostring(MeleeEquipBusyName))
                return
              end

              if not v20 then
                if ShouldPreemptForMeleeBuy then
                  if ShouldPreemptForMeleeBuy() then
                    SetTask("MainTask", "Auto Melee Buy | Pending " .. tostring(GetMeleeBuyPending()))
                    return
                  end
                end
              end

              pcall(function()
                setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
              end)
              if not kind then
                return
              end
              v23 = CombatController.IsRaidActive()

              if v19 then
                tbl12 = v19
              else
                tbl12 = {}
              end

              flag6 = tbl12.AllowBring == true

              for _, v35 in ipairs(tbl11) do
                str4 = tostring(v35)
                v25 = nil
                v26 = nil

                if v23 then
                  flag7 = v23
                else
                  flag7 = not flag6

                  if not flag7 then
                    flag7 = CombatController.IsBossTarget(str4)

                    if not flag7 then
                      flag7 = CombatController.SpecialClusterMobs

                      if flag7 then
                        flag7 = CombatController.SpecialClusterMobs[str4]
                      end
                    end
                  end
                end

                if (str4 == "Deandre") or ((str4 == "Urban") or (str4 == "Diablo")) then
                  if not ScriptStorage.Backpack.Yama then
                    num = tonumber(FunctionsHandler.Yama:Get("EliteCount"))

                    if not num or (num < 30) then
                      now5 = os.time()
                      n8 = LastFire12

                      if not n8 then
                        n8 = 0
                      end

                      if (now5 - n8) > 180 then
                        LastFire12 = os.time()
                        Remotes.CommF_:InvokeServer("EliteHunter")
                      end
                    end
                  end
                end

                if tbl12.TargetInstance then
                  targetInstance = tbl12.TargetInstance
                  enemies = workspace:FindFirstChild("Enemies")
                  flag8 = typeof(targetInstance) == "Instance"

                  if flag8 then
                    flag8 = targetInstance:FindFirstChildOfClass("Humanoid")
                  end

                  if not enemies then
                    return
                  end

                  if typeof(targetInstance) ~= "Instance" then
                    return
                  end

                  if targetInstance.Name ~= str4 then
                    return
                  end

                  if not targetInstance:IsDescendantOf(enemies) then
                    return
                  end

                  if not flag8 then
                    return
                  end

                  if flag8.Health <= 0 then
                    return
                  end
                  v25 = targetInstance
                  if not v25 then
                    continue
                  end
                else
                  v25 = CombatController.Search({str4})
                  if not v25 then
                    v27 = GetMonAsSortedRange()[1]
                    if v27 and v27:FindFirstChild("HumanoidRootPart") then
                      position = v27.HumanoidRootPart.Position
                      local maxDist = tonumber(v17) or 500
                      if position and CaculateDistance(position) < maxDist then
                        v25 = v27
                      end
                    end
                  end
                  if not v25 then
                    local standby = CombatController.GetStandbyFrame(str4)
                    if not standby and ScriptStorage.MobRegions and ScriptStorage.MobRegions[str4] then
                      standby = ScriptStorage.MobRegions[str4][1]
                    end
                    if standby then
                      TweenController.Create(standby * CFrame.new(0, 25, 0), false, v23)
                    end
                    task.wait(0.2)
                    continue
                  end
                end

                humanoidRootPart = v25:FindFirstChild("HumanoidRootPart")
                flag9 = CombatController.IsCakeBossTarget(tbl11)

                if flag9 then
                  flag9 = not humanoidRootPart

                  if humanoidRootPart then
                    if CaculateDistance(humanoidRootPart.CFrame) > 400 then
                      if CombatController.UseCakeBigMirrorPortal() then
                        return
                      end
                    end
                  elseif flag9 then
                    if CombatController.UseCakeBigMirrorPortal() then
                      return
                    end
                  end
                elseif flag9 then
                  if CombatController.UseCakeBigMirrorPortal() then
                    return
                  end
                end

                LastFound = os.time()
                os.time()
                now6 = os.time()

                if flag7 then
                  v26 = nil
                else
                  if not v26 then
                    v26 = CombatController.GetBringSession(str4)
                  end

                  CombatController.RefreshBringTargets(str4, v26)
                end

                stopCondition = tbl12.StopCondition

                if stopCondition then
                  stopCondition = function()
                    if tbl12.StopCondition() then
                      CombatController.ReleaseGrab(v25)

                      if v26 then
                        if v26.Mobs then
                          for _, mob in ipairs(v26.Mobs) do
                            CombatController.ReleaseGrab(mob)
                          end

                          return true
                        end
                      end

                      return true
                    end

                    return false
                  end
                end

                n9 = 0
                n10 = 0

                while true do
                  if _G.Stop then
                    return
                  end

                  if stopCondition then
                    if stopCondition() then
                      return
                    end
                  end

                  if MeleeEquipBusyName then
                    TweenController.ClearGhost()
                    SetTask("MainTask", "Melee | Loading " .. tostring(MeleeEquipBusyName))
                    return
                  end

                  if not flag7 then
                    if ShouldPreemptForMeleeBuy then
                      if ShouldPreemptForMeleeBuy() then
                        SetTask("MainTask", "Auto Melee Buy | Pending " .. tostring(GetMeleeBuyPending()))
                        return
                      end
                    end
                  end

                  character = LocalPlayer.Character
                  if not character then
                    TweenController.ClearGhost()
                    return
                  end
                  humanoid = character:FindFirstChildOfClass("Humanoid")
                  if not humanoid or (humanoid.Health <= 0) then
                    TweenController.ClearGhost()
                    return
                  end

                  if tbl12.CheckQuest then
                    if not GetCurrentClaimQuest() then
                      CombatController.ReleaseGrab(v25)

                      if v26 then
                        if v26.Mobs then
                          for _, mob in ipairs(v26.Mobs) do
                            CombatController.ReleaseGrab(mob)
                          end
                        end
                      end

                      TweenController.Hovering = false
                      TweenController.HoverCFrame = nil
                      break
                    end
                  end

                  humanoid2 = v25:FindFirstChild("Humanoid")
                  humanoidRootPart2 = v25:FindFirstChild("HumanoidRootPart")
                  flag10 = not humanoid2

                  if (humanoid2 and (humanoid2.Health <= 0)) or (not humanoid2 and flag10) then
                    CombatController.ReleaseGrab(v25)

                    if tbl12.CheckQuest then
                      if not GetCurrentClaimQuest() then
                        if v26 then
                          if v26.Mobs then
                            for _, mob in ipairs(v26.Mobs) do
                              CombatController.ReleaseGrab(mob)
                            end
                          end
                        end

                        TweenController.Hovering = false
                        TweenController.HoverCFrame = nil
                        break
                      end
                    end

                    flag11 = not flag7

                    if not flag7 then
                      flag11 = CombatController.GetCurrentBringTarget(str4)
                    end

                    if not flag11 then
                      if v25.Name ~= "Don Swan" then
                        TweenController.Hovering = false
                        TweenController.HoverCFrame = nil
                      else
                        Storage:Set("SwanDefeated", true)
                        TweenController.Hovering = false
                        TweenController.HoverCFrame = nil
                        Hop()
                      end

                      break
                    end

                    v25 = flag11
                    humanoid2 = v25:FindFirstChild("Humanoid")
                    humanoidRootPart2 = v25:FindFirstChild("HumanoidRootPart")
                  end

                  if flag7 or not v26 then
                    if not flag7 then
                      local v36, v37 = CombatController.GetDistantBringMob(v26)

                      if v37 then
                        CombatController.Grab(str4, v26)
                      end
                    end
                  else
                    CombatController.RefreshBringTargets(str4, v26)
                    CombatController.Grab(str4, v26)
                    local v36, v37 = CombatController.GetDistantBringMob(v26)

                    if v37 then
                      CombatController.Grab(str4, v26)
                    end
                  end

                  specialClusterMobs2 = CombatController.SpecialClusterMobs

                  if specialClusterMobs2 then
                    specialClusterMobs2 = CombatController.SpecialClusterMobs[str4]
                  end

                  n11 = humanoidRootPart2.CFrame * CombatController.GetAttackOffset(humanoidRootPart2.CFrame)

                  if flag7 or specialClusterMobs2 then
                    v28 = n11

                    if not v28 then
                      v28 = CombatController.GetStandbyFrame(str4, v26)

                      if not v28 then
                        v28 = n11
                      end
                    end
                  else
                    v28 = CombatController.GetStandbyFrame(str4, v26)

                    if not v28 then
                      v28 = n11
                    end
                  end

                  if v23 then
                    if CaculateDistance(v28) > 1000 then
                      return
                    end
                  end

                  v29 = CaculateDistance(v28)

                  if v23 and (v29 <= 150) then
                    humanoidRootPart3 = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart3 then
                      stopTween(false)
                      humanoidRootPart3.CFrame = v28
                    else
                      TweenController.CreateDirect(v28, false, true)
                    end
                  elseif v29 > 150 then
                    TweenController.Create(v28, false, v23)
                    n12 = math.min(12, math.max(3, CaculateDistance(v28) / 200))
                    now7 = os.clock()

                    while (CaculateDistance(v28) > 150) and ((os.clock() - now7) < n12) do
                      if stopCondition then
                        if stopCondition() then
                          return
                        end
                      end

                      if not LocalPlayer.Character then
                        TweenController.ClearGhost()
                        return
                      end
                      humanoid3 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                      if not humanoid3 then
                        TweenController.ClearGhost()
                        return
                      end

                      if humanoid3.Health <= 0 then
                        TweenController.ClearGhost()
                        return
                      end

                      if not TweenController.Playing then
                        if CaculateDistance(v28) > 150 then
                          TweenController.Create(v28, false, v23)
                        end
                      end

                      task.wait(0.1)
                    end
                  elseif flag7 or specialClusterMobs2 then
                    TweenController.CreateDirect(v28, false, v23)
                  elseif CombatController.BRING_FOLLOW_DISTANCE < CaculateDistance(v28) then
                    TweenController.Create(v28, false, v23)
                  else
                    TweenController.Hovering = true
                    TweenController.HoverCFrame = v28
                    fn30()
                  end

                  if CaculateDistance(v28) < 150 then
                    if v18 then
                      v18()
                    end

                    if CombatController.SpecialClusterMobs then
                      if CombatController.SpecialClusterMobs[str4] then
                        CombatController.GrabSpecial(str4, humanoidRootPart2)
                      end
                    end

                    if v25.Name ~= "Core" then
                      if ScriptStorage.PlayerData.Level > 100 then
                        if CombatController.MAX_ATTACK_DURATION_2 <= n9 then
                          if (humanoid2.Health - humanoid2.MaxHealth) == 0 then
                            pcall(function() v25:Destroy() end)
                            continue
                          end
                        end
                      end

                      attribute = v25:GetAttribute("FailureCount")

                      if attribute then
                        if attribute > 5 then
                          pcall(function() v25:Destroy() end)
                          continue
                        end
                      end

                      if (CombatController.MAX_ATTACK_DURATION > n10) or ((humanoid2.Health - humanoid2.MaxHealth) ~= 0) then
                        local equipTool = FunctionsHandler.LocalPlayerController.Methods.EquipTool
                        v31 = equipTool
                        call = equipTool.Call

                        if ScriptStorage.ForceToUseSword then
                          str5 = "Sword"
                        else
                          str5 = "Melee"
                        end

                        call(v31, str5)

                        if not v23 then
                          CombatController.FreezeMob(v25)
                        end

                        flag12 = not flag7

                        if ((flag7 and flag12) or (not flag7 and v26)) and v26.Mobs then
                          for _, mob in ipairs(v26.Mobs) do
                            CombatController.FreezeMob(mob, v26.Anchor)
                          end
                        end

                        if v23 then
                          if humanoid.Health > 0 then
                            if humanoid.Health < (humanoid.MaxHealth * 0.45) then
                              now8 = os.clock()

                              while (humanoid.Health > 0) and ((humanoid.Health < (humanoid.MaxHealth * 0.85)) and ((os.clock() - now8) < 8)) do
                                TweenController.CreateDirect(humanoidRootPart2.CFrame * CFrame.new(0, 100, 0), false, v23)
                                task.wait(0.2)
                              end
                            end
                          end
                        end

                        FastAttack:Attack(v25)

                        if os.time() ~= now6 then
                          now6 = os.time()
                          n10 += 1
                          n9 += 1
                        end

                        if n10 > 30 then
                          if v25.Name ~= "Core" then
                            break
                          end
                        end

                        task.wait(0.03)
                        continue
                      else
                        attribute2 = v25:GetAttribute("OldPosition")
                        n10 = 0

                        if attribute2 then
                          CombatController.ReleaseGrab(v25)
                          v25:SetPrimaryPartCFrame(CFrame.new(attribute2))
                          v25:SetAttribute("IgnoreGrab", true)
                          v30 = v25
                          setAttribute = v25.SetAttribute
                          attribute3 = v25:GetAttribute("FailureCount")

                          if not attribute3 then
                            attribute3 = 0
                          end

                          setAttribute(v30, "FailureCount", attribute3 + 1)

                          while true do
                            if CaculateDistance(v25.HumanoidRootPart.CFrame, attribute2) <= 6 then
                              task.wait()
                              return
                            end

                            if not task.wait() then
                              task.wait()
                              return
                            end
                            v25.HumanoidRootPart.CFrame = CFrame.new(attribute2)
                          end
                        else
                          local equipTool = FunctionsHandler.LocalPlayerController.Methods.EquipTool
                          v31 = equipTool
                          call = equipTool.Call

                          if ScriptStorage.ForceToUseSword then
                            str5 = "Sword"
                          else
                            str5 = "Melee"
                          end

                          call(v31, str5)

                          if not v23 then
                            CombatController.FreezeMob(v25)
                          end

                          flag12 = not flag7

                          if ((flag7 and flag12) or (not flag7 and v26)) and v26.Mobs then
                            for _, mob in ipairs(v26.Mobs) do
                              CombatController.FreezeMob(mob, v26.Anchor)
                            end
                          end

                          if v23 then
                            if humanoid.Health > 0 then
                              if humanoid.Health < (humanoid.MaxHealth * 0.45) then
                                now8 = os.clock()

                                while (humanoid.Health > 0) and ((humanoid.Health < (humanoid.MaxHealth * 0.85)) and ((os.clock() - now8) < 8)) do
                                  TweenController.CreateDirect(humanoidRootPart2.CFrame * CFrame.new(0, 100, 0), false, v23)
                                  task.wait(0.2)
                                end
                              end
                            end
                          end

                          FastAttack:Attack(v25)

                          if os.time() ~= now6 then
                            now6 = os.time()
                            n10 += 1
                            n9 += 1
                          end

                          if n10 > 30 then
                            if v25.Name ~= "Core" then
                              break
                            end
                          end

                          task.wait(0.03)
                          continue
                        end
                      end
                    else
                      local equipTool = FunctionsHandler.LocalPlayerController.Methods.EquipTool
                      v31 = equipTool
                      call = equipTool.Call

                      if ScriptStorage.ForceToUseSword then
                        str5 = "Sword"
                      else
                        str5 = "Melee"
                      end

                      call(v31, str5)

                      if not v23 then
                        CombatController.FreezeMob(v25)
                      end

                      flag12 = not flag7

                      if ((flag7 and flag12) or (not flag7 and v26)) and v26.Mobs then
                        for _, mob in ipairs(v26.Mobs) do
                          CombatController.FreezeMob(mob, v26.Anchor)
                        end
                      end

                      if v23 then
                        if humanoid.Health > 0 then
                          if humanoid.Health < (humanoid.MaxHealth * 0.45) then
                            now8 = os.clock()

                            while (humanoid.Health > 0) and ((humanoid.Health < (humanoid.MaxHealth * 0.85)) and ((os.clock() - now8) < 8)) do
                              TweenController.CreateDirect(humanoidRootPart2.CFrame * CFrame.new(0, 100, 0), false, v23)
                              task.wait(0.2)
                            end
                          end
                        end
                      end

                      FastAttack:Attack(v25)

                      if os.time() ~= now6 then
                        now6 = os.time()
                        n10 += 1
                        n9 += 1
                      end

                      if n10 > 30 then
                        if v25.Name ~= "Core" then
                          break
                        end
                      end

                      task.wait(0.03)
                      continue
                    end
                  else
                    return
                  end
                end
              end

              TweenController.Hovering = false
              TweenController.HoverCFrame = nil
              return
            end

            CombatController.Attack = fn37
          LevelFarmTTL = 0
          LastTravel = os.time()
          LastQuestRefreshLevel = 0
          LastQuestRefreshTick = 0
          local v14
          v14 = nil
          local fn22

          fn22 = function(arg)
            if arg < 10 then
              return 4
            end

            if arg < 50 then
              return 1
            end

            if arg < 80 then
              return 2
            end
            return 4
          end

          local fn23

          fn23 = function(arg)
            local flag5 = SeaIndex ~= 1
            if flag5 then
              return flag5
            end
            local level

            if GetLiveLevel then
              level = (GetLiveLevel() or ScriptStorage.PlayerData.Level) or 0
            else
              level = ScriptStorage.PlayerData.Level or 0
            end

            return arg == fn22(level)
          end

          DragonTalonNeedsFireEssence = false
          LastUptimeTick = 0
          LastSideTaskTick = 0
          FunctionsHandler = {Initalized = false}
          local tbl7, tbl8, fn24, fn25, fn26, fn27, fn28, fn29, fn30, fn31

          do

            setmetatable(FunctionsHandler, {__index = function(arg, arg2)
              QueryResult = rawget(arg, arg2)
              if QueryResult then
                return QueryResult
              end

              return {Register = function(arg3)
                if arg3 ~= false then
                  Result = {CacheListener = {}, RealCache = {}, Methods = {}, Constants = {}, Events = {}, Initalized = true}

                  Result.RegisterMethod = function(arg4, arg5, arg6)
                    arg4.Methods[arg5] = {Name = arg5, Callback = arg6, Call = function(arg7, ...)
                      return arg7.Callback(...)
                    end, Events = {}}

                    return true
                  end

                  local function fn32()
                    assert(false, "cannot change constant value!")
                  end

                  setmetatable(Result.Constants, {__newindex = fn32})

                  Result.SaveConstant = function(arg4, arg5, arg6)
                    if arg4.Constants[arg5] then
                      return assert(false, "constant name was used before!")
                    end
                    rawset(arg4.Constants, arg5, arg6)
                  end

                  Result.Set = function(arg4, arg5, arg6)
                    arg4.CacheListener[arg5] = arg6
                    return arg6
                  end

                  local function get(arg4, arg5)
                    local v15 = arg4.Constants[arg5]
                    if v15 then
                      return v15
                    end
                    return arg4.RealCache[arg5]
                  end

                  Result.Get = get

                  local function addVariableChangeListener(arg4, arg5, arg6)
                    arg4.Events[arg5] = arg6
                  end

                  Result.AddVariableChangeListener = addVariableChangeListener
                  Result.CacheListener.__parent = Result

                  setmetatable(Result.CacheListener, {__newindex = function(arg4, arg5, arg6)
                    _ = arg4.__parent.Events[arg5] and arg4.__parent.Events[arg5](arg5, arg6)
                    arg4.__parent.RealCache[arg5] = arg6
                  end})

                  FunctionsHandler[arg2] = Result
                  return
                end
              end, Initalized = false}
            end})

            FunctionsHandler.SynchorizeUntilModuleLoaded = function(arg, arg2)
              local now4 = os.time()

              while not arg.Initalized do
                task.wait()
                local n3 = os.time() - now4
                assert(not (arg2 and (n3 > arg2)), "timed out")
              end
            end

            GetCurrentClaimQuest = function(...)
              return QuestController.GetCurrentClaimQuest(...)
            end

            FunctionsHandler.LocalPlayerController.Register()
            FunctionsHandler.ExpRedeem:Register()
            FunctionsHandler.LevelFarm:Register()
            FunctionsHandler.Yama:Register()
            FunctionsHandler.Tushita:Register()
            FunctionsHandler.CursedDualKatana:Register()
            FunctionsHandler.SoulGuitar:Register()
            FunctionsHandler.SecondSeaPuzzle:Register()
            FunctionsHandler.ColosseumPuzzle:Register()
            FunctionsHandler.Trevor:Register()
            FunctionsHandler.ThirdSeaPuzzle:Register()
            FunctionsHandler.PirateRaid:Register()
            FunctionsHandler.RaidController:Register()
            FunctionsHandler.MeleeBuyController:Register()
            FunctionsHandler.CannonBuyController:Register()
            FunctionsHandler.MeleesController:Register()
            FunctionsHandler.BossesTask:Register()
            FunctionsHandler.SpecialBossesTask:Register()
            FunctionsHandler.CollectDrops:Register()
            FunctionsHandler.UtillyItemsActivitation:Register()

            local function fn32()
              local n3 = 0

              pcall(function()
                local guideModule = game:GetService("ReplicatedStorage"):FindFirstChild("GuideModule")

                if guideModule then
                  local v15 = getsenv(guideModule)

                  if v15 then
                    if v15._G then
                      if v15._G.ServerData then
                        if v15._G.ServerData.ExpBoost then
                          local n4 = tonumber(v15._G.ServerData.ExpBoost) or 0
                          local now4 = tonumber(v15._G.ServerData.ExpBoostTick) or tick()
                          n3 = math.max(0, math.floor((n4 - tick()) - now4))
                          return
                        end
                      end
                    end
                  end
                end
              end)

              return n3
            end

            local function fn33()
              if fn32() > 0 then
                return
              end
              local tbl = {}
              local tbl9 = {}

              local function fn34(arg)
                if arg then
                  if arg == "" then
                    return
                  end

                  if not tbl9[arg] then
                    tbl9[arg] = true
                    table.insert(tbl, arg)
                    return
                  end
                end
              end

              pcall(function()
                local v15 = request({Url = "https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json", Method = "GET"})
                local statusCode

                if v15 then
                  statusCode = v15.StatusCode or 0
                else
                  statusCode = 0
                end

                local num = tonumber(tostring(statusCode):sub(1, 1))
                local body, HttpService2, v16, jsonDecode, response, v17, exitTo, str4, str5

                if v15.Body then
                  if not v15.Body:find("Just a moment") then
                    if v15.Body then
                      body = v15.Body

                      if not body:find("Checking your browser") then
                        if num ~= 4 then
                          if num == 5 then
                            return
                          end
                          HttpService2 = game:GetService("HttpService")
                          v16 = HttpService2
                          jsonDecode = HttpService2.JSONDecode

                          if HttpGet then
                            response = HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")

                            if not response then
                              response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                            end
                          else
                            response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                          end

                          v17 = jsonDecode(v16, response.parse.text["*"])

                          if v17 ~= "" then
                            for match, match2 in tostring(v17):gmatch("<code>([%w_%-]+)</code>.-<td>(.-)</td>") do
                              exitTo = nil

                              if match ~= "" then
                                str4 = tostring(match2):gsub("<[^>]+>", "")
                                str5 = str4:lower()

                                if str5:find("2x exp") then
                                  fn34(match)
                                end
                              end
                            end

                            return
                          end
                        end
                      end
                    elseif num ~= 4 then
                      if num ~= 5 then
                        HttpService2 = game:GetService("HttpService")
                        v16 = HttpService2
                        jsonDecode = HttpService2.JSONDecode

                        if HttpGet then
                          response = HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")

                          if not response then
                            response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                          end

                          v17 = jsonDecode(v16, response.parse.text["*"])

                          if v17 ~= "" then
                            for match, match2 in tostring(v17):gmatch("<code>([%w_%-]+)</code>.-<td>(.-)</td>") do
                              exitTo = nil

                              if match ~= "" then
                                str4 = tostring(match2):gsub("<[^>]+>", "")
                                str5 = str4:lower()

                                if str5:find("2x exp") then
                                  fn34(match)
                                end
                              end
                            end

                            return
                          end

                          return
                        else
                          response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                        end
                      end

                      return
                    end
                  end

                  return
                else
                  if not v15.Body then
                    if num == 4 then
                      return
                    end

                    if num ~= 5 then
                      HttpService2 = game:GetService("HttpService")
                      v16 = HttpService2
                      jsonDecode = HttpService2.JSONDecode

                      if HttpGet then
                        response = HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")

                        if response then
                          v17 = jsonDecode(v16, response.parse.text["*"])

                          if v17 ~= "" then
                            for match, match2 in tostring(v17):gmatch("<code>([%w_%-]+)</code>.-<td>(.-)</td>") do
                              exitTo = nil

                              if match ~= "" then
                                str4 = tostring(match2):gsub("<[^>]+>", "")
                                str5 = str4:lower()

                                if str5:find("2x exp") then
                                  fn34(match)
                                end
                              end
                            end

                            return
                          end

                          return
                        end

                        response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                        v17 = jsonDecode(v16, response.parse.text["*"])

                        if v17 ~= "" then
                          for match, match2 in tostring(v17):gmatch("<code>([%w_%-]+)</code>.-<td>(.-)</td>") do
                            exitTo = nil

                            if match ~= "" then
                              str4 = tostring(match2):gsub("<[^>]+>", "")
                              str5 = str4:lower()

                              if str5:find("2x exp") then
                                fn34(match)
                              end
                            end
                          end

                          return
                        end

                        return
                      end

                      response = game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&format=json")
                      v17 = jsonDecode(v16, response.parse.text["*"])

                      if v17 ~= "" then
                        for match, match2 in tostring(v17):gmatch("<code>([%w_%-]+)</code>.-<td>(.-)</td>") do
                          exitTo = nil

                          if match ~= "" then
                            str4 = tostring(match2):gsub("<[^>]+>", "")
                            str5 = str4:lower()

                            if str5:find("2x exp") then
                              fn34(match)
                            end
                          end
                        end

                        return
                      end

                      return
                    end

                    return
                  end

                  body = v15.Body
                  if body:find("Checking your browser") then
                    return
                  end
                end
              end)

              for _, v15 in ipairs({"Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy", "THELAUGHINGCAT", "axiore", "Sub2CaptainMaui", "sub2officialnoobie", "StrawHatMaine", "Sub2Daigrock", "TantaiGaming", "SUB2NOOBMASTER123", "sub2gamerrobot_exp1", "SUB2GAMERROBOT_EXP1", "easterexp", "kittgaming", "Sub2UncleKizaru", "CHANDLER", "SUB2DRAGONBALLZ", "SUB2PEYTON8432", "STRAWHATMAINO", "BLESSEDRNG", "FruitHub888", "lightningabuse", "thegreatace", "SEKTI_EXP1", "NEWTROLL", "ADMINHACKED", "youtuber_servcode", "EARN_FRUITS", "FIGHT4FRUIT", "NOOB2PRO", "TY_FOR_WATCHING", "KittGaming", "Sub2Gambit", "Axiore", "fudd10_v2", "FUDD10", "BIGNEWS", "DEVSCOOKING", "CODE_SLAYER", "15B_BESTBROTHERS", "CINCODEMAYO_BOOST", "ADMINGIVEAWAY", "GAMERROBOT_YT", "GAMER_ROBOT_1M", "UPD16", "1MLIKES_RESET", "2BILLION", "THIRDSEA"}) do
                fn34(v15)
              end

              local RedeemedExpCodes = Storage:Get("RedeemedExpCodes") or {}

              for _, v15 in ipairs(tbl) do
                if not _G.Stop then
                  if fn32() > 0 then
                    return
                  end

                  if not RedeemedExpCodes[v15] then
                    pcall(function()
                      Remotes.Redeem:InvokeServer(v15)
                    end)

                    RedeemedExpCodes[v15] = true
                    Storage:Set("RedeemedExpCodes", RedeemedExpCodes)
                    Storage:Save()
                    task.wait(1)

                    if fn32() > 0 then
                      pcall(function()
                        SetTask("SideTask", "2x EXP Active (" .. (v15 .. ")"))
                      end)

                      return
                    end
                  end
                end

                return
              end
            end

            task.spawn(function()
              task.wait(3)

              while not _G.Stop do
                local level

                if GetLiveLevel then
                  level = (GetLiveLevel() or ScriptStorage.PlayerData.Level) or 0
                else
                  level = ScriptStorage.PlayerData.Level or 0
                end

                if level < MaxLevel then
                  if fn32() == 0 then
                    pcall(fn33)
                  end
                end

                task.wait(10)
              end
            end)

            FunctionsHandler.LevelFarm:RegisterMethod("Refresh", function()
              if SeaIndex ~= 1 then
                if CombatController.IsRaidActive() then
                  return nil
                end
              end

              local raidController = FunctionsHandler.RaidController

              if raidController then
                if raidController.Initalized then
                  if raidController.Methods.IsLocked then
                    local ok, result = pcall(function()
                      return raidController.Methods.IsLocked:Call()
                    end)

                    if ok then
                      if result then
                        return nil
                      end
                    end
                  end
                end
              end

              local level

              if GetLiveLevel then
                level = (GetLiveLevel() or ScriptStorage.PlayerData.Level) or 0
              else
                level = ScriptStorage.PlayerData.Level or 0
              end

              if SeaIndex == 3 then
                if QuestController:IsUnderWaterQuest() then
                  return 5
                end
              end

              local v15 = fn22(level)

              if SeaIndex == 1 then
                if v14 then
                  if v14 ~= v15 then
                    TweenController.ClearGhost()
                  end
                end
              end

              v14 = v15
              return v15
            end)

            FunctionsHandler.LevelFarm:RegisterMethod("Start", function(arg)
              if fn23(arg) then
                local function fn34()
                  return not fn23(arg)
                end

                if SeaIndex ~= 1 then
                  if CombatController.IsRaidActive() then
                    return
                  end
                end

                local level = ScriptStorage.PlayerData.Level
                local flag5 = false

                if SeaIndex == 3 then
                  local bones = ScriptStorage.Backpack.Bones

                  if not bones then
                    bones = {Count = 0}
                  end

                  if bones.Count >= 50 then
                    local now4, n3

                    if ForceToRollBone then
                      now4 = os.time()
                      n3 = BonesCooldown

                      if n3 then
                        if n3 < now4 then
                          local response, v15, n4, v16 = Remotes.CommF_:InvokeServer("Bones", "Check")
                          local str4 = v16
                          n4 = n4 or 1

                          if tonumber(n4) ~= 0 then
                            local v17 = SetTask
                            local str5

                            if ScriptStorage.Tools["Fire Essence"] then
                              str5 = "Bones | Rolling Random Surprise"
                            elseif IsFireEssenceGave then
                              str5 = "Bones | Rolling Random Surprise"
                            elseif IsMeleePurchaseComplete("Dragon Talon") then
                              str5 = "Bones | Rolling Random Surprise"
                            else
                              str5 = "Bones | Rolling Random Surprise for Fire Essence"
                            end

                            v17("MainTask", str5)

                            local ok, result = pcall(function()
                              return Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                            end)

                            flag5 = ok and (result == 1)
                            task.wait(0.3)
                            pcall(RefreshInventory)
                          else
                            str4 = str4 or "0:0"
                            local match, v17 = tostring(str4):match("(%d+):(%d+)")
                            local n5 = (tonumber(match) or 0) * 60
                            local n6 = tonumber(v17) or 0
                            BonesCooldown = os.time() + ((n5 + n6) * 60)
                          end
                        end
                      else
                        n3 = 0
                      end
                    elseif not ScriptStorage.Tools["Fire Essence"] then
                      if not IsFireEssenceGave then
                        if not IsMeleePurchaseComplete("Dragon Talon") then
                          now4 = os.time()
                          n3 = BonesCooldown

                          if not n3 then
                            n3 = 0
                          end
                        end
                      end
                    end
                  end
                end

                if SeaIndex == 3 then
                  if DragonTalonNeedsFireEssence then
                    if not ScriptStorage.Tools["Fire Essence"] then
                      if not IsFireEssenceGave then
                        if flag5 then
                          return
                        end
                        local count = (ScriptStorage.Backpack.Bones or {Count = 0}).Count

                        if count < 50 then
                          SetTask("MainTask", "Dragon Talon | Farming Bones for Fire Essence ( " .. (count .. " / 50 )"))
                          CombatController.Attack({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}, nil, nil, nil, {AllowBring = true})
                          return
                        end

                        local now4 = os.time()
                        local v15 = BonesCooldown

                        if v15 then
                          if v15 < now4 then
                            return
                          end
                        elseif now4 > 0 then
                          return
                        end

                        SetTask("SideTask", "Dragon Talon | Random Surprise cooldown")
                      end
                    end
                  end
                end

                if GodHumanFlag then
                  local function fn35()
                    getgenv()["     mphm >< <3"] = {}

                    for k, v15 in pairs(GodhumanMaterials) do
                      if (ScriptStorage.Backpack[k] or {Count = 0}).Count < v15[1] then
                        getgenv()["     mphm >< <3"] = {k, v15}
                      end
                    end

                    return unpack(getgenv()["     mphm >< <3"])
                  end

                  local v15, v16 = fn35()

                  if v15 then
                    if SeaIndex ~= v16[2] then
                      SetTask("MainTask", "Sea Travel | Godhuman Materials | Travelling to Sea " .. v16[2])
                      Remotes.CommF_:InvokeServer("Travel" .. SeaIndexes[v16[2]])
                      return
                    end

                    SetTask("MainTask", "Material Farming | Godhuman | " .. (v15 .. " | In Progress"))
                    local v17

                    if v16[4][3] <= level then
                      local v18, v19 = GetCurrentClaimQuest()

                      if v18 then
                        if not string.find(v19, v16[3][1]) then
                          if not string.find(v19, v16[3][2]) then
                            QuestController.AbandonQuest()
                            v17 = v16[3]
                            CombatController.Attack(v17, nil, nil, nil, {AllowBring = true})
                            return
                          end
                        end

                        CombatController.Attack(v16[3], nil, nil, nil, {AllowBring = true})
                        return
                      end

                      local v20 = ScriptStorage.NPCs[v16[4][4]]

                      if v20 then
                        local modelCFrame = v20:GetModelCFrame()

                        if modelCFrame then
                          TweenController.Create(modelCFrame + Vector3.new(0, 5, 3))
                          local now4 = os.clock()

                          while CaculateDistance(modelCFrame) > 12 do
                            if (os.clock() - now4) < 15 then
                              if LocalPlayer.Character then
                                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid then
                                  if humanoid.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end
                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end

                          if CaculateDistance(modelCFrame) > 15 then
                            return
                          end
                        else
                          Report("NPC HauntedQuest2 not found")
                        end

                        task.wait(1)
                        QuestController.StartQuest(v16[4][1], v16[4][2])
                        task.wait(0.5)
                        return
                      end

                      Report("NPC HauntedQuest2 not found")
                      task.wait(1)
                      QuestController.StartQuest(v16[4][1], v16[4][2])
                      task.wait(0.5)
                      return
                    end

                    v17 = v16[3]
                    CombatController.Attack(v17, nil, nil, nil, {AllowBring = true})
                    return
                  end

                  GodHumanFlag = false
                  SetTask("SideTask", "Godhuman materials ready; waiting for MeleeBuyController")
                  return
                end

                local v15 = LastTravel

                if (os.time() - v15) > 60 then
                  LastTravel = os.time()

                  if level >= 1500 then
                    if SeaIndex ~= 2 then
                      if level >= 700 then
                        if SeaIndex == 1 then
                          SetTask("MainTask", "Sea Travel | Teleporting to Second Sea")
                          Remotes.CommF_:InvokeServer("TravelDressrosa")
                        end
                      end
                    elseif not Services.Workspace.Map.IceCastle.Hall.LibraryDoor:FindFirstChild("PhoeyuDoor") then
                      Remotes.CommF_:InvokeServer("TravelZou")
                      SetTask("MainTask", "Sea Travel | Teleporting to Third Sea")
                    end
                  elseif level >= 700 then
                    if SeaIndex == 1 then
                      SetTask("MainTask", "Sea Travel | Teleporting to Second Sea")
                      Remotes.CommF_:InvokeServer("TravelDressrosa")
                    end
                  end
                end

                if level == MaxLevel then
                  if (ScriptStorage.Backpack.Bones or {Count = 0}).Count >= 500 then
                    SetTask("MainTask", "Fragments Farming | Cake Prince | Dough King")
                    local cakePrince = ScriptStorage.Enemies["Cake Prince"]

                    if cakePrince then
                      if cakePrince:FindFirstChild("Humanoid") then
                        if cakePrince.Humanoid.Health > 0 then
                          CombatController.Attack(cakePrince.Name, nil, nil, nil, {AllowBring = false})
                          return
                        end
                      end
                    else
                      cakePrince = ScriptStorage.Enemies["Dough King"]

                      if cakePrince then
                        if cakePrince:FindFirstChild("Humanoid") then
                          if cakePrince.Humanoid.Health > 0 then
                            CombatController.Attack(cakePrince.Name, nil, nil, nil, {AllowBring = false})
                            return
                          end
                        end
                      end
                    end

                    local v16, v17 = GetCurrentClaimQuest()

                    if v16 then
                      if string.find(v17, "Cookie") then
                        CombatController.Attack("Cookie Crafter", nil, nil, nil, {AllowBring = true, CheckQuest = true})
                        Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                        return
                      end

                      if not string.find(v17, "Cake") then
                        if not string.find(v17, "Guard") then
                          if not string.find(v17, "Baker") then
                            if not string.find(v17, "Baking") then
                              QuestController.AbandonQuest()
                              task.wait(0.5)
                              return
                            end
                          end

                          CombatController.Attack("Baking Staff", nil, nil, nil, {AllowBring = true, CheckQuest = true})
                          Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                          return
                        end
                      end

                      CombatController.Attack("Cake Guard", nil, nil, nil, {AllowBring = true, CheckQuest = true})
                      Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                      return
                    end

                    local cakeQuestGiver1 = ScriptStorage.NPCs["Cake Quest Giver 1"]

                    if cakeQuestGiver1 then
                      local modelCFrame = cakeQuestGiver1:GetModelCFrame()

                      if modelCFrame then
                        TweenController.Create(modelCFrame + Vector3.new(0, 5, 3))
                        local now4 = os.clock()

                        while CaculateDistance(modelCFrame) > 12 do
                          if (os.clock() - now4) < 15 then
                            if LocalPlayer.Character then
                              local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                              if humanoid then
                                if humanoid.Health <= 0 then
                                  TweenController.ClearGhost()
                                  return
                                end
                                task.wait(0.1)
                                continue
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            TweenController.ClearGhost()
                            return
                          end

                          break
                        end

                        if CaculateDistance(modelCFrame) > 15 then
                          return
                        end
                      else
                        Report("NPC Cake Quest Giver 1 not found")
                      end

                      task.wait(1)
                      QuestController.StartQuest("CakeQuest1", 1)
                      task.wait(0.5)
                      return
                    end

                    Report("NPC Cake Quest Giver 1 not found")
                    task.wait(1)
                    QuestController.StartQuest("CakeQuest1", 1)
                    task.wait(0.5)
                    return
                  end
                end

                if Config.FarmBoneForx2EXP and (level >= 2025) and ((fn32() == 0) or (level == MaxLevel)) then
                  local bones = ScriptStorage.Backpack.Bones or {Count = 0}

                  if bones.Count < 500 then
                    SetTask("MainTask", "Resource Farming | Bones | For X2 Mastery/Beli")
                    CurrentClaimQuest3 = GetCurrentClaimQuest(true)

                    if CurrentClaimQuest3 then
                      if string.find(CurrentClaimQuest3, "Demonic") then
                        CombatController.Attack({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}, nil, nil, nil, {AllowBring = true})
                        return
                      end
                      QuestController.AbandonQuest()
                      return
                    end

                    local hauntedCastleQuestGiver2 = ScriptStorage.NPCs["Haunted Castle Quest Giver 2"]

                    if hauntedCastleQuestGiver2 then
                      local modelCFrame = hauntedCastleQuestGiver2:GetModelCFrame()

                      if modelCFrame then
                        TweenController.Create(modelCFrame + Vector3.new(0, 5, 3))
                        if CaculateDistance(modelCFrame) >= 20 then
                          return
                        end
                        task.wait(1)
                      else
                        Report("NPC HauntedQuest2 not found")
                      end

                      QuestController.StartQuest("HauntedQuest2", 1)
                      return
                    end

                    Report("NPC HauntedQuest2 not found")
                    QuestController.StartQuest("HauntedQuest2", 1)
                    return
                  end
                end

                if arg ~= 1 then
                  if arg ~= 2 then
                    if arg ~= 3 then
                      if arg ~= 5 then
                        if arg ~= 4 then
                          return
                        end
                        local v16 = GetLiveLevel()
                        if fn34() then
                          return
                        end
                        local n3, fn35

                        if v16 ~= LastQuestRefreshLevel then

                          fn35 = function()
                            QuestController:RefreshQuest()
                          end

                          pcall(fn35)
                          LastQuestRefreshLevel = v16
                          LastQuestRefreshTick = os.time()
                        else
                          local v17 = LastQuestRefreshTick

                          if (os.time() - v17) > 20 then

                            fn35 = function()
                              QuestController:RefreshQuest()
                            end

                            pcall(fn35)
                            LastQuestRefreshLevel = v16
                            LastQuestRefreshTick = os.time()
                          end
                        end

                        local currentQuest, v17, v18, v19, v20 = QuestController:GetCurrentQuest()
                        local currentNpc = v17

                        if currentQuest then
                          if v20 then
                            local v22, v23 = GetCurrentClaimQuest()
                            if fn34() then
                              return
                            end

                            if v22 then
                              if v22 ~= v20 then
                                if v22 ~= (v20 .. "s") then
                                  warn("UI≠script Abandon Raw=", v23, " Norm=", v22, " Tit=", v20, " Mon=", currentQuest, " Q=", v18)
                                  QuestController.AbandonQuest()

                                  pcall(function()
                                    QuestController:RefreshQuest()
                                  end)

                                  LastQuestRefreshLevel = ScriptStorage.PlayerData.Level
                                  LastQuestRefreshTick = os.time()
                                  return
                                end
                              end
                            else
                              if not currentNpc then
                                pcall(function()
                                  QuestController:RefreshQuest()
                                end)

                                currentNpc = QuestController.CurrentNpc
                                if not currentNpc then
                                  resetCurrentQuest("lvl4_npcpos_nil", "[L4] NpcPosition nil Q," .. (tostring(v18) .. (" idx," .. (tostring(v19) .. (" " .. tostring(v20))))))
                                  return Report("failed to get npc position quest 528")
                                end
                              end

                              if fn34() then
                                return
                              end
                              SetTask("MainTask", "Level Farming | " .. (currentQuest .. " | Claiming Quest"))
                              TweenController.Create(currentNpc + Vector3.new(0, 5, 3))
                              local now4 = os.clock()

                              while CaculateDistance(currentNpc) > 12 do
                                if (os.clock() - now4) < 20 then
                                  if fn34() then
                                    return
                                  end
                                  local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                  local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                                  if humanoid then
                                    if humanoid.Health <= 0 then
                                      TweenController.ClearGhost()
                                      return
                                    end

                                    if humanoidRootPart then
                                      if SeaIndex ~= 1 then
                                        if CombatController.IsRaidActive() then
                                          TweenController.ClearGhost()
                                          return
                                        end
                                      end
                                    end

                                    if not TweenController.Playing then
                                      if CaculateDistance(currentNpc) > 12 then
                                        TweenController.Create(currentNpc + Vector3.new(0, 5, 3))
                                      end
                                    end

                                    task.wait(0.1)
                                    continue
                                  end

                                  TweenController.ClearGhost()
                                  return
                                end

                                break
                              end

                              if fn34() then
                                return
                              end

                              if CaculateDistance(currentNpc) > 15 then
                                resetCurrentQuest("lvl4_claim_retry_exhausted", "[L4] claim max try d=" .. (string.format("%.0f", CaculateDistance(currentNpc)) .. (" " .. currentQuest)))
                                return
                              end
                              task.wait(2)
                              if fn34() then
                                return
                              end
                              LevelFarmTTL = 0
                              QuestController.StartQuest(v18, v19)
                              if fn34() then
                                return
                              end
                              task.wait(1)
                              if fn34() then
                                return
                              end

                              if not GetCurrentClaimQuest() then
                                task.wait(0.5)
                                if fn34() then
                                  return
                                end
                                QuestController.StartQuest(v18, v19)
                                if fn34() then
                                  return
                                end
                                task.wait(1)
                                if fn34() then
                                  return
                                end

                                if not GetCurrentClaimQuest() then
                                  return
                                end
                              end
                            end

                            SetTask("MainTask", "Level Farming | " .. (currentQuest .. " | Defeating Enemies"))
                            local now4 = os.time()
                            CombatController.Attack(currentQuest, nil, nil, nil, {AllowBring = true, CheckQuest = true, StopCondition = fn34})
                            LevelFarmTTL = (LevelFarmTTL + os.time()) - now4
                            return
                          end
                        end

                        local str4 = tostring(currentQuest)
                        resetCurrentQuest("lvl4_no_montitle", "[L4] no Task Mon," .. (str4 .. (" Tit," .. (tostring(v20) .. (" id," .. (tostring(QuestController.CurrentQuestId) .. (" i," .. (tostring(QuestController.CurrentLevel) .. ("," .. tostring(QuestController.CurrentQuests[QuestController.CurrentLevel] and QuestController.CurrentQuests[QuestController.CurrentLevel].Name))))))))))
                        return
                      end

                      local v16 = GetLiveLevel()

                      if v16 ~= LastQuestRefreshLevel then
                        pcall(function()
                          QuestController:RefreshQuest()
                        end)

                        LastQuestRefreshLevel = v16
                        LastQuestRefreshTick = os.time()
                      else
                        local v17 = LastQuestRefreshTick

                        if (os.time() - v17) > 20 then
                          pcall(function()
                            QuestController:RefreshQuest()
                          end)

                          LastQuestRefreshLevel = v16
                          LastQuestRefreshTick = os.time()
                        end
                      end

                      local currentQuest, v17, v18, v19, v20 = QuestController:GetCurrentQuest()
                      local cframe = v17

                      if currentQuest then
                        if v20 then
                          if questAllowMap[tostring(v18)] then
                            if stripQuestSpaces() then
                              local v22, v23 = GetCurrentClaimQuest()

                              if v22 then
                                if v22 ~= v20 then
                                  if v22 ~= (v20 .. "s") then
                                    warn("UI~=script Abandon Raw=", v23, " Norm=", v22, " Tit=", v20, " Mon=", currentQuest, " Q=", v18)
                                    QuestController.AbandonQuest()

                                    pcall(function()
                                      QuestController:RefreshQuest()
                                    end)

                                    LastQuestRefreshLevel = ScriptStorage.PlayerData.Level
                                    LastQuestRefreshTick = os.time()
                                    return
                                  end
                                end
                              else
                                local v24

                                if cframe then
                                  if not cframe then
                                    v24 = workspace.Enemies:FindFirstChild(currentQuest)

                                    if v24 then
                                      if v24:FindFirstChild("HumanoidRootPart") then
                                        cframe = (v24.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)) or CFrame.new(11256, -2138, 9888)
                                      else
                                        cframe = CFrame.new(11256, -2138, 9888)
                                      end
                                    else
                                      cframe = CFrame.new(11256, -2138, 9888)
                                    end
                                  end
                                else
                                  cframe = matchQuestTitle(questNameOverrides[tostring(v18)])

                                  if cframe then
                                    if not cframe then
                                      v24 = workspace.Enemies:FindFirstChild(currentQuest)

                                      if v24 then
                                        if v24:FindFirstChild("HumanoidRootPart") then
                                          cframe = (v24.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)) or CFrame.new(11256, -2138, 9888)
                                        end
                                      else
                                        cframe = CFrame.new(11256, -2138, 9888)
                                      end
                                    end
                                  elseif stripQuestSpaces() then
                                    if workspace:FindFirstChild("NPCs") then
                                      for _, child in ipairs(workspace.NPCs:GetChildren()) do
                                        if normQuestName(child:GetPivot().Position) then
                                          if child.Name:lower():find("quest") then
                                            cframe = child:GetPivot()
                                            break
                                          elseif child.Name:lower():find("giver") then
                                            cframe = child:GetPivot()
                                            break
                                          end
                                        end
                                      end

                                      if not cframe then
                                        v24 = workspace.Enemies:FindFirstChild(currentQuest)

                                        if v24 then
                                          if v24:FindFirstChild("HumanoidRootPart") then
                                            cframe = (v24.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)) or CFrame.new(11256, -2138, 9888)
                                          end
                                        else
                                          cframe = CFrame.new(11256, -2138, 9888)
                                        end
                                      end
                                    elseif not cframe then
                                      v24 = workspace.Enemies:FindFirstChild(currentQuest)

                                      if v24 then
                                        if v24:FindFirstChild("HumanoidRootPart") then
                                          cframe = (v24.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)) or CFrame.new(11256, -2138, 9888)
                                        end
                                      else
                                        cframe = CFrame.new(11256, -2138, 9888)
                                      end
                                    end
                                  elseif not cframe then
                                    v24 = workspace.Enemies:FindFirstChild(currentQuest)

                                    if v24 then
                                      if v24:FindFirstChild("HumanoidRootPart") then
                                        cframe = (v24.HumanoidRootPart.CFrame + Vector3.new(0, 20, 0)) or CFrame.new(11256, -2138, 9888)
                                      end
                                    else
                                      cframe = CFrame.new(11256, -2138, 9888)
                                    end
                                  end
                                end

                                SetTask("MainTask", "Level Farming | Under Water | " .. (currentQuest .. " | Claiming Quest"))
                                TweenController.Create(cframe + Vector3.new(0, 5, 3))
                                local now4 = os.clock()

                                while CaculateDistance(cframe) > 12 do
                                  if (os.clock() - now4) < 20 then
                                    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    local character = LocalPlayer.Character

                                    if character then
                                      character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                      if not humanoid then
                                        TweenController.ClearGhost()
                                        return
                                      end
                                    elseif not humanoid then
                                      TweenController.ClearGhost()
                                      return
                                    end

                                    if humanoid.Health <= 0 then
                                      TweenController.ClearGhost()
                                      return
                                    end

                                    if character then
                                      if SeaIndex ~= 1 then
                                        if CombatController.IsRaidActive() then
                                          TweenController.ClearGhost()
                                          return
                                        end
                                      end
                                    end

                                    if not TweenController.Playing then
                                      if CaculateDistance(cframe) > 12 then
                                        TweenController.Create(cframe + Vector3.new(0, 5, 3))
                                      end
                                    end

                                    task.wait(0.1)
                                    continue
                                  end

                                  break
                                end

                                if CaculateDistance(cframe) > 15 then
                                  resetCurrentQuest("lvl5_claim_retry_exhausted", "[L5] claim max try d=" .. (string.format("%.0f", CaculateDistance(cframe)) .. (" " .. currentQuest)))
                                  return
                                end
                                task.wait(2)
                                LevelFarmTTL = 0
                                QuestController.StartQuest(v18, v19)
                                task.wait(1)

                                if not GetCurrentClaimQuest() then
                                  task.wait(0.5)
                                  QuestController.StartQuest(v18, v19)
                                  task.wait(1)
                                  if not GetCurrentClaimQuest() then
                                    return
                                  end
                                end
                              end

                              SetTask("MainTask", "Level Farming | Under Water | " .. (currentQuest .. " | Defeating Enemies"))
                              local now4 = os.time()
                              CombatController.Attack(currentQuest, nil, nil, nil, {AllowBring = true, CheckQuest = true})
                              LevelFarmTTL = (LevelFarmTTL + os.time()) - now4
                              return
                            end

                            SetTask("MainTask", "Level Farming | Under Water | Entering Submerged")
                            trySubmarineTravel(Vector3.new(11256, -2138, 9888))
                            return
                          end
                        end
                      end

                      pcall(function()
                        QuestController:RefreshQuest()
                      end)

                      if FunctionsHandler.LevelFarm then
                        if FunctionsHandler.LevelFarm.Methods then
                          if FunctionsHandler.LevelFarm.Methods.Start then
                            return FunctionsHandler.LevelFarm.Methods.Start.Callback(4)
                          end
                        end
                      end

                      return
                    end

                    SetTask("MainTask", "Level Farming | Skip Mode | Floor " .. arg)
                    CombatController.Attack({"God's Guard", "Shanda", "Royal Soldier", "Royal Squad"}, nil, nil, nil, {AllowBring = true, StopCondition = fn34})
                    return
                  end

                  SetTask("MainTask", "Level Farming | Skip Mode | Floor " .. arg)
                  CombatController.Attack("God's Guard", nil, nil, nil, {AllowBring = true, StopCondition = fn34})
                  return
                end

                SetTask("MainTask", "Level Farming | Skip Mode | Floor " .. arg)
                local enemies = workspace:FindFirstChild("Enemies")
                local v16 = nil

                if enemies then
                  v16 = nil

                  for _, child in ipairs(enemies:GetChildren()) do
                    if child.Name ~= "Sky Bandit" then
                      v16 = nil
                    elseif CombatController.GetAliveMob(child) then
                      v16 = child
                      break
                    else
                      v16 = nil
                    end
                  end

                  if v16 then
                    CombatController.Attack("Sky Bandit", nil, nil, nil, {AllowBring = true, TargetInstance = v16, StopCondition = fn34})
                    return
                  end
                elseif v16 then
                  CombatController.Attack("Sky Bandit", nil, nil, nil, {AllowBring = true, TargetInstance = v16, StopCondition = fn34})
                  return
                end

                local skyBandit = ScriptStorage.MobRegions["Sky Bandit"]
                if skyBandit then
                  skyBandit = skyBandit[1]

                  if skyBandit then

                    local n3

                    if typeof(skyBandit) ~= "CFrame" then
                      skyBandit = CFrame.new(skyBandit)
                    end
                    if skyBandit then
                      n3 = skyBandit * CombatController.GetAttackOffset(skyBandit)
                      local flag6, playing, hoverCFrame

                      if n3 then
                        flag6 = not tweenTargetInstance

                        if tweenTargetInstance then
                          flag6 = (tweenTargetInstance.Position - n3.Position).Magnitude > 8
                        end

                        if TweenController.Playing then
                          if flag6 then
                            if flag6 then
                              TweenController.Create(n3)
                            end
                          else
                            playing = TweenController.Playing

                            if playing then
                              flag6 = TweenController.Hovering

                              if flag6 then
                                hoverCFrame = TweenController.HoverCFrame
                                flag6 = not hoverCFrame

                                if hoverCFrame then
                                  if CaculateDistance(TweenController.HoverCFrame, n3) > 8 then
                                    TweenController.Create(n3)
                                    task.wait(0.5)
                                    return
                                  end
                                elseif flag6 then
                                  TweenController.Create(n3)
                                  task.wait(0.5)
                                  return
                                end
                              elseif flag6 then
                                TweenController.Create(n3)
                                task.wait(0.5)
                                return
                              end
                            else
                              flag6 = CaculateDistance(n3) > 60

                              if flag6 then
                                if flag6 then
                                  TweenController.Create(n3)
                                  task.wait(0.5)
                                  return
                                end
                              else
                                flag6 = TweenController.Hovering

                                if flag6 then
                                  hoverCFrame = TweenController.HoverCFrame
                                  flag6 = not hoverCFrame

                                  if hoverCFrame then
                                    if CaculateDistance(TweenController.HoverCFrame, n3) > 8 then
                                      TweenController.Create(n3)
                                      task.wait(0.5)
                                      return
                                    end
                                  end
                                end
                              end
                            end
                          end
                        else
                          playing = TweenController.Playing

                          if playing then
                            flag6 = TweenController.Hovering

                            if flag6 then
                              hoverCFrame = TweenController.HoverCFrame
                              flag6 = not hoverCFrame

                              if hoverCFrame then
                                if CaculateDistance(TweenController.HoverCFrame, n3) > 8 then
                                  TweenController.Create(n3)
                                  task.wait(0.5)
                                  return
                                end
                              end
                            end
                          else
                            flag6 = CaculateDistance(n3) > 60
                            TweenController.Create(n3)
                          end
                        end
                      else
                        n3 = CombatController.GetStandbyFrame("Sky Bandit")
                        if n3 then
                          flag6 = not tweenTargetInstance

                          if tweenTargetInstance then
                            flag6 = (tweenTargetInstance.Position - n3.Position).Magnitude > 8
                          end

                          if TweenController.Playing then
                            if flag6 then
                              if flag6 then
                                TweenController.Create(n3)
                              end
                            end
                          else
                            playing = TweenController.Playing

                            if playing then
                              flag6 = TweenController.Hovering

                              if flag6 then
                                hoverCFrame = TweenController.HoverCFrame
                                flag6 = not hoverCFrame

                                if hoverCFrame then
                                  if CaculateDistance(TweenController.HoverCFrame, n3) > 8 then
                                    TweenController.Create(n3)
                                    task.wait(0.5)
                                    return
                                  end
                                end
                              end
                            else
                              flag6 = CaculateDistance(n3) > 60
                              TweenController.Create(n3)
                            end
                          end
                        end
                      end
                    else
                      n3 = CombatController.GetStandbyFrame("Sky Bandit")
                      TweenController.Create(n3)
                    end
                  end
                end

                task.wait(0.5)
                return
              end
            end)

            FunctionsHandler.LocalPlayerController:RegisterMethod("EquipTool", function(arg)
              if not LocalPlayer.Character then
                return
              end
              local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
              if not humanoid then
                return
              end

              local targetMelee = ((arg == "Melee") and (ScriptStorage.TargetMelee or arg)) or arg
              local character = LocalPlayer.Character
              local tool = character and character:FindFirstChildOfClass("Tool")

              if tool then
                if (arg == "Melee") and ScriptStorage.TargetMelee then
                  if (tool.Name == targetMelee) or (NormalizeMeleeName(tool.Name) == targetMelee) then
                    return
                  end
                elseif (tool.ToolTip == arg) or (tool.Name == tostring(arg)) or (NormalizeMeleeName(tool.Name) == tostring(arg)) then
                  return
                end
              end

              local backpack = LocalPlayer.Backpack
              if backpack then
                for _, v17 in ipairs(backpack:GetChildren()) do
                  if v17:IsA("Tool") and (v17.Name ~= "Tool") then
                    if (arg == "Melee") and ScriptStorage.TargetMelee then
                      if (v17.Name == targetMelee) or (NormalizeMeleeName(v17.Name) == targetMelee) then
                        humanoid:EquipTool(v17)
                        return
                      end
                    elseif (v17.Name == tostring(arg)) or (v17.ToolTip == arg) or (NormalizeMeleeName(v17.Name) == tostring(arg)) then
                      humanoid:EquipTool(v17)
                      return
                    end
                  end
                end
              end

              if (arg == "Melee") and ScriptStorage.TargetMelee and character then
                local targetMelee2 = ScriptStorage.TargetMelee
                if targetMelee2 ~= "Electro" then
                  local num = tonumber(ScriptStorage.Melees[targetMelee2]) or 0
                  if ScriptStorage.MeleesOwned[targetMelee2] or (num > 0) or IsMeleePurchaseComplete(targetMelee2) then
                    local v15 = MeleePrices[targetMelee2]
                    if v15 and v15.Buy then
                      pcall(v15.Buy)
                      task.wait(0.1)
                      pcall(v15.Buy)
                    else
                      local v16 = GetMeleeIdByName(targetMelee2)
                      if v16 then
                        pcall(function()
                          Remotes.CommF_:InvokeServer("Buy" .. v16)
                        end)
                        task.wait(0.1)
                        pcall(function()
                          Remotes.CommF_:InvokeServer("Buy" .. v16, true)
                        end)
                      end
                    end

                    task.wait(0.15)
                    backpack = LocalPlayer.Backpack
                    if backpack then
                      for _, v17 in ipairs(backpack:GetChildren()) do
                        if v17:IsA("Tool") then
                          if (v17.Name == targetMelee2) or (NormalizeMeleeName(v17.Name) == targetMelee2) then
                            humanoid:EquipTool(v17)
                            return
                          end
                        end
                      end
                    end
                  end
                end
              end
            end)

            FunctionsHandler.LocalPlayerController:RegisterMethod("ToggleAbilities", function(arg, arg2)
              if arg ~= "Buso" then
                return
              end

              if not LocalPlayer:HasTag("Buso") then
                if not arg2 then
                  return
                end
              end

              Remotes.CommF_:InvokeServer("Buso")
            end)

            FunctionsHandler.LocalPlayerController:RegisterMethod("ConfigurationAbilitiesToggle", function()
              FunctionsHandler.LocalPlayerController.Methods.ToggleAbilities:Call("Buso", SCRIPT_CONFIG.BUSO)
              FunctionsHandler.LocalPlayerController.Methods.ToggleAbilities:Call("Observation", SCRIPT_CONFIG.OBSERVATION)
            end)

            MeleeBuyRefreshCache = {CheckedAt = 0, Result = nil}
            MeleeBuyBusy = false
            MeleeBuyBusyAt = 0
            MeleeBuyRetryAfter = {}
            tbl7 = {}
            tbl8 = {}
            MeleeBuyPendingName = nil
            MeleeEquipBusyName = nil

            fn24 = function()
              local genv3

              if type(getgenv) ~= "function" then
                genv3 = _G
              else
                genv3 = getgenv() or _G
              end

              genv3.BananaCatMeleeBuyPending = genv3.BananaCatMeleeBuyPending or {}
              return genv3.BananaCatMeleeBuyPending
            end

            GetMeleeBuyPending = function()
              local v15 = fn24()
              local v16 = MeleeBuyPendingName
              if v16 then
                return v16
              end
              return v15.Name
            end

            fn25 = function(arg)
              local v15 = fn24()

              if arg then
                if v15.Name == arg then
                  v15.Name = nil
                end

                if MeleeBuyPendingName ~= arg then
                  return
                end
                MeleeBuyPendingName = nil
                return
              end

              v15.Name = nil
              MeleeBuyPendingName = nil
            end

            MeleeNPCMap = {["Black Leg"] = "Dark Step Teacher", Electro = "Mad Scientist", ["Fishman Karate"] = "Water Kung-fu Teacher", ["Dragon Claw"] = "Sabi", Superhuman = "Martial Arts Master", ["Death Step"] = "Phoeyu, the Reformed", ["Sharkman Karate"] = "Sharkman Teacher", ["Electric Claw"] = "Previous Hero", ["Dragon Talon"] = "Uzoth", Godhuman = "Ancient Monk"}
            MeleeNPCSeaMap = {["Black Leg"] = {1, 2, 3}, Electro = {1, 2, 3}, ["Fishman Karate"] = {1, 2, 3}, ["Dragon Claw"] = {2, 3}, Superhuman = {2, 3}, ["Death Step"] = {2, 3}, ["Sharkman Karate"] = {2, 3}, ["Electric Claw"] = 3, ["Dragon Talon"] = 3, Godhuman = 3}
            MeleeNPCCFrameFallbacks = {Electro = CFrame.new(-4607.82275, 872.542297, -1667.55688), ["Electric Claw"] = CFrame.new(-10371.6211, 331.301849, -10131.6211)}
            ElectricClawMansionCFrame = CFrame.new(-12547.71, 290.139008, -7487.06494)
            local tbl = {{"Black Leg", "Electro", "Fishman Karate"}, {"Black Leg", "Electro", "Fishman Karate", "Dragon Claw", "Superhuman", "Death Step", "Sharkman Karate"}, {"Black Leg", "Electro", "Fishman Karate", "Dragon Claw", "Superhuman", "Death Step", "Sharkman Karate", "Electric Claw", "Dragon Talon", "Godhuman"}}
            local tbl9 = {}

            local function fn34(arg)
              if not arg then
                return
              end

              local ok, result = pcall(function()
                if arg:IsA("Model") then
                  return arg:GetModelCFrame()
                end

                if arg:IsA("BasePart") then
                  return arg.CFrame
                end
                local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")

                if not humanoidRootPart then
                  humanoidRootPart = arg:FindFirstChildWhichIsA("BasePart", true)
                  if not humanoidRootPart then
                    return humanoidRootPart
                  end
                end

                return humanoidRootPart.CFrame
              end)

              if ok then
                return result
              end
            end

            fn26 = function()
              local ok, result = pcall(function()
                return Remotes.CommF_:InvokeServer("ElectroQuestState")
              end)

              if ok then
                return result
              end
              return nil
            end

            fn27 = function()
              local tbl10 = {}
              local tbl11 = {}

              local function fn35(arg, arg2)
                if arg then
                  if arg:IsA("BasePart") then
                    if arg.Parent then
                      if tbl11[arg] then
                        return
                      end
                      tbl11[arg] = true
                      table.insert(tbl10, {Part = arg, Priority = arg2 or 10})
                      return
                    end

                    return
                  end

                  return
                end
              end

              pcall(function()
                local bonusMoments = game:GetService("ReplicatedStorage"):FindFirstChild("BonusMoments")

                if bonusMoments then
                  local electricFightingTeacher = bonusMoments:FindFirstChild("Electric Fighting Teacher")

                  if electricFightingTeacher then
                    if getupvalues then
                      local module = require(electricFightingTeacher)

                      if module then
                        if module.RemoteEvents then
                          if module.RemoteEvents.Charge then
                            for _, v15 in pairs(getupvalues(module.RemoteEvents.Charge)) do
                              if type(v15) == "table" then
                                for k, v16 in pairs(v15) do
                                  if typeof(k) == "Instance" then
                                    if k:IsA("BasePart") then
                                      if k.Parent then
                                        if v16 == true then
                                          fn35(k, 1)
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end

                            return
                          end
                        end
                      end
                    end
                  end
                end
              end)

              local position

              if LocalPlayer.Character then
                local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                  position = humanoidRootPart.Position or Vector3.new(-4800, 950, -1800)
                else
                  position = Vector3.new(-4800, 950, -1800)
                end
              else
                position = Vector3.new(-4800, 950, -1800)
              end

              table.sort(tbl10, function(arg, arg2)
                if arg.Priority ~= arg2.Priority then
                  return arg.Priority < arg2.Priority
                end
                return (arg.Part.Position - position).Magnitude < (arg2.Part.Position - position).Magnitude
              end)

              local tbl12 = {}

              for _, v15 in ipairs(tbl10) do
                table.insert(tbl12, v15.Part)
              end

              return tbl12
            end

            local function fn35(arg)
              local v15 = MeleeNPCSeaMap[arg]

              if type(v15) ~= "table" then
                if v15 then
                  return {v15}
                end
                return {}
              end

              return v15
            end

            local function fn36(arg, arg2)
              for _, v15 in ipairs(fn35(arg)) do
                if v15 ~= arg2 then
                  continue
                end
                return true
              end

              return false
            end

            local function fn37(arg)
              if fn36(arg, SeaIndex) then
                return
              end

              for _, v15 in ipairs(fn35(arg)) do
                if v15 ~= SeaIndex then
                  return v15
                end
              end
            end

            local function fn38(arg, arg2, arg3)
              local v15 = fn34(arg2)
              if v15 then
                tbl9[arg] = {Instance = arg2, CFrame = v15, Sea = SeaIndex, Source = arg3, UpdatedAt = os.clock()}
                return v15, arg2
              end
            end

            local function fn39(arg, arg2)
              local v15 = tbl9[arg]

              if v15 then
                if typeof(v15) ~= "Instance" then
                  if type(v15) ~= "table" then
                    return
                  end

                  if v15.Instance then
                    local v16 = fn34(v15.Instance)

                    if v16 then
                      v15.CFrame = v16
                      v15.Sea = v15.Sea or SeaIndex
                      v15.UpdatedAt = os.clock()
                      return v16, v15.Instance
                    end
                  end

                  if v15.CFrame then
                    if not arg2 then
                      return v15.CFrame, v15.Instance
                    end

                    if v15.Sea == SeaIndex then
                      return v15.CFrame, v15.Instance
                    end
                  end

                  return
                end

                local v16 = fn34(v15)
                if v16 then
                  tbl9[arg] = {Instance = v15, CFrame = v16, Sea = SeaIndex, Source = "legacy", UpdatedAt = os.clock()}
                  return v16, v15
                end
                return
              end
            end

            local function fn40(arg, arg2)
              local v15 = MeleeNPCMap[arg]

              if v15 then
                local npCs = workspace:FindFirstChild("NPCs")
                local v16, v17 = fn38(arg, npCs and npCs:FindFirstChild(v15), "workspace")
                if v16 then
                  return v16, v17
                end

                if arg2 then
                  local npCs2 = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs")
                  local v18

                  if npCs2 then
                    v18 = npCs2:FindFirstChild(v15) or game:GetService("ReplicatedStorage"):FindFirstChild(v15)
                  else
                    v18 = game:GetService("ReplicatedStorage"):FindFirstChild(v15)
                  end

                  local v19, v20 = fn38(arg, v18, "replicated")
                  if v19 then
                    return v19, v20
                  end
                end

                return
              end
            end

            local function fn41(arg)
              if fn40(arg, fn36(arg, SeaIndex)) then
                return true
              end

              if fn39(arg, true) then
                return true
              end
              return false
            end

            fn28 = function(arg)
              local v15 = fn36(arg, SeaIndex)
              local v16, v17 = fn40(arg, v15)
              if v16 then
                return v16, v17
              end
              local v18, v19 = fn39(arg, true)
              if v18 then
                return v18, v19
              end

              if v15 then
                if arg == "Electro" then
                  if SeaIndex ~= 1 then
                    return
                  end
                end

                return MeleeNPCCFrameFallbacks[arg], v19
              end
            end

            fn29 = function()
              local worldOrigin = workspace:FindFirstChild("_WorldOrigin")

              if worldOrigin then
                worldOrigin = worldOrigin:FindFirstChild("Locations")
                worldOrigin = worldOrigin and worldOrigin:FindFirstChild("Mansion")
              end

              local v15 = fn34(worldOrigin)
              if v15 then
                return v15
              end
              local map = workspace:FindFirstChild("Map")

              if map then
                map = map:FindFirstChild("Turtle")

                if map then
                  map = map:FindFirstChild("IslandModel")
                  map = map and map:FindFirstChild("Mansion")
                end
              end

              local v16 = fn34(map)
              if v16 then
                return v16
              end
              return ElectricClawMansionCFrame
            end

            local function fn42()
              for k, v15 in pairs(MeleeNPCMap) do
                local npCs = workspace:FindFirstChild("NPCs") and workspace.NPCs:FindFirstChild(v15)
                local v16

                if game.ReplicatedStorage:FindFirstChild("NPCs") then
                  v16 = game.ReplicatedStorage.NPCs:FindFirstChild(v15) or game.ReplicatedStorage:FindFirstChild(v15)
                else
                  v16 = game.ReplicatedStorage:FindFirstChild(v15)
                end

                fn38(k, v16, "replicated")
                fn38(k, npCs, "workspace")
              end
            end

            local npCs = game.ReplicatedStorage:FindFirstChild("NPCs")
            local npCs2 = workspace:FindFirstChild("NPCs")

            if npCs then
              npCs.ChildAdded:Connect(function(child)
                for k, v15 in pairs(MeleeNPCMap) do
                  if child.Name == v15 then
                    fn38(k, child, "replicated")
                  end
                end
              end)

              if npCs2 then
                npCs2.ChildAdded:Connect(function(child)
                  for k, v15 in pairs(MeleeNPCMap) do
                    if child.Name == v15 then
                      fn38(k, child, "workspace")
                    end
                  end
                end)
              end
            elseif npCs2 then
              npCs2.ChildAdded:Connect(function(child)
                for k, v15 in pairs(MeleeNPCMap) do
                  if child.Name == v15 then
                    fn38(k, child, "workspace")
                  end
                end
              end)
            end

            fn42()

            local function fn43(arg)
              local flag5 = arg == "Death Step"
              local now4, v15

              if flag5 then
                if SeaIndex ~= 2 then
                  now4 = os.clock()
                  v15 = tbl8[arg]

                  if v15 then
                    if now4 < v15 then
                      return true
                    end
                  elseif now4 < 0 then
                    return true
                  end

                  tbl8[arg] = os.clock() + 10
                elseif fn41(arg) then
                  return false
                end
              else
                flag5 = arg == "Sharkman Karate"

                if flag5 then
                  if SeaIndex ~= 2 then
                    now4 = os.clock()
                    v15 = tbl8[arg]

                    if v15 then
                      if now4 < v15 then
                        return true
                      end
                    elseif now4 < 0 then
                      return true
                    end

                    tbl8[arg] = os.clock() + 10
                  elseif fn41(arg) then
                    return false
                  end
                elseif fn41(arg) then
                  return false
                end
              end

              local n3 = fn37(arg)
              local v16

              if flag5 then
                if SeaIndex ~= 2 then
                  n3 = 2

                  if n3 ~= SeaIndex then
                    v16 = SeaIndexes[n3]

                    if v16 then
                      SetTask("MainTask", "Sea Travel | Melee " .. (tostring(arg) .. (" | Travelling to Sea " .. n3)))
                      Remotes.CommF_:InvokeServer("Travel" .. v16)
                      return true
                    end

                    return false
                  end

                  return false
                end

                if n3 then
                  if n3 ~= SeaIndex then
                    v16 = SeaIndexes[n3]

                    if v16 then
                      SetTask("MainTask", "Sea Travel | Melee " .. (tostring(arg) .. (" | Travelling to Sea " .. n3)))
                      Remotes.CommF_:InvokeServer("Travel" .. v16)
                      return true
                    end

                    return false
                  end

                  return false
                end
              elseif n3 then
                if n3 ~= SeaIndex then
                  v16 = SeaIndexes[n3]

                  if v16 then
                    SetTask("MainTask", "Sea Travel | Melee " .. (tostring(arg) .. (" | Travelling to Sea " .. n3)))
                    Remotes.CommF_:InvokeServer("Travel" .. v16)
                    return true
                  end

                  return false
                end

                return false
              end

              return false
            end

            fn30 = function(arg)
              local n3 = tonumber(ScriptStorage.Melees[arg]) or 0
              local v15

              if NormalizeMeleeName then
                v15 = NormalizeMeleeName(arg) or arg
              else
                v15 = arg
              end

              local backpack = LocalPlayer:FindFirstChild("Backpack")
              local flag5 = ScriptStorage.MeleesOwned[arg]

              if not flag5 then
                flag5 = ScriptStorage.MeleesOwned[v15]

                if not flag5 then
                  flag5 = n3 > 0

                  if not flag5 then
                    flag5 = ScriptStorage.Tools[arg]

                    if not flag5 then
                      if backpack then
                        flag5 = backpack:FindFirstChild(arg)

                        if not flag5 then
                          flag5 = backpack:FindFirstChild(v15)

                          if not flag5 then
                            flag5 = LocalPlayer.Character

                            if flag5 then
                              flag5 = LocalPlayer.Character:FindFirstChild(arg)
                              if not flag5 then
                                local character = LocalPlayer.Character
                                return (character:FindFirstChild(v15))
                              end
                            end
                          end
                        end
                      else
                        flag5 = LocalPlayer.Character

                        if flag5 then
                          flag5 = LocalPlayer.Character:FindFirstChild(arg)
                          if not flag5 then
                            return (LocalPlayer.Character:FindFirstChild(v15))
                          end
                        end
                      end
                    end
                  end
                end
              end

              return flag5
            end

            local function fn44(arg)
              local v15 = MeleePrices[arg]

              if v15 then
                if v15.Price then
                  for k, v16 in pairs(v15.Price) do
                    local v17 = ScriptStorage.PlayerData[k]

                    if v17 then
                      if v17 < v16 then
                        return false
                      end
                      continue
                    end

                    if v16 > 0 then
                      return false
                    end
                  end

                  return true
                end

                return false
              end

              return false
            end

            local function fn45()
              local tbl10 = tbl[SeaIndex] or {}

              for _, v15 in ipairs(tbl10) do
                local v16 = MeleePrices[v15]
                local n3 = tonumber(ScriptStorage.Melees[v15]) or 0

                if fn30(v15) then
                  if v16 then
                    if n3 < v16.NextLevelRequirement then
                      return v15, "Mastery", n3, v16
                    end
                    continue
                  end

                  continue
                end

                return v15, "Buy", n3, v16
              end

              return nil, "Complete"
            end

            fn31 = function()
              local v15, v16 = fn45()

              if v16 == "Buy" then
                if v15 then
                  return v15
                end
              end

              return nil
            end

            local function fn46()
              for k, v15 in pairs(GodhumanMaterials) do
                if (ScriptStorage.Backpack[k] or {Count = 0}).Count < v15[1] then
                  return false
                end
              end

              return true
            end

            local function fn47(arg)
              local v15 = MeleePrices[arg]

              if v15 then
                if fn44(arg) then
                  if MeleeBuyRetryAfter[arg] then
                    local v16 = MeleeBuyRetryAfter[arg]
                    if os.clock() < v16 then
                      return false
                    end
                  end

                  if arg == "Dragon Talon" then
                    if not ScriptStorage.Tools["Fire Essence"] then
                      if not IsFireEssenceGave then
                        return false
                      end
                    end
                  end

                  if arg == "Godhuman" then
                    if GodHumanFlag then
                      if not fn46() then
                        return false
                      end
                    end
                  end

                  local flag5 = arg == "Electro"

                  if not flag5 then
                    local requirements = v15.Requirements
                    flag5 = not requirements
                    if requirements then
                      return (v15.Requirements())
                    end
                  end

                  return flag5
                end

                return false
              end

              return false
            end

            local function fn48(arg)
              ScriptStorage.MeleesOwned[arg] = true
              ScriptStorage.Melees[arg] = tonumber(ScriptStorage.Melees[arg]) or 0
              fn25(arg)
              if arg ~= "Dragon Talon" then
                return
              end
              IsFireEssenceGave = true
            end

            local tbl10 = {["Death Step"] = true, ["Sharkman Karate"] = true, ["Electric Claw"] = true, ["Dragon Talon"] = true, Godhuman = true}

            local function fn49(arg)
              if arg == "Electro" then
                if not HasLightningBolt(true) then
                  if not fn30("Electro") then
                    return true
                  end
                end
              end

              return tbl10[arg] == true
            end

            local function fn50(name2)
              if name2 then
                if fn30(name2) then
                  return
                end
                MeleeBuyPendingName = name2
                local v15 = fn24()
                v15.Name = name2
                v15.At = os.clock()
                MeleeBuyRefreshCache.CheckedAt = 0
                MeleeBuyRefreshCache.Result = name2
                return
              end
            end

            local function fn51(arg)
              if fn49(arg) then
                if arg ~= "Electro" then
                  if arg ~= "Sharkman Karate" then
                    if arg ~= "Death Step" then
                      if arg ~= "Electric Claw" then
                        if arg ~= "Dragon Talon" then
                          if arg ~= "Godhuman" then
                            return false
                          end

                          if fn46() then
                            return false
                          end
                          GodHumanFlag = true
                          SetTask("MainTask", "Godhuman - Checking materials")
                          return true
                        end

                        if SeaIndex ~= 3 then
                          return false
                        end

                        if ScriptStorage.Tools["Fire Essence"] then
                          if not IsFireEssenceGave then
                            FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Uzoth Essence")
                            SetTask("MainTask", "Dragon Talon - Giving Fire Essence to Uzoth")
                            if FunctionsHandler.UtillyItemsActivitation.Methods.Start then
                              FunctionsHandler.UtillyItemsActivitation.Methods.Start:Call()
                              return true
                            end
                            return true
                          end
                        end

                        return false
                      end

                      if SeaIndex ~= 3 then
                        return false
                      end

                      local ok, result = pcall(function()
                        return Remotes.CommF_:InvokeServer("BuyElectricClaw", true)
                      end)

                      if ok then
                        if result ~= 4 then
                          if result ~= nil then
                            return false
                          end
                        end
                      end

                      FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Previous Hero")
                      SetTask("MainTask", "Electric Claw - Queued Previous Hero")
                      if FunctionsHandler.UtillyItemsActivitation.Methods.Start then
                        FunctionsHandler.UtillyItemsActivitation.Methods.Start:Call()
                        return true
                      end
                      return true
                    end
                  end

                  if SeaIndex ~= 2 then
                    return false
                  end
                  local str4 = ((arg ~= "Sharkman Karate") and "Library Key") or "Water Key"
                  local now4 = os.clock()
                  local v15 = tbl7[arg]

                  if v15 then
                    if now4 < v15 then
                      return true
                    end
                  elseif now4 < 0 then
                    return true
                  end

                  local ok, result = pcall(function()
                    if arg ~= "Sharkman Karate" then
                      return Remotes.CommF_:InvokeServer("OpenLibrary")
                    end
                    return Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
                  end)

                  if ok then
                    if arg ~= "Sharkman Karate" then
                      if result == true then
                        return false
                      end

                      if result then
                        SetTask("SideTask", "Melee | Waiting for " .. (str4 .. " status"))
                        tbl7[arg] = os.clock() + 2
                        return true
                      end
                    elseif typeof(result) ~= "string" then
                      return false
                    end

                    if ScriptStorage.Tools[str4] then
                      FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", str4)

                      if FunctionsHandler.UtillyItemsActivitation.Methods.Start then
                        FunctionsHandler.UtillyItemsActivitation.Methods.Start:Call()
                      end

                      tbl7[arg] = os.clock() + 1
                      return true
                    end

                    local str5 = ((arg ~= "Sharkman Karate") and "Awakened Ice Admiral") or "Tide Keeper"
                    local v16 = ScriptStorage.Enemies[str5]

                    if v16 then
                      local humanoid = v16:FindFirstChild("Humanoid")

                      if humanoid then
                        if humanoid.Health > 0 then
                          SetTask("SideTask", "Melee | Waiting for " .. (str4 .. (" from " .. str5)))
                          FunctionsHandler.BossesTask.Methods.Start:Call(v16)
                          tbl7[arg] = os.clock() + 1
                          return true
                        end
                      end
                    end

                    SetTask("MainTask", "Melee | Hopping for " .. (str5 .. (" to get " .. str4)))
                    tbl7[arg] = os.clock() + 5
                    Hop(8)
                    return true
                  end

                  SetTask("SideTask", "Melee | Checking " .. (str4 .. (" for " .. arg)))
                  tbl7[arg] = os.clock() + 2
                  return true
                end

                if not HasLightningBolt(true) then
                  if not fn30("Electro") then
                    if SeaIndex ~= 1 then
                      SetTask("MainTask", "Sea Travel | Electro Quest | Travelling to Sea 1")
                      Remotes.CommF_:InvokeServer("TravelMain")
                      return true
                    end

                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Mad Scientist Task")
                    SetTask("MainTask", "Electro - Queued Mad Scientist Task")
                    if FunctionsHandler.UtillyItemsActivitation.Methods.Start then
                      FunctionsHandler.UtillyItemsActivitation.Methods.Start:Call()
                      return true
                    end
                    return true
                  end
                end

                return false
              end

              return false
            end

            local function fn52()
              local v15 = fn31()
              DragonTalonNeedsFireEssence = (v15 == "Dragon Talon") and not IsFireEssenceGave

              if fn47(v15) then
                if v15 then
                  return v15
                end
              end

              return nil
            end

            ShouldPreemptForMeleeBuy = function()
              if FunctionsHandler.RaidController then
                if FunctionsHandler.RaidController.Initalized then
                  if FunctionsHandler.RaidController.Methods.IsLocked then
                    if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                      return false
                    end
                  end
                end
              end

              if MeleeEquipBusyName then
                return true
              end
              local v15 = fn52()

              if v15 then
                if GetMeleeBuyPending() ~= v15 then
                  fn25()
                  fn50(v15)
                  return true
                end

                return true
              end

              fn25()
              return false
            end

            local function fn53(arg)
              local v15 = MeleePrices[arg]

              if v15 then
                if v15.Buy then
                  if fn30(arg) then
                    return fn30(arg)
                  end
                  local ok, result

                  if arg ~= "Electro" then
                    if arg ~= "Godhuman" then
                      ok, result = pcall(v15.Buy)
                      task.wait(0.4)

                      if arg == "Electro" then
                        getBypassSpawn()
                        pcall(RefreshInventory)
                      end

                      SyncLiveMeleeTools()
                      if fn30(arg) then
                        fn48(arg)
                        return true, result
                      end

                      if arg == "Electro" then
                        if ok then
                          if result == 1 then
                            fn48(arg)
                            return true, result
                          end
                        end
                      end

                      return false, result
                    end

                    pcall(v15.Buy, true)
                    ok, result = pcall(v15.Buy)
                    task.wait(0.4)

                    if arg == "Electro" then
                      getBypassSpawn()
                      pcall(RefreshInventory)
                    end

                    SyncLiveMeleeTools()
                    if fn30(arg) then
                      fn48(arg)
                      return true, result
                    end

                    if arg == "Electro" then
                      if ok then
                        if result == 1 then
                          fn48(arg)
                          return true, result
                        end
                      end
                    end

                    return false, result
                  end

                  local v16 = fn26()

                  if v16 ~= 4 then
                    if v16 == 5 then
                      fn48(arg)
                      return true, v16
                    end

                    if v16 ~= 3 then
                      if v16 ~= 2 then
                        return false, v16
                      end
                      ok, result = pcall(v15.Buy)
                      task.wait(0.4)

                      if arg == "Electro" then
                        getBypassSpawn()
                        pcall(RefreshInventory)
                      end

                      SyncLiveMeleeTools()
                      if fn30(arg) then
                        fn48(arg)
                        return true, result
                      end

                      if arg == "Electro" then
                        if ok then
                          if result == 1 then
                            fn48(arg)
                            return true, result
                          end
                        end
                      end

                      return false, result
                    end

                    SetTask("MainTask", "Electro | Delivering Lightning Bolt")

                    local ok2, result2 = pcall(function()
                      return Remotes.CommF_:InvokeServer("DeliverLightningBolt")
                    end)

                    if ok2 then
                      if result2 ~= 1 then
                        if fn26() ~= 2 then
                          return false, result2
                        end
                      end
                    elseif fn26() ~= 2 then
                      return false, result2
                    end

                    ok, result = pcall(v15.Buy)
                    task.wait(0.4)

                    if arg == "Electro" then
                      getBypassSpawn()
                      pcall(RefreshInventory)
                    end

                    SyncLiveMeleeTools()
                    if fn30(arg) then
                      fn48(arg)
                      return true, result
                    end

                    if arg == "Electro" then
                      if ok then
                        if result == 1 then
                          fn48(arg)
                          return true, result
                        end
                      end
                    end

                    return false, result
                  end

                  fn48(arg)
                  return true, v16
                end

                return fn30(arg)
              end

              return fn30(arg)
            end

            FunctionsHandler.MeleeBuyController:RegisterMethod("Refresh", function()
              if CurrentTask ~= "BossesTask" then
                if CurrentTask ~= "SpecialBossesTask" then
                  if FunctionsHandler.RaidController then
                    if FunctionsHandler.RaidController.Initalized then
                      if FunctionsHandler.RaidController.Methods.IsLocked then
                        if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                          return
                        end
                      end
                    end
                  end

                  SyncLiveMeleeTools()
                  local v15 = GetMeleeBuyPending()

                  if v15 then
                    if fn30(v15) then
                      fn25(v15)
                      v15 = nil
                    end
                  end

                  if MeleeBuyBusy then
                    return v15
                  end
                  local v16 = fn52()

                  if v15 then
                    if v15 ~= v16 then
                      fn25(v15)

                      if v16 then
                        fn50(v16)
                        MeleeBuyRefreshCache.Result = v16
                        return v16
                      end
                    elseif v16 then
                      fn50(v16)
                      MeleeBuyRefreshCache.Result = v16
                      return v16
                    end
                  elseif v16 then
                    fn50(v16)
                    MeleeBuyRefreshCache.Result = v16
                    return v16
                  end

                  return
                end

                return
              end
            end)

            local n3 = 0

            FunctionsHandler.CannonBuyController:RegisterMethod("Refresh", function()
              if SeaIndex ~= 2 then
                return
              end

              if CurrentTask ~= "BossesTask" then
                if CurrentTask ~= "SpecialBossesTask" then
                  local num = tonumber(ScriptStorage.PlayerData.Level)

                  if num then
                    if num < 800 then
                      return
                    end
                    local num2 = tonumber(ScriptStorage.PlayerData.Beli)

                    if num2 then
                      if num2 < 100000 then
                        return
                      end

                      if ScriptStorage.Backpack.Cannon then
                        return
                      end

                      if ScriptStorage.Tools.Cannon then
                        return
                      end

                      if os.clock() < n3 then
                        return
                      end
                      return "Cannon"
                    end

                    return
                  end

                  return
                end

                return
              end
            end)

            FunctionsHandler.CannonBuyController:RegisterMethod("Start", function(arg)
              if arg ~= "Cannon" then
                return
              end

              if SeaIndex ~= 2 then
                return
              end
              local num = tonumber(ScriptStorage.PlayerData.Level)

              if num then
                if num < 800 then
                  return
                end
                local num2 = tonumber(ScriptStorage.PlayerData.Beli)

                if num2 then
                  if num2 < 100000 then
                    return
                  end

                  if ScriptStorage.Backpack.Cannon then
                    return
                  end

                  if ScriptStorage.Tools.Cannon then
                    return
                  end
                  n3 = os.clock() + 60
                  SetTask("MainTask", "Auto Weapon Buy | Cannon")

                  pcall(function()
                    Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
                  end)

                  task.wait(0.4)
                  pcall(RefreshInventory)
                  if ScriptStorage.Backpack.Cannon then
                    SetTask("MainTask", "Auto Weapon Buy | Cannon | Done")
                    return
                  end

                  if ScriptStorage.Tools.Cannon then
                    SetTask("MainTask", "Auto Weapon Buy | Cannon | Done")
                    return
                  end
                  SetTask("SideTask", "Cannon | Buy not confirmed; retrying later")
                  return
                end

                return
              end
            end)

            FunctionsHandler.MeleeBuyController:RegisterMethod("Start", function(arg)
              local str4, n4, v15, v16, now4, n5, fn54, v17, v18, n6, now5, v19, v20, v22, flag5, v23, v24, v25
              str4 = arg

              if CurrentTask ~= "BossesTask" then
                if CurrentTask ~= "SpecialBossesTask" then
                  if not str4 or ((str4 ~= fn31()) or not fn47(str4)) then
                    fn25()
                  else
                    fn50(str4)

                    if FunctionsHandler.RaidController then
                      if FunctionsHandler.RaidController.Initalized then
                        if FunctionsHandler.RaidController.Methods.IsLocked then
                          if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                            SetTask("SideTask", "Melee | Waiting raid before buy " .. tostring(str4))
                            return
                          end
                        end
                      end
                    end

                    if MeleeBuyBusy then
                      now4 = os.clock()
                      n5 = MeleeBuyBusyAt

                      if not n5 then
                        n5 = 0
                      end

                      if (now4 - n5) < 20 then
                        v23 = SetTask
                        v24 = tostring
                        v25 = GetMeleeBuyPending()

                        if not v25 then
                          v25 = str4
                        end

                        v23("MainTask", "Auto Melee Buy | Waiting for " .. v24(v25))
                        return
                      end
                    end

                    MeleeBuyBusy = true
                    MeleeBuyBusyAt = os.clock()

                    fn54 = function()
                      MeleeBuyBusy = false
                      MeleeBuyRefreshCache.CheckedAt = 0
                      MeleeBuyRefreshCache.Result = GetMeleeBuyPending()
                      RefreshMelees()
                    end

                    SyncLiveMeleeTools()

                    if fn30(str4) then
                      fn48(str4)
                    else
                      if str4 == "Electro" then
                        v17 = fn26()

                        if not ((v17 ~= 4) and (v17 ~= 5)) then
                          fn48(str4)
                          fn54()
                          return
                        end
                      end

                      if not fn43(str4) then
                        if not fn51(str4) then
                          if MeleeNPCMap[str4] then
                            v18 = fn28(str4)

                            if not v18 then
                              fn42()
                              v18 = fn28(str4)

                              if not v18 then
                                local str5 = "MeleeBuy: NPC '" .. (tostring(MeleeNPCMap[str4]) .. ("' for " .. (tostring(str4) .. " not found (workspace.NPCs nor ReplicatedStorage.NPCs)")))
                                Report(str5)
                                SetTask("SideTask", str5)

                                if str4 == "Electro" then
                                  MeleeBuyRetryAfter[str4] = os.clock() + 5
                                end

                                fn54()
                                return
                              end
                            end

                            SetTask("MainTask", "Auto Melee Buy | " .. (str4 .. (" | Travelling to " .. MeleeNPCMap[str4])))

                            if str4 ~= "Electro" then
                              n6 = 55
                            else
                              n6 = 8
                            end

                            TweenController.Create(v18 + Vector3.new(0, 5, 3))
                            now5 = os.clock()

                            while (n6 < CaculateDistance(v18)) and ((os.clock() - now5) < 25) do
                              if FunctionsHandler.RaidController then
                                if FunctionsHandler.RaidController.Methods.IsLocked then
                                  if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                                    fn54()
                                    return
                                  end
                                end
                              end

                              if not TweenController.Playing then
                                if n6 < CaculateDistance(v18) then
                                  TweenController.Create(v18 + Vector3.new(0, 5, 3))
                                end
                              end

                              task.wait(0.1)
                            end

                            v19 = CaculateDistance(v18)

                            if str4 ~= "Electro" then
                              if v19 > 60 then
                                fn54()
                                return
                              end
                            elseif v19 > 8 then
                              fn54()
                              return
                            end

                            SetTask("MainTask", "Auto Melee Buy | " .. (str4 .. " | Firing Buy"))
                            local v26
                            v26, v20 = fn53(str4)

                            if v26 then
                              SetTask("MainTask", "Auto Melee Buy | " .. (str4 .. " | Done"))

                              pcall(function()
                                FunctionsHandler.MeleesController.Methods.Start:Call()
                              end)
                            else
                              warn("failed", str4, "response=", v20)
                              getBypassSpawn()
                              pcall(RefreshInventory)
                              v22 = fn26()
                              canUseBypass = os.clock()
                              flag5 = v22 == 2

                              if not flag5 then
                                flag5 = v22 == 3

                                if not flag5 then
                                  flag5 = v22 == 4
                                end
                              end

                              checkBypassCond = flag5

                              if (v22 ~= 4) and (v22 ~= 5) then
                                if checkBypassCond or HasLightningBolt(false) then
                                  SetTask("SideTask", "Electro | Buy rejected; cooldown before retry")
                                  MeleeBuyRetryAfter[str4] = os.clock() + 60
                                else
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Mad Scientist Task")
                                  SetTask("SideTask", "Electro | Buy rejected; returning to Lightning Bolt quest")
                                  MeleeBuyRetryAfter[str4] = os.clock() + 3
                                end
                              else
                                fn48(str4)
                              end

                              fn25(str4)
                            end
                          else
                            local str5 = "MeleeBuy: no NPC map for " .. tostring(str4)
                            Report(str5)
                            SetTask("SideTask", str5)
                          end
                        end
                      end
                    end

                    fn54()
                  end

                  return
                end
              end

              v15 = SetTask
              v16 = tostring

              if not str4 then
                str4 = ""
              end

              v15("SideTask", "Melee | Waiting for boss before buying " .. v16(str4))
              return
            end)

            FunctionsHandler.MeleesController:RegisterMethod("Start", function()
              if FunctionsHandler.RaidController then
                if FunctionsHandler.RaidController.Initalized then
                  if FunctionsHandler.RaidController.Methods.IsLocked then
                    if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                      return
                    end
                  end
                end
              end

              SyncLiveMeleeTools()

              if ScriptStorage.MeleesLiveScanDone then
                local function fn54()
                  local character = LocalPlayer.Character
                  local tool

                  if character then
                    tool = character:FindFirstChildOfClass("Tool")

                    if tool then
                      if tool.ToolTip == "Melee" then
                        return tool, NormalizeMeleeName(tool.Name)
                      end
                    end
                  end
                end

                local function fn55(arg, arg2)
                  local v15, v16, v17, v18, num, v19, now4, v20, now5, v22, v23, now6, character
                  v15 = arg
                  v16 = arg2
                  local v24
                  v17, v24 = fn54()

                  if v24 ~= v15 then
                    if not ((CurrentTask ~= "BossesTask") and (CurrentTask ~= "SpecialBossesTask")) then
                      if not MeleeEquipBusyName then
                        SetTask("SideTask", "Melee | Waiting for boss before loading " .. v15)
                        return false, v17
                      end
                    end

                    MeleeEquipBusyName = v15
                    FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call(v15)
                    task.wait(0.15)
                    local v25
                    v18, v25 = fn54()

                    if v25 ~= v15 then
                      if not ScriptStorage.MeleesOwned[v15] then
                        num = tonumber(ScriptStorage.Melees[v15])

                        if not (num and (num > 0)) then
                          if not fn30(v15) then
                            MeleeEquipBusyName = nil
                            return false, v18
                          end
                        end
                      end

                      if v15 ~= "Electro" then
                        if v16 and v16.Buy then
                          pcall(v16.Buy)
                          task.wait(0.1)
                          pcall(v16.Buy)
                        else
                          v19 = GetMeleeIdByName(v15)

                          if v19 then
                            pcall(function()
                              Remotes.CommF_:InvokeServer("Buy" .. v19)
                            end)

                            task.wait(0.1)

                            pcall(function()
                              Remotes.CommF_:InvokeServer("Buy" .. v19, true)
                            end)
                          end
                        end
                      end

                      now4 = os.clock()

                      while true do
                        if (os.clock() - now4) >= 2 then
                          v20 = fn28(v15)

                          if v20 then
                            SetTask("MainTask", "Melee | Loading " .. (v15 .. (" from " .. tostring(MeleeNPCMap[v15]))))
                            TweenController.Create(v20 + Vector3.new(0, 5, 3))
                            now5 = os.clock()

                            while true do
                              v22 = CaculateDistance(v20)

                              if (((v15 == "Electro") and (v22 > 8)) or ((v15 ~= "Electro") and (v22 > 55))) and ((os.clock() - now5) < 25) then
                                character = LocalPlayer.Character

                                if character then
                                  character = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                end

                                if not character or (character.Health <= 0) then
                                  MeleeEquipBusyName = nil
                                  TweenController.ClearGhost()
                                  return false
                                end

                                if not TweenController.Playing then
                                  TweenController.Create(v20 + Vector3.new(0, 5, 3))
                                end

                                task.wait(0.1)
                                continue
                              else
                                break
                              end
                            end

                            v23 = CaculateDistance(v20)

                            if ((v15 ~= "Electro") and (v23 <= 60)) or ((v15 == "Electro") and (v23 <= 8)) then
                              pcall(v16.Buy)
                              now6 = os.clock()

                              while (os.clock() - now6) < 3 do
                                FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call(v15)
                                task.wait(0.1)
                                local v26
                                v18, v26 = fn54()

                                if v26 == v15 then
                                  MeleeEquipBusyName = nil
                                  MeleeCheck(v18)
                                  return true, v18
                                end
                              end
                            end
                          end

                          MeleeEquipBusyName = nil
                          return false, v18
                        end

                        SyncLiveMeleeTools()
                        FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call(v15)
                        task.wait(0.1)
                        local v26
                        v18, v26 = fn54()

                        if v26 == v15 then
                          MeleeEquipBusyName = nil
                          MeleeCheck(v18)
                          return true, v18
                        end
                      end
                    else
                      MeleeEquipBusyName = nil
                      MeleeCheck(v18)
                      return true, v18
                    end
                  else
                    return true, v17
                  end
                end

                local v15, v16, value, v17 = fn45()

                if v16 ~= "Buy" then
                  if v16 ~= "Mastery" then
                    ScriptStorage.TargetMelee = nil
                    local forceToUseSword = nil

                    for _, v18 in pairs(ScriptStorage.Backpack) do
                      if v18.Type ~= "Sword" then
                        forceToUseSword = nil
                      else
                        if v18.Name == "Yama" then
                          MasteryRequirement = 350
                        elseif v18.Name == "Tushita" then
                          MasteryRequirement = 350
                        else
                          MasteryRequirement = 0
                          if type(v18.Skill) == "table" then
                            for _, v19 in pairs(v18.Skill) do
                              MasteryRequirement = math.max(MasteryRequirement, tonumber(v19) or 0)
                            end
                          end
                        end

                        if v18.Mastery < MasteryRequirement then
                          if v18.Name ~= "Yama" then
                            if v18.Name ~= "Tushita" then
                              forceToUseSword = nil
                            else
                              forceToUseSword = {v18.Name, v18.Mastery, MasteryRequirement}
                              break
                            end
                          else
                            forceToUseSword = {v18.Name, v18.Mastery, MasteryRequirement}
                            break
                          end
                        else
                          forceToUseSword = nil
                        end
                      end
                    end

                    ScriptStorage.ForceToUseSword = forceToUseSword

                    if forceToUseSword then
                      SetTask("SideTask", "Farming mastery for " .. (forceToUseSword[1] .. (" ( " .. (forceToUseSword[2] .. (" / " .. (forceToUseSword[3] .. " )"))))))
                      if not ScriptStorage.Tools[forceToUseSword[1]] then
                        Remotes.CommF_:InvokeServer("LoadItem", forceToUseSword[1])
                        return
                      end
                    end

                    return
                  end

                  ScriptStorage.TargetMelee = v15
                  ScriptStorage.ForceToUseSword = nil
                  local v18, v19 = fn55(v15, v17)

                  if v18 then
                    if v19 then
                      if v19:FindFirstChild("Level") then
                        value = v19.Level.Value
                        ScriptStorage.Melees[v15] = value
                      end
                    end

                    SetTask("SideTask", "Farming Until Enough Mastery For " .. (v15 .. (" ( " .. (value .. (" / " .. (v17.NextLevelRequirement .. " )."))))))
                    return
                  end

                  if CurrentTask ~= "BossesTask" then
                    if CurrentTask ~= "SpecialBossesTask" then
                      SetTask("SideTask", "Switching melee to " .. (v15 .. " for mastery."))
                      return
                    end
                    SetTask("SideTask", "Melee | Waiting for boss before loading " .. v15)
                    return
                  end

                  SetTask("SideTask", "Melee | Waiting for boss before loading " .. v15)
                  return
                end

                ScriptStorage.TargetMelee = nil
                ScriptStorage.ForceToUseSword = nil
                local str4 = nil
                local exitTo = nil

                for k, v18 in pairs(v17.Price) do
                  local v19 = ScriptStorage.PlayerData[k]
                  if (not v19 and v18 > 0) or (v19 and v19 < v18) then
                    str4 = k .. " ( " .. tostring(v19 or 0) .. " / " .. v18 .. " )"
                    break
                  end
                end

                local v18 = SetTask
                local str5

                if str4 then
                  str5 = ("Farming Until Enough " .. (str4 .. (" For " .. v15))) or ("Melee | Waiting requirements for " .. v15)
                else
                  str5 = "Melee | Waiting requirements for " .. v15
                  v18("SideTask", str5)
                  return
                end

                v18("SideTask", str5)
                return
              end

              SetTask("SideTask", "Melee | Waiting for live tool data")
            end)
          end

          FunctionsHandler.SecondSeaPuzzle:RegisterMethod("Refresh", function()
            if ScriptStorage.PlayerData.Level < 700 then
              return
            end

            if SeaIndex ~= 1 then
              return
            end

            if FunctionsHandler.SecondSeaPuzzle:Get("IsCompleted") then
              return
            end
            local response = Remotes.CommF_:InvokeServer("DressrosaQuestProgress")

            if response.TalkedDetective then
              if response.KilledIceBoss then
                FunctionsHandler.SecondSeaPuzzle:Set("IsCompleted", true)
              else
                Result = 2
              end
            else
              Result = 1
            end

            FunctionsHandler.SecondSeaPuzzle:Set("CurrentProgressLevel", Result)
            FunctionsHandler.SecondSeaPuzzle:Set("LastestRefreshSenque", os.time())
            return Result
          end)

          FunctionsHandler.SecondSeaPuzzle:RegisterMethod("Start", function()
            local CurrentProgressLevel = FunctionsHandler.SecondSeaPuzzle:Get("CurrentProgressLevel")
            FunctionsHandler.SecondSeaPuzzle:Get("LastestRefreshSenque")
            FunctionsHandler.SecondSeaPuzzle:Set("CurrentProgressLevel", nil)

            if CurrentProgressLevel then
              if CurrentProgressLevel ~= 1 then
                if CurrentProgressLevel ~= 2 then
                  return
                end
                Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                task.wait(1)
                Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "UseKey")
                SetTask("MainTask", "Auto Second Sea - Defeating Ice Admiral")
                CombatController.Attack("Ice Admiral")
                Remotes.CommF_:InvokeServer("TravelDressrosa")
                return
              end

              SetTask("MainTask", "Auto Second Sea - Talk To Detective")
              Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
              Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
              task.wait(1)
              Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "UseKey")
              return
            end

            FunctionsHandler.SecondSeaPuzzle.Methods.Refresh:Call()
            return FunctionsHandler.SecondSeaPuzzle.Methods.Start:Call()
          end)

          FunctionsHandler.ColosseumPuzzle:RegisterMethod("Refresh", function()
            if SeaIndex ~= 2 then
              return
            end
            local warriorHelmet

            if LocalPlayer then
              if LocalPlayer:FindFirstChild("Backpack") then
                warriorHelmet = LocalPlayer.Backpack:FindFirstChild("Warrior Helmet")

                if not warriorHelmet then
                  if LocalPlayer then
                    if LocalPlayer.Character then
                      warriorHelmet = LocalPlayer.Character:FindFirstChild("Warrior Helmet") or (ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"])
                    else
                      warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
                    end
                  else
                    warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
                  end
                end
              elseif LocalPlayer then
                if LocalPlayer.Character then
                  warriorHelmet = LocalPlayer.Character:FindFirstChild("Warrior Helmet") or (ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"])
                else
                  warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
                end
              else
                warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
              end
            elseif LocalPlayer then
              if LocalPlayer.Character then
                warriorHelmet = LocalPlayer.Character:FindFirstChild("Warrior Helmet") or (ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"])
              else
                warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
              end
            else
              warriorHelmet = ScriptStorage.Backpack and ScriptStorage.Backpack["Warrior Helmet"]
            end

            if ScriptStorage.PlayerData.Level >= 850 then
              if not warriorHelmet then
                local response = Remotes.CommF_:InvokeServer("BartiloQuestProgress")

                if response then
                  if response.DidPlates then
                    if response.KilledBandits then
                      if response.KilledSpring then
                        FunctionsHandler.ColosseumPuzzle:Set("CurrentProgressLevel", nil)
                        return
                      end
                    end
                  end

                  local n3

                  if response.KilledBandits then
                    if response.KilledSpring then
                      n3 = nil

                      if not response.DidPlates then
                        n3 = 3
                      end
                    else
                      n3 = nil

                      if ScriptStorage.Enemies.Jeremy then
                        n3 = 2
                      end
                    end
                  else
                    n3 = 1
                  end

                  FunctionsHandler.ColosseumPuzzle:Set("CurrentProgressLevel", n3)
                  FunctionsHandler.ColosseumPuzzle:Set("LastestRefreshSenque", os.time())
                  return n3
                end

                FunctionsHandler.ColosseumPuzzle:Set("CurrentProgressLevel", nil)
                return
              end
            end

            FunctionsHandler.ColosseumPuzzle:Set("CurrentProgressLevel", nil)
          end)

          FunctionsHandler.ColosseumPuzzle:RegisterMethod("Start", function()
            local CurrentProgressLevel = FunctionsHandler.ColosseumPuzzle:Get("CurrentProgressLevel")
            FunctionsHandler.ColosseumPuzzle:Get("LastestRefreshSenque")
            FunctionsHandler.ColosseumPuzzle:Set("CurrentProgressLevel", nil)

            if CurrentProgressLevel then
              if CurrentProgressLevel ~= 1 then
                if CurrentProgressLevel ~= 2 then
                  if CurrentProgressLevel ~= 3 then
                    return
                  end
                  SetTask("MainTask", "Auto Bartilo Quest - Doing Puzzle")

                  if CaculateDistance(CFrame.new(-1837.46155, 44.2921753, 1656.1987, 0.999881566, -0, -0.0153914848, 0, 1, 0, 0.0153914848, -0, 0.999881566)) > 10 then
                    TweenController.Create(CFrame.new(-1837.46155, 44.2921753, 1656.1987, 0.999881566, -0, -0.0153914848, 0, 1, 0, 0.0153914848, -0, 0.999881566))
                  else
                    LocalPlayer = game.Players.LocalPlayer
                    local character = LocalPlayer.Character
                    TweenController.ClearGhost()

                    pcall(function()
                      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                      local humanoidRootPart = character

                      if character then
                        humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                        if humanoid then
                          humanoid.Sit = false
                          humanoid.PlatformStand = false

                          if humanoidRootPart then
                            humanoidRootPart.Anchored = false
                            humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                          end
                        elseif humanoidRootPart then
                          humanoidRootPart.Anchored = false
                          humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                          humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                          pcall(function()
                            setscriptable(LocalPlayer, "SimulationRadius", true)
                            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                          end)
                          return
                        end
                      elseif humanoid then
                        humanoid.Sit = false
                        humanoid.PlatformStand = false

                        if humanoidRootPart then
                          humanoidRootPart.Anchored = false
                          humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                          humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                          pcall(function()
                            setscriptable(LocalPlayer, "SimulationRadius", true)
                            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                          end)
                          return
                        end
                      elseif humanoidRootPart then
                        humanoidRootPart.Anchored = false
                        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        pcall(function()
                          setscriptable(LocalPlayer, "SimulationRadius", true)
                          sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                        end)
                        return
                      end

                      pcall(function()
                        setscriptable(LocalPlayer, "SimulationRadius", true)
                        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                      end)
                    end)

                    task.wait(0.05)
                    character = LocalPlayer.Character

                    if character then
                      if character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
                        task.wait(0.5)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
                        task.wait(1)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
                        return
                      end
                    end

                    return
                  end

                  return
                end

                SetTask("MainTask", "Auto Bartilo Quest - Defeating Jeremy")
                CombatController.Attack("Jeremy")
                return
              end

              SetTask("MainTask", "Auto Bartilo Quest - Defeating 50x Swan Pirate")
              local currentClaimQuest, v15 = QuestController:GetCurrentClaimQuest()

              if currentClaimQuest then
                if string.find(v15, "50") then
                  CombatController.Attack("Swan Pirate")
                  return
                end
                QuestController.AbandonQuest()
                return
              end

              QuestController.StartQuest("BartiloQuest", 1)
              return
            end

            if FunctionsHandler.ColosseumPuzzle.Methods.Refresh:Call() then
              return FunctionsHandler.ColosseumPuzzle.Methods.Start:Call()
            end
          end)

          do
            local function fn32(arg)
              local map, flag5, num

              if arg ~= "Deandre" then
                if arg ~= "Urban" then
                  if arg ~= "Diablo" then
                    if arg ~= "Tide Keeper" then
                      if arg ~= "Awakened Ice Admiral" then
                        return true
                      end
                      map = Services.Workspace:FindFirstChild("Map")

                      if map then
                        map = map:FindFirstChild("IceCastle")

                        if map then
                          map = map:FindFirstChild("Hall")
                          map = map and map:FindFirstChild("LibraryDoor")
                        end
                      end

                      flag5 = SeaIndex == 2

                      if flag5 then
                        flag5 = not map
                        if map then
                          return map:FindFirstChild("PhoeyuDoor") ~= nil
                        end
                      end

                      return flag5
                    end
                  else
                    if ScriptStorage.Backpack.Yama then
                      return false
                    end
                    num = tonumber(FunctionsHandler.Yama:Get("EliteCount"))

                    if num then
                      if num >= 30 then
                        return false
                      end

                      if arg ~= "Tide Keeper" then
                        if arg ~= "Awakened Ice Admiral" then
                          return true
                        end
                        map = Services.Workspace:FindFirstChild("Map")

                        if map then
                          map = map:FindFirstChild("IceCastle")

                          if map then
                            map = map:FindFirstChild("Hall")
                            map = map and map:FindFirstChild("LibraryDoor")
                          end
                        end

                        flag5 = SeaIndex == 2

                        if flag5 then
                          flag5 = not map
                          if map then
                            return map:FindFirstChild("PhoeyuDoor") ~= nil
                          end
                        end

                        return flag5
                      end
                    elseif arg ~= "Tide Keeper" then
                      if arg ~= "Awakened Ice Admiral" then
                        return true
                      end
                      map = Services.Workspace:FindFirstChild("Map")

                      if map then
                        map = map:FindFirstChild("IceCastle")

                        if map then
                          map = map:FindFirstChild("Hall")
                          map = map and map:FindFirstChild("LibraryDoor")
                        end
                      end

                      flag5 = SeaIndex == 2

                      if flag5 then
                        flag5 = not map
                        if map then
                          return map:FindFirstChild("PhoeyuDoor") ~= nil
                        end
                      end

                      return flag5
                    end
                  end
                else
                  if ScriptStorage.Backpack.Yama then
                    return false
                  end
                  num = tonumber(FunctionsHandler.Yama:Get("EliteCount"))

                  if num then
                    if num >= 30 then
                      return false
                    end

                    if arg ~= "Tide Keeper" then
                      if arg ~= "Awakened Ice Admiral" then
                        return true
                      end
                      map = Services.Workspace:FindFirstChild("Map")

                      if map then
                        map = map:FindFirstChild("IceCastle")

                        if map then
                          map = map:FindFirstChild("Hall")
                          map = map and map:FindFirstChild("LibraryDoor")
                        end
                      end

                      flag5 = SeaIndex == 2

                      if flag5 then
                        flag5 = not map
                        if map then
                          return map:FindFirstChild("PhoeyuDoor") ~= nil
                        end
                      end

                      return flag5
                    end
                  elseif arg ~= "Tide Keeper" then
                    if arg ~= "Awakened Ice Admiral" then
                      return true
                    end
                    map = Services.Workspace:FindFirstChild("Map")

                    if map then
                      map = map:FindFirstChild("IceCastle")

                      if map then
                        map = map:FindFirstChild("Hall")
                        map = map and map:FindFirstChild("LibraryDoor")
                      end
                    end

                    flag5 = SeaIndex == 2

                    if flag5 then
                      flag5 = not map
                      if map then
                        return map:FindFirstChild("PhoeyuDoor") ~= nil
                      end
                    end

                    return flag5
                  end
                end
              else
                if ScriptStorage.Backpack.Yama then
                  return false
                end
                num = tonumber(FunctionsHandler.Yama:Get("EliteCount"))

                if num then
                  if num >= 30 then
                    return false
                  end

                  if arg ~= "Tide Keeper" then
                    if arg ~= "Awakened Ice Admiral" then
                      return true
                    end
                    map = Services.Workspace:FindFirstChild("Map")

                    if map then
                      map = map:FindFirstChild("IceCastle")

                      if map then
                        map = map:FindFirstChild("Hall")
                        map = map and map:FindFirstChild("LibraryDoor")
                      end
                    end

                    flag5 = SeaIndex == 2

                    if flag5 then
                      flag5 = not map
                      if map then
                        return map:FindFirstChild("PhoeyuDoor") ~= nil
                      end
                    end

                    return flag5
                  end
                elseif arg ~= "Tide Keeper" then
                  if arg ~= "Awakened Ice Admiral" then
                    return true
                  end
                  map = Services.Workspace:FindFirstChild("Map")

                  if map then
                    map = map:FindFirstChild("IceCastle")

                    if map then
                      map = map:FindFirstChild("Hall")
                      map = map and map:FindFirstChild("LibraryDoor")
                    end
                  end

                  flag5 = SeaIndex == 2

                  if flag5 then
                    flag5 = not map
                    if map then
                      return map:FindFirstChild("PhoeyuDoor") ~= nil
                    end
                  end

                  return flag5
                end
              end

              return Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == "I lost my house keys, could you help me find them? Thanks."
            end

            local function fn33(arg)
              local flag5

              if arg ~= "Cake Prince" then
                flag5 = arg == "Dough King"

                if flag5 then
                  flag5 = ScriptStorage.Backpack["Mirror Fractal"]
                  if not flag5 then
                    return ScriptStorage.Tools["Mirror Fractal"]
                  end
                end
              elseif ScriptStorage.Backpack["Spikey Trident"] then
                flag5 = ScriptStorage.Backpack["Pale Scarf"]

                if not flag5 then
                  flag5 = ScriptStorage.Tools["Pale Scarf"]

                  if not flag5 then
                    flag5 = arg == "Dough King"

                    if flag5 then
                      flag5 = ScriptStorage.Backpack["Mirror Fractal"]
                      if not flag5 then
                        return ScriptStorage.Tools["Mirror Fractal"]
                      end
                    end
                  end
                end
              elseif ScriptStorage.Tools["Spikey Trident"] then
                flag5 = ScriptStorage.Backpack["Pale Scarf"]

                if not flag5 then
                  flag5 = ScriptStorage.Tools["Pale Scarf"]

                  if not flag5 then
                    flag5 = arg == "Dough King"

                    if flag5 then
                      flag5 = ScriptStorage.Backpack["Mirror Fractal"]
                      if not flag5 then
                        return ScriptStorage.Tools["Mirror Fractal"]
                      end
                    end
                  end
                end
              else
                flag5 = arg == "Dough King"

                if flag5 then
                  flag5 = ScriptStorage.Backpack["Mirror Fractal"]
                  if not flag5 then
                    return ScriptStorage.Tools["Mirror Fractal"]
                  end
                end
              end

              return flag5
            end

            FunctionsHandler.BossesTask:RegisterMethod("Refresh", function()
              local raidController = FunctionsHandler.RaidController

              if raidController then
                if raidController.Initalized then
                  if raidController.Methods.IsLocked then
                    local ok, result = pcall(function()
                      local methods = raidController.Methods
                      return methods.IsLocked:Call()
                    end)

                    if ok then
                      if result then
                        return nil
                      end
                    end
                  end
                end
              end

              local v15 = nil

              for _, v16 in ipairs(BossesOrder) do
                if BossesOrderLevel[v16] <= ScriptStorage.PlayerData.Level then
                  local v17 = ScriptStorage.Enemies[v16]

                  if v17 then
                    if v17:FindFirstChild("Humanoid") then
                      if v17.Humanoid.Health > 0 then
                        if fn33(v16) then
                        elseif fn32(v16) then
                          v15 = v17
                        end
                      end
                    end
                  end
                end
              end

              if v15 then
                local v16 = CaculateDistance(v15.HumanoidRootPart.CFrame)

                if SeaIndex ~= 2 then
                  if v16 < 5000 then
                    return v15
                  end
                elseif v16 < 3000 then
                  return v15
                end

                if BossesOrderWL[tostring(v15)] then
                  return v15
                end

                if ScriptStorage.PlayerData.Level ~= MaxLevel then
                  return
                end
                return v15
              end
            end)

            local function fn34(arg)
              local raidController = FunctionsHandler.RaidController

              if raidController then
                if raidController.Initalized then
                  if raidController.Methods.IsLocked then
                    if raidController.Methods.IsLocked:Call() then
                      return
                    end
                  end
                end
              end

              if CombatController.IsRaidActive() then
                return
              end

              if arg then
                if fn33(arg.Name) then
                  return
                end
                SetTask("MainTask", "Auto Farm Boss - Defeating " .. arg.Name)
                local v15 = nil
                local v16 = nil

                local function fn35()
                  SpecialItems = nil
                end

                CombatController.Attack(tostring(arg), v15, v16, fn35)
                SpecialItems = nil
                TweenController.Hovering = false
                TweenController.HoverCFrame = nil
                return
              end
            end

            FunctionsHandler.BossesTask:RegisterMethod("Start", fn34)

            FunctionsHandler.SpecialBossesTask:RegisterMethod("Refresh", function()
              local raidController = FunctionsHandler.RaidController

              if raidController then
                if raidController.Initalized then
                  if raidController.Methods.IsLocked then
                    local ok, result = pcall(function()
                      return raidController.Methods.IsLocked:Call()
                    end)

                    if ok then
                      if result then
                        return nil
                      end
                    end
                  end
                end
              end

              local v15 = nil

              for k, v16 in pairs(SpecialBossesOrder) do
                if v16 <= ScriptStorage.PlayerData.Level then
                  local v17 = ScriptStorage.Enemies[k]

                  if v17 then
                    if v17:FindFirstChild("Humanoid") then
                      if v17.Humanoid.Health > 0 then
                        if not fn33(k) then
                          v15 = v17
                        end
                      end
                    end
                  end
                end
              end

              return v15
            end)

            FunctionsHandler.SpecialBossesTask:RegisterMethod("Start", function(arg)
              local raidController = FunctionsHandler.RaidController

              if raidController then
                if raidController.Initalized then
                  if raidController.Methods.IsLocked then
                    if raidController.Methods.IsLocked:Call() then
                      return
                    end
                  end
                end
              end

              if CombatController.IsRaidActive() then
                return
              end

              if arg then
                if fn33(arg.Name) then
                  return
                end
                SetTask("MainTask", "Auto Farm Boss - Defeating " .. arg.Name)
                CombatController.Attack(tostring(arg))
                return
              end
            end)
          end

          local flag5
          flag5 = false
          local flag6
          flag6 = false
          local flag7
          flag7 = false
          local n3
          n3 = 0
          local n4
          n4 = 0
          local fn32, fn33

          do
            local n5 = 0
            local flag8 = false
            local tbl = {}

            fn32 = function(arg)
              if arg ~= "Island 4" then
                if arg ~= "Island 5" then
                  return
                end
              end

              if os.clock() < n5 then
                return
              end
              n5 = os.clock() + 12
              local enemies = workspace:FindFirstChild("Enemies")

              if enemies then
                local tbl9 = {}

                for _, child in ipairs(enemies:GetChildren()) do
                  local humanoid = child:FindFirstChildOfClass("Humanoid")

                  if humanoid then
                    if humanoid.Health > 0 then
                      table.insert(tbl9, {Humanoid = humanoid, MaxHealth = humanoid.MaxHealth})
                    end
                  end
                end

                local function fn34(arg2, arg3)
                  return arg2.MaxHealth > arg3.MaxHealth
                end

                table.sort(tbl9, fn34)
                local n6 = math.min(3, #tbl9)
                local n7 = 1
                local v15, humanoid, n8, fn35

                for i = n7, n6 do
                  humanoid = tbl9[i].Humanoid

                  if humanoid.Parent then
                    if humanoid.Health > 0 then

                      fn35 = function()
                        humanoid:ChangeState(Enum.HumanoidStateType.Dead)
                      end

                      pcall(fn35)
                    end

                    break
                  end
                end

                return
              end
            end

            local function fn34(arg, arg2)
              if not arg or not arg2 then
                for k in pairs(tbl) do
                  if k.Parent then
                    local raidVelocity = k:FindFirstChild("RaidVelocity")

                    if raidVelocity then
                      raidVelocity:Destroy()
                    end
                  end

                  tbl[k] = nil
                end

                return
              end

              for _, child in ipairs(arg:GetChildren()) do
                local humanoidRootPart = child:IsA("Model") and (child:FindFirstChild("HumanoidRootPart") or child.PrimaryPart)
                local humanoid = child:IsA("Model") and child:FindFirstChildOfClass("Humanoid")

                if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
                  local raidVelocity = humanoidRootPart:FindFirstChild("RaidVelocity")
                  local farOut = (math.abs(humanoidRootPart.Position.X) > 40000) or (math.abs(humanoidRootPart.Position.Z) > 40000)

                  if (farOut and humanoid) and (humanoid.Health > 0) then
                    humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

                    if not raidVelocity then
                      raidVelocity = Instance.new("BodyVelocity")
                      raidVelocity.Name = "RaidVelocity"
                      raidVelocity.Parent = humanoidRootPart
                    end

                    raidVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
                    raidVelocity.Velocity = Vector3.new(0, 0, 0)
                    tbl[humanoidRootPart] = true
                  elseif raidVelocity then
                    raidVelocity:Destroy()
                    tbl[humanoidRootPart] = nil
                  end
                end
              end
            end

            fn33 = function()
              if flag8 then
                return
              end
              flag8 = true

              task.spawn(function()
                local now4 = os.clock()

                while not _G.Stop do
                  if CombatController.IsRaidActive() then
                    now4 = os.clock()
                    pcall(fn34, workspace:FindFirstChild("Enemies"), true)
                    task.wait()
                    continue
                  elseif (os.clock() - now4) <= 5 then
                    pcall(fn34, workspace:FindFirstChild("Enemies"), false)
                    task.wait(0.1)
                    continue
                  end

                  break
                end

                pcall(fn34, workspace:FindFirstChild("Enemies"), false)
                flag8 = false
              end)
            end
          end

          local remotes = Services.ReplicatedStorage:FindFirstChild("Remotes")

          if remotes then
            local raids = remotes:FindFirstChild("Raids")

            if raids then
              if raids:IsA("RemoteEvent") then
                raids.OnClientEvent:Connect(function(arg)
                  if arg == "StartTimer" then
                    if flag7 then
                      flag5 = true
                      flag6 = false
                      n4 = 0
                      flag7 = false
                      return
                    end
                  end
                end)
              end
            end
          end

          local fn34

          fn34 = function(arg)
            local flag8 = not flag6

            if not flag6 then
              flag8 = flag5

              if not flag5 then
                flag8 = arg ~= nil
                if not flag8 then
                  return (CombatController.IsRaidActive())
                end
              end
            end

            return flag8
          end

          FunctionsHandler.RaidController:RegisterMethod("RefreshRaidType", function()
            local raids = require(game.ReplicatedStorage.Raids).raids
            local str4 = tostring(ScriptStorage.PlayerData.DevilFruit or "")

            if str4 ~= "" then
              if str4 ~= "None" then
                for _, raid in ipairs(raids) do
                  if string.find(str4, raid) then
                    FunctionsHandler.RaidController:Set("CurrentChip", raid)
                    return
                  end
                end
              end
            end

            for _, raid in ipairs(raids) do
              if string.lower(tostring(raid)) ~= "ice" then
                continue
              end
              FunctionsHandler.RaidController:Set("CurrentChip", raid)
              return
            end

            FunctionsHandler.RaidController:Set("CurrentChip", "Ice")
          end)

          FunctionsHandler.RaidController:RegisterMethod("GetRaidableFruit", function()
            local v15, v16, v17 = pairs(ScriptStorage.Backpack or {})
            local huge = math.huge
            local v18 = nil
            local n5, num

            for _, v19 in v15, v16, v17 do
              if type(v19) == "table" then
                local flag8

                if v19.Name then
                  n5 = (tonumber(v19.Count) or tonumber(v19.Amount)) or 0
                  num = tonumber(v19.Price) or submergedWaitTick(v19.Name)
                  flag8 = v19.Type == "Blox Fruit"

                  if flag8 then
                    if not ((n5 <= 0) or (not flag8 or (not num or ((num <= 1) or ((num >= 1000000) or (huge <= num)))))) then
                      huge = num
                      v18 = v19
                    end
                  else
                    flag8 = v19.Type == "PhysicalMoveset"

                    if flag8 then
                      if not ((n5 <= 0) or (not flag8 or (not num or ((num <= 1) or ((num >= 1000000) or (huge <= num)))))) then
                        huge = num
                        v18 = v19
                      end
                    else
                      flag8 = v19.Type == "Tool"

                      if flag8 then
                        flag8 = submergedWaitTick(v19.Name) > 1

                        if n5 <= 0 then
                        elseif flag8 then
                          if num then
                            if (num <= 1) or (num >= 1000000) then
                            elseif huge > num then
                              huge = num
                              v18 = v19
                            end
                          end
                        end
                      elseif not ((n5 <= 0) or (not flag8 or (not num or ((num <= 1) or ((num >= 1000000) or (huge <= num)))))) then
                        huge = num
                        v18 = v19
                      end
                    end
                  end
                end
              end
            end

            return v18
          end)

          FunctionsHandler.RaidController:RegisterMethod("GetCurrentRaidIsland", function()
            if SeaIndex ~= 1 then
              if flag6 then
                return nil
              end
              local character = LocalPlayer.Character

              if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                  local tbl = {{}, {}, {}, {}, {}}
                  local flag8 = (math.abs(humanoidRootPart.Position.X) > 40000) or (math.abs(humanoidRootPart.Position.Z) > 40000)
                  local locations = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
                  local v15 = nil

                  if locations then
                    local v16 = nil
                    v15 = nil

                    for _, child in ipairs(locations:GetChildren()) do
                      if string.find(child.Name, "Island ") then
                        if (child.Position - Vector3.new(0, 0, 0)).Magnitude > 7000 then
                          local v17 = string.match(child.Name, "%d+")
                          local num = tonumber(v17)

                          if num then
                            if tbl[num] then
                              table.insert(tbl[num], child)
                            end
                          end

                          local magnitude = (child.Position - humanoidRootPart.Position).Magnitude

                          if v16 then
                            if magnitude < v16 then
                              v16 = magnitude
                              v15 = child
                            end
                          else
                            v16 = magnitude
                            v15 = child
                          end
                        end
                      end
                    end
                  end

                  for i = 5, 1, -1 do
                    for _, v16 in ipairs(tbl[i]) do
                      if (v16.Position - humanoidRootPart.Position).Magnitude < 3000 then
                        return v16
                      end
                    end
                  end

                  if flag8 then
                    if v15 then
                      return v15
                    end
                  end

                  return nil
                end
              end

              return nil
            end

            return nil
          end)

          local function fn35(arg)
            if arg then
              if arg:IsA("Tool") then
                local v15 = string.lower(tostring(arg.Name))
                local flag8 = v15 == "special microchip"
                if flag8 then
                  return flag8
                end
                return v15:find("microchip", 1, true) ~= nil
              end

              return false
            end

            return false
          end

          CheckSpecialMicrochip = function(arg)
            local tbl = {}

            if LocalPlayer.Character then
              table.insert(tbl, LocalPlayer.Character:GetChildren())
            end

            if LocalPlayer.Backpack then
              table.insert(tbl, LocalPlayer.Backpack:GetChildren())
            end

            for _, v15 in ipairs(tbl) do
              for _, v16 in ipairs(v15) do
                if fn35(v16) then
                  if arg then
                    if v16.Parent ~= LocalPlayer.Character then
                      continue
                    end
                    return v16
                  end

                  return v16
                end
              end
            end
          end

          local fn36

          do
            local function fn37(arg, arg2)
              local now4 = os.clock()

              while true do
                local v15 = CheckSpecialMicrochip(arg2)

                if v15 then
                  return v15
                else
                  task.wait(0.15)
                  local n5 = os.clock() - now4

                  if arg then
                    if arg < n5 then
                      return
                    end
                    continue
                  end

                  if n5 > 3 then
                    break
                  end
                end
              end
            end

            local function fn38()
              local now4 = os.clock()
              local v15 = fn37(0.5)
              if not v15 then
                return nil
              end

              while (os.clock() - now4) < 2 do
                if v15 then
                  if v15.Parent == LocalPlayer.Character then
                    return v15
                  end
                end

                if v15 then
                  if v15:IsA("Tool") then
                    if LocalPlayer.Character then
                      local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                      if humanoid then
                        pcall(function()
                          humanoid:EquipTool(v15)
                        end)
                      end
                    end
                  else
                    pcall(function()
                      FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Special Microchip")
                    end)

                    v15 = fn37(0.25)
                  end
                else
                  pcall(function()
                    FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Special Microchip")
                  end)

                  v15 = fn37(0.25)
                end

                local v16 = fn37(0.25, true)
                if v16 then
                  return v16
                end
                v15 = CheckSpecialMicrochip()
                task.wait(0.1)
              end

              return CheckSpecialMicrochip(true)
            end

            local function fn39(arg)
              local map = workspace:FindFirstChild("Map")

              if map then
                local v15 = map:FindFirstChild(arg)
                if v15 then
                  return v15
                end
              end

              return (workspace:FindFirstChild(arg))
            end

            local function fn40(arg)
              if arg then
                if arg:IsA("BasePart") then
                  return arg.CFrame
                end

                if arg:IsA("Model") then
                  return arg:GetModelCFrame()
                end
                local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")

                if not humanoidRootPart then
                  humanoidRootPart = arg:FindFirstChildWhichIsA("BasePart", true)
                  if not humanoidRootPart then
                    return humanoidRootPart
                  end
                end

                return humanoidRootPart.CFrame
              end
            end

            local function fn41(arg)
              local v15 = fn39(arg)
              local v16 = fn40(v15)
              local v17 = nil

              for _, descendant in ipairs(workspace:GetDescendants()) do
                local exitTo = nil

                if (descendant.Name == "RaidSummon2") or (descendant.Name == "RaidSummon") then
                  if v16 then
                    exitTo = 1
                  elseif not v17 then
                    v17 = descendant
                  end
                end

                if exitTo == 1 then
                  local v18 = fn40(descendant)

                  if v18 then
                    if (v18.Position - v16.Position).Magnitude < 2500 then
                      return v15, descendant
                    end
                    continue
                  end

                  continue
                end

                if exitTo == 2 then
                  break
                end
              end

              return v15, v17
            end

            local function fn42(arg)
              local v15 = fn39(arg)
              local raidSummon2, v16

              if v15 then
                raidSummon2 = v15:FindFirstChild("RaidSummon2", true)

                if not raidSummon2 then
                  local v17
                  v16, v17 = fn41(arg)
                  raidSummon2 = v17
                  if not v15 then
                    return v16, raidSummon2
                  end
                end
              else
                v16, raidSummon2 = fn41(arg)
                if not v15 then
                  return v16, raidSummon2
                end
              end

              return v15, raidSummon2
            end

            local function fn43(arg)
              local v15, v16 = fn42(arg)
              local button, clickDetector

              if v16 then
                button = v16:FindFirstChild("Button", true)

                if button then
                  clickDetector = button:FindFirstChildWhichIsA("ClickDetector", true)

                  if not button:IsA("BasePart") then
                    button = button:FindFirstChildWhichIsA("BasePart", true)
                  end
                else
                  button = v16:FindFirstChild("Main", true)

                  if button then
                    clickDetector = button:FindFirstChildWhichIsA("ClickDetector", true)

                    if not button:IsA("BasePart") then
                      button = button:FindFirstChildWhichIsA("BasePart", true)
                    end
                  else
                    clickDetector = button
                  end
                end
              else
                button = v16
                clickDetector = button
                return v15, v16, clickDetector, button
              end

              return v15, v16, clickDetector, button
            end

            local function fn44(arg, arg2, arg3)
              local v15 = fn40(arg3)

              if not v15 then
                v15 = fn40(arg2)

                if not v15 then
                  v15 = fn40(arg)
                  if not v15 then
                    return
                  end
                end
              end

              return v15 + Vector3.new(0, 5, 3)
            end

            local function fn45(arg)
              local v15

              if ScriptStorage.Map then
                v15 = ScriptStorage.Map[arg]

                if not v15 then
                  local v16 = workspace

                  if v16:FindFirstChild("Map") then
                    v15 = workspace.Map:FindFirstChild(arg) or workspace:FindFirstChild(arg)
                  else
                    v15 = workspace:FindFirstChild(arg)
                    return fn40(v15)
                  end
                end
              elseif workspace:FindFirstChild("Map") then
                v15 = workspace.Map:FindFirstChild(arg) or workspace:FindFirstChild(arg)
              else
                v15 = workspace:FindFirstChild(arg)
                return fn40(v15)
              end

              return fn40(v15)
            end

            local function fn46(arg, arg2)
              local flag8 = false

              if arg then
                pcall(function()
                  fireclickdetector(arg)
                  flag8 = true
                end)
              end

              local character = LocalPlayer.Character

              if character then
                character = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if arg2 then
                  if character then
                    pcall(function()
                      firetouchinterest(character, arg2, 0)
                      task.wait()
                      firetouchinterest(character, arg2, 1)
                      flag8 = true
                    end)

                    return flag8
                  end
                end
              elseif arg2 then
                if character then
                  pcall(function()
                    firetouchinterest(character, arg2, 0)
                    task.wait()
                    firetouchinterest(character, arg2, 1)
                    flag8 = true
                  end)

                  return flag8
                end
              end

              return flag8
            end

            local tbl = {["Boat Castle"] = CFrame.new(-5050, 322, -2960), CircleIsland = CFrame.new(-6440, 250, -4500), ["Circle Island"] = CFrame.new(-6440, 250, -4500)}

            local function fn47(arg)
              warn("TweenClear", arg or "?")

              pcall(function()
                local v15 = TweenInstance2
                if v15 then
                  return (TweenInstance2:Cancel())
                end
                return v15
              end)

              TweenController.ClearGhost()

              pcall(function()
                local character = LocalPlayer.Character

                if character then
                  local humanoid = character:FindFirstChildOfClass("Humanoid")

                  if humanoid then
                    humanoid.Sit = false
                    humanoid.PlatformStand = false
                  end

                  local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart then
                    humanoidRootPart.Anchored = false
                    humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                  end

                  pcall(function()
                    setscriptable(LocalPlayer, "SimulationRadius", true)
                    sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                  end)
                  return
                end
              end)

              task.wait(0.05)
            end

            local v15 = nil
            local n5 = 0
            local v16 = nil
            local n6 = 0
            local n7 = 0
            local n8 = 30
            local n9 = 120

            local function fn48(arg)
              if FunctionsHandler.RaidController:Get("RaidCommitted") then
                if v16 ~= arg then
                  warn("Lock on:", arg)
                end
              else
                warn("Lock on:", arg)
              end

              n5 = os.time()
              v16 = arg
              FunctionsHandler.RaidController:Set("RaidCommitted", true)
            end

            local function fn49(arg)
              if FunctionsHandler.RaidController:Get("RaidCommitted") then
                warn("Lock off:", arg or "unknown")
              end

              n5 = 0
              v16 = nil
              FunctionsHandler.RaidController:Set("RaidCommitted", false)
            end

            fn36 = function()
              flag5 = false
              flag6 = true
              flag7 = false
              n3 += 1
              n4 = os.clock() + 5
              LastRaidAlert = 0
              LastRaidAlert2 = 0
              v15 = nil
              FunctionsHandler.RaidController:Set("CurrentProgressLevel", nil)
              fn49("raid_completed")
              TweenDebounce = false

              pcall(function()
                if TweenInstance then
                  TweenInstance:Cancel()
                end

                if TweenInstance2 then
                  TweenInstance2:Cancel()
                  return
                end
              end)

              fn47("raid_completed_clear_state")
              warn("Completed -> cleared all raid state")
            end

            FunctionsHandler.RaidController:RegisterMethod("IsLocked", function()
              if SeaIndex == 1 then
                return nil
              end

              if os.clock() < n4 then
                return true
              end

              if flag6 then
                if CombatController.IsRaidActive() then
                  return true
                end
              end

              local ok, result = pcall(function()
                return FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call()
              end)

              if ok then
                result = result or nil
              else
                result = nil
              end

              if fn34(result) then
                fn48("in_raid_dimension")
                if result then
                  return result
                end
                return true
              end

              if FunctionsHandler.RaidController:Get("RaidCommitted") then
                if v16 == "in_raid_dimension" then
                  if n5 > 0 then
                    if (os.time() - n5) <= n9 then
                      return true
                    end
                  end

                  fn49("raid_dimension_expired")
                end
              end

              local v17 = CheckSpecialMicrochip()
              if v17 then
                fn48("special_microchip")
                return v17
              end

              if FunctionsHandler.RaidController:Get("RaidCommitted") then
                if n5 > 0 then
                  if (os.time() - n5) <= n9 then
                    return true
                  end
                end

                fn49("prep_expired")
                return nil
              end

              return nil
            end)

            FunctionsHandler.RaidController:RegisterMethod("Refresh", function()
              local v17 = FunctionsHandler.RaidController.Methods.IsLocked:Call()
              if v17 then
                return v17
              end
              local level = ScriptStorage.PlayerData.Level
              local fragments = ScriptStorage.PlayerData.Fragments
              if level < 1300 then
                return
              end

              if SeaIndex ~= 1 then
                if level < 1500 then
                  if fragments > 2000 then
                    return
                  end
                end

                if level < MaxLevel then
                  if fragments > 5000 then
                    return
                  end
                elseif fragments > 10000 then
                  return
                end

                local v18 = FunctionsHandler.RaidController.Methods.GetRaidableFruit:Call()
                local flag8 = (n7 == 0) or ((os.clock() - n7) >= n8)
                local flag9 = (tonumber(ScriptStorage.PlayerData.Beli) or 0) >= 100000

                if flag9 then
                  flag9 = (os.time() - n6) > 7200
                end

                if not v18 then
                  if flag9 then
                    FunctionsHandler.RaidController:Set("CurrentProgressLevel", "Beli")
                    return "Beli"
                  end
                  return nil
                end

                if flag8 then
                  FunctionsHandler.RaidController:Set("CurrentProgressLevel", v18)
                  return v18
                end

                if flag9 then
                  FunctionsHandler.RaidController:Set("CurrentProgressLevel", "Beli")
                  return "Beli"
                end
                return nil
              end
            end)

            FunctionsHandler.RaidController:RegisterMethod("Start", function()
              local start = FunctionsHandler.RaidController.Methods.Start
              if start.Busy then
                return
              end
              start.Busy = true

              local ok, result = xpcall(function()
                local now4 = os.clock()
                if now4 < n4 then
                  SetTask("MainTask", "Auto Raid - Waiting After Completion")
                  return
                end

                if flag6 then
                  if CombatController.IsRaidActive() then
                    SetTask("MainTask", "Auto Raid - Waiting for server return")
                    return
                  end
                end

                if not FunctionsHandler.RaidController:Get("CurrentChip") then
                  FunctionsHandler.RaidController.Methods.RefreshRaidType:Call()
                end

                if SeaIndex ~= 1 then
                  local ok, result = pcall(function()
                    return FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call()
                  end)

                  local v17 = result

                  if ok then
                    v17 = v17 or nil
                  else
                    v17 = nil
                  end

                  local v18 = fn34(v17)
                  RefreshInventory()

                  if n3 ~= n3 then
                    local v19 = SetTask
                    local str4 = (CombatController.IsRaidActive() and "Auto Raid - Waiting for server return") or "Auto Raid - Waiting After Completion"
                    v19("MainTask", str4)
                    return
                  end

                  FunctionsHandler.RaidController:Set("CurrentProgressLevel", nil)
                  local name2

                  if v17 then
                    fn48("in_raid_dimension")
                    name2 = v17.Name or "dim"
                  elseif v18 then
                    fn48("in_raid_dimension")
                    name2 = "dim"
                  else
                    name2 = "dim"
                  end

                  local v19 = SeaIndex
                  local str4 = (v18 and "raid") or "prep"
                  local str5 = name2 .. ("|" .. (v19 .. ("|" .. str4)))

                  if str5 ~= v15 then
                    v15 = str5
                    local CurrentChip = FunctionsHandler.RaidController:Get("CurrentChip")
                    local v20 = SeaIndex
                    local name3

                    if v17 then
                      name3 = v17.Name

                      if not name3 then
                        if v18 then
                          name3 = "in_dimension"
                        else
                          name3 = "nil"
                        end
                      end
                    elseif v18 then
                      name3 = "in_dimension"
                    else
                      name3 = "nil"
                    end

                    warn("Start chip=", CurrentChip, "sea=", v20, "island=", name3)
                  end

                  if not v18 then
                    local position

                    if v17 then
                      local name3

                      if typeof(v17) ~= "Instance" then
                        v17 = FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call()

                        if v17 then
                          now4 = v17:IsA("BasePart")

                          if now4 then
                            position = v17.Position

                            if position then
                              if v17 then
                                name3 = v17.Name or "Raid Island"
                              else
                                name3 = "Raid Island"
                              end
                            else
                              position = nil

                              if v17 then
                                name3 = v17.Name
                              else
                                name3 = "Raid Island"
                              end
                            end
                          else
                            position = nil
                          end
                        else
                          position = nil
                        end
                      elseif v17:IsA("BasePart") then
                        if v17 then
                          now4 = v17:IsA("BasePart")

                          if now4 then
                            position = v17.Position
                          end
                        else
                          v17 = FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call()
                        end
                      else
                        v17 = FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call()
                      end

                      SetTask("MainTask", "Auto Raid - " .. (tostring(name3) .. " / 5"))
                      fn33()
                      local enemies = workspace:FindFirstChild("Enemies")
                      local v20 = nil

                      if enemies then
                        local v22 = nil
                        v20 = nil

                        for _, child in ipairs(enemies:GetChildren()) do
                          local humanoid = child:FindFirstChildOfClass("Humanoid")
                          local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

                          if humanoid then
                            if humanoid.Health > 0 then
                              if humanoidRootPart then
                                local v23 = CaculateDistance(humanoidRootPart.Position)

                                if v23 <= 400 then
                                  if v22 then
                                    if v23 < v22 then
                                      v22 = v23
                                      v20 = child
                                    end
                                  else
                                    v22 = v23
                                    v20 = child
                                  end
                                end
                              end
                            end
                          end
                        end
                      end

                      fn32(name3)

                      if v20 then
                        local now5 = os.time()

                        while v20.Parent do
                          if v20:IsDescendantOf(enemies) then
                            if (os.time() - now5) < 45 then
                              task.wait(0.05)
                              fn32(name3)
                              local humanoid = v20:FindFirstChildOfClass("Humanoid")
                              local humanoidRootPart = v20:FindFirstChild("HumanoidRootPart")

                              if humanoid then
                                if humanoid.Health <= 0 then
                                  return
                                end

                                if humanoidRootPart then
                                  if CaculateDistance(humanoidRootPart.Position) > 400 then
                                    return
                                  end
                                  CombatController.Attack(v20.Name, nil, nil, nil, {AllowBring = false, TargetInstance = v20})
                                  continue
                                end

                                break
                              end

                              break
                            end

                            break
                          end

                          break
                        end

                        return
                      end

                      if position then
                        local flag8 = (name3 == "Island 2") and (FunctionsHandler.RaidController:Get("CurrentChip") == "Phoenix")
                        local n11 = (flag8 and 300) or 0
                        local n12 = position + Vector3.new(n11, 60, 0)

                        if not TweenController.Playing then
                          if TweenController.Hovering then
                            stopTween(false)
                          end

                          if CaculateDistance(n12) > 8 then
                            TweenController.Create(n12, false, true)
                          end
                        end

                        return
                      end

                      SetTask("MainTask", "Auto Raid - Waiting for island")
                      return
                    else
                      if v16 == "in_raid_dimension" then
                        if n5 > 0 then
                          if (os.time() - n5) <= n9 then
                            SetTask("MainTask", "Auto Raid - Waiting for raid state")
                            return
                          end
                        end
                      end

                      SetTask("MainTask", "Auto Raid - Buying Chip - " .. FunctionsHandler.RaidController:Get("CurrentChip"))
                      local v20 = CheckSpecialMicrochip()
                      local flag8 = not v20

                      if v20 then
                        if flag8 then
                          local v22 = FunctionsHandler.RaidController.Methods.GetRaidableFruit:Call()
                          local num = tonumber(ScriptStorage.PlayerData.Beli)

                          if num then
                            if v22 then
                              local n11, fn50, v23, n12, exitTo2

                              if n7 ~= 0 then
                                if n8 <= (os.clock() - n7) then
                                  n7 = os.clock()
                                  warn("Prep LoadFruit", v22.Name)
                                  fn48("buying_chip")
                                  table.insert(ScriptStorage.IgnoreStoreFruits, v22.Name)

                                  fn50 = function()
                                    Remotes.CommF_:InvokeServer("LoadFruit", v22.Name)
                                  end

                                  pcall(fn50)
                                  v23 = FruitIdToName(v22.Name)
                                  n12 = os.clock() + 1.5
                                  exitTo2 = nil
                                  local exitTo4 = nil

                                  while true do
                                    if ScriptStorage.Tools[v22.Name] then
                                      exitTo4 = 1
                                    else
                                      if not v23 then
                                        task.wait(0.1)

                                        if n12 <= os.clock() then
                                          exitTo4 = 2
                                          break
                                        else
                                          continue
                                        end
                                      end
                                    end

                                    break
                                  end

                                  if exitTo4 ~= 1 then
                                    if exitTo4 ~= 2 then
                                      if ScriptStorage.Tools[v23] then
                                        exitTo2 = 1
                                      else
                                        task.wait(0.1)

                                        if n12 > os.clock() then
                                          local exitTo5 = nil

                                          while true do
                                            if ScriptStorage.Tools[v22.Name] then
                                              exitTo5 = 1
                                            else
                                              if v23 then
                                                exitTo5 = 2
                                                break
                                              else
                                                task.wait(0.1)
                                                if n12 > os.clock() then
                                                  continue
                                                end
                                              end
                                            end

                                            break
                                          end

                                          if exitTo5 == 1 then
                                            exitTo2 = 1
                                          end
                                        end
                                      end

                                      if exitTo2 ~= 1 then
                                        fn49("raid_fruit_load_failed")
                                        warn("Raid fruit did not load", v22.Name)
                                        return
                                      end

                                      pcall(function()
                                        Remotes.CommF_:InvokeServer("RaidsNpc", "Select", FunctionsHandler.RaidController:Get("CurrentChip"))
                                      end)

                                      fn37(1.5)

                                      if not CheckSpecialMicrochip() then
                                        if not fn37(1) then
                                          n6 = os.time()
                                          fn49("buy_chip_failed")
                                          warn("Prep buy chip failed or cooldown active")
                                          return
                                        end
                                      end

                                      local v24 = ({nil, "CircleIsland", "Boat Castle"})[SeaIndex]

                                      local v25, v26, v27, v28 = fn43(v24)
                                      local now5, exitTo3, humanoid, now6, v29

                                      if v27 then
                                        now5 = os.clock()
                                        SetTask("MainTask", "Auto Raid - Starting Raid")
                                        exitTo3 = nil

                                        while true do
                                          if CheckSpecialMicrochip() then
                                            if fn34() then
                                              exitTo3 = 1
                                              break
                                            elseif (os.clock() - now5) <= 30 then
                                              fn38()
                                              flag7 = true
                                              fn46(v27, v28)
                                              stopTween(false)
                                              task.wait(0.25)
                                              continue
                                            end
                                          else
                                            exitTo3 = 1
                                          end

                                          break
                                        end

                                        if exitTo3 ~= 1 then
                                          warn("Prep timeout 30s inserting chip -> resetting character")
                                          flag7 = false
                                          fn49("insert_timeout_reset")

                                          if LocalPlayer.Character then
                                            humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                            if humanoid then
                                              humanoid:ChangeState(15)
                                              task.wait(1.5)
                                              return
                                            end
                                          end

                                          return
                                        end

                                        now6 = os.time()
                                        v29 = SetTask

                                        do
                                          v29("MainTask", "Auto Raid - Waiting Until Raid Is Started")
                                          stopTween(false)

                                          while not fn34() do
                                            if (os.time() - now6) > 30 then
                                              warn("Timeout 30s waiting for raid to start")
                                              flag7 = false
                                              break
                                            else
                                              task.wait(0.5)
                                            end
                                          end

                                          flag7 = false
                                          return
                                        end
                                      elseif v28 then
                                        now5 = os.clock()
                                        SetTask("MainTask", "Auto Raid - Starting Raid")
                                        exitTo3 = nil

                                        while true do
                                          if CheckSpecialMicrochip() then
                                            if fn34() then
                                              exitTo3 = 1
                                              break
                                            elseif (os.clock() - now5) <= 30 then
                                              fn38()
                                              flag7 = true
                                              fn46(v27, v28)
                                              stopTween(false)
                                              task.wait(0.25)
                                              continue
                                            end
                                          else
                                            exitTo3 = 1
                                          end

                                          break
                                        end

                                        if exitTo3 ~= 1 then
                                          warn("Prep timeout 30s inserting chip -> resetting character")
                                          flag7 = false
                                          fn49("insert_timeout_reset")

                                          if LocalPlayer.Character then
                                            humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                            if humanoid then
                                              humanoid:ChangeState(15)
                                              task.wait(1.5)
                                              return
                                            end
                                          end

                                          return
                                        end

                                        now6 = os.time()
                                        v29 = SetTask

                                        do
                                          v29("MainTask", "Auto Raid - Waiting Until Raid Is Started")
                                          stopTween(false)

                                          while not fn34() do
                                            if (os.time() - now6) > 30 then
                                              warn("Timeout 30s waiting for raid to start")
                                              flag7 = false
                                              break
                                            else
                                              task.wait(0.5)
                                            end
                                          end

                                          flag7 = false
                                          return
                                        end
                                      else
                                        local v30 = fn44(v25, v26, v28)

                                        if not v30 then
                                          v30 = tbl[v24]

                                          if not v30 then
                                            return
                                          end
                                        end

                                        SetTask("MainTask", "Auto Raid - Loading Raid Room - " .. tostring(v24))

                                        if TweenController.Hovering then
                                          if TweenController.HoverCFrame then
                                            if (TweenController.HoverCFrame.Position - v30.Position).Magnitude > 8 then
                                              TweenController.Create(v30)
                                            end

                                            return
                                          end

                                          TweenController.Create(v30)
                                          return
                                        end

                                        TweenController.Create(v30)
                                        return
                                      end
                                    end
                                  end
                                else
                                  if num >= 100000 then
                                    if (os.time() - n6) > 7200 then
                                      warn("Prep BuyChip with 100k Beli")
                                      fn48("buying_chip_beli")

                                      pcall(function()
                                        local commF = Remotes.CommF_
                                        commF:InvokeServer("RaidsNpc", "Select", FunctionsHandler.RaidController:Get("CurrentChip"))
                                      end)

                                      fn37(1.5)

                                      if not CheckSpecialMicrochip() then
                                        n6 = os.time()
                                        fn49("buy_chip_failed")
                                        warn("Prep buy chip failed or cooldown active")
                                        return
                                      end
                                    end
                                  end

                                  fn49("no_fruit_or_beli_cooldown")
                                  warn("Prep no raid fruit and not enough Beli or on cooldown")
                                  return
                                end
                              else
                                n7 = os.clock()
                                warn("Prep LoadFruit", v22.Name)
                                fn48("buying_chip")
                                table.insert(ScriptStorage.IgnoreStoreFruits, v22.Name)

                                fn50 = function()
                                  Remotes.CommF_:InvokeServer("LoadFruit", v22.Name)
                                end

                                pcall(fn50)
                                v23 = FruitIdToName(v22.Name)
                                n12 = os.clock() + 1.5
                                exitTo2 = nil
                              end
                            else
                              if num >= 100000 then
                                if (os.time() - n6) > 7200 then
                                  warn("Prep BuyChip with 100k Beli")
                                  fn48("buying_chip_beli")

                                  pcall(function()
                                    local commF = Remotes.CommF_
                                    commF:InvokeServer("RaidsNpc", "Select", FunctionsHandler.RaidController:Get("CurrentChip"))
                                  end)

                                  fn37(1.5)
                                end
                              end

                              fn49("no_fruit_or_beli_cooldown")
                              warn("Prep no raid fruit and not enough Beli or on cooldown")
                              return
                            end
                          else
                            num = 0

                            if not v22 then
                              if num >= 100000 then
                                if (os.time() - n6) > 7200 then
                                  warn("Prep BuyChip with 100k Beli")
                                  fn48("buying_chip_beli")

                                  pcall(function()
                                    local commF = Remotes.CommF_
                                    commF:InvokeServer("RaidsNpc", "Select", FunctionsHandler.RaidController:Get("CurrentChip"))
                                  end)

                                  fn37(1.5)
                                end
                              end

                              fn49("no_fruit_or_beli_cooldown")
                              warn("Prep no raid fruit and not enough Beli or on cooldown")
                              return
                            end
                          end
                        else
                          fn48("special_microchip")
                        end
                      else
                        local tools = ScriptStorage.Tools
                        local flag9 = not tools["Special Microchip"]
                      end
                    end
                  end
                end
              end, debug.traceback)

              start.Busy = false
              if ok then
                return
              end
              Report(result)
            end)
          end

          FunctionsHandler.CollectDrops:RegisterMethod("Refresh", function()
            if ShouldPreemptForMeleeBuy then
              if ShouldPreemptForMeleeBuy() then
                return
              end
            end

            if FunctionsHandler.RaidController then
              if FunctionsHandler.RaidController.Initalized then
                if FunctionsHandler.RaidController.Methods.IsLocked then
                  if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                    FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", nil)
                    return
                  end
                end
              end
            end

            local n5 = tonumber(ScriptStorage.PlayerData.Level) or 0
            local CurrentProgressLevel = FunctionsHandler.CollectDrops:Get("CurrentProgressLevel")

            if CurrentProgressLevel then
              if CurrentProgressLevel:IsDescendantOf(workspace) then
                if CurrentProgressLevel:FindFirstChild("Handle") then
                  if n5 >= 1000 then
                    return CurrentProgressLevel
                  end

                  if not isSubmergedPos(CurrentProgressLevel:GetModelCFrame().Position) then
                    return CurrentProgressLevel
                  end
                end
              end
            end

            local tbl = {}

            for k in pairs(FruitList or {}) do
              tbl[FruitIdToName(k)] = k
            end

            for _, v15 in workspace:GetChildren() do
              if string.find(v15.Name, "Fruit") then
                if not PlayersService:FindFirstChild(v15.Name) then
                  if v15:FindFirstChild("Handle") then
                    if not tbl[tostring(v15)] then
                      if not ScriptStorage.Backpack[FruitNameToId(tostring(v15))] then
                        if n5 >= 1000 then
                          FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", v15)
                          return v15
                        end

                        if not isSubmergedPos(v15:GetModelCFrame().Position) then
                          FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", v15)
                          return v15
                        end
                        continue
                      end

                      continue
                    end

                    continue
                  end
                end
              end
            end
          end)

          FunctionsHandler.CollectDrops:RegisterMethod("Start", function()
            if ShouldPreemptForMeleeBuy then
              if ShouldPreemptForMeleeBuy() then
                return
              end
            end

            if FunctionsHandler.RaidController then
              if FunctionsHandler.RaidController.Initalized then
                if FunctionsHandler.RaidController.Methods.IsLocked then
                  if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                    FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", nil)
                    return
                  end
                end
              end
            end

            local CurrentProgressLevel = FunctionsHandler.CollectDrops:Get("CurrentProgressLevel")

            if CurrentProgressLevel then
              if CurrentProgressLevel:IsDescendantOf(workspace) then
                local modelCFrame = CurrentProgressLevel:GetModelCFrame()
                SetTask("MainTask", "Auto Collect Drop Items - " .. tostring(CurrentProgressLevel))

                if CaculateDistance(modelCFrame.Position) > 10 then
                  if TweenController.Playing then
                    return
                  end
                  TweenController.Create(modelCFrame)
                  return
                end

                FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", nil)
                return
              end
            end

            FunctionsHandler.CollectDrops:Set("CurrentProgressLevel", nil)
          end)

          do
            local n5 = 0

            local function fn37()
              if os.time() < n5 then
                return nil
              end

              local ok, result = pcall(function()
                return Remotes.CommF_:InvokeServer("BuyElectricClaw", true)
              end)

              if ok then
                return result
              end
              return nil
            end

            FunctionsHandler.UtillyItemsActivitation:RegisterMethod("Refresh", function()

              if FunctionsHandler.RaidController then
                if FunctionsHandler.RaidController.Initalized then
                  if FunctionsHandler.RaidController.Methods.IsLocked then
                    if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                      return
                    end
                  end
                end
              end

              if (os.time() - now3) < 20 then
                return
              end

              if not SpecialItems then
                SpecialItems = {}
                local tbl = {}
                IceAdmiralPassed = true
                local num = tonumber(FunctionsHandler.Yama:Get("EliteCount"))

                if SeaIndex == 3 then
                  if not ScriptStorage.Backpack.Yama then
                    local ok, result = pcall(function()
                      return Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
                    end)

                    if ok then
                      local num2 = tonumber(result)

                      if num2 then
                        num = num2
                        FunctionsHandler.Yama:Set("EliteCount", num)
                      elseif num then
                        FunctionsHandler.Yama:Set("EliteCount", num)
                      end
                    elseif num then
                      FunctionsHandler.Yama:Set("EliteCount", num)
                    end
                  end
                end

                if ScriptStorage.Tools["Hidden Key"] then
                  table.insert(SpecialItems, "Hidden Key")
                end

                if SeaIndex == 2 then
                  if Services.Workspace.Map.IceCastle.Hall.LibraryDoor:FindFirstChild("PhoeyuDoor") then
                    table.insert(SpecialItems, "Library Key")
                    IceAdmiralPassed = false
                  end
                end

                if IceAdmiralPassed then
                  table.insert(tbl, "Awakened Ice Admiral")
                end

                local sharkmanKarate = ScriptStorage.Melees["Sharkman Karate"]
                local flag8 = not sharkmanKarate

                if not sharkmanKarate then
                  flag8 = Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
                end

                SharkmanPassed = typeof(flag8) == "string"

                if typeof(flag8) ~= "string" then
                  TidePassed = true
                  table.insert(tbl, "Tide Keeper")
                else
                  table.insert(SpecialItems, "Water Key")
                end

                if ScriptStorage.Backpack.Yama then
                  table.insert(tbl, "Deandre")
                  table.insert(tbl, "Urban")
                  table.insert(tbl, "Diablo")
                elseif num then
                  if num >= 30 then
                    table.insert(tbl, "Deandre")
                    table.insert(tbl, "Urban")
                    table.insert(tbl, "Diablo")
                  end
                end

                local function fn38()
                  local tbl9 = {}

                  for _, v15 in ipairs(BossesOrder) do
                    local flag9 = true

                    for _, v16 in ipairs(tbl) do
                      if v16 == v15 then
                        flag9 = false
                      end
                    end

                    if flag9 then
                      table.insert(tbl9, v15)
                    end
                  end

                  local n7 = #tbl9

                  for i = 1, n7 - 1 do
                    for i2 = 1, n7 - i do
                      local str4 = tostring((key and tbl9[i2][key]) or tbl9[i2]):lower()
                      local str5 = tostring((key and tbl9[i2 + 1][key]) or tbl9[i2 + 1]):lower()

                      if str5 < str4 then
                        tbl9[i2], tbl9[i2 + 1] = tbl9[i2 + 1], tbl9[i2]
                      end
                    end
                  end

                  return tbl9
                end

                BossesOrder = fn38()

                if FunctionsHandler.Trevor:Get("IsCompleted") then
                  if not Storage:Get("SwanDefeated") then
                    BossesOrderLevel["Don Swan"] = 1100
                    table.insert(BossesOrder, "Don Swan")

                    if SeaIndex == 2 then
                      if ScriptStorage.PlayerData.Level > 1500 then
                        if not ScriptStorage.Enemies["Don Swan"] then
                          Hop("Hop for don swan")
                        end
                      end
                    end
                  end
                end
              end

              for _, v15 in pairs(SpecialItems) do
                if ScriptStorage.Tools[v15] then
                  if v15 ~= "Water Key" then
                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", v15)
                    return v15
                  end

                  if fn31() == "Sharkman Karate" then
                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", v15)
                    return v15
                  end
                end
              end

              if SeaIndex == 1 then
                local level = ScriptStorage.PlayerData.Level

                if level then
                  if level >= 150 then
                    if not HasLightningBolt(true) then
                      if not fn30("Electro") then
                        FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Mad Scientist Task")
                        return "Mad Scientist Task"
                      end
                    end
                  end
                end
              end

              if ScriptStorage.Tools["Red Key"] then
                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Red Key")
                return "Red Key"
              end

              if SeaIndex == 3 then
                if ScriptStorage.Tools["Fire Essence"] then
                  if not IsFireEssenceGave then
                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", "Uzoth Essence")
                    return "Uzoth Essence"
                  end
                end
              end
            end)

            FunctionsHandler.UtillyItemsActivitation:RegisterMethod("Start", function()
              if FunctionsHandler.RaidController then
                if FunctionsHandler.RaidController.Initalized then
                  if FunctionsHandler.RaidController.Methods.IsLocked then
                    if FunctionsHandler.RaidController.Methods.IsLocked:Call() then
                      return
                    end
                  end
                end
              end

              local CurrentProgressLevel = FunctionsHandler.UtillyItemsActivitation:Get("CurrentProgressLevel")

              if CurrentProgressLevel ~= "Hidden Key" then
                if CurrentProgressLevel ~= "Water Key" then
                  if CurrentProgressLevel ~= "Library Key" then
                    if CurrentProgressLevel ~= "Red Key" then
                      if CurrentProgressLevel ~= "Previous Hero" then
                        if CurrentProgressLevel ~= "Uzoth Essence" then
                          if CurrentProgressLevel ~= "Mad Scientist Task" then
                            return
                          end
                          SetTask("MainTask", "Electro - Mad Scientist Quest")
                          local v15 = fn26()

                          if v15 ~= 0 then
                            if v15 ~= 5 then
                              if v15 ~= nil then
                                if not HasLightningBolt(true) then
                                  local cframe

                                  if workspace:FindFirstChild("Map") then
                                    local sky = workspace.Map:FindFirstChild("Sky")

                                    if sky then
                                      cframe = (sky:GetPivot() + Vector3.new(0, 350, 0)) or CFrame.new(-4450, 1000, -500)
                                    else
                                      cframe = CFrame.new(-4450, 1000, -500)
                                    end
                                  else
                                    cframe = CFrame.new(-4450, 1000, -500)
                                  end

                                  local now4 = os.clock()
                                  local exitTo = nil

                                  while true do
                                    if HasLightningBolt(true) then
                                      exitTo = 1
                                    else
                                      if (os.clock() - now4) < 120 then
                                        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                        if humanoid then
                                          if humanoid.Health <= 0 then
                                            exitTo = 2
                                            break
                                          else
                                            local v16 = fn27()[1]

                                            if v16 then
                                              local position = v16.Position
                                              local n6 = v16.CFrame + Vector3.new(0, 3, 0)
                                              SetTask("MainTask", "Electro - Flying to Electric Cloud")
                                              TweenController.Create(n6, true)
                                              local now5 = os.clock()

                                              while CaculateDistance(n6) > 18 do
                                                if (os.clock() - now5) < 20 then
                                                  if not TweenController.Playing then
                                                    if CaculateDistance(n6) > 18 then
                                                      TweenController.Create(n6, true)
                                                    end
                                                  end

                                                  task.wait(0.1)
                                                  continue
                                                end

                                                break
                                              end

                                              SetTask("MainTask", "Electro - Attacking Electric Cloud")
                                              local now6 = os.clock()
                                              local now7 = nil

                                              while not HasLightningBolt(true) and ((os.clock() - now6) < 10) do
                                                local humanoid2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                                if not humanoid2 or (humanoid2.Health <= 0) then
                                                  break
                                                end

                                                if v16.Parent then
                                                  position = v16.Position
                                                end

                                                local parent = (v16.Parent and v16) or nil
                                                local cloudPieces = workspace:FindFirstChild("CloudPieces")

                                                if cloudPieces then
                                                  for _, child in ipairs(cloudPieces:GetChildren()) do
                                                    if ((child:IsA("BasePart") and child.Parent) and ((child.Position - position).Magnitude <= 180)) and not parent then
                                                      parent = child
                                                    end
                                                  end
                                                end

                                                if parent then
                                                  TweenController.Hovering = true
                                                  TweenController.HoverCFrame = CFrame.new(position + Vector3.new(0, 3, 0))

                                                  pcall(function()
                                                    FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Melee")
                                                    VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                                    task.wait(0.04)
                                                    VirtualInputMgr:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                                  end)

                                                  task.wait(0.08)
                                                  now7 = nil
                                                else
                                                  now7 = now7 or os.clock()
                                                  if (os.clock() - now7) > 1 then
                                                    break
                                                  end
                                                  task.wait(0.1)
                                                end
                                              end

                                              TweenController.Hovering = false
                                              TweenController.HoverCFrame = nil
                                              task.wait(0.2)
                                            else
                                              if CaculateDistance(cframe) > 250 then
                                                SetTask("MainTask", "Electro - Travelling to Charged Cloud Area")
                                                TweenController.Create(cframe, true)
                                              else
                                                SetTask("MainTask", "Electro - Waiting for Charged Cloud")
                                              end

                                              task.wait(0.5)
                                            end

                                            continue
                                          end
                                        else
                                          exitTo = 2
                                          break
                                        end
                                      else
                                        exitTo = 1
                                        break
                                      end
                                    end

                                    break
                                  end

                                  if exitTo ~= 1 then
                                    if exitTo == 2 then
                                      TweenController.ClearGhost()
                                      return
                                    end
                                    TweenController.ClearGhost()
                                    return
                                  end
                                end

                                if HasLightningBolt(true) then
                                  pcall(RefreshInventory)
                                end

                                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                return
                              end
                            end
                          end

                          local Electro = fn28("Electro")

                          if not Electro then
                            Electro = MeleeNPCCFrameFallbacks.Electro
                            if not Electro then
                              SetTask("SideTask", "Electro | Mad Scientist not found")
                              return
                            end
                          end

                          SetTask("MainTask", "Electro - Travelling to Mad Scientist")
                          TweenController.Create(Electro + Vector3.new(0, 5, 3))
                          local now4 = os.clock()

                          while CaculateDistance(Electro) > 8 do
                            if (os.clock() - now4) < 25 then
                              if LocalPlayer.Character then
                                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid then
                                  if humanoid.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end

                                  if not TweenController.Playing then
                                    if CaculateDistance(Electro) > 8 then
                                      TweenController.Create(Electro + Vector3.new(0, 5, 3))
                                    end
                                  end

                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end

                          if CaculateDistance(Electro) > 8 then
                            SetTask("SideTask", "Electro | Mad Scientist out of reach")
                            return
                          end
                          Remotes.CommF_:InvokeServer( "AcceptElectroQuest")
                          return
                        end

                        local dragonTalon = fn28("Dragon Talon")

                        if dragonTalon then
                          SetTask("MainTask", "Dragon Talon - Giving Fire Essence to Uzoth")
                          TweenController.Create(dragonTalon + Vector3.new(0, 5, 3))
                          local now4 = os.clock()

                          while CaculateDistance(dragonTalon) > 45 do
                            if (os.clock() - now4) < 25 then
                              if LocalPlayer.Character then
                                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid then
                                  if humanoid.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end

                                  if not TweenController.Playing then
                                    if CaculateDistance(dragonTalon) > 45 then
                                      TweenController.Create(dragonTalon + Vector3.new(0, 5, 3))
                                    end
                                  end

                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end
                        end

                        pcall(function()
                          FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Fire Essence")
                        end)

                        local ok, result = pcall(function()
                          return Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
                        end)

                        task.wait(0.5)
                        pcall(RefreshInventory)
                        warn("DragonTalon essence check ok=", ok, "response=", result)
                        local fireEssence = ScriptStorage.Tools["Fire Essence"]

                        if fireEssence then
                          if ok then
                            if result ~= nil then
                              if typeof(result) ~= "string" then
                                IsFireEssenceGave = true
                                DragonTalonNeedsFireEssence = false
                                Report("Fire Essence Used")
                              elseif not fireEssence then
                                IsFireEssenceGave = true
                                DragonTalonNeedsFireEssence = false
                                Report("Fire Essence Used")
                                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                return
                              end
                            elseif not fireEssence then
                              IsFireEssenceGave = true
                              DragonTalonNeedsFireEssence = false
                              Report("Fire Essence Used")
                              FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                              return
                            end
                          end
                        else
                          fireEssence = ScriptStorage.Backpack["Fire Essence"]

                          if fireEssence then
                            if ok then
                              if result ~= nil then
                                if typeof(result) ~= "string" then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                elseif not fireEssence then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                  return
                                end
                              elseif not fireEssence then
                                IsFireEssenceGave = true
                                DragonTalonNeedsFireEssence = false
                                Report("Fire Essence Used")
                                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                return
                              end
                            end
                          elseif LocalPlayer.Backpack then
                            fireEssence = LocalPlayer.Backpack:FindFirstChild("Fire Essence")

                            if fireEssence then
                              if ok then
                                if result ~= nil then
                                  if typeof(result) ~= "string" then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                  elseif not fireEssence then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                    return
                                  end
                                elseif not fireEssence then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                  return
                                end
                              end
                            else
                              fireEssence = LocalPlayer.Character

                              if fireEssence then
                                fireEssence = LocalPlayer.Character:FindFirstChild("Fire Essence")

                                if ok then
                                  if result ~= nil then
                                    if typeof(result) ~= "string" then
                                      IsFireEssenceGave = true
                                      DragonTalonNeedsFireEssence = false
                                      Report("Fire Essence Used")
                                    elseif not fireEssence then
                                      IsFireEssenceGave = true
                                      DragonTalonNeedsFireEssence = false
                                      Report("Fire Essence Used")
                                      FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                      return
                                    end
                                  elseif not fireEssence then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                    return
                                  end
                                end
                              elseif ok then
                                if result ~= nil then
                                  if typeof(result) ~= "string" then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                  elseif not fireEssence then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                    return
                                  end
                                elseif not fireEssence then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                  return
                                end
                              end
                            end
                          else
                            fireEssence = LocalPlayer.Character

                            if fireEssence then
                              fireEssence = LocalPlayer.Character:FindFirstChild("Fire Essence")

                              if ok then
                                if result ~= nil then
                                  if typeof(result) ~= "string" then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                  elseif not fireEssence then
                                    IsFireEssenceGave = true
                                    DragonTalonNeedsFireEssence = false
                                    Report("Fire Essence Used")
                                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                    return
                                  end
                                elseif not fireEssence then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                  return
                                end
                              end
                            elseif ok then
                              if result ~= nil then
                                if typeof(result) ~= "string" then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                elseif not fireEssence then
                                  IsFireEssenceGave = true
                                  DragonTalonNeedsFireEssence = false
                                  Report("Fire Essence Used")
                                  FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                  return
                                end
                              elseif not fireEssence then
                                IsFireEssenceGave = true
                                DragonTalonNeedsFireEssence = false
                                Report("Fire Essence Used")
                                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                                return
                              end
                            end
                          end
                        end

                        FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                        return
                      end

                      local electricClaw = fn28("Electric Claw")
                      local now4, humanoid

                      if electricClaw then
                        SetTask("MainTask", "Electric Claw - Travelling to Previous Hero")
                        TweenController.Create(electricClaw + Vector3.new(0, 5, 3))
                        now4 = os.clock()

                        while CaculateDistance(electricClaw) > 45 do
                          if (os.clock() - now4) < 25 then
                            if LocalPlayer.Character then
                              humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                              if humanoid then
                                if humanoid.Health <= 0 then
                                  TweenController.ClearGhost()
                                  return
                                end

                                if not TweenController.Playing then
                                  if CaculateDistance(electricClaw) > 45 then
                                    TweenController.Create(electricClaw + Vector3.new(0, 5, 3))
                                  end
                                end

                                task.wait(0.1)
                                continue
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            TweenController.ClearGhost()
                            return
                          end

                          break
                        end
                      else
                        electricClaw = MeleeNPCCFrameFallbacks["Electric Claw"]

                        if electricClaw then
                          SetTask("MainTask", "Electric Claw - Travelling to Previous Hero")
                          TweenController.Create(electricClaw + Vector3.new(0, 5, 3))
                          now4 = os.clock()

                          while CaculateDistance(electricClaw) > 45 do
                            if (os.clock() - now4) < 25 then
                              if LocalPlayer.Character then
                                humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid then
                                  if humanoid.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end

                                  if not TweenController.Playing then
                                    if CaculateDistance(electricClaw) > 45 then
                                      TweenController.Create(electricClaw + Vector3.new(0, 5, 3))
                                    end
                                  end

                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end
                        end
                      end

                      local v15 = fn37()
                      warn("ElectricClaw state near npc=", v15)
                      local n6, fn38, ok, result, v16, now5, humanoid2

                      if v15 == 4 then

                        fn38 = function()
                          return Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
                        end

                        ok, result = pcall(fn38)
                        warn("ElectricClaw start ok=", ok, "response=", result)
                        task.wait(0.3)
                        v16 = fn29()
                        SetTask("MainTask", "Electric Claw - Running to Mansion")

                        if v16 then
                          TweenController.Create(v16 + Vector3.new(0, 5, 0))
                        end

                        now5 = os.clock()

                        if v16 then
                          while CaculateDistance(v16) > 35 do
                            if (os.clock() - now5) < 26 then
                              if LocalPlayer.Character then
                                humanoid2 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid2 then
                                  if humanoid2.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end

                                  if not TweenController.Playing then
                                    if CaculateDistance(v16) > 35 then
                                      TweenController.Create(v16 + Vector3.new(0, 5, 0))
                                    end
                                  end

                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end
                        end

                        task.wait(0.5)
                        v15 = fn37()
                        warn("ElectricClaw state after mansion=", v15)

                        if v15 ~= 0 then
                          if v15 ~= 1 then
                            n5 = os.time() + 120
                            FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                            SetTask("MainTask", "Electric Claw quest unavailable; continuing farm")
                            return
                          end
                        end
                      elseif v15 ~= nil then
                        if v15 ~= 0 then
                          if v15 ~= 1 then
                            n5 = os.time() + 120
                            FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                            SetTask("MainTask", "Electric Claw quest unavailable; continuing farm")
                            return
                          end
                        end
                      else

                        fn38 = function()
                          return Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
                        end

                        ok, result = pcall(fn38)
                        warn("ElectricClaw start ok=", ok, "response=", result)
                        task.wait(0.3)
                        v16 = fn29()
                        SetTask("MainTask", "Electric Claw - Running to Mansion")

                        if v16 then
                          TweenController.Create(v16 + Vector3.new(0, 5, 0))
                        end

                        now5 = os.clock()

                        if v16 then
                          while CaculateDistance(v16) > 35 do
                            if (os.clock() - now5) < 26 then
                              if LocalPlayer.Character then
                                humanoid2 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                                if humanoid2 then
                                  if humanoid2.Health <= 0 then
                                    TweenController.ClearGhost()
                                    return
                                  end

                                  if not TweenController.Playing then
                                    if CaculateDistance(v16) > 35 then
                                      TweenController.Create(v16 + Vector3.new(0, 5, 0))
                                    end
                                  end

                                  task.wait(0.1)
                                  continue
                                end

                                TweenController.ClearGhost()
                                return
                              end

                              TweenController.ClearGhost()
                              return
                            end

                            break
                          end
                        end

                        task.wait(0.5)
                        v15 = fn37()
                        warn("ElectricClaw state after mansion=", v15)

                        if v15 ~= 0 then
                          if v15 ~= 1 then
                            n5 = os.time() + 120
                            FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                            SetTask("MainTask", "Electric Claw quest unavailable; continuing farm")
                            return
                          end
                        end
                      end

                      FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                      SetTask("MainTask", "Electric Claw quest completed; waiting for MeleeBuyController")
                      return
                    end

                    Remotes.CommF_:InvokeServer("CakeScientist", "Check")
                    ScriptStorage.Tools["Red Key"]:Destroy()
                    return
                  end

                  local function fn38()
                    Remotes.CommF_:InvokeServer("OpenLibrary")
                  end

                  if pcall(fn38) then
                    local map = Services.Workspace:FindFirstChild("Map")

                    if map then
                      local iceCastle = map:FindFirstChild("IceCastle")

                      if iceCastle then
                        local hall = iceCastle:FindFirstChild("Hall")

                        if hall then
                          local libraryDoor = hall:FindFirstChild("LibraryDoor")

                          if libraryDoor then
                            local phoeyuDoor = libraryDoor:FindFirstChild("PhoeyuDoor")

                            if phoeyuDoor then
                              phoeyuDoor:Destroy()
                            end
                          end
                        end
                      end
                    end

                    task.wait(0.5)
                    pcall(RefreshInventory)
                    FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                    return
                  end

                  return
                end

                FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Water Key")

                pcall(function()
                  Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
                end)

                task.wait(0.5)
                pcall(RefreshInventory)
                FunctionsHandler.UtillyItemsActivitation:Set("CurrentProgressLevel", nil)
                return
              end

              Remotes.CommF_:InvokeServer("OpenRengoku")
            end)
          end

          FunctionsHandler.Trevor:RegisterMethod("GetFruit", function()
            for _, v15 in pairs(ScriptStorage.Backpack) do
              if string.find(FruitIdToName(v15.Name), " Fruit") then
                if v15.Value then
                  if v15.Value > 1000000 then
                    if v15.Value < 2500000 then
                      return v15
                    end
                    continue
                  end
                end
              end
            end
          end)

          FunctionsHandler.Trevor:RegisterMethod("Refresh", function()
            if FunctionsHandler.Trevor:Get("IsCompleted") then
              return
            end

            if (os.time() - now3) < 1 then
              return
            end

            if ScriptStorage.PlayerData.Level < 1100 then
              return
            end
            local v15 = FunctionsHandler.Trevor.Methods.GetFruit:Call()

            if v15 then
              FunctionsHandler.Trevor:Set("Fruit", v15)
            end

            TrevorDebounce = os.time()

            if not FunctionsHandler.Trevor:Get("IsCompleted") then
              FunctionsHandler.Trevor:Set("IsCompleted", Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0)
              local commF = Remotes.CommF_
            end

            local IsCompleted = FunctionsHandler.Trevor:Get("IsCompleted")
            local flag8 = not IsCompleted
            if IsCompleted then
              return flag8
            end
            return v15
          end)

          FunctionsHandler.Trevor:RegisterMethod("Start", function()
            local Fruit = FunctionsHandler.Trevor:Get("Fruit")
            FunctionsHandler.Trevor:Set("Fruit", nil)
            table.insert(ScriptStorage.IgnoreStoreFruits, Fruit.Name)
            Remotes.CommF_:InvokeServer("LoadFruit", Fruit.Name)
            task.wait()
            FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call(FruitIdToName(Fruit.Name))
            Remotes.CommF_:InvokeServer("TalkTrevor", "1")
            Remotes.CommF_:InvokeServer("TalkTrevor", "2")
            Remotes.CommF_:InvokeServer("TalkTrevor", "3")
            task.wait(1)
            FunctionsHandler.Trevor:Set("IsCompleted", true)
          end)

          FunctionsHandler.ThirdSeaPuzzle:RegisterMethod("Refresh", function()
            if ScriptStorage.PlayerData.Level < 1500 then
              return
            end

            if SeaIndex ~= 2 then
              return
            end

            if nil == FunctionsHandler.ThirdSeaPuzzle:Get("State") then
              ZQuestProgress = Remotes.CommF_:InvokeServer("ZQuestProgress", "Check")
              FunctionsHandler.ThirdSeaPuzzle:Set("State", ZQuestProgress == 0)
            end

            return FunctionsHandler.ThirdSeaPuzzle:Get("State")
          end)

          FunctionsHandler.ThirdSeaPuzzle:RegisterMethod("Start", function()
            if FunctionsHandler.ThirdSeaPuzzle:Get("State") then
              repeat
                task.wait(1)
                Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
              until CaculateDistance(Vector3.new(0, 0, 0)) > 20000

              task.spawn(function()
                task.wait(30)
                LocalPlayer:Kick()
              end)

              while task.wait() do
                CombatController.Attack("rip_indra")
              end
            end
          end)

          FunctionsHandler.Yama:RegisterMethod("Refresh", function()
            if SeaIndex ~= 3 then
              return
            end

            if ScriptStorage.Backpack.Yama then
              return
            end

            if not FunctionsHandler.Yama:Get("EliteCount") then
              FunctionsHandler.Yama:Set("EliteCount", Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
            end

            if FunctionsHandler.Yama:Get("EliteCount") >= 30 then
              return true
            end
          end)

          FunctionsHandler.Yama:RegisterMethod("Start", function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("FakeIslands") then
              local waterfall = game:GetService("ReplicatedStorage").FakeIslands:FindFirstChild("Waterfall")

              if waterfall then
                TweenController.Create(waterfall:GetModelCFrame())
              end
            end

            local now4 = os.clock()

            while true do
              if not (workspace.Map:FindFirstChild("Waterfall") and workspace.Map.Waterfall:FindFirstChild("SealedKatana")) then
                if (os.clock() - now4) < 25 then
                  task.wait(0.1)
                  continue
                end
              end

              break
            end

            if workspace.Map:FindFirstChild("Waterfall") then
              if workspace.Map.Waterfall:FindFirstChild("SealedKatana") then
                if workspace.Map.Waterfall.SealedKatana:FindFirstChild("Hitbox") then
                  if workspace.Map.Waterfall.SealedKatana.Hitbox:FindFirstChild("ClickDetector") then
                    fireclickdetector(workspace.Map.Waterfall.SealedKatana.Hitbox.ClickDetector)
                    return
                  end
                end
              end
            end
          end)

          FunctionsHandler.PirateRaid:RegisterMethod("Refresh", function()
            local Senque = FunctionsHandler.PirateRaid:Get("Senque")

            if Senque then
              if (os.time() - Senque) >= 500 then
                return false
              end
              local enemies = workspace:FindFirstChild("Enemies")
              local flag8 = false

              if enemies then
                for _, child in ipairs(enemies:GetChildren()) do
                  local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
                  local humanoid = child:FindFirstChild("Humanoid")

                  if humanoidRootPart then
                    if humanoid then
                      if humanoid.Health > 0 then
                        if (humanoidRootPart.Position - Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875)).Magnitude <= 600 then
                          flag8 = true
                          break
                        end
                      end
                    end
                  end
                end
              end

              if (os.time() - Senque) > 25 then
                if not flag8 then
                  FunctionsHandler.PirateRaid:Set("Senque", 0)
                  return false
                end
              end

              return true
            end

            return false
          end)

          FunctionsHandler.PirateRaid:RegisterMethod("Start", function()
            SetTask("MainTask", "Pirate Raid / Defending Castle on the Sea")
            local v15 = nil

            for _, v16 in ipairs(GetMonAsSortedRange()) do
              local humanoidRootPart = v16:FindFirstChild("HumanoidRootPart")
              local humanoid = v16:FindFirstChild("Humanoid")

              if humanoidRootPart then
                if humanoid then
                  if humanoid.Health > 0 then
                    if (humanoidRootPart.Position - Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875)).Magnitude <= 600 then
                      v15 = v16
                      break
                    else
                      v15 = nil
                    end
                  else
                    v15 = nil
                  end
                else
                  v15 = nil
                end
              else
                v15 = nil
              end
            end

            if v15 then
              CombatController.Attack(v15.Name)
              return
            end

            if CaculateDistance(Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875)) > 100 then
              TweenController.Create(Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875))
              local now4 = os.clock()

              while CaculateDistance(Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875)) > 100 do
                if (os.clock() - now4) < 20 then
                  if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                    if humanoid then
                      if humanoid.Health <= 0 then
                        TweenController.ClearGhost()
                        return
                      end

                      if not TweenController.Playing then
                        if CaculateDistance(Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875)) > 100 then
                          TweenController.Create(Vector3.new(-5543.53271484375, 313.8006286621094, -2964.258544921875))
                        end
                      end

                      task.wait(0.1)
                      continue
                    end

                    TweenController.ClearGhost()
                    return
                  end

                  TweenController.ClearGhost()
                  return
                end

                break
              end
            else
              task.wait(1)
              local Senque = FunctionsHandler.PirateRaid:Get("Senque")

              if Senque then
                if (os.time() - Senque) > 25 then
                  FunctionsHandler.PirateRaid:Set("Senque", 0)
                end

                return
              end
            end
          end)

          CheckFullMoon = function(arg)
            if Lighting.Sky.MoonTextureId ~= "http://www.roblox.com/asset/?id=9709149431" then
              return
            end

            if arg then
              return true
            end
            local flag8 = Lighting.ClockTime > 18
            if flag8 then
              return flag8
            end
            return Lighting.ClockTime < 5
          end

          FunctionsHandler.SoulGuitar:RegisterMethod("Refresh", function()
            if Config.SoulGuitar then
              if ScriptStorage.PlayerData.Level < MaxLevel then
                return
              end

              if not ScriptStorage.MeleesOwned.Godhuman then
                if not ScriptStorage.Backpack.Godhuman then
                  if not ScriptStorage.Tools.Godhuman then
                    local godhuman = ScriptStorage.Melees.Godhuman
                    if not godhuman then
                      return
                    end

                    if godhuman <= 0 then
                      return
                    end
                  end
                end
              end

              if ScriptStorage.Backpack["Skull Guitar"] then
                return
              end

              if ScriptStorage.PlayerData.Level < 2300 then
                return
              end
              local count = (ScriptStorage.Backpack.Ectoplasm or {Count = 0}).Count
              local count2 = (ScriptStorage.Backpack.Bones or {Count = 0}).Count
              if count < 250 then
                return 1
              end

              if ScriptStorage.Backpack["Dark Fragment"] then
                if SeaIndex ~= 3 then
                  return
                end
                SoulGuitarProcess = Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")

                if SoulGuitarProcess then
                  if SoulGuitarProcess.Swamp then
                    if SoulGuitarProcess.Gravestones then
                      if SoulGuitarProcess.Ghost then
                        if SoulGuitarProcess.Trophies then
                          if SoulGuitarProcess.Pipes then
                            if count2 >= 500 then
                              if not ScriptStorage.Backpack["Skull Guitar"] then
                                return 8
                              end
                            end

                            return
                          end

                          return 6
                        end

                        return 5
                      end

                      return 4
                    end

                    return 3
                  end

                  return 2
                end

                Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
                if CheckFullMoon() then
                  return 7
                end
                SetTask("MainTask", "Hopping for full moon ( soul guitar )")
                Hop("Moon")
                return 7
              end

              return 9
            end
          end)

          FunctionsHandler.SoulGuitar:RegisterMethod("Start", function(arg)
            if arg ~= 7 then
              if arg ~= 1 then
                if arg ~= 9 then
                  if arg ~= 2 then
                    if arg == 3 then
                      local hauntedCastle_ = workspace.Map["Haunted Castle"]
                      local cframe = CFrame.new(-8800, 178, 6033)
                      SetTask("MainTask", "Soul Guitar task 2 / 5: completing placards")
                      TweenController.Create(cframe)
                      local now4 = os.clock()

                      while CaculateDistance(cframe) > 10 do
                        if (os.clock() - now4) < 20 then
                          task.wait(0.1)
                          continue
                        end
                        break
                      end

                      for k, child in pairs(hauntedCastle_:GetChildren()) do
                        fireclickdetector(hauntedCastle_[k][child].ClickDetector)
                      end
                    elseif arg ~= 4 then
                      if arg ~= 5 then
                        if arg ~= 6 then
                          if arg == 8 then
                            Remotes.CommF_:InvokeServer("soulGuitarBuy")
                          end
                        else
                          for k, v15 in pairs(Pipes) do
                            pcall(function()
                              local v16 = workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[k]

                              if v16.BrickColor.Name ~= v15 then
                                repeat
                                  task.wait()
                                  fireclickdetector(v16.ClickDetector)
                                until v16.BrickColor.Name == v15

                                return
                              end
                            end)
                          end

                          Remotes.CommF_:InvokeServer("soulGuitarBuy")
                        end
                      elseif CaculateDistance(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375)) > 30 then
                        TweenController.Create(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375))
                      else
                        local tablet = workspace.Map["Haunted Castle"].Tablet
                        local v15

                        for _, v16 in pairs(BlankTablets) do
                          local exitTo = nil

                          while true do
                            v15 = tablet[v16]
                            if v15.Line.Rotation.Z ~= 0 then
                              exitTo = 1
                              break
                            end
                          end

                          if exitTo == 1 then
                            repeat
                              task.wait()
                              fireclickdetector(v15.ClickDetector)
                            until v15.Line.Rotation.Z == 0

                            continue
                          end

                          break
                        end

                        for k, v16 in pairs(Trophy) do
                          local v17 = tostring(workspace.Map["Haunted Castle"].Trophies.Quest[v16].Handle.CFrame):split(", ")[4]
                          local str4

                          if v17 ~= "1" then
                            str4 = "180"

                            if v17 == "-1" then
                              str4 = "90"
                            end
                          else
                            str4 = "90"
                          end

                          if not string.find(tostring(tablet[k].Line.Rotation.Z), str4) then
                            repeat
                              task.wait()
                              fireclickdetector(tablet[k].ClickDetector)
                            until string.find(tostring(tablet[k].Line.Rotation.Z), str4)
                          end
                        end
                      end
                    else
                      Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
                    end

                    return
                  end

                  TTL9 = TTL9 or 0
                  local v15 = LastestTime1

                  if os.time() ~= v15 then
                    TTL9 = TTL9 + 1
                    LastestTime1 = os.time()
                  end

                  if TTL9 > 60 then
                    return Hop("LOMGGGGGGGG SG 1")
                  end
                  local tbl = {}

                  for _, v16 in Services.Workspace.Enemies:GetChildren() do
                    if v16.name == "Living Zombie" then
                      table.insert(tbl, v16)
                    end
                  end

                  if #tbl < 6 then
                    SetTask("MainTask", "Soul Guitar task 1 / 5: waiting until entity spawn")
                    TweenController.Create(ScriptStorage.MobRegions["Living Zombie"][1] + Vector3.new(0, 30, 0))
                    return
                  end

                  local now4 = os.time()

                  for k, v16 in pairs(tbl) do
                    while task.wait() do
                      if v16.Humanoid.Health > 7000 then
                        SetTask("MainTask", "Soul Guitar task 1 / 5: Hit mob " .. (k .. " / 6"))
                        FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Melee")

                        if (os.time() - now4) > 60 then
                          Hop("So long nerds")
                        end

                        TweenController.Create(v16.HumanoidRootPart.CFrame + Vector3.new(0, 50, 0))
                        FastAttack:Attack()
                        continue
                      end

                      break
                    end
                  end

                  SetTask("MainTask", "Soul Guitar task 1 / 5: Attack")

                  while workspace.Enemies:FindFirstChild("Living Zombie") do
                    if task.wait() then
                      if (os.time() - now4) > 60 then
                        Hop("So long nerds")
                      end

                      CombatController.Attack("Living Zombie")
                      continue
                    end

                    break
                  end

                  return
                end

                if SeaIndex ~= 2 then
                  SetTask("MainTask", "Teleport to second sea to farm ectoplasm")
                  return Remotes.CommF_:InvokeServer("TravelDressrosa")
                end
                SetTask("MainTask", "Sea 2 | Get DarkFragments")
                return
              end

              if SeaIndex ~= 2 then
                SetTask("MainTask", "Teleport to second sea to farm ectoplasm")
                return Remotes.CommF_:InvokeServer("TravelDressrosa")
              end
              SetTask("MainTask", "Farming ectoplasms for soul guitar")
              CombatController.Attack({"Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"})
              return
            end

            local cframe = CFrame.new(-8654, 140, 6167)
            TweenController.Create(cframe)
            local now4 = os.clock()

            while CaculateDistance(cframe) > 5 do
              if (os.clock() - now4) < 20 then
                task.wait(0.1)
                continue
              end
              break
            end

            SoulGuitarProcess = Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
          end)

          FunctionsHandler.Tushita:RegisterMethod("Refresh", function()
            if ScriptStorage.Backpack.Tushita then
              return
            end

            if ScriptStorage.PlayerData.Level < 2000 then
              return
            end

            if SeaIndex ~= 3 then
              return
            end
            TushitaProgress = TushitaProgress or Remotes.CommF_:InvokeServer("TushitaProgress")

            if TushitaProgress.OpenedDoor then
              if ScriptStorage.Enemies.Longma then
                TushitaProgress = nil
                return 2
              end
            elseif ScriptStorage.Enemies["rip_indra True Form"] then
              TushitaProgress = nil
              return 1
            end
          end)

          FunctionsHandler.Tushita:RegisterMethod("Start", function(arg)
            if arg ~= 1 then
              if arg ~= 2 then
                return
              end
              CombatController.Attack("Longma")
              return
            end

            if ScriptStorage.Tools["Holy Torch"] then
              local questTorches = workspace.Map.Turtle.QuestTorches

              for i = 1, 5 do
                local v15 = questTorches:FindFirstChild("Torch" .. i)

                if v15 then
                  TweenController.Create(v15.CFrame)
                  local now4 = os.clock()

                  while v15.Parent do
                    if not ((v15:FindFirstChild("Particles") and v15.Particles:FindFirstChild("Main")) and v15.Particles.Main.Enabled) then
                      if (os.clock() - now4) < 15 then
                        task.wait(0.1)
                        continue
                      end
                    end

                    break
                  end
                end
              end

              return
            end

            FunctionsHandler.LocalPlayerController.Methods.EquipTool:Call("Holy Torch")
            if TweenController.Playing then
              return
            end
            TweenController.Create(CFrame.new(5714, 20, 256))
          end)

          FunctionsHandler.CursedDualKatana:RegisterMethod("Refresh", function()
            if Config.CursedDualKatana then
              if ScriptStorage.PlayerData.Level < MaxLevel then
                return
              end

              if not ScriptStorage.MeleesOwned.Godhuman then
                if not ScriptStorage.Backpack.Godhuman then
                  if not ScriptStorage.Tools.Godhuman then
                    local godhuman = ScriptStorage.Melees.Godhuman
                    if not godhuman then
                      return
                    end

                    if godhuman <= 0 then
                      return
                    end
                  end
                end
              end

              local backpack = ScriptStorage.Backpack
              if ScriptStorage.PlayerData.Level < 2200 then
                return
              end

              if backpack["Cursed Dual Katana"] then
                return
              end

              if backpack.Tushita then
                if backpack.Tushita.Mastery < 350 then
                  return
                end

                if backpack.Yama then
                  if backpack.Yama.Mastery < 350 then
                    return
                  end

                  if SeaIndex ~= 3 then
                    return
                  end
                  local response = (CdkProgess or Remotes.CommF_:InvokeServer("CDKQuest", "Progress")) or "uwu"

                  if response ~= "uwu" then
                    if workspace.Map.Turtle.Cursed:FindFirstChild("Breakable") then
                      return {"break"}
                    end
                    local tbl = {Good = "Tushita", Evil = "Yama"}

                    if response.Good == 4 then
                      if response.Evil == 4 then
                        return {"burn 2"}
                      end
                    end

                    if response.Good ~= 3 then
                      if response.Evil ~= 3 then
                        if response.Opened then
                          for k, v15 in pairs(response) do
                            local exitTo = nil

                            if k ~= "Opened" and k ~= "Finished" then

                              if v15 < 3 then
                                ScriptStorage.CdkCache = {k, v15 + 1}

                                if not ScriptStorage.Tools[tbl[k]] then
                                  Remotes.CommF_:InvokeServer("LoadItem", tbl[k])
                                end

                                Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", k)
                                SetTask("MainTask", "Cursed Dual Katana - " .. (tostring(tbl[k]) .. (" " .. tostring(k))))
                                return false
                              end

                              continue
                            end

                            break
                          end
                        end

                        local cdkCache = ScriptStorage.CdkCache

                        if cdkCache then
                          local v15 = cdkCache[1]
                          local v16 = cdkCache[2]

                          if v15 ~= "Evil" then
                            if v15 == "Good" then
                              if v16 == 2 then
                                SetTask("SideTask", "CDK Quest / Waiting until pirate raid started")
                                return
                              end

                              if v16 == 3 then
                                if not ScriptStorage.Enemies["Cake Queen"] then
                                  Hop("Cake Queen Find")
                                  SetTask("SideTask", "CDK Quest / Waiting until Cake Queen boss spawned")
                                  return
                                end
                              end
                            end
                          elseif v16 ~= 3 then
                            if v15 == "Good" then
                              if v16 == 2 then
                                SetTask("SideTask", "CDK Quest / Waiting until pirate raid started")
                                return
                              end

                              if v16 == 3 then
                                if not ScriptStorage.Enemies["Cake Queen"] then
                                  Hop("Cake Queen Find")
                                  SetTask("SideTask", "CDK Quest / Waiting until Cake Queen boss spawned")
                                  return
                                end
                              end
                            end
                          elseif not ScriptStorage.Enemies["Soul Reaper"] then
                            ForceToRollBone = true
                            return
                          end

                          return cdkCache
                        end

                        return
                      end
                    end

                    return {"burn"}
                  end

                  return
                end

                return
              end

              return
            end
          end)

          FunctionsHandler.CursedDualKatana:RegisterMethod("GetHazeMon", function()
            local tbl = {}

            for _, v15 in LocalPlayer.QuestHaze:GetChildren() do
              if v15.Value > 0 then
                table.insert(tbl, v15)
              end
            end

            table.sort(tbl, function(arg, arg2)
              return CaculateDistance(arg:GetAttribute("Position")) < CaculateDistance(arg2:GetAttribute("Position"))
            end)

            return tostring(tbl[1])
          end)

          do
            local cursedDualKatana = FunctionsHandler.CursedDualKatana
            local registerMethod = cursedDualKatana.RegisterMethod

            local function fn37(arg)
              local v15 = string.gsub(arg, " ", "")
              local now4 = os.time()

              while true do
                local v16 = TorchEnabledTime

                if (os.time() - v16) >= 10 then
                  if (os.time() - now4) <= 60 then
                    task.wait(0.2)
                    continue
                  end
                end

                break
              end

              while true do
                task.wait()
                local v16 = workspace.Map:WaitForChild(v15, 10)

                if v16 then
                  for _, v17 in v16:GetChildren() do
                    if v17 then
                      if string.find(v17.Name, "Torch") then
                        if v17:FindFirstChild("ProximityPrompt") then
                          if v17.ProximityPrompt.Enabled then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = v17.CFrame
                            v17.ProximityPrompt.HoldDuration = 0
                            task.wait(1)
                            local VirtualInputManager = game:GetService("VirtualInputManager")
                            VirtualInputManager:SendKeyEvent(true, "E", 0, game)
                            VirtualInputManager:SendKeyEvent(false, "E", 0, game)
                            fireproximityprompt(workspace.Map:WaitForChild(v15, 10):FindFirstChild(tostring(v17)).ProximityPrompt)
                          end
                        end
                      end
                    end

                    for _, v18 in workspace.Enemies:GetChildren() do
                      local humanoidRootPart = v18:FindFirstChild("HumanoidRootPart")
                      local humanoid = v18:FindFirstChild("Humanoid")

                      if humanoidRootPart then
                        if humanoid then
                          if CaculateDistance(humanoidRootPart.CFrame) < 1000 then
                            CombatController.Attack(v18.Name)
                          end
                        end
                      end
                    end
                  end

                  ExitDoor = v16:FindFirstChild("Exit")

                  if ExitDoor then
                    PortalBrick = tostring(ExitDoor.BrickColor)
                  end
                else
                end

                if PortalBrick ~= "Olivine" then
                  if PortalBrick ~= "Cloudy grey" then
                    continue
                  end
                end

                break
              end

              if ExitDoor then
                TweenController.Create(ExitDoor.CFrame + Vector3.new(0, 3, 0))
              end

              while true do
                local v16 = DoneCdkTick

                if (os.time() - v16) > 15 then
                  task.wait(0.2)
                else
                  break
                end
              end

              Hop("Rejoin")
            end

            registerMethod(cursedDualKatana, "DoDimension", fn37)
          end

          FunctionsHandler.CursedDualKatana:RegisterMethod("Start", function(arg)
            if arg[1] ~= "break" then
              if arg[1] ~= "burn 2" then
                if arg[1] ~= "burn" then
                  if arg[1] ~= "Evil" then
                    if arg[2] ~= 1 then
                      if arg[2] ~= 3 then
                        return
                      end

                      while true do
                        task.wait()
                        CombatController.Attack("Cake Queen")
                        local v15 = TorchEnabledTime

                        if (os.time() - v15) < 10 then
                          break
                        elseif not ScriptStorage.Enemies["Cake Queen"] then
                          break
                        end
                      end

                      TweenController.Create(LocalPlayer.Character.HumanoidRootPart.CFrame)
                      Report("Cake Queen")
                      FunctionsHandler.CursedDualKatana.Methods.DoDimension.Callback("Heavenly Dimension")
                      CdkProgess = nil
                      return
                    end

                    for _, v15 in game.ReplicatedStorage.NPCs:GetChildren() do
                      if v15.Name == "Luxury Boat Dealer" then
                        while true do
                          task.wait()
                          local v16 = DoneCdkTick

                          if (os.time() - v16) < 15 then
                            return
                          else
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v15:GetModelCFrame()
                            RealNPC = nil

                            for _, v17 in workspace.NPCs:GetChildren() do
                              local getModelCFrame = v15.GetModelCFrame
                              if CaculateDistance(v17:GetModelCFrame(), getModelCFrame(v15)) < 20 then
                                RealNPC = v17
                                break
                              end
                            end

                            if CaculateDistance(v15:GetModelCFrame()) < 5 then
                              if RealNPC then
                                break
                              end
                            end
                          end
                        end

                        Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", RealNPC)
                        CdkProgess = nil
                        return
                      end
                    end

                    CdkProgess = nil
                    return
                  end

                  if arg[2] ~= 1 then
                    if arg[2] ~= 2 then
                      if arg[2] == 3 then
                        Report("found cdk yama 3")
                        local soulReaper = ScriptStorage.Enemies["Soul Reaper"]

                        if soulReaper then
                          TweenController.Create(soulReaper:GetModelCFrame())
                        end

                        local now4 = os.clock()

                        if soulReaper then
                          while soulReaper.Parent do
                            local v15 = TorchEnabledTime

                            if (os.time() - v15) >= 100 then
                              if (os.clock() - now4) < 30 then
                                if FunctionsHandler.RaidController.Methods.GetCurrentRaidIsland:Call() then
                                  pcall(function()
                                    LocalPlayer.Character.Humanoid.Health = 0
                                  end)
                                end

                                task.wait(0.1)
                                continue
                              end
                            end

                            break
                          end
                        end

                        if not ScriptStorage.Enemies["Soul Reaper"] then
                          return
                        end
                        FunctionsHandler.CursedDualKatana.Methods.DoDimension.Callback("Hell Dimension")
                        CdkProgess = nil
                      end
                    else
                      CombatController.Attack(FunctionsHandler.CursedDualKatana.Methods.GetHazeMon:Call())
                      CdkProgess = nil
                    end
                  else
                    local forestPirate = ScriptStorage.Enemies["Forest Pirate"]
                    local create = TweenController.Create
                    local cFrame

                    if forestPirate then
                      cFrame = forestPirate.HumanoidRootPart.CFrame or ScriptStorage.MobRegions["Forest Pirate"][0]
                    else
                      cFrame = ScriptStorage.MobRegions["Forest Pirate"][0]
                      create(cFrame)
                      CdkProgess = nil
                      return
                    end

                    create(cFrame)
                    CdkProgess = nil
                  end

                  return
                end

                for i = 1, 3 do
                  local v15 = workspace.Map.Turtle.Cursed:FindFirstChild("Pedestal" .. i)

                  if v15 then
                    if v15:FindFirstChild("ProximityPrompt") then
                      if v15.ProximityPrompt.Enabled then
                        TweenController.Create(v15.CFrame)
                        local now4 = os.clock()

                        while CaculateDistance(v15.CFrame) >= 5 do
                          if (os.clock() - now4) < 15 then
                            task.wait(0.1)
                            continue
                          end
                          break
                        end

                        fireproximityprompt(v15.ProximityPrompt)
                        task.wait(3)

                        local function fn37()
                          local character = LocalPlayer.Character
                          character.Humanoid.Health = 0
                        end

                        pcall(fn37)
                      end
                    end
                  end

                  CdkProgess = nil
                end

                return
              end

              if workspace.Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled then
                fireproximityprompt(workspace.Map.Turtle.Cursed.Pedestal3.ProximityPrompt)
                task.wait(1)

                pcall(function()
                  LocalPlayer.Character.Humanoid.Health = 0
                end)

                task.wait(10)
                return
              end

              CDKAttempts = (CDKAttempts or 0) + 1
              TweenController.Create(CFrame.new(-12341.66796875, 603.3455810546875, -6550.6064453125))
              task.wait(5)

              pcall(function()
                LocalPlayer.Character.Humanoid.Health = 0
              end)

              task.wait(5)

              if CDKAttempts > 5 then
                Hop("CDK Stuck")
              end

              CdkProgess = nil
              return
            end

            TweenController.Create(workspace.Map.Turtle.Cursed.Breakable.CFrame)
            Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
            Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
            workspace.Map.Turtle.Cursed.Breakable:Destroy()
            CdkProgess = nil
          end)

          do
            local tbl9 = {Listeners = {}}
            TorchEnabledTime = 0
            DoneCdkTick = 0

            local function notificationCallBack(arg)
              for k, v15 in pairs(tbl9.Listeners) do
                if string.find(string.lower(arg), string.lower(k)) then
                  v15(arg)
                end
              end
            end

            getgenv().NotificationCallBack = notificationCallBack

            tbl9.RegisterNotifyListener = function(arg, arg2, arg3)
              tbl9.Listeners[arg2] = arg3
            end

            tbl9:RegisterNotifyListener("go!", function()
              LastRaidAlert = os.time()
            end)

            tbl9:RegisterNotifyListener("raid", function()
              LastRaidAlert2 = os.time()
            end)

            tbl9:RegisterNotifyListener("been spotted approaching", function()
              FunctionsHandler.PirateRaid:Set("Senque", os.time())
            end)

            tbl9:RegisterNotifyListener("job", function()
              FunctionsHandler.PirateRaid:Set("Senque", 0)
            end)

            tbl9:RegisterNotifyListener("level", function()
              AddPoint()
            end)

            tbl9:RegisterNotifyListener("torch", function()
              TorchEnabledTime = os.time()
            end)

            tbl9:RegisterNotifyListener("scroll reacts", function()
              DoneCdkTick = os.time()
            end)

            tbl9:RegisterNotifyListener("elite", function()
              FunctionsHandler.Yama:Set("EliteCount", Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
            end)

            tbl9:RegisterNotifyListener("the raid with", function()
              stopTween(false)
              TweenController.Hovering = false
              TweenController.HoverCFrame = nil
              fn36()
              if ScriptStorage.PlayerData.Level < MaxLevel then
                return
              end
              Remotes.CommF_:InvokeServer("Awakener", "Awaken")
            end)

            tbl9:RegisterNotifyListener("quest completed", function()
              QuestController:RefreshQuest()
              task.wait()
              if QuestController:GetCurrentClaimQuest() then
                return
              end
              QuestController:MarkAsCompleted()
            end)

            local v15 = nil

            v15 = hookfunction(require(game.ReplicatedStorage.Notification).new, function(arg, arg2)
              local v16 = tostring(tostring(arg or "") .. tostring(arg2 or ""))
              getgenv().NotificationCallBack(v16)
              return v15(arg, arg2)
            end)

            IfTableHaveIndex = function(tbl)
              return (type(tbl) == "table") and (next(tbl) ~= nil)
            end

            GetServers = function()
              if LastServersDataPulled then
                local v16 = LastServersDataPulled
                if (os.time() - v16) < 60 then
                  return CachedServers
                end
              end

              for i = 1, 100 do
                local response = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer(i)

                if IfTableHaveIndex(response) then
                  LastServersDataPulled = os.time()
                  CachedServers = response
                  return response
                end
              end
            end

            spawn(function()
              GetServers()

              while task.wait(180) do
                GetServers()
              end
            end)

            Hop = function(arg, arg2)
              if type(arg) == "string" then
                arg = nil
              end

              local v16 = GetServers()
              if type(v16) ~= "table" then
                return
              end
              local tbl = {}

              for k, v17 in pairs(v16) do
                if type(v17) == "table" then
                  table.insert(tbl, {JobId = k, Players = tonumber(v17.Count) or 0, LastUpdate = v17.__LastUpdate, Region = v17.Region})
                end
              end

              if #tbl ~= 0 then
                local v17 = nil

                for _ = 1, math.min(120, #tbl * 2) do
                  local v18 = tbl[math.random(1, #tbl)]

                  if v18 then
                    local flag8 = (not arg) or (v18.Players < arg)
                    local flag9 = (not arg2) or (v18.Region == arg2)
                    if flag8 and flag9 then
                      v17 = v18
                      break
                    end
                  end

                  task.wait()
                end

                if v17 then

                  pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer("teleport", v17.JobId)
                  end)

                  return
                end

                return
              end
            end

            if Config.BlockAcc then
              local name2 = "ChuoiCon"
              local n5 = 0
              local n6 = 0
              local userId2 = LocalPlayer.UserId

              pcall(function()
                if isfolder("MosHubKaitun/BlockAcc") then
                  return
                end
                makefolder("MosHubKaitun/BlockAcc")
              end)

              local function fn37()
                local character, chuoiCon, humanoidRootPart, bananaCatBlockAccWeld
                character = LocalPlayer.Character

                if not character then
                  character = workspace:FindFirstChild("Characters")

                  if character then
                    character = workspace.Characters:FindFirstChild(LocalPlayer.Name)
                    if not character then
                      return
                    end
                    chuoiCon = character:FindFirstChild("ChuoiCon")

                    if chuoiCon then
                      if chuoiCon:IsA("BasePart") then
                        chuoiCon:SetAttribute("BananaCatBlockAcc", true)
                        chuoiCon:SetAttribute("UserId", userId2)
                        chuoiCon:SetAttribute("UserName", LocalPlayer.Name)
                        chuoiCon:SetAttribute("JobId", game.JobId)
                        chuoiCon:SetAttribute("UpdatedAt", os.time())
                        humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                        if humanoidRootPart then
                          chuoiCon.CFrame = humanoidRootPart.CFrame
                          bananaCatBlockAccWeld = chuoiCon:FindFirstChild("BananaCatBlockAccWeld")

                          if bananaCatBlockAccWeld then
                            if (bananaCatBlockAccWeld.Part0 ~= humanoidRootPart) or (bananaCatBlockAccWeld.Part1 ~= chuoiCon) then
                              bananaCatBlockAccWeld.Part0 = humanoidRootPart
                              bananaCatBlockAccWeld.Part1 = chuoiCon
                            end
                          else
                            local weldConstraint = Instance.new("WeldConstraint")
                            weldConstraint.Name = "BananaCatBlockAccWeld"
                            weldConstraint.Part0 = humanoidRootPart
                            weldConstraint.Part1 = chuoiCon
                            weldConstraint.Parent = chuoiCon
                          end
                        end

                        return
                      end

                      chuoiCon:Destroy()
                    end

                    chuoiCon = Instance.new("Part")
                    chuoiCon.Name = name2
                    chuoiCon.Size = Vector3.new(0.15, 0.15, 0.15)
                    chuoiCon.Transparency = 1
                    chuoiCon.Anchored = false
                    chuoiCon.CanCollide = false
                    chuoiCon.CanTouch = false
                    chuoiCon.CanQuery = false
                    chuoiCon.Massless = true
                    chuoiCon.Parent = character
                    chuoiCon:SetAttribute("BananaCatBlockAcc", true)
                    chuoiCon:SetAttribute("UserId", userId2)
                    chuoiCon:SetAttribute("UserName", LocalPlayer.Name)
                    chuoiCon:SetAttribute("JobId", game.JobId)
                    chuoiCon:SetAttribute("UpdatedAt", os.time())
                    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      chuoiCon.CFrame = humanoidRootPart.CFrame
                      bananaCatBlockAccWeld = chuoiCon:FindFirstChild("BananaCatBlockAccWeld")

                      if bananaCatBlockAccWeld then
                        if (bananaCatBlockAccWeld.Part0 ~= humanoidRootPart) or (bananaCatBlockAccWeld.Part1 ~= chuoiCon) then
                          bananaCatBlockAccWeld.Part0 = humanoidRootPart
                          bananaCatBlockAccWeld.Part1 = chuoiCon
                        end
                      else
                        local weldConstraint = Instance.new("WeldConstraint")
                        weldConstraint.Name = "BananaCatBlockAccWeld"
                        weldConstraint.Part0 = humanoidRootPart
                        weldConstraint.Part1 = chuoiCon
                        weldConstraint.Parent = chuoiCon
                      end
                    end

                    return
                  end
                end

                if not character then
                  return
                end
                chuoiCon = character:FindFirstChild("ChuoiCon")

                if chuoiCon then
                  if chuoiCon:IsA("BasePart") then
                    chuoiCon:SetAttribute("BananaCatBlockAcc", true)
                    chuoiCon:SetAttribute("UserId", userId2)
                    chuoiCon:SetAttribute("UserName", LocalPlayer.Name)
                    chuoiCon:SetAttribute("JobId", game.JobId)
                    chuoiCon:SetAttribute("UpdatedAt", os.time())
                    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                      chuoiCon.CFrame = humanoidRootPart.CFrame
                      bananaCatBlockAccWeld = chuoiCon:FindFirstChild("BananaCatBlockAccWeld")

                      if bananaCatBlockAccWeld then
                        if (bananaCatBlockAccWeld.Part0 ~= humanoidRootPart) or (bananaCatBlockAccWeld.Part1 ~= chuoiCon) then
                          bananaCatBlockAccWeld.Part0 = humanoidRootPart
                          bananaCatBlockAccWeld.Part1 = chuoiCon
                        end
                      else
                        local weldConstraint = Instance.new("WeldConstraint")
                        weldConstraint.Name = "BananaCatBlockAccWeld"
                        weldConstraint.Part0 = humanoidRootPart
                        weldConstraint.Part1 = chuoiCon
                        weldConstraint.Parent = chuoiCon
                      end
                    end

                    return
                  end

                  chuoiCon:Destroy()
                end

                chuoiCon = Instance.new("Part")
                chuoiCon.Name = name2
                chuoiCon.Size = Vector3.new(0.15, 0.15, 0.15)
                chuoiCon.Transparency = 1
                chuoiCon.Anchored = false
                chuoiCon.CanCollide = false
                chuoiCon.CanTouch = false
                chuoiCon.CanQuery = false
                chuoiCon.Massless = true
                chuoiCon.Parent = character
                chuoiCon:SetAttribute("BananaCatBlockAcc", true)
                chuoiCon:SetAttribute("UserId", userId2)
                chuoiCon:SetAttribute("UserName", LocalPlayer.Name)
                chuoiCon:SetAttribute("JobId", game.JobId)
                chuoiCon:SetAttribute("UpdatedAt", os.time())
                humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                  chuoiCon.CFrame = humanoidRootPart.CFrame
                  bananaCatBlockAccWeld = chuoiCon:FindFirstChild("BananaCatBlockAccWeld")

                  if bananaCatBlockAccWeld then
                    if (bananaCatBlockAccWeld.Part0 ~= humanoidRootPart) or (bananaCatBlockAccWeld.Part1 ~= chuoiCon) then
                      bananaCatBlockAccWeld.Part0 = humanoidRootPart
                      bananaCatBlockAccWeld.Part1 = chuoiCon
                    end
                  else
                    local weldConstraint = Instance.new("WeldConstraint")
                    weldConstraint.Name = "BananaCatBlockAccWeld"
                    weldConstraint.Part0 = humanoidRootPart
                    weldConstraint.Part1 = chuoiCon
                    weldConstraint.Parent = chuoiCon
                  end
                end

                return
              end

              local function fn38()
                pcall(function()
                  local now4 = os.time()
                  local tbl = {}

                  if isfile("MosHubKaitun/BlockAcc/servers.json") then
                    local ok, result = pcall(function()
                      return Services.HttpService:JSONDecode(readfile("MosHubKaitun/BlockAcc/servers.json"))
                    end)

                    if ok then
                      if type(result) == "table" then
                        tbl = result
                      end
                    end
                  end

                  local accounts = ((type(tbl.Accounts) ~= "table") and {}) or (tbl.Accounts or {})

                  for k, account in pairs(accounts) do
                    if type(account) ~= "table" then
                      accounts[k] = nil
                    else
                      if (now4 - (tonumber(account.UpdatedAt) or 0)) > 25 then
                        accounts[k] = nil
                      end
                    end
                  end

                  local tbl10 = {UserId = userId2, UserName = LocalPlayer.Name, JobId = game.JobId, PlaceId = game.PlaceId, UpdatedAt = now4}
                  accounts[tostring(userId2)] = tbl10
                  writefile("MosHubKaitun/BlockAcc/servers.json", Services.HttpService:JSONEncode({UpdatedAt = now4, Accounts = accounts}))
                end)
              end

              local function fn39()
                pcall(function()
                  if isfile("MosHubKaitun/BlockAcc/servers.json") then
                    local ok, result = pcall(function()
                      return Services.HttpService:JSONDecode(readfile("MosHubKaitun/BlockAcc/servers.json"))
                    end)

                    if ok then
                      if type(result) == "table" then
                        if type(result.Accounts) == "table" then
                          result.Accounts[tostring(userId2)] = nil
                          writefile("MosHubKaitun/BlockAcc/servers.json", Services.HttpService:JSONEncode(result))
                          return
                        end
                      end
                    end
                  end
                end)
              end

              local function fn40()
                local num, num2

                for _, player in ipairs(Services.Players:GetPlayers()) do
                  local exitTo = nil

                  if player ~= LocalPlayer then
                    if player.Character then
                      local chuoiCon = player.Character:FindFirstChild("ChuoiCon")

                      if chuoiCon then
                        if chuoiCon:GetAttribute("BananaCatBlockAcc") == true then
                          num = tonumber(chuoiCon:GetAttribute("UserId"))
                          num2 = tonumber(chuoiCon:GetAttribute("UpdatedAt"))

                          if not num2 then
                            num2 = 0
                          end

                          if num then
                            if num ~= userId2 then
                              if (os.time() - num2) <= 25 then
                                if num < userId2 then
                                  return true
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end

                  if exitTo == 1 then
                    break
                  end

                  if exitTo == 2 then
                    if (os.time() - num2) <= 25 then
                      if num < userId2 then
                        return true
                      end
                    end
                  end
                end

                return false
              end

              local function fn41()
                local flag8 = false

                pcall(function()
                  if isfile("MosHubKaitun/BlockAcc/servers.json") then
                    local ok, result = pcall(function()
                      return Services.HttpService:JSONDecode(readfile("MosHubKaitun/BlockAcc/servers.json"))
                    end)

                    if ok then
                      if type(result) == "table" then
                        if type(result.Accounts) == "table" then
                          local now4 = os.time()
                          local num

                          for _, account in pairs(result.Accounts) do
                            local exitTo = nil

                            if type(account) == "table" then
                              num = tonumber(account.UserId)
                              if num and (num ~= userId2) then
                                exitTo = 1
                              end
                            end

                            if exitTo == 1 then
                              if account.JobId ~= game.JobId then
                                continue
                              end

                              if account.PlaceId ~= game.PlaceId then
                                continue
                              end

                              if (now4 - (tonumber(account.UpdatedAt) or 0)) <= 25 then
                                if num < userId2 then
                                  flag8 = true
                                  return
                                end
                                continue
                              end

                              continue
                            end

                            if exitTo == 2 then
                              break
                            end
                          end

                          return
                        end
                      end
                    end
                  end
                end)

                return flag8
              end

              task.spawn(function()
                while task.wait(4) do
                  pcall(function()
                    fn37()
                    fn38()
                  end)
                end
              end)

              task.spawn(function()
                while task.wait(4) do
                  local flag8 = false

                  pcall(function()
                    flag8 = fn40() or fn41()
                    if flag8 then
                      n5 += 1
                      return
                    end
                    n5 = 0
                  end)

                  if flag8 and (n5 >= 2) and ((os.time() - n6) > 20) then
                    n6 = os.time()
                    SetTask("MainTask", "Hop Server - BlockAcc detected duplicate account (yielding to lower UserId)")
                    fn39()
                    Hop(8)
                    task.wait(8)
                  end
                end
              end)
            end

            Storage = {WRITE_DELAY = 1, Data = {}, Dirty = false}
            Services = {}

            setmetatable(Services, {__index = function(arg, arg2)
              return game:GetService(arg2)
            end})

            LocalPlayer = game.Players.LocalPlayer
            local str4 = "MosHubKaitun" .. ("/.storage_u_" .. tostring(LocalPlayer))

            Decode = function(arg)
              return Services.HttpService:JSONDecode(arg)
            end

            Encode = function(arg)
              return Services.HttpService:JSONEncode(arg)
            end

            Storage.Set = function(arg, arg2, arg3)
              if arg.Data[arg2] ~= arg3 then
                arg.Data[arg2] = arg3
                arg.Dirty = true
                return
              end
            end

            Storage.Get = function(arg, arg2)
              return arg.Data[arg2]
            end

            Storage.Save = function(arg)
              if arg.Dirty then
                writefile(str4, Encode(arg.Data))
                arg.Dirty = false
                return
              end
            end

            if not isfile(str4) then
              pcall(function()
                writefile(str4, "{}")
              end)
            end

            Storage.Data = {}

            pcall(function()
              Storage.Data = Decode(readfile(str4) or "{}")
            end)

            spawn(function()
              while task.wait(Storage.WRITE_DELAY) do
                if Storage.Dirty then
                  pcall(function()
                    Storage:Save()
                  end)
                end
              end
            end)

            CreateTraceback("Initalize", "Initalizing script...")

            task.spawn(function()
              pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")

                if playerGui then
                  if playerGui:FindFirstChild("Main") then
                    if playerGui.Main:FindFirstChild("Settings") then
                      if playerGui.Main.Settings:FindFirstChild("Buttons") then
                        local fastModeButton = playerGui.Main.Settings.Buttons:FindFirstChild("FastModeButton")

                        if fastModeButton then
                          if getconnections then
                            for _, v16 in ipairs(getconnections(fastModeButton.Activated)) do
                              pcall(v16.Function)
                            end

                            return
                          end
                        end
                      end
                    end
                  end
                end
              end)
            end)

            local tbl = {}
            SetTask("MainTask", "n/a")
            SetTask("SideTask", "n/a")
            ParsingTimes = 101

            local function fn37(arg, arg2)
              if CurrentTask ~= arg then
                TweenController.Hovering = false
                TweenController.HoverCFrame = nil
              end

              CurrentTask = arg

              pcall(function()
                ScriptStorage.Interface.SetText("DebugLine", arg)
              end)

              local ok, result = xpcall(function()
                FunctionsHandler[arg].Methods.Start:Call(arg2)
              end, debug.traceback)

              if ok then
                return
              end
              Report(result)
            end

            RefreshTasksData = function()
              if _G.Stop then
                return
              end
              local flag8 = (SeaIndex ~= 1) and CombatController.IsRaidActive()
              local raidController = FunctionsHandler.RaidController
              local flag9 = false

              if (((SeaIndex ~= 1) and raidController) and raidController.Initalized) and raidController.Methods.IsLocked then
                local ok, result = pcall(function()
                  return raidController.Methods.IsLocked:Call()
                end)

                if ok then
                  flag9 = result or flag9
                end
              end

              if flag8 or flag9 then
                fn37("RaidController", flag9 or true)
                return
              end

              if (CurrentTask == "BossesTask") or (CurrentTask == "SpecialBossesTask") then
                local v16 = FunctionsHandler[CurrentTask]
                local refresh = (v16 and v16.Methods) and v16.Methods.Refresh
                local start = (v16 and v16.Methods) and v16.Methods.Start

                if refresh and start then
                  local v17 = refresh:Call(false)
                  if v17 then
                    fn37(CurrentTask, v17)
                    return
                  end
                end
              end

              for _, v16 in ipairs(TasksOrder) do
                local v17 = FunctionsHandler[v16]

                if not v17 then
                  if not tbl[v16] then
                    tbl[v16] = true
                  end
                elseif v17.Initalized then
                  local refresh = v17.Methods.Refresh
                  local start = v17.Methods.Start

                  if refresh and start then
                    local v18 = refresh:Call(false)
                    if v18 then
                      fn37(v16, v18)
                      return
                    end
                  end
                end
              end
            end

            task.spawn(function()
              pcall(AddPoint)
              pcall(RefreshRace)
            end)

            pcall(function()
              QuestController:RefreshQuest()
            end)

            pcall(RefreshInventory)

            Remotes.CommE.OnClientEvent:Connect(function(...)
              local tbl10 = {...}

              if tbl10[1] then
                if string.find(tostring(tbl10[1]), "Item") then
                  pcall(RefreshInventory)
                  return
                end
              end
            end)

            PlayersService.LocalPlayer.Idled:Connect(function()
              Services.VirtualUser:CaptureController()
              Services.VirtualUser:ClickButton2(Vector2.new())
            end)

            local function fn38()
              if Config.WebhookEnabled then
                if type(Config.WebhookUrl) ~= "string" then
                  return
                end

                if #Config.WebhookUrl < 10 then
                  return
                end

                local ok, result = pcall(function()
                  RefreshInventory()
                  SyncLiveMeleeTools()
                  local data = LocalPlayer:FindFirstChild("Data")
                  local character = LocalPlayer.Character
                  local str5

                  if data then
                    if data:FindFirstChild("Race") then
                      str5 = data.Race.Value or "Unknown"
                    else
                      str5 = "Unknown"
                    end
                  else
                    str5 = "Unknown"
                  end

                  local str6, devilFruit, v16, v17, v18, v19

                  if character then
                    if character:FindFirstChild("RaceTransformed") then
                      str6 = "V4"
                    else
                      v16, v17 = safeInvokeRemote(Remotes.CommF_, 3, "Wenlocktoad", "1")

                      if v16 then
                        if v17 ~= -2 then
                          v18, v19 = safeInvokeRemote(Remotes.CommF_, 3, "Alchemist", "1")
                          str6 = "V1"

                          if v18 then
                            if v19 == -2 then
                              str6 = "V2"
                            end
                          end
                        else
                          str6 = "V3"
                        end
                      else
                        v18, v19 = safeInvokeRemote(Remotes.CommF_, 3, "Alchemist", "1")
                        str6 = "V1"

                        if v18 then
                          if v19 == -2 then
                            str6 = "V2"
                          end
                        end
                      end
                    end

                    devilFruit = data and data:FindFirstChild("DevilFruit")
                  else
                    v16, v17 = safeInvokeRemote(Remotes.CommF_, 3, "Wenlocktoad", "1")

                    if v16 then
                      if v17 ~= -2 then
                        v18, v19 = safeInvokeRemote(Remotes.CommF_, 3, "Alchemist", "1")
                        str6 = "V1"

                        if v18 then
                          if v19 == -2 then
                            str6 = "V2"
                          end
                        end
                      else
                        str6 = "V3"
                        devilFruit = data and data:FindFirstChild("DevilFruit")
                      end
                    else
                      v18, v19 = safeInvokeRemote(Remotes.CommF_, 3, "Alchemist", "1")
                      str6 = "V1"

                      if v18 then
                        if v19 == -2 then
                          str6 = "V2"
                        end
                      end

                      devilFruit = data and data:FindFirstChild("DevilFruit")
                    end
                  end

                  local str7

                  if devilFruit then
                    str7 = devilFruit.Value or "None"
                  else
                    str7 = "None"
                  end

                  local str8 = tostring(str7)
                  local match = (str8:match("^(T%-Rex)") or str8:match("^([^%-]+)")) or str8

                  if LocalPlayer.Backpack then
                    local v20 = LocalPlayer.Backpack:FindFirstChild(str8)

                    if v20 then
                      character = v20
                      character = character:FindFirstChild("Level")
                    elseif character then
                      character = character:FindFirstChild(str8)
                      character = character and character:FindFirstChild("Level")
                    end
                  elseif character then
                    character = character:FindFirstChild(str8)
                    character = character and character:FindFirstChild("Level")
                  end

                  character = character and character.Value
                  local n5 = tonumber(character) or 0
                  local tbl10 = {}
                  local tbl11 = {}
                  local tbl12 = {}
                  local num

                  for k, v20 in pairs(ScriptStorage.MeleesOwned) do
                    local num = tonumber(ScriptStorage.Melees[k]) or 0
                    if v20 and num > 0 then
                      table.insert(tbl10, k .. " [" .. num .. "]")
                    end
                  end

                  local tbl13 = {}
                  local tbl14 = {}
                  local str9

                  for k, v20 in pairs(ScriptStorage.Backpack) do
                    local name2 = v20.Name or k
                    str9 = tostring(name2)

                    if v20.Type ~= "Blox Fruit" then
                      if v20.Type == "Accessory" then
                        if not tbl14[str9] then
                          tbl14[str9] = true
                          table.insert(tbl12, str9)
                        end
                      elseif ((str9 == "Cursed Dual Katana") and tbl14[str9]) or ((str9 ~= "Cursed Dual Katana") and (((str9 == "Yama") and tbl14[str9]) or ((str9 ~= "Yama") and (((str9 == "Tushita") and tbl14[str9]) or ((str9 ~= "Tushita") and ((str9 ~= "Skull Guitar") or tbl14[str9])))))) then
                        exitTo2 = 1
                      else
                        tbl14[str9] = true
                        table.insert(tbl12, str9)
                      end
                    else
                      local match2 = (str9:match("^(T%-Rex)") or str9:match("^([^%-]+)")) or str9

                      if not tbl13[match2] then
                        tbl13[match2] = true
                        table.insert(tbl11, match2)
                      end
                    end
                  end

                  table.sort(tbl10)
                  table.sort(tbl11)
                  table.sort(tbl12)

                  local function fn39(arg)
                    local str10 = table.concat(arg, ", ")

                    if #str10 > 992 then
                      str10 = str10:sub(1, 989) .. "..."
                    end

                    return "```\n" .. (str10 .. "\n```")
                  end

                  local name2 = LocalPlayer.Name
                  local n6

                  if data then
                    if data:FindFirstChild("Level") then
                      n6 = data.Level.Value or 0
                    else
                      n6 = 0
                    end
                  else
                    n6 = 0
                  end

                  local str10 = tostring(n6)
                  local str11 = tostring(str5)
                  local str12

                  if str8 ~= "None" then
                    str12 = match .. (" [" .. (n5 .. "]"))
                  else
                    str12 = "None"
                  end

                  local str13 = name2 .. ("||" .. ("\nLevel : " .. (str10 .. ("\nRace : " .. (str11 .. (" [" .. (str6 .. ("]" .. ("\nFruits : " .. str12)))))))))
                  local tbl15 = {username = "BANANA CAT HUB", avatar_url = "https://i.pinimg.com/736x/5c/56/b1/5c56b155aa6c7736f192b47787d4052a.jpg", allowed_mentions = {parse = {}}}
                  local embeds = {}
                  local tbl16 = {author = {name = "BANANA CAT HUB  •  PLAYER PROFILE", icon_url = "https://i.pinimg.com/736x/5c/56/b1/5c56b155aa6c7736f192b47787d4052a.jpg"}, title = "Account Overview", description = "Username : ||" .. str13, color = 16776960}
                  local fields = {}
                  local tbl17 = {name = "Melee", value = fn39(tbl10), inline = false}
                  local tbl18 = {name = "Inventory Fruit", value = fn39(tbl11), inline = false}
                  local tbl19 = {name = "Inventory", value = fn39(tbl12), inline = false}
                  fields[1] = tbl17
                  fields[2] = tbl18
                  fields[3] = tbl19
                  tbl16.fields = fields
                  tbl16.footer = {text = "MosHub-MinhNg222  •  Player Stats", icon_url = "https://i.pinimg.com/736x/5c/56/b1/5c56b155aa6c7736f192b47787d4052a.jpg"}
                  tbl16.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                  embeds[1] = tbl16
                  tbl15.embeds = embeds
                  local request_3 = http_request

                  if request_3 then
                    if not request_3 then
                      error("No HTTP request function available")
                    end
                  else
                    request_3 = request

                    if request_3 then
                      if not request_3 then
                        error("No HTTP request function available")
                        request_3({Url = Config.WebhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Services.HttpService:JSONEncode(tbl15)})
                        return
                      end
                    else
                      request_3 = syn

                      if request_3 then
                        request_3 = syn.request

                        if not request_3 then
                          error("No HTTP request function available")
                          request_3({Url = Config.WebhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Services.HttpService:JSONEncode(tbl15)})
                          return
                        end
                      elseif not request_3 then
                        error("No HTTP request function available")
                        request_3({Url = Config.WebhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Services.HttpService:JSONEncode(tbl15)})
                        return
                      end
                    end
                  end

                  request_3({Url = Config.WebhookUrl, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = Services.HttpService:JSONEncode(tbl15)})
                end)

                if ok then
                  return
                end
                warn("[Webhook] " .. tostring(result))
                return
              end
            end

            task.spawn(function()
              local lastSent = 0

              while task.wait(30) do
                if (not Config.WebhookEnabled or (type(Config.WebhookUrl) ~= "string")) or (#Config.WebhookUrl < 10) then
                  lastSent = 0
                else
                  local interval = math.max(1, tonumber(Config.WebhookIntervalMinutes) or 5) * 60

                  if (lastSent == 0) or ((os.clock() - lastSent) >= interval) then
                    lastSent = os.clock()
                    fn38()
                  end
                end
              end
            end)

            local v16 = StartTick
            SetTask("MainTask", "Loaded In " .. (math.floor((tick() - v16) * 1000) .. "ms!"))
            QueueList = {}

            NearbyHopHandler = function()
            end

            local function fn39()
              local ok, result = pcall(function()
                return require(game:GetService("ReplicatedStorage").Controllers.GachaClient)
              end)

              if ok then
                local ok2, result2 = pcall(result.CheckGachaAsync, "ZiolesGacha", "Blox Fruit Gacha")

                if ok2 then
                  if type(result2) ~= "table" then
                    return
                  end

                  if result2.RequirementsMet ~= true then
                    return
                  end
                  pcall(result.PurchaseGachaAsync, "ZiolesGacha")
                  return
                end

                return
              end
            end

            task.spawn(function()
              local n5 = 0
              local n6 = 0
              local n7 = 0

              while task.wait(1) do
                local ok, result = xpcall(function()
                  if _G.Stop then
                    return
                  end

                  if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SpinnerWindow") then
                    local closeButton = game:GetService("Players").LocalPlayer.PlayerGui.SpinnerWindow:FindFirstChild("CloseButton", true)

                    if closeButton then
                      if getconnections then
                        for _, v17 in ipairs(getconnections(closeButton.MouseButton1Click)) do
                          v17:Fire()
                        end

                        for _, v17 in ipairs(getconnections(closeButton.Activated)) do
                          v17:Fire()
                        end
                      end
                    end
                  end

                  NearbyHopHandler()

                  if LocalPlayer.Character:FindFirstChild("Humanoid") then
                    if LocalPlayer.Character.Humanoid.Sit then
                      LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                  end

                  RefreshPlayerData()

                  if runtimeUI then
                    if runtimeUI.SyncRuntimeUI then
                      pcall(runtimeUI.SyncRuntimeUI)
                    end
                  end

                  local raidController = FunctionsHandler.RaidController

                  if raidController then
                    if raidController.Initalized then
                      if raidController.Methods.IsLocked then
                        if not raidController.Methods.IsLocked:Call() then
                          if (os.time() - n5) > 3 then
                            n5 = os.time()
                            FunctionsHandler.MeleesController.Methods.Start:Call()
                          end
                        end
                      elseif (os.time() - n5) > 3 then
                        n5 = os.time()
                        FunctionsHandler.MeleesController.Methods.Start:Call()
                      end
                    elseif (os.time() - n5) > 3 then
                      n5 = os.time()
                      FunctionsHandler.MeleesController.Methods.Start:Call()
                    end
                  elseif (os.time() - n5) > 3 then
                    n5 = os.time()
                    FunctionsHandler.MeleesController.Methods.Start:Call()
                  end

                  if (os.time() - n6) > 60 then
                    n6 = os.time()

                    if Remotes.CommF_:InvokeServer("Cousin", "CheckTime", "DLCBoxData") == true then
                      Remotes.CommF_:InvokeServer("Cousin", "DLCBoxData")
                    end
                  end

                  if (os.time() - n7) >= 30 then
                    n7 = os.time()
                    fn39()
                    return
                  end
                end, debug.traceback)

                if not ok then
                  Report(result)
                end
              end
            end)

            task.spawn(function()
              pcall(RefreshTasksData)
            end)

            while task.wait(0.25) do
              if Config.HopWhenIdle then
                if (os.time() - lastIdleTick) > 180 then
                  SetTask("MainTask", "Rejoining due idle in 3 min")
                  UnifiedReconnect("Rejoining due to idle in 3 min")

                  while true do
                    task.wait(1)
                  end
                end
              end

              if Config.AutoHop ~= false then
                local v17 = StartTick

                if (tick() - v17) > 1800 then
                  SetTask("MainTask", "Hop Server - 30 min")
                  Hop("30 min server hop")
                  task.wait(5)
                end
              end

              local ok, result = xpcall(RefreshTasksData, debug.traceback)

              if not ok then
                Report(result)
              end
            end
          end
          end

        mmb = fn21
        local ok, result = xpcall(mmb, debug.traceback)

        if not ok then
          genv2.BananaCat = nil
          warn("[Banana Cat Error]: " .. tostring(result))
          pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
              Title = "Banana Cat Error",
              Text = tostring(result):sub(1, 100),
              Duration = 10
            })
          end)
        end

        local genv3 = getgenv()

        return true
      end

      tbl5.CursedDualKatana = false
      tbl5.SoulGuitar = false
      tbl5.FarmBoneForx2EXP = false
      tbl5.WebhookEnabled = false
      tbl5.WebhookUrl = ""
      tbl5.WebhookIntervalMinutes = 5
    end
  end
end
