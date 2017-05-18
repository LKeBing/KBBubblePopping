//
//  KBBubblePopping.h
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBBubbleItem.h"
#import "KBBubbleAppearance.h"
#import "KBBubbleView.h"
#import "KBBubbleItemView.h"
#import "KBBubbleCustomContentView.h"

@interface KBBubblePopping : NSObject

+ (id)sharedInstance;

@property (nonatomic, strong) KBBubbleAppearance *appearance;

- (void)showWithItems:(NSArray<KBBubbleItem *> *)items
              atPoint:(CGPoint)point
             animated:(BOOL)animated
        selectedBlock:(void(^)(NSInteger index))selectedBlock;

- (void)dismiss;

@end
