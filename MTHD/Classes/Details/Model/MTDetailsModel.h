//
//  MTDetailsModel.h
//  MTHD
//
//  Created by 李鹏跃 on 16/12/24.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTHomeCellModel.h"
#import "MTDetails_Is_popular.h"
@interface MTDetailsModel : MTHomeCellModel
@property (nonatomic,strong) MTDetails_Is_popular *is_popularModel;
@end
