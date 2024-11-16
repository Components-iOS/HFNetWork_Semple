//
//  HFNetworkManager.m
//  HFNetWork
//
//  Created by liuhongfei on 2021/4/16.
//

#import "HFNetworkManager.h"
#import "HFURLMacros.h"

@interface HFNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation HFNetworkManager

+ (instancetype)sharedInstance {
    static HFNetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

/// 设置域名
- (void)setBaseURL:(NSString *)baseURL {
    HFURLMacros.sharedInstance.baseURL = baseURL;

    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    self.sessionManager.requestSerializer.timeoutInterval = 60;
    // 设置相应的解析格式
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/json", @"text/html", @"text/javascript", @"application/octet-stream", nil];
}

/// 获取当前HTTPSessionManager
- (AFHTTPSessionManager *)getSessionManager {
    return self.sessionManager;
}

/// 发起 GET 请求
- (NSURLSessionDataTask *)GETRequest:(NSString *)URLString
                          parameters:(NSDictionary *)parameters
                          completion:(void (^)(id json, NSError *error))completion {
    NSMutableDictionary *parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parametersM addEntriesFromDictionary:[self globalParmsWithNeedUserInfo:YES]];
    
    if (parametersM != nil) {
        for (NSString *httpHeaderField in parametersM.allKeys) {
            NSString *value = parametersM[httpHeaderField];
            [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }

    return [self.sessionManager GET:URLString parameters:parametersM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.isCanLog) {
            [self showLogWith:task parameters:parameters];
        }
    
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

/// 发起 POST 请求
- (NSURLSessionDataTask *)POSTRequest:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                           completion:(void (^)(id json, NSError *error))completion {
    NSMutableDictionary *parametersM = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parametersM addEntriesFromDictionary:[self globalParmsWithNeedUserInfo:YES]];
    
    if (parametersM != nil) {
        for (NSString *httpHeaderField in parametersM.allKeys) {
            NSString *value = parametersM[httpHeaderField];
            [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    return [self.sessionManager POST:URLString parameters:parametersM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.isCanLog) {
            [self showLogWith:task parameters:parameters];
        }
        
        completion(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

/// 全局参数
- (NSDictionary *)globalParmsWithNeedUserInfo:(BOOL)isNeedInfo {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters addEntriesFromDictionary:self.globalDict];
    [parameters addEntriesFromDictionary:self.userDict];
    
    return parameters;
}

- (void)showLogWith:(NSURLSessionDataTask *)task parameters:(NSDictionary *)parameters  {
    NSLog(@"===== URL = %@",task.originalRequest.URL);
    NSLog(@"----- HTTPMethod = %@",task.originalRequest.HTTPMethod);
    NSLog(@"----- HTTPBody = %@",parameters);
    NSLog(@"----- allHTTPHeaderFields = %@",task.originalRequest.allHTTPHeaderFields);
}

@end
