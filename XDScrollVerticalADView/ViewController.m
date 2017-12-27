//
//  ViewController.m
//  XDScrollVerticalADView
//
//  Created by Celia on 2017/12/25.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "ViewController.h"
#import "XDScrollADView.h"
#import "ADCellModel.h"

#define SCWidth [[UIScreen mainScreen] bounds].size.width
#define SCHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    XDScrollADView *adView = [[XDScrollADView alloc] initWithFrame:CGRectMake(0, 100, SCWidth, 65)];
    
    adView.leftImageName = @"aaa.jpg";
    [self.view addSubview:adView];
    
    // 加两个数据模型
    ADCellModel *model1 = [[ADCellModel alloc] init];
    model1.topADTitle = @"原麦山丘 古早味、高纤奶酪 怎么这么好吃";
    model1.bottomADTitle = @"女孩子 多买好看衣服 少吃零食 真理！！";
    model1.topType = @"超赞";
    model1.bottomType = @"精华";
    model1.imageN = @"bbb.jpg";
    
    ADCellModel *model2 = [[ADCellModel alloc] init];
    model2.topADTitle = @"肚子一直瘦不下去的女生，这几点。。。";
    model2.bottomADTitle = @"长相一般的女生剪这个刘海";
    model2.topType = @"精华";
    model2.bottomType = @"超赞";
    model2.imageN = @"ccc.jpg";
    
    adView.dataArray = @[model1, model2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
