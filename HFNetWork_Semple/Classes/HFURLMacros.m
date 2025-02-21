//
//  HFURLMacros.m
//  HFBase
//
//  Created by liuhongfei on 2021/4/16.
//

#import "HFURLMacros.h"

@implementation HFURLMacros

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static HFURLMacros *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)setBaseURL:(NSString *)baseURL {
    [[NSUserDefaults standardUserDefaults] setObject:baseURL forKey:@"baseURL"];
}

- (NSString *)baseURL {
    NSString *baseURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"baseURL"];
    return baseURL.length > 0 ? baseURL : @"";
}

@end
