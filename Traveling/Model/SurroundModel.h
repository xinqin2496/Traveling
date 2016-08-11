//
//  SurroundModel.h
//  Traveling
//
//  Created by 郑文青 on 16/7/11.
//  Copyright © 2016年 zhengwenqing’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Retdata,Ticketdetail,Data,Display,Ticket,Pricelist;
@interface SurroundModel : NSObject

@property (nonatomic, copy) NSString *errMsg;

@property (nonatomic, assign) NSInteger errNum;

@property (nonatomic, strong) Retdata *retData;

@end
@interface Retdata : NSObject
//id - > ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) Ticketdetail *ticketDetail;

@end

@interface Ticketdetail : NSObject

@property (nonatomic, copy) NSString *changefreq;

@property (nonatomic, strong) Data *data;

@property (nonatomic, copy) NSString *loc;

@property (nonatomic, copy) NSString *lastmod;

@property (nonatomic, copy) NSString *priority;

@end

@interface Data : NSObject

@property (nonatomic, strong) Display *display;

@end

@interface Display : NSObject

@property (nonatomic, strong) Ticket *ticket;

@property (nonatomic, copy) NSString *subcate;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *category;

@end

@interface Ticket : NSObject
//description -> desc
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *spotScore;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *starGrade;

@property (nonatomic, copy) NSString *spotName;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *detailUrl;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *coordinates;

@property (nonatomic, strong) Pricelist *priceList;

@property (nonatomic, copy) NSString *spotID;

@end

@interface Pricelist : NSObject

@property (nonatomic, copy) NSString *ticketID;

@property (nonatomic, copy) NSString *normalPrice;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *priceType;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *ticketTitle;

@property (nonatomic, copy) NSString *bookUrl;

@end

