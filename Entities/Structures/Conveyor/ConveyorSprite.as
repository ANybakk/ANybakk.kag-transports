/* 
 * Conveyor sprite.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobConnectionData.as"

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
        
        //Create a connection data object
        Transports::ConveyorBlobConnectionData connectionData;
        
        //Create a blob position vector
        Vec2f screenBlobPosition;
        
        //Create a direction vector
        Vec2f screenDirectionPosition;
        
        //Iterate through all possible connections
        for(u8 i=0; i<Transports::ConveyorVariables::CONNECTION_DATA.length; i++) {
        
          //Keep connection data
          connectionData = Transports::ConveyorVariables::CONNECTION_DATA[i];
          
          //Check if tagged with this connection name
          if(blob.hasTag(connectionData.mName)) {
          
            screenBlobPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition());
            screenDirectionPosition = getDriver().getScreenPosFromWorldPos(blob.getPosition() + connectionData.mOffset / 2);
            GUI::DrawLine2D(screenBlobPosition, screenDirectionPosition, SColor(0xff00ff00) );
            
          }
          
        }
        
      }
      
      //Finished
      return;

    }
    
    
    
  }
  
}