//
//  MTDetailsVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDetailsVC.h"
#import "MTDetails_LeftDetailsV.h"
#import "MTHomeCellModel.h"
#import "MTDetailsViewModel.h"//数据请求的ViewModel

@interface MTDetailsVC () <UIWebViewDelegate>
@property (nonatomic,strong) MTDetailsViewModel *detailsViewModel;//ViewModel
@property (nonatomic,strong) MTDetails_LeftDetailsV *LeftDetailsView;//左边的View
@property (nonatomic,strong) UIWebView *rightDetailsWebView;//右边的View
@end

@implementation MTDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadData];
    //加载数据
    [self setupUI];
}

#pragma mark - UI界面的搭建
- (void)setupUI{
    self.view.backgroundColor = MTColor(240, 240, 240);
    //分为左右两个控制器
    [self setupLeftDetails];
    [self setupRightDetailsWeb];
}

#pragma mark - 加载数据
- (void)loadData {
    MTDetailsViewModel *detalsViewModel = [[MTDetailsViewModel alloc]init];
    NSMutableDictionary *parames = [[NSMutableDictionary alloc]init];
    parames[@"deal_id"] = self.homeCellMode.deal_id;
    
    
    [detalsViewModel loadDetailsDataWithParames:parames  LoadDataBlock:^(NSArray<MTDetailsViewModel *> *dataArray, NSError *error) {
       //请求下来后是一个数组  但是数组就一个元素 取出来
        MTDetailsModel *detailsModel = [dataArray firstObject];
        
        
    }];
}


#pragma mark - 左边的详情控制器
-(MTDetails_LeftDetailsV *)LeftDetailsView {
    if (!_LeftDetailsView) {
        _LeftDetailsView = [[MTDetails_LeftDetailsV alloc]init];
        _LeftDetailsView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    }
    return _LeftDetailsView;
}

//1.MARK: 懒加载左边的控制器
- (void)setupLeftDetails {
    [self.view addSubview:self.LeftDetailsView];
    [self.LeftDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.equalTo(400);
    }];
}





#pragma mark - 右边的Web控制器
//2.MARK: 懒加载右边的控制器
- (UIWebView *)rightDetailsWebView {
    if (!_rightDetailsWebView) {
        _rightDetailsWebView = [[UIWebView alloc]init];
        _rightDetailsWebView.delegate = self;
        _rightDetailsWebView.backgroundColor = MTColor(240, 240, 240);
        [_rightDetailsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    }
    return _rightDetailsWebView;
}

- (void)setupRightDetailsWeb {
    [self.view addSubview:self.rightDetailsWebView];
    [self.rightDetailsWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.view);
        make.left.equalTo(self.LeftDetailsView.mas_right).offset(20);
    }];
}



#pragma mark - webView的代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //从这里面可以拿到url的string
    
    return true;
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
