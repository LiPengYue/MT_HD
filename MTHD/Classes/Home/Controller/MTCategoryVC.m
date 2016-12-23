//
//  MTCategoryVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/19.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTCategoryVC.h"
#import "MTDropdownView.h"//基类左右各一个tableView
#import "MTCategoryModel.h"


@interface MTCategoryVC ()
//详情数据的展示view
@property (strong,nonatomic) MTDropdownView *dropdownView;
//数据源
@property (strong,nonatomic) NSArray<MTCategoryModel *> *dataArray;

@end

@implementation MTCategoryVC





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    self.dropdownView.categoryModelArray = self.dataArray;
}

#pragma mark - UI界面的搭建 数据 的加载
- (void)setupUI {
    //1.设置自己被modal出来时候的大小
    self.preferredContentSize = CGSizeMake(350, 350);
    //2.设置view
    [self setupDropdownView];
}
- (void)loadData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray *array = [NSArray yy_modelArrayWithClass:[MTCategoryModel class] json:plistArray];
    self.dataArray = array;
}


#pragma mark - MTDropdownView
//MARK: 懒加载
- (MTDropdownView *)dropdownView {
    if (!_dropdownView) {
        _dropdownView = [[MTDropdownView alloc]init];
    }
    return _dropdownView;
}

//MARK: 设置dropdownView
- (void)setupDropdownView {
    //1.添加view
    [self.view addSubview:self.dropdownView];
    //2.添加约束
    [self.dropdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - 懒加载属性
-(NSArray<MTCategoryModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc]init];
    }
    return _dataArray;
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
