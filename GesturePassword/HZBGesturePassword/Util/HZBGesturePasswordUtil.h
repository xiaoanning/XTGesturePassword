//
//  HZBGesturePasswordUtil.h
//  GesturePassword
//
//  Created by 安宁 on 2017/5/22.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZBGesturePasswordController.h"


typedef NS_ENUM(NSUInteger , ViewSwitchType)
{
    ViewSwitchTypeNavigation = 1 ,
    ViewSwitchTypeModel = 2 ,
};

@interface HZBGesturePasswordUtil : NSObject

+(void)showGestureViewWithCurrentViewController:(UIViewController *)currentViewController ViewSwitchType:(ViewSwitchType)viewSwitchType GesturePasswordType:(GesturePasswordType)gesturePasswordType textModel:(HZBTextModel *)textModel;

+(BOOL)touchIsExist ;
+(HZBTextModel *)getTextModel ;

@end
