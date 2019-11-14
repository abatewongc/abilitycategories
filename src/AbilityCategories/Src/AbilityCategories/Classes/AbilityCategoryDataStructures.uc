class AbilityCategoryDataStructures extends Object config(AbilityCategories);

struct AbilityCategory {
    var name CategoryName;
    var name CategoryColor;
    var name AbilityTemplateName; // the ability categories are technically abilites
    var name IconImage;
    var name HUDPriority;
};

struct AbilityCategoryAssociation {
    var name CategoryName;
    var name AbilityTemplateName;
};

