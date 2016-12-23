//
//  MTHMCitySearchResultVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/20.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTCitySearchResultVC.h"
#import "MTHomeViewModel.h"
#import "MTCityModel.h"
@interface MTCitySearchResultVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *cityTableView;

//数据源
@property (nonatomic,strong) NSArray<MTCityModel *> *cityArray;
@end

@implementation MTCitySearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 搭建UI界面
- (void)setupUI{
    
    [self setupbottomTableView];
    
}

#pragma mark - 下边的tableView的设置
//MARK: 懒加载tableView
- (UITableView *)cityTableView{
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
    }
    return _cityTableView;
}
- (void)setupbottomTableView {
    //1.添加到view
    [self.view addSubview:self.cityTableView];
    
    //2. 约束
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    //3.设置组尾 为了取消多余的分割线
    self.cityTableView.tableFooterView = [[UIView alloc]init];
}

//MARK: 代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    //如没有cell 那就创建一个
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"btn_changeCity"];
    cell.imageView.highlightedImage = [UIImage imageNamed:@"btn_changeCity_selected"];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.cityArray[indexPath.row].name;
    return cell;
}

//MARK: 监听点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1. dismiss
    [self dismissViewControllerAnimated:true completion:nil];
    
    //2. 发送通知 并且传入model（这里也发到 home的地区接受通知的那个地方）
    
    NSDictionary *userInfo = @{
                               kMTCityDidChangeNotifacation :
                                   self.cityArray[indexPath.row]
                               };
    //3.发送
    [[NSNotificationCenter defaultCenter] postNotificationName:kMTCityDidChangeNotifacation object:nil userInfo:userInfo];
}

//组头的显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"查询到%zd个结果",self.cityArray.count];
}

#pragma mark - 监听搜索字符 
//MARK: 重写setter 方法进行监听
- (void)setSearchString:(NSString *)searchString {
    _searchString = searchString;
    //遍历查询看有没有查询结果 在loadData的时候就进行加载数据
    MTHomeViewModel *sharedHomeViewModel = [MTHomeViewModel sharedHomeViewModel];
    [sharedHomeViewModel searchCityWithStr:searchString andResultBlock:^(NSInteger count, NSArray<MTCityModel *> *searchCityArray) {
        self.cityArray = searchCityArray;
        //刷新数据
        [self.cityTableView reloadData];
    }];
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
