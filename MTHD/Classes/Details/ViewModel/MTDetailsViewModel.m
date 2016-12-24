//
//  MTDetailsViewModel.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTDetailsViewModel.h"
#import "MTDetailsModel.h"
#import "DPAPI.h"
#import "NSString+MTStr.h"
#import "NSDate+MTCompareDate.h"
@interface MTDetailsViewModel ()<DPRequestDelegate>
@property (nonatomic,copy) void(^loadDataBlock)(NSArray <MTDetailsModel *>*dataArray,NSError *error);
@end

@implementation MTDetailsViewModel

- (void)loadDetailsDataWithParames: (NSMutableDictionary *)parames LoadDataBlock: (void(^)(NSArray <MTDetailsModel *>*dataArray,NSError *error))loadDataBlock {

    DPAPI *dpapi = [[DPAPI alloc]init];

    [dpapi requestWithURL:@"http://api.dianping.com/v1/deal/get_deals_by_business_id" params:parames delegate:self];
    
    self.loadDataBlock = loadDataBlock;
}

//请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------请求失败：error ---%@",error);
    if (self.loadDataBlock) {
        self.loadDataBlock(nil,error);
    }
}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *netData = (NSDictionary *) result;
    id statusData = netData[@"status"];
    if (![statusData isKindOfClass:[NSString class]]) {
        NSLog(@"-----连接成功----请求错误error： %@",statusData);
        if (self.loadDataBlock) {
            self.loadDataBlock(nil,statusData);
        }
        return ;
    }
    
    //表示的是请求成功
    NSArray<NSDictionary *> *netDetailsArray = result[@"deals"];
    
    //字典转模型
    NSArray<MTDetailsModel *> *dataArray = [NSArray yy_modelArrayWithClass:[MTDetailsModel class] json:netDetailsArray];
    
    //处理字段信息
    [dataArray enumerateObjectsUsingBlock:^(MTDetailsModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        //1.转成字符串 并且去掉多余的0
        model.currentPriceStr = [NSString deleteLastZeroWithStr:model.current_price];
        model.listPriceStr = [NSString deleteLastZeroWithStr:model.list_price];
        
        //2.获取当前时间
        NSDate *currentDate = [NSDate date];
        //3.获取model的字符串时间
        NSString *modelStrDate = model.purchase_deadline;
        //4.根据分类比较时间
            
            
        }];
    
    //返回数据
    if (self.loadDataBlock) {
        self.loadDataBlock(dataArray,nil);
    }
}



#pragma mark - 返回实例：

/*
 
 { "status": "OK", "count": 3, 
 "deals":[ { "deal_id": "1-219960",
 "title": "新世纪影城电影票", 
 "description": "仅售39元,价值130元电影票1张!环境优雅舒适,大片云集,震撼视听双享受,带给你别样的精彩感受!", 
 "city": "上海", 
 "list_price": 130,
 "current_price": 39,
 "regions": [ "八佰伴" ], 
 "categories": [ "电影" ],
 "purchase_count": 5349, 
 "purchase_deadline": "2013-08-26",
 "publish_date": "2013-06-29", 
 "details": "团购详情\n 凭大众点评网团购券可享受以下内容：\n\n- 电影票（1张，价值130元） \n",
 "image_url": "http://t2.dpfile.com/tuan/20130628/260329_130169072090000000.jpg", "s_image_url": "http://t3.dpfile.com/tuan/20130628/260329_130169072090000000_1.jpg", 
 "more_image_urls": [], "more_s_image_urls": [],
 "is_popular": 0, 
 "restrictions": { "is_reservation_required": 1, "is_refundable": 0, 
 "special_tips": "特别提示\n \n有效期：2013-06-29 至 2013-08-31\n本团购券可使用商户详见页面右侧/手机客户端“查看适用商户” \n请客户直接去影院票房联影通兑换窗口，工作人员手持终端进行兑换。 \n凭本券可在有效期内兑换新世纪普通公映场次电影票1张\n本券兑换周五18:00之后（含18:00）场次电影需补贴人民币5元/张\n本券兑换周六，周日双休日所有场次电影需补贴人民币5元/张\n本券可兑换二日内电影票（8月31日仅可兑换当日电影票） \n本电子券VIP厅、首映式、国际电影节、影展等特殊场次除不可使用兑换电影。\n含3D,不含VIP厅、首映式、见面会等特殊场次 \n配备3D眼镜，需另缴纳押金 \n所有影片上映时间以影院为准 \n如遇特殊影片需补差价，补差规则详见影院公告 \n不可与其他优惠同享\n本单团购不支持退款\n \n" },
 "notice": "", "deal_url": "http://cps.51ping.com/TLt2ub2j0l", 
 "deal_h5_url": "http://cps.51ping.com/i3-1e1iNpv", 
 "commission_ratio": 0.03, 
 "businesses": [ { "name": "新世纪影城", "id": 1926046, "city": "上海", 
 "address": "张杨路501号第一八佰伴10楼", 
 "latitude": 31.226833, "longitude": 121.52274, 
 "url": "http://cps.51ping.com/Wa8Pm0SroM",
 "h5_url": "http://cps.51ping.com/DiwGXp556X"
 } ]
 }}
 */

@end
