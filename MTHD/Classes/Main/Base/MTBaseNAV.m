//
//  MTBaseNAV.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTBaseNAV.h"
#import "UIImage+MTGategoryImage.h"
@interface MTBaseNAV ()

@end

@implementation MTBaseNAV
+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    UIImage * image = [UIImage imageNamed:@"bg_navigationBar_normal"];
    
    UIImage *image = [UIImage MT_imageWithName:@"bg_navigationBar_normal"];
    
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 搭建UI界面
- (void)setupUI{
 
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
