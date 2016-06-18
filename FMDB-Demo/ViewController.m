//
//  ViewController.m
//  FMDB-Demo
//
//  Created by zhangbin on 16/6/18.
//  Copyright © 2016年 zhangbin. All rights reserved.
//

#import "ViewController.h"
#import "ZBModel.h"
#import "ZBModelTool.h"
#import "FMDB.h"

@interface ViewController ()
@property(nonatomic,strong)FMDatabase *db1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 向数据库中插入数据
    [self Insert];

    // 向数据库中查询数据
    [self Query];
    
    // 向数据库中删除数据
    [self Delete];
  }

 // 向数据库中插入数据
-(void)Insert{
    
    // 利用for循环+SQL语句实现向User数据库中    插入100条数据
    for (int i = 0; i < 100; i++) {
        ZBModel *model = [[ZBModel alloc] init];
        model.name = [NSString stringWithFormat:@"%d",i+1];
        // arc4random()%800,这个随机数函数得到的结果为0-800
        model.sight = arc4random() % 800;
        [ZBModelTool InsertData:model];
    }
    NSLog(@"调用Insert方法,插入了100条数据");
}

// 向数据库中查询数据
-(void)Query{
    
    // 保证只执行一次代码块中的内容，这样只有第一次调用Query方法时，才会输入代码块中的内容，第二次调用,不在执行代码块
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"调用Query方法,查询到了此时数据库中的数据，如下所示");
    });
    // 取出User数据库的t_User表中所有的数据，放到AllDataFromTable保存
    NSArray *AllDataFromTable = [ZBModelTool Models];
    // 遍历AllDataFromTable保存的数据，放到ZBModel的模型对象中保存
    for (ZBModel  *model in AllDataFromTable) {
        // 根据属性，取出模型中属性对应的数据，然后打印对应的数据
        NSLog(@"我的第%@个小弟, 视力为%f度",model.name,model.sight);
    }
}
// 向数据库中删除数据
-(void)Delete{
    NSLog(@"调用Delete方法,根据输入的条件,删除数据库中指定的数据");
    // 删除数据库中sight不为2200的数据，留下sight为2200的数据,如果没有满足的条件，数据库中的数据就全部删除
    // [ZBModelTool DeleteDate:2200 Cal:@"!="];
    
    // 删除数据库中sight小于2200的数据，留下sight大于等于2200的数据,如果没有满足的条件，数据库中的数据就全部删除
     [ZBModelTool DeleteDate:200 Cal:@"<"];

    [self Query];
    
    
}

@end
