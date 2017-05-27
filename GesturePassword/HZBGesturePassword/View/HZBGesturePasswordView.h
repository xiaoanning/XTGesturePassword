

/*
    手势的承载视图
 */

#import <UIKit/UIKit.h>
#import "HZBTentacleView.h"
#import "HZBTextModel.h"

typedef NS_ENUM(NSUInteger , TouchCode)
{
    TouchIsSuccess    = 1 , //登陆时与原密码校验一致 ;  设置时符合规则要求 ; 二次校验与第一次输入一致 ;
    TouchIsLengthLess = 2 , //密码长度不够
    TouchIsLoginError = 3 , // 登陆／重置 密码与原密码校验错误
    TouchIsTwoStepVerificationError = 4 ,//二次校验错误
    TouchIsError = 5 , //其他错误
};


typedef NS_ENUM(NSUInteger, GesturePasswordType)
{
    GesturePasswordTypeLogin = 1, //登陆 或者是校验已设密码

    GesturePasswordTypeSet = 2, // 提交设置

    GesturePasswordTypeOneStepSet = 3, //设置时第一次输入

    GesturePasswordTypeTwoStepVerification = 4, //设置时二次校验
    
    GesturePasswordTypeReset = 5, //重置
    

};


@interface HZBGesturePasswordView : UIView

- (id)initWithFrame:(CGRect)frame type:(GesturePasswordType)type ;

@property ( nonatomic , copy ) void(^touchesEndedCallback)(NSString * touchesResult ,  GesturePasswordType type ,void(^resultCallback)(TouchCode code  , NSString * tips)) ;

@property ( nonatomic , copy ) void(^forgetPasswordWhenLoginCallback)() ;
@property ( nonatomic , copy ) void(^forgetPasswordWhenResetCallback)() ;

@property ( nonatomic , copy ) void(^otherLoginType)() ;

@end
