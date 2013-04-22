//
//  SRRocketScene.m
//  SRCocos2dIntro
//
//  Created by Sally Ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRRocketScene.h"
#import "SRMenuScene.h"
#import "SRRocketBackgroundLayer.h"

#define MENU_BUFFER 10

@implementation SRRocketScene

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	SRRocketScene *layer = [SRRocketScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init {
    self = [super init];
    
	if(self) {
        [self addBackground];
        [self addGround];
        [self addRocket];
        [self displayMenu];
	}
    
	return self;
}

#pragma mark - Display Methods

- (void)addBackground {
    CCSprite *background = [CCSprite spriteWithFile:@"Background.png"];
    background.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    [self addChild:background z:2];
}

- (void)addGround {
    CCSprite *ground = [CCSprite spriteWithFile:@"GroundSmall.png"];
    CGFloat yPosition = ground.contentSize.height/2;
    ground.position = ccp(self.screensize.width/2, yPosition);
    
    [self addChild:ground z:2];
}

- (void)addRocket {
    CCSprite *rocket = [CCSprite spriteWithFile:@"RocketMed.png"];
    rocket.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    [self addChild:rocket z:2];
}

#pragma mark - Menu

- (void)displayMenu {
    CCMenuItem *menuItem = [CCMenuItemFont itemWithString:@"Menu" target:self selector:@selector(gotoMenuScene)];
    menuItem.position = ccp(menuItem.contentSize.width/2 + MENU_BUFFER, self.screensize.height - menuItem.contentSize.height/2);
    
    CCMenu *gameMenu = [CCMenu menuWithItems:menuItem, nil];
    gameMenu.position = CGPointZero;
    
    [self addChild:gameMenu z:3];
}

#pragma mark - Menu Methods

- (void)gotoMenuScene {
    [[CCDirector sharedDirector] replaceScene:[SRMenuScene scene]];
}

@end
