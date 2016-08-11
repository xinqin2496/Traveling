//
//  ParentChildView.h
//  Traveling
//
//  Created by 郑文青 on 16/7/5.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentChildView : UIView
/**
 *  纵横大西北
 */
@property (weak, nonatomic) IBOutlet UIButton *YunanBtn;
/**
 *  港澳日韩游
 */
@property (weak, nonatomic) IBOutlet UIButton *HongKongBtn;
/**
 *  周边游
 */
@property (weak, nonatomic) IBOutlet UIButton *SwimAroundBtn;
/**
 *  亲子游
 */
@property (weak, nonatomic) IBOutlet UIButton *parentChildBtn;
/**
 *  8月特惠游
 */
@property (weak, nonatomic) IBOutlet UIButton *preferentialBtn;
/**
 *  三亚游
 */
@property (weak, nonatomic) IBOutlet UIButton *sanyaBtn;
@end
