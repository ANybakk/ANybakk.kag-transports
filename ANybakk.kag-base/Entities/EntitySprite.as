/* 
 * Entity sprite.
 * 
 * Author: ANybakk
 */

#include "EntitySpriteLayer.as";


namespace ANybakk {

  namespace EntitySprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
      
      //Retrieve a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      //Set default animation state (conveyor is not placed yet)
      this.SetAnimation("default");
      
      //Set default frame to 0
      this.animation.frame = 0;
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
      
      //Finished
      return;
      
    }
    
    
    
    /**
     * Sets layer
     * 
     * @param   layer     what layer (Z-index) to put this sprite in.
     */
    void setLayer(CSprite@ this, int layer = ANybakk::EntitySpriteLayer::LAYER_DEFAULT) {
    
      //Set layer
      this.SetZ(layer);
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}