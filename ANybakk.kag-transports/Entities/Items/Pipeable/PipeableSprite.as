/* 
 * Pipe sprite ("abstract" type). Can also be used with vanilla types by 
 * calling functions directly. Keep in mind that some default post-event 
 * behaviour may reside in onTick handlers, so you might have to manually call 
 * them once.
 * 
 * Author: ANybakk
 */

#include "EntityVariables.as";
#include "EntitySprite.as";



namespace ANybakk {

  namespace PipeableSprite {
  
  
  
    /**
     * Initialization event function
     */
    void onInit(CSprite@ this) {
      
      //Finished
      return;
      
    }



    /**
     * Tick event function
     */
    void onTick(CSprite@ this) {
    
      //Obtain blob object reference
      CBlob@ blob = this.getBlob();
      
      //Check if recently placed
      if(blob.hasTag("PipeableBlob::wasEnteredPipe")) {
      
        //Put in the background layer
        ANybakk::EntitySprite::setLayer(this, ANybakk::EntitySpriteLayer::LAYER_ABYSS);
        
        //Set invisible
        //this.SetVisible(false);
        
        //Check if shrinking is enabled and hasn't already been shrunk
        if(ANybakk::PipeableVariables::SHRINK_ON_ENTERED_PIPE && !blob.exists("PipeableSprite::originalSize")) {
        
          Vec2f originalSize(this.getFrameWidth(), this.getFrameHeight());
          
          //Store original size
          blob.set("PipeableSprite::originalSize", originalSize);
          
          //Shrink
          ANybakk::EntitySprite::scale(this, ANybakk::PipeableVariables::SHRINK_TO_SIZE);
          
          //Check if pipeable vanilla
          if(ANybakk::PipeableBlob::isConsideredPipeableVanilla(blob)) {
            
            //Manually call onTick once (handler not associated with vanilla types)
            ANybakk::EntitySprite::onTick(this);
            
          }
          
        }
        
        //Untag
        blob.Untag("PipeableBlob::wasEnteredPipe");
        
      }
      
      //Check if recently placed
      if(blob.hasTag("PipeableBlob::wasExitedPipe")) {
      
        //Put in the background layer
        ANybakk::EntitySprite::setLayer(this, ANybakk::EntitySpriteLayer::LAYER_DEFAULT);
        
        //Set invisible
        //this.getSprite().SetVisible(true);
        
        //Check if shrinking is enabled and has been shrunk
        if(ANybakk::PipeableVariables::SHRINK_ON_ENTERED_PIPE && blob.exists("PipeableSprite::originalSize")) {
        
          Vec2f originalSize;
        
          //Check if could retrieve original size variable
          if(blob.get("PipeableSprite::originalSize", originalSize)) {
          
            //Shrink
            ANybakk::EntitySprite::scale(this, originalSize);
          
            //Delete variable (is now back to original size)
            blob.clear("PipeableSprite::originalSize");
          
            //Check if pipeable vanilla
            if(ANybakk::PipeableBlob::isConsideredPipeableVanilla(blob)) {
              
              //Manually call onTick once (handler not associated with vanilla types)
              ANybakk::EntitySprite::onTick(this);
              
            }
            
          }
          
        }
        
        //Untag
        blob.Untag("PipeableBlob::wasExitedPipe");
        
      }
      
      //Finished
      return;
      
    }



    /**
     * Rendering event function
     */
    void onRender(CSprite@ this) {
      
      //Finished
      return;
      
    }
    
    
    
  }
  
}