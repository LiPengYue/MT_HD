//
//  NSDate+MTCompareDate.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/23.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "NSDate+MTCompareDate.h"

@implementation NSDate (MTCompareDate)

+ (BOOL)isLateCurrentDateWithDate: (NSObject *)date_OBJ{
    //1、创建时间
    NSDate *compareDate = [[NSDate alloc]init];
    
    
    if ([date_OBJ isKindOfClass:[NSString class]]){//是字符串
        NSString *dateStr = (NSString *)date_OBJ;
        //1. 把字符串 转化成事件对象
            //1.0时间格式化对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
            //2.0时间格式化
        compareDate = [dateFormatter dateFromString:dateStr];
    }else if ([date_OBJ isKindOfClass: [NSDate class]]){
        compareDate = (NSDate *)date_OBJ;
    }else{
        return nil;
    }
    
    //2、表示事件格式转化完毕 比较时间
        //1.0 获取当前时间
    NSDate *currentDate = [[NSDate alloc]init];
        //2.0 比较时间
        //NSOrderedAscending 升序
        // NSOrderedSame 相同
        // NSOrderedDescending 降序
    //升序表示比现在事件要晚
   BOOL isTrue = [currentDate compare:compareDate] == NSOrderedAscending;
    
    return isTrue;
}
@end
