local F, C = unpack(select(2, ...))

if not C.general.interrupt then return end

local playerName = UnitName("player")

local interrupt = CreateFrame("Frame")
interrupt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
interrupt:SetScript("OnEvent", function(_, _, _, subevent, _, _, sourceName, _, _, _, destName, _, _, _, _, _, spellID)
	if subevent == "SPELL_INTERRUPT" then
		if sourceName == playerName and GetNumGroupMembers() > 5 then
			local isInstance, instanceType = IsInInstance()
			if isInstance and instanceType ~= "pvp" then
				local channel
				if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
					channel = "INSTANCE_CHAT"
				else
					channel = "RAID"
				end

				SendChatMessage("Interrupted: "..destName.."'s "..GetSpellLink(spellID)..".", channel)
			end
		end
	end
end)