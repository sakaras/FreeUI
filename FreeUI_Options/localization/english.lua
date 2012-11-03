local _, ns = ...

ns.localization = {}

ns.localization.profile = "Character Specific settings"
ns.localization.profileTooltip = "Switch to a profile unique to this character."
ns.localization.install = "Installer"
ns.localization.needReload = "The above settings require a UI reload to apply."
ns.localization.noReloadException = "The above settings require a UI reload to apply, unless marked with *."
ns.localization.reloadException = "Only settings marked with * require a UI reload to apply."
ns.localization.reload = "Reload UI"
ns.localization.resetData = "Remove data"
ns.localization.resetOptions = "Remove saved options"
ns.localization.author = "FreeUI by Haleth on wowinterface.com"
ns.localization.authorSubText = "Freethinker @ Steamwheedle Cartel - EU"

ns.localization.general = "General"
ns.localization.generalSubText = "These options control most of the common settings in the UI."
ns.localization.generalbags_size = "Bag size"
ns.localization.generalbuffreminder = "Buff reminder"
ns.localization.generalbuffreminderTooltip = "While in combat, show a reminder when missing important buffs that you can cast."
ns.localization.generalbuffTracker = "Buff tracker"
ns.localization.generalbuffTrackerTooltip = "Show important buffs below the center of the screen for certain classes."
ns.localization.generalhelmcloakbuttons = "Helm/Cloak buttons"
ns.localization.generalhelmcloakbuttonsTooltip = "Allows you to toggle Helm/Cloak display from the character frame."
ns.localization.generalinterrupt = "Interrupt announcer"
ns.localization.generalinterruptTooltip = "Announce your interrupts to raid chat in a PVE situation."
ns.localization.generalmailButton = "Mail collection button"
ns.localization.generalmailButtonTooltip = "Adds a button to the mail frame to collect all mail attachments with one click."
ns.localization.generalthreatMeter = "Threat meter"
ns.localization.generalthreatMeterTooltip = "Show a bar above the target frame that displays your threat compared to the tank as a dps, or the threat and name of the second highest in threat when tanking."
ns.localization.generaltolbarad = "Tol Barad timer"
ns.localization.generaltolbaradTooltip = "Show a Tol Barad timer below the minimap."
ns.localization.generaltooltip_cursor = "Attach the tooltip to the cursor"
ns.localization.generaltooltip_guildranks = "Show guild ranks in tooltips"
ns.localization.generaluiScaleAuto = "UI scale adjusting"
ns.localization.generaluiScaleAutoTooltip = "Automatically apply the optimal UI scale for your resolution. Requires a UI reload to change."
ns.localization.generalundressButton = "Undress button"
ns.localization.generalundressButtonTooltip = "Adds an undress button to the dressup frame. Useful when trying on shirts or chest armour."

ns.localization.automation = "Automation"
ns.localization.automationSubText = "With these features, the UI can perform common tasks automatically."
ns.localization.automationautoAccept = "Automatically accept invites from friends and guildies"
ns.localization.automationautoRepair = "Automatically repair items"
ns.localization.automationautoRepair_guild = "Use guild funds"
ns.localization.automationautoRoll = "Automatically roll DE or greed on BoE uncommon items"
ns.localization.automationautoRoll_maxLevel = "Only at max level"
ns.localization.automationautoSell = "Automatically sell junk"

ns.localization.actionbars = "Action bars"
ns.localization.actionbarsSubText = "These options are specific to the action bars and their buttons."
ns.localization.actionbarsenable = "Enable"
ns.localization.actionbarsenableTooltip = "Disable this option if you want to use an other action bars addon."
ns.localization.actionbarsenableStyle = "Enable button style"
ns.localization.actionbarsenableStyleTooltip = "You may need to disable this option to ensure compatibility with other action bars addons."
ns.localization.actionbarshotkey = "Show key bindings on buttons"
ns.localization.actionbarsrightbars_mouseover = "Show right action bars on mouseover"

ns.localization.notifications = "Notifications"
ns.localization.notificationsSubText = "These options let you choose when and how the UI should show notifications."
ns.localization.notificationsenable = "Enable *"
ns.localization.notificationsenableTooltip = "Allow notifications to be shown. A banner will appear at the top of the UI. Clicking it with either mouse button dismisses the notifications. Clicking it with the left button can also perform an action, such as showing the calendar."
ns.localization.notificationsplaySounds = "Play sounds"
ns.localization.notificationsplaySoundsTooltip = "Play a sound when a notification is shown."
ns.localization.notificationsanimations = "Animations"
ns.localization.notificationsanimationsTooltip = "Animate the banner when it is shown or hidden."
ns.localization.notificationstimeShown = "Time shown"
ns.localization.notificationscheckMail = "Mail"
ns.localization.notificationscheckMailTooltip = "Show a notification when you have new mail."
ns.localization.notificationscheckEvents = "Calendar events"
ns.localization.notificationscheckEventsTooltip = "Show a notification when you have pending calendar events."
ns.localization.notificationscheckGuildEvents = "Guild events"
ns.localization.notificationscheckGuildEventsTooltip = "Show a notification when you have pending guild events. These events do not appear on your calendar button by default and are easily missed."

ns.localization.unitframes = "Unit frames"
ns.localization.unitframesSubText = "These options control most of the options for the unit frames. If you want to move the unit frames easily, install oUF_MovableFrames."
ns.localization.unitframesenable = "Enable"
ns.localization.unitframesenableTooltip = "Disable this option if you want to use an other unit frames addon."
ns.localization.unitframesenableGroup = "Party/Raid frames"
ns.localization.unitframesenableGroupTooltip = "Uncheck if you want to use an other addon for party and raid frames."
ns.localization.unitframeslimitRaidSize = "Limit raid size *"
ns.localization.unitframeslimitRaidSizeTooltip = "Check to show a maximum of 25 players in a raid group."
ns.localization.unitframespartyNameAlways = "Always show group member names"
ns.localization.unitframepartyNameAlwaysTooltip = "Check to show group member names in the dps/tank layout."
ns.localization.unitframescastbarSeparate = "Player castbar as separate bar"
ns.localization.unitframescastbarSeparateTooltip = "When this option is disabled, the player cast bar is embedded in the player frame."
ns.localization.unitframescastbarSeparateOnlyCasters = "Only for caster classes"
ns.localization.unitframescastbarSeparateOnlyCastersTooltip = "Check to only use the separate cast bar as a Mage, Priest, or Warlock"
ns.localization.unitframestargettarget = "Target of Target"
ns.localization.unitframestargettargetTooltip = "Add a Target of Target frame above the target frame."
ns.localization.unitframeshealerClasscolours = "Always use class colours"
ns.localization.unitframeshealerClasscoloursTooltip = "Enable to use class colours rather than gradient in the healer layout."
ns.localization.unitframespvp = "PVP Icon"
ns.localization.unitframespvpTooltip = "Show a small red PVP icon above the player unit frame."

ns.localization.classmod = "Class specific"
ns.localization.classmodSubText = "These options allow you to toggle the class-specific modules in the UI."

local classes = UnitSex("player") == 2 and LOCALIZED_CLASS_NAMES_MALE or LOCALIZED_CLASS_NAMES_FEMALE

for class, localized in pairs(classes) do
	ns.localization["classmod"..strlower(class)] = localized
end

ns.localization.classmoddeathknight = ns.localization.classmoddeathknight..":|cffffffff Rune bars"
ns.localization.classmoddruid = ns.localization.classmoddruid..":|cffffffff Eclipse bar and shapeshift mana bar"
ns.localization.classmodmonk = ns.localization.classmodmonk..":|cffffffff Chi orb tracker"
ns.localization.classmodpaladinHP = ns.localization.classmodpaladin..":|cffffffff Holy Power tracker"
ns.localization.classmodpaladinRF = ns.localization.classmodpaladin..":|cffffffff Righteous Fury reminder"
ns.localization.classmodpriest = ns.localization.classmodpriest..":|cffffffff Shadow orb tracker"
ns.localization.classmodshaman = ns.localization.classmodshaman..":|cffffffff Maelstrom Weapon tracker"
ns.localization.classmodwarlock = ns.localization.classmodwarlock..":|cffffffff Specialization bars"

ns.localization.credits = "Credits"
ns.localization.thankYou = "Thank you:"
ns.localization.alza = "For AlzaUI, which once formed the basis for FreeUI, and of which some code still exists today"
ns.localization.haste = "For the oUF framework, without which the unitframes in this UI could not exist"
ns.localization.tukz = "For allowing the use of his code, and collaboration in UI development"
ns.localization.zork = "For rActionBarStyler, rActionButtonStyler, and rBuffFrameStyler, three important parts of this UI"
ns.localization.others = "as well as..."