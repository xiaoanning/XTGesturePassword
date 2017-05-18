
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
