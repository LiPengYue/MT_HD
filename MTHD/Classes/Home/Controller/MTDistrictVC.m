//
//  MTDistrictVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/20.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDistrictVC.h"
#import "MTCityVC.h"
#import "MTBaseNAV.h"
#import "MTDropdownView.h"
#import "MTCityModel.h"

@interface MTDistrictVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *topTableView;
@property (nonatomic,strong) MTDropdownView *dropdownView;
@end

@implementation MTDistrictVC{
    NSString *_topTableViewCellTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 搭建UI界面
- (void)setupUI {
    self.preferredContentSize = CGSizeMake(350, 350 + 44);
    
    _topTableViewCellTitle = @"切换城市";
    //分析 创建一个tableView 只有一行
    //下边是一个正常的dropDownView;
    
    //创建上面的tableView
    [self setupTopTableView];
    
    //是否隐藏 在方法内部做了判断，看self.model.name是否有值
    [self setupDropDownView];
}


#pragma mark - 上边的tableView的设置
//MARK: 懒加载tableView
- (UITableView *)topTableView{
    if (!_topTableView) {
        _topTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.bounces = false;
        _topTableView.showsVerticalScrollIndicator = false;
        _topTableView.showsHorizontalScrollIndicator = false;
    }
    return _topTableView;
}
- (void)setupTopTableView {
    //1.添加到view
    [self.view addSubview:self.topTableView];
    
    //2. 约束
    [self.topTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
}

//MARK: 代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    cell.textLabel.text = _topTableViewCellTitle;
    //cell.backgroundColor = [UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//MARK: 监听点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //MARK: ---------------------------问题 为什么一定要在前面dismiss 掉 然后在跳转
     [self dismissViewControllerAnimated:true completion:nil];
    
    //1.条转控制器
    MTCityVC * cityVC = [[MTCityVC alloc] init];
    //2. 跳转并且dismiss掉现在的控制器
    //这种方法不行 因为self 已经被dismiss掉了 就不能跳转了  跳转必须让self 能对他有引用
    //这时候可以用window的rootViewcontroller来跳转
//    [self presentViewController:cityVC animated:true completion:^{
//        [self dismissViewControllerAnimated:true completion:nil];
//    }];
    
    //3. 这时候可以用window的rootViewcontroller来跳转
    UIViewController * viewController = [[UIApplication sharedApplication].windows firstObject].rootViewController;
    
    //modal的形式
    MTBaseNAV * navigationController = [[MTBaseNAV alloc]initWithRootViewController:cityVC];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    //嵌套一个导航条
//    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:cityVC];
    
    [viewController presentViewController:navigationController animated:true completion:nil];
//    [self dismissViewControllerAnimated:true completion:nil];
    
}



#pragma mark - 下边的dropdownView;
//MARK: 懒加载dropDownView;
- (MTDropdownView *)dropdownView{
    if (!_dropdownView) {
        _dropdownView = [[MTDropdownView alloc]init];
    }
    return _dropdownView;
}

//MARK: 设置dropDownview
- (void)setupDropDownView {
    //1. 添加到View
    [self.view addSubview:self.dropdownView];
    //2. 约束
    [self.dropdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topTableView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
    //3.设置隐藏是否隐藏
    self.dropdownView.hidden = self.cityModel.name == nil;
    self.dropdownView.districtModelArray = self.cityModel.districts;
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
