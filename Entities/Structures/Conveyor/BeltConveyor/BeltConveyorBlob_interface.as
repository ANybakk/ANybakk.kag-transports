/*
 * Belt Conveyor blob interface.
 * 
 * Author: ANybakk
 */

#include "ConveyorBlob.as";
#include "BeltConveyorBlob.as";
#include "BeltConveyorVariables.as";



void onInit(CBlob@ this) {
  
  Transports::BeltConveyorBlob::onInit(this);
  
}

void onTick(CBlob@ this) {
  
  Transports::BeltConveyorBlob::onTick(this);
  
}

void onSetStatic(CBlob@ this, const bool isStatic) {

	Transports::ConveyorBlob::onSetStatic(this, isStatic);
  
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

  return Transports::ConveyorBlob::canBePickedUp(this, byBlob);
  
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
  
  return Transports::ConveyorBlob::doesCollideWithBlob(this, other);
  
}