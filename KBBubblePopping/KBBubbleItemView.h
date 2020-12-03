//
//  KBBubbleItemView.h
//  KBBubblePopView
//
//  Created by KB on 2017/4/28.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBBubbleUtilities.h"

@class KBBubbleItemView;
typedef void(^DidSelctedCompletedBlock)(KBBubbleItemView *itemView);


@interface KBBubbleItemView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *text;

/**
 UIImageView和UILabel距离边框的距离
 */
@property (nonatomic, assign) CGFloat edgeMargin;

/**
 UIImageView和UILabel之间的间隔距离
 */
@property (nonatomic, assign) CGFloat separator;

/**
 UIImageView和UILabel的位置摆放方式，例如：图片在左文字在又，图片在上文字在下
 */
@property (nonatomic, assign) ContentAlignment contentAlignment;

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

/**
 文字摆放位置
 */
@property(nonatomic)        NSTextAlignment    textAlignment;

/**
 itemView的点击事件
 */
@property (nonatomic, copy) DidSelctedCompletedBlock didSelctedCompleted;

@end
