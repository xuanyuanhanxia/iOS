//
//  Person.h
//  RunTime
//
//  Created by 尚书威 on 2018/5/8.
//  Copyright © 2018年 尚书威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *ID;
@end
