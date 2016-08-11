//
//  TravelCell.m
//  Traveling
//
//  Created by 郑文青 on 16/7/6.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "TravelCell.h"

@implementation TravelCell

- (void)awakeFromNib {
    [self.iconIV setRoundBorderWidth:1 borderColor:kBgColor];
    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
