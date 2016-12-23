//
//  UIBarButtonItem+MTCategory.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MTCategory)
+ (UIBarButtonItem *)barButtonItemWithImageName: (NSString *)imageName andTarget: (id)target andAction: (SEL)action;
@end
