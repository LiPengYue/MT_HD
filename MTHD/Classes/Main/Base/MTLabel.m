//
//  MTLabel.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTLabel.h"

@implementation MTLabel
+ (MTLabel *)labelWithStr: (NSString *)str{
    MTLabel * label = [[MTLabel alloc]init];
    label.text = str;
    [label sizeToFit];
    [label setNeedsDisplayInRect:label.frame];
    return label;
}

- (void)drawRect:(CGRect)rect {
    //先super
    [super drawTextInRect:rect];
    //获取当前上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //获取开始点
    CGContextMoveToPoint(ref, 0, self.frame.size.height * 0.5);
    //获取最后的点
    CGContextAddLineToPoint(ref, self.frame.size.width,self.frame.size.height * 0.5);
    //开画
    CGContextStrokePath(ref);
    
    
}

@end
