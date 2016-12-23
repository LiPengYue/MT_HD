//
//  MTConst.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/20.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


@interface MTConst : NSObject
// extern : 引用本类或者其他类中使用


// 城市通知
extern NSString *const kMTCityDidChangeNotifacation;
extern NSString *const kMTCityDidChangeNotifacation_CellTitel;
extern NSString *const kMTDistrictDidChangeNotifacation;//地区将要改变
extern NSString *const kMTDistrictDidChangeNotifacation_CellTitel;//title；

// 分类通知
extern NSString *const kMTCategoryDidChangeNotifacation;
extern NSString *const kMTCategoryDidChangeNotifacation_CellTitle;
// 区域通知


// 排序通知


// 收藏改变的通知



@end
