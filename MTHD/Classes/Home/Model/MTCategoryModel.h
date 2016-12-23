//
//  MTCategoryModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/19.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCategoryModel : NSObject
/** 名称*/
@property (nonatomic, copy) NSString *name;
/** 图标*/
@property (nonatomic, copy) NSString *icon;
/** 高亮图标*/
@property (nonatomic, copy) NSString *highlighted_icon;
/** 小图标*/
@property (nonatomic, copy) NSString *small_icon;
/** 高亮小图标*/
@property (nonatomic, copy) NSString *small_highlighted_icon;
/** 地图图标*/
@property (nonatomic, copy) NSString *map_icon;
/** 子分类数据*/
@property (nonatomic, strong) NSArray *subcategories;
@end
