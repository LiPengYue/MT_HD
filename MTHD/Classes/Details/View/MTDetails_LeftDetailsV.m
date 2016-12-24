//
//  MTDetails_LeftDetailsV.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDetails_LeftDetailsV.h"
//导航的View
#import "MTDetails_LeftNAVView.h"
#import "MTLeftDetailsView.h"


@interface MTDetails_LeftDetailsV ()
//上面的导航View
@property (nonatomic,strong) MTDetails_LeftNAVView *leftNAVView;

//MAKR: 中间的详情view 及其用到的属性
@property (nonatomic,strong) MTLeftDetailsView *detailsView;

// 自定义底部view
@end

@implementation MTDetails_LeftDetailsV



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark - 搭建UI界面
- (void)setupUI {
    //1. 上面的导航的view
    [self setupDetails_LeftNAVView];
    //2. 下边的view
    [self setupDetailsView];
    
    
}

#pragma mark - 导航的View
- (MTDetails_LeftNAVView *)leftNAVView {
    if (!_leftNAVView) {
        _leftNAVView = [[MTDetails_LeftNAVView alloc]init];
    }
    return _leftNAVView;
}
- (void)setupDetails_LeftNAVView{
    [self addSubview:self.leftNAVView];
    [self.leftNAVView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(64);
    }];
}


#pragma mark - 中间的详情view
- (MTLeftDetailsView *)detailsView {
    if (!_detailsView) {
        _detailsView = [[MTLeftDetailsView alloc]init];
    }
//    _detailsView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    return _detailsView;
}
//设置布局和子控件
- (void)setupDetailsView {
    [self addSubview:self.detailsView];
    [self.detailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftNAVView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
}


- (void)setDetailsModel:(MTDetailsModel *)detailsModel {
    _detailsModel = detailsModel;
    //给子空间的属性赋值
    self.detailsView.detailsModel = detailsModel;
}


@end
