/* 
 * Pipe Straight sprite.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "StructureSprite.as";
#include "PipeSprite.as";



namespace ANybakk {

  namespace PipeStraightSprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
    
      ANybakk::PipeSprite::onInit(this);
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
    
      //Update frame depending on orientation (2 variants)
      ANybakk::StructureSprite::updateFrameFromOrientation(this, 2);
      
      ANybakk::PipeSprite::onTick(this);
      
      //Finished
      return;
      
    }



    /**
     * Rendering event function
     */
    void onRender(CSprite@ this) {
    
      ANybakk::PipeSprite::onRender(this);
      
    }
    
    
    
  }
  
}