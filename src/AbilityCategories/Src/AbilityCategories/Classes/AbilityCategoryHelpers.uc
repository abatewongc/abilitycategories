class AbilityCategoryHelpers extends Object;

var AbilityCategory RootAbilityCategory;
var int NumberOfCategories;

static function ACLog(string message, optional bool bShouldRedScreenToo = false, optional bool bShouldOutputToConsoleToo = false) {
	local bool b;
	local name mod;

	b = `DLCINFO.IsDebuggingEnabled();
	if(!b) {
		return;
	}
	mod = 'AbilityCategories';

	`LOG(message, b, mod);
	if(bShouldRedScreenToo) {
		`RedScreen(mod $ ": " $ message);
	}
	if(bShouldOutputToConsoleToo) {
		class'Helpers'.static.OutputMsg(mod $ ": " $ message);
	}
}

static function int GetNumberOfCategories() {
	return default.NumberOfCategories;
}

defaultproperties
{
	RootAbilityCategory=(CategoryName="categoryROOT",CategoryColor="9acbcb") // NORMAL_HTML_COLOR
	NumberOfCategories=0
}