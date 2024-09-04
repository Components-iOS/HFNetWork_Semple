//
//  UIView+LoadState.h
//  HFNetWork
//
//  Created by liuhongfei on 2021/4/16.
//

typedef NS_ENUM(NSInteger, HFViewState) {
    HFViewStateDefault = 0,  // 空白显示
    HFViewStateLoading,      // 起始加载状态，一个indicatorView在中间
    HFViewStateNoData,       // 无数据状态
    HFViewStateNetworkFail,  // 无网络状态
    HFViewStateError         // 其他错误
};

/*
 一行代码设置加载状态
 self.view.currentLoadingState = LQViewState;
 或 self.tableView.currentLoadingState = LQViewState;
 
 其它可设置属性，可在loadingStateProperties设置
 加载区域为self 的父类bounds
 并将加载view加入到self的superview子视图
 */

#import <UIKit/UIKit.h>

@class LoadStateProperty;

@interface UIView (LoadState)

@property (nonatomic) HFViewState viewState;
@property (nonatomic, readonly) LoadStateProperty *stateProperties;

- (void)setStateWithError:(NSError *)error;
- (void)setStateWithArray:(NSArray *)list Error:(NSError *)error;

@end
