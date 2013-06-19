//
//  SRParticleEmitter.m
//  SRCocos2dIntro
//
//  Created by sailon ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRParticleEmitter.h"
#import "SRMenuScene.h"
#import "SRRocketBackgroundLayer.h"

#define MENU_BUFFER 10

@interface SRParticleEmitter () {
    CCSprite *_rocket;
    CCParticleSystemQuad *_rocketThrust;
    CCParticleSystemQuad *_outerspace;
}

@end

@implementation SRParticleEmitter

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	SRParticleEmitter *layer = [SRParticleEmitter node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init {
    self = [super init];
    
	if(self) {
        [self addOuterSpace];
        [self addGround];
        [self addRocket];
        [self displayMenu];
        [self addRocketThrust];
        
        [self scheduleUpdate];
	}
    
	return self;
}

- (void)addGround {
    CCSprite *ground = [CCSprite spriteWithFile:@"GroundSmall.png"];
    CGFloat yPosition = ground.contentSize.height/2;
    ground.position = ccp(self.screensize.width/2, yPosition);
    
    [self addChild:ground z:2];
}

- (void)addRocket {
    _rocket = [CCSprite spriteWithFile:@"RocketMed.png"];
    _rocket.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    [self addChild:_rocket z:2];
}

- (void)addRocketThrust {
    _rocketThrust = [CCParticleSystemQuad particleWithFile:@"rocket_thrust.plist"];
    _rocketThrust.position = ccp(_rocket.position.x, _rocket.position.y - _rocket.contentSize.height/2 + 30.0);
    
    [self addChild:_rocketThrust z:3];
}

- (void)addOuterSpace{
    _outerspace = [CCParticleSystemQuad particleWithFile:@"space.plist"];
    _outerspace.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    for (int i = 0; i < 80; i++) {
        [_outerspace update:1.0/60.0];
    }
    
    [self addChild:_outerspace z:-1];
}

- (void)update:(ccTime)dt {
    _rocketThrust.position = ccp(_rocket.position.x, _rocket.position.y - _rocket.contentSize.height/2 + 30.0);
}

#pragma mark - Menu

- (void)displayMenu {
    CCMenuItem *menuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(gotoMenuScene)];
    menuItem.position = ccp(menuItem.contentSize.width/2 + MENU_BUFFER, self.screensize.height - menuItem.contentSize.height/2);
    
    CCMenuItem *launchMenuItem = [CCMenuItemFont itemWithString:@"launch" target:self selector:@selector(launchRocketToOuterSpace)];
    launchMenuItem.position = ccp(self.screensize.width - launchMenuItem.contentSize.width/2 - MENU_BUFFER, self.screensize.height - launchMenuItem.contentSize.height/2);
    
    CCMenu *gameMenu = [CCMenu menuWithItems:menuItem, launchMenuItem, nil];
    gameMenu.position = CGPointZero;
    
    [self addChild:gameMenu z:3];
}

#pragma mark - Menu Methods

- (void)gotoMenuScene {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionProgressRadialCCW transitionWithDuration:1.0
                                               scene:[SRMenuScene scene]]];
}

- (void)launchRocketToOuterSpace {
    CCMoveTo *move = [CCMoveTo actionWithDuration:1.0 position:ccp(self.screensize.width/2, 700)];
    CCEaseInOut *ease = [CCEaseInOut actionWithAction:move rate:2];
    CCSequence *easeIntoSpace = [CCSequence actions: ease, nil];
    
    [_rocket runAction:easeIntoSpace];
}

@end
