#import "HZBGesturePasswordView.h"
#import "GestureSmallButton.h"
#import "HZBGesturePasswordButton.h"
#import "HZBTentacleView.h"


@interface HZBGesturePasswordView ()


@property ( nonatomic , assign ) GesturePasswordType type ;


@property ( nonatomic , retain ) UIView * smallGestureView ;
@property ( nonatomic , retain ) UIView * bigGestureView ;


@property ( nonatomic , strong ) UILabel * bottomLeftLabel;
@property ( nonatomic , strong ) UILabel * bottomrightLabel;


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

        if (type == GesturePasswordTypeLogin)
        {
            CGFloat topSpace = 163.0f / 1334.0f * KKScreenHeight ;
            y += topSpace ;

            UILabel * unlockTitleLabel = [[UILabel alloc]init];
            [unlockTitleLabel setTextColor:[UIColor whiteColor]];
            [unlockTitleLabel setBackgroundColor: [UIColor clearColor]];
            [unlockTitleLabel setTextAlignment:NSTextAlignmentCenter];
            unlockTitleLabel.text = @"手势解锁";
            [unlockTitleLabel setFont:KKFont22];
            
            [unlockTitleLabel sizeToFit];
            CGFloat unlockLabelWidth = CGRectGetWidth(unlockTitleLabel.frame) ;
            CGFloat unlockLabelHeight = CGRectGetHeight(unlockTitleLabel.frame) ;
            unlockTitleLabel.frame = CGRectMake( CGRectGetMidX(frame) - unlockLabelWidth/2.0 , y, unlockLabelWidth, unlockLabelHeight) ;
            [self addSubview:unlockTitleLabel];
            
            
            y += unlockLabelHeight + 80.0f / 1330.0f * KKScreenHeight ;
            
            UILabel * userNameLabel = [[UILabel alloc]init];
            [userNameLabel setTextColor:[UIColor whiteColor]];
            _userTitle.text =[NSString stringWithFormat:@"当前帐户：%@", _userName];
            userNameLabel.textAlignment = NSTextAlignmentCenter;
            [userNameLabel setBackgroundColor: [UIColor clearColor]];
            
            [userNameLabel sizeToFit];
            CGFloat userNameLabelWidth = CGRectGetWidth(userNameLabel.frame) ;
            CGFloat userNameLabelHeight = CGRectGetHeight(userNameLabel.frame) ;
            userNameLabel.frame = CGRectMake( CGRectGetMidX(frame) - userNameLabelWidth/2.0 , y, userNameLabelWidth, userNameLabelHeight) ;

            [self addSubview:userNameLabel];
            
            y += userNameLabelHeight + (160.0f - 60.0f) / 1330.0f * KKScreenHeight ;
            

        }else
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
            
            UILabel * titleLabel2 = [[UILabel alloc]init];
            [titleLabel2 setTextColor:[UIColor whiteColor]];
            titleLabel2.text = @"绘制解锁图案";
            titleLabel2.textAlignment = NSTextAlignmentCenter;
            [titleLabel2 setBackgroundColor: [UIColor clearColor]];
            [titleLabel2 setFont:KKFont16];
            [titleLabel2 sizeToFit];
            CGFloat titleLabel2Height = CGRectGetHeight(titleLabel2.frame) ;
            CGFloat titleLabel2Width = CGRectGetWidth(titleLabel2.frame) ;
            titleLabel2.frame =  CGRectMake(CGRectGetMidX(frame) - titleLabel2Width/2.0 , y , titleLabel2Width , titleLabel2Height );

            [self addSubview:titleLabel2];

            
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
                GestureSmallButton * gestureSmallButton = [[GestureSmallButton alloc]initWithFrame:CGRectMake((itemWidth + midSpace)*(i%rowItemCount) , (itemWidth + midSpace) * (i / rowItemCount), itemWidth, itemWidth)];
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
        [_tentacleView setButtonArray:_buttonArray];
        [_tentacleView setTouchBeginDelegate:self];
        [self addSubview:_tentacleView];
        
        
        y += CGRectGetHeight(_bigGestureView.frame) ;
        

        //登陆不显示  设置：首次绘制解锁图案 请再次绘制解锁图案  错误时提示（两次密码不一致，密码不符合约定）
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, y - bottomSpace, KKScreenWidth, bottomSpace)];
        [_tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipsLabel setFont:KKFont14];
        [_tipsLabel setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [_tipsLabel setBackgroundColor: [UIColor clearColor]];
        [_tipsLabel setHidden:YES];
        [self addSubview:_tipsLabel];
        
        if (_type == GesturePasswordTypeSet )
        {
            
        }else
        {
            CGFloat bottomLabelWidth = (KKScreenWidth - leftSpace - rightSpace)/2.0f ;
            CGFloat bottomLabelHeight = 30.0f ;
            _bottomLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSpace, y, bottomLabelWidth, bottomLabelHeight )];
            [_bottomLeftLabel setTextAlignment:NSTextAlignmentLeft];
            [_bottomLeftLabel setFont:KKFont14];
            [_bottomLeftLabel setTextColor:KKWhiteColor];
            [_bottomLeftLabel setText:@"忘记手势密码"];
            _bottomLeftLabel.userInteractionEnabled = YES ;
            [_bottomLeftLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomLeftLabelAction)]];
            [self addSubview:_bottomLeftLabel];
            
            
            _bottomrightLabel = [[UILabel alloc]initWithFrame:CGRectMake(KKScreenWidth - rightSpace - bottomLabelWidth, y, bottomLabelWidth, bottomLabelHeight )];
            [_bottomrightLabel setTextAlignment:NSTextAlignmentRight];
            [_bottomrightLabel setFont:KKFont14];
            [_bottomrightLabel setTextColor:KKWhiteColor];
            [_bottomrightLabel setText:@"用其他账号登录"];
            _bottomrightLabel.userInteractionEnabled = YES ;
            [_bottomrightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomRightLabelAction)]];
            [self addSubview:_bottomrightLabel];
        }


        
    }
    
    return self;
}

-(void)bottomLeftLabelAction
{
    NSLog(@"左边按钮被点击");
}

-(void)bottomRightLabelAction
{
    NSLog(@"右边按钮被点击");

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


- (void)checkdrawView:(NSArray *)array
{
    
    [self clearDrawView];
    
    for ( NSDictionary * num in array ){
        if(![num objectForKey:@"num"])break;
        GestureSmallButton *view = (GestureSmallButton *)[_drawView viewWithTag:[[num objectForKey:@"num"] intValue]+99];
        view.selected = YES;
        [view setNeedsDisplay];
    }
}

- (void)clearDrawView
{
    for(int i = 0; i<9; i++) {
        GestureSmallButton *view = (GestureSmallButton *)[_drawView viewWithTag:i + 100];
        view.selected = NO;
        [view setNeedsDisplay];
    }
}

@end



