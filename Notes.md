V1 Architecture:

UITacticalHUD
-> UITacticalHUD_AbilityContainer
    -> UITacticalHUD_Ability
    -> UITacticalHUD_Ability
    -> ...

V2 Architecture:

UITacticalHUD
-> UITacticalHUD_AbilityContainer
    -> UITacticalHUD_AbilityCategory
        -> UITacticalHUD_Ability
        -> UITacticalHUD_Ability
        -> UITacticalHUD_AbilityCategory
            -> UITacticalHUD_Ability
            -> UITacticalHUD_Ability
    -> UITacticalHUD_AbilityCategory
        -> UITacticalHUD_Ability

V3 Architecture (X2AbilityTemplate)
-> UITacticalHUD_AbilityContainer (root)
    -> ACUITacticalHUD_AbilityCategory (shoot)
    -> ACUITacticalHUD_AbilityCategory (overwatch)
    -> ACUITacticalHUD_AbilityCategory (etc)
    -> ACUITacticalHUD_AbilityCategory (category 1)
        -> ACUITacticalHUD_AbilityCategory (back)
        -> ACUITacticalHUD_AbilityCategory (category 2 ability 1)
        -> ACUITacticalHUD_AbilityCategory (category 2 ability 2)
        -> ...
    -> ACUITacticalHUD_AbilityCategory (category 2)
        -> ...





