/* 
 * Structure blob.
 * 
 * Author: ANybakk
 */



namespace Transports {

  namespace StructureBlob {



    void onInit(CBlob@ this) {
      
      setTags(this);
      
      //Set background tile type (for TileBackground.as)
      this.set_TileType("background tile", Transports::StructureVariables::BACKGROUND_TILE_TYPE);
      
      //Set default orientation
      this.set_u16("StructureBlobOrientation", Transports::StructureVariables::DEFAULT_ORIENTATION);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isStructure");
      this.Untag("isPlaced");
      this.Untag("wasPlaced");
      
    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {

      //Check if not static
      if(!isStatic) {
        
        //Finished, entity not yet static
        return;
        
      }
      
      //Tag as placed (used by sprite/sound)
      this.Tag("wasPlaced");
      
      //Tag as placed
      this.Tag("isPlaced");
      
      //Store orientation using segment's angle
      this.set_u16("StructureBlobOrientation", this.getShape().getAngleDegrees());
      
    }
    
    
    
    bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

      return false;

    }
    
    
    
  }
  
}