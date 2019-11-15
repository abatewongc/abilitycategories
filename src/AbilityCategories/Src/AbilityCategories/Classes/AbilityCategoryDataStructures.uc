class AbilityCategoryDataStructures extends Object config(AbilityCategories);

struct AbilityCategory {
    var name CategoryName;
    var String CategoryColor;
    var name AbilityTemplateName; // the ability categories are technically abilites
    var String IconImage;
    var int HUDPriority;
};

struct AbilityCategoryAssociation {
    var name CategoryName;
    var name AbilityTemplateName;
};



