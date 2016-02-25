/*
 * Pipe Straight sprite interface.
 * 
 * Author: ANybakk
 */

#include "ConveyorSprite.as";
#include "PipeStraightSprite.as";
#include "PipeStraightVariables.as";



void onInit(CSprite@ this) {

  Transports::PipeStraightSprite::onInit(this);
  
}

void onTick(CSprite@ this) {

  Transports::PipeStraightSprite::onTick(this);
  
}

void onRender(CSprite@ this) {

  Transports::ConveyorSprite::onRender(this);
  
}