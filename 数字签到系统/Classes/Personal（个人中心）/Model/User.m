//
//  User.m
//  数字签到系统
//
//  Created by VOREVER on 2/9/16.
//  Copyright © 2016 XiongSiYao. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _username = dict[@"data"][@"username"];
        _email = dict[@"data"][@"email"];
        _nickname = dict[@"data"][@"nickname"];
        _number = dict[@"data"][@"number"];
        _create_time = dict[@"data"][@"create_time"];
        _last_time = dict[@"data"][@"last_time"];
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"username = %@, email = %@, nickname = %@, number = %@, create_time = %@, last_time = %@", self.username, self.email, self.nickname, self.number, self.create_time, self.last_time];
}

@end
