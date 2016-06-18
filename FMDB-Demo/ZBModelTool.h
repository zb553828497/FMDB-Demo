//
//  ZBModelTool.h
//  FMDB
//
//  Created by zhangbin on 16/6/18.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBModel;

@interface ZBModelTool : NSObject
+(NSArray *)Models;
+(void)InsertData:(ZBModel *)model;
+(void)DeleteDate:(float )DelData Cal:(NSString *)cal;
@end
