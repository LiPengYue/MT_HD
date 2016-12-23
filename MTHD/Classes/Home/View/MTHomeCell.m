//
//  MTHomeCell.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/22.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeCell.h"
#import "MTHomeCellModel.h"

@interface MTHomeCell ()
//**背景图片*/
@property (nonatomic,strong) UIImageView *imageV_BG;
//**logo*/
@property (nonatomic,strong) UIImageView *imageV_Icon;
//**标题*/
@property (nonatomic,strong) UILabel *label_Title;
//**描述信息*/
@property (nonatomic,strong) UILabel *label_Desc;
//**现价*/
@property (nonatomic,strong) UILabel *label_Current;
//**原价*/
@property (nonatomic,strong) UILabel *label_List;
//**已售*/
@property (nonatomic,strong) UILabel *label_Number;
//**新单*/
@property (nonatomic,strong) UIImageView *imageV_DealNew;

@end

@implementation MTHomeCell{
    CGFloat _sbViewMagen;//基础的字控件间距属性
}


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        _sbViewMagen = 5;
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建UI界面
- (void)setupUI{
    [self setupSbView];
}
//MARK: 设置子控件
- (void)setupSbView {
    //MARK: 添加view
    [self.contentView addSubview:self.imageV_BG];//背景图片
    [self.contentView addSubview:self.imageV_Icon];//头像
    [self.contentView addSubview:self.label_Desc];//描述信息
    [self.contentView addSubview:self.label_Title];//标题
    [self.contentView addSubview:self.label_Current];//现价
    [self.contentView addSubview:self.label_List];//原价
    [self.contentView addSubview:self.label_Number];//已售

    //MARK: 约束
    [self.imageV_BG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.imageV_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(_sbViewMagen);
        make.right.offset(- _sbViewMagen);
        make.height.equalTo(180);
    }];
    [self.label_Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV_Icon.mas_bottom).offset(2 * _sbViewMagen);
        make.left.right.equalTo(self.imageV_Icon);
    }];
    [self.label_Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_Title.mas_bottom).offset(2 * _sbViewMagen);
        make.left.right.equalTo(self.label_Title);
    }];
    [self.label_Current mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label_Desc.mas_bottom).offset(_sbViewMagen);
        make.left.equalTo(self.label_Desc);
    }];
    [self.label_List mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label_Current.mas_right).offset(_sbViewMagen);
        make.centerY.equalTo(self.label_Current);
    }];
    [self.label_Number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-_sbViewMagen);
        make.top.equalTo(self.label_Current);
    }];
}


#pragma mark -赋值



#pragma mark -懒加载
//背景图片
- (UIImageView *)imageV_BG {
    if (!_imageV_BG) {
        
        UIImage *image = [UIImage imageNamed:@"bg_dealcell"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        _imageV_BG = [[UIImageView alloc]initWithImage:image];
//        _imageV_BG.hidden = true;
    }
    return _imageV_BG;
}
//头像
- (UIImageView *)imageV_Icon {
    if (!_imageV_Icon) {
        UIImage *image = [UIImage imageNamed:@"bg_dealcell"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        _imageV_Icon = [[UIImageView alloc]initWithImage: image];
    }
    return _imageV_Icon;
}
//描述信息
- (UILabel *)label_Desc {
    if (!_label_Desc) {
        _label_Desc = [[UILabel alloc]init];
        _label_Desc.text = @"林伟个是二货？ 额~是吧林伟个是二货？ 额~是吧林伟个是二货？ 额~是吧林伟个是二货？ 额~是吧林伟个是二货？ 额~是吧林伟个是二货？ 额~是吧";
        _label_Desc.numberOfLines = 2;
        _label_Desc.font = [UIFont systemFontOfSize:14];
        // 颜色
        _label_Desc.textColor = [UIColor darkGrayColor];
    }
    return _label_Desc;
}
//标题
- (UILabel *)label_Title {
    if (!_label_Title) {
        _label_Title = [[UILabel alloc]init];
        _label_Title.text = @"我叫label";
        _label_Title.font = [UIFont systemFontOfSize:17];
        _label_Title.textColor = [UIColor darkGrayColor];
    }
    return _label_Title;
}
//现价
- (UILabel *)label_Current {
    if (!_label_Current) {
        _label_Current = [[UILabel alloc]init];
        _label_Current.text = @"1993";
        _label_Current.textColor = [UIColor redColor];
        _label_Current.font = [UIFont systemFontOfSize:17];
    }
    return _label_Current;
}
//原价
- (UILabel *)label_List {
    if (!_label_List) {
        _label_List = [[UILabel alloc]init];
        _label_List.text = @"原价";
        _label_List.font = [UIFont systemFontOfSize:14];
        _label_List.textColor = [UIColor darkGrayColor];
    }
    return _label_List;
}
//已售
- (UILabel *)label_Number {
    if (!_label_Number) {
        _label_Number = [[UILabel alloc]init];
        _label_Number.text = @"已售";
        _label_Number.font = [UIFont systemFontOfSize:14];
        _label_Number.textColor = [UIColor darkGrayColor];
    }
    return _label_Number;
}

#pragma mark -数据源
- (void)setModel:(MTHomeCellModel *)model{
    //logo
    NSURL *iconURL = [[NSURL alloc]initWithString:model.image_url];
    [self.imageV_Icon sd_setImageWithURL:iconURL];
    
    //描述
    self.label_Desc.text = model.desc;
    
    //标题
    self.label_Title.text = model.title;
    
    //现价
    self.label_Current.text = model.currentPriceStr;
    
    //原价
    self.label_List.text = model.listPriceStr;
    
    //已售
    self.label_Number.text = [NSString stringWithFormat:@"已售%d",model.purchase_count];
}


@end
