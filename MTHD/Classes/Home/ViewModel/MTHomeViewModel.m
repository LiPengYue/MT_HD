//
//  MTHomeViewModel.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/21.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeViewModel.h"
#import "MTCityModel.h"
#import "MTDistrictModel.h" 
#import "MTSortModel.h"


#import "DPAPI.h"
#import "MTHomeCellModel.h"
#import "NSDate+MTCompareDate.h"
#import "NSString+MTStr.h"
//#import "AwesomeMenu.h"//地区的菜单

//------------------------宏定义---------------------------------
//1. 网络请求url 资源访问路径，如/v1/deal/find_deals;
#define kRequestPtath @"v1/deal/find_deals"

@interface MTHomeViewModel () <DPRequestDelegate>

//------------------------首页plist------------------------------
#pragma mark - 首页 的plist （NavigationColtroller）的属性
//城市 具体地区的数组   //城市查询数
@property (nonatomic,strong) NSArray <MTCityModel *> *cityDistictArray;




//------------------------首页网络------------------------------
#pragma mark - 首页网络数据的储存
//数据返回的block
@property (nonatomic,copy) void(^modelArrayBlock)(BOOL,NSArray <MTHomeCellModel *> *modelArray);


@end







@implementation MTHomeViewModel
static id _instancetype;
//单利模式
+ (instancetype)sharedHomeViewModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instancetype = [[self alloc]init];
    });
    return _instancetype;
}

#pragma mark - 首页 - plist数据加载 也就是navigationController数据
//MARK: 懒加载
//返回详细的城市列表 （城市+ 县 - 地区）
- (NSArray<MTCityModel *> *)cityDistictArray {
    if (!_cityDistictArray) {
        //加载数据
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
        NSArray *plistArray = [NSArray arrayWithContentsOfFile:dataPath];
        _cityDistictArray = [NSArray yy_modelArrayWithClass:[MTCityModel class] json:plistArray];
    }
    return _cityDistictArray;
}

//地区的 数据
/**
 * 关于查询城市列表的方法
 */
- (void)searchCityWithStr: (NSString *)searchStr andResultBlock: (void(^)(NSInteger count,NSArray<MTCityModel *> *searchCityArray))resultBlock{
    
    //根据字段查询
    
    //3. 建立临时数组
    NSMutableArray<MTCityModel *> *cityModelArray = [[NSMutableArray alloc]init];
    
    //1. 遍历
    for (MTCityModel *cityModel in self.cityDistictArray){
        //5.全部转化成小写 防止人家输入的是大写 而被遗漏掉
        searchStr = [searchStr lowercaseString];
        
        //2. 若其中的条件满足 那么加入数组
        if ([cityModel.pinYin containsString:searchStr] ||
            [cityModel.pinYinHead containsString:searchStr] ||
            [cityModel.name containsString:searchStr] ){
            //4. 符合条件追加到数组中
            [cityModelArray addObject:cityModel];
        }
    }
    
    //6.通过block 回调 （这里是防止以后用网络请求所以用的block 没有用返回值）
    if (resultBlock) {
        resultBlock(cityModelArray.count,cityModelArray.copy);
    }
}

//MARK: 具体城市的列表
//根据城市名 + 县名 block返回对应的 县级的model
- (void)cityWithCityName: (NSString *)cityName andDistictName: (NSString *)distictName andCityResultBlock: (void(^)(MTDistrictModel * model)) resultBlock{
    
    __block MTCityModel * cityModel = [[MTCityModel alloc]init];
    [self.cityDistictArray enumerateObjectsUsingBlock:^(MTCityModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.name isEqualToString:cityName]){
            cityModel = model;
            *stop = YES;
        }
    }];
    
    [cityModel.districts enumerateObjectsUsingBlock:^(MTDistrictModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.name isEqualToString:distictName]){
            if (resultBlock){
                resultBlock(model);
            }
            *stop = YES;
        }
    }];
}
//返回详细的城市+地区 根据城市名字
- (void)cityWithCityName: (NSString *)cityName andCityResultBlock: (void(^)(MTCityModel * model)) resultBlock {

    [self.cityDistictArray enumerateObjectsUsingBlock:^(MTCityModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.name isEqualToString:cityName]){
            if (resultBlock) {
                resultBlock(model);
            }
            *stop = YES;
        }
    }];
}


//MARK: --对于首页排序item的数据
- (NSArray *)sortArray{
    if (!_sortArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sorts.plist" ofType:nil];
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        _sortArray = [NSArray yy_modelArrayWithClass:[MTSortModel class] json:array];
    }
    return _sortArray;
}


#pragma mark - 对于首页的网络数据加载

/**
 * cityName ----------包含团购信息的城市名称，
 * page --------------页码，如不传入默认为1，即第一页；
 * destination_city---指定目的地城市名称，适用于“酒店”、“旅游”等分类，
 * category ----------包含团购信息的分类名，支持多个category合并查询，多个category用逗号分割。
 * sort	--------------结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先
 *
 * modelArrayBlock ---用于返回数据的block
 */
//参数从外界传过来
- (void)loadHomeNetDataWithCityName: (NSMutableDictionary *)params andModelArrayBlock: (void(^)(BOOL isSucceed,NSArray< MTHomeCellModel *>* modelArray))modelArrayBlock {
    //1.实例化一个对象
    DPAPI *dpapi= [DPAPI new];
    
    //3.调用请求数据的方法
    [dpapi requestWithURL:kRequestPtath params: params delegate:self];
    
    //4.赋值
    self.modelArrayBlock = modelArrayBlock;
}

//MARK: DPAPI 代理的 代理方法的实现

//1.请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------------------请求失败");
    NSLog(@"-----error----%@",error);
    if (self.modelArrayBlock){
        self.modelArrayBlock(NO,nil);
    }
}


//2.请求成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSLog(@"-------------------请求成功");
//    NSLog(@"-----%@",result);
    //返回的是一个字典，里面有：
    /*
     {
     "status": "OK",     ----1.如果是OK那么说明数据返回成功
                             2.如果失败返回"ERROR"，并返回错误说明
     
     "total_count": 11,------  所有页面团购总数
     
     "count": 1,-------------  本次API访问所获取的单页团购数量
     "deals": []-------------  如果数据返回成功 就返回数据段 为字典数组
     }
     */
    
    //1.判断是否返回成功：
    NSDictionary *netDaic = (NSDictionary *)result;
    NSString *status = netDaic[@"status"];
    if (![status isEqualToString:@"OK"]){//不等于ok就说明返回数据失败；
//        NSLog(@"%@",status);
        if (self.modelArrayBlock){
            self.modelArrayBlock(NO,nil);
        }
        return;
    }
    
    //2.成功返回数据
        //--1.数据的解析//返回的数据段有关键字 desctipation 在model里面做了处理
    NSArray <NSDictionary *> *dicArray = result[@"deals"];
        //--2.YYModel 进行解析数据
    NSArray <MTHomeCellModel *> *modelArray = [NSArray yy_modelArrayWithClass:[MTHomeCellModel class] json:dicArray];
    
        //--3.对model数据进行处理
    //遍历数组 //是地址传递 OC不用重新赋值 而swift 要赋值
    [modelArray enumerateObjectsUsingBlock:^(MTHomeCellModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        //是否为新品
        model.isDealNew = [NSDate isLateCurrentDateWithDate:model.publish_date];
        //商品的价格小数部分的处理
        //如果有是俩个小数那么不显示 
        model.currentPriceStr = [NSString deleteLastZeroWithStr:model.current_price];
        model.listPriceStr = [NSString deleteLastZeroWithStr:model.list_price];
    }];
    
    //3.返回数据
    if (self.modelArrayBlock) {
        self.modelArrayBlock(YES,modelArray);
    }
}
@end


