//
//  MTDetails_Is_popular.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDetails_Is_popular : NSObject
/** 是否需要预约，0：不是，1：是*/
@property (nonatomic, assign) int is_reservation_required;
/** 是否支持随时退款，0：不是，1：是*/
@property (nonatomic, assign) int is_refundable;

@end
