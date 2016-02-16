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
      
      //Retrieve current mode
      u8 currentMode = this.get_u8("ConveyorBlobMode");
      
      //Check if mode is not off
      if(currentMode != Transports::ConveyorBlobMode::MODE_OFF) {
      
        //Obtain a reference to the map object
        CMap@ map = this.getMap();
      
        //Create an array of blob object references
        CBlob@[] nearbyBlobs;
        
        //Check if any blobs are within radius
        if(map.getBlobsInRadius(this.getPosition(), map.tilesize, @nearbyBlobs)) {
        
          //Create a handle for a blob object
          CBlob@ nearbyBlob;
          
          //Create a vector representing the relative displacement
          Vec2f relativeDisplacement;
        
          //Determine if facing left
          bool isFacingLeft = this.isFacingLeft();
          
          //Iterate through blob objects
          for(u8 i = 0; i<nearbyBlobs.length; i++) {
          
            //Keep a reference to this blob object
            @nearbyBlob = nearbyBlobs[i];
            
            //Keep relative displacement
            relativeDisplacement = nearbyBlob.getPosition() - this.getPosition();
            
            //Check if blob is not this blob, not tagged as conveyor and is above
            //TODO: Maybe also exclude any static blobs in general
            if(nearbyBlob !is this && !nearbyBlob.hasTag("isConveyor") && relativeDisplacement.y <= 0.0f) {
              
              //If blob is tagged as touching
              if(nearbyBlob.hasTag("isTouchingBeltConveyor")) {
                
                //Obtain a vector for the blob's current velocity
                Vec2f currentVelocity = nearbyBlob.getVelocity();
                
                //Create a vector for target velocity
                Vec2f targetVelocity = Vec2f(0.0f, 0.0f);
                
                //Iterate through modes
                for(u8 i=0; i<Transports::ConveyorVariables::MODE_DATA.length; i++) {
                
                  //Check if current mode
                  if(Transports::ConveyorVariables::MODE_DATA[i].mMode == currentMode) {
                  
                    //Keep target velocity vector
                    targetVelocity = Transports::ConveyorVariables::MODE_DATA[i].mTargetVelocity;
                    
                    //End loop
                    break;
                    
                  }
                
                }
                
                //Check if conveyor is facing left
                if(isFacingLeft) {
                
                  //Set horizontal velocity in left direction
                  targetVelocity.x *= -1.0f;
                
                }
                
                //Determine what acceleration to apply (a = v / t)
                Vec2f acceleration = (targetVelocity - currentVelocity) / (Transports::ConveyorVariables::TIME_FOR_TARGET_VELOCITY * getTicksASecond());
                
                //Add force impulse (F = m * a)
                nearbyBlob.AddForce(acceleration * nearbyBlob.getMass());
                
              }
            
              /*
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
              */
              
            }
            
          }
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    void onCollision(CBlob@ this, CBlob@ otherBlob, bool solid, Vec2f normal, Vec2f point1) {
    
      //If this is tagged as placed, other is a valid blob, and not a conveyor
      if(this.hasTag("isPlaced") && otherBlob !is null && !otherBlob.hasTag("isConveyor")) {
      
        //Check if not tagged as touching
        if(!otherBlob.hasTag("isTouchingBeltConveyor")) {
      
          //Tag as touching
          otherBlob.Tag("isTouchingBeltConveyor");
          
          //Create a movement vector
          //Vec2f acceleration(250.0f, 0.0f);//Transports::ConveyorVariables::SLOW_VELOCITY * otherBlob.getMass()
          
          //Check if conveyor is facing left
          //if(this.isFacingLeft()) {
          
            //Set horizontal movement in left direction
            //acceleration.x *= -1.0f;
          
          //}
          
          //Add force
          //otherBlob.AddForce(acceleration);//otherBlob.setVelocity(otherBlob.getVelocity() + acceleration);//
          
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
        
        //Determine if other blob is moving upwards
        bool isMovingUpwards = otherBlob.getVelocity().y < 0.0f;
        
        //Check if moving upwards (blob left the belt conveyor)
        if(isMovingUpwards) {
        
          //Disable touching flag
          otherBlob.Untag("isTouchingBeltConveyor");
          
        }
      
      }
      
      //Finished
      return;

    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      Transports::ConveyorBlob::onSetStatic(this, isStatic);
      
      //Check if recently placed
      if(this.hasTag("wasPlaced")) {
      
        //Obtain a reference to the map object
        CMap@ map = this.getMap();
        
        //Set tile type to 256 (just to get proper collision)
        map.server_SetTile(this.getPosition(), 256);
        
        //Obtain a reference to the sprite object
        CSprite@ sprite = this.getSprite();
        
        //Check if sprite is valid
        if(sprite !is null) {
        
          //Set z-index to 500 (overlapping tile)
          sprite.SetZ(500);
          
        }
        
        //Retrieve tile space position
        Vec2f tileSpacePosition = map.getTileSpacePosition(this.getPosition());
        
        //Retrieve the offset index for this tile
        int tileOffset = map.getTileOffsetFromTileSpace(tileSpacePosition);
        
        //Set solid and collision flags for this tile
        map.AddTileFlag(tileOffset, Tile::SOLID | Tile::COLLISION);
      
      }
      
    }
    
    
    
    void onDie(CBlob@ this) {
    
      //Obtain a reference to the map object
      CMap@ map = this.getMap();
      
      //Set empty tile
      map.server_SetTile(this.getPosition(), CMap::tile_empty);
      
    }
    
    
    
  }
  
}