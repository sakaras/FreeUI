local F, C, L = unpack(select(2, ...))

local IDs = {}
for _, slot in pairs({"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "MainHand", "SecondaryHand", "Ranged"}) do 	IDs[slot] = GetInventorySlotInfo(slot .. "Slot")
end

local cost
local last = 0
local function onUpdate(self, elapsed)
	last = last + elapsed
	if last >= 1 then
		self:SetScript("OnUpdate", nil)
		last = 0
		local gearRepaired = true
		for slot, id in pairs(IDs) do
			local dur, maxdur = GetInventoryItemDurability(id)
			if dur and maxdur and dur < maxdur then
				gearRepaired = false
				break
			end
		end
		if gearRepaired then
			print(format("Repair: %.1fg (Guild)", cost * 0.0001))
		else
			print("Your guild cannot afford your repairs.")
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", function(self, event)
	if CanMerchantRepair() and C.general.autorepair == true then
		cost = GetRepairAllCost()
		if cost > 0 and CanGuildBankRepair() and C.general.autorepair_guild == true then
			if GetGuildBankWithdrawMoney() > cost then
				self:SetScript("OnUpdate", onUpdate) -- to work around bug when there's not enough money in guild bank
				RepairAllItems(1)
			else
				print("Your repair costs are higher than your guild permits.")
			end
		elseif cost > 0 and GetMoney() > cost then
			RepairAllItems()
			print(format("Repair: %.1fg", cost * 0.0001))
		elseif GetMoney() < cost then
			print("You are not repaired! (insufficient funds)")
		end
	end

	if C.general.autosell == true then
		for bag = 0, 4 do
			for slot = 0, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot)
				if link and (select(3, GetItemInfo(link))==0) then
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end)

if C.general.auto_accept == true then
	if UnitFactionGroup("player") == "Horde" then playerFaction = 0 else playerFaction = 1 end
	local playerRealm = GetRealmName()

	local IsFriend = function(name)
		for i = 1, GetNumFriends() do if(GetFriendInfo(i)==name) then return true end end
		if IsInGuild() then for i = 1, GetNumGuildMembers() do if(GetGuildRosterInfo(i)==name) then return true end end end
		for i = 1, select(2, BNGetNumFriends()) do
			local presenceID, _, _, toonName, _, client = BNGetFriendInfo(i)
			local _, _, _, realmName, faction = BNGetToonInfo(presenceID)
			if client == "WoW" and realmName == playerRealm and toonName == name then
				return true
			end
		end
	end

	local g = CreateFrame("Frame")
	g:RegisterEvent("PARTY_INVITE_REQUEST")
	g:SetScript("OnEvent", function(self, event, name)
		if MiniMapLFGFrame:IsShown() then return end
		if IsFriend(name) then
			AcceptGroup()
			for i = 1, 4 do
				local frame = _G["StaticPopup"..i]
				if frame:IsVisible() and frame.which == "PARTY_INVITE" then
					frame.inviteAccepted = 1
					return StaticPopup_Hide("PARTY_INVITE")
				end
			end
		end
	end)
end

if C.general.auto_loot_switch == true then
	local h = CreateFrame("Frame")
	h:RegisterEvent("PLAYER_ENTERING_WORLD")
	h:SetScript("OnEvent", function()
		if select(2, GetInstanceInfo()) == "raid" then
			SetCVar("showLootSpam", 0)
		else
			SetCVar("showLootSpam", 1)
		end
	end)
end

if C.general.helmcloakbuttons == true then
	local helm = CreateFrame("CheckButton", "FreeUI_HelmCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
	helm:SetSize(22, 22)
	helm:SetPoint("LEFT", CharacterHeadSlot, "RIGHT", 5, 0)
	helm:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
	helm:SetScript("OnEvent", function() helm:SetChecked(ShowingHelm()) end)
	helm:RegisterEvent("UNIT_MODEL_CHANGED")
	helm:SetToplevel(true)

	local cloak = CreateFrame("CheckButton", "FreeUI_CloakCheckBox", PaperDollFrame, "OptionsCheckButtonTemplate")
	cloak:SetSize(22, 22)
	cloak:SetPoint("LEFT", CharacterBackSlot, "RIGHT", 5, 0)
	cloak:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)
	cloak:SetScript("OnEvent", function() cloak:SetChecked(ShowingCloak()) end)
	cloak:RegisterEvent("UNIT_MODEL_CHANGED")
	cloak:SetToplevel(true)

	helm:SetChecked(ShowingHelm())
	cloak:SetChecked(ShowingCloak())
	helm:SetFrameLevel(31)
	cloak:SetFrameLevel(31)
end