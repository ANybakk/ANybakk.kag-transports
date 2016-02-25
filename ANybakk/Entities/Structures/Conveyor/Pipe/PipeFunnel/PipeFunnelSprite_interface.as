/*
 * Pipe Funnel sprite interface.
 * 
 * Author: ANybakk
 */

#include "ConveyorSprite.as";
#include "PipeFunnelSprite.as";
#include "PipeFunnelVariables.as";



void onInit(CSprite@ this) {

  Transports::PipeFunnelSprite::onInit(this);
  
}

void onTick(CSprite@ this) {

  Transports::PipeFunnelSprite::onTick(this);
  
}

void onRender(CSprite@ this) {

  Transports::ConveyorSprite::onRender(this);
  
}