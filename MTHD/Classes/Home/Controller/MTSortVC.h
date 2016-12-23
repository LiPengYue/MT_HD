//
//  MTSortVC.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSortVC : UIViewController

@property (nonatomic,copy)void(^clickButtonBlock)(NSInteger buttonTag, NSString *buttonText);

@end
