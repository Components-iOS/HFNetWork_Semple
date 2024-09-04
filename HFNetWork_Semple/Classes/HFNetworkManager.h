//
//  HFNetworkManager.h
//  HFNetWork
//
//  Created by liuhongfei on 2021/4/16.
//

#import <AFNetworking/AFNetworking.h>

#define HttpTool [HFNetworkManager sharedInstance]

@interface HFNetworkManager : AFHTTPSessionManager

/// 单点登录下线通知
extern NSString *USERFOURCEKICKEDOUR;

/// 全局参数
@property (nonatomic, strong) NSDictionary *globalDict;
/// 用户登录参数
@property (nonatomic, strong) NSDictionary *userDict;
/// 单点登录状态码、外部设定
@property (nonatomic, copy) NSString *statusCode;

+ (instancetype)sharedInstance;

/// 发起 GET 请求
- (NSURLSessionDataTask *)GETRequest:(NSString *)URLString
                          parameters:(NSDictionary *)parameters
                          completion:(void (^)(id json, NSError *error))completion;

/// 发起 POST 请求
- (NSURLSessionDataTask *)POSTRequest:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                           completion:(void (^)(id json, NSError *error))completion;

@end
