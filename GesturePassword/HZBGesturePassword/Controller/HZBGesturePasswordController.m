
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
    _gesturePasswordView = [[HZBGesturePasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds type:_type];

    [self.view addSubview:_gesturePasswordView];
}


//#pragma mark - 设置手势密码
//-(void)setGesturePassword
//{
//
//}
//
//#pragma mark - 验证手势密码
//- (void)verifyGesturePassword
//{
//
//}
//
//#pragma mark - 重置手势密码
//- (void)resetGesturePassword
//{
//
//}

#pragma mark - 判断是否已存在手势密码
- (BOOL)exist
{
    NSString * password = @"" ;
    if ([password isEqualToString:@""])
    {
        return NO;
    }
    
    return YES;
}


#pragma mark - 取消手势密码

- (void)backToView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//关闭手势
- (void)closeGesture
{
    //发送数据
}

#pragma mark - 重新设置手势密码
- (void)againSetGesturePassword
{
    [_gesturePasswordView.resetButton setHidden:NO];
    _firstGesturePassword = @"";
    [_gesturePasswordView.tipsLabel setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
    [_gesturePasswordView clearDrawView];
}

#pragma mark - 其他账号登陆
- (void)change
{

}

#pragma mark - 忘记手势密码
- (void)forget
{
    
}

//验证密码
- (void)verification:(NSString *)result
{
    
    if(result.length<6){
        if (result.length == 4) {
            result = [NSMutableString stringWithFormat:@"00%@",result];
        }else if(result.length == 5){
            result = [NSMutableString stringWithFormat:@"0%@",result];
        }else{
            [_gesturePasswordView.tentacleView enterArgin];
            [_gesturePasswordView.tipsLabel setTextColor:[UIColor redColor]];
            [_gesturePasswordView.tipsLabel setText:@"手势密码小于4位，请重新输入"];
            [_gesturePasswordView.tentacleView showDifferent:YES] ;
            return;
        }
    }
    
    self.view.userInteractionEnabled=NO;
    
    
}

//重新设置密码
- (void)resetPassword:(NSString *)result withArray:(NSMutableArray * )touchesArray
{
    if ([_firstGesturePassword isEqualToString:@""])
    {
        if(result.length < 4)
        {
            [_gesturePasswordView.tentacleView enterArgin];
            [_gesturePasswordView.tipsLabel setTextColor:[UIColor redColor]];
            [_gesturePasswordView.tipsLabel setText:@"手势密码小于4位，请重新输入"];
        }else
        {
            _firstGesturePassword=result;
            [_gesturePasswordView checkdrawView:touchesArray];
            [_gesturePasswordView.tentacleView enterArgin];
            [_gesturePasswordView.tipsLabel setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];

            [_gesturePasswordView.tipsLabel setTextColor:[UIColor blackColor]];
            [_gesturePasswordView.tipsLabel setText:@"请再次绘制解锁图案"];
            [self performSelector:@selector(clear) withObject:nil afterDelay:0.8];
        }
        [_gesturePasswordView.tentacleView showDifferent:YES] ;
        [_gesturePasswordView.resetButton setHidden:NO];
    }else
    {
        if ([result isEqualToString:_firstGesturePassword])
        {
//             设置密码和账号
            //发送到后台设置
            
            if(result.length<6)
            {
                if (result.length == 4)
                {
                    result = [NSString stringWithFormat:@"00%@",result];
                }else
                {
                    result = [NSString stringWithFormat:@"0%@",result];
                }
            }
            
            //判断指纹是否已开启
            
            if(/* DISABLES CODE */ (YES))
            {
//                self.request = result;
                //关闭指纹
                [self closeTouchID];
            }else
            {
                //开启手势
                [self openGesture:result];
            }

        }else
        {
            [_gesturePasswordView.tipsLabel setTextColor:[UIColor redColor]];
            [_gesturePasswordView.tipsLabel setText:@"两次密码不一致，请重新输入"];
            [self performSelector:@selector(clear) withObject:nil afterDelay:0.8];
           [_gesturePasswordView.tentacleView showDifferent:NO] ;
        }
    }
}

- (void)openGesture:(NSString *)result
{
    //发送到后台设置
}


//关闭指纹设置
- (void)closeTouchID
{
    //发送数据
}


- (void)clear
{
    [_gesturePasswordView.tentacleView enterArgin];
}

- (void)removeMyView
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
