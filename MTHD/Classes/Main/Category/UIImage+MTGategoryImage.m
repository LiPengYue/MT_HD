//
//  UIImage+MTGetegoryImage.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "UIImage+MTGategoryImage.h"

@implementation UIImage (MTGategoryImage)

+ (UIImage *)MT_imageWithName: (NSString *)imageName {
    UIImage * image = [UIImage imageNamed:imageName];
    // 第一种方法
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    //第二种方法
//    CGFloat left = image.size.width * 0.5;
//    CGFloat right = image.size.width * 0.5;
//    CGFloat top = image.size.height * 0.5;
//    CGFloat bottom = image.size.height * 0.5;
//    [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    return image;
}

@end
