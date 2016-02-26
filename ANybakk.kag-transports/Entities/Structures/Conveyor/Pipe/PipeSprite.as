/* 
 * Pipe sprite.
 * 
 * Author: ANybakk
 */

#include "StructureSpriteLayer.as";
#include "ConveyorSprite.as";



namespace ANybakk {

  namespace PipeSprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
    
      ANybakk::ConveyorSprite::onInit(this);
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
      
      //Check if recently placed
      if(this.getBlob().hasTag("wasPlaced")) {
      
        //Put in the background, behind ladders
        this.SetZ(ANybakk::StructureSpriteLayer::LAYER_BEHIND_LADDER);
        
      }
    
      ANybakk::ConveyorSprite::onTick(this);
      
      //Finished
      return;
      
    }



    /**
     * Rendering event function
     */
    void onRender(CSprite@ this) {
    
      ANybakk::ConveyorSprite::onRender(this);
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}