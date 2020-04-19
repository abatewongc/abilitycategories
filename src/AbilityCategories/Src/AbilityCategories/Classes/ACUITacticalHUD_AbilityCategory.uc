//----------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:	ACUITacticalHUD_AbilityCategory.uc
//  AUTHOR:  Brit Steiner, Sam Batista
//  PURPOSE: Containers holding current soldiers ability icons.
//----------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//----------------------------------------------------------------------------

class ACUITacticalHUD_AbilityCategory extends UITacticalHUD_Ability config (AbilityCategories);

var private bool IsCurrentlyCategory;
var private name ParentCategoryName; 
var private AbilityCategory CurrentAbilityCategory;

function bool IsCategory() {
	return IsCurrentlyCategory;
}

function AbilityCategory GetCategoryData() {
	return CurrentAbilityCategory;
}

function SetCategoryData(AbilityCategory data) {
	self.CurrentAbilityCategory = data;
}

function name GetParentCategoryName() {
	return ParentCategoryName;
}

simulated function ClearCategoryData() {
	IsCurrentlyCategory = false;
	ParentCategoryName = '';
	CurrentAbilityCategory = `ACD.EmptyCategory;
}

simulated function ClearData()
{
	if (!bIsInited)
	{
		return;
	}
	super.ClearData();
	ClearCategoryData();
}



simulated function UpdateData(int NewIndex, const out AvailableAction AvailableActionInfo) {
	local AbilityCategoryTemplate CategoryTemplate;
	local XComGameState_Ability AbilityState;
	local ACUITacticalHUD_AbilityContainer AbilityContainer;
	local int iTmp;

	AbilityContainer = ACUITacticalHUD_AbilityContainer(ParentPanel);
	if(AbilityContainer == none) {
		`LOG("Could not find Parent Panel for ACUITacticalHUD_AbilityCategory! Things are gonna get weird.", true, 'AbilityCategories');
	}

	super.UpdateData(NewIndex, AvailableActionInfo);
	
	ParentCategoryName = AbilityContainer.GetCurrentAbilityCategory();
	Index = NewIndex;

	//AvailableActionInfo function parameter holds UI-SPECIFIC data such as "is this ability visible to the HUD?" and "is this ability available"?
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AvailableActionInfo.AbilityObjectRef.ObjectID));
	CategoryTemplate = AbilityCategoryTemplate(AbilityState.GetMyTemplate());
	if(CategoryTemplate == none) {
		// this is really an ability, not an abilitycategory
		ClearCategoryData();
		return;
	}
	
	IsCurrentlyCategory = true;
	SetCategoryData(CategoryTemplate.CategoryData);

	// categories are always available (currently)
	SetAvailable(true);
	SetCooldown("");
	SetCharge("");

	//Set the icon
	Icon.LoadIcon(AbilityState.GetMyIconImage());
	// Set Antenna text, PC only
	if(Movie.IsMouseActive())
		SetAntennaText(class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(AbilityState.GetMyFriendlyName()));
	MC.FunctionBool("SetOverwatchButtonHelp", false);
	
	if(AbilityTemplate.AbilityIconColor != "") { // this is the category color
		Icon.EnableMouseAutomaticColor(AbilityTemplate.AbilityIconColor, class'UIUtilities_Colors'.const.BLACK_HTML_COLOR);
	} else {
		// just set default. This is an error path, so no need to handle further
		Icon.EnableMouseAutomaticColor(class'UIUtilities_Colors'.const.NORMAL_HTML_COLOR, class'UIUtilities_Colors'.const.BLACK_HTML_COLOR);
	}

	// HOTKEY LABEL (pc only)
	if(Movie.IsMouseActive())
	{
		iTmp = eTBC_Ability1 + Index;
		if( iTmp <= eTBC_Ability0 )
			SetHotkeyLabel(PC.Pres.m_kKeybindingData.GetPrimaryOrSecondaryKeyStringForAction(PC.PlayerInput, (eTBC_Ability1 + Index)));
		else
			SetHotkeyLabel("");
	}

	RefreshShine();
}

/*
simulated function OnMouseEvent(int cmd, array<string> args)
{
	local UITacticalHUD_AbilityContainer AbilityContainer;

	super.OnMouseEvent(cmd, args);

	Index = int(GetRightMost(string(MCName)));
	AbilityContainer = UITacticalHUD_AbilityContainer(ParentPanel);

	switch(cmd)
	{
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_IN:
		AbilityContainer.ShowAOE(Index);
		break;
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_OUT:
		AbilityContainer.HideAOE(Index);
		break;

	case class'UIUtilities_Input'.const.FXS_L_MOUSE_UP_DELAYED:
		RefreshShine();
		AbilityContainer.AbilityClicked(Index);
		break;
	case class'UIUtilities_Input'.const.FXS_L_MOUSE_DOUBLE_UP:
		if( AbilityContainer.AbilityClicked(Index) && AbilityContainer.GetTargetingMethod() != none )
		{
			AbilityContainer.OnAccept();
			AbilityContainer.ResetMouse();
			RefreshShine();
		}
		break;
	}
}*/



