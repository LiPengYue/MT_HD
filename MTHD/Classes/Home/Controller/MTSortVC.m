//
//  MTSortVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTSortVC.h"
#import "MTHomeViewModel.h"
#import "MTSortModel.h"
#import "MTButton.h"
@interface MTSortVC ()

@end

@implementation MTSortVC{
    CGFloat _width;
    CGFloat _height;
    CGFloat _margin;
    CGSize _buttonSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
#pragma mark 搭建UI界面
- (void)setupUI{
    
    
    _width = 100;
    _height = 30;
    _margin = 15;
    _buttonSize = CGSizeMake(_width, _height);
    
    NSArray<MTSortModel *> *sortArray = [MTHomeViewModel sharedHomeViewModel].sortArray;
    [self addButtonWithSortModelArray:sortArray];
    self.preferredContentSize = CGSizeMake(_width,(_height + _margin) * sortArray.count);
}

#pragma mark - 按钮的添加
- (void)addButtonWithSortModelArray: (NSArray <MTSortModel *> *)sortArray {
 
    
    [sortArray enumerateObjectsUsingBlock:^(MTSortModel * _Nonnull sortModel, NSUInteger idx, BOOL * _Nonnull stop) {
        MTButton *button = [[MTButton alloc]init];
        
        button.tag = idx + 1;
        // 设置标题
        [button setTitle:sortModel.label forState:UIControlStateNormal];
        button.buttonText = sortModel.label;
        // 设置文字颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        // 设置背景图片 的切图
        UIImage *normalImage = [UIImage imageNamed:@"btn_filter_normal"];
        normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width * 0.5 topCapHeight:normalImage.size.height * 0.5];
       
        UIImage *selectImage = [UIImage imageNamed:@"btn_filter_selected"];
        selectImage = [normalImage stretchableImageWithLeftCapWidth:selectImage.size.width * 0.5 topCapHeight:selectImage.size.height * 0.5];
        //设置背景图片
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        [button setBackgroundImage:selectImage forState:UIControlStateHighlighted];
        
        //添加
        [self.view addSubview:button];
        
        //设置Button的frame
        button.frame = CGRectMake(0, (_height + _margin) * idx, _width, _height);
        
        //添加点击事件
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

//MARK:  闭包
- (void)clickButton: (MTButton *)button {
    
    if (self.clickButtonBlock) {
        //因为tag值加了一个1； 不是从0 开始了
        self.clickButtonBlock(button.tag - 1,button.buttonText);
    }
}



- (void)loadData {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
