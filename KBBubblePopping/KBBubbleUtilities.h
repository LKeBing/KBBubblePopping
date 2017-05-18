//
//  KBBubbleUtilities.h
//  KBBubblePopView
//
//  Created by Daniel on 2017/5/16.
//  Copyright © 2017年 KB. All rights reserved.
//

#ifndef KBBubbleUtilities_h
#define KBBubbleUtilities_h

/**
 气泡弹出方向
 
 - KBBubbleViewDirectionDown: 向下
 - KBBubbleViewDirectionRight: 向右
 - KBBubbleViewDirectionLeft: 向左
 - KBBubbleViewDirectionUp: 向上
 */
typedef NS_ENUM(NSInteger, KBBubbleViewDirection) {
    KBBubbleViewDirectionDown,
    KBBubbleViewDirectionRight,
    KBBubbleViewDirectionLeft,
    KBBubbleViewDirectionUp,
};

/**
 containerView 的放置方向
 
 - KBBubbleViewSubContainerPutDirectionHorizontal: 沿水平方向摆放
 - KBBubbleViewSubContainerPutDirectionVertical: 沿垂直方向摆放
 */
typedef NS_ENUM(NSInteger, KBBubbleViewSubContainerPutDirection) {
    KBBubbleViewSubContainerPutDirectionHorizontal,
    KBBubbleViewSubContainerPutDirectionVertical,
};

/**
 图片、文字的摆放位置
 
 - ContentAlignmentVertical: 图片在上，文字在下
 - ContentAlignmentHorizontal: 图片在左，文字在右
 */
typedef NS_ENUM(NSInteger, ContentAlignment) {
    ContentAlignmentVertical = 0,
    ContentAlignmentHorizontal = 1,
};

#endif /* KBBubbleUtilities_h */
