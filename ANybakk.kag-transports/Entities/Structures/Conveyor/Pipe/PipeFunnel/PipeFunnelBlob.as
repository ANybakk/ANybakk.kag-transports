/* 
 * Pipe Funnel blob.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "ConveyorBlob.as";
#include "ConveyorBlobMode";
#include "PipeBlob.as";



namespace ANybakk {

  namespace PipeFunnelBlob {



    void onInit(CBlob@ this) {
    
      ANybakk::PipeBlob::onInit(this);
      
      setTags(this);
      
      //Set blank ID of object
      this.set_netid("isMovingID", 0);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipeFunnel");
      
      this.Untag("wasEntered");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      ANybakk::PipeBlob::onTick(this);
      
      //Retrieve current mode
      u8 currentMode = this.get_u8("ConveyorBlobMode");
      
      //Check if mode is not off
      if(currentMode != ANybakk::ConveyorBlobMode::MODE_OFF) {
      
        //Propel any overlapping blobs
        propelOverlapping(this);
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
    /*
      //Determine relative displacement 
      Vec2f relativeDisplacement = other.getPosition() - this.getPosition();
      
      //Retrieve current orientation
      u16 orientation = this.get_u16("StructureBlobOrientation");
      
      //Check if orientation is up
      if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.y < 0 - this.getShape().getHeight();
        
      }
      
      //Check if orientation is right
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.x > 0 + this.getShape().getWidth();
        
      }
      
      //Check if orientation is down
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.y > 0 + this.getShape().getHeight();
        
      }
      
      //Check if orientation is left
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.x < 0 - this.getShape().getWidth();
        
      }
      
      //Finished, return false
      return false;
      */return false;
    }
    
    
    
    void onCollision(CBlob@ this, CBlob@ otherBlob, bool solid, Vec2f normal, Vec2f point1) {
      
      //Check if can convey and object not already in a pipe
      if(canConvey(this, otherBlob) && !otherBlob.hasTag("isInPipe")) {
      
        //Retrieve current orientation
        u16 orientation = this.get_u16("StructureBlobOrientation");
        
        //Reverse normal vector so that what we get is relative to this
        normal.x *= -1;
        normal.y *= -1;
        
        //Check if not already entered this pipe (can happen when pipe turns back close enough) and collision from the right direction
        if(
          (orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP && normal.y < 0.0f)
          || (orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT && normal.x > 0.0f)
          || (orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN && normal.y > 0.0f)
          || (orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT && normal.x < 0.0f)
        ) {
        
          absorb(this, otherBlob);
          
        }
        
      }
      
    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      ANybakk::PipeBlob::onSetStatic(this, isStatic);
      
    }
    
    
    
    /**
     * Propels any overlapping blobs that are in pipe
     */
    void propelOverlapping(CBlob@ this) {
      
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
          
          //Check if within and in pipe
          //TODO: item might not actually be physically inside yet
          if(this.isPointInside(overlappingPosition) && overlappingBlob.hasTag("isInPipe")) {
          
            //Determine if this blob entered the pipe through this segment
            //bool enteredThis = (overlappingBlob.get_netid("enteredPipeID") == this.getNetworkID());
            
            propel(this, overlappingBlob);
            
          }
          
          //Otherwise, check if outside
          else if(!this.isPointInside(overlappingPosition)) {
          /*
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
            
              //Disable in pipe flag
              overlappingBlob.Untag("isInPipe");
              
              //Reset pipe ID
              overlappingBlob.set_netid("enteredPipeID", 0);
              
              //Restore gravitational forces
              overlappingBlob.getShape().SetGravityScale(1.0f);
              
            }
           */ 
          }
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    bool canConvey(CBlob@ this, CBlob@ otherBlob) {
    
      return this.hasTag("isPlaced")
        && this.get_u8("ConveyorBlobMode") != ANybakk::ConveyorBlobMode::MODE_OFF
        && otherBlob !is null 
        && !otherBlob.hasTag("isStructure") 
        && (
          otherBlob.hasTag("isPipeable")
          || otherBlob.hasTag("material")
          || otherBlob.hasTag("food")
          || otherBlob.getName() == "bomb"
          || otherBlob.getName() == "waterbomb"
          || otherBlob.getName() == "mine"
          || otherBlob.getName() == "lantern"
          || otherBlob.getName() == "powerup"
          || otherBlob.getName() == "arrow"
          || otherBlob.getName() == "sponge"
        );
          
    }
    
    
    
    /**
     * Absorbs a blob
     */
    void absorb(CBlob@ this, CBlob@ otherBlob) {
    
      //Retrieve current orientation
      u16 orientation = this.get_u16("StructureBlobOrientation");
      
      //Check if orientation is up
      if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP) {
      
        //Absorb
        absorbTop(this, otherBlob);
        
      }
      
      //Check if orientation is right
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT) {
      
        //Absorb
        absorbRight(this, otherBlob);
        
      }
      
      //Check if orientation is down
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN) {
      
        //Absorb
        absorbBottom(this, otherBlob);
        
      }
      
      //Check if orientation is left
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT) {
      
        //Absorb
        absorbLeft(this, otherBlob);
        
      }
      
    }
    
    
    
    /**
     * Absorbs a blob, top-side
     */
    void absorbTop(CBlob@ this, CBlob@ otherBlob) {
    
      //Move other 1.0 inside
      otherBlob.setPosition(this.getPosition() + Vec2f(0.0f, -this.getShape().getHeight() / 2 + 1.0f));
      
      //Propel down
      ANybakk::PipeBlob::propelDown(this, otherBlob);
      
      //Call common handler
      onAbsorbed(this, otherBlob);
      
    }
    
    
    
    /**
     * Absorbs a blob, right-side
     */
    void absorbRight(CBlob@ this, CBlob@ otherBlob) {
    
      //Move other 1.0 inside
      otherBlob.setPosition(this.getPosition() + Vec2f(this.getShape().getWidth() / 2 - 1.0f, 0.0f));
      
      //Propel left
      ANybakk::PipeBlob::propelLeft(this, otherBlob);
      
      //Call common handler
      onAbsorbed(this, otherBlob);
      
    }
    
    
    
    /**
     * Absorbs a blob, bottom-side
     */
    void absorbBottom(CBlob@ this, CBlob@ otherBlob) {
    
      //Move other 1.0 inside
      otherBlob.setPosition(this.getPosition() + Vec2f(0.0f, this.getShape().getHeight() / 2 - 1.0f));
      
      //Propel up
      ANybakk::PipeBlob::propelUp(this, otherBlob);
      
      //Call common handler
      onAbsorbed(this, otherBlob);
      
    }
    
    
    
    /**
     * Absorbs a blob, left-side
     */
    void absorbLeft(CBlob@ this, CBlob@ otherBlob) {
    
      //Move other 1.0 inside
      otherBlob.setPosition(this.getPosition() + Vec2f(-this.getShape().getWidth() / 2 + 1.0f, 0.0f));
      
      //Propel right
      ANybakk::PipeBlob::propelRight(this, otherBlob);
      
      //Call common handler
      onAbsorbed(this, otherBlob);
      
    }
    
    
    
    /**
     * Handler for when a blob has been absorbed
     */
    void onAbsorbed(CBlob@ this, CBlob@ otherBlob) {
      
      //Store pipe ID
      otherBlob.set_netid("enteredPipeID", this.getNetworkID());
      
      //Obtain a reference to the other blob's shape object
      CShape@ otherShape = otherBlob.getShape();
      
      //Disable collisions
      //otherShape.checkCollisionsAgain = false;
      otherShape.getConsts().mapCollisions = false;
      otherShape.getConsts().collidable = false;
      
      //Disable gravity for object
      otherShape.SetGravityScale(0.0f);
      
      //Set invisible
      //otherBlob.getSprite().SetVisible(true);
      
      //Set entered pipe flag
      this.Tag("wasEntered");
      
      //Set in pipe flag
      otherBlob.Tag("isInPipe");
      
    }
    
    
    
    /**
     * Propels a blob
     */
    void propel(CBlob@ this, CBlob@ otherBlob) {
    
      //Retrieve current orientation
      u16 orientation = this.get_u16("StructureBlobOrientation");
    
      //Retrieve current velocity of object
      Vec2f currentVelocity = otherBlob.getVelocity();
      
      //Check if orientation is up or down
      if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP || orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN) {
      
        //Check if moving up
        if(currentVelocity.y < 0.0f) {
        
          //Propel up
          ANybakk::PipeBlob::propelUp(this, otherBlob);
          
        }
        
        //Otherwise, check if moving down
        else if(currentVelocity.y >= 0.0f) {
        
          //Propel down
          ANybakk::PipeBlob::propelDown(this, otherBlob);
          
        }
        
      }
      
      //Check if orientation is right or left
      else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT || orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT) {
      
        //Check if moving right
        if(currentVelocity.x > 0.0f) {
        
          //Propel right
          ANybakk::PipeBlob::propelRight(this, otherBlob);
          
        }
        
        //Otherwise, check if moving left
        else if(currentVelocity.x <= 0.0f) {
        
          //Propel left
          ANybakk::PipeBlob::propelLeft(this, otherBlob);
          
        }
        
      }
      
    }
    
    
    
  }
  
}