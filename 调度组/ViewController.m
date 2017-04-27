//
//  ViewController.m
//  调度组
//
//  Created by WJ on 2017/4/26.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self group1];
    [self group2];
    
}

/*
 
 void
 dispatch_group_async(dispatch_group_t group, dispatch_queue_t queue, dispatch_block_t block)
 {
 dispatch_retain(group);
 dispatch_group_enter(group);
 dispatch_async(queue, ^{
 block();
 dispatch_group_leave(group);
 dispatch_release(group);
 });
 }
 
 */


- (void)group2{
    
    // 创建调度组
    dispatch_group_t group = dispatch_group_create();
    // 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    // 调度组
    // 入组
    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"download a %@",[NSThread currentThread]);
        
        // 出组
        dispatch_group_leave(group);
    });
    
    // 入组 和 出组 一定要成对使用
    // 入组
    dispatch_group_enter(group);
    dispatch_group_async(group, q, ^{
        NSLog(@"download b %@",[NSThread currentThread]);
        
        // 出组
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"去主线程刷新页面 %@",[NSThread currentThread]);
    });
    
    
    
}

- (void)group1{
    
    // 创建调度组
    dispatch_group_t g = dispatch_group_create();

    // 队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(g, q, ^{
        NSLog(@"download a %@",[NSThread currentThread]);
    });
    
    dispatch_group_async(g, q, ^{
        sleep(1.0);
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"download b %@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(g, dispatch_get_main_queue(), ^{
        NSLog(@"去主线程刷新页面 %@",[NSThread currentThread]);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
