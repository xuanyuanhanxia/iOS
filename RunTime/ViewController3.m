//
//  ViewController3.m
//  RunTime
//
//  Created by 尚书威 on 2018/6/28.
//  Copyright © 2018年 尚书威. All rights reserved.
//

/*
 懒加载
    方法的懒加载：使用RunTime 为没有定义的方法添加实现,动态添加方法
 */

#import "ViewController3.h"
#import "Person.h"
@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc] init];
    /*
     Person 对象没有eat方法 但是我们可以在运行时动态添加eat方法
     */
//    [p performSelector:@selector(eat)];
    [p performSelector:@selector(eat1:) withObject:@"烧麦"];
}


@end
