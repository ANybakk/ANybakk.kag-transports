
#include "StructureBlobOrientation.as";
#include "ConveyorBlobMode.as";
#include "ConveyorBlobModeData.as";
#include "ConveyorBlobConnectionData.as";
#include "ConveyorBlobDirection.as";

namespace Transports {

  namespace StructureVariables {
  
    //Define a wooden background tile type 
    const int BACKGROUND_TILE_TYPE = CMap::tile_wood_back;
    
    //Define a "build_door.ogg" placement sound
    const string PLACEMENT_SOUND = "/build_door.ogg";
  
    //Define an orientation of up (typically first sprite frame)
    const u16 DEFAULT_ORIENTATION = Transports::StructureBlobOrientation::ORIENTATION_UP;
    
  }

  namespace ConveyorVariables {
  
    //Define a default mode to be off
    const u8 DEFAULT_MODE = Transports::ConveyorBlobMode::MODE_OFF;
  
    //Define a default mode when turned on to be slow
    const u8 DEFAULT_ON_MODE = Transports::ConveyorBlobMode::MODE_SLOW;
    
    //Define an array of supported modes
    const Transports::ConveyorBlobModeData[] MODE_DATA = { 
    
      //Define an off mode with a target velocity of 0.0, 0.0
      Transports::ConveyorBlobModeData(Transports::ConveyorBlobMode::MODE_OFF, Vec2f(0.0f, 0.0f)),
    
      //Define a slow mode with a target velocity of 1.0, 0.0
      Transports::ConveyorBlobModeData(Transports::ConveyorBlobMode::MODE_SLOW, Vec2f(1.0f, 0.0f))
      
    };
  
    //Define a default direction to be clockwise
    const u8 DEFAULT_DIRECTION = Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE;
    
    //Define horizontal connections for up orientation (belt conveyor always has up orientation)
    const int[] CONNECTION_DATA_HORIZONTAL_ORIENTATIONS = { 
      
      Transports::StructureBlobOrientation::ORIENTATION_UP 
      
    };
    
    //Define compatibility with belt conveyor segments
    const string[] CONNECTION_DATA_COMPATIBILITIES = {
    
      "isBeltConveyor"
      
    };
    
    //Define an array of supported connections
    const Transports::ConveyorBlobConnectionData[] CONNECTION_DATA = { 
    
      //Define a right connection with an offset of 8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedRight", Vec2f(8.0f, 0.0f), CONNECTION_DATA_HORIZONTAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES),
    
      //Define a left connection with an offset of -8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedLeft", Vec2f(-8.0f, 0.0f), CONNECTION_DATA_HORIZONTAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES)
      
    };
    
    //Define a sword damage flag as true
    const bool TAKE_DAMAGE_FROM_SWORD = true;
    
  }

  namespace BeltConveyorVariables {
    
  }
  
}