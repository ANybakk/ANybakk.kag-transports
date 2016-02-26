/* 
 * Pipe Funnel blob.
 * 
 * Author: ANybakk
 */

#include "StructureBlobOrientation.as";
#include "ConveyorBlobConnectionData.as";
#include "PipeBlob.as";



namespace ANybakk {

  namespace PipeCornerBlob {



    void onInit(CBlob@ this) {
    
      ANybakk::PipeBlob::onInit(this);
      
      setTags(this);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipeCorner");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      ANybakk::PipeBlob::onTick(this);
      
      //Propel overlapping blobs
      propelOverlapping(this);
    
      return;
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
      
      return ANybakk::PipeBlob::doesCollideWithBlob(this, other);

    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
      
      ANybakk::PipeBlob::onSetStatic(this, isStatic);
      
      //Check if placed
      if(this.hasTag("isPlaced")) {
      
        //Retrieve current orientation
        u16 orientation = this.get_u16("StructureBlobOrientation");
        
        //Create a connection data object
        ANybakk::ConveyorBlobConnectionData connectionData;
        
        //Iterate through all possible connections (we need to un-tag connection types that aren't valid any longer)
        for(u8 i=0; i<ANybakk::ConveyorVariables::CONNECTION_DATA.length; i++) {
        
          //Keep connection data
          connectionData = ANybakk::ConveyorVariables::CONNECTION_DATA[i];
          
          //Check if orientation is up (up-right)
          if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP) {
          
            //Check if offset is not up or right
            if(!(connectionData.mOffset.y < 0.0f || connectionData.mOffset.x > 0.0f)) {
            
              //Remove tag
              this.Untag(connectionData.mName);
              
            }
            
          }
          
          //Check if orientation is right (right-down)
          else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT) {
          
            //Check if offset is not right or down
            if(!(connectionData.mOffset.x > 0.0f || connectionData.mOffset.y > 0.0f)) {
            
              //Remove tag
              this.Untag(connectionData.mName);
              
            }
            
          }
          
          //Check if orientation is down (down-left)
          else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN) {
          
            //Check if offset is not down or left
            if(!(connectionData.mOffset.y > 0.0f || connectionData.mOffset.x < 0.0f)) {
            
              //Remove tag
              this.Untag(connectionData.mName);
              
            }
            
          }
          
          //Check if orientation is left (left-up)
          else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT) {
          
            //Check if offset is not left or up
            if(!(connectionData.mOffset.x < 0.0f || connectionData.mOffset.y < 0.0f)) {
            
              //Remove tag
              this.Untag(connectionData.mName);
              
            }
            
          }
          
        }
        
      }
      
      //Finished
      return;
      
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
        for(u8 i=0; i<ANybakk::ConveyorVariables::MODE_DATA.length; i++) {
        
          //Check if current mode
          if(ANybakk::ConveyorVariables::MODE_DATA[i].mMode == currentMode) {
          
            //Keep target velocity vector
            targetVelocity = ANybakk::ConveyorVariables::MODE_DATA[i].mTargetVelocity;
            
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
          
          //Check if valid, is within and in pipe
          if(overlappingBlob !is null && this.isPointInside(overlappingBlob.getPosition()) && overlappingBlob.hasTag("isInPipe")) {
            
            //Retrieve current velocity of object
            Vec2f currentVelocity = overlappingBlob.getVelocity();
            
            //Set moving direction flags
            bool isMovingUp = currentVelocity.y < 0.0f;
            bool isMovingRight = currentVelocity.x > 0.0f;
            bool isMovingDown = currentVelocity.y > 0.0f;
            bool isMovingLeft = currentVelocity.x < 0.0f;
            
            //Obtain position of object
            Vec2f objectPosition = overlappingBlob.getPosition();
            
            //Obtain position of segment
            Vec2f segmentPosition = this.getPosition();
            
            //Set reached bend flags
            bool hasReachedBendUp = (objectPosition.y <= segmentPosition.y);
            bool hasReachedBendRight = (objectPosition.x >= segmentPosition.x);
            bool hasReachedBendDown= (objectPosition.y >= segmentPosition.y);
            bool hasReachedBendLeft = (objectPosition.x <= segmentPosition.x);
            
            //Check if orientation is up (up-right)
            if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_UP) {
            
              //Check if moving up
              if(isMovingUp) {
              
                //Propel up
                overlappingBlob.setVelocity(propelUp);
                
              }
              
              //Otherwise, check if moving right
              else if(isMovingRight) {
              
                //Propel right
                overlappingBlob.setVelocity(propelRight);
              
              }
              
              //Otherwise, check if moving down
              else if(isMovingDown) {
              
                //Check if reached the bend (center)
                if(hasReachedBendDown) {
                  
                  //Propel right
                  overlappingBlob.setVelocity(propelRight);
                
                } else {
                  
                  //Propel down
                  overlappingBlob.setVelocity(propelDown);
                
                }
              
              }
              
              //Otherwise, check if moving left
              else if(isMovingLeft) {
              
                //Check if reached the bend (center)
                if(hasReachedBendLeft) {
              
                  //Propel up
                  overlappingBlob.setVelocity(propelUp);
                
                } else {
              
                  //Propel left
                  overlappingBlob.setVelocity(propelLeft);
                
                }
              
              }
              
            }
            
            //Check if orientation is right (right-down)
            else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_RIGHT) {
            
              //Check if moving up
              if(isMovingUp) {
              
                //Check if reached the bend (center)
                if(hasReachedBendUp) {
                  
                  //Propel right
                  overlappingBlob.setVelocity(propelRight);
                
                } else {
                  
                  //Propel up
                  overlappingBlob.setVelocity(propelUp);
                
                }
                
              }
              
              //Otherwise, check if moving right
              else if(isMovingRight) {
              
                //Propel right
                overlappingBlob.setVelocity(propelRight);
              
              }
              
              //Otherwise, check if moving down
              else if(isMovingDown) {
              
                //Propel down
                overlappingBlob.setVelocity(propelDown);
              
              }
              
              //Otherwise, check if moving left
              else if(isMovingLeft) {
              
                //Check if reached the bend (center)
                if(hasReachedBendLeft) {
              
                  //Propel down
                  overlappingBlob.setVelocity(propelDown);
                
                } else {
              
                  //Propel left
                  overlappingBlob.setVelocity(propelLeft);
                
                }
              
              }
              
            }
            
            //Check if orientation is down (down-left)
            else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_DOWN) {
            
              //Check if moving up
              if(isMovingUp) {
              
                //Check if reached the bend (center)
                if(hasReachedBendUp) {
                  
                  //Propel left
                  overlappingBlob.setVelocity(propelLeft);
                
                } else {
                  
                  //Propel up
                  overlappingBlob.setVelocity(propelUp);
                
                }
                
              }
              
              //Otherwise, check if moving right
              else if(isMovingRight) {
              
                //Check if reached the bend (center)
                if(hasReachedBendRight) {
                  
                  //Propel down
                  overlappingBlob.setVelocity(propelDown);
                
                } else {
                  
                  //Propel right
                  overlappingBlob.setVelocity(propelRight);
                
                }
              
              }
              
              //Otherwise, check if moving down
              else if(isMovingDown) {
              
                //Propel down
                overlappingBlob.setVelocity(propelDown);
              
              }
              
              //Otherwise, check if moving left
              else if(isMovingLeft) {
              
                //Propel left
                overlappingBlob.setVelocity(propelLeft);
              
              }
              
            }
            
            //Check if orientation is left (left-up)
            else if(orientation == ANybakk::StructureBlobOrientation::ORIENTATION_LEFT) {
            
              //Check if moving up
              if(isMovingUp) {
              
                //Propel up
                overlappingBlob.setVelocity(propelUp);
                
              }
              
              //Otherwise, check if moving right
              else if(isMovingRight) {
              
                //Check if reached the bend (center)
                if(hasReachedBendRight) {
                  
                  //Propel up
                  overlappingBlob.setVelocity(propelUp);
                
                } else {
                  
                  //Propel right
                  overlappingBlob.setVelocity(propelRight);
                
                }
              
              }
              
              //Otherwise, check if moving down
              else if(isMovingDown) {
              
                //Check if reached the bend (center)
                if(hasReachedBendDown) {
                  
                  //Propel left
                  overlappingBlob.setVelocity(propelLeft);
                
                } else {
                  
                  //Propel down
                  overlappingBlob.setVelocity(propelDown);
                
                }
              
                
              
              }
              
              //Otherwise, check if moving left
              else if(isMovingLeft) {
              
                //Propel left
                overlappingBlob.setVelocity(propelLeft);
              
              }
              
            }
            
            //TODO: Remove isInPipe flag if object is going to exit?
            
          }
          
        }
        
      }
      
    }
    
    
    
  }
  
}