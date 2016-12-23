//
//  MTCityVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/19.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTCityVC.h"//城市的VC
#import "MTCitySearchResultVC.h" //城市查询结果的VC（与蒙版按钮一样大的VC）
#import "MTCityGroupModel.h"//分组的（包括热门搜索的）model

@interface MTCityVC ()
<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate
>

@property (nonatomic,strong) UITableView *bottomTableView;//底部的城市的按钮
@property (nonatomic,strong) UISearchBar *searchBarView;//查询 输入框
@property (nonatomic,strong) UIButton *coverButton;// 罩层按钮
@property (nonatomic,strong) MTCitySearchResultVC * citySearchResultVC;//城市查询的VC
@property (nonatomic,strong) NSArray<MTCityGroupModel *> *cityGroupArray;//包括热门城市的最低层的tableView的数据源

@end

@implementation MTCityVC{
    NSString *_NVCTitle;//NVC标题
    NSString *_searchBarViewPlaceTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];//UI界面的搭建
    [self loadData];//加载数据
}

#pragma mark - 搭建UI界面 以及加载数据
- (void)setupUI {
    
    _NVCTitle = @"选择城市";
    _searchBarViewPlaceTitle = @"请输入城市名或拼音";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationItem];//设置导航条
    
    [self setupsearchBarView];//创建上边的view

    [self setupbottomTableView];//创建下面的tableView
    
    [self setupCoverButton];//罩层按钮
    
    [self setupCitySearchResultVC];//设置CitySearchResultVC
}

- (void)loadData {
    //1.获取路径
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    //2.加载数据
    NSArray *dataPlistArray = [NSMutableArray arrayWithContentsOfFile:dataPath];
    NSArray *cityGroupArray = [NSArray yy_modelArrayWithClass:[MTCityGroupModel class] json:dataPlistArray];
    self.cityGroupArray = cityGroupArray;
    //异步网络请求的话刷新UI界面
}


#pragma mark - 设置导航条
- (void)setupNavigationItem {
    self.navigationItem.title = _NVCTitle;
   //自定义左边的item；
    UIButton *itemButton = [[UIButton alloc]init];
    [itemButton setImage:[UIImage imageNamed:@"btn_navigation_close"] forState:UIControlStateNormal];
    [itemButton setImage:[UIImage imageNamed:@"btn_navigation_close_hl"] forState:UIControlStateHighlighted];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:itemButton];
    [itemButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];//点击事件
    //一开始不出来是因为没有大
    [itemButton sizeToFit];//----
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

//MARK: NVC 取消按钮的点击事件
- (void)clickCancelButton {
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 上边的view
//MARK: 懒加载topView
- (UIView *)searchBarView {
    if (!_searchBarView) {
        _searchBarView = [[UISearchBar alloc]initWithFrame:CGRectZero];
    }
    return _searchBarView;
}


//MARK: 设置searchBarView
- (void)setupsearchBarView{
    [self.view addSubview: self.searchBarView];
    [self.searchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    self.searchBarView.delegate = self;//设置代理
    self.searchBarView.placeholder = _searchBarViewPlaceTitle;
    //1.设置背景颜色
    UIImage *image = [UIImage imageNamed:@"bg_login_textfield"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    self.searchBarView.backgroundImage = image;
    
    //2.获取系统的searchBar 的取消按钮
    //他只有一个控件 那就是view
    //view里面又有控件这时候才有按钮
//    UIView *sbView = self.searchBarView.subviews[0];
//   
//    //MARK: -------------0.1-------------------注意这里要先展示取消按钮 才能遍历到这个按钮
//    //MARK: -------------0.2-------------------注意这里业务逻辑 要隐藏取消按钮 但是隐藏了就有回到了英文状态 所以要在编辑的时候进行设置
//
//    self.searchBarView.showsCancelButton = true;//展示
//    //遍历view
//    for (UIView *view in sbView.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)view;
//            button.titleLabel.text = @"取消";
//            [button setTitle:@"取消" forState:UIControlStateNormal];
//            [button setTitleColor:MTColor(21, 188, 173) forState:UIControlStateNormal];
//        }
//    }
//    //先隐藏
//    self.searchBarView.showsCancelButton = false;
}


//MARK: 代理方法

//MARK:1.开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 让导航条隐藏
    [self.navigationController setNavigationBarHidden:true];
    
    //1.背景图片换成绿色的
    UIImage *image = [UIImage imageNamed:@"bg_login_textfield_hl"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [searchBar setBackgroundImage: image];
    
    //2. 显示取消按钮
    //.获取系统的searchBar 的取消按钮
    //他只有一个控件 那就是view
    //view里面又有控件这时候才有按钮
    UIView *sbView = self.searchBarView.subviews[0];
    self.searchBarView.showsCancelButton = true;
    //MARK: -------------0.2-------------------注意这里业务逻辑 要隐藏取消按钮 但是隐藏了就有回到了英文状态 所以要在编辑的时候进行设置
    
    self.searchBarView.showsCancelButton = true;//展示
    //遍历view
    for (UIView *view in sbView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.text = @"取消";
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:MTColor(21, 188, 173) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickSearchBarCancelButton) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //出现罩层按钮
    self.coverButton.alpha = 1;
}
//MARK: 取消 searchBar 按钮的点击事件
- (void)clickSearchBarCancelButton {
    [self.searchBarView endEditing:true];
    [self dismissViewControllerAnimated:true completion:nil];
}


//MARK: 取消编辑
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.searchBarView.showsCancelButton = false;//隐藏按钮
    //1.设置背景颜色
    UIImage *image = [UIImage imageNamed:@"bg_login_textfield"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    self.searchBarView.backgroundImage = image;
}

//MARK: 文件改变的时候
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(self.searchBarView.text.length > 0){
        //1.隐藏罩层按钮
        self.coverButton.alpha = 0;
        //2.显示控制器
        self.citySearchResultVC.view.hidden = false;
        //3.给citySearchResultVC赋值
        self.citySearchResultVC.searchString = self.searchBarView.text;
    }else{
        self.coverButton.alpha = 1;
        self.citySearchResultVC.view.hidden = true;
    }
}


#pragma mark - 罩层按钮
//MARK: 懒加载罩层按钮
- (UIButton *)coverButton {
    if (!_coverButton) {
        _coverButton = [[UIButton alloc]init];
    }
    _coverButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    return _coverButton;
}

//MARK: 设置罩层按钮
- (void)setupCoverButton {
    //1. 添加到view
    [self.view addSubview:self.coverButton];
    //2. 约束
    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomTableView);
    }];
    //3.添加点击事件
    [self.coverButton addTarget:self action:@selector(clickCoverButton) forControlEvents:UIControlEventTouchUpInside];
    //4. 设置隐藏
//    self.coverButton.isHidden = YES;
    self.coverButton.alpha = 0;
}

//MARK: 罩层按钮 点击事件
- (void)clickCoverButton {
    //导航条出现
    [self.navigationController setNavigationBarHidden:false];
    //编辑结束
    [self.searchBarView endEditing:true];
    //隐藏按钮
    self.coverButton.alpha = 0;
}


#pragma mark - citySearchResultVC的设置
- (MTCitySearchResultVC *)citySearchResultVC{
    if (!_citySearchResultVC) {
        _citySearchResultVC = [[MTCitySearchResultVC alloc]init];
    }
    return _citySearchResultVC;
}

- (void)setupCitySearchResultVC {
    //添加
    [self.view addSubview:self.citySearchResultVC.view];
    [self addChildViewController:self.citySearchResultVC];
    [self.citySearchResultVC didMoveToParentViewController:self];
    
    //约束
    [self.citySearchResultVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.coverButton);
    }];
    //隐藏
    self.citySearchResultVC.view.hidden = true;
}

#pragma mark - 下边的tableView的设置
//MARK: 懒加载tableView
- (UITableView *)bottomTableView{
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.sectionIndexColor = MTColor(21, 188, 173);
        _bottomTableView.sectionIndexMinimumDisplayRowCount = 1;
        //点击后的背景颜色
        _bottomTableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
        //背景颜色
        _bottomTableView.sectionIndexBackgroundColor = [UIColor blackColor];
//        [_bottomTableView reloadSectionIndexTitles];
    }
    return _bottomTableView;
}
- (void)setupbottomTableView {
    //1.添加到view
    [self.view addSubview:self.bottomTableView];
    
    //2. 约束
    [self.bottomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.searchBarView.mas_bottom).offset(15);
    }];
    
    //3.设置组尾 为了取消多余的分割线
    self.bottomTableView.tableFooterView = [[UIView alloc]init];
}

//MARK: 代理和数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityGroupArray[section].cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    //如没有cell 那就创建一个
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    //右箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.cityGroupArray[indexPath.section].cities[indexPath.row];
    return cell;
}

//MARK: 监听点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击后发送通知到 homeVC 然后把名字传过去
    [[NSNotificationCenter defaultCenter] postNotificationName:kMTCityDidChangeNotifacation object:nil userInfo:@{kMTCityDidChangeNotifacation_CellTitel : self.cityGroupArray[indexPath.section].cities[indexPath.row]}];
}

// MARK: 组头 设置
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.cityGroupArray[section].title;
}
- (NSArray <NSString *>*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *sectionArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.cityGroupArray.count; i ++) {
        [sectionArray addObject:self.cityGroupArray[i].title];
    }
    return sectionArray;
}




#pragma mark - 懒加载
- (NSArray<MTCityGroupModel *> *)cityGroupArray {
    if (!_cityGroupArray) {
        _cityGroupArray = [[NSArray alloc]init];
    }
    return _cityGroupArray;
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
