//
//  HZBGesturePasswordUtil.m
//  GesturePassword
//
//  Created by 安宁 on 2017/5/22.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBGesturePasswordUtil.h"

#define KKTouchMinLength 4

#define KKTouchIsLoginErrorTips @"登陆密码错误"
#define KKTouchIsLengthLessTips [NSString stringWithFormat:@"请至少连接%@个点",@(KKTouchMinLength)]

#define KKTouchIsVeriOriginPWWhenResetErrorTips @"密码验证错误"


#define KKTouchInfo @"KKTouchInfo"

#define KKPhoneNumPassword @"KKPhoneNumPassword"


typedef NS_ENUM(NSInteger , ResetVerifiType)
{
    ResetVerifiTypePhoneNum = 1 , //手机号
    ResetVerifiTypeUserId = 2 , //用户id
};

@interface HZBGesturePasswordUtil ()


@end

@implementation HZBGesturePasswordUtil

#pragma mark 初始化手势视图
+(void)showGestureViewWithCurrentViewController:(UIViewController *)currentViewController ViewSwitchType:(ViewSwitchType)viewSwitchType GesturePasswordType:(GesturePasswordType)gesturePasswordType textModel:(HZBTextModel *)textModel
{
    if ( !textModel && (gesturePasswordType == GesturePasswordTypeLogin || gesturePasswordType == GesturePasswordTypeReset) )
    {
        textModel = [HZBGesturePasswordUtil getTextModel];
    }
    
    @try {
        
        if (![HZBGesturePasswordUtil touchIsExist])
        {
            NSAssert(textModel != nil, @"数据信息不能为null");
        }
        
    } @catch (NSException *exception) {
        return ;
    } @finally {

    }
    
    
    HZBGesturePasswordController * vc = [[HZBGesturePasswordController alloc]initWithType:gesturePasswordType ];
    
    
    [vc setTouchesEndedCallback:^(NSString * touchesResult , GesturePasswordType type ,void(^resultCallback)(TouchCode code , NSString * tips)){
       
        [HZBGesturePasswordUtil checkTouchResult:touchesResult andType:type andCallback:resultCallback ViewController:currentViewController ViewSwitchType:viewSwitchType textModel:textModel];
    }];
    
    __block typeof(self) weakSelf = self ;
    if (gesturePasswordType == GesturePasswordTypeLogin )
    {
        [vc setOtherLoginType:^(UIViewController * currentVC){
            [weakSelf otherLoginType:currentVC];
        }];
        
        [vc setForgetPasswordWhenLoginCallback:^(UIViewController * currentVC){
            
            NSLog(@"忘记手势密码，直接进入密码登陆页 或者选择其他登陆方式");
            [weakSelf otherLoginType:currentVC];
            
        }];
    }else if(gesturePasswordType == GesturePasswordTypeReset )
    {
        [vc setForgetPasswordWhenResetCallback:^(UIViewController * currentVC , void(^passwordRightCallback)()){
            NSLog(@"弹出密码输入框 输入通过后重新绘制");
            [weakSelf forgetPasswordWhenReset:currentVC passwordRightCallback:passwordRightCallback];
        }];
    }
        

    
    if (viewSwitchType == ViewSwitchTypeModel)
    {
        [currentViewController presentViewController:vc animated:YES completion:^{
            
        }];
    }else if (viewSwitchType == ViewSwitchTypeNavigation)
    {
        @try {
            
            NSAssert(currentViewController.navigationController != nil , @"导航栏为nil ");
            
        } @catch (NSException *exception)
        {
            return ;
        } @finally {
            
        }
        
        [currentViewController.navigationController pushViewController:vc animated:YES];
    
    }

}

#pragma mark 手势滑动完后的校验
+(void)checkTouchResult:(NSString * ) touchesResult andType:( GesturePasswordType ) type andCallback:(void(^)(TouchCode code , NSString * tips))callback ViewController:(UIViewController *)vc ViewSwitchType:(ViewSwitchType)viewSwitchType textModel:(HZBTextModel *)textModel
{
    if (type == GesturePasswordTypeLogin)
    {
        //控制规则校验
        if (touchesResult.length < KKTouchMinLength)
        {
            callback(TouchIsLoginError,KKTouchIsLoginErrorTips);
            
        }else
        {
            //与原密码校验
#warning 测试  需要提交服务器 与原密码校验

            if ([touchesResult isEqualToString:@"1234"])
            {
                callback(TouchIsSuccess,nil);
                
                //登陆成功 以后的操作
                NSLog(@"%@",@"登陆成功");
                [self backWithViewController:vc ViewSwitchType:viewSwitchType];
                
            }else
            {
                callback(TouchIsLoginError,KKTouchIsLoginErrorTips);
            }
        }
    }else if (type == GesturePasswordTypeOneStepSet)
    {

        //控制规则校验
        if (touchesResult.length < KKTouchMinLength)
        {
            callback(TouchIsLengthLess,KKTouchIsLengthLessTips);
            
        }else
        {
                callback(TouchIsSuccess,nil);
                
        }

    }else if (type == GesturePasswordTypeSet)
    {
        //提交设置
        
#warning 测试  需要提交服务器
        BOOL success = YES ;
        
        if (success)
        {
            
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:textModel];
            [[NSUserDefaults standardUserDefaults ]setObject:data forKey:KKTouchInfo];
            callback(TouchIsSuccess , @"设置成功");
            [self backWithViewController:vc ViewSwitchType:viewSwitchType];
        }else
        {
            callback(TouchIsError, @"其他错误");
        }
    }else if (type == GesturePasswordTypeReset)
    {
        //控制规则校验
        if (touchesResult.length < KKTouchMinLength)
        {
            callback(TouchIsLoginError,KKTouchIsVeriOriginPWWhenResetErrorTips);
            
        }else
        {
            //与原密码校验
#warning 测试  需要提交服务器 与原密码校验
            
            if ([touchesResult isEqualToString:@"1234"])
            {
                callback(TouchIsSuccess,nil);
                
                //登陆成功 以后的操作
                NSLog(@"%@",@"验证成功");

                callback(TouchIsSuccess , nil);
            }else
            {
                callback(TouchIsLoginError,KKTouchIsVeriOriginPWWhenResetErrorTips);
            }
        }

    }

}

#pragma mark 返回
+(void)backWithViewController:(UIViewController *)vc ViewSwitchType:(ViewSwitchType)viewSwitchType
{
    if (viewSwitchType == ViewSwitchTypeModel)
    {
        [vc dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else if (viewSwitchType == ViewSwitchTypeNavigation && vc.navigationController)
    {
        [vc.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 判断手势是否已经设置
+(BOOL)touchIsExist
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KKTouchInfo] ? YES : NO ;
}

#pragma mark 获得手势设置的账户相关信息
+(HZBTextModel *)getTextModel
{
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:KKTouchInfo];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark 其他登陆方式
+(void)otherLoginType:(UIViewController *)vc
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择其他登陆方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"密码登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            //密码登陆
        NSLog(@" 已选择密码登陆");
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"指纹登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@" 已选择指纹登陆");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [vc presentViewController:alertController animated:YES completion:^{
        
    }];

}

#pragma mark 重置时忘记密码

+(void)forgetPasswordWhenReset:(UIViewController * ) currentVC  passwordRightCallback:(void(^)())passwordRightCallback
{
    __block typeof(self) weakSelf = self ;

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择其他验证方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"手机号密码验证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf verifiTypeWhenReset:ResetVerifiTypePhoneNum viewController:currentVC passwordRightCallback:passwordRightCallback];
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"用户ID密码验证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf verifiTypeWhenReset:ResetVerifiTypeUserId viewController:currentVC passwordRightCallback:passwordRightCallback];

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [currentVC presentViewController:alertController animated:YES completion:^{
        
    }];

}
#pragma mark 重置密码时 其他验证方式
+(void)verifiTypeWhenReset:(ResetVerifiType)type viewController: (UIViewController * ) currentVC  passwordRightCallback:(void(^)())passwordRightCallback
{
    HZBTextModel * model = [HZBGesturePasswordUtil getTextModel];
    
    __block typeof(self) weakSelf = self ;
    
    NSString * phoneNum = [NSString stringWithFormat:@"手机号:%@",  model.phoneNum];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"手机号验证" message:phoneNum preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.tag = 100 ;
        textField.placeholder = @"请输入手机号登陆密码" ;
        textField.secureTextEntry = YES ;
        
        [[NSNotificationCenter defaultCenter]addObserver:weakSelf selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:weakSelf selector:@selector(textFieldTextDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:nil];
        
        
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf removeObserver];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf postDataToVerifiPhoneNum:currentVC passwordRightCallback:passwordRightCallback];
    }]];
    
    [currentVC presentViewController:alertController animated:YES completion:^{
        
    }];

    if (type == ResetVerifiTypePhoneNum)
    {
    }else if (type == ResetVerifiTypeUserId)
    {
        __block typeof(self) weakSelf = self ;
        
        NSString * phoneNum = [NSString stringWithFormat:@"用户:%@ (%@)", model.userName,model.userId];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"用户ID验证" message:phoneNum preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            textField.tag = 100 ;
            textField.placeholder = @"请输入用户ID登陆密码" ;
            textField.secureTextEntry = YES ;
            
            [[NSNotificationCenter defaultCenter]addObserver:weakSelf selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
            [[NSNotificationCenter defaultCenter]addObserver:weakSelf selector:@selector(textFieldTextDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:nil];
            
            
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakSelf removeObserver];
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf postDataToVerifiPhoneNum:currentVC passwordRightCallback:passwordRightCallback];
        }]];
        
        [currentVC presentViewController:alertController animated:YES completion:^{
            
        }];

    }

}

#pragma mark 与服务器通讯 验证手机号密码
+(void)postDataToVerifiPhoneNum:(UIViewController * ) currentVC  passwordRightCallback:(void(^)())passwordRightCallback
{
    NSString * str = [[NSUserDefaults standardUserDefaults]objectForKey:KKPhoneNumPassword];
    
    if (!str)
    {
        [self postDataToVerifiPhoneNum:currentVC passwordRightCallback:passwordRightCallback];
        return ;
    }
    
#warning 测试 应该请求服务器
#if 1 //测试
    if ([str isEqualToString:@"111111"])
    {
        passwordRightCallback();
    }else
    {
        NSLog(@"测试密码为6个1");
    }
    
#endif
    
}

#pragma mark UITextField Notification
+(void)textFieldTextDidChangeNotification:(NSNotification *)notifi
{
    if ([notifi.object isKindOfClass:[UITextField class]] && [(UITextField *)notifi.object tag] == 100)
    {
        @try {
            
            NSString * str = [(UITextField *)notifi.object text];

        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }

}

+(void)textFieldTextDidEndEditingNotification:(NSNotification *)notifi
{
    if ([notifi.object isKindOfClass:[UITextField class]] && [(UITextField *)notifi.object tag] == 100)
    {
        @try {

            NSString * str = [(UITextField *)notifi.object text];
            if (!str)
            {
                str = @"";
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:str forKey:KKPhoneNumPassword];

        } @catch (NSException *exception) {

        } @finally {

        }
    }
    
}
+(void)removeObserver
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}



@end
