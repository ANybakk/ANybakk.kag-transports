/* 
 * Pipe Straight sprite.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "StructureSprite.as";
#include "PipeSprite.as";



namespace Transports {

  namespace PipeStraightSprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
    
      Transports::PipeSprite::onInit(this);
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
    
      //Update frame depending on orientation (2 variants)
      Transports::StructureSprite::updateFrameFromOrientation(this, 2);
      
      Transports::PipeSprite::onTick(this);
      
      //Finished
      return;
      
    }



    /**
     * Rendering event function
     */
    void onRender(CSprite@ this) {
    
      Transports::PipeSprite::onRender(this);
      
    }
    
    
    
  }
  
}