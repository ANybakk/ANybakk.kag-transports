/* 
 * Conveyor blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";



namespace Transports {

  namespace ConveyorBlob {



    void onInit(CBlob@ this) {
      
      setTags(this);
      
      this.set_u8("ConveyorBlobMode", Transports::ConveyorBlobMode::MODE_OFF);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isConveyor");
      this.Untag("isPlaced");
      this.Untag("wasPlaced");
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
      
      //Finished, return true always
      return true;

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
      
      //Set mode to slow
      this.set_u8("ConveyorBlobMode", Transports::ConveyorVariables::DEFAULT_ON_MODE);
      
    }
    
    
    
    bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

      return false;

    }
    
    
    
  }
  
}