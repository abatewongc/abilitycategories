class ACAbility_AbilityCategoryTemplateHandler extends X2Ability config(AbilityCategoryData);

var config array<AbilityCategory> AbilityCategories;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	local AbilityCategory IteratorData;

	`ACLOG("Adding Category Templates!");

	foreach default.AbilityCategories(IteratorData) {
		Templates.AddItem(CreateCategory(IteratorData));
		`ACLOG("Added category: " $ IteratorData.AbilityTemplateName);
	}

	return Templates;
}

static function X2AbilityTemplate CreateCategory(AbilityCategory CategoryData) {
	local AbilityCategoryTemplate	Template;

	`CREATE_X2TEMPLATE(class'AbilityCategoryTemplate', Template, CategoryData.AbilityTemplateName);
	Template.IconImage = CategoryData.IconImage;
	Template.AbilityIconColor = CategoryData.CategoryColor;

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.ShotHUDPriority = CategoryData.HUDPriority;

	Template.ConcealmentRule = eConceal_Always;

	Template.AbilityCosts.AddItem(default.FreeActionCost);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	Template.BuildNewGameStateFn = Empty_BuildGameState;
	// Note: no visualization on purpose!
	Template.bCrossClassEligible = false;

	Template.CategoryData = CategoryData;

	return Template;
}

function XComGameState Empty_BuildGameState( XComGameStateContext Context )
{
	return none;
}