/* 
 * Conveyor sprite.
 * 
 * Author: ANybakk
 */



namespace Transports {

  namespace ConveyorSprite {
  
  
  
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

      //Obtain a reference to the blob object
      CBlob@ blob = this.getBlob();
      
      //Check if tagged as recently placed
      if(blob.hasTag("wasPlaced")) {
      
        //Play a sound
        this.PlaySound("/build_door.ogg");
        
        //Remove flag
        blob.Untag("wasPlaced");
        
      }
      
    }



    /**
     * Rendering event function
     */
    void onRender(CSprite@ this) {

      //Check if debug mode
      if(g_debug > 0) {
      
        CBlob@ blob = this.getBlob();
        
        if(blob.hasTag("isConnectedRight")) {
        
          Vec2f screenBlobPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition());
          Vec2f screenDirectionPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition() + Vec2f(4.0f, 0.0f));
          GUI::DrawLine2D(screenBlobPosition, screenDirectionPosition, SColor(0xff00ff00) );
          
        }
        
        if(blob.hasTag("isConnectedLeft")) {
        
          Vec2f screenBlobPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition());
          Vec2f screenDirectionPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition() + Vec2f(-4.0f, 0.0f));
          GUI::DrawLine2D(screenBlobPosition, screenDirectionPosition, SColor(0xff00ff00) );
          
        }
        
        if(blob.hasTag("isConnectedUp")) {
        
          Vec2f screenBlobPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition());
          Vec2f screenDirectionPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition() + Vec2f(0.0f, -4.0f));
          GUI::DrawLine2D(screenBlobPosition, screenDirectionPosition, SColor(0xff00ff00) );
          
        }
        
        if(blob.hasTag("isConnectedDown")) {
        
          Vec2f screenBlobPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition());
          Vec2f screenDirectionPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition() + Vec2f(0.0f, 4.0f));
          GUI::DrawLine2D(screenBlobPosition, screenDirectionPosition, SColor(0xff00ff00) );
          
        }
        
      }
      
      //Finished
      return;

    }
    
    
    
  }
  
}