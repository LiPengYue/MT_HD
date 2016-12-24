//
//  MTLeftDetailsV_bottomView.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTLeftDetailsV_bottomView.h"
#import "MTDetailsModel.h"

@interface MTLeftDetailsV_bottomView ()

/** 随时退款 */
@property (nonatomic,strong) UIButton *button_AnyRefund;
/** 过期退款 */
@property (nonatomic,strong) UIButton *button_OverdueRefund;
/** 距离过期的时间 */
@property (nonatomic,strong) UIButton *button_OverdueTime;
/** 已售 */
@property (nonatomic,strong) UIButton *button_sellNumber;

@end




@implementation MTLeftDetailsV_bottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark - 数据源setter
- (void)setDetailsModel:(MTDetailsModel *)detailsModel {
    _detailsModel = detailsModel;
    //是否支持随时退款
    self.button_AnyRefund.selected = detailsModel.is_popularModel.is_reservation_required;
    //是否支持过期退款
    self.button_OverdueRefund.selected = detailsModel.is_popularModel.is_refundable;
    //是否过期
    
}

#pragma mark - 搭建UI界面
- (void)setupUI {
    [self addSubview:self.button_AnyRefund];//随时退款
    [self addSubview:self.button_OverdueRefund];//过期退
    [self addSubview:self.button_OverdueTime];//距离过期的时间
    [self addSubview:self.button_sellNumber];//已售
    
    
    [self.button_AnyRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(self).dividedBy(2);
        make.height.equalTo(self).dividedBy(2);
    }];
    [self.button_OverdueRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.height.top.equalTo(self.button_AnyRefund);
    }];
    [self.button_OverdueTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button_AnyRefund.mas_bottom);
        make.left.right.height.equalTo(self.button_AnyRefund);
    }];
    [self.button_sellNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.button_OverdueTime);
        make.left.equalTo(self.button_OverdueTime.mas_right);
    }];
}

#pragma mark - 懒加载控件
//随时退款
- (UIButton *)button_AnyRefund {
    if (!_button_AnyRefund) {
        _button_AnyRefund = [self buttonWithTitle:@"支持随时退款"];
    }
    return _button_AnyRefund;
}
//过期退款
- (UIButton *)button_OverdueRefund {
    if (!_button_OverdueRefund) {
        _button_OverdueRefund = [self buttonWithTitle:@"支持过期退款"];
    }
    return _button_OverdueRefund;
}
//距离过期的时间
- (UIButton *)button_OverdueTime {
    if (!_button_OverdueTime) {
        _button_OverdueTime = [self buttonWithTitle:@"过期时间"];
    }
    return _button_OverdueTime;
}
//已售
- (UIButton *)button_sellNumber {
    if (!_button_sellNumber) {
        _button_sellNumber = [self buttonWithTitle:@"已售"];
    }
    return _button_sellNumber;
}
#pragma mark - 生成Button
- (UIButton *)buttonWithTitle: (NSString *)str{
    
    UIButton *button = [[UIButton alloc]init];
    
    //设置图片
    [button setImage:[UIImage imageNamed:@"icon_order_unrefundable"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_order_refundable"] forState:UIControlStateSelected];
    
    //设置文字
    [button setTitle:str forState:UIControlStateNormal];
    
    //设置字体
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //设置title的位置
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    //title颜色
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    //用户交互
    button.userInteractionEnabled = false;
    
    //设置对其方法
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return button;
}



@end
