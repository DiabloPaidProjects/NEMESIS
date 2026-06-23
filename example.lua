--[[
	NEMESIS v1.1 — example / demo
	Run in your executor. Press RightShift to hide/show (floating "N" on mobile).
]]

local NEMESIS = loadstring(game:HttpGet("https://raw.githubusercontent.com/DiabloPaidProjects/NEMESIS/main/source.lua"))()

local Win = NEMESIS.Window({
	title = "NEMESIS",
	subtitle = "demo hub",
	accent = Color3.fromRGB(140, 90, 255),
	toggleKey = Enum.KeyCode.RightShift,
	-- width = 700, height = 460,   -- optional; defaults to a wide rectangle
})

----------------------------------------------------------------------
-- Tab 1: Main — single column, sidebar icon = lucide "home"
----------------------------------------------------------------------
local Main = Win.Tab("Main", { icon = "home" })

Main.Section("Combat")
Main.Toggle({
	text = "Auto Farm",
	default = false,
	flag = "autofarm",
	callback = function(on)
		NEMESIS.Notify({ title = "Auto Farm", content = on and "Enabled" or "Disabled", duration = 2 })
	end,
})
Main.Slider({
	text = "Walk Speed", min = 16, max = 250, default = 16, increment = 1, flag = "walkspeed",
	callback = function(v)
		local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = v end
	end,
})
Main.Button({ text = "Execute", callback = function()
	NEMESIS.Notify({ title = "Executed", content = "Ran the thing.", duration = 3 })
end })

----------------------------------------------------------------------
-- Tab 2: Visuals — TWO-COLUMN layout with group boxes
----------------------------------------------------------------------
local Visuals = Win.Tab("Visuals", { icon = "eye", columns = 2 })

local esp = Visuals.GroupBox("ESP")          -- auto-placed (left column)
esp.Toggle({ text = "Box ESP", default = false, flag = "esp_box" })
esp.Toggle({ text = "Name ESP", default = true, flag = "esp_name" })
esp.ColorPicker({
	text = "ESP Color",
	default = Color3.fromRGB(255, 0, 80),
	transparency = 0,          -- full color panel: SV square, hue, alpha, hex
	flag = "esp_color",
	callback = function(color, alpha)
		print("ESP color:", color, "transparency:", alpha)
	end,
})

local world = Visuals.GroupBox("World", "right")
world.Slider({ text = "FOV", min = 60, max = 120, default = 90, suffix = "\u{00B0}", flag = "fov" })
world.Dropdown({
	text = "Render",
	options = { "Players", "NPCs", "Items", "Chests" },
	multi = true,
	default = { "Players" },
	flag = "render",
})

----------------------------------------------------------------------
-- Tab 3: Config — icon by asset ID
----------------------------------------------------------------------
local Config = Win.Tab("Config", { icon = "settings" })

local g = Config.GroupBox("Settings")
g.Input({ text = "Webhook URL", placeholder = "https://...", flag = "webhook",
	callback = function(text) print("Webhook:", text) end })
g.Keybind({ text = "Panic Key", default = Enum.KeyCode.P, mode = "Toggle", flag = "panic",
	callback = function(state) print("Panic:", state) end })
g.Paragraph({ title = "About", content = "NEMESIS v1.1 — group boxes, two columns, full color panel. Right-click a swatch to copy hex." })

----------------------------------------------------------------------
NEMESIS.Notify({ title = "NEMESIS", content = "Loaded successfully.", duration = 4 })
