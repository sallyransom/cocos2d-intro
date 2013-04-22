//
//  SRDraggableRocket.m
//  SRCocos2dIntro
//
//  Created by Sally Ransom on 4/19/13.
//  Copyright 2013 Supa Sally. All rights reserved.
//

#import "SRDraggableRocket.h"


@implementation SRDraggableRocket

- (id)init {
    self = [super init];
    
    if (self) {
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: @"RocketSmall.png"];
        CGRect rect = CGRectZero;
        rect.size = texture.contentSize;
        [self setTexture:texture];
        [self setTextureRect:rect];
    }
    
    return self;
}

@end
