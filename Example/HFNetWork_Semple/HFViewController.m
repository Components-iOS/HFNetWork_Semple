//
//  HFViewController.m
//  HFNetWork_Semple
//
//  Created by liuhongfei on 09/14/2021.
//  Copyright (c) 2021 liuhongfei. All rights reserved.
//

#import "HFViewController.h"
#import <HFNetWork_Semple/HFURLMacros.h>
#import <HFNetWork_Semple/HFNetworkManager.h>
#import <UIView+LoadState.h>
#import <LoadStateProperty.h>

@interface HFViewController ()

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [HttpTool setBaseURL:@"https://apinext-qa.bizvideo.cn"];
    
    [self loadData];
}

- (void)loadData {
    self.view.viewState = HFViewStateLoading;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    [HttpTool GETRequest:@"/appapi/getAppConfiguration" parameters:parameters completion:^(id json, NSError *error) {
        NSLog(@"%@",json);
        self.view.viewState = HFViewStateDefault;
    }];
}

@end
