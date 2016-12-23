//
//  MTDropdownView.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/19.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDropdownView.h"
#import "MTCategoryModel.h"
#import "MTDistrictModel.h"

@interface MTDropdownView ()
<//代理协议 数据源协议
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
//被选中的cell 的模型
//@property (nonatomic,strong) MTCategoryModel *selectModel;

//判断为那个 控制器服务
@property (nonatomic,assign) BOOL isCategory;
@end

static NSString * CELLID = @"CELLID";
@implementation MTDropdownView{
    MTCategoryModel *_selectCategoryModel;
    MTDistrictModel *_selectDistrictModel;
}

//有两个tableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI界面的搭建
- (void)setupUI{

//    self.isCategory = self.categoryModelArray.count > 0;
    
    //左边的tableView
    [self setupLeftTableView];
    
    //右边的tableView
    [self setupRightTableView];
}

#pragma mark - 左边的tableView 
- (void)setupLeftTableView {
    //1.懒加载控件
    [self addSubview:self.leftTableView];
    
    //2.设置约束
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(self).dividedBy(2);
    }];
    
    //MARK:-- 默认左边的tableView 选中 第一行
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self tableView:self.leftTableView didSelectRowAtIndexPath:indexPath];
    //3.设置代理与数据源
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
//    //4.注册
//    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLID];
    
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor redColor];
    
}

//懒加载
-(UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _leftTableView;
}

#pragma mark - 右边的tableView
- (void)setupRightTableView {
    //1.创建右边的
    [self addSubview:self.rightTableView];
    //2.设置约束
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.equalTo(self).dividedBy(2);//为self的宽的 1/2；
    }];
    //3.设置数据源于代理
    self.rightTableView.dataSource = self;
    self.rightTableView.delegate = self;
    //取消线
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//MARK: 懒加载
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]init];
    }
    return _rightTableView;
}


#pragma mark - 数据源 代理  方法
//MARK: 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {//等于左边的处理
        return [self leftTabelViewNumberOfRowsInSection];
    }
    //右边的处理
    return [self rightTabelViewNumberOfRowsInSection];
}

- (NSInteger)leftTabelViewNumberOfRowsInSection{
    //三元表达式 如果要是categoryModelArray有值 那么返回这个的count 否则就。。。
    NSInteger count = self.categoryModelArray.count ?
    self.categoryModelArray.count :
    self.districtModelArray.count;
    return count;

}
- (NSInteger)rightTabelViewNumberOfRowsInSection{
    
    return self.isCategory ? self.selectCategoryModel.subcategories.count : self.selectDistrictModel.subdistricts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
   
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    if (tableView == _leftTableView){//左边的cell 的设置
        if (self.categoryModelArray){//表示的是分类的cell
            [self setLeftTableView_CategoryWithCell:cell andModel:self.categoryModelArray[indexPath.row]];
        }else{
            [self setLeftTableView_DistrictWithCell:cell andModel:self.districtModelArray[indexPath.row]];
        }
    }

    
    if (tableView == _rightTableView) {//右边的cell 图片的设置
        
        NSArray *subModelArray = [[NSArray alloc]init];
        subModelArray = self.isCategory ?
        self.selectCategoryModel.subcategories :
        self.selectDistrictModel.subdistricts;
        [self setRightCell:cell andTitle:subModelArray[indexPath.row]];
    }
    return cell;
}

//MARK: 左边的cell 的处理
// 分类的cell
- (void)setLeftTableView_CategoryWithCell: (UITableViewCell *)cell andModel: (MTCategoryModel *)model{
    //设置cell 的样式
    [self setLeftCell:cell andCellAccessoryTypeIsNone:model.subcategories.count];
    //设置图片
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.imageView.highlightedImage = [UIImage imageNamed:model.highlighted_icon];
    //设置text
    cell.textLabel.text = model.name;
}
//如果是 地区的cell
- (void)setLeftTableView_DistrictWithCell: (UITableViewCell *)cell andModel: (MTDistrictModel *)model {
    [self setLeftCell:cell andCellAccessoryTypeIsNone:model.subdistricts.count];
    cell.textLabel.text = model.name;
}
//共同的cell 的设置
- (void)setLeftCell: (UITableViewCell *)cell andCellAccessoryTypeIsNone: (BOOL)isNone{
    //1.cell 背景图片的处理
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
    [cell setBackgroundView:imageView];
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    
    //如果没有右边的cell 的数据 那么就没有箭头
    if (isNone){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
}


//MARK: 右边的cell 的处理
- (void)setRightCell: (UITableViewCell *)cell andTitle: (NSString *)title{
    //1.cell 背景图片的处理
    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    cell.textLabel.text = title;
    
}

//MARK: 代理方法的实现
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.leftTableView == tableView) {
        //给选中的model赋值 判断是否有子的数组 详情 有就发送通知
        [self handleClickLeftCellWithIndexPath:indexPath];
        return;
    }
    //2. 表示点击的是右边的cell 发送通知
    [self handleClickRightCellWithIndexPath:indexPath];
}

//点击左边的cell
- (void)handleClickLeftCellWithIndexPath: (NSIndexPath *)indexPath {
    //右边的刷新界面 在setter方法里面
    //判断是否有子的cell 如果有就赋值 没有就发送通知
    
    //1.分类的子详情有值
    if (self.categoryModelArray[indexPath.row].subcategories > 0){
        //0.1说明了是分类 并且有值 那么直接赋值
        self.selectCategoryModel = self.categoryModelArray[indexPath.row];
    }else if (self.categoryModelArray.count > 0){
        //0.2说明了是分类 但是没有值 所以发送通知 因为要改变icon 所以要把model传过去
        [[NSNotificationCenter defaultCenter] postNotificationName:kMTCategoryDidChangeNotifacation object:nil userInfo:@{kMTCategoryDidChangeNotifacation : self.categoryModelArray[indexPath.row]}];
        return;
    }
    
    //2.表示的是 地区的子详情有值
    if (self.districtModelArray[indexPath.row].subdistricts.count > 0){
        if (self.isCategory) {
            self.selectCategoryModel = self.categoryModelArray[indexPath.row];
        }else{
            self.selectDistrictModel = self.districtModelArray[indexPath.row];
        }
    }else if(self.districtModelArray.count > 0){
        // 说明了地区是地区 但是没有详情 发送通知  改变item的title
        [[NSNotificationCenter defaultCenter] postNotificationName:kMTDistrictDidChangeNotifacation object:nil userInfo:@{kMTDistrictDidChangeNotifacation : self.districtModelArray[indexPath.row]}];
    }
}
//点击的是右边的cell
- (void)handleClickRightCellWithIndexPath: (NSIndexPath *)indexPath {
    //1.判断是否地区 还是分类
    if (self.categoryModelArray.count){//表示的是 分类的cell
        //1.1 传 分类的model 和其选中的子model
        NSDictionary *userInfo = @{
                                   kMTCategoryDidChangeNotifacation:
                                       self.selectCategoryModel,
                                   kMTCategoryDidChangeNotifacation_CellTitle:
                                       self.selectCategoryModel.subcategories[indexPath.row]
                                   };
        //1.1 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kMTCategoryDidChangeNotifacation object:nil userInfo:userInfo];
        return;
    }
    
    //2. 说明是 地区的cell
    NSDictionary *userInfo = @{
                               kMTDistrictDidChangeNotifacation:
                                   self.selectDistrictModel,
                               kMTDistrictDidChangeNotifacation_CellTitel:
                                   self.selectDistrictModel.subdistricts[indexPath.row]
                               };
    //2.1 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName: kMTDistrictDidChangeNotifacation object:nil userInfo:userInfo];
}


#pragma mark - 懒加载 选中的model
//  1.selectCategoryModel
- (MTCategoryModel *)selectCategoryModel {
    if (!_selectCategoryModel) {
        _selectCategoryModel = [[MTCategoryModel alloc]init];
        _selectCategoryModel = self.categoryModelArray[0];//一开始就有第0个元素
    }
    return _selectCategoryModel;
}
- (void)setSelectCategoryModel:(MTCategoryModel *)selectCategoryModel{
    _selectCategoryModel = selectCategoryModel;
    [self.rightTableView reloadData];
}

//2. MTDistrictModel
- (MTDistrictModel *)selectDistrictModel {
    if (!_selectDistrictModel) {
        _selectDistrictModel = [[MTDistrictModel alloc]init];
    }
    return _selectDistrictModel;
}

- (void)setSelectDistrictModel: (MTDistrictModel *)selectDistrictModel {
    _selectDistrictModel = selectDistrictModel;
    [self.rightTableView reloadData];//刷新UI界面
}



-(void)setCategoryModelArray:(NSArray<MTCategoryModel *> *)categoryModelArray{
    _categoryModelArray = categoryModelArray;
    self.isCategory = true;
}
@end
