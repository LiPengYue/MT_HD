//
//  UIBarButtonItem+MTCategory.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "UIBarButtonItem+MTCategory.h"

@implementation UIBarButtonItem (MTCategory)

+ (UIBarButtonItem *)barButtonItemWithImageName: (NSString *)imageName andTarget: (id)target andAction: (SEL)action{
    
    UIButton * button = [[UIButton alloc]init];
    //图片
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    //button 的点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //item
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}


@end
