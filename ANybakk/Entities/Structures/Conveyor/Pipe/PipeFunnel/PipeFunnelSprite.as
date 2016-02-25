/* 
 * Pipe Funnel sprite.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "StructureSprite.as";
#include "PipeSprite.as";



namespace Transports {

  namespace PipeFunnelSprite {
  
  
  
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
      
      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      if(blob.hasTag("wasEntered")) {
      
        this.PlaySound("PipeFunnelEntered.ogg");
        
        blob.Untag("wasEntered");
        
      }
    
      Transports::PipeSprite::onTick(this);
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}