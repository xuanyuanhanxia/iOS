//
//  Person.m
//  RunTime
//
//  Created by 尚书威 on 2018/5/8.
//  Copyright © 2018年 尚书威. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    //获取Person类属性数组指针 因为是C语言的copy方法 所以要在循环结束free掉
    Ivar *list = class_copyIvarList(Person.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        //获取属性名称
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        //根据属性名称获取属性值
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    //释放堆内存 否则会内存泄露
    free(list);
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *list = class_copyIvarList(Person.class, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = list[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(list);
    }
    return self;
}


@end
