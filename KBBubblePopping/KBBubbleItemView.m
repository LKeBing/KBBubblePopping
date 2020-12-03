//
//  KBBubbleItemView.m
//  KBBubblePopView
//
//  Created by KB on 2017/4/28.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "KBBubbleItemView.h"

@interface KBBubbleItemView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation KBBubbleItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        button.frame = self.bounds;
        [button addTarget:self action:@selector(itemViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.edgeMargin = 3.f;
        self.separator = 5.f;
        self.contentAlignment = ContentAlignmentHorizontal;

        self.imageSize = CGSizeMake(24.f, 24.f);
        self.imageCornerRadius = 0.f;
        self.textColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15.f];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.image && self.text) {
        if (self.contentAlignment == ContentAlignmentHorizontal) {
            CGFloat imageX = self.edgeMargin;
            CGFloat imageY = (CGRectGetHeight(self.frame) - self.imageSize.height) / 2.f;
            self.imageView.frame = (CGRect){CGPointMake(imageX, imageY), self.imageSize};
            
            CGFloat labelX = CGRectGetMaxX(self.imageView.frame) + self.separator;
            CGFloat labelY = 0.f;
            CGFloat labelWidth = CGRectGetWidth(self.frame) - labelX - self.edgeMargin;
            CGFloat labelHeight = CGRectGetHeight(self.frame);
            self.label.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
            self.label.textAlignment = NSTextAlignmentLeft;
        } else {
            CGFloat imageX = (CGRectGetWidth(self.frame) - self.imageSize.width) / 2.f;
            CGFloat imageY = self.edgeMargin;
            self.imageView.frame = (CGRect){CGPointMake(imageX, imageY), self.imageSize};
            
            CGFloat labelX = 0.f;
            CGFloat labelY = CGRectGetMaxY(self.imageView.frame) + self.separator;
            CGFloat labelWidth = CGRectGetWidth(self.frame);
            CGFloat labelHeight = CGRectGetHeight(self.frame) - labelY - self.edgeMargin;
            self.label.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
            self.label.textAlignment = NSTextAlignmentCenter;
        }
    } else if (self.image && !self.text) {
        self.imageView.bounds = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
        self.imageView.center = self.center;
    } else if (!self.image && self.text) {
        self.label.frame = CGRectMake(self.edgeMargin, self.edgeMargin, CGRectGetWidth(self.frame) - 2 * self.edgeMargin,  CGRectGetHeight(self.frame) - 2 * self.edgeMargin);
    }
}

- (void)itemViewClicked:(UIButton *)sender {
    if (self.didSelctedCompleted) {
        self.didSelctedCompleted(self);
    }
}

#pragma mark -- setter

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius {
    _imageCornerRadius = imageCornerRadius;
    if (imageCornerRadius > 0.f) {
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = imageCornerRadius;
    }
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.label.font = textFont;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.label.textAlignment = textAlignment;
}
@end
