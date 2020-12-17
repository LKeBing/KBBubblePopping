//
//  ViewController.m
//  KBBubblePopView
//
//  Created by Daniel on 17/4/6.
//  Copyright © 2017年 KB. All rights reserved.
//

#import "ViewController.h"
#import "KBBubblePopping.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 3;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 0.5;
    button.frame = CGRectMake(10, 100, 100, 30);
    [button setTitle:@"点一下" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
}

- (void)click {
    KBBubbleItem *item1 = [KBBubbleItem itemWithTitle:@"item1" iconName:@"ic_shiti_setup_bottom" index:1];
    KBBubbleItem *item2 = [KBBubbleItem itemWithTitle:@"item2" iconName:@"ic_shiti_setup_top" index:2];;
    [[KBBubblePopping sharedInstance] showWithItems:@[item1, item2] atPoint:CGPointMake(CGRectGetMidX(self.button.frame), CGRectGetMaxY(self.button.frame)) animated:YES selectedBlock:^(KBBubbleItem *item) {
        
    }];
}


@end
