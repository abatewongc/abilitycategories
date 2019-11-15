class ACCommandManager extends X2DownloadableContentInfo_AbilityCategories;

exec function DebugCategoryUI()
{
	local UITacticalHUD HUD;
	local UIScreen Screen;
	local UITacticalHUD_AbilityContainer DefaultContainer;
	local ACUITacticalHUD_AbilityContainer AbilityContainer;
	local UITacticalHUD_Ability	DefaultAbilityIterator;
	local ACUITacticalHUD_AbilityCategory AbilityIterator;


	Screen = `SCREENSTACK.GetFirstInstanceOf(class'UITacticalHUD');
	HUD = UITacticalHUD(Screen);
	
	if(HUD == none) {
		`ACLOG("Could not find UITacticalHUD. instead found " $ PathName(Screen));
		return;
	}

	DefaultContainer = HUD.m_kAbilityHUD;
	AbilityContainer = ACUITacticalHUD_AbilityContainer(DefaultContainer);
	if(AbilityContainer == none) {
		`ACLOG("Could not get ACUITacticalHUD_AbilityContainer!");
		return;
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

	}
	`ACLOG("------------------------------------------------------------------------------------------");


}
