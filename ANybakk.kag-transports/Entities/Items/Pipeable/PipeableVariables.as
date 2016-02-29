


namespace ANybakk {

  namespace ItemVariables {
  
  }

  namespace PipeableVariables {
  
    //Define an array of vanilla object names that should be considered pipeable
    const string[] VANILLA_PIPEABLE_NAMES = { "bomb", "waterbomb", "mine", "lantern", "powerup", "arrow", "sponge" };
    
    //Define an array of vanilla group tag names that should be considered pipeable
    const string[] VANILLA_PIPEABLE_GROUP_NAMES = { "material", "food" };
    
    //Define a shrinkage on entering pipe flag
    const bool SHRINK_ON_ENTERED_PIPE = false;
    
    //Define a shrink size of 8.0, 8.0
    const Vec2f SHRINK_TO_SIZE(8.0f, 8.0f);
    
  }
  
}