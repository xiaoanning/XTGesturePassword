
#import "HZBGesturePasswordController.h"
#import "HZBTentacleView.h"


@interface HZBGesturePasswordController ()

@property ( nonatomic , copy ) NSString * firstGesturePassword ;


@property (nonatomic,strong) HZBGesturePasswordView * gesturePasswordView;



@end

@implementation HZBGesturePasswordController

-(instancetype)initWithType:(GesturePasswordType)type 
{
    self = [super init];
    
    if (self)
    {
        _type = type ;
        
    }
    
    return self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createUI];
}

#pragma mark - 创建UI

-(void)createUI
{
    _gesturePasswordView = [[HZBGesturePasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds type:_type ];

    __block typeof(self) weakSelf = self ;
    
    if (_type == GesturePasswordTypeReset )
    {
        [_gesturePasswordView setTouchesEndedCallback:^(NSString * touchesResult ,  GesturePasswordType type ,void(^resultCallback)(TouchCode code  , NSString * tips)){
            
            weakSelf.touchesEndedCallback(touchesResult , type , ^(TouchCode code  , NSString * tips){
                
                if (code == TouchIsSuccess)
                {
                    [weakSelf checkOriginPasswordRightToChangeUI];
                }else
                {
                    resultCallback(code , tips);
                }
            }) ;
            
        }];

    }else
    {
        [_gesturePasswordView setTouchesEndedCallback:_touchesEndedCallback];
    }
    

    if (_type == GesturePasswordTypeLogin )
    {
        
        [_gesturePasswordView setForgetPasswordWhenLoginCallback:^{
            
            if (weakSelf.forgetPasswordWhenLoginCallback)
            {
                weakSelf.forgetPasswordWhenLoginCallback(weakSelf);
            }

        }];

    }else if ( _type == GesturePasswordTypeReset)
    {
        [_gesturePasswordView setForgetPasswordWhenResetCallback:^{
            
            if (weakSelf.forgetPasswordWhenResetCallback)
            {
                weakSelf.forgetPasswordWhenResetCallback(weakSelf , ^{
                    
                    [weakSelf checkOriginPasswordRightToChangeUI];
                });
            }

        }];
    }
    
    if (_type == GesturePasswordTypeLogin )
    {
        [_gesturePasswordView setOtherLoginType:^{
            
            if (weakSelf.otherLoginType)
            {
                weakSelf.otherLoginType(weakSelf);
            }
            
        }];

    }

    
    
    [self.view addSubview:_gesturePasswordView];
}

-(void)checkOriginPasswordRightToChangeUI
{
    _gesturePasswordView = [[HZBGesturePasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds type:GesturePasswordTypeOneStepSet ];
    [self.view addSubview:_gesturePasswordView];
    
    [_gesturePasswordView setTouchesEndedCallback:_touchesEndedCallback];

}


@end
