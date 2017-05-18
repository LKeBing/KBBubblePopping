//
//  KBBubbleView.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubbleView.h"

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359*degrees)/180)

NSValue * pointValue(CGFloat x, CGFloat y) {
    NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    return pointValue;
}

@interface KBBubbleView ()
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGPoint arrowPoint;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) CGPoint anchorPoint;
@property (nonatomic, assign) CGRect selfFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, strong) NSArray<NSArray *> *points;
@end

@implementation KBBubbleView

- (void)showAtSuperview:(UIView *)superview contentSize:(CGSize)contentSize animation:(BOOL)animation completion:(void (^)(BOOL))completion {
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    self.contentSize = contentSize;
    [superview addSubview:self];
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
    if (animation) {
        self.alpha = 0.f;
        self.superview.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(FLT_MIN, FLT_MIN);// 无限缩小
        [UIView animateWithDuration:self.animationDuration
                              delay:self.delayDuration
             usingSpringWithDamping:0.6
              initialSpringVelocity:1.5
                            options:(UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
            self.alpha = 1.f;
            self.superview.alpha = 1.f;
            self.transform = CGAffineTransformIdentity;// 还原比例
        } completion:^(BOOL completed){
            if (completion) completion(completed);
        }];
    } else {
        self.alpha = 1.f;
        self.superview.alpha = 1.f;
        if (completion) completion(YES);
    }
}

- (void)dismissWithAnimation:(BOOL)animation completion:(void (^)(BOOL))completion {
    if (self.superview == nil) {
        return;
    }
    
    if (animation) {
        [UIView animateWithDuration:self.animationDuration
                              delay:self.delayDuration
                            options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
            self.alpha = 0.f;
            self.superview.alpha = 0.f;
            self.transform = CGAffineTransformMakeScale(FLT_MIN, FLT_MIN);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completion) completion(finished);
        }];
    } else {
        self.alpha = 0.f;
        self.superview.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(FLT_MIN, FLT_MIN);
        [self removeFromSuperview];
        if (completion) completion(YES);
    }
}

- (void)reloadContentSize:(CGSize)contentSize completion:(void (^)(void))completion {
    self.contentSize = contentSize;
    [self setNeedsLayout];
    [self setNeedsDisplay];
    if (completion) completion();
}



- (instancetype)init {
    self = [super init];
    if (self) {
        self.radius = 10.f;
        self.arrowOffset = 15.f;
        self.startPoint = CGPointZero;
        self.arrowSize = CGSizeMake(10, 10);
        self.direction = KBBubbleViewDirectionDown;
        self.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.animationDuration = 0.35;
        self.delayDuration = 0.f;
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.fillColor = backgroundColor;
    [super setBackgroundColor:[UIColor clearColor]];
}

- (void)setContentSize:(CGSize)contentSize {
    _contentSize = contentSize;
    [self setSomeDatas];
}

- (void)setContentFrame:(CGRect)contentFrame {
    _contentFrame = contentFrame;
    _contentView.frame = self.contentFrame;
}

- (void)setSomeDatas {
    CGFloat radius = fmaxf(self.radius, 0.0);
    CGFloat arrowX = 0.0;
    CGFloat arrowY = 0.0;
    CGFloat arrowHeight = fmaxf(self.arrowSize.height, 0.0);
    CGFloat arrowWidth = 0.0;
    CGFloat arrowHalfWidth = 0.0;
    CGFloat arrowOffset = 0.0;
    
    CGFloat selfX = 0.0;
    CGFloat selfY = 0.0;
    CGFloat selfWidth = 0.0;
    CGFloat selfHeight = 0.0;
    
    CGPoint anchorPoint = CGPointZero;
    CGPoint contentPoint = CGPointZero;
    CGPoint tempPoint = CGPointZero;
    NSArray<NSArray *> *points = nil;// 按照顺时针方向添加边界描绘的各个点，以及圆角
    
    
    switch (self.direction) {
        default:// 默认朝下
        case KBBubbleViewDirectionDown:{
            selfWidth = self.contentSize.width + self.contentInsets.left + self.contentInsets.right;
            selfHeight = self.contentSize.height + self.contentInsets.top + self.contentInsets.bottom + arrowHeight;
            arrowOffset = fminf(fmaxf(self.arrowOffset, 0.0), selfWidth);
            selfX = self.startPoint.x - arrowOffset;
            selfY = self.startPoint.y;
            arrowX = arrowOffset;
            arrowY = 0;
            anchorPoint = CGPointMake(arrowX / selfWidth, 0);
            contentPoint = CGPointMake(self.contentInsets.left, arrowHeight + self.contentInsets.top);
            
            arrowWidth = fminf(self.arrowSize.width, selfWidth - 2 * radius);
            arrowHalfWidth = arrowWidth / 2.f;
            tempPoint = CGPointMake(fminf(fmaxf(arrowX, radius+arrowHalfWidth), selfWidth-radius-arrowHalfWidth), arrowY+arrowHeight);
            points = @[@[pointValue(tempPoint.x+arrowHalfWidth, tempPoint.y)],
                       @[pointValue(selfWidth-radius, arrowY+arrowHeight)],
                       @[pointValue(selfWidth-radius, arrowY+arrowHeight+radius),@[@(270),@(0)]],
                       @[pointValue(selfWidth, selfHeight-radius)],
                       @[pointValue(selfWidth-radius, selfHeight-radius),@[@(0),@(90)]],
                       @[pointValue(radius, selfHeight)],
                       @[pointValue(radius, selfHeight-radius),@[@(90),@(180)]],
                       @[pointValue(0, arrowY+arrowHeight+radius)],
                       @[pointValue(radius, arrowY+arrowHeight+radius),@[@(180),@(270)]],
                       @[pointValue(tempPoint.x-arrowHalfWidth, tempPoint.y)]];
            break;
        }
        case KBBubbleViewDirectionUp:{
            selfWidth = self.contentSize.width + self.contentInsets.left + self.contentInsets.right;
            selfHeight = self.contentSize.height + self.contentInsets.top + self.contentInsets.bottom + arrowHeight;
            arrowOffset = fminf(fmaxf(self.arrowOffset, 0.0), selfWidth);
            selfX = self.startPoint.x - arrowOffset;
            selfY = self.startPoint.y;
            arrowX = arrowOffset;
            arrowY = selfHeight;
            anchorPoint = CGPointMake(arrowX / selfWidth, 1);
            contentPoint = CGPointMake(self.contentInsets.left, self.contentInsets.top);
            
            arrowWidth = fminf(self.arrowSize.width, selfWidth - 2 * radius);
            arrowHalfWidth = arrowWidth / 2.f;
            tempPoint = CGPointMake(fminf(fmaxf(arrowX, radius+arrowHalfWidth), selfWidth-radius-arrowHalfWidth), selfHeight-arrowHeight);
            points = @[@[pointValue(tempPoint.x-arrowHalfWidth, tempPoint.y)],
                       @[pointValue(radius, selfHeight-arrowHeight)],
                       @[pointValue(radius, selfHeight-arrowHeight-radius),@[@(90),@(180)]],
                       @[pointValue(0, radius)],
                       @[pointValue(radius, radius),@[@(180),@(270)]],
                       @[pointValue(selfWidth-radius, 0)],
                       @[pointValue(selfWidth-radius, radius),@[@(270),@(0)]],
                       @[pointValue(selfWidth, selfHeight-arrowHeight-radius)],
                       @[pointValue(selfWidth-radius, selfHeight-arrowHeight-radius),@[@(0),@(90)]],
                       @[pointValue(tempPoint.x+arrowHalfWidth, tempPoint.y)]];
            break;
        }
        case KBBubbleViewDirectionLeft:
        {
            selfWidth = self.contentSize.width + self.contentInsets.left + self.contentInsets.right + arrowHeight;
            selfHeight = self.contentSize.height + self.contentInsets.top + self.contentInsets.bottom;
            arrowOffset = fminf(fmaxf(self.arrowOffset, 0.0), selfHeight);
            selfX = self.startPoint.x - selfWidth;
            selfY = self.startPoint.y - arrowOffset;
            arrowX = selfWidth;
            arrowY = arrowOffset;
            anchorPoint = CGPointMake(1, arrowY / selfHeight);
            contentPoint = CGPointMake(self.contentInsets.left, self.contentInsets.top);
            
            arrowWidth = fminf(self.arrowSize.width, selfHeight - 2 * radius);
            arrowHalfWidth = arrowWidth / 2.f;
            tempPoint = CGPointMake(selfWidth-arrowHeight, fminf(fmaxf(arrowY, radius+arrowHalfWidth), selfHeight-radius-arrowHalfWidth));
            points = @[@[pointValue(tempPoint.x, tempPoint.y+arrowHalfWidth)],
                       @[pointValue(selfWidth-arrowHeight, selfHeight-radius)],
                       @[pointValue(selfWidth-arrowHeight-radius, selfHeight-radius),@[@(0),@(90)]],
                       @[pointValue(radius, selfHeight)],
                       @[pointValue(radius, selfHeight-radius),@[@(90),@(180)]],
                       @[pointValue(0, radius)],
                       @[pointValue(radius,radius),@[@(180),@(270)]],
                       @[pointValue(selfWidth-arrowHeight-radius, 0)],
                       @[pointValue(selfWidth-arrowHeight-radius, radius),@[@(270),@(0)]],
                       @[pointValue(tempPoint.x, tempPoint.y-arrowHalfWidth)]];
            break;
        }
        case KBBubbleViewDirectionRight:
        {
            selfWidth = self.contentSize.width + self.contentInsets.left + self.contentInsets.right + arrowHeight;
            selfHeight = self.contentSize.height + self.contentInsets.top + self.contentInsets.bottom;
            arrowOffset = fminf(fmaxf(self.arrowOffset, 0.0), selfHeight);
            selfX = self.startPoint.x;
            selfY = self.startPoint.y - arrowOffset;
            arrowX = 0;
            arrowY = arrowOffset;
            anchorPoint = CGPointMake(0, arrowY / selfHeight);
            contentPoint = CGPointMake(self.contentInsets.left + arrowHeight, self.contentInsets.top);
            
            arrowWidth = fminf(self.arrowSize.width, selfHeight - 2 * radius);
            arrowHalfWidth = arrowWidth / 2.f;
            tempPoint = CGPointMake(arrowX+arrowHeight, fminf(fmaxf(arrowY, radius+arrowHalfWidth), selfHeight-radius-arrowHalfWidth));
            points = @[@[pointValue(tempPoint.x, tempPoint.y-arrowHalfWidth)],
                       @[pointValue(arrowHeight, arrowY-arrowHalfWidth-radius)],
                       @[pointValue(arrowHeight+radius, radius),@[@(180),@(270)]],
                       @[pointValue(selfWidth-radius, 0)],
                       @[pointValue(selfWidth-radius, radius),@[@(270),@(0)]],
                       @[pointValue(selfWidth, selfHeight-radius)],
                       @[pointValue(selfWidth-radius, selfHeight-radius),@[@(0),@(90)]],
                       @[pointValue(arrowHeight+radius, selfHeight)],
                       @[pointValue(arrowHeight+radius, selfHeight-radius),@[@(90),@(180)]],
                       @[pointValue(tempPoint.x, tempPoint.y+arrowHalfWidth)]];
            break;
        }
    }
    
    self.points = points;
    self.anchorPoint = anchorPoint;
    self.arrowPoint = CGPointMake(arrowX, arrowY);
    self.contentFrame = (CGRect){contentPoint,self.contentSize};
    self.selfFrame = CGRectMake(selfX, selfY, selfWidth, selfHeight);
}

/**
 设置一些位置属性
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    self.frame = self.selfFrame;
    self.layer.position = self.startPoint;
    self.layer.anchorPoint = self.anchorPoint;
}

/**
 重新绘制
 */
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.points.count > 0) {
        // 获取上下文
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(contextRef, self.fillColor.CGColor);
        CGContextSetLineWidth(contextRef, 0);
        // 起点
        CGContextMoveToPoint(contextRef, self.arrowPoint.x, self.arrowPoint.y);
        [self.points enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point = [[obj firstObject] CGPointValue];
            if (obj.count == 1) {
                // 依次连接各个点
                CGContextAddLineToPoint(contextRef, point.x, point.y);
            } else if (obj.count == 2) {
                // 按逆时针方向画圆角
                NSArray<NSNumber *> *degrees = [obj lastObject];
                CGFloat degree1 = [[degrees firstObject] floatValue];
                CGFloat degree2 = [[degrees lastObject] floatValue];
                CGContextAddArc(contextRef, point.x, point.y, self.radius, DEGREES_TO_RADIANS(degree1), DEGREES_TO_RADIANS(degree2), 0);
            }
        }];
        // 首尾相连
        CGContextClosePath(contextRef);
        // 设置为实心
        CGContextFillPath(contextRef);
    }
}

@end
