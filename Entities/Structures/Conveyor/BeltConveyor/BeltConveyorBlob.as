/* 
 * Belt Conveyor blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlob.as";
#include "ConveyorBlobMode.as";



namespace Transports {

  namespace BeltConveyorBlob {



    void onInit(CBlob@ this) {
    
      Transports::ConveyorBlob::onInit(this);
      
      setTags(this);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isBeltConveyor");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      //Retrieve current mode
      u8 currentMode = this.get_u8("ConveyorBlobMode");
      
      //Check if mode is not off
      if(currentMode != Transports::ConveyorBlobMode::MODE_OFF) {
      
        //Create an array of blob object references
        CBlob@[] nearbyBlobs;
        
        //Create a handle for a blob object
        CBlob@ nearbyBlob;
        
        //Check if any blobs are within radius
        if(this.getMap().getBlobsInRadius(this.getPosition(), this.getRadius(), @nearbyBlobs)) {
        
          //Determine current mode
          bool isFacingLeft = this.isFacingLeft();
          
          //Iterate through blob objects
          for(u8 i = 0; i<nearbyBlobs.length; i++) {
          
            //Keep a reference to this blob object
            @nearbyBlob = nearbyBlobs[i];
            
            //Check if blob is not this blob and not tagged as conveyor
            //TODO: Maybe also exclude any static blobs in general
            if(nearbyBlob !is this && !nearbyBlob.hasTag("isConveyor")) {
            
              //Create a movement vector
              Vec2f movement(3.0f, 0.0f);
              
              //Check if conveyor is facing left
              if(isFacingLeft) {
              
                //Set horizontal movement in left direction
                movement.x *= -1.0f;
              
              }
              
              //Add a force to the left
              nearbyBlob.AddForce(movement);
              
            }
            
            
          }
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}