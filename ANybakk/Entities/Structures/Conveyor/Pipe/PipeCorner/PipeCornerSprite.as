/* 
 * Pipe Funnel sprite.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "StructureSprite.as";
#include "PipeSprite.as";



namespace Transports {

  namespace PipeCornerSprite {
  
  
  
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
    
      //Update frame depending on orientation (4 variants)
      Transports::StructureSprite::updateFrameFromOrientation(this, 4);
    
      Transports::PipeSprite::onTick(this);
      
      return;
      
    }
    
    
    
  }
  
}