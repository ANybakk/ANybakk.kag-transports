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
    
    
    
    /**
     * Propels another blob upwards according to mode data rules
     */
    void propelUp(CBlob@ this, CBlob@ otherBlob) {
    
      //Create a vector for target velocity
      Vec2f targetVelocity = ANybakk::ConveyorBlob::getModeData(this).mTargetVelocity;
      
      //Set velocity upwards
      otherBlob.setVelocity(Vec2f(0.0f, -targetVelocity.y));
      
    }
    
    
    
    /**
     * Propels another blob rightwards according to mode data rules
     */
    void propelRight(CBlob@ this, CBlob@ otherBlob) {
    
      //Create a vector for target velocity
      Vec2f targetVelocity = ANybakk::ConveyorBlob::getModeData(this).mTargetVelocity;
      
      //Set velocity rightwards
      otherBlob.setVelocity(Vec2f(targetVelocity.x, 0.0f));
      
    }
    
    
    
    /**
     * Propels another blob downwards according to mode data rules
     */
    void propelDown(CBlob@ this, CBlob@ otherBlob) {
    
      //Create a vector for target velocity
      Vec2f targetVelocity = ANybakk::ConveyorBlob::getModeData(this).mTargetVelocity;
      
      ///Set velocity downwards
      otherBlob.setVelocity(Vec2f(0.0f, targetVelocity.y));
      
    }
    
    
    
    /**
     * Propels another blob leftwards according to mode data rules
     */
    void propelLeft(CBlob@ this, CBlob@ otherBlob) {
    
      //Create a vector for target velocity
      Vec2f targetVelocity = ANybakk::ConveyorBlob::getModeData(this).mTargetVelocity;
      
      //Set velocity leftwards
      otherBlob.setVelocity(Vec2f(-targetVelocity.x, 0.0f));
      
    }
    
    
    
  }
  
}