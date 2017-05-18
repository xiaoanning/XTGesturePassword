
#import <UIKit/UIKit.h>

@protocol ResetDelegate <NSObject>

- (void)resetPassword:(NSString *)result withArray:(NSMutableArray * )touchesArray;

@end

@protocol VerificationDelegate <NSObject>

- (void)verification:(NSString *)result;

@end

@protocol TouchBeginDelegate <NSObject>

//- (void)gestureTouchBegin;

@end



@interface HZBTentacleView : UIView

@property (nonatomic,strong) NSArray * buttonArray;

@property (nonatomic,assign) id<VerificationDelegate> rerificationDelegate;

@property (nonatomic,assign) id<ResetDelegate> resetDelegate;

@property (nonatomic,assign) id<TouchBeginDelegate> touchBeginDelegate;

/*
 判断是设置还是验证
 1: Verify
 2: Reset
 */
@property (nonatomic,assign) NSInteger style;

- (void)enterArgin;
- (void)enterArginRed;
- (void)showDifferent:(BOOL)suc;
@end
