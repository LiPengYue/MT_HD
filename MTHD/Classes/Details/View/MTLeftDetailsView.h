//
//  MTLeftDetailsView.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    LeftDetailsButtonTpye_Buy = 0,//抢购
    LeftDetailsButtonTpye_Collect,//收藏
    LeftDetailsButtonTpye_Share,//分享
} LeftDetailsButtonTpye;


@class MTDetailsModel;
@interface MTLeftDetailsView : UIView
//接受model
@property (nonatomic,strong) MTDetailsModel *detailsModel;


//MARK: 点击Button返回按钮
@property (nonatomic,copy) void(^clckButtonBlcok)(LeftDetailsButtonTpye);


@end
