/*
 * Pipe Funnel blob interface.
 * 
 * Author: ANybakk
 */

#include "StructureBlob.as";
#include "PipeFunnelBlob.as";
#include "PipeFunnelVariables.as";



void onInit(CBlob@ this) {
  
  Transports::PipeFunnelBlob::onInit(this);
  
}

void onTick(CBlob@ this) {
  
  Transports::PipeFunnelBlob::onTick(this);
  
}

void onSetStatic(CBlob@ this, const bool isStatic) {

	Transports::PipeFunnelBlob::onSetStatic(this, isStatic);
  
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

  return Transports::StructureBlob::canBePickedUp(this, byBlob);
  
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
  
  return Transports::PipeFunnelBlob::doesCollideWithBlob(this, other);
  
}

void onCollision(CBlob@ this, CBlob@ otherBlob, bool solid, Vec2f normal, Vec2f point1) {
  
  Transports::PipeFunnelBlob::onCollision(this, otherBlob, solid, normal, point1);
  
}