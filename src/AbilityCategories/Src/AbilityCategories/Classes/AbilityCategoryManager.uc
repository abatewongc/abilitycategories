class AbilityCategoryManager extends Object config(AbilityCategoryData);

var config array<AbilityCategoryAssociation> AbilityCategoryAssociations;
var array<AbilityCategoryAssociation> CachedAbilityCategoryAssociations;

var const name AbilityCategory_Standard;
var const name AbilityCategory_Weapon;
var const name AbilityCategory_Psionic;
var const name AbilityCategory_Misc;
var const name AbilityCategory_Item;
var const name AbilityCategory_Electronic;

var const name AbilityCategory_ROOT;
var const name AbilityCategory_BACK;
var const name AbilityCategory_ALWAYS_SHOW;

var AbilityCategory EmptyCategory;

defaultproperties
{
	AbilityCategory_Standard = "categoryStandard";
	AbilityCategory_Weapon = "categoryWeapon";
	AbilityCategory_Psionic = "categoryPsionic";
	AbilityCategory_Misc = "categoryMisc";
	AbilityCategory_Item = "categoryItem";
	AbilityCategory_Electronic = "categoryElectronic";

	// special
	AbilityCategory_ROOT = "categoryROOT";
	AbilityCategory_ALWAYS_SHOW = "categoryALWAYSSHOW";
	AbilityCategory_BACK = "AbilityCategory_BACK";
	EmptyCategory=(CategoryName="",CategoryColor="",AbilityTemplateName="",IconImage="",HUDPriority=0);
	
}

static function AbilityCategoryManager GetAbilityCategoryManager()
{
	return AbilityCategoryManager(class'XComEngine'.static.GetClassDefaultObject(class'AbilityCategoryManager'));
}

static function name GetCategoryForAbility(X2AbilityTemplate Template, XComGameState_Ability AbilityState) {
	local int index;
	local AbilityCategoryTemplate ACTemplate;
	local name foundName;

	//`ACLOG("Getting Category for Ability: " $ Template.DataName);

	index = default.AbilityCategoryAssociations.Find('AbilityTemplateName', Template.DataName);
	if(index != INDEX_NONE) {
		foundName = default.AbilityCategoryAssociations[index].CategoryName;
		//`ACLOG("Found it in AbilityCategoryAssociations, was " $ foundName);
		return foundName;
	}
	
	index = default.CachedAbilityCategoryAssociations.Find('AbilityTemplateName', Template.DataName);
	if(index != INDEX_NONE) {
		foundName = default.CachedAbilityCategoryAssociations[index].CategoryName;
		//`ACLOG("Found it in CachedAbilityCategoryAssociations, was " $ foundName);
		return foundName;
	}

	// Fallback selection logic
	// TODO: TEMPORARY, this doesn't support subcategories
	ACTemplate = AbilityCategoryTemplate(Template);
	if(ACTemplate != none) {
		return default.AbilityCategory_ROOT;
	}
	// do our best to find what category this is gonna go in.
	switch(Template.AbilitySourceName) {
		case 'eAbilitySource_Standard':
		case 'eAbilitySource_Perk':
			foundName =  default.AbilityCategory_Standard;
		case 'eAbilitySource_Psionic':
			foundName =  default.AbilityCategory_Psionic;
		case 'eAbilitySource_Item':
			foundName =  default.AbilityCategory_Item;
		case 'eAbilitySource_Commander':
			foundName =  default.AbilityCategory_ROOT;
		default:
			foundName =  default.AbilityCategory_Misc;
	}

	//`ACLOG("Had to fallback to AbilitySourceName, final result was " $ foundName);
	return foundName;
}