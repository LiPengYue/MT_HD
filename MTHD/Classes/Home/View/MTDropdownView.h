//
//  MTDropdownView.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/19.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCategoryModel;
@class MTDistrictModel;

@interface MTDropdownView : UIView
@property (nonatomic,strong) NSArray <MTCategoryModel *> *categoryModelArray;
@property (nonatomic,strong) NSArray <MTDistrictModel *> *districtModelArray;
@end
