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

	Transports::BeltConveyorBlob::onSetStatic(this, isStatic);
  
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob) {

  return Transports::ConveyorBlob::canBePickedUp(this, byBlob);
  
}

bool doesCollideWithBlob(CBlob@ this, CBlob@ other) {
  
  return Transports::ConveyorBlob::doesCollideWithBlob(this, other);
  
}

void onCollision(CBlob@ this, CBlob@ other, bool solid, Vec2f normal, Vec2f point1) {

  Transports::BeltConveyorBlob::onCollision(this, other, solid, normal, point1);
  
}

void onEndCollision(CBlob@ this, CBlob@ blob) {

  Transports::BeltConveyorBlob::onEndCollision(this, blob);
  
}

void onDie(CBlob@ this) {

  Transports::BeltConveyorBlob::onDie(this);
  
}