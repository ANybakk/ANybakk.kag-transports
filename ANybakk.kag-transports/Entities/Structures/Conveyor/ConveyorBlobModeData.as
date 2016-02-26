/*
 * Conveyor blob mode data.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlobMode.as";

namespace ANybakk {

  class ConveyorBlobModeData {
    
    
    
    u8 mMode;
    Vec2f mTargetVelocity;
    
    
    
    ConveyorBlobModeData() {
    
      mMode = ANybakk::ConveyorBlobMode::MODE_OFF;
      mTargetVelocity = Vec2f(0.0f, 0.0f);
      
    }
    
    
    
    ConveyorBlobModeData(u8 mode, Vec2f targetVelocity) {
    
      mMode = mode;
      mTargetVelocity = targetVelocity;
      
    }
    
    
    
  }
  
}