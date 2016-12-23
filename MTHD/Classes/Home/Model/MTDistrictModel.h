//
//  MTDistrictModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/20.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDistrictModel : NSObject

/** 名字*/
@property (nonatomic, copy) NSString *name;

/** 子区域数据*/
@property (nonatomic, strong) NSArray <NSString *> *subdistricts;
@end
