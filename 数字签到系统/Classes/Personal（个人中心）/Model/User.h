//
//  User.h
//  数字签到系统
//
//  Created by VOREVER on 2/9/16.
//  Copyright © 2016 XiongSiYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *last_time;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
