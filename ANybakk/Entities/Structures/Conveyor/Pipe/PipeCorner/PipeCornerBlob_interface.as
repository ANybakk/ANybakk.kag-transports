/*
 * Pipe Funnel blob interface.
 * 
 * Author: ANybakk
 */

#include "StructureBlob.as";
#include "PipeCornerBlob.as";
#include "PipeCornerVariables.as";



void onInit(CBlob@ this) {
  
  Transports::PipeCornerBlob::onInit(this);
  
}

void onTick(CBlob@ this) {
  
  Transports::PipeCornerBlob::onTick(this);
  
}

void onSetStatic(CBlob@ this, const bool isStatic) {

	Transports::PipeCornerBlob::onSetStatic(this, isStatic);
  
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

  return Transports::StructureBlob::canBePickedUp(this, byBlob);
  
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
  
  return Transports::PipeCornerBlob::doesCollideWithBlob(this, other);
  
}