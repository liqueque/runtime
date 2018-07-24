//
//  ViewController.m
//  runtime
//
//  Created by 李雀 on 2018/7/24.
//  Copyright © 2018年 com.meituan. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    People *people = [[People alloc] init];
    [people performSelector:@selector(speak)];
    [people performSelector:@selector(fly)];
    [people performSelector:@selector(code)];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    People *people = [[People alloc] init];
    [people performSelector:@selector(missMethod)];
}



@end
