//
//  MTHomeVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeVC.h"
#import "MTHomeCollectionVC.h"
#import "UIBarButtonItem+MTCategory.h"
#import "MTHomeNACView.h"
#import "MTCategoryVC.h"
#import "MTDistrictVC.h"
#import "MTCategoryModel.h"
#import "MTCityModel.h"
#import "MTDistrictModel.h"
#import "MTSortVC.h"
#import "MTHomeViewModel.h"
#import "MJRefresh.h"
#import "MTSortModel.h"
#import "AwesomeMenu.h"

@interface MTHomeVC () <AwesomeMenuDelegate>
@property (nonatomic,strong) MTHomeNACView *categoryView;//分组
@property (nonatomic,strong) MTHomeNACView *districtNavView;//城市
@property (nonatomic,strong) MTHomeNACView *sortNavView;//排序

@property (nonatomic,assign) NSInteger page;//分页
@property (nonatomic,weak) UIViewController *modalVC;//记录的vc
@property (nonatomic,copy) NSString *selectCity;//选中的城市
@property (nonatomic,copy) NSString *selectDistrct;//记录选中的地区
@property (nonatomic) NSNumber *selectSort;//记录排序方法
@property (nonatomic,copy) NSString *selectCategoryName;//综合排序筛选
@property (nonatomic,strong) MTCityModel *selectDistrictModel;//记录选中的model

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIImageView *noDataImage;

@property (nonatomic,weak) MTHomeCollectionVC *homeCollectionVC;
@end

@implementation MTHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 搭建UI界面
- (void)setupUI{
    
    //设置出事值
    self.selectCity = @"北京";
    
    [self setNavigationBar];//设置导航条
    [self setCollectionVC];//设置collectionVC
    [self observeNotification];//监听通知的方法
    [self loadDate];//加载数据
    [self setupRefresh];//加动画
    [self setupMenu];//添加菜单
    
//    [self.view addSubview:self.noDataImage];
//    [self.noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];

}


#pragma mark - loadDate
- (void)loadDate {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    // 城市参数
    params[@"city"] = self.selectCity;
    // 分类
    if (self.selectCategoryName) {
        params[@"category"] = self.selectCategoryName;
    }
    // 区域
    if (self.selectDistrct) {
        params[@"region"] = self.selectDistrct;
    }
    // 排序
    if (self.selectSort) {
        params[@"sort"] = self.selectSort;
    }
    
    if (!self.page){
        self.page = 1;
    }
    
    
    
    
    params[@"limit"] = @24;
    //分页
    params[@"page"] = @(self.page);
    
    
    NSLog(@"%@",params);
    
    [[MTHomeViewModel sharedHomeViewModel] loadHomeNetDataWithCityName:params andModelArrayBlock:^(BOOL isSucceed, NSArray<MTHomeCellModel *> *modelArray) {
        if (isSucceed) {
            //传递model数组给homeCollectionVC
            if (self.page == 1) {
//                [self.dataArray removeAllObjects];
                self.dataArray = modelArray.mutableCopy;
            }else{
                [self.dataArray addObjectsFromArray:modelArray];
            }
             self.homeCollectionVC.modelArray = self.dataArray;
        }
        //判断是否隐藏collctionView的NoDataImage
        self.homeCollectionVC.hiddenNoDataImage = !self.dataArray.count;
//        self.noDataImage.hidden = self.dataArray.count;
        
        //结束加载
        [self.homeCollectionVC.collectionView.mj_footer endRefreshing];
        [self.homeCollectionVC.collectionView.mj_header endRefreshing];
    }];
}


#pragma mark - refrech
- (void)setupRefresh{
//    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        
//    }];
    //yao
//    self.homeCollectionVC.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.page = 1;
//        [self loadDate];
//    }];
//    
//    self.homeCollectionVC.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        self.page ++;
//        [self loadDate];
//    }];
//    
//    [self.homeCollectionVC.collectionView.mj_header beginRefreshing];
    [self.homeCollectionVC setMj_footerBlock:^{
        self.page ++;
        [self loadDate];
    }];
    [self.homeCollectionVC setMj_headerBlock:^{
        self.page = 1;
        [self loadDate];
    }];
}

#pragma mark - CollectionVC

- (void)setCollectionVC {
    MTHomeCollectionVC * homeCollectionVC = [[MTHomeCollectionVC alloc]init];
    self.homeCollectionVC = homeCollectionVC;
    //MARK: ---------- 注意这里只要加入View 给self就可以，这样就可以进行collctionView 的view添加子控件了
    [self.view addSubview:homeCollectionVC.view];
    [self addChildViewController:homeCollectionVC];
    [homeCollectionVC didMoveToParentViewController:self];
    homeCollectionVC.collectionView.frame = self.view.frame;
}

#pragma mark - NavigationBar

- (void)setNavigationBar{
    //MARK: 搭建右边NavigationBar
    //地图
    UIBarButtonItem *mapItem = [UIBarButtonItem barButtonItemWithImageName:@"icon_map" andTarget:self andAction:@selector(mapItemAction)];
    mapItem.customView.frame = CGRectMake(0, 0, 60, 60);
    
    //搜索
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithImageName:@"icon_search" andTarget:self andAction:@selector(searchItemAction)];
    searchItem.customView.frame = CGRectMake(0, 0, 60, 60);
    
    //添加
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
    
    //MARK: 左边的NavigationBar
    UIBarButtonItem *logoItem = [UIBarButtonItem barButtonItemWithImageName:@"icon_meituan_logo" andTarget:self andAction:nil];
    logoItem.customView.frame = CGRectMake(0, 0, 60, 60);
    logoItem.customView.userInteractionEnabled = false;
    
    //分类
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryView];
    //地区
    UIBarButtonItem *districtNavItem = [[UIBarButtonItem alloc]initWithCustomView:self.districtNavView];
    
    //排序
    UIBarButtonItem *sortNavItem = [[UIBarButtonItem alloc]initWithCustomView:self.sortNavView];
    
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,districtNavItem,sortNavItem];
}

//MARK: item 的点击事件
- (void)mapItemAction{
    NSLog(@"地图");
}
- (void)searchItemAction{
    NSLog(@"查询");
}



#pragma mark - 懒加载 左边的item 并且设置了回调Block

//MARK: -左边的item
- (MTHomeNACView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[MTHomeNACView alloc]init];
        
        //MARK: -----------------------------------产生了强引用，必须要用WeakSelf
        __weak typeof (self) weakSelf = self;
        [_categoryView setClickButtonBlock:^{
            NSLog(@"分类");
            //点击事件的回调：
            [weakSelf clickCategoryItem];
        }];
        
        [_categoryView changeValueWithTitle:@"全部分类" andSubTitle:nil];
        [_categoryView changeIconWithNormalStr:@"icon_category_-1" andHighlightedStr:@"icon_category_highlighted_-1"];
        
        [[MTHomeViewModel sharedHomeViewModel] cityWithCityName:self.selectCity andCityResultBlock:^(MTCityModel *model) {
            self.selectDistrictModel = model;
        }];
    }
    return _categoryView;
}

- (MTHomeNACView *)districtNavView{
    if (!_districtNavView) {
        _districtNavView = [[MTHomeNACView alloc]init];
        __weak typeof (self) weakSelf = self;
        [_districtNavView setClickButtonBlock:^{
            NSLog(@"地区");
            [weakSelf clickDistrictItem];
        }];
        [_districtNavView changeValueWithTitle:@"北京—全部" andSubTitle:nil];
    }
    return _districtNavView;
}

- (MTHomeNACView *)sortNavView {
    if (!_sortNavView) {
        _sortNavView = [[MTHomeNACView alloc]init];
        __weak typeof (self) weakSelf = self;
        [_sortNavView setClickButtonBlock:^{
            NSLog(@"排序");
            //弹出弹框
            [weakSelf clickSortItem];
        }];
        [_sortNavView changeValueWithTitle:@"排序" andSubTitle:@"默认排序"];
        [_sortNavView changeIconWithNormalStr:@"icon_sort" andHighlightedStr:@"icon_sort_highlighted"];
    }
    return _sortNavView;
}

//MARK: 左边的item点击事件的处理
- (void)clickCategoryItem {//分组
    //modal一个控制器
    MTCategoryVC * categoryVC = [[MTCategoryVC alloc]init];
    [self handleModalVC:categoryVC andItemIndex:1];
    
//    //1、设置modal的样式
//    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
//    //2、设置modal的位置
//    categoryVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[1];
//    //3、modal出来
//    [self presentViewController:categoryVC animated:true completion:nil];
    
}

- (void)clickDistrictItem {//地区
    MTDistrictVC * districtVC = [[MTDistrictVC alloc]init];
    //传入 选中的 的model
    
    districtVC.cityModel = self.selectDistrictModel;
    
    [self handleModalVC:districtVC andItemIndex:2];
}

- (void)clickSortItem {//排序
    MTSortVC *sortVC = [[MTSortVC alloc]init];
    [sortVC setClickButtonBlock:^(NSInteger tag,NSString *buttonTitle) {
        [self.sortNavView changeValueWithTitle:@"排序" andSubTitle: buttonTitle];
        
        //MARK: 赋值
        self.selectSort = @(tag);
        [self.dataArray removeAllObjects];
        [self loadDate];
        
        [self dismissViewControllerAnimated:true completion:nil];
    }];
    [self handleModalVC:sortVC andItemIndex:3];
}



#pragma mark - 通知的监听

//MARK: 注册 监听通知
- (void)observeNotification{
    //1.监听分类的改变的方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryDidChenge:) name:kMTCategoryDidChangeNotifacation object:nil];
    
    
    //2.监听城市改变的方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:kMTCityDidChangeNotifacation object:nil];
    //3.监听地区将要改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDistrictChange:) name:kMTDistrictDidChangeNotifacation object:nil];
    
}

//MARK: 监听到通知执行的方法

//城市的改变
- (void)cityDidChange: (NSNotification *)noti{
    
    //3. dismiss
    [self dismissViewControllerAnimated:true completion:nil];
    
    //1. 拿到穿过来的title；
    NSString *districtItemTiele;//定义
        //1.0 如果要是从搜索传来的城市 那应该是模型
    NSDictionary *dic = noti.userInfo;
   

    if([dic[kMTCityDidChangeNotifacation] isMemberOfClass:[MTCityModel class]]){
        //是从搜索界面传过来的
        MTCityModel *districtModel = dic[kMTCityDidChangeNotifacation];
        districtItemTiele = districtModel.name;//赋值给选总城市名字
        self.selectDistrictModel = districtModel;//赋值给选中的model
        self.selectCity = self.selectDistrictModel.name;
        //MARK: 搜索
//        [self handleCityWithCity:nil andDistrict:nil];

    }else{
        //是从切换城市点击后 下面的tableView传过来的
        //1.1.1 如果是从切换城市直接选中  那么应该是一个字符串
        districtItemTiele = dic[kMTCityDidChangeNotifacation_CellTitel];
        //拼贴上 -全部
        //4、记录选中的城市
        self.selectCity = districtItemTiele;
        [[MTHomeViewModel sharedHomeViewModel] cityWithCityName:districtItemTiele andCityResultBlock:^(MTCityModel *model) {
            self.selectDistrictModel = model;
        }];
        //MARK: 搜索
//        [self handleCityWithCity:nil andDistrict:nil];
        
    }
//    //MARK: 搜索
    [self handleCityWithCity:nil andDistrict:nil];
    // 赋值
    [self.districtNavView changeValueWithTitle:[NSString stringWithFormat:@"%@-全部", districtItemTiele] andSubTitle:nil];
}

//MARK: 监听从dropdownView 地区中传来的通知
- (void)cityDistrictChange: (NSNotification *)noti {
   
    [self dismissViewControllerAnimated:true completion:nil];
    
    NSString *districtTitle = noti.userInfo[kMTDistrictDidChangeNotifacation_CellTitel];
    MTDistrictModel *districtModel = noti.userInfo[kMTDistrictDidChangeNotifacation];
    NSString *cityDistrictTitle = districtModel.name;
    
    //MAKR: 搜索
    [self handleCityWithCity:cityDistrictTitle andDistrict:districtTitle];
    
    //赋值  拼贴
    if (cityDistrictTitle){//如果有值 （表示有详情）
        cityDistrictTitle = [NSString stringWithFormat:@"%@-%@",self.selectCity,cityDistrictTitle];
    }
    
    
    //赋值
    [self.districtNavView changeValueWithTitle:cityDistrictTitle andSubTitle:districtTitle];
}



//MARK: 监听到分类改变
- (void)categoryDidChenge: (NSNotification *)noti {
    //4.dismiss
    [self dismissViewControllerAnimated:true completion:nil];
    
    NSDictionary *userInfo = noti.userInfo;
    //2. 拿到对应的信息赋值
        //传过来的model
    MTCategoryModel *categoryModel = userInfo[kMTCategoryDidChangeNotifacation];
        //主标题
    NSString *mainTitle = categoryModel.name;
        //子标题
    NSString *subTitle = userInfo[kMTCategoryDidChangeNotifacation_CellTitle];
        //高粱icon
    NSString *highlighted_icon = categoryModel.highlighted_icon;
        //icon
    NSString *icon = categoryModel.icon;
    
    //MAKR: 搜索赋值
    [self handleCategoryWithTitle:mainTitle andSubTitle:subTitle];
    
    //3.赋值
    [self.categoryView changeValueWithTitle:mainTitle andSubTitle:subTitle];
    [self.categoryView changeIconWithNormalStr:icon andHighlightedStr:highlighted_icon];
}




//MARK: 注销通知
- (void)dealloc{
    //注销所有的通知：
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 选中的逻辑处理
//分类的判断
- (void)handleCategoryWithTitle: (NSString *)title andSubTitle: (NSString *)subTitle{
    
    if (subTitle == nil || [self.selectCategoryName isEqualToString:@"全部"] ) {
        self.selectCategoryName = title;
    }else{
        self.selectCategoryName = subTitle;
    }
    
    if ([self.selectCategoryName isEqualToString:@"全部分类"]) {
        self.selectCategoryName = nil;
    }
    //清空记录数据的数组
    [self.dataArray removeAllObjects];
    [self loadDate];
}

//城市的判断
- (void)handleCityWithCity: (NSString *)cityName andDistrict:(NSString *)districtName{
    if (districtName == nil || [districtName isEqualToString:@"全部"]) {
        self.selectDistrct = cityName;
    }else{
        self.selectDistrct = districtName;
    }
    
    if ([self.selectDistrct isEqualToString:@"全部"]) {
        self.selectDistrct = nil;
    }
    [self.dataArray removeAllObjects];
    [self loadDate];
}


#pragma mark - 菜单栏的添加
- (void)setupMenu {
    //开始的菜单按钮
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    //我的
    AwesomeMenuItem *mineItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mine_highlighted"]];
    // 收藏
    AwesomeMenuItem *collectItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_collect_highlighted"]];
    // 预览
    AwesomeMenuItem *scanItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_scan_highlighted"]];
    // 更多
    AwesomeMenuItem *moreItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_more_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_more_highlighted"]];
    
    //2.添加
    NSArray *itemArray = @[mineItem,collectItem,scanItem,moreItem];
    AwesomeMenu *menu = [[AwesomeMenu alloc]initWithFrame:CGRectZero startItem:startItem menuItems:itemArray];
    
    //3.添加到view
    [self.view addSubview:menu];
    //4.设置约束 ： 注意这里必须先设置起点位置
    menu.startPoint = CGPointMake(0, 0);
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.bottom.offset(-100);
    }];
    
    //5.设置不能专项
    menu.rotateAddButton = false;
    //6.设置子菜单的角度
    menu.menuWholeAngle = M_PI_2;
    //7.设置透明度
    menu.alpha = 0.6;
    //8.设置代理
    menu.delegate = self;
}
//MARK: 菜单 代理方法的实现
//开启
-(void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu {
    //调整透明度
    [UIView animateWithDuration:.2 animations:^{
        menu.alpha = 1;
        menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
        menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    }];
    
}
//关闭
- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu {
    [UIView animateWithDuration:.2 animations:^{
        menu.alpha = .6;
        menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
        menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    }];
}
//点击事件
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx {
    switch (idx) {
        case 0:
            NSLog(@"我的")
            break;
        case 1:{
        
        }
            NSLog(@"收藏")
            break;
        case 2:
            NSLog(@"预览")
            break;
        case 3:
            NSLog(@"更多")
            break;
            
        default:
            NSLog(@"没有")
            break;
    }
}

#pragma mark - ------其他的一些方法
//MARK: 左边的item 的modal事件的封装
- (void)handleModalVC: (UIViewController *)VC andItemIndex: (int) index {
    if (self.modalVC && self.modalVC != VC) {
        //销毁
        [self.modalVC dismissViewControllerAnimated:true completion:nil];
    }
    self.modalVC = VC;
    //1、设置modal的样式
    VC.modalPresentationStyle = UIModalPresentationPopover;
    //2、设置modal的位置
    VC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[index];
    //3、modal出来
    [self presentViewController:VC animated:true completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)noDataImage {
    if (!_noDataImage) {
        _noDataImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        _noDataImage.hidden = true;
    }
    return _noDataImage;
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
