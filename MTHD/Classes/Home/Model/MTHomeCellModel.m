//
//  MTHomeCellModel.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/22.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeCellModel.h"

@implementation MTHomeCellModel
//1.description
- (NSString *)description {
    return [self yy_modelDescription];
}

//2.返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}


@end
