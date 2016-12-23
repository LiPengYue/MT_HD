//
//  MTCityModel.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTCityModel.h"
#import "MTDistrictModel.h"


@implementation MTCityModel

- (NSString *)description {
    return [self yy_modelDescription];
}


//因为字典数组里面又有字典数组  那么就要告诉yymodel 这个属性是什么类型
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"districts" : [MTDistrictModel class]};
}



@end
