//
//  ParentChildView.m
//  Traveling
//
//  Created by 郑文青 on 16/7/5.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "ParentChildView.h"

@interface ParentChildView()
@property (weak, nonatomic) IBOutlet UIImageView *iv1;
@property (weak, nonatomic) IBOutlet UIImageView *iv2;
@property (weak, nonatomic) IBOutlet UIImageView *iv3;
@property (weak, nonatomic) IBOutlet UIImageView *iv4;
@property (weak, nonatomic) IBOutlet UIImageView *iv5;

@end

@implementation ParentChildView

-(void)layoutSubviews
{
    [self.iv1 setRoundBorderWidth:1 borderColor:kBgColor];
    [self.iv2 setRoundBorderWidth:1 borderColor:kBgColor];
    [self.iv3 setRoundBorderWidth:1 borderColor:kBgColor];
    [self.iv4 setRoundBorderWidth:1 borderColor:kBgColor];
    [self.iv5 setRoundBorderWidth:1 borderColor:kBgColor];
    [self.parentChildBtn setRoundRectLayerCornerRadius:3 borderWidth:1 borderColor:[UIColor whiteColor]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
