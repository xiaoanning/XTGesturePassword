
/*
        手势密码的 ViewController
 */


#import <UIKit/UIKit.h>
#import "HZBGesturePasswordView.h"



@interface HZBGesturePasswordController : UIViewController
{

}

-(instancetype)initWithType:(GesturePasswordType)type ;

@property ( nonatomic , assign , readonly ) GesturePasswordType type;


@property ( nonatomic , copy ) void(^touchesEndedCallback)(NSString * touchesResult ,  GesturePasswordType type ,void(^resultCallback)(TouchCode code  , NSString * tips)) ;

@property ( nonatomic , copy ) void(^forgetPasswordWhenLoginCallback)(UIViewController * currentVC) ;
@property ( nonatomic , copy ) void(^forgetPasswordWhenResetCallback)(UIViewController * currentVC , void(^passwordRightCallback)()) ;
@property ( nonatomic , copy ) void(^otherLoginType)(UIViewController * currentVC) ;


//-(void)setTouchesResult:(BOOL)success andSetType:(GesturePasswordType) type ;

//- (void)clear;
//
//
///**
//        是否存在手势密码
//
// */
//+ (BOOL)exist;
//
//- (void)backToView;
//- (void)againSetGesturePassword;
//-(void)forget;
//-(void)change;

@end
