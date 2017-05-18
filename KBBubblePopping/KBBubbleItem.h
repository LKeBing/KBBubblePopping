//
//  KBBubbleItem.h
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface KBBubbleItem : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  配图
 */
@property (nonatomic, strong) UIImage *iconImage;

/**
 *  索引
 */
@property (nonatomic, assign) NSInteger index;

#pragma mark - 初始话 init

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index NS_AVAILABLE_IOS(2_0);

+ (instancetype)itemWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index NS_AVAILABLE_IOS(2_0);

@end
