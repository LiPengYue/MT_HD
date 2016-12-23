//
//  NSString+MTStr.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/23.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "NSString+MTStr.h"

@implementation NSString (MTStr)

+ (NSString *)deleteLastZeroWithStr: (CGFloat)number{
    NSString *str = [NSString stringWithFormat:@"%.2lf",number];
    if ([str containsString:@".00"]) {
        return [str stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    
    return str;
}
@end
