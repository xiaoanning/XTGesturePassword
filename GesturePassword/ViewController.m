//
//  ViewController.m
//  GesturePassword
//
//  Created by 安宁 on 2017/5/13.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "ViewController.h"


#import "HZBGesturePasswordUtil.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    if ([HZBGesturePasswordUtil touchIsExist])
    {
        __block typeof(self) weakSelf = self ;
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"已有手势 选择操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf GesturePasswordType:GesturePasswordTypeLogin textModel:nil];
            
        }];
        
        [alertController addAction:action1];
        
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf GesturePasswordType:GesturePasswordTypeReset textModel:nil];
            
        }];
        
        [alertController addAction:action2];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
    }else
    {
        HZBTextModel * textModel = [[HZBTextModel alloc]init];
        
        [self GesturePasswordType:GesturePasswordTypeOneStepSet textModel:textModel];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

-(void)GesturePasswordType:(GesturePasswordType)type textModel:(HZBTextModel *)textModel
{
    [HZBGesturePasswordUtil showGestureViewWithCurrentViewController:self ViewSwitchType:ViewSwitchTypeModel GesturePasswordType:type textModel:textModel];
}

@end
