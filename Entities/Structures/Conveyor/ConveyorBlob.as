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
      this.set_bool("ignore sword", Transports::ConveyorVariables::TAKE_DAMAGE_FROM_SWORD);
      
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
      updateConnections(this);
      
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
      updateConnections(this);
      
      //Update direction
      updateDirection(this);
      
      //Set mode to default
      this.set_u8("ConveyorBlobMode", Transports::ConveyorVariables::DEFAULT_ON_MODE);
      
    }
    
    
    
    bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

      return false;

    }
    
    
    
    /**
     * Updates connection statuses for the blob
     */
    void updateConnections(CBlob@ this) {
    
      //Disable all connection flags
      this.Untag("isConnectedRight");
      this.Untag("isConnectedLeft");
      this.Untag("isConnectedDown");
      this.Untag("isConnectedUp");
      
      //Obtain a reference to the map
      CMap@ map = this.getMap();
      
      //Create an array of blob object references
      CBlob@[] nearbyBlobs;
      
      //Create a handle for a blob object
      CBlob@ nearbyBlob;
      
      //Check if any blobs are within radius
      if(map.getBlobsInRadius(this.getPosition(), map.tilesize, @nearbyBlobs)) {
      
        //Iterate through blob objects
        for(u8 i = 0; i<nearbyBlobs.length; i++) {
        
          //Keep a reference to this blob object
          @nearbyBlob = nearbyBlobs[i];
          
          //Check if blob is not this blob, tagged as conveyor and is placed
          if(nearbyBlob !is this && nearbyBlob.hasTag("isConveyor") && nearbyBlob.hasTag("isPlaced")) {
          
            //Check if same type name
            if(nearbyBlob.getName() == this.getName()) {
            
              //Create a vector representing the relative displacement
              Vec2f relativeDisplacement = nearbyBlob.getPosition() - this.getPosition();
              
              //Check if displaced one tile to the right
              if(relativeDisplacement.x == map.tilesize && relativeDisplacement.y == 0.0f) {
              
                //Tag as connected to the right
                this.Tag("isConnectedRight");
              
              }
              
              //Check if displaced one tile to the left
              if(relativeDisplacement.x == - map.tilesize && relativeDisplacement.y == 0.0f) {
              
                //Tag as connected to the right
                this.Tag("isConnectedLeft");
              
              }
              
              //Check if displaced one tile down
              if(relativeDisplacement.y == map.tilesize && relativeDisplacement.x == 0.0f) {
              
                //Tag as connected to the right
                this.Tag("isConnectedDown");
              
              }
              
              //Check if displaced one tile up
              if(relativeDisplacement.y == -map.tilesize && relativeDisplacement.x == 0.0f) {
              
                //Tag as connected to the right
                this.Tag("isConnectedUp");
              
              }
              
            }
          
          }
          
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
    
    
    
    void onDie(CBlob@ this) {
    
      //Obtain a reference to the map object
      CMap@ map = this.getMap();
      
      //Set empty tile
      map.server_SetTile(this.getPosition(), CMap::tile_empty);
      
    }
    
    
    
  }
  
}