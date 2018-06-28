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

//实现自定义对象的归档 自定义对象应该遵守NSCoding协议，并实现 归档initWithCoder:和 接归档encodeWithCoder:协议方法

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


//(id self,SEL _cmd) 所有的C语言的函数里边 都有这两个隐式参数 只要调用，系统都会传递进来
void eat(id self,SEL _cmd){
    NSLog(@"调用了%@ 的%@方法",self,NSStringFromSelector(_cmd));
    NSLog(@"eat");
}

void eatWithParams(id self,SEL _cmd,id object) {
    NSLog(@"吃了%@",object);
}

//当这个类被调用了没有实现的方法 就会来到这里
//调用类方法未果
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"你没有实现 %@ 这个类方法",NSStringFromSelector(sel));
   
    return [super resolveClassMethod:sel];
}
//调用对象方法未果
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"你没有实现 %@ 这个对象方法",NSStringFromSelector(sel));
    /*
     第一个参数： 类类型 为那个类添加方法
     第二个参数： 添加的方法 方法编号
     第三个参数： 添加方法的实现 函数指针 强转下IMP类型
     第四个参数： 函数类型 c字符串 v->void @->id类型 :->SEL
     */
    if (sel == @selector(eat)) {
        class_addMethod([Person class], sel, (IMP)eat, "v@:");
    } else if (sel == @selector(eat1:)) {
        class_addMethod([Person class], sel, (IMP)eatWithParams, "v@:@");
    }
    return [super resolveInstanceMethod:sel];
}

@end
