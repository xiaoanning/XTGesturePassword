//
//  ViewController.m
//  GesturePassword
//
//  Created by 安宁 on 2017/5/13.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "ViewController.h"


#import "HZBGesturePasswordController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    HZBGesturePasswordController * vc = [[HZBGesturePasswordController alloc]initWithType:GesturePasswordTypeSet];
    
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}



@end
