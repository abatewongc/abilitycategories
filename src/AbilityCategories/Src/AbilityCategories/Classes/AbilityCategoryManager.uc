class AbilityCategoryManager extends Object config(AbilityCategoryData);

var config array<AbilityCategoryAssociation> AbilityCategoryAssociations;

var const name AbilityCategory_Standard;
var const name AbilityCategory_Psionic;
var const name AbilityCategory_Misc;
var const name AbilityCategory_ROOT;
var const name AbilityCategory_BACK;
var const name AbilityCategory_ALWAYS_SHOW;

var AbilityCategory EmptyCategory;

defaultproperties
{
	AbilityCategory_Standard = "categoryStandard";
	AbilityCategory_Psionic = "categoryPsionic";
	AbilityCategory_Misc = "categoryMisc";
	AbilityCategory_ROOT = "categoryROOT";
	AbilityCategory_ALWAYS_SHOW = "categoryALWAYSSHOW";
	
	AbilityCategory_BACK = "AbilityCategory_BACK";
	EmptyCategory=(CategoryName="",CategoryColor="",AbilityTemplateName="",IconImage="",HUDPriority=0);
	
}

static function AbilityCategoryManager GetAbilityCategoryManager()
{
	return new class'AbilityCategoryManager';
}

static function name GetCategoryForAbility(X2AbilityTemplate Template) {
	local int index;
	local AbilityCategoryTemplate ACTemplate;

	index = default.AbilityCategoryAssociations.Find('AbilityTemplateName', Template.DataName);
	if(index != INDEX_NONE) {
		return default.AbilityCategoryAssociations[index].CategoryName;
	} else {
		// TODO: TEMPORARY, this doesn't support subcategories
		ACTemplate = AbilityCategoryTemplate(Template);
		if(ACTemplate != none) {
			return default.AbilityCategory_ROOT;
		}
		// do our best to find what category this is gonna go in.
		switch(Template.AbilitySourceName) {
			case 'eAbilitySource_Standard':
				return default.AbilityCategory_Standard;
			case 'eAbilitySource_Psionic':
				return default.AbilityCategory_Psionic;
			default:
				return default.AbilityCategory_Misc;
		}
	}
}