//
//  SRRocketAnimationScene.m
//  SRCocos2dIntro
//
//  Created by sailon ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRRocketAnimationScene.h"
#import "SRRocketBackgroundLayer.h"
#import "SRMenuScene.h"

#define MENU_BUFFER 10
#define MENU_ITEM_BUFFER 35

@interface SRRocketAnimationScene () {
    CCSprite *_rocket;
}

@end

@implementation SRRocketAnimationScene

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	SRRocketAnimationScene *layer = [SRRocketAnimationScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init {
    self = [super init];
    
	if(self) {
        [self addBackground];
        [self addRocket];
        [self displayMenu];
	}
    
	return self;
}

- (void)addBackground {
    SRRocketBackgroundLayer *background = [[SRRocketBackgroundLayer alloc] init];
    [self addChild:background z:0];
}

- (void)addRocket {
    _rocket = [CCSprite spriteWithFile:@"RocketMed.png"];
    _rocket.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    [self addChild:_rocket z:2];
}

#pragma mark - Menu

- (void)displayMenu {
    CCMenuItem *menuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(gotoMenuScene)];
    menuItem.position = ccp(menuItem.contentSize.width/2 + MENU_BUFFER, self.screensize.height - menuItem.contentSize.height/2);
    
    CCMenuItem *resetMenuItem = [CCMenuItemFont itemWithString:@"reset" target:self selector:@selector(resetRocket)];
    resetMenuItem.position = ccp(self.screensize.width - resetMenuItem.contentSize.width/2 - MENU_BUFFER, self.screensize.height - resetMenuItem.contentSize.height/2);
    
    CCMenuItem *spinMenuItem = [CCMenuItemFont itemWithString:@"spin" target:self selector:@selector(spinRocket)];
    spinMenuItem.position = ccp(self.screensize.width - spinMenuItem.contentSize.width/2 - MENU_BUFFER, resetMenuItem.position.y - MENU_ITEM_BUFFER);
    
    CCMenuItem *launchMenuItem = [CCMenuItemFont itemWithString:@"launch" target:self selector:@selector(launchRocketToOuterSpace)];
    launchMenuItem.position = ccp(self.screensize.width - launchMenuItem.contentSize.width/2 - MENU_BUFFER, spinMenuItem.position.y - MENU_ITEM_BUFFER);
    
    CCMenuItem *comboMenuItem = [CCMenuItemFont itemWithString:@"combo" target:self selector:@selector(spinandLaunchRocket)];
    comboMenuItem.position = ccp(self.screensize.width - comboMenuItem.contentSize.width/2 - MENU_BUFFER, launchMenuItem.position.y - MENU_ITEM_BUFFER);
    
    CCMenu *gameMenu = [CCMenu menuWithItems:menuItem, resetMenuItem, spinMenuItem, launchMenuItem, comboMenuItem, nil];
    gameMenu.position = CGPointZero;
    
    [self addChild:gameMenu z:3];
}

#pragma mark - Menu Methods

- (void)gotoMenuScene {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:1.0
                                               scene:[SRMenuScene scene]]];
}

#pragma mark - Animation Methods

- (void)resetRocket {
    [_rocket stopAllActions];
    _rocket.rotation = 0.0;
    _rocket.position = ccp(self.screensize.width/2, self.screensize.height/2);
}

- (void)spinRocket {
    CCRotateBy *rotateFullCircle = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:2 angle: 360]];
    [_rocket runAction:rotateFullCircle];
}

- (void)launchRocketToOuterSpace {
    CCMoveTo *move = [CCMoveTo actionWithDuration:1.0 position:ccp(self.screensize.width/2, 700)];
    CCEaseInOut *ease = [CCEaseInOut actionWithAction:move rate:2];
    CCSequence *easeIntoSpace = [CCSequence actions: ease, nil];
    
    [_rocket runAction:easeIntoSpace];
}

- (void)spinandLaunchRocket {
    CCRotateBy *spinOnce = [CCRotateBy actionWithDuration:2 angle: 360];
    [_rocket runAction:spinOnce];
    CCMoveTo *moveToOuterSpace = [CCMoveTo actionWithDuration:1.0 position:ccp(self.screensize.width/2, 700)];
    CCEaseInOut *easeToOuterSpace = [CCEaseInOut actionWithAction:moveToOuterSpace rate:2];
    CCSequence *easeIntoSpace = [CCSequence actions: spinOnce, easeToOuterSpace, nil];
    
    [_rocket runAction:easeIntoSpace];
}

@end
