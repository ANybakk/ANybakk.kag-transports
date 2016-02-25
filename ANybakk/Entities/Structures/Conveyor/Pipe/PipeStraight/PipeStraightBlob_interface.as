/*
 * Pipe Straight blob interface.
 * 
 * Author: ANybakk
 */

#include "StructureBlob.as";
#include "PipeBlob.as";
#include "PipeStraightBlob.as";
#include "PipeStraightVariables.as";



void onInit(CBlob@ this) {
  
  Transports::PipeStraightBlob::onInit(this);
  
}

void onTick(CBlob@ this) {
  
  Transports::PipeStraightBlob::onTick(this);
  
}

void onSetStatic(CBlob@ this, const bool isStatic) {

	Transports::PipeStraightBlob::onSetStatic(this, isStatic);
  
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

  return Transports::StructureBlob::canBePickedUp(this, byBlob);
  
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
  
  return Transports::PipeBlob::doesCollideWithBlob(this, other);
  
}