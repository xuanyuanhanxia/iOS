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
    Ivar *list = class_copyIvarList(Person.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
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
