//
//  DraggableSprite.m
//
//  Created by Sally Ransom on 10/30/12.
//  Copyright (c) 2012 CodeRed. All rights reserved.
//

#import "SRDraggableSprite.h"

@implementation SRDraggableSprite

- (id)init {
    self = [super init];
    if (self) {
        self.isSelected = NO;
        self.isAllowedToMove = YES;
    }
    return self;
}

- (void)onEnterTransitionDidFinish {
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)onExit {
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.isSelected || !self.isAllowedToMove) {
        return NO;
    }
    
	CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if (CGRectContainsPoint(self.boundingBox, touchLocation)) {
        self.isSelected = YES;
        return YES;
    }
    return NO;
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint newPos = ccpAdd(self.position, translation);
    self.position = newPos;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self.isSelected || !self.isAllowedToMove) {
        return;
    }
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    
    [self panForTranslation:translation];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self.isSelected || !self.isAllowedToMove) {
        return;
    }
    self.isSelected = NO;
}

@end
