//
//  NSDate+MTCompareDate.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/23.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>

//利用运行时添加属性

@interface NSDate (MTCompareDate)
+ (BOOL)isLateCurrentDateWithDate: (NSObject *)date_OBJ;
@end
