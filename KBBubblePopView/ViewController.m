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
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(300, 100, 30, 30);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
}

- (void)click {
    KBBubbleItem *item1 = [KBBubbleItem itemWithTitle:@"创建临时保养单" iconName:@"temporarySign@2x" index:1];
    KBBubbleItem *item2 = [KBBubbleItem itemWithTitle:@"创建临时维修单" iconName:@"urgentSign@2x" index:2];;
    [[KBBubblePopping sharedInstance] showWithItems:@[item1, item2] atPoint:CGPointMake(CGRectGetMidX(self.button.frame), CGRectGetMaxY(self.button.frame)) animated:YES selectedBlock:^(NSInteger index) {
        
    }];
}


@end
