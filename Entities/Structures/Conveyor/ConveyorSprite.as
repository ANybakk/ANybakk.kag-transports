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
        
        
        
      }
      
      //Finished
      return;

    }
    
    
    
  }
  
}