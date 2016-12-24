//
//  MTLeftDetailsView.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTLeftDetailsView.h"
#import "MTLabel.h"
#import "MTLeftDetailsV_bottomView.h"
#import "MTDetailsModel.h"

@interface MTLeftDetailsView ()

// logo
@property (nonatomic, strong) UIImageView *imageV_Logo;
/**标题*/
@property (nonatomic, strong) UILabel *label_Title;
/**描述*/
@property (nonatomic, strong) UILabel *label_Desc;
/**现价*/
@property (nonatomic, strong) UILabel *label_Current;
/**原价*/
@property (nonatomic, strong) MTLabel *label_List;
/**立即抢购*/
@property (nonatomic, strong) UIButton *button_Buy;
/**收藏*/
@property (nonatomic, strong) UIButton *button_Collect;
/**分享*/
@property (nonatomic, strong) UIButton *button_Share;
/**底部的view*/
@property (nonatomic, strong) MTLeftDetailsV_bottomView *bottomView;

/**收藏状态*/
@property (nonatomic, assign) BOOL collectSelected;

@end
@implementation MTLeftDetailsView

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
    //MARK: 赋值
    //logo
    [self.imageV_Logo sd_setImageWithURL:[NSURL URLWithString:detailsModel.image_url]];
    //标题
    self.label_Title.text = detailsModel.title;
    //详情
    self.label_Desc.text = detailsModel.desc;
    //现价
    self.label_Current.text = detailsModel.currentPriceStr;
    //原价
    self.label_Title.text = detailsModel.listPriceStr;
    //底部的View
    self.bottomView.detailsModel = detailsModel;   
}

#pragma mark - 添加控件
- (void)setupUI {
    [self addSubview:self.imageV_Logo];//logo
    [self addSubview:self.label_Title];//标题
    [self addSubview:self.label_Desc];//详情
    [self addSubview:self.label_Current];//现价
    [self addSubview:self.label_List];//原价
    [self addSubview:self.button_Buy];//购买
    [self addSubview:self.button_Collect];//收藏
    [self addSubview:self.button_Share];//分享
    [self addSubview:self.bottomView];//底部的view
    
    //添加约束
    [self.imageV_Logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.mas_top);
        make.right.offset(-10);
        make.height.offset(185);
    }];
    //标题
    [self.label_Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.left.offset(15);
        make.top.equalTo(self.imageV_Logo.mas_bottom).offset(10);
    }];
    //描述
    [self.label_Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.label_Title);
        make.top.equalTo(self.label_Title.mas_bottom).offset(15);
    }];
    //现价
    [self.label_Current mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_Desc);
        make.top.equalTo(self.label_Desc.mas_bottom).offset(20);
    }];
    //原价
    [self.label_List mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_Current.mas_right).offset(20);
        make.bottom.equalTo(self.label_Current);
    }];
    //购买
    [self.button_Buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_Current);
        make.top.equalTo(self.label_Current.mas_bottom).offset(20);
        make.size.equalTo(CGSizeMake(120, 40));
    }];
    //收藏
    [self.button_Collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button_Buy.mas_right).offset(40);
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.button_Buy);
    }];
    //分享
    [self.button_Share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.button_Collect.mas_right).offset(40);
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.button_Buy);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.equalTo(-15);
        make.top.equalTo(self.button_Buy.mas_bottom).offset(30);
        make.height.offset(80);
    }];
}


#pragma mark - 懒加载
//图片
- (UIImageView *)imageV_Logo {
    if (!_imageV_Logo) {
        _imageV_Logo = [[UIImageView alloc]init];
        _imageV_Logo.contentMode = UIViewContentModeScaleAspectFill;
        _imageV_Logo.clipsToBounds = true;
        _imageV_Logo.image = [UIImage imageNamed:@"placeholder_deal"];
    }
    return _imageV_Logo;
}
//标题
- (UILabel *) label_Title {
    if (!_label_Title) {
        _label_Title = [[UILabel alloc]init];
        _label_Title.text = @"我是谁，不知道";
        _label_Title.numberOfLines = 0;
        _label_Title.font = [UIFont systemFontOfSize:17];
    }
    return  _label_Title;
}
//描述
- (UILabel *)label_Desc {
    if (!_label_Desc) {
        _label_Desc = [[UILabel alloc]init];
        _label_Desc.text = @"我是谁dddddddddddddddddddddddddddddddddddddddddddddddddd";
        _label_Desc.font = [UIFont systemFontOfSize:14];
        _label_Desc.numberOfLines = 0;
        _label_Desc.textColor = [UIColor darkGrayColor];
    }
    return _label_Desc;
}
//现价
- (UILabel *)label_Current {
    if (!_label_Current) {
        _label_Current = [[UILabel alloc]init];
        _label_Current.text = @"别说骚话";
        _label_Current.textColor = [UIColor redColor];
        _label_Current.font = [UIFont systemFontOfSize:17];
    }
    return _label_Current;
}
//原价
- (MTLabel *)label_List {
    if (!_label_List) {
        _label_List = [MTLabel labelWithStr:@"哈哈"];
        _label_List.font = [UIFont systemFontOfSize:14];
        _label_List.textColor = [UIColor darkGrayColor];
    }
    return _label_List;
}




//MARK: Button的处理
//购买
- (UIButton *)button_Buy {
    if (!_button_Buy) {
        _button_Buy = [[UIButton alloc]init];
        [_button_Buy setBackgroundImage:[UIImage imageNamed:@"bg_deal_purchaseButton"] forState:UIControlStateNormal];
        [_button_Buy setBackgroundImage:[UIImage imageNamed:@"bg_deal_purchaseButton_highlighted"] forState:UIControlStateHighlighted];
        
        [_button_Buy addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_button_Buy setTitle:@"立即抢购" forState:UIControlStateNormal];
        [_button_Buy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置tag值
        _button_Buy.tag = LeftDetailsButtonTpye_Buy;
    }
    return _button_Buy;
}
//收藏
- (UIButton *)button_Collect {
    if (!_button_Collect) {
        _button_Collect = [[UIButton alloc]init];
        [_button_Collect setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
        [_button_Collect setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateSelected];
        [_button_Collect addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
       
        //设置tag值
        _button_Collect.tag = LeftDetailsButtonTpye_Collect;
    }
    return _button_Collect;
}
//分享
- (UIButton *)button_Share {
    if (!_button_Share) {
        _button_Share = [[UIButton alloc]init];
        [_button_Share setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_button_Share setImage:[UIImage imageNamed:@"icon_share_highlighted"] forState:UIControlStateHighlighted];
        [_button_Share addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        //设置tag值
        _button_Share.tag = LeftDetailsButtonTpye_Share;
    }
    return _button_Share;
}

#pragma mark - 点击事件
// 分享事件
- (void)clickButton: (UIButton *)button{
   
    switch (button.tag) {
        case LeftDetailsButtonTpye_Buy:
             NSLog(@"购买")
            if (self.clckButtonBlcok) {
                self.clckButtonBlcok(button.tag);
            }
            break;
        case LeftDetailsButtonTpye_Collect:
            self.button_Collect.selected = !self.collectSelected;
            self.collectSelected = self.button_Collect.isSelected;
             NSLog(@"收藏")
            if (self.clckButtonBlcok) {
                self.clckButtonBlcok(button.tag);
            }
            break;
        case LeftDetailsButtonTpye_Share:
             NSLog(@"分享")
            if (self.clckButtonBlcok) {
                self.clckButtonBlcok(button.tag);
            }
            break;
        default:
            break;
    }
    if (self.clckButtonBlcok) {
        self.clckButtonBlcok(button.tag);
    }
}


#pragma mark - 底部的view
//MARK: 懒加载
- (MTLeftDetailsV_bottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[MTLeftDetailsV_bottomView alloc]init];
    }
    return _bottomView;
}




@end
