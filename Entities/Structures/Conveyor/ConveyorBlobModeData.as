/*
 * Conveyor blob modes.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";

namespace Transports {

  class ConveyorBlobModeData {
    
    
    
    u8 mMode;
    Vec2f mTargetVelocity;
    
    
    
    ConveyorBlobModeData() {
    
      mMode = Transports::ConveyorBlobMode::MODE_OFF;
      mTargetVelocity = Vec2f(0.0, 0.0);
      
    }
    
    
    
    ConveyorBlobModeData(u8 mode, Vec2f targetVelocity) {
    
      mMode = mode;
      mTargetVelocity = targetVelocity;
      
    }
    
    
    
  }
  
}