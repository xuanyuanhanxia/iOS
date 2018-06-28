//
//  NSURL+SSURL.m
//  RunTime
//
//  Created by 尚书威 on 2018/5/8.
//  Copyright © 2018年 尚书威. All rights reserved.
//

#import "NSURL+SSURL.h"
#import <objc/runtime.h>
@implementation NSURL (SSURL)
/*
 文件预编译 发生在 程序主函数之前 所以load方法一旦交换方法的实现 工程通过selector调用方法时已经发生变化
 */
+ (void)load {
    //获取类方法 class_getClassMethod
    //获取对象方法 class_getInstanceMethod
    Method method1 = class_getClassMethod(self, @selector(URLWithString:));
    Method method2 = class_getClassMethod(self, @selector(SSURLWithString:));
    method_exchangeImplementations(method1,method2);
}

+ (NSURL *)SSURLWithString:(NSString *)string {
    //编译文件时方法交换已经完成 SSURLWithString的IMP 和 URLWithString的IMP已经交换 所以这里调用的是交换完成之后的方法
    NSURL *url = [NSURL SSURLWithString:string];
    if (url) {
        return url;
    }
    NSLog(@"url为nil");
    return nil;
}

@end
