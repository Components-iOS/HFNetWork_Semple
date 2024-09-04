//
//  HFURLMacros.h
//  HFBase
//
//  Created by liuhongfei on 2021/4/16.
//

#import <Foundation/Foundation.h>

@interface HFURLMacros : NSObject

+ (instancetype)sharedInstance;

/// APP启动需要指定的域名
@property (nonatomic, copy) NSString *baseURL;

@end
