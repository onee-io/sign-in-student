//
//  SignTableViewCell.h
//  数字签到系统
//
//  Created by VOREVER on 2/5/16.
//  Copyright © 2016 VOREVER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignTableViewCell;

@protocol SignTableViewCellDelegate <NSObject>

@optional
- (void)CellButtonClick:(SignTableViewCell *)signTableViewCell Button:(UIButton *)sender;

@end

@interface SignTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SignTableViewCellDelegate> delegate;

- (void)changeSignButtonStatus:(BOOL)status;

@end
