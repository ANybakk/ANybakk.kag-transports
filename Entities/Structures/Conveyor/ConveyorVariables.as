
#include "ConveyorBlobMode.as";

namespace Transports {

  namespace ConveyorVariables {
  
    //Define a default mode when turned on to be slow
    const u8 DEFAULT_ON_MODE = Transports::ConveyorBlobMode::MODE_SLOW;
    
    const f32 SLOW_VELOCITY = 0.2f;
  }
  
}