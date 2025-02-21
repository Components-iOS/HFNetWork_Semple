//
//  HFViewController.m
//  HFNetWork_Semple
//
//  Created by liuhongfei on 09/14/2021.
//  Copyright (c) 2021 liuhongfei. All rights reserved.
//

#import "HFViewController.h"
#import <HFNetWork_Semple/HFURLMacros.h>
#import <HFNetWork_Semple/HFNetWork_Semple-Swift.h>
#import <UIView+LoadState.h>
#import <LoadStateProperty.h>

@interface HFViewController ()

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [HFNetworkManager_Swift.sharedInstance setBaseURLWithBaseURL:@"https://apinext-qa.bizvideo.cn"];
    
    [self loadData];
}

- (void)loadData {
    self.view.viewState = HFViewStateLoading;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [HFNetworkManager_Swift.sharedInstance GETRequestWithURLString:@"/appapi/getAppConfiguration" parameters:parameters completion:^(id _Nullable json, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", json);
        }
        self.view.viewState = HFViewStateDefault;
    }];
}

@end
