//
//  KBBubbleCustomContentView.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/12.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubbleCustomContentView.h"

@implementation KBBubbleCustomContentView

- (void)layoutWithCompletion:(void (^)(CGSize, NSArray<UIView *> *))completion {
    
    while (self.subviews.lastObject) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    NSMutableArray<UIView *> *containers = @[].mutableCopy;
    CGFloat subContainerWidth = self.subContainerSize.width;
    CGFloat subContainerHeight = self.subContainerSize.height;
    UIView *lastSubContainerView = nil;
    UIView *lastSeparatorView = nil;
    
    for (NSInteger i = 0; i < self.subContainerCount; i ++) {
        // container
        UIView *subContainerView = [UIView new];
        subContainerView.backgroundColor = [UIColor clearColor];
        [self addSubview:subContainerView];
        if (i == 0) {
            subContainerView.frame = CGRectMake(0, 0, subContainerWidth, subContainerHeight);
        } else {
            if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionHorizontal) {
                subContainerView.frame = CGRectMake(CGRectGetMaxX(lastSeparatorView.frame) + self.padding, 0, subContainerWidth, subContainerHeight);
            } else if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionVertical) {
                subContainerView.frame = CGRectMake(0, CGRectGetMaxY(lastSeparatorView.frame) + self.padding, subContainerWidth, subContainerHeight);
            }
        }
        lastSubContainerView = subContainerView;
        
        // separator
        if (self.separatorLineWidth >= 0 && i != self.subContainerCount - 1) {
            UIView *separatorView = [UIView new];
            separatorView.backgroundColor = self.separatorLineColor;
            [self addSubview:separatorView];
            if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionHorizontal) {
                separatorView.frame = CGRectMake(CGRectGetMaxX(lastSubContainerView.frame) + self.padding, 0, self.separatorLineWidth, subContainerHeight);
            } else if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionVertical) {
                separatorView.frame = CGRectMake(0, CGRectGetMaxY(lastSubContainerView.frame) + self.padding, subContainerWidth, self.separatorLineWidth);
            }
            lastSeparatorView = separatorView;
        }
        
        [containers addObject:subContainerView];
    }
    
    if (completion) {
        CGSize contentSize = CGSizeZero;
        if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionHorizontal) {
            contentSize = CGSizeMake(CGRectGetMaxX(lastSubContainerView.frame), CGRectGetHeight(lastSubContainerView.frame));
        } else if (self.subContainerPutDirection == KBBubbleViewSubContainerPutDirectionVertical) {
            contentSize = CGSizeMake(CGRectGetWidth(lastSubContainerView.frame), CGRectGetMaxY(lastSubContainerView.frame));
        }
        completion(contentSize, containers.copy);
    }
}

@end
