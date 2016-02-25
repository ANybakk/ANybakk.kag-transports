/* 
 * Pipe Straight blob.
 * 
 * Author: ANybakk
 */

#include "PipeBlob.as";
#include "PipeFunnelBlob.as";



namespace Transports {

  namespace PipeStraightBlob {



    void onInit(CBlob@ this) {
    
      Transports::PipeBlob::onInit(this);
      
      setTags(this);
      
    }
    
    
    
    void setTags(CBlob@ this) {
    
      this.Tag("isPipeStraight");
      
    }
    
    
    
    void onTick(CBlob@ this) {
    
      Transports::PipeBlob::onTick(this);
      
      //Propel any overlapping blobs
      Transports::PipeFunnelBlob::propelOverlapping(this);
      
    }
    
    
    
    bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
      
      return Transports::PipeBlob::doesCollideWithBlob(this, other);;

    }
    
    
    
    void onSetStatic(CBlob@ this, const bool isStatic) {
    
      Transports::PipeBlob::onSetStatic(this, isStatic);
      
    }
    
    
    
  }
  
}