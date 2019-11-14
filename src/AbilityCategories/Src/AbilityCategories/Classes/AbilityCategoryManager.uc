class AbilityCategoryManager extends Object config(AbilityCategoryData);

var config array<AbilityCategoryAssociation> AbilityCategoryAssociations;

function name GetCategoryForAbility(X2AbilityTemplate Template) {
    local int index;

    index = AbilityCategoryAssociations.Find('AbilityTemplateName', Template.DataName);
    if(index != INDEX_NONE) {
        return AbilityCategoryAssociations[index].CategoryName;
    } else {
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