/* 
 * Pipe blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlob.as";



namespace ANybakk {

  namespace PipeBlob {



    void onInit(CBlob@ this) {
    
      ANybakk::ConveyorBlob::onInit(this);
      
      setTags(this);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipe");
      
      //Unset animation synchronized flag (pipes aren't animated collectively)
      this.Untag("isAnimationSynchronized");
      
      //Unset sound synchronized flag (pipes aren't animated collectively)
      this.Untag("isSoundSynchronized");
      
      //Unset flag so that blob can be rotated when built (for BlobPlacement.as)
      this.Untag("place norotate");

      //Set flag so that blob isn't flipped depending on direction faced (for BlobPlacement.as)
      this.Tag("place ignore facing");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      ANybakk::ConveyorBlob::onTick(this);
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
      
      //Finished, return false always
      return false;

    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      ANybakk::ConveyorBlob::onSetStatic(this, isStatic);
      
    }
    
    
    
  }
  
}