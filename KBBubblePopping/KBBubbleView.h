//
//  KBBubbleView.h
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBBubbleUtilities.h"

@interface KBBubbleView : UIView

/**
 强烈建议把内容添加到 contentView 上面
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 扩展的起始点---气泡将从这个位置弹出来
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 小三角的宽高尺寸---说明：三角形的底边是紧邻气泡上的那条边，arrowSize.width就是这条底边的宽度，而arrowSize.height就是三角形的高度，默认CGSizeMake(10, 10)
 */
@property (nonatomic, assign) CGSize arrowSize;

/**
 小三角顶尖的偏移量，默认为气泡某条边长的一半
 */
@property (nonatomic, assign) CGFloat arrowOffset;

/**
 圆角大小，默认为10
 */
@property (nonatomic, assign) CGFloat radius;

/**
 扩展方向，默认向下KBBubbleViewDirectionDown
 */
@property (nonatomic, assign) KBBubbleViewDirection direction;

/**
 contentView距离边框的距离，默认UIEdgeInsetsMake(10, 10, 10, 10)
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

/**
 气泡动画时长，默认0.35s
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 气泡动画之前的延迟时长，默认0
 */
@property (nonatomic, assign) NSTimeInterval delayDuration;


/**
 弹出气泡

 @param superview 需要指定气泡摆放的父视图
 @param contentSize 需要给一个气泡内容页的大小
 @param animation 是否需要动画效果
 @param completion 弹出操作结束之后的回调
 */
- (void)showAtSuperview:(UIView *)superview
            contentSize:(CGSize)contentSize
              animation:(BOOL)animation
             completion:(void(^)(BOOL finished))completion;

/**
 收回气泡

 @param animation 是否需要动画效果
 @param completion 收回操作结束之后的回调
 */
- (void)dismissWithAnimation:(BOOL)animation
                  completion:(void(^)(BOOL finished))completion;

/**
 更新气泡大小

 @param contentSize 需要重新指定气泡内容页的大小尺寸
 @param completion 大小更新后的回调
 */
- (void)reloadContentSize:(CGSize)contentSize
               completion:(void(^)(void))completion;

@end
