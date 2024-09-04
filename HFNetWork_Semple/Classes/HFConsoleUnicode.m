//
//  HFConsoleUnicode.m
//  HFNetWork
//
//  Created by liuhongfei on 2021/4/16.
//

#import "HFConsoleUnicode.h"
#import <objc/runtime.h>

static inline void LHF_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation HFConsoleUnicode

@end

@implementation NSString (BizUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (BizUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LHF_swizzleSelector(class, @selector(description), @selector(LHF_description));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LHF_descriptionWithLocale:));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LHF_descriptionWithLocale:indent:));
    });
}

- (NSString *)LHF_description {
    return [[self LHF_description] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale {
    return [[self LHF_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LHF_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (BizUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LHF_swizzleSelector(class, @selector(description), @selector(LHF_description));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LHF_descriptionWithLocale:));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LHF_descriptionWithLocale:indent:));
    });
}

- (NSString *)LHF_description {
    return [[self LHF_description] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale {
    return [[self LHF_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LHF_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (BizUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LHF_swizzleSelector(class, @selector(description), @selector(LHF_description));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LHF_descriptionWithLocale:));
        LHF_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LHF_descriptionWithLocale:indent:));
    });
}

- (NSString *)LHF_description {
    return [[self LHF_description] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale {
    return [[self LHF_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LHF_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LHF_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

