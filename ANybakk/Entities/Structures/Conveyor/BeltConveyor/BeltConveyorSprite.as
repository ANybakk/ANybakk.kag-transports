/* 
 * Belt Conveyor sprite.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";
#include "ConveyorBlobDirection.as";
#include "ConveyorSprite.as";
#include "BeltConveyorSpriteSection.as";



namespace Transports {

  namespace BeltConveyorSprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
    
      Transports::ConveyorSprite::onInit(this);
      
      CBlob@ blob = this.getBlob();
      
      blob.set_u32("lastRunningSoundTime", getGameTime());
      
      //Set default animation state (conveyor is not placed yet)
      this.SetAnimation("default");
      
      //Set default frame to left end
      this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_STANDALONE;
      
      //Store mode
      blob.set_u8("BeltConveyorSpriteSection", Transports::BeltConveyorSpriteSection::SECTION_STANDALONE);
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
    
      //Call super type's onTick (for placement sound)
      Transports::ConveyorSprite::onTick(this);
      
      //Update section
      updateSection(this);
      
      //Update animation
      updateAnimation(this);
    
      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      //Retrieve time variable for when the running sound was last played
      u32 lastRunningSoundTime = blob.get_u32("lastRunningSoundTime");
      
      //Check if more than 0.68 seconds have passed
      if(getGameTime() - lastRunningSoundTime >= 0.68 * getTicksASecond()) {
  
        //Retrieve current blob mode
        u8 blobMode = blob.get_u8("ConveyorBlobMode");
        
        //Check if mode is slow
        if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW) {
        
          //Play running sound
          //this.PlaySound("BeltConveyorSlow.ogg");
          
          //Update time variable
          blob.set_u32("lastRunningSoundTime", getGameTime());
          
        }
        
      }
      
    }
    
    
    
    /**
     * Updates animation
     */
    void updateAnimation(CSprite@ this) {
    
      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
  
      //Retrieve current blob mode
      u8 blobMode = blob.get_u8("ConveyorBlobMode");
      
      //Retrieve current section
      u8 section = blob.get_u8("BeltConveyorSpriteSection");
      
      //Retrieve direction
      u8 direction = blob.get_u8("ConveyorBlobDirection");
      
      //Check if sprite section is standalone
      if(section == Transports::BeltConveyorSpriteSection::SECTION_STANDALONE) {
      
        //Check if blob mode is slow and animation not active
        if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW && !this.isAnimation("slow_standalone")) {
        
          //Start slow left animation
          this.SetAnimation("slow_standalone");
        
        }
        
        //Otherwise, check if mode is off and animation is not active
        else if(blobMode == Transports::ConveyorBlobMode::MODE_OFF && !this.isAnimation("default")) {
      
          //Set default animation state
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_STANDALONE;
          
        }
        
      }
      
      //Otherwise, check if section is left edge
      else if(section == Transports::BeltConveyorSpriteSection::SECTION_LEFT) {
      
        //Check if blob mode is slow
        if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW) {
        
          //Check if direction is clockwise and left animation not active
          if(direction == Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE && !this.isAnimation("slow_left")) {
        
            //Start slow left animation
            this.SetAnimation("slow_left");
            
          }
          
          //Otherwise, check if direction is counter-clockwise and right animation not active (sprite is flipped)
          else if(direction == Transports::ConveyorBlobDirection::DIRECTION_COUNTERCLOCKWISE && !this.isAnimation("slow_right")) {
        
            //Start slow right animation
            this.SetAnimation("slow_right");
            
          }
        
        }
        
        //Otherwise, check if mode is off and animation is not active
        else if(blobMode == Transports::ConveyorBlobMode::MODE_OFF && !this.isAnimation("default")) {
      
          //Set default animation state
          this.SetAnimation("default");
          
          //Check if direction is clockwise
          if(direction == Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE) {
      
            //Set default frame to left end
            this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_LEFT;
            
          }
          
          //Otherwise, check if direction is counter-clockwise
          else if(direction == Transports::ConveyorBlobDirection::DIRECTION_COUNTERCLOCKWISE) {
      
            //Set default frame to right end (sprite is flipped)
            this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_RIGHT;
          
          }
          
        }
        
      }
      
      //Otherwise, check if section is right edge
      else if(section == Transports::BeltConveyorSpriteSection::SECTION_RIGHT) {
      
        //Check if blob mode is slow
        if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW) {
        
          //Check if direction is clockwise and right animation not active
          if(direction == Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE && !this.isAnimation("slow_right")) {
        
            //Start slow right animation
            this.SetAnimation("slow_right");
            
          }
          
          //Otherwise, check if direction is counter-clockwise and left animation not active (sprite is flipped)
          else if(direction == Transports::ConveyorBlobDirection::DIRECTION_COUNTERCLOCKWISE && !this.isAnimation("slow_left")) {
        
            //Start slow left animation
            this.SetAnimation("slow_left");
            
          }
        
        }
        
        //Otherwise, check if mode is off and animation is not active
        else if(blobMode == Transports::ConveyorBlobMode::MODE_OFF && !this.isAnimation("default")) {
      
          //Set default animation state
          this.SetAnimation("default");
          
          //Check if direction is clockwise
          if(direction == Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE) {
      
            //Set default frame to right end
            this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_RIGHT;
            
          }
          
          //Otherwise, check if direction is counter-clockwise
          else if(direction == Transports::ConveyorBlobDirection::DIRECTION_COUNTERCLOCKWISE) {
      
            //Set default frame to left end (sprite is flipped)
            this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_LEFT;
          
          }
          
        }
        
      }
      
      //Check if sprite section is middle
      else if(section == Transports::BeltConveyorSpriteSection::SECTION_MIDDLE) {
      
        //Check if blob mode is slow and animation not active
        if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW && !this.isAnimation("slow_middle")) {
        
          //Start slow middle animation
          this.SetAnimation("slow_middle");
        
        }
        
        //Otherwise, check if mode is off and animation is not active
        else if(blobMode == Transports::ConveyorBlobMode::MODE_OFF && !this.isAnimation("default")) {
      
          //Set default animation state
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_MIDDLE;
          
        }
        
      }
      
      //Finished
      return;
      
    }
    
    
    
    /**
     * Updates section variable based on connections
     */
    void updateSection(CSprite@ this) {
    
      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      //Check if connected both to the left and to the right
      if(blob.hasTag("isConnectedLeft") && blob.hasTag("isConnectedRight")) {
      
        //Set section to middle
        blob.set_u8("BeltConveyorSpriteSection", Transports::BeltConveyorSpriteSection::SECTION_MIDDLE);
        
      }
      
      //Otherwise, check if connected to the right
      else if(blob.hasTag("isConnectedRight")) {
      
        blob.set_u8("BeltConveyorSpriteSection", Transports::BeltConveyorSpriteSection::SECTION_LEFT);
        
      }
      
      //Otherwise, check if connected to the left
      else if(blob.hasTag("isConnectedLeft")) {
      
        //Set section to right
        blob.set_u8("BeltConveyorSpriteSection", Transports::BeltConveyorSpriteSection::SECTION_RIGHT);
        
      }
      
      //Otherwise
      else {
      
        //Set section to standalone
        blob.set_u8("BeltConveyorSpriteSection", Transports::BeltConveyorSpriteSection::SECTION_STANDALONE);
        
      }
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}