//
//  ViewController.m
//  RunTime
//
//  Created by 尚书威 on 2018/5/8.
//  Copyright © 2018年 尚书威. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)saveInfo:(id)sender {
    Person *p = [[Person alloc] init];
    p.name = @"coder";
    p.age = 18;
    p.ID = @"1234567890";
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"person.data"];
    if ([NSKeyedArchiver archiveRootObject:p toFile:filePath]) {
        NSLog(@"保存成功");
    }
}
- (IBAction)readInfo:(id)sender {
    NSString *tempPath = NSTemporaryDirectory();
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"person.data"];
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"p.name=%@  p.age=%d  p.ID=%@",p.name,p.age,p.ID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
