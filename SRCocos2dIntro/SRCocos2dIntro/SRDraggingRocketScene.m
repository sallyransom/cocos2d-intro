//
//  SRDraggingRocketScene.m
//  SRCocos2dIntro
//
//  Created by Sally Ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRDraggingRocketScene.h"
#import "SRRocketBackgroundLayer.h"
#import "SRMenuScene.h"
#import "SRDraggableRocket.h"

#define MENU_BUFFER 10

@implementation SRDraggingRocketScene

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	SRDraggingRocketScene *layer = [SRDraggingRocketScene node];
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
    SRDraggableRocket *rocket = [[SRDraggableRocket alloc] init];
    rocket.position = ccp(self.screensize.width/2, self.screensize.height/2);
    
    [self addChild:rocket z:4];
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
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFlipAngular transitionWithDuration:1.0
                                               scene:[SRMenuScene scene]]];
}

@end
