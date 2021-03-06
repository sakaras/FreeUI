local F, C
local _, ns = ...

-- [[ Functions ]]

ns.categories = {}
ns.buttons = {}
ns.protectOptions = {}

local checkboxes = {}
local sliders = {}
local dropdowns = {}
local panels = {}

local r, g, b

local function SaveValue(f, value)
	if not C.options[f.group] then C.options[f.group] = {} end
	if not C.options[f.group][f.option] then C.options[f.group][f.option] = {} end

	C.options[f.group][f.option] = value -- these are the saved variables
	C[f.group][f.option] = value -- and this is from the lua options
end

local function toggleChildren(self, checked)
	local tR, tG, tB
	if checked then
		tR, tG, tB = 1, 1, 1
	else
		tR, tG, tB = .5, .5, .5
	end

	for _, child in next, self.children do
		child:SetEnabled(checked)
		child.Text:SetTextColor(tR, tG, tB)
	end
end

local function toggle(self)
	local checked = self:GetChecked() == 1

	if checked then
		PlaySound("igMainMenuOptionCheckBoxOn")
	else
		PlaySound("igMainMenuOptionCheckBoxOff")
	end

	SaveValue(self, checked)
	if self.children then toggleChildren(self, checked) end
end

ns.CreateCheckBox = function(parent, option, tooltipText)
	local f = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")

	f.group = parent.tag
	f.option = option

	f.Text:SetText(ns.localization[parent.tag..option])
	if tooltipText then f.tooltipText = ns.localization[parent.tag..option.."Tooltip"] end

	f:SetScript("OnClick", toggle)
	parent[option] = f

	tinsert(checkboxes, f)

	return f
end

local function onValueChanged(self, value)
	value = floor(value*1000)/1000

	if self.textInput then
		self.textInput:SetText(value)
	end

	SaveValue(self, value)
end

local function onValueChanged(self, value)
	value = floor(value*1000)/1000

	if self.textInput then
		self.textInput:SetText(value)
	end

	SaveValue(self, value)
end

local function createSlider(parent, option, lowText, highText, low, high, step)
	local baseName = "FreeUIOptionsPanel"
	local f = CreateFrame("Slider", baseName..option, parent, "OptionsSliderTemplate")

	BlizzardOptionsPanel_Slider_Enable(f)

	f.group = parent.tag
	f.option = option

	_G[baseName..option.."Text"]:SetText(ns.localization[parent.tag..option])
	_G[baseName..option.."Low"]:SetText(lowText)
	_G[baseName..option.."High"]:SetText(highText)
	f:SetMinMaxValues(low, high)
	f:SetValueStep(step)

	f:SetScript("OnValueChanged", onValueChanged)
	parent[option] = f

	tinsert(sliders, f)

	return f
end

local function onEscapePressed(self)
	self:ClearFocus()
end

local function onEnterPressed(self)
	local slider = self:GetParent()
	local min, max = slider:GetMinMaxValues()

	local value = tonumber(self:GetText())
	if value and value >= floor(min) and value <= floor(max) then
		slider:SetValue(value)
	else
		self:SetText(floor(slider:GetValue()*1000)/1000)
	end

	self:ClearFocus()
end

ns.CreateNumberSlider = function(parent, option, lowText, highText, low, high, step, alignRight)
	local slider = createSlider(parent, option, lowText, highText, low, high, step)

	local baseName = "FreeUIOptionsPanel"

	local f = CreateFrame("EditBox", baseName..option.."TextInput", slider)
	f:SetAutoFocus(false)
	f:SetWidth(60)
	f:SetHeight(20)
	f:SetMaxLetters(8)
	f:SetFontObject(GameFontHighlight)

	if alignRight then
		slider:SetPoint("RIGHT", f, "LEFT", -20, 0)
	else
		f:SetPoint("LEFT", slider, "RIGHT", 20, 0)
	end

	f:SetScript("OnEscapePressed", onEscapePressed)
	f:SetScript("OnEnterPressed", onEnterPressed)

	slider.textInput = f

	return slider
end

local offset = 60
local activeTab = nil

local function setActiveTab(tab)
	activeTab = tab
	activeTab:SetBackdropColor(r, g, b, .2)
	activeTab.panel:Show()
end

local onTabClick = function(tab)
	activeTab:SetBackdropColor(0, 0, 0, 0)
	activeTab.panel:Hide()
	setActiveTab(tab)
end

local function colourTab(f)
	f.Text:SetTextColor(1, 1, 1)
end

local function clearTab(f)
	f.Text:SetTextColor(1, .82, 0)
end

ns.addCategory = function(name)
	local tag = strlower(name)

	local panel = CreateFrame("Frame", "FreeUIOptionsPanel"..name, FreeUIOptionsPanel)
	panel:SetSize(623, 568)
	panel:SetPoint("RIGHT", -16, 0)
	panel:Hide()

	panel.Title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	panel.Title:SetPoint("TOPLEFT", 8, -16)
	panel.Title:SetText(ns.localization[tag])

	panel.subText = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	panel.subText:SetPoint("TOPLEFT", panel.Title, "BOTTOMLEFT", 0, -8)
	panel.subText:SetJustifyH("LEFT")
	panel.subText:SetJustifyV("TOP")
	panel.subText:SetSize(607, 32)
	panel.subText:SetText(ns.localization[tag.."SubText"])

	local tab = CreateFrame("Frame", nil, FreeUIOptionsPanel)
	tab:SetPoint("TOPLEFT", 16, -offset)
	tab:SetSize(160, 44)

	tab.Text = tab:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	tab.Text:SetPoint("CENTER")
	tab.Text:SetText(ns.localization[tag])

	tab:SetScript("OnMouseUp", onTabClick)
	tab:SetScript("OnEnter", colourTab)
	tab:SetScript("OnLeave", clearTab)

	tab.panel = panel
	panel.tab = tab
	panel.tag = tag

	FreeUIOptionsPanel[tag] = panel

	tinsert(panels, panel)

	offset = offset + 54
end

-- [[ Init ]]

local function changeProfile()
	local profile
	if FreeUIOptionsGlobal[C.myRealm][C.myName] == true then
		if FreeUIOptionsPerChar == nil then
			FreeUIOptionsPerChar = {}
		end
		profile = FreeUIOptionsPerChar
	else
		profile = FreeUIOptions
	end

	local groups = {
		["general"] = true,
		["automation"] = true,
		["actionbars"] = true,
		["bags"] = true,
		["notifications"] = true,
		["unitframes"] = true,
		["classmod"] = true
	}

	-- set variables from lua options if they're not saved yet, otherwise load saved option
	for group, options in pairs(C) do
		if groups[group] then
			if profile[group] == nil then profile[group] = {} end

			for option, value in pairs(options) do
				-- not using this yet
				if type(C[group][option]) ~= "table" then
					if profile[group][option] == nil then
						profile[group][option] = value
					else
						-- temporary fix for non-implemented unitframe options
						if group ~= "unitframes" or not tonumber(profile[group][option]) then
							C[group][option] = profile[group][option]
						end
					end
				end
			end
		end
	end

	C.options = profile
end

local function displaySettings()
	for _, box in pairs(checkboxes) do
		box:SetChecked(C[box.group][box.option])
		if box.child then toggleChild(box) end
	end

	for _, slider in pairs(sliders) do
		slider:SetValue(C[slider.group][slider.option])
		slider.textInput:SetText(floor(C[slider.group][slider.option]*1000)/1000)
		slider.textInput:SetCursorPosition(0)
	end
end

local function removeCharData(self)
	self:ClearFocus()

	local realm = C.myRealm
	local text = self:GetText()

	self:SetText("")

	if text ~= "" then
		for name in pairs(FreeUIGlobalConfig[realm].class) do
			if text == name then
				FreeUIGlobalConfig[realm].class[name] = nil
				FreeUIGlobalConfig[realm].gold[name] = nil
				DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffData for "..text.." removed.", unpack(C.class))
				return
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage("FreeUI: |cffffffffData for "..text.." not found. Check the spelling of the name.", unpack(C.class))
	end
end

local init = CreateFrame("Frame")
init:RegisterEvent("PLAYER_LOGIN")
init:SetScript("OnEvent", function()
	if not FreeUI then return end

	F, C = unpack(FreeUI)
	r, g, b = unpack(C.class)

	FreeUIOptionsPanel:HookScript("OnShow", function()
		oUF_FreePlayer:SetAlpha(0)
		oUF_FreeTarget:SetAlpha(0)
	end)

	FreeUIOptionsPanel:HookScript("OnHide", function()
		oUF_FreePlayer:SetAlpha(1)
		oUF_FreeTarget:SetAlpha(1)
	end)

	local resetFrame = FreeUIOptionsPanel.resetFrame
	local layout = FreeUIOptionsPanel.unitframes.Layout

	resetFrame.Okay:SetScript("OnClick", function()
		local somethingChecked = false

		if resetFrame.Data:GetChecked() then
			FreeUIGlobalConfig = {}
			FreeUIConfig = {}
			somethingChecked = true
		end
		if resetFrame.Options:GetChecked() then
			FreeUIOptions = {}
			FreeUIOptionsPerChar = {}
			FreeUIOptionsGlobal[C.myRealm][C.myName] = false
			C.options = FreeUIOptions
			somethingChecked = true
		end

		removeCharData(resetFrame.charBox)

		if somethingChecked then
			ReloadUI()
		else
			resetFrame:Hide()
		end
	end)

	resetFrame.charBox:SetScript("OnEnterPressed", removeCharData)

	FreeUIOptionsPanel.Profile:SetChecked(FreeUIOptionsGlobal[C.myRealm][C.myName])
	FreeUIOptionsPanel.Profile:SetScript("OnClick", function(self)
		FreeUIOptionsGlobal[C.myRealm][C.myName] = self:GetChecked() == 1
		changeProfile()
		displaySettings()
	end)

	layout:SetText((FreeUIConfig.layout == 2) and "Dps/Tank Layout" or "Healer Layout")
	layout:SetScript("OnClick", function()
		FreeUIConfig.layout = (FreeUIConfig.layout == 2) and 1 or 2
		ReloadUI()
	end)

	F.CreateBD(FreeUIOptionsPanel)
	F.CreateSD(FreeUIOptionsPanel)
	F.CreateBD(resetFrame)
	F.ReskinClose(FreeUIOptionsPanel.CloseButton)
	F.ReskinCheck(FreeUIOptionsPanel.Profile)
	F.ReskinCheck(resetFrame.Data)
	F.ReskinCheck(resetFrame.Options)

	for _, panel in pairs(panels) do
		F.CreateBD(panel.tab, 0)
		F.CreateGradient(panel.tab)
	end

	setActiveTab(FreeUIOptionsPanel.general.tab)

	for _, button in pairs(ns.buttons) do
		F.Reskin(button)
	end

	for _, box in pairs(checkboxes) do
		box:SetChecked(C[box.group][box.option])
		if box.children then
			toggleChildren(box, box:GetChecked())
		end

		F.ReskinCheck(box)
	end

	for _, slider in pairs(sliders) do
		slider:SetValue(C[slider.group][slider.option])

		slider.textInput:SetText(floor(C[slider.group][slider.option]*1000)/1000)
		slider.textInput:SetCursorPosition(0)
		F.ReskinInput(slider.textInput)

		F.ReskinSlider(slider)
	end

	for _, setting in pairs(ns.classOptions) do
		local colour = C.classcolours[strupper(setting.option)]
		setting.Text:SetTextColor(colour.r, colour.g, colour.b)
	end

	F.ReskinInput(resetFrame.charBox)

	local colour = C.classcolours["PALADIN"]
	FreeUIOptionsPanel.classmod.paladinHP.Text:SetTextColor(colour.r, colour.g, colour.b)
	FreeUIOptionsPanel.classmod.paladinRF.Text:SetTextColor(colour.r, colour.g, colour.b)
end)

local protect = CreateFrame("Frame")
protect:RegisterEvent("PLAYER_REGEN_ENABLED")
protect:RegisterEvent("PLAYER_REGEN_DISABLED")
protect:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_REGEN_ENABLED" then
		for _, option in next, ns.protectOptions do
			option.Text:SetTextColor(1, 1, 1)
			option:Enable()
		end
	else
		for _, option in next, ns.protectOptions do
			option.Text:SetTextColor(.5, .5, .5)
			option:Disable()
		end
	end
end)