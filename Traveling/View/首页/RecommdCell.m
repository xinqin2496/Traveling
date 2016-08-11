//
//  RecommdCell.m
//  Traveling
//
//  Created by 郑文青 on 16/7/5.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "RecommdCell.h"

@implementation RecommdCell

- (void)awakeFromNib {
   
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.cornerRadius = 3;
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.cornerRadius = 3;
    self.btn3.layer.masksToBounds = YES;
    self.btn3.layer.cornerRadius = 3;
    self.btn4.layer.masksToBounds = YES;
    self.btn4.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
