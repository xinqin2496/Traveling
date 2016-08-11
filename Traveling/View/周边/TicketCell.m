//
//  TicketCell.m
//  Traveling
//
//  Created by 郑文青 on 16/7/12.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

- (void)awakeFromNib {
    self.iconIV.layer.masksToBounds = YES;
    self.iconIV.layer.cornerRadius = 3;
    self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
