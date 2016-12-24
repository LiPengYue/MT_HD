//
//  MTDetailsViewModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTDetailsModel;
@interface MTDetailsViewModel : NSObject
//加载数据类;
- (void)loadDetailsDataWithParames: (NSMutableDictionary *)parames LoadDataBlock: (void(^)(NSArray <MTDetailsModel *>*dataArray,NSError *error))loadDataBlock;
@end
