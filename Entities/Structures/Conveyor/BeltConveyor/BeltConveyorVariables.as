
#include "ConveyorBlobMode.as";
#include "ConveyorBlobModeData.as";
#include "ConveyorBlobConnectionData.as";

namespace Transports {

  namespace ConveyorVariables {
  
    //Define a default mode when turned on to be slow
    const u8 DEFAULT_ON_MODE = Transports::ConveyorBlobMode::MODE_SLOW;
    
    //Define an array of supported modes
    const Transports::ConveyorBlobModeData[] MODE_DATA = { 
    
      //Define an off mode with a target velocity of 0.0, 0.0
      Transports::ConveyorBlobModeData(Transports::ConveyorBlobMode::MODE_OFF, Vec2f(0.0f, 0.0f)),
    
      //Define a slow mode with a target velocity of 4.0, 0.0 (should probably equal to animation time)
      Transports::ConveyorBlobModeData(Transports::ConveyorBlobMode::MODE_SLOW, Vec2f(1.0f, 0.0f))
      
    };
    
    //Define an array of supported connections
    const Transports::ConveyorBlobConnectionData[] CONNECTION_DATA = { 
    
      //Define a right connection with an offset of 8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedRight", Vec2f(8.0f, 0.0f)),
    
      //Define a left connection with an offset of -8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedLeft", Vec2f(-8.0f, 0.0f))
      
    };
    
    //Define a time constant of 1 second for reaching target velocity 
    const f32 TIME_FOR_TARGET_VELOCITY = 1.0f;
  
    //Define a wooden background tile type 
    const int BACKGROUND_TILE_TYPE = CMap::tile_wood_back;
    
    //Define a sword damage flag as true
    const bool TAKE_DAMAGE_FROM_SWORD = true;
    
  }

  namespace BeltConveyorVariables {
    
  }
  
}