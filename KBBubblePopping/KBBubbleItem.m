//
//  KBBubbleItem.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubbleItem.h"

@implementation KBBubbleItem

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index {
    if (self = [super init]) {
        self.title = title;
        self.iconImage = iconName.length > 0 ? [UIImage imageNamed:iconName] : nil;
        self.index = index;
    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSInteger)index {
    KBBubbleItem *item = [[self alloc ] initWithTitle:title iconName:iconName index:index];
    return item;
}

@end
