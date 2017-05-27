#import "HZBGesturePasswordView.h"
#import "HZBGestureSmallButton.h"
#import "HZBGesturePasswordButton.h"
#import "HZBTentacleView.h"
#import "HZBGesturePasswordUtil.h"


@interface HZBGesturePasswordView ()


@property ( nonatomic , assign ) GesturePasswordType type ;

@property ( nonatomic , retain ) UILabel * titleLabel2 ;

@property ( nonatomic , retain ) UIView * smallGestureView ;
@property ( nonatomic , retain ) UIView * bigGestureView ;


@property ( nonatomic , strong ) UILabel * bottomLeftLabel;
@property ( nonatomic , strong ) UILabel * bottomrightLabel;



@property ( nonatomic , copy ) NSString * resultStr;
@property ( nonatomic , copy ) NSString * firstTouchStr;

@property ( nonatomic , strong ) UILabel * tipsLabel;

@property (nonatomic,strong) UILabel *userTitle;

@property (nonatomic,strong) HZBTentacleView * tentacleView;



@end

@implementation HZBGesturePasswordView
{
    NSMutableArray * _buttonArray;
    
}

- (id)initWithFrame:(CGRect)frame type:(GesturePasswordType)type 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _type = type ;
        
        self.backgroundColor = KKBlueColor ;
        
        CGFloat y = 0 ;
        
        NSUInteger rowItemCount = 3 ;
        NSUInteger colItemCount = 3 ;

        if (type == GesturePasswordTypeLogin || type == GesturePasswordTypeReset)
        {
            CGFloat topSpace = 163.0f / 1334.0f * KKScreenHeight ;
            y += topSpace ;

            UILabel * unlockTitleLabel = [[UILabel alloc]init];
            [unlockTitleLabel setTextColor:[UIColor whiteColor]];
            [unlockTitleLabel setBackgroundColor: [UIColor clearColor]];
            [unlockTitleLabel setTextAlignment:NSTextAlignmentCenter];
            if (type == GesturePasswordTypeLogin)
            {
                unlockTitleLabel.text = @"手势解锁";

            }else if (type == GesturePasswordTypeReset)
            {
                unlockTitleLabel.text = @"验证手势";
            }
            [unlockTitleLabel setFont:KKFont22];
            
            [unlockTitleLabel sizeToFit];
            CGFloat unlockLabelWidth = CGRectGetWidth(unlockTitleLabel.frame) ;
            CGFloat unlockLabelHeight = CGRectGetHeight(unlockTitleLabel.frame) ;
            unlockTitleLabel.frame = CGRectMake( CGRectGetMidX(frame) - unlockLabelWidth/2.0 , y, unlockLabelWidth, unlockLabelHeight) ;
            [self addSubview:unlockTitleLabel];
            
            
            y += unlockLabelHeight + 80.0f / 1330.0f * KKScreenHeight ;
            
            UILabel * userNameLabel = [[UILabel alloc]init];
            [userNameLabel setTextColor:[UIColor whiteColor]];
            HZBTextModel * model = [HZBGesturePasswordUtil getTextModel];
            userNameLabel.text =[NSString stringWithFormat:@"当前帐户：%@ (%@)",
                              model.userName , model.userId];
            userNameLabel.textAlignment = NSTextAlignmentCenter;
            [userNameLabel setBackgroundColor: [UIColor clearColor]];
            
            [userNameLabel sizeToFit];
            CGFloat userNameLabelWidth = CGRectGetWidth(userNameLabel.frame) ;
            CGFloat userNameLabelHeight = CGRectGetHeight(userNameLabel.frame) ;
            userNameLabel.frame = CGRectMake( CGRectGetMidX(frame) - userNameLabelWidth/2.0 , y, userNameLabelWidth, userNameLabelHeight) ;

            [self addSubview:userNameLabel];
            
            y += userNameLabelHeight + (160.0f - 60.0f) / 1330.0f * KKScreenHeight ;
            

        }else if(type == GesturePasswordTypeOneStepSet)
        {
            CGFloat topSpace = 163.0f / 1334.0f * KKScreenHeight ;
            y += topSpace ;
            
            UILabel * titleLabel1 = [[UILabel alloc]init] ;
            [titleLabel1 setTextColor:[UIColor whiteColor]];
            [titleLabel1 setTextAlignment:NSTextAlignmentCenter];
            titleLabel1.text = @"设置手势密码";
            [titleLabel1 setBackgroundColor: [UIColor clearColor]];
            [titleLabel1 setFont:KKFont22];
            [titleLabel1 sizeToFit];
            CGFloat titleLabel1Height = CGRectGetHeight(titleLabel1.frame) ;
            CGFloat titleLabel1Width = CGRectGetWidth(titleLabel1.frame) ;
            titleLabel1.frame =  CGRectMake(CGRectGetMidX(frame) - titleLabel1Width/2.0 , y , titleLabel1Width , titleLabel1Height );
            [self addSubview:titleLabel1];

            
            CGFloat space1 = 30.0f /1330.0f * KKScreenHeight ;
            
            y += titleLabel1Height + space1 ;
            
            _titleLabel2 = [[UILabel alloc]init];
            [_titleLabel2 setTextColor:[UIColor whiteColor]];
            _titleLabel2.text = @"绘制解锁图案";
            _titleLabel2.textAlignment = NSTextAlignmentCenter;
            [_titleLabel2 setBackgroundColor: [UIColor clearColor]];
            [_titleLabel2 setFont:KKFont16];
            [_titleLabel2 sizeToFit];
            CGFloat titleLabel2Height = CGRectGetHeight(_titleLabel2.frame) ;
            CGFloat titleLabel2Width = KKScreenWidth ;
            _titleLabel2.frame =  CGRectMake(CGRectGetMidX(frame) - titleLabel2Width/2.0 , y , titleLabel2Width , titleLabel2Height );

            [self addSubview:_titleLabel2];

            
            CGFloat space2 = 20.0f / 1330.0f * KKScreenHeight ;
            
            y += titleLabel2Height + space2 ;
            
            CGFloat itemWidth = 40.0f/750.0f * KKScreenWidth ;
            CGFloat midSpace =  10.0f/750.0f * KKScreenWidth ;
            
            CGFloat superWidth = itemWidth * rowItemCount  + midSpace * (rowItemCount -1);
            CGFloat superHeight = superWidth ;

            _smallGestureView = [[UIView alloc]initWithFrame:CGRectMake( CGRectGetMidX(frame) - superWidth/2.0 , y, superWidth, superHeight)];
            [_smallGestureView setBackgroundColor:KKClearColor];
            [self addSubview:_smallGestureView];

            for (int i = 0; i < rowItemCount * colItemCount ;  i ++ )
            {
                HZBGestureSmallButton * gestureSmallButton = [[HZBGestureSmallButton alloc]initWithFrame:CGRectMake((itemWidth + midSpace)*(i%rowItemCount) , (itemWidth + midSpace) * (i / rowItemCount), itemWidth, itemWidth)];
                [gestureSmallButton setTag:i+100];
//                gestureSmallButton.backgroundColor = KKGrayColor ;
                [_smallGestureView addSubview:gestureSmallButton];
            }

            y += superHeight ;
        }
        
        
        
        _buttonArray = [NSMutableArray array];
        
        
        CGFloat leftSpace = 103.0f/750.0f * KKScreenWidth ;
        CGFloat rightSpace = 103.0f/750.0f * KKScreenWidth ;
        CGFloat itemWidth = 124.0f/750.0f * KKScreenWidth ;
        CGFloat midSpace = (KKScreenWidth - leftSpace - rightSpace - itemWidth * rowItemCount)/(rowItemCount -1) ;
        CGFloat topSpace = 60.0f / 1330.0f * KKScreenHeight ;
        CGFloat bottomSpace = 130.0f / 1330.0f * KKScreenHeight ;
        
        _bigGestureView = [[UIView alloc]initWithFrame:CGRectMake(0, y, KKScreenWidth, topSpace + bottomSpace + itemWidth * colItemCount + midSpace * (colItemCount -1))];

        
        for (int i = 0 ; i < rowItemCount * colItemCount ; i ++ )
        {

            HZBGesturePasswordButton * gesturePasswordButton = [[HZBGesturePasswordButton alloc]initWithFrame:CGRectMake( leftSpace + (itemWidth + midSpace) * ( i % rowItemCount ), topSpace + (itemWidth + midSpace) * ( i / rowItemCount), itemWidth, itemWidth)];
            [gesturePasswordButton setTag:i];
            [_bigGestureView addSubview:gesturePasswordButton];
            [_buttonArray addObject:gesturePasswordButton];
        }

        [self addSubview:_bigGestureView];
        _tentacleView = [[HZBTentacleView alloc]initWithFrame:_bigGestureView.frame];
        
        __block typeof(self) weakSelf = self ;

        [_tentacleView setTouchesBeginCallback:^{
            
            [weakSelf changeUIWhenTouchesBegin];
        }];
        
        [_tentacleView setButtonArray:_buttonArray];

        [self addSubview:_tentacleView];
        
        
        y += CGRectGetHeight(_bigGestureView.frame) ;
        

        //登陆显示  设置：首次绘制解锁图案 请再次绘制解锁图案  错误时提示（两次密码不一致，密码不符合约定）
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, y - bottomSpace, KKScreenWidth, bottomSpace)];
        [_tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipsLabel setFont:KKFont14];
        [_tipsLabel setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [_tipsLabel setBackgroundColor: [UIColor clearColor]];
        [_tipsLabel setHidden:YES];
        [self addSubview:_tipsLabel];
        
        CGFloat bottomLabelWidth = (KKScreenWidth - leftSpace - rightSpace)/2.0f ;
        CGFloat bottomLabelHeight = 30.0f ;
        _bottomLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, y, bottomLabelWidth, bottomLabelHeight )];
        [_bottomLeftLabel setTextAlignment:NSTextAlignmentLeft];
        [_bottomLeftLabel setFont:KKFont14];
        [_bottomLeftLabel setTextColor:KKWhiteColor];
        _bottomLeftLabel.userInteractionEnabled = YES ;
        _bottomLeftLabel.hidden = YES ;
        [self addSubview:_bottomLeftLabel];
        
        
        _bottomrightLabel = [[UILabel alloc]initWithFrame:CGRectMake(KKScreenWidth - rightSpace - bottomLabelWidth, y, bottomLabelWidth, bottomLabelHeight )];
        [_bottomrightLabel setTextAlignment:NSTextAlignmentRight];
        [_bottomrightLabel setFont:KKFont14];
        [_bottomrightLabel setTextColor:KKWhiteColor];
        _bottomrightLabel.userInteractionEnabled = YES ;
        _bottomrightLabel.hidden = YES ;
        [self addSubview:_bottomrightLabel];


        if (type == GesturePasswordTypeLogin)
        {
            _bottomLeftLabel.hidden = NO ;
            [_bottomLeftLabel setText:@"忘记手势密码"];

            [self addGestureRecognizerForView:_bottomLeftLabel target:self action:@selector(forgetActionWhenLogin)];
            
            _bottomrightLabel.hidden = NO ;
            [_bottomrightLabel setText:@"其他登陆方式"];
            [self addGestureRecognizerForView:_bottomrightLabel target:self action:@selector(otherLoginTypeAction)];

        }else if (type == GesturePasswordTypeReset)
        {
            _bottomLeftLabel.hidden = NO ;
            [_bottomLeftLabel setText:@"忘记手势密码"];
            
            [self addGestureRecognizerForView:_bottomLeftLabel target:self action:@selector(forgetActionWhenReset)];
        }
        
        
    }
    
    return self;
}
#pragma mark 重置时忘记密码
-(void)forgetActionWhenReset
{
    NSLog(@"忘记密码按钮被点击");
    
    if (_forgetPasswordWhenResetCallback)
    {
        _forgetPasswordWhenResetCallback();
    }

}

#pragma mark 登陆时忘记密码
-(void)forgetActionWhenLogin
{
    NSLog(@"忘记密码按钮被点击");
    
    if (_forgetPasswordWhenLoginCallback)
    {
        _forgetPasswordWhenLoginCallback();
    }

}
#pragma mark 重新设置
-(void)resetAction
{
    NSLog(@"重新设置按钮被点击");
    
    [self setSmallButtonView:_firstTouchStr andSelected:NO];
    [_tentacleView clear];

    _resultStr = @"" ;
    _firstTouchStr = @"" ;
    _type = GesturePasswordTypeOneStepSet ;
    

}

-(void)otherLoginTypeAction
{
    NSLog(@"其他登陆方式按钮被点击");
    
    if (_otherLoginType)
    {
        _otherLoginType();
    }

}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        51 / 255.0, 181 / 255.0, 246 / 255.0, 1.00,
        21 / 255.0,  124 / 255.0, 222 / 255.0, 1.00,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
}

-(void)setTouchesEndedCallback:(void (^)(NSString *, GesturePasswordType, void (^)(TouchCode, NSString *)))touchesEndedCallback
{
    _touchesEndedCallback = touchesEndedCallback ;
    
    __block typeof(self) weakSelf = self ;
    
    [_tentacleView setTouchesEndedCallback:^(NSString * touchesResult ){
        
       weakSelf.resultStr = touchesResult ;
        
        
        if (weakSelf.type == GesturePasswordTypeTwoStepVerification)
        {
            if ([weakSelf.firstTouchStr isEqualToString:touchesResult])
            {
                weakSelf.type = GesturePasswordTypeSet ;

            }else
            {
                [weakSelf showResultUI:TouchIsTwoStepVerificationError andtips:@"两次密码不一致"];
                
                return  ;
            }
        }
        
        if (weakSelf.touchesEndedCallback )
        {
            weakSelf.touchesEndedCallback (touchesResult,weakSelf.type,^(TouchCode code , NSString * tips){
                [weakSelf showResultUI:code andtips:tips];
            });
        }
    }];

}

#pragma mark 设置小视图
- (void)setSmallButtonView:(NSString *)selectedStr andSelected:(BOOL)selected
{

    for(int i = 0 ; i < selectedStr.length ; i ++ )
    {
        NSInteger value = [[selectedStr substringWithRange:NSMakeRange(i, 1)] integerValue] ;

        @try {

            NSAssert(value > 0 , @"手势选中的数字有错 %@" ,  selectedStr);

        } @catch (NSException *exception) {

            return ;
            
        } @finally {

        }
        
        value -= 1 ;
        
        HZBGestureSmallButton *view = (HZBGestureSmallButton *)[_smallGestureView viewWithTag: value + 100];
        view.selected = selected;
        [view setNeedsDisplay];
    }
}

#pragma mark 加手势
-(void)addGestureRecognizerForView:(UIView *)gesView target:( id)target action:( SEL)action
{
    for (UIGestureRecognizer * ges in gesView.gestureRecognizers)
    {
        [gesView removeGestureRecognizer:ges];
    }
    [gesView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];

}

#pragma mark 根据校验结果显示ui

-(void)showResultUI:(TouchCode) code andtips:( NSString *) tips
{
    _tipsLabel.hidden = YES ;
    
    if (_type == GesturePasswordTypeLogin)
    {
        if (code == TouchIsSuccess)
        {
            //不做处理
        }else if (code == TouchIsLoginError )
        {
            _tipsLabel.hidden = NO ;
        }
        
    }else if (_type == GesturePasswordTypeSet)
    {
        
        NSLog(@"%@",tips);
        
    }else if (_type == GesturePasswordTypeOneStepSet)
    {
        if (code == TouchIsSuccess)
        {
            //保存 第一次设置的手势
            _firstTouchStr = _resultStr ;
            
            [self setSmallButtonView:_firstTouchStr andSelected:YES];
            [_tentacleView clear];
            
            //显示重新绘制按钮
            _bottomrightLabel.hidden = NO ;
            [_bottomrightLabel setText:@"重新绘制"];
            
            [self addGestureRecognizerForView:_bottomrightLabel target:self action:@selector(resetAction)];
            
            
            _type = GesturePasswordTypeTwoStepVerification ;
            _titleLabel2.text = [NSString stringWithFormat:@"%@",@"请再次输入以确认"];
            
        }else if(code == TouchIsLengthLess ) //失败 显示提示文字
        {
            _tipsLabel.hidden = NO ;
        }
            
        
    }else if (_type == GesturePasswordTypeTwoStepVerification)
    {
        if (code == TouchIsSuccess)
        {
            //不做处理
        }else if(code == TouchIsTwoStepVerificationError)
        {
            //设置不成功
            _tipsLabel.hidden = NO ;
            _bottomrightLabel.hidden = YES ;

        }else if (code == TouchIsError)
       {
      
       }
    }else if (_type == GesturePasswordTypeReset)
    {
        if (code == TouchIsSuccess)
        {
            
            
        }else if(code == TouchIsLoginError)
        {

            _tipsLabel.hidden = NO ;
        }
    }
    
    
    if (!_tipsLabel.hidden)
    {
        _tipsLabel.text = [NSString stringWithFormat:@"%@",tips];
        
        [_tentacleView setSuccess:NO];
        
        [self performSelector:@selector(showErrorUI) withObject:nil afterDelay:1];

    }

}

#pragma mark 错误时改变ui
-(void)showErrorUI
{
    [_tentacleView clear];
}

#pragma mark 手势开始时改变ui
-(void)changeUIWhenTouchesBegin
{
    //隐藏或显示相应的ui
    
}

@end



