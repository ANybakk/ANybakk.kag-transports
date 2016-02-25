/*
 * Structure blob orientations.
 * NOTE: u8 is not large enough to hold this data
 * 
 * Author: ANybakk
 */

namespace Transports {

  namespace StructureBlobOrientation {


    /**
     * Enumeration for a conveyor's direction
     */
    enum Orientation {
    
      ORIENTATION_UP = 0,
      ORIENTATION_RIGHT = 90,
      ORIENTATION_DOWN = 180,
      ORIENTATION_LEFT = 270
      
    }
    
  }
  
}