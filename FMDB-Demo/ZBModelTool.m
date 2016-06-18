//
//  ZBModelTool.m
//  FMDB
//
//  Created by zhangbin on 16/6/18.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import "ZBModelTool.h"
#import "FMDB.h"
#import "ZBModel.h"

@implementation ZBModelTool

static FMDatabase *db;

+(void)initialize{
    // 拼接User.sqlist文件的全路径
    NSString *FilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"User1.sqlite"];
    NSLog(@"数据库的存储路径 %@",FilePath);
     db = [FMDatabase databaseWithPath:FilePath];
    // 1.打开数据库(连接数据库)
    [db open];
    NSLog(@"打开数据库成功");
    // 2.创建t_User表
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_User (id integer PRIMARY KEY, name text NOT NULL, sight real);"];
}

+(NSArray *)Models{
    // 得到结果集(得到t_User表中所有的数据)
    FMResultSet *set = [db executeQuery:@"SELECT * FROM t_User;"];
    // 调用FMResultSet中的next方法来一个一个的取出结果集中的数据
    NSMutableArray *ContainModels = [NSMutableArray array];
    while (set.next) {
        // 获得当前所指向的数据
        ZBModel *model = [[ZBModel alloc] init];
        //  注意用string调用
        model.name = [set stringForColumn:@"name"];
        // 注意用double调用
        model.sight = [set doubleForColumn:@"sight"];
        [ContainModels addObject:model];
    }
    return ContainModels;
}
// 插入数据到数据库User中
+(void)InsertData:(ZBModel *)model{
    // 将插入的数据进行格式化为c语言能识别的代码,需要用到executeUpdateWithFormat
    [db executeUpdateWithFormat:@"INSERT INTO t_User(name, sight) VALUES (%@, %f);",model.name,model.sight];
    

}
// 删除数据库User中的指定数据
+(void)DeleteDate:(float)DelData Cal:(NSString *)cal{
if([cal isEqualToString:@">"]){
     [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight > %f;",DelData];
    }else if([cal isEqualToString:@"<"]){
    [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight < %f;",DelData];
    }else if([cal isEqualToString:@"="]){
    [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight < %f;",DelData];
    }else if([cal isEqualToString:@">="]){
    [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight >= %f;",DelData];
    }else if([cal isEqualToString:@"<="]){
    [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight <= %f;",DelData];
    }else if([cal isEqualToString:@"!="]){
    [db executeUpdateWithFormat:@"DELETE FROM t_User WHERE sight != %f;",DelData];
    }else{
     NSLog(@"输入的符号错误");
    }
    // 删除指定数据，显示当前数据库中满足条件的数据
    FMResultSet *set = [db executeQuery:@"SELECT * FROM t_User;"];
    NSMutableArray *ContainModels111 = [NSMutableArray array];
    while (set.next) {
     // 获得当前所指向的数据
     ZBModel *model = [[ZBModel alloc] init];
     //  注意用string调用
     model.name = [set stringForColumn:@"name"];
     // 注意用double调用
     model.sight = [set doubleForColumn:@"sight"];
      [ContainModels111 addObject:model];
    }
    if(ContainModels111.count == 0){
    NSLog(@"你输入的条件是:删除%@%f的数据,所以数据都被你删除了",cal,DelData);
    }else{
    NSLog(@"你输入的条件是:删除%@%f的数据,此时数据库中剩余的数据如下:",cal,DelData);
    }
        
}
@end
