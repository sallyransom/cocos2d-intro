//
//  SRDraggableSprite.h
//
//  Created by Sally Ransom on 10/30/12.
//  Copyright (c) 2012 CodeRed. All rights reserved.
//

#import "cocos2d.h"

@interface SRDraggableSprite : CCSprite <CCTouchOneByOneDelegate>

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isAllowedToMove;

- (void)panForTranslation:(CGPoint)translation;

@end
