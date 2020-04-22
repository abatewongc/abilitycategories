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

public static function bool IsAbilityConsumableExplosive(X2AbilityTemplate Template) {
	return false;
}