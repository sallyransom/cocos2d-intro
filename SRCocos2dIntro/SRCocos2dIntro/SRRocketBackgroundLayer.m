//
//  SRRocketBackgroundLayer.m
//  SRCocos2dIntro
//
//  Created by Sally Ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRRocketBackgroundLayer.h"

@implementation SRRocketBackgroundLayer

- (id)init {
    self = [super init];
    
    if (self) {
        [self addBackground];
        [self addGround];
    }
    
    return self;
}

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

@end
