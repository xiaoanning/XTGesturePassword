//
//  HZBTextModel.h
//  GesturePassword
//
//  Created by 安宁 on 2017/5/24.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZBTextModel : NSObject<NSCoding>

@property ( nonatomic , copy ) NSString * customerId ;
@property ( nonatomic , copy ) NSString * userId ;
@property ( nonatomic , copy ) NSString * userName ;
@property ( nonatomic , copy ) NSString * phoneNum ;


@end
