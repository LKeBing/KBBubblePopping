//
//  KBBubblePopping.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubblePopping.h"

@interface KBBubblePopping ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) KBBubbleCustomContentView *contentView;
@property (nonatomic, strong) KBBubbleView *bubble;
@end

@implementation KBBubblePopping

+ (id)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    if ((self = [super init])) {
        self.appearance = [[KBBubbleAppearance alloc] init];
        self.bubble = [[KBBubbleView alloc] init];
        self.contentView = [[KBBubbleCustomContentView alloc] init];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return self;
}

- (void)showWithItems:(NSArray<KBBubbleItem *> *)items atPoint:(CGPoint)point animated:(BOOL)animated selectedBlock:(void (^)(KBBubbleItem *))selectedBlock {
    
    // 透明的背景view
    UIView *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.backgroundView];

    // 自定义的contentView
    self.contentView.subContainerCount = items.count;
    self.contentView.subContainerSize = self.appearance.itemViewSize;
    self.contentView.separatorLineColor = self.appearance.separatorLineColor;
    self.contentView.separatorLineWidth = self.appearance.separatorLineWidth;
    self.contentView.padding = self.appearance.itemViewPadding;
    self.contentView.subContainerPutDirection = KBBubbleViewSubContainerPutDirectionVertical;
    [self.bubble.contentView addSubview:self.contentView];
    [self.contentView layoutWithCompletion:^(CGSize contentSize, NSArray<UIView *> *subContainerViews) {
        self.contentView.frame = (CGRect){CGPointZero, contentSize};
        
        // 对所有containerView进行处理
        [subContainerViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            KBBubbleItemView *itemView = [[KBBubbleItemView alloc] initWithFrame:obj.bounds];
            itemView.text = [items objectAtIndex:idx].title;
            itemView.image = [items objectAtIndex:idx].iconImage;
            itemView.contentAlignment = self.appearance.itemViewContentAlignment;
            itemView.edgeMargin = self.appearance.itemViewContentEdgeMargin;
            itemView.separator = self.appearance.itemViewContentSeparator;
            itemView.imageSize = self.appearance.imageSize;
            itemView.imageCornerRadius = self.appearance.imageCornerRadius;
            itemView.textFont = self.appearance.textFont;
            itemView.textColor = self.appearance.textColor;
            itemView.textAlignment = self.appearance.itemTextAlignment;
            itemView.didSelctedCompleted = ^(KBBubbleItemView *itemView) {
                if (selectedBlock) {
                    selectedBlock([items objectAtIndex:idx]);
                    [self dismiss];
                }
            };
            [obj addSubview:itemView];
        }];
        
        // 弹出气泡
        CGFloat arrowOffset = 0.f;
        CGFloat temp = 0.f;
        switch (self.appearance.popDirection) {
            default:
            case KBBubbleViewDirectionDown:
            case KBBubbleViewDirectionUp:
            {
                arrowOffset = (self.appearance.bubbleContentInsets.left + self.appearance.bubbleContentInsets.right + contentSize.width) / 2.f;
                temp = (point.x + arrowOffset) - (CGRectGetWidth(window.frame) - self.appearance.edgeMargin);
                if (temp > 0.f) arrowOffset += temp;
                temp = (point.x - arrowOffset) - self.appearance.edgeMargin;
                if (temp < 0.f) arrowOffset += temp;
            }
                break;
            case KBBubbleViewDirectionLeft:
            case KBBubbleViewDirectionRight:
            {
                arrowOffset = (self.appearance.bubbleContentInsets.top + self.appearance.bubbleContentInsets.bottom + contentSize.height) / 2.f;
                temp = (point.y + arrowOffset) - (CGRectGetHeight(window.frame) - self.appearance.edgeMargin);
                if (temp > 0.f) arrowOffset += temp;
                temp = (point.y - arrowOffset) - self.appearance.edgeMargin;
                if (temp < 0.f) arrowOffset -= temp;
            }
                break;
        }
        self.bubble.arrowOffset = arrowOffset;
        self.bubble.startPoint = point;
        self.bubble.radius = self.appearance.radius;
        self.bubble.arrowSize = self.appearance.arrowSize;
        self.bubble.direction = self.appearance.popDirection;
        self.bubble.contentInsets = self.appearance.bubbleContentInsets;
        self.bubble.animationDuration = self.appearance.animationDuration;
        self.bubble.delayDuration = self.appearance.delayDuration;
        self.bubble.backgroundColor = self.appearance.backgroundColor;
        self.bubble.lineWidth = self.appearance.lineWidth;
        [self.bubble showAtSuperview:self.backgroundView contentSize:contentSize animation:YES completion:nil];
    }];
}

- (void)dismiss {
    [self.bubble dismissWithAnimation:YES completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
    }];
}

@end
