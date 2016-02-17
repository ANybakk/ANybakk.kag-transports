/* 
 * Conveyor blob.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";
#include "ConveyorBlobDirection.as";
#include "ConveyorBlobConnectionData.as"



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
      
      //Update direction
      updateDirection(this);
      
      //Update connections
      updateConnections(this, false, false);
      
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
      
      //Update direction
      updateDirection(this);
      
      //Update connections
      updateConnections(this, true, true);
      
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
     * @param   doAnimationSync whether to synchronize animations when propagating
     */
    void updateConnections(CBlob@ this, bool doPropagate=false, bool doAnimationSync=false) {
      
      //Check if placed
      if(this.hasTag("isPlaced")) {
      
        //Obtain a reference to the map
        CMap@ map = this.getMap();
        
        //Create a blob handle
        CBlob@ previousBlob;
        
        //Create a blob handle
        CBlob@ nextBlob;
        
        //Create a connection data object
        Transports::ConveyorBlobConnectionData connectionData;
        
        //Iterate through all possible connections
        for(u8 i=0; i<Transports::ConveyorVariables::CONNECTION_DATA.length; i++) {
        
          //Keep connection data
          connectionData = Transports::ConveyorVariables::CONNECTION_DATA[i];
          
          //Remove tag
          this.Untag(connectionData.mName);
        
          //Reference this blob first
          @nextBlob = this;
          
          //Set valid flag
          bool nextIsValid = true;
        
          //Do at least once
          do {
          
            //Keep a reference to the previous segment
            @previousBlob = nextBlob;
            
            //Retrieve the next segment in line
            @nextBlob = map.getBlobAtPosition(previousBlob.getPosition() + connectionData.mOffset);
            
            //Check if invalid blob reference
            if(nextBlob is null) {
            
              //Update flag
              nextIsValid = false;
              
            }
            
            //Otherwise, check if same type, tagged as conveyor, is placed, and same direction
            else if(
                nextBlob.getName() == previousBlob.getName() 
                && nextBlob.hasTag("isConveyor") 
                && nextBlob.hasTag("isPlaced") 
                && nextBlob.get_u8("ConveyorBlobDirection") == previousBlob.get_u8("ConveyorBlobDirection")
              ) {
            
              //Set tag
              previousBlob.Tag(connectionData.mName);
            
              //Check if propagate flag
              if(doAnimationSync) {
              
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