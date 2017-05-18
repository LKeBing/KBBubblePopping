//
//  KBBubbleAppearance.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubbleAppearance.h"

@implementation KBBubbleAppearance

- (instancetype)init {
    self = [super init];
    if (self) {
        self.popDirection = KBBubbleViewDirectionDown;
        self.bubbleContentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.edgeMargin = 10.f;
        self.radius = 8.f;
        self.arrowSize = CGSizeMake(8.f, 8.f);
        self.backgroundColor = [UIColor redColor];
        self.itemViewPutDirection = KBBubbleViewSubContainerPutDirectionVertical;
        self.itemViewContentAlignment = ContentAlignmentHorizontal;
        self.textFont = [UIFont systemFontOfSize:15.f];
        self.textColor = [UIColor whiteColor];
        self.separatorLineWidth = 1.f;
        self.separatorLineColor = [UIColor grayColor];
        self.itemViewSize = CGSizeMake(150, 40);
        self.itemViewPadding = 5.f;
        self.itemViewContentEdgeMargin = 0.f;
        self.itemViewContentSeparator = 8.f;
        self.imageSize = CGSizeMake(20, 20);
        self.imageCornerRadius = 0.f;
        self.animationDuration = 0.35;
        self.delayDuration = 0.f;
    }
    return self;
}

@end
