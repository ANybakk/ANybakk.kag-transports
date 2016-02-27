/* 
 * Pipe sprite ("abstract" type).
 * 
 * Author: ANybakk
 */

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
      if(blob.hasTag("wasEnteredPipe")) {
      
        //Put in the background layer
        ANybakk::EntitySprite::setLayer(this, ANybakk::EntitySpriteLayer::LAYER_ABYSS);
        
        //Set invisible
        //this.SetVisible(false);
        
        //Scale
        //this.ScaleBy(Vec2f)
        
        //Untag
        blob.Untag("wasEnteredPipe");
        
      }
      
      //Check if recently placed
      if(blob.hasTag("wasExitedPipe")) {
      
        //Put in the background layer
        ANybakk::EntitySprite::setLayer(this, ANybakk::EntitySpriteLayer::LAYER_DEFAULT);
        
        //Set invisible
        //this.getSprite().SetVisible(true);
        
        //Untag
        blob.Untag("wasExitedPipe");
        
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