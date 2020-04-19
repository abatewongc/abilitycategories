class ACCommandManager extends X2DownloadableContentInfo_AbilityCategories;

exec function DebugCategoryUI()
{
	local ACUITacticalHUD_AbilityContainer AbilityContainer;
	local UITacticalHUD_Ability	DefaultAbilityIterator;
	local ACUITacticalHUD_AbilityCategory AbilityIterator;
	local int i;


	AbilityContainer = GetAbilityCategoryContainer();
	if(AbilityContainer == none) {
		`ACLOG("Could not get ACUITacticalHUD_AbilityContainer!");
		return;
	}

	`ACLOG("CurrentAbilityCategory: " $ AbilityContainer.GetCurrentAbilityCategory());
	`ACLOG("AbilityCategoryStack: ");
	for(i = 0; i < AbilityContainer.AbilityCategoryStack.Length; ++i) {
		`ACLOG("AbilityCategoryStack["$i$"]: " $ AbilityContainer.AbilityCategoryStack[i]);
	}

	`ACLOG("Printing AbilityData:");
	foreach AbilityContainer.m_arrUIAbilities(DefaultAbilityIterator) {
		AbilityIterator = ACUITacticalHUD_AbilityCategory(DefaultAbilityIterator);
		if(AbilityIterator == none) {
			`ACLOG("Could not find ACUITacticalHUD_AbilityCategories!");
			return;
		}

		`ACLOG("------------------------------------------------------------------------------------------");
		`ACLOG("Found ACUITacticalHUD_AbilityCategory " $ AbilityIterator.MCName);
		`ACLOG("X2AbilityTemplateName = " $ AbilityIterator.AbilityTemplate.DataName);
		`ACLOG("ParentCategoryName = " $ AbilityIterator.GetParentCategoryName());

	}
	`ACLOG("------------------------------------------------------------------------------------------");
}

exec function ResetCategoryUI() {
	local ACUITacticalHUD_AbilityContainer AbilityContainer;

	AbilityContainer = GetAbilityCategoryContainer();
	if(AbilityContainer == none) {
		`ACLOG("Could not get ACUITacticalHUD_AbilityContainer!");
		return;
	}

	AbilityContainer.ResetAbilityCategoryStack();
	AbilityContainer.UpdateAbilitiesArray();
}

private function ACUITacticalHUD_AbilityContainer GetAbilityCategoryContainer() {
	local UIScreen Screen;
	local UITacticalHUD HUD;
	local ACUITacticalHUD_AbilityContainer AbilityContainer;
	local UITacticalHUD_AbilityContainer DefaultContainer;

	Screen = `SCREENSTACK.GetFirstInstanceOf(class'UITacticalHUD');
	HUD = UITacticalHUD(Screen);
	
	if(HUD == none) {
		`ACLOG("Could not find UITacticalHUD. instead found " $ PathName(Screen));
		return none;
	}

	DefaultContainer = HUD.m_kAbilityHUD;
	AbilityContainer = ACUITacticalHUD_AbilityContainer(DefaultContainer);

	return AbilityContainer;
}