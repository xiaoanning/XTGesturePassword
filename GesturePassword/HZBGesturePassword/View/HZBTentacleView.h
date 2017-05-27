
#import <UIKit/UIKit.h>
#import "HZBGesturePasswordButton.h"

@interface HZBTentacleView : UIView

@property ( nonatomic , retain ) NSArray <HZBGesturePasswordButton *> * buttonArray;

@property ( nonatomic , copy ) void(^touchesEndedCallback)(NSString * touchesResult) ;
@property ( nonatomic , copy ) void(^touchesBeginCallback)() ;


@property ( nonatomic , assign ) BOOL success ;



/**
        清空数据 恢复到初始话状态
 */
- (void)clear ;

@end
