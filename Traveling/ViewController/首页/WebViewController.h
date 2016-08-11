//
//  WebViewController.h
//  Traveling
//
//  Created by 郑文青 on 16/8/1.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import "ScrollNaviBarController.h"

@interface WebViewController : ScrollNaviBarController
/** 接受url字符串 */
@property (nonatomic,copy)NSString *backURLStr;
@end
