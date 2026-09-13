enum TagsReference {
  beauty,
  fragrances,
  perfumes,
  mascara,
  eyeshadow,
  facePowder,
  lipstick,
  nailPolish,
  furniture,
  bed,
  sofas,
  bedsideTables,
  officeChairs,
  bathroom,
  fruits,
  meat,
  petSupplies,
  catFood,
  cookingEssentials,
  vegetables,
  dogFood,
  dairy,
  seafood,
  condiments,
  desserts,
  beverages
}

// Referencing tags with two words
extension TagReferenceTwoWord on TagsReference{
  String get displayTags{
    switch (this){
      case TagsReference.facePowder:
        return "face powder";
      case TagsReference.nailPolish:
        return "nail polish";
      case TagsReference.bedsideTables:
        return "bedside tables";
      case TagsReference.officeChairs:
        return "office chairs";
      case TagsReference.petSupplies:
        return "pet supplies";
      case TagsReference.catFood:
        return "cat food";
      case TagsReference.dogFood:
        return "dog food";
      case TagsReference.cookingEssentials:
        return "cooking essentials";
      default:
        return name;  // Fallback
    }
  }
}