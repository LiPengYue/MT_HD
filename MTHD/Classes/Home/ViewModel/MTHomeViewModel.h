//
//  MTHomeViewModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>
//home plist model
@class MTCityModel;
@class MTSortModel;
@class MTDistrictModel;

//home net model
@class MTHomeCellModel;
@interface MTHomeViewModel : NSObject



//MARK: 单利方法
+ (instancetype)sharedHomeViewModel;

//MARK: 首页 plist
@property (nonatomic,strong) NSArray<MTSortModel *> *sortArray;//排序

- (void)searchCityWithStr: (NSString *)searchStr andResultBlock: (void(^)(NSInteger count,NSArray<MTCityModel *> *searchCityArray))resultBlock;

- (void)cityWithCityName: (NSString *)cityName andDistictName: (NSString *)distictName andCityResultBlock: (void(^)(MTDistrictModel * model)) resultBlock;

- (void)cityWithCityName: (NSString *)cityName andCityResultBlock: (void(^)(MTCityModel * model)) resultBlock;

//MARK: 首页网络
//- (void)homeNetDataWithBolck: (void(^)(BOOL isSucceed,NSArray< MTHomeCellModel *>* modelArray))modelArrayBlock;

/**
 * isSucceed: 是否返回数据成功
 * modelArrayBlock: 转成model的数据
 */
//- (void)loadHomeNetDataWithCityName: (NSString *)cityName andModelArrayBlock: (void(^)(BOOL isSucceed,NSArray< MTHomeCellModel *>* modelArray))modelArrayBlock ;
- (void)loadHomeNetDataWithCityName: (NSMutableDictionary *)params andModelArrayBlock: (void(^)(BOOL isSucceed,NSArray< MTHomeCellModel *>* modelArray))modelArrayBlock;
@end
