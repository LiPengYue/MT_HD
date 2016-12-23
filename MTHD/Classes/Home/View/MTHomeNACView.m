//
//  MTHomeNACView.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeNACView.h"


@interface MTHomeNACView ()
@property (nonatomic,strong) UIView *lienView;
@property (nonatomic,strong) UILabel *mainHeading;
@property (nonatomic,strong) UILabel *subheading;
@property (nonatomic,strong) UIButton *itemButton;
@end


@implementation MTHomeNACView{
    CGFloat _homeNACVW;
    CGFloat _homeNACVH;
    

    CGFloat _headingH;
    CGFloat _headingW;

    CGFloat _headingX;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建UI界面
- (void)setupUI{
    
    self.frame = CGRectMake(0, 0, 160, 40);
//    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    _homeNACVW = self.frame.size.width;
    _homeNACVH = self.frame.size.height;
    _headingH = 20;
    //MARK: ------------- 这里减去了一个20 为了防止字挡住 图片
    _headingW = _homeNACVW - 20;
    _headingX = 20;
    
    [self addSubview:self.lienView];//加线
    [self addSubview:self.subheading];//加子标题
    [self addSubview:self.mainHeading];//加主标题
    [self addSubview:self.itemButton]; //加覆盖的Button
}


#pragma mark - 懒加载
- (UIView *)lienView{
    if (!_lienView) {
        _lienView = [[UIView alloc]init];
        _lienView.frame = CGRectMake(5, 5, 1.0 / [UIScreen mainScreen].scale, _homeNACVH - 10);
        _lienView.backgroundColor = [UIColor grayColor];
    }
    return _lienView;
}

- (UILabel *)mainHeading{
    if (!_mainHeading) {
        _mainHeading = [[UILabel alloc]init];
        _mainHeading.frame = CGRectMake(_headingX, 0, _headingW, _headingH);
        _mainHeading.text = @"主标题";
        _mainHeading.font = [UIFont systemFontOfSize:14];
        _mainHeading.textAlignment = NSTextAlignmentCenter;
        
    }
    return _mainHeading;
}

- (UILabel *)subheading{
    if (!_subheading) {
        _subheading = [[UILabel alloc]init];
        _subheading.frame = CGRectMake(_headingX, _headingH, _headingW, _headingH);
        _subheading.font = [UIFont systemFontOfSize:17];
        _subheading.text = @"副标题";
        _subheading.textAlignment = NSTextAlignmentCenter;
        
    }
    return _subheading;
}

- (UIButton *)itemButton{
    if (!_itemButton) {
        _itemButton = [[UIButton alloc]init];
        _itemButton.frame = CGRectMake(0, 0, _homeNACVW, _homeNACVH);
        [_itemButton setImage:[UIImage imageNamed:@"icon_district"] forState:UIControlStateNormal];
        [_itemButton setImage:[UIImage imageNamed:@"icon_district_highlighted"] forState:UIControlStateHighlighted];
        
        //设置button 的内容的对其方法
        [_itemButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        //调整Button的image 的位置
        _itemButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        //添加点击事件
        [_itemButton addTarget:self action:@selector(clickItemButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemButton;
}

#pragma mark - 点击事件的处理
- (void) clickItemButton {
    if (self.clickButtonBlock){
        _clickButtonBlock();
    }
}

#pragma mark - 在外面设置内部的属性的方法

//提供label修改值的方法
- (void)changeValueWithTitle: (NSString *)title andSubTitle: (NSString *)subTitle{
    if (subTitle.length > 0) {//说明有值
        self.subheading.text = subTitle;
        self.mainHeading.frame = CGRectMake(_headingX, 0, _headingW, _headingH);
    }else{//说明没有值
        self.subheading.text = subTitle;
        self.mainHeading.frame = CGRectMake(_headingX, 0, _headingW, _headingH * 2);
    }
     self.mainHeading.text = title;
}


//提供修改icon的方法
- (void)changeIconWithNormalStr: (NSString *)normalStr andHighlightedStr: (NSString *)highlightedStr{
    [self.itemButton setImage:[UIImage imageNamed:normalStr] forState:UIControlStateNormal];
    [self.itemButton setImage:[UIImage imageNamed:highlightedStr] forState:UIControlStateHighlighted];
}




@end
