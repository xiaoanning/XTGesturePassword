

/*
    手势的承载视图
 */

#import <UIKit/UIKit.h>
#import "HZBTentacleView.h"

typedef NS_ENUM(NSUInteger, GesturePasswordType)
{
    GesturePasswordTypeLogin = 1,

    GesturePasswordTypeSet = 2,

    GesturePasswordTypeTwoStepVerification = 3,
    
    GesturePasswordTypeReset = 4,
    

};

@protocol GesturePasswordDelegate <NSObject>

- (void)forget;
- (void)change;
- (void)backToView;
- (void)closeGesture;
- (void)againSet;

@end


@interface HZBGesturePasswordView : UIView<TouchBeginDelegate>

- (id)initWithFrame:(CGRect)frame type:(GesturePasswordType)type;

@property (nonatomic,copy) NSString * userName;

@property ( nonatomic , strong ) UILabel * tipsLabel;


@property (nonatomic,strong) HZBTentacleView * tentacleView;

@property (nonatomic,strong) UILabel *bigTitle;
@property (nonatomic,strong) UILabel *smalllTitle;

@property (nonatomic,strong) UILabel *unlockTitle;
@property (nonatomic,strong) UILabel *userTitle;


@property (nonatomic,assign) id<GesturePasswordDelegate> gesturePasswordDelegate;


@property (nonatomic,strong) UIButton * backButton;
@property (nonatomic,strong) UIButton * resetButton;
@property (nonatomic,strong) UIButton * closeButton;

@property (nonatomic,strong) UIButton * forgetButton;
@property (nonatomic,strong) UIButton * changeButton;

@property (nonatomic,strong) UIView * drawView;

- (void)initViewWithType:(NSInteger )type;
- (void)checkdrawView:(NSArray *)array;
- (void)clearDrawView;

@end
