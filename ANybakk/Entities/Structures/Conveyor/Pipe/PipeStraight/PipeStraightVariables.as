
#include "StructureBlobOrientation.as";
#include "ConveyorBlobMode.as";
#include "ConveyorBlobModeData.as";
#include "ConveyorBlobConnectionData.as";
#include "ConveyorBlobDirection.as";

namespace Transports {

  namespace StructureVariables {
  
    //Define a stone background tile type 
    const int BACKGROUND_TILE_TYPE = CMap::tile_castle_back;
    
    //Define a "build_door.ogg" placement sound
    const string PLACEMENT_SOUND = "/build_wall2.ogg";
  
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
    
      //Define a slow mode with a target velocity of 1.0, 1.0
      Transports::ConveyorBlobModeData(Transports::ConveyorBlobMode::MODE_SLOW, Vec2f(1.0f, 1.0f))
      
    };
  
    //Define a default direction to be clockwise
    const u8 DEFAULT_DIRECTION = Transports::ConveyorBlobDirection::DIRECTION_CLOCKWISE;
    
    //Define vertical connections for up and down orientations
    const int[] CONNECTION_DATA_VERTICAL_ORIENTATIONS = { 
    
      Transports::StructureBlobOrientation::ORIENTATION_UP, 
      Transports::StructureBlobOrientation::ORIENTATION_DOWN 
      
    };
    
    //Define horizontal connections for left and right orientations
    const int[] CONNECTION_DATA_HORIZONTAL_ORIENTATIONS = { 
      
      Transports::StructureBlobOrientation::ORIENTATION_LEFT, 
      Transports::StructureBlobOrientation::ORIENTATION_RIGHT 
      
    };
    
    //Define compatibility with all pipe segments
    const string[] CONNECTION_DATA_COMPATIBILITIES = {
    
      "isPipe"
      
    };
    
    //Define an array of supported connections
    const Transports::ConveyorBlobConnectionData[] CONNECTION_DATA = { 
    
      //Define an up connection with an offset of 0.0, -8.0
      Transports::ConveyorBlobConnectionData("isConnectedUp", Vec2f(0.0f, -8.0f), CONNECTION_DATA_VERTICAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES),
    
      //Define a right connection with an offset of 8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedRight", Vec2f(8.0f, 0.0f), CONNECTION_DATA_HORIZONTAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES),
    
      //Define a down connection with an offset of 0.0, 8.0
      Transports::ConveyorBlobConnectionData("isConnectedDown", Vec2f(0.0f, 8.0f), CONNECTION_DATA_VERTICAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES),
    
      //Define a left connection with an offset of -8.0, 0.0
      Transports::ConveyorBlobConnectionData("isConnectedLeft", Vec2f(-8.0f, 0.0f), CONNECTION_DATA_HORIZONTAL_ORIENTATIONS, CONNECTION_DATA_COMPATIBILITIES)
      
    };
    
    //Define a sword damage flag as false
    const bool TAKE_DAMAGE_FROM_SWORD = false;
    
  }

  namespace PipeVariables {
    
  }

  namespace PipeStraightVariables {
    
  }
  
}