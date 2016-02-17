/*
 * Conveyor blob connection data.
 * 
 * Author: ANybakk
 */

namespace Transports {

  class ConveyorBlobConnectionData {
    
    
    
    string mName;
    Vec2f mOffset;
    
    
    
    ConveyorBlobConnectionData() {
    
      mName = "isConnectedSelf";
      mOffset = Vec2f(0.0f, 0.0f);
      
    }
    
    
    
    ConveyorBlobConnectionData(string name, Vec2f offset) {
    
      mName = name;
      mOffset = offset;
      
    }
    
    
    
  }
  
}