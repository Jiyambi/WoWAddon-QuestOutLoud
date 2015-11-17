--------------------------------
--   QuestOutLoud_Quest.lua   --
--------------------------------


----
QuestOutLoud_Quest = QuestOutLoud:NewModule("QuestOutLoud_Quest", "AceEvent-3.0")
QuestOutLoud_Quest.parent = QuestOutLoud
----


-- OnEnable --
---- Called when the addon is enabled, and on log-in and /reload, after all addons have loaded
function QuestOutLoud_Quest:OnEnable()
	self.parent:QOLPrint("Quest Module Enabled.")

	-- Event Setup --
	self:RegisterEvents( {
		"QUEST_LOG_UPDATE", "QUEST_DETAIL", "QUEST_GREETING", "QUEST_TURNED_IN", "QUEST_PROGRESS", "QUEST_ACCEPTED"
	})

	-- Quest log buttons --
	self.QuestFrameButton = self:CreateQuestLogButton(QuestFrame, "QuestFrameButton");
	self.QuestLogPopupDetailFrameButton = self:CreateQuestLogButton(QuestLogPopupDetailFrame, "QuestLogPopupDetailFrameButton");
end	
----


-- RegisterEvents --
---- Iterates through the supplied table of events, and registers each event to the guide frame.
function QuestOutLoud_Quest:RegisterEvents(eventtable)
	for _, event in ipairs(eventtable) do
		self:RegisterEvent(event)
	end
end
----


-- CreateQuestLogButton
---- Creates the button on the quest log entry
---- Will be attached to QuestLogPopupDetailFrame, QuestFrame
function QuestOutLoud_Quest:CreateQuestLogButton(parent, name)
	self.parent:Debug("CreateQuestLogButton()")
	--
	-- TODO: Some kind of sound symbol on button
	--
	local button = CreateFrame("Button", "QuestOutLoud."..name, parent)
	button:SetPoint("TOPLEFT", parent, "TOPLEFT", 60, -30)
	button:SetWidth(75)
	button:SetHeight(25)
	button:SetText("Play")
	button:SetNormalFontObject("GameFontNormal")
	--
	button:SetScript("OnClick", function(self, button)
		local index = GetQuestLogSelection()
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory = GetQuestLogTitle(index)
		QuestOutLoud:Debug("Quest log button: QID = "..questID)
		local triggerType = "questAccept"
		if QuestFrameProgressPanel:IsVisible() then
			triggerType = "questProgress"
		elseif QuestFrameRewardPanel:IsVisible() then
			triggerType = "questCompletion"
		end
		QuestOutLoud:RequestSound(triggerType,questID)
	end)
	--
	local ntex = button:CreateTexture()
	ntex:SetTexture("Interface/Buttons/UI-Panel-Button-Up")
	ntex:SetTexCoord(0, 0.625, 0, 0.6875)
	ntex:SetAllPoints()	
	button:SetNormalTexture(ntex)
	--
	local htex = button:CreateTexture()
	htex:SetTexture("Interface/Buttons/UI-Panel-Button-Highlight")
	htex:SetTexCoord(0, 0.625, 0, 0.6875)
	htex:SetAllPoints()
	button:SetHighlightTexture(htex)
	--
	local ptex = button:CreateTexture()
	ptex:SetTexture("Interface/Buttons/UI-Panel-Button-Down")
	ptex:SetTexCoord(0, 0.625, 0, 0.6875)
	ptex:SetAllPoints()
	button:SetPushedTexture(ptex)
	--
	return button
end
----


-- QUEST_LOG_UPDATE
---- EVENT - Called when the quest log is updated
function QuestOutLoud_Quest:QUEST_LOG_UPDATE()
end
----


-- QUEST_DETAIL
---- EVENT - Called the quest detail page is shown
function QuestOutLoud_Quest:QUEST_DETAIL()
end
----


-- QUEST_GREETING
---- EVENT - Called when the quest greeting is shown
function QuestOutLoud_Quest:QUEST_GREETING()
end
----


-- QUEST_TURNED_IN
---- EVENT - Called when a quest is turned in
function QuestOutLoud_Quest:QUEST_TURNED_IN()
end
----


-- QUEST_PROGRESS
---- EVENT - Called when the quest progress page is shown
function QuestOutLoud_Quest:QUEST_PROGRESS()
end
----


-- QUEST_ACCEPTED
---- EVENT - Called when a quest is accepted
function QuestOutLoud_Quest:QUEST_ACCEPTED()
end
----