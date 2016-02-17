/* 
 * Conveyor blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";
#include "ConveyorBlobDirection.as";



namespace Transports {

  namespace ConveyorBlob {



    void onInit(CBlob@ this) {
      
      setTags(this);
      
      //Set initial mode to OFF
      this.set_u8("ConveyorBlobMode", Transports::ConveyorBlobMode::MODE_OFF);
      
      //Set flag so that blob cannot be rotated when built (for BlobPlacement.as)
      this.Tag("place norotate");

      //Unset flag so that blob is flipped depending on direction faced (for BlobPlacement.as)
      this.Untag("place ignore facing");
      
      //Set flag so that builder always hit (for BuilderHittable.as)
      this.Tag("builder always hit");

      //Unset flag so that swords hit (for KnightLogic.as)
      //TODO: Sword won't do damage anyway
      this.set_bool("ignore sword", !Transports::ConveyorVariables::TAKE_DAMAGE_FROM_SWORD);
      
      //Set background tile type (for TileBackground.as)
      this.set_TileType("background tile", Transports::ConveyorVariables::BACKGROUND_TILE_TYPE);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isConveyor");
      this.Untag("isPlaced");
      this.Untag("wasPlaced");
      
    }
    
    
    
    void onTick(CBlob@ this) {
      
      //Update connections
      updateConnections(this, false, false);
      
      //Update direction
      updateDirection(this);
      
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
      
      //Update connections
      updateConnections(this, true, true);
      
      //Update direction
      updateDirection(this);
      
      //Set mode to default
      this.set_u8("ConveyorBlobMode", Transports::ConveyorVariables::DEFAULT_ON_MODE);
      
    }
    
    
    
    bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

      return false;

    }
    
    
    
    /**
     * Updates connection statuses for the blob (and any others of the same type in the same direction)
     * 
     * @param   doPropagate     whether to propagate linearly or not
     * @param   doAnimationSync whether to synchronize animations (if propagating)
     */
    void updateConnections(CBlob@ this, bool doPropagate=false, bool doAnimationSync=false) {
      
      //Check if placed
      if(this.hasTag("isPlaced")) {
      
        //Obtain a reference to the map
        CMap@ map = this.getMap();
        
        //Create an array of vector offsets (clockwise)
        Vec2f[] connectionOffsets = {Vec2f(0.0f, -map.tilesize), Vec2f(map.tilesize, 0.0f), Vec2f(0.0f, map.tilesize), Vec2f(-map.tilesize, 0.0f)};
        
        //Create an array of tag strings (clockwise)
        string[] connectionTags = {"isConnectedUp", "isConnectedRight", "isConnectedDown", "isConnectedLeft"};
        
        //Create a blob handle
        CBlob@ previousBlob;
        
        //Create a blob handle
        CBlob@ nextBlob;
        
        //Iterate through all possible connections
        for(u8 i=0; i<connectionOffsets.length; i++) {
        
          //Remove tag
          this.Untag(connectionTags[i]);
        
          //Reference this blob first
          @nextBlob = this;
          
          //Set valid flag
          bool nextIsValid = true;
        
          //Do at least once
          do {
          
            //Keep a reference to the previous segment
            @previousBlob = nextBlob;
            
            //Retrieve the next segment in line
            @nextBlob = map.getBlobAtPosition(previousBlob.getPosition() + connectionOffsets[i]);
            
            //Check if invalid blob reference
            if(nextBlob is null) {
            
              //Update flag
              nextIsValid = false;
              
            }
            
            //Otherwise, check if same type, tagged as conveyor, is placed, and faces the same direction
            else if(
                nextBlob.getName() == previousBlob.getName() 
                && nextBlob.hasTag("isConveyor") 
                && nextBlob.hasTag("isPlaced") 
                && nextBlob.isFacingLeft() == previousBlob.isFacingLeft()
              ) {
            
              //Set tag
              previousBlob.Tag(connectionTags[i]);
            
              //Check if propagate flag
              if(doPropagate) {
              
                //Set animation frame number
                nextBlob.getSprite().animation.frame = previousBlob.getSprite().animation.frame;
                
              }
              
            }
            
            //Otherwise
            else {
            
              //Update flag
              nextIsValid = false;
              
            }

          }

          //Repeat if propagate flag and valid flag
          while(doPropagate && nextIsValid);
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    /**
     * Updates direction based on blob facing direction
     */
    void updateDirection(CBlob@ this) {
    
      //Check if facing left
      if(this.isFacingLeft()) {
      
        //Set direction counter-clockwise
        this.set_u8("ConveyorBlobDirection", Transports::ConveyorBlobDirection::DIRECTION_COUNTERCLOCKWISE);
        
      }
      
      //Otherwise, is facing right
      else {
      
        //Set direction clockwise
        this.set_u8("ConveyorBlobDirection", Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE);
        
      }
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}