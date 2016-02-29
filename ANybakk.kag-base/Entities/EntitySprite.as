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
      
      //Set default animation state (conveyor is not placed yet)
      this.SetAnimation("default");
      
      //Set default frame to 0
      this.animation.frame = 0;
      
      //Retrieve a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      //Disable recently scaled flag
      blob.Untag("EntitySprite::wasScaled");
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
    
      CBlob@ blob = this.getBlob();
      
      if(blob !is null && blob.hasTag("EntitySprite::wasScaled")) {
      
        //Disable flag
        blob.Untag("EntitySprite::wasScaled");
        
      }
      
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
    
    
    
    void scale(CSprite@ this, Vec2f newSize=ANybakk::EntityVariables::DEFAULT_SCALE_TO_SIZE) {
    
      //Retrieve current width
      int width = this.getFrameWidth();
      
      //Retrieve current height
      int height = this.getFrameHeight();
      
      //Retrieve current offset
      Vec2f offset = this.getOffset();
      
      //Determine scaling factors
      f32 scaleWidth = newSize.x * ((width > newSize.x && offset.x >= 0) ? -1.0f : 1.0f) / width;
      f32 scaleHeight = newSize.y * ((height > newSize.y && offset.y >= 0) ? -1.0f : 1.0f) / height;
      
      //Scale
      this.ScaleBy(Vec2f(scaleWidth, scaleHeight));
      
      //Tag as recently scaled
      this.getBlob().Tag("EntitySprite::wasScaled");
      
    }
    
    
    
  }
  
}