class AbilityCategorizationAlgorithms extends Object;

public static function bool IsAbilityInputTriggered(X2AbilityTemplate Template)
{
	local int Index;
	local bool bInputTriggered;

	bInputTriggered = false;
	if (Template != None)
	{
		for( Index = 0; Index < Template.AbilityTriggers.Length && !bInputTriggered; ++Index )
		{
			bInputTriggered = Template.AbilityTriggers[Index].IsA('X2AbilityTrigger_PlayerInput');
		}
	}

	return bInputTriggered;
}

public static function Default(out array<AbilityCategoryAssociation> data, X2AbilityTemplate Template) {
	local AbilityCategoryAssociation association;

	association.AbilityTemplateName = Template.DataName;
	association.CategoryName = '';

	if(AbilityCategoryTemplate(Template) != none) {
		// don't generate category data for categories, they have to be set up manually
		return;
	}
	
	if(IsAbilityConsumableExplosive(Template)) {
		association.CategoryName = `ACD.AbilityCategory_Item;
	} else if(IsAbilityPsionic(Template)) {
		association.CategoryName = `ACD.AbilityCategory_Psionic; 
	} else if(IsAbilityWeaponBased(Template)) {
		association.CategoryName = `ACD.AbilityCategory_Weapon;
	} else if(IsAbilityGremlinBitBased(Template)) {
		association.CategoryName = `ACD.AbilityCategory_Electronic;
	} else if(IsAbilityOverwatchSetup(Template)) {
		association.CategoryName = `ACD.AbilityCategory_Weapon;
	}
	
	if(association.CategoryName != '') {
		data.AddItem(association);
	}
}

public static function bool IsAbilityConsumableExplosive(X2AbilityTemplate Template) {
	return Template.bUseThrownGrenadeEffects || Template.bUseLaunchedGrenadeEffects;
}

public static function bool IsAbilityWeaponBased(X2AbilityTemplate Template) {
	return Template.bAllowBonusWeaponEffects || Template.bAllowAmmoEffects;
}

public static function bool IsAbilityGremlinBitBased(X2AbilityTemplate Template) {
	local name iterator;

	foreach Template.PostActivationEvents(iterator) {
		if(iterator == 'ItemRecalled') {
			return true;
		}
	}

	return false;
}

public static function bool IsAbilityPsionic(X2AbilityTemplate Template) {
	return Template.AbilitySourceName == 'eAbilitySource_Psionic';
}

public static function bool IsAbilityOverwatchSetup(X2AbilityTemplate Template) {
	return Template.CinescriptCameraType == "Overwatch";
}