//
//  MTHomeCollectionVC.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/17.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTHomeCellModel;
@interface MTHomeCollectionVC : UICollectionViewController
@property (nonatomic,strong) NSMutableArray <MTHomeCellModel *> *modelArray;
//@property (nonatomic,assign) BOOL hiddenNoDataImage;
@end
