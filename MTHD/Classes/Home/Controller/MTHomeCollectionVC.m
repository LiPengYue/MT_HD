//
//  MTHomeCollectionVC.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "MTHomeCollectionVC.h"
#import "UIBarButtonItem+MTCategory.h"
#import "MTHomeCell.h"
#import "MJRefresh.h"


@interface MTHomeCollectionVC ()
@property (nonatomic,strong) UIImageView *noDataImage;
@end

@implementation MTHomeCollectionVC {
    int _itemNum_erect;//竖屏的item个数
    int _itemNum_horizontal;//横屏itme的个数
    
    CGFloat _itemMagen_erect;//竖屏的间距
    CGFloat _itemMagen_horizontal;//横屏的间距
    CGFloat _itemSizeW;
    CGFloat _itemSizeH;
    
}

static NSString * const CELLID = @"CELLID";


- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _itemNum_erect = 2;//竖屏个数
        _itemNum_horizontal = 3;//竖屏的个数
        _itemSizeW = 305;//item 宽
        _itemSizeH = 305;//item高
        self = [self initWithCollectionViewLayout:flowLayout];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    //集成MJRefresh
//    [self setupRefresh];
}

#pragma mark - 搭建UI界面
- (void)setupUI{
    self.collectionView.backgroundColor = MTColor(222, 222, 222);
    
    //这里不能在View上面加 view 只能在collctionView里面
    [self.view addSubview:self.noDataImage];
    [self.noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    //因为用了self.View 了所以懒加载的view 已经创建
    self.modelArray = [[NSMutableArray alloc]init];

    //注册
    [self.collectionView registerClass:[MTHomeCell class] forCellWithReuseIdentifier:CELLID];
    
    //强调用一波将要横竖屏的方法
    [self viewWillTransitionToSize:CGSizeMake(kScreenW, kScreenH) withTransitionCoordinator:self.transitionCoordinator];
}


#pragma mark - 将要横屏竖屏

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
//    NSLog(@"%f===%f",kScreenW,size.width);
    
    //MARK: 这个方法是说将要旋转的时候，现在还没有旋转 所以屏幕的宽还是没有旋转的时候的宽，而size是旋转后的屏幕的宽度
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    //计算横屏竖屏的
    
    //设置大小 item
    layout.itemSize = CGSizeMake(_itemSizeW, _itemSizeH);
    
    //判断横竖屏
    if (size.height > size.width) {//竖屏
        //竖屏的间距
        _itemMagen_erect = (size.width - (_itemNum_erect * _itemSizeW)) / (_itemNum_erect + 1);
        
        layout.sectionInset = UIEdgeInsetsMake(_itemMagen_erect, _itemMagen_erect, _itemMagen_erect, _itemMagen_erect);
        layout.minimumLineSpacing = _itemMagen_erect;
    }else {
        //横屏的间距
        _itemMagen_horizontal = (size.width - (_itemNum_horizontal * _itemSizeW)) / (_itemNum_horizontal + 1);
        layout.sectionInset = UIEdgeInsetsMake(_itemMagen_horizontal, _itemMagen_horizontal, _itemMagen_horizontal, _itemMagen_horizontal);
        layout.minimumLineSpacing = _itemMagen_horizontal;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - model数据源
- (void)setModelArray:(NSMutableArray<MTHomeCellModel *> *)modelArray{
    _modelArray = modelArray;
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (UIImageView *)noDataImage {
    if (!_noDataImage) {
        _noDataImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        _noDataImage.hidden = false;
    }
    return _noDataImage;
}

#pragma mark - 是否隐藏noDataImage
-(void)setHiddenNoDataImage:(BOOL)hiddenNoDataImage{
    _hiddenNoDataImage = hiddenNoDataImage;
    self.noDataImage.hidden = false;
}

@end









