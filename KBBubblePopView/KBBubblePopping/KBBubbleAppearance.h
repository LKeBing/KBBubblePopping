//
//  KBBubbleAppearance.h
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KBBubbleUtilities.h"

@interface KBBubbleAppearance : NSObject

/**
 扩展方向
 */
@property (nonatomic, assign) KBBubbleViewDirection popDirection;

/**
 小三角的宽高尺寸
 */
@property (nonatomic, assign) CGSize arrowSize;

/**
 圆角大小
 */
@property (nonatomic, assign) CGFloat radius;

/**
 contentView 距离边框的距离
 */
@property (nonatomic, assign) UIEdgeInsets bubbleContentInsets;

/**
 气泡距离屏幕边缘的最小距离
 */
@property (nonatomic, assign) CGFloat edgeMargin;

/**
 气泡颜色
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 气泡动画时长
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 气泡动画之前的延迟时长
 */
@property (nonatomic, assign) NSTimeInterval delayDuration;


/**
 subContainer的摆放方向，分为横向摆放和纵向摆放
 */
@property (nonatomic, assign) KBBubbleViewSubContainerPutDirection itemViewPutDirection;

/**
 subContainer和separator之间的间隔距离
 */
@property (nonatomic, assign) CGFloat itemViewPadding;

/**
 subContainer宽高尺寸
 */
@property (nonatomic, assign) CGSize itemViewSize;



/**
 UIImageView和UILabel的位置摆放方式，例如：图片在左文字在又，图片在上文字在下
 */
@property (nonatomic, assign) ContentAlignment itemViewContentAlignment;

/**
 分割线的宽度
 */
@property (nonatomic, assign) CGFloat separatorLineWidth;

/**
 分割线的颜色
 */
@property (nonatomic, strong) UIColor *separatorLineColor;

/**
 UIImageView和UILabel距离边框的距离
 */
@property (nonatomic, assign) CGFloat itemViewContentEdgeMargin;

/**
 UIImageView和UILabel之间的间隔距离
 */
@property (nonatomic, assign) CGFloat itemViewContentSeparator;

/**
 UIImageView的宽高尺寸
 */
@property (nonatomic, assign) CGSize imageSize;

/**
 UIImageView的圆角大小
 */
@property (nonatomic, assign) CGFloat imageCornerRadius;

/**
 文字字体大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;

@end
