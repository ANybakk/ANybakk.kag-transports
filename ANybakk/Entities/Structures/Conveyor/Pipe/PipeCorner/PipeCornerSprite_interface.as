/*
 * Pipe Funnel sprite interface.
 * 
 * Author: ANybakk
 */

#include "ConveyorSprite.as";
#include "PipeCornerSprite.as";
#include "PipeCornerVariables.as";



void onInit(CSprite@ this) {

  Transports::PipeCornerSprite::onInit(this);
  
}

void onTick(CSprite@ this) {

  Transports::PipeCornerSprite::onTick(this);
  
}

void onRender(CSprite@ this) {

  Transports::ConveyorSprite::onRender(this);
  
}