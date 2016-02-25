/*
 * Belt Conveyor sprite interface.
 * 
 * Author: ANybakk
 */

#include "ConveyorSprite.as";
#include "BeltConveyorSprite.as";
#include "BeltConveyorVariables.as";



void onInit(CSprite@ this) {

  Transports::BeltConveyorSprite::onInit(this);
  
}

void onTick(CSprite@ this) {

  Transports::BeltConveyorSprite::onTick(this);
  
}

void onRender(CSprite@ this) {

  Transports::ConveyorSprite::onRender(this);
  
}
