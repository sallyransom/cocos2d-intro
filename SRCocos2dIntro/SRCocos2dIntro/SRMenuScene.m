//
//  SRBaseScene.m
//  SRCocos2dIntro
//
//  Created by Sally Ransom on 4/19/13.
//  Copyright Supa Sally 2013. All rights reserved.
//


#import "SRMenuScene.h"
#import "AppDelegate.h"
#import "SRRocketScene.h"
#import "SRRocketAnimationScene.h"
#import "SRDraggingRocketScene.h"
#import "SRParticleEmitter.h"

@implementation SRMenuScene

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	SRMenuScene *layer = [SRMenuScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init {
    self = [super init];
    
	if(self) {
		[self displayTitle];
		[self displayMenu];
	}
    
	return self;
}

#pragma mark - Display Methods

- (void)displayTitle {
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Menu" fontName:@"Futura" fontSize:64];
    label.position =  ccp(self.screensize.width /2, self.screensize.height - 100);
    
    [self addChild: label];
}

- (void)displayMenu {
    CCMenuItem *rocketLayersMenuItem = [CCMenuItemFont itemWithString:@"Rocket Layers" target:self selector:@selector(gotoRocketLayers)];
    
    CCMenuItem *rocketAnimationMenuItem = [CCMenuItemFont itemWithString:@"Rocket Animation" target:self selector:@selector(gotoRocketAnimations)];
    
    CCMenuItem *rocketDraggingMenuItem = [CCMenuItemFont itemWithString:@"Rocket Dragging" target:self selector:@selector(gotoDraggingRockets)];
    
    CCMenuItem *particleEmitterMenuItem = [CCMenuItemFont itemWithString:@"Particle Emitter" target:self selector:@selector(gotoParticleEmitter)];
    
    CCMenu *gameMenu = [CCMenu menuWithItems:rocketLayersMenuItem, rocketAnimationMenuItem, rocketDraggingMenuItem, particleEmitterMenuItem, nil];
    [gameMenu alignItemsVerticallyWithPadding:5];
    
    [self addChild:gameMenu];
}

#pragma mark - Menu Methods

- (void)gotoRocketLayers {
    [[CCDirector sharedDirector] replaceScene:[SRRocketScene scene]];
}

- (void)gotoRocketAnimations {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:1.0
                                               scene:[SRRocketAnimationScene node]]];
}

- (void)gotoDraggingRockets {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFlipAngular transitionWithDuration:1.0
                                               scene:[SRDraggingRocketScene node]]];
}

- (void)gotoParticleEmitter {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionProgressRadialCW transitionWithDuration:1.0
                                               scene:[SRParticleEmitter node]]];
}

@end
