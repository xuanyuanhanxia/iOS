//
//  ViewController2.m
//  RunTime
//
//  Created by 尚书威 on 2018/5/8.
//  Copyright © 2018年 尚书威. All rights reserved.
//

#import "ViewController2.h"
#import "NSURL+SSURL.h"
@interface ViewController2 ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController2
/*
 系统的URLWithString方法 是不会判断string中是否有中文
 一旦出现中文，返回为空，就加载不出来webview
 所以，为了判断url是否为空，我们可以使用RunTime实现方法交换
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"https://www.baidu.com/";
    NSString *string1 = @"https://www.baidu.com/中国";
    NSURL *url = [NSURL URLWithString:string1];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
}

@end
