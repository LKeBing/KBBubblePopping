//
//  KBBubbleCustomContentView.h
//  KBBubblePopView
//
//  Created by Daniel on 17/4/12.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBBubbleUtilities.h"

@interface KBBubbleCustomContentView : UIView

/**
 subContainer宽高尺寸
 */
@property (nonatomic, assign) CGSize subContainerSize;

/**
 subContainer的个数
 */
@property (nonatomic, assign) NSInteger subContainerCount;

/**
 分割线的宽度
 */
@property (nonatomic, assign) CGFloat separatorLineWidth;

/**
 分割线的颜色
 */
@property (nonatomic, strong) UIColor *separatorLineColor;

/**
 subContainer和separator之间的间隔距离
 */
@property (nonatomic, assign) CGFloat padding;

/**
 subContainer的摆放方向，分为横向摆放和纵向摆放
 */
@property (nonatomic, assign) KBBubbleViewSubContainerPutDirection subContainerPutDirection;


/**
 按照指定的方式摆放subContainer

 @param completion 摆放完成要将所有的subContainer和contentSize提出来共外面使用
 */
- (void)layoutWithCompletion:(void(^)(CGSize contentSize, NSArray<UIView *> *subContainerViews))completion;

@end
