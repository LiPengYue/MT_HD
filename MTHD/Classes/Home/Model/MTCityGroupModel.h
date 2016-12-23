//
//  MTCityGroupModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/20.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroupModel : NSObject


/** 标题*/
@property (nonatomic, copy) NSString *title;

/** 城市数据*/
@property (nonatomic, strong) NSArray *cities;
@end
