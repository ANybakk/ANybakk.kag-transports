/* 
 * Pipe Funnel blob.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "ConveyorBlob.as";
#include "ConveyorBlobMode";
#include "PipeBlob.as";



namespace Transports {

  namespace PipeFunnelBlob {



    void onInit(CBlob@ this) {
    
      Transports::PipeBlob::onInit(this);
      
      setTags(this);
      
      //Set blank ID of object
      this.set_netid("isMovingID", 0);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipeFunnel");
      
      this.Untag("wasEntered");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      Transports::PipeBlob::onTick(this);
      
      //Retrieve current mode
      u8 currentMode = this.get_u8("ConveyorBlobMode");
      
      //Check if mode is not off
      if(currentMode != Transports::ConveyorBlobMode::MODE_OFF) {
      
        //Propel any overlapping blobs
        propelOverlapping(this);
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
    
      //Determine relative displacement 
      Vec2f relativeDisplacement = other.getPosition() - this.getPosition();
      
      //Retrieve current orientation
      u16 orientation = this.get_u16("StructureBlobOrientation");
      
      //Check if orientation is up
      if(orientation == Transports::StructureBlobOrientation::ORIENTATION_UP) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.y < 0 - this.getShape().getHeight();
        
      }
      
      //Check if orientation is right
      else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_RIGHT) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.x > 0 + this.getShape().getWidth();
        
      }
      
      //Check if orientation is down
      else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_DOWN) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.y > 0 + this.getShape().getHeight();
        
      }
      
      //Check if orientation is left
      else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_LEFT) {
      
        //Finished, return true if beyond segment
        return relativeDisplacement.x < 0 - this.getShape().getWidth();
        
      }
      
      //Finished, return false
      return false;
      
    }
    
    void onCollision(CBlob@ this, CBlob@ otherBlob, bool solid, Vec2f normal, Vec2f point1) {
      
      //Check if can convey and meets the collision criteria
      if(canConvey(this, otherBlob)
        && doesCollideWithBlob(this, otherBlob)//COMMENT: Apparently, onCollision is always called
      ) {
      
        //Retrieve current orientation
        u16 orientation = this.get_u16("StructureBlobOrientation");
        
        //Determine the angle to the collision point
        f32 angle = (point1 - this.getPosition()).getAngle();
        
        //Check if collision from the right direction
        if(
          (orientation == Transports::StructureBlobOrientation::ORIENTATION_UP && angle < 135.0f && angle >= 45.0f)
          || (orientation == Transports::StructureBlobOrientation::ORIENTATION_RIGHT && angle < 45.0f && angle >= 315.0f)
          || (orientation == Transports::StructureBlobOrientation::ORIENTATION_DOWN && angle < 315.0f && angle >= 225.0f)
          || (orientation == Transports::StructureBlobOrientation::ORIENTATION_LEFT && angle < 225.0f && angle >= 135.0f)
        ) {
      
          //Store pipe ID
          otherBlob.set_netid("enteredPipeID", this.getNetworkID());
          
          //Create a displacement vector
          Vec2f displacement = Vec2f(0.0f, 0.0f);
          
          //Retrieve current orientation
          u16 orientation = this.get_u16("StructureBlobOrientation");
        
          //Check if orientation is up
          if(orientation == Transports::StructureBlobOrientation::ORIENTATION_UP) {
          
            //Set displacement in the y direction to 1.0 from edge
            displacement.y = -this.getShape().getHeight() + 1.0f;
            
            //Set displacement in the x direction so that blob lines up
            displacement.x = 0.0f;
            
          }
          
          //Check if orientation is right
          else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_RIGHT) {
          
            //set displacement in the x direction to -1.0 from edge
            displacement.x = this.getShape().getWidth() - 1.0f;
            
            //Set displacement in the y direction so that blob lines up
            displacement.y = 0.0f;
            
          }
          
          //Check if orientation is down
          else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_DOWN) {
          
            //set displacement in the y direction to -1.0 from edge
            displacement.y = this.getShape().getHeight() - 1.0f;
            
            //Set displacement in the x direction so that blob lines up
            displacement.x = 0.0f;
            
          }
          
          //Check if orientation is left
          else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_LEFT) {
          
            //set displacement in the x direction to 1.0 from edge
            displacement.x = -this.getShape().getWidth() + 1.0f;
            
            //Set displacement in the y direction so that blob lines up
            displacement.y = 0.0f;
            
          }
          
          //Move object past collision barrier
          otherBlob.setPosition(this.getPosition());// + displacement);
          
          //Obtain a reference to the other blob's shape object
          CShape@ otherShape = otherBlob.getShape();
          
          //Disable collisions
          //otherShape.checkCollisionsAgain = false;
          //otherShape.getConsts().mapCollisions = false;
          
          //Disable gravity for object
          otherShape.SetGravityScale(0.0f);
          
          //Set entered pipe flag
          this.Tag("wasEntered");
          
          //Set in pipe flag
          otherBlob.Tag("isInPipe");
          
        }
        
      }
      
    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      Transports::PipeBlob::onSetStatic(this, isStatic);
      
    }
    
    
    
    /**
     * Propels any overlapping blobs that are in pipe
     */
    void propelOverlapping(CBlob@ this) {
      
      //Create an array of blobs
      CBlob@[] overlappingBlobs;
      
      //Check if any blobs are overlapping
      if(this.getOverlapping(@overlappingBlobs)) {
      
        //Retrieve current mode
        u8 currentMode = this.get_u8("ConveyorBlobMode");
        
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
        
        //Create directional velocity vectors
        Vec2f propelUp(0.0f, -targetVelocity.y);
        Vec2f propelRight(targetVelocity.x, 0.0f);
        Vec2f propelDown(0.0f, targetVelocity.y);
        Vec2f propelLeft(-targetVelocity.x, 0.0f);
        
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
            
            //Retrieve current velocity of object
            Vec2f currentVelocity = overlappingBlob.getVelocity();
            
            //Set moving direction flags
            bool isMovingUp = currentVelocity.y < 0.0f;
            bool isMovingRight = currentVelocity.x > 0.0f;
            bool isMovingDown = currentVelocity.y > 0.0f;
            bool isMovingLeft = currentVelocity.x < 0.0f;
            
            //Check if orientation is up or down
            if(orientation == Transports::StructureBlobOrientation::ORIENTATION_UP || orientation == Transports::StructureBlobOrientation::ORIENTATION_DOWN) {
            
              //Check if moving up
              if(isMovingUp) {
              
                //Propel up
                overlappingBlob.setVelocity(propelUp);
                
              }
              
              //Otherwise, check if moving down
              else if(isMovingDown) {
              
                //Propel down
                overlappingBlob.setVelocity(propelDown);
                
              }
              
            }
            
            //Check if orientation is right or left
            else if(orientation == Transports::StructureBlobOrientation::ORIENTATION_RIGHT || orientation == Transports::StructureBlobOrientation::ORIENTATION_LEFT) {
            
              //Check if moving right
              if(isMovingRight) {
              
                //Propel right
                overlappingBlob.setVelocity(propelRight);
                
              }
              
              //Otherwise, check if moving left
              else if(isMovingLeft) {
              
                //Propel left
                overlappingBlob.setVelocity(propelLeft);
                
              }
              
            }
            
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
                  isValidPipe = isValidPipe || Transports::ConveyorBlob::isConnected(this, blobAtPosition);
                  
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
    
    
    
  }
  
}