// Apparently using data structures in classes alphabetically inferior to their object is not possible. Thanks Mr. Unreal
class AAbilityCategoryDataStructures extends Object config(AbilityCategories);

struct AbilityCategory {
    var name CategoryName;
    var String CategoryColor;
    var name AbilityTemplateName; // the ability categories are technically abilites
    var String IconImage;
    var int HUDPriority;
};

struct AbilityCategoryAssociation {
    var name AbilityTemplateName;
    var name CategoryName;
};
