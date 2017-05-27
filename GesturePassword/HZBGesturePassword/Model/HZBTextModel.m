//
//  HZBTextModel.m
//  GesturePassword
//
//  Created by 安宁 on 2017/5/24.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "HZBTextModel.h"

@implementation HZBTextModel

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _customerId = @"customerIdTest";
        _userId = @"userIdTest" ;
        _userName = @"userNameTest" ;
        _phoneNum = @"18538365004" ;
    }
    return self ;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.customerId forKey:@"customerId"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.phoneNum forKey:@"phoneNum"];


}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.customerId = [aDecoder decodeObjectForKey:@"customerId"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];

    }
    
    return self ;
}


@end
