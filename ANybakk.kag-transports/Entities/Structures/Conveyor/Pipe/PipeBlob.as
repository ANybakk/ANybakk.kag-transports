/* 
 * Pipe blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlob.as";
#include "PipeableVariables.as"; //Required for PipeableBlob.as
#include "PipeableBlob.as";
#include "PipeableSprite.as";



namespace ANybakk {

  namespace PipeBlob {
  
  
  
    void onInit(CBlob@ this) {
    
      ANybakk::ConveyorBlob::onInit(this);
      
      setTags(this);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipe");
      
      //Unset animation synchronized flag (pipes aren't animated collectively)
      this.Untag("ConveyorBlob::isAnimationSynchronized");
      
      //Unset sound synchronized flag (pipes aren't animated collectively)
      this.Untag("ConveyorBlob::isSoundSynchronized");
      
      //Unset flag so that blob can be rotated when built (for BlobPlacement.as)
      this.Untag("place norotate");

      //Set flag so that blob isn't flipped depending on direction faced (for BlobPlacement.as)
      this.Tag("place ignore facing");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      ANybakk::ConveyorBlob::onTick(this);
      
      //Retrieve current mode
      u8 currentMode = this.get_u8("ConveyorBlobMode");
      
      //Check if mode is not off
      if(currentMode != ANybakk::ConveyorBlobMode::MODE_OFF) {
      
        //Propel any overlapping blobs
        releaseOverlappingOutside(this);
        
      }
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
      
      //Finished, return false always
      return false;

    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      ANybakk::ConveyorBlob::onSetStatic(this, isStatic);
      
    }
    
    
    
    /**
     * Propels any overlapping blobs that are in pipe
     */
    void releaseOverlappingOutside(CBlob@ this) {
      
      //Create an array of blobs
      CBlob@[] overlappingBlobs;
      
      //Check if any blobs are overlapping
      if(this.getOverlapping(@overlappingBlobs)) {
        
        //Retrieve current orientation
        u16 orientation = this.get_u16("StructureBlobOrientation");
        
        //Create a blob handle
        CBlob@ overlappingBlob;
        
        //Iterate through all overlapping blobs
        for(int i=0; i<overlappingBlobs.length; i++) {
        
          //Keep reference to this blob
          @overlappingBlob = overlappingBlobs[i];
          
          //Check if invalid blob or can't convey
          if(overlappingBlob is null || !canConvey(this, overlappingBlob)) {
          
            //Skip to the next one
            continue;
            
          }
          
          //Get blob's position
          Vec2f overlappingPosition = overlappingBlob.getPosition();
          
          //Check if outside and in pipe
          if(!this.isPointInside(overlappingPosition) && overlappingBlob.hasTag("PipeableBlob::isInPipe")) {
          
            //Obtain a reference to the map object
            CMap@ map = this.getMap();
            
            //Create a blob array
            CBlob@[] blobsAtPosition;
            
            //Create a valid pipe flag
            bool isValidPipe = false;
            
            //Check if any blobs at position
            if(map.getBlobsAtPosition(overlappingPosition, blobsAtPosition)) {
            
              //Create blob handle
              CBlob@ blobAtPosition;
              
              //Iterate through blobs
              for(int i=0; i<blobsAtPosition.length; i++) {
              
                //Keep blob reference
                @blobAtPosition = blobsAtPosition[i];
                
                //Check if blob is valid and is pipe
                if(blobAtPosition !is null && blobAtPosition.hasTag("isPipe")) {
                
                  //Check if connected
                  isValidPipe = isValidPipe || ANybakk::ConveyorBlob::isConnected(this, blobAtPosition);
                  
                }
                
              }
            
            }
            
            //Check if valid pipe was not found
            if(!isValidPipe) {
    
              //Tell pipeable to enter this pipe
              ANybakk::PipeableBlob::exitPipe(overlappingBlob);
              
              //Check if pipeable vanilla
              if(ANybakk::PipeableBlob::isConsideredPipeableVanilla(overlappingBlob)) {
              
                //Manually call sprite's onTick once (handler not associated with vanilla types)
                ANybakk::PipeableSprite::onTick(overlappingBlob.getSprite());
                
              }
              
            }
            
          }
          
        }
        
      }
      
      //Finished
      return;
      
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
    
    
    
    /**
     * Checks if a pipe funnel can convey another blob
     */
    bool canConvey(CBlob@ this, CBlob@ otherBlob) {
    
      return 
        this.hasTag("StructureBlob::isPlaced")
        && this.get_u8("ConveyorBlobMode") != ANybakk::ConveyorBlobMode::MODE_OFF
        && otherBlob !is null
        && !otherBlob.hasTag("isStructure")
        && ANybakk::PipeableBlob::isConsideredPipeable(otherBlob);
        
    }
    
    
    
  }
  
}