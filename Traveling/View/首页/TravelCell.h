//
//  TravelCell.h
//  Traveling
//
//  Created by 郑文青 on 16/7/6.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *DescIV;
@property (weak, nonatomic) IBOutlet UILabel *titlLb;
@property (weak, nonatomic) IBOutlet UILabel *routeLb;

@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UILabel *thumbUpLb;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;


@property (weak, nonatomic) IBOutlet UIButton *thumbUpBtn;

@end
