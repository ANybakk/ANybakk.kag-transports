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
    
      Transports::ConveyorBlob::onTick(this);
      
      /*
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
        
          //Determine if facing left
          bool isFacingLeft = this.isFacingLeft();
          
          //Iterate through blob objects
          for(u8 i = 0; i<nearbyBlobs.length; i++) {
          
            //Keep a reference to this blob object
            @nearbyBlob = nearbyBlobs[i];
            
            //Create a vector representing the relative displacement
            Vec2f relativeDisplacement = nearbyBlob.getPosition() - this.getPosition();
            
            //Check if blob is not this blob, not tagged as conveyor and at least 45 degrees from positive y-axis
            //TODO: Maybe also exclude any static blobs in general
            if(nearbyBlob !is this && !nearbyBlob.hasTag("isConveyor") && relativeDisplacement.y < 0.5f) {
            
              //If blob is not tagged as touching
              if(!nearbyBlob.hasTag("isTouchingBeltConveyor")) {
              
                //Tag as touching
                nearbyBlob.Tag("isTouchingBeltConveyor");
                
                //Create a movement vector
                Vec2f movement(2.0f, 0.0f);//Transports::ConveyorVariables::SLOW_VELOCITY * nearbyBlob.getMass()
                
                //Check if conveyor is facing left
                if(isFacingLeft) {
                
                  //Set horizontal movement in left direction
                  movement.x *= -1.0f;
                
                }
                
                //Add force
                nearbyBlob.setVelocity(nearbyBlob.getVelocity() + movement);//AddForce(movement);
                
              }
              
            }
            
            
          }
          
        }
        
      }*/
      
      //Finished
      return;
      
    }
    
    
    
    void onCollision(CBlob@ this, CBlob@ otherBlob, bool solid, Vec2f normal, Vec2f point1) {
    
      //If this is tagged as placed, other is a valid blob, and not a conveyor
      if(this.hasTag("isPlaced") && otherBlob !is null && !otherBlob.hasTag("isConveyor")) {
      
        //Check if tagged as touching
        if(!otherBlob.hasTag("isTouchingBeltConveyor")) {
      
          //Tag as touching
          otherBlob.Tag("isTouchingBeltConveyor");
          
          //Create a movement vector
          Vec2f acceleration(250.0f, 0.0f);//Transports::ConveyorVariables::SLOW_VELOCITY * otherBlob.getMass()
          
          //Check if conveyor is facing left
          if(this.isFacingLeft()) {
          
            //Set horizontal movement in left direction
            acceleration.x *= -1.0f;
          
          }
          
          //Add force
          otherBlob.AddForce(acceleration);//otherBlob.setVelocity(otherBlob.getVelocity() + acceleration);//
          
        }
        
        //Otherwise, tagged as touching
        else {
        
          //TODO: Add small force to compensate for friction
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    void onEndCollision(CBlob@ this, CBlob@ otherBlob) {
    
      if(otherBlob !is null) {
        print("VELOCITY: x=" + otherBlob.getVelocity().x + " y=" + otherBlob.getVelocity().y);
        //TODO: how to check for positive y-axis movement?
        bool isMovingUpwards = otherBlob.getVelocity().y < 4.0f;
        print("moving upwards?"+isMovingUpwards);
        //Check if moving upwards (blob left the belt conveyor)
        if(isMovingUpwards) {
        
          //Disable touching flag
          otherBlob.Untag("isTouchingBeltConveyor");
          
        }
      
      }
      
      //Finished
      return;

    }
    
    
    
  }
  
}