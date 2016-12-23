//
//  MTCityModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTDistrictModel;
@interface MTCityModel : NSObject

/** 名字*/
@property (nonatomic, copy) NSString *name;

/** 拼音全称*/
@property (nonatomic, copy) NSString *pinYin;

/** 拼音缩写*/
@property (nonatomic, copy) NSString *pinYinHead;

/** 子数据(区县街道)--> districts 对应的也是数据模型*/
@property (nonatomic, strong) NSArray <MTDistrictModel *> *districts;
@end
