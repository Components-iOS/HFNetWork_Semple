//
//  LoadStateProperty.m
//  HFNetWork
//
//  Created by liuhongfei on 2021/4/16.
//

#import "LoadStateProperty.h"

#define defaultNoDataImageKey         @"defaultNoDataImage"
#define defaultErrorImageKey          @"defaultErrorImageKey"
#define defaultNetworkFailImageKey    @"defaultNetworkFailImageKey"
#define defaultNoDataTitleKey         @"defaultNoDataTitleKey"
#define defaultErrorTitleKey          @"defaultErrorTitleKey"
#define defaultNetworkFailTitleKey    @"defaultNetworkFailTitleKey"

@interface LoadStateProperty ()

@property (nonatomic, strong) NSMutableDictionary *customerViewDictionary;

@end

@implementation LoadStateProperty

+ (instancetype)sharedInstance
{
    static LoadStateProperty *property;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        property = [[self alloc] init];
    });
    
    return property;
}

+ (void)setImageNoData:(UIImage *)noData error:(UIImage *)error network:(UIImage *)networkfail
{
    [[[self sharedInstance] customerViewDictionary] setObject:noData forKey:defaultNoDataImageKey];
    [[[self sharedInstance] customerViewDictionary] setObject:error forKey:defaultErrorImageKey];
    [[[self sharedInstance] customerViewDictionary] setObject:networkfail forKey:defaultNetworkFailImageKey];
}

+ (void)setTitleNoData:(NSString *)noData error:(NSString *)error network:(NSString *)networkfail
{
    [[[self sharedInstance] customerViewDictionary] setObject:noData forKey:defaultNoDataTitleKey];
    [[[self sharedInstance] customerViewDictionary] setObject:error forKey:defaultErrorTitleKey];
    [[[self sharedInstance] customerViewDictionary] setObject:networkfail forKey:defaultNetworkFailTitleKey];
}

+ (instancetype)defaultProperties
{
    LoadStateProperty *properties = [[LoadStateProperty alloc] init];
    return properties;
}

- (void)setText:(NSString *)text forLoadState:(HFViewState)loadState
{
    if (text)
    {
        [self.customerViewDictionary setObject:text forKey:[NSString stringWithFormat:@"text_%@",@(loadState)]];
    }
}

- (NSString *)textForState:(HFViewState)loadState
{
    NSString *text = [self.customerViewDictionary objectForKey: [NSString stringWithFormat:@"text_%@",@(loadState)]];
    if (text == nil) {
        switch (loadState) {
            case HFViewStateNoData:
                text = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultNoDataTitleKey];
                break;
            case HFViewStateError:
                text = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultErrorTitleKey];
                break;
            default:
                text = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultNetworkFailTitleKey];
                break;
        }
    }
    return text;
}

- (void)setDetail:(NSString *)text forLoadState:(HFViewState)loadState
{
    if (text) {
        [self.customerViewDictionary setObject:text forKey:[NSString stringWithFormat:@"detail_%@",@(loadState)]];
    }
}

- (NSString *)detailForState:(HFViewState)loadState
{
    NSString *text = [self.customerViewDictionary objectForKey: [NSString stringWithFormat:@"detail_%@",@(loadState)]];
    if (text == nil) {
        switch (loadState) {
            default:
                text = @"";
                break;
        }
    }
    return text;
}

- (void)setImage:(UIImage *)image forLoadState:(HFViewState)loadState
{
    if (image) {
        [self.customerViewDictionary setObject:image forKey: [NSString stringWithFormat:@"img_%@",@(loadState)]];
    }
}

- (UIImage *)imageForState:(HFViewState)loadState
{
    UIImage *img = [self.customerViewDictionary objectForKey: [NSString stringWithFormat:@"img_%@",@(loadState)]];
    if (img == nil) {
        switch (loadState) {
            case HFViewStateNoData:
                img = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultNoDataImageKey];
                break;
            case HFViewStateError:
                img = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultErrorImageKey];
                break;
            case HFViewStateNetworkFail:
                img = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultNetworkFailImageKey];
                break;
            default:
                img = [[[LoadStateProperty sharedInstance] customerViewDictionary] valueForKey:defaultErrorImageKey];
                break;
        }
    }
    return img;
}

- (void)setCustomerView:(UIView *)view forLoadState:(HFViewState)loadState
{
    if (view) {
        [self.customerViewDictionary setObject:view forKey:@(loadState)];
    }
}

- (UIView *)customerViewForLoadState:(HFViewState)loadState
{
    return [self.customerViewDictionary objectForKey:@(loadState)];
}

- (NSMutableDictionary *)customerViewDictionary
{
    if (!_customerViewDictionary) {
        _customerViewDictionary = [NSMutableDictionary dictionaryWithCapacity:15];
    }
    return _customerViewDictionary;
}

@end
