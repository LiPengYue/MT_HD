//
//  MTHomeNACView.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeNACView : UIView
//对外的接口 (用于点击事件)
@property (nonatomic,copy) void (^clickButtonBlock)();

//提供label修改值的方法
- (void)changeValueWithTitle: (NSString *)title andSubTitle: (NSString *)subTitle;
//提供修改icon的方法
- (void)changeIconWithNormalStr: (NSString *)normalStr andHighlightedStr: (NSString *)highlightedStr;

@end
