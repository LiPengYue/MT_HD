//
//  MTDetails_LeftNAVView.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDetails_LeftNAVView.h"

@interface MTDetails_LeftNAVView ()

@property (nonatomic,strong) UIImageView *image_bg;//背景图片
@property (nonatomic,strong) UILabel *label_title;//标题
@property (nonatomic,strong) UIButton *backButton;//返回按钮

@end

@implementation MTDetails_LeftNAVView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - 搭建UI界面
- (void)setupUI{
    [self setupImage_bg];
    [self setupLabel_title];
    [self setupBackButton];
}

#pragma mark - 懒加载——控件
- (UIImageView *)image_bg {
    if (!_image_bg){
        UIImage *image = [UIImage imageNamed:@"bg_navigationBar_normal"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        _image_bg = [[UIImageView alloc]initWithImage:image];
    }
    return _image_bg;
}
- (void)setupImage_bg {
    [self addSubview:self.image_bg];
    [_image_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self).offset(20);
    }];
}

- (UILabel *)label_title {
    if (!_label_title) {
        _label_title = [[UILabel alloc]init];
        _label_title.text = @"团购没有了！";
        _label_title.font = [UIFont systemFontOfSize:19];
        _label_title.textColor = [UIColor blueColor];
        _label_title.textAlignment = NSTextAlignmentCenter;
    }
    return _label_title;
}
- (void)setupLabel_title {
    [self addSubview:self.label_title];
    [self.label_title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.bottom.left.right.equalTo(self);
    }];
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    }
    return _backButton;
}
- (void)setupBackButton {
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.bottom.equalTo(self.label_title);
    }];
}
@end
