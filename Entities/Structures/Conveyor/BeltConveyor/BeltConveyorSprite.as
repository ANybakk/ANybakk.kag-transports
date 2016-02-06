/* 
 * Belt Conveyor sprite.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";
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

      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
  
      //Retrieve current blob mode
      u8 blobMode = blob.get_u8("ConveyorBlobMode");
  
      //Retrieve current sprite mode
      u8 section = blob.get_u8("BeltConveyorSpriteSection");
      
      //Check if blob mode is slow
      if(blobMode == Transports::ConveyorBlobMode::MODE_SLOW) {
      
        //Check if sprite section is standalone and animation not already active
        if(section == Transports::BeltConveyorSpriteSection::SECTION_STANDALONE && !this.isAnimation("slow_left")) {
        
          //Start slow left animation
          this.SetAnimation("slow_standalone");
          
        }
      
        //Otherwise, check if sprite section is left and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_LEFT && !this.isAnimation("slow_left")) {
        
          //Start slow left animation
          this.SetAnimation("slow_left");
          
        }
      
        //Otherwise, check if sprite section is middle and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_MIDDLE && !this.isAnimation("slow_middle")) {
        
          //Start slow left animation
          this.SetAnimation("slow_middle");
          
        }
      
        //Otherwise, check if sprite section is right and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_RIGHT && !this.isAnimation("slow_right")) {
        
          //Start slow left animation
          this.SetAnimation("slow_right");
          
        }
      
      }
      
      //Otherwise, check if blob mode is off
      else if(blobMode == Transports::ConveyorBlobMode::MODE_OFF) {
      
        //Check if sprite section is standalone and animation not already active
        if(section == Transports::BeltConveyorSpriteSection::SECTION_STANDALONE && !this.isAnimation("default")) {
      
          //Set default animation state (conveyor is not placed yet)
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_STANDALONE;
          
        }
      
        //Otherwise, check if sprite section is left and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_LEFT && !this.isAnimation("default")) {
      
          //Set default animation state (conveyor is not placed yet)
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_LEFT;
          
        }
      
        //Otherwise, check if sprite section is middle and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_MIDDLE && !this.isAnimation("default")) {
      
          //Set default animation state (conveyor is not placed yet)
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_MIDDLE;
          
        }
      
        //Otherwise, check if sprite section is right and animation not already active
        else if(section == Transports::BeltConveyorSpriteSection::SECTION_RIGHT && !this.isAnimation("default")) {
      
          //Set default animation state (conveyor is not placed yet)
          this.SetAnimation("default");
      
          //Set default frame to left end
          this.animation.frame = Transports::BeltConveyorSpriteSection::SECTION_RIGHT;
          
        }
      
      }
      
    }
    
    
    
  }
  
}