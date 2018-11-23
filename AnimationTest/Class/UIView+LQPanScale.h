//
//  UIView+LQPanScale.h
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/23.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//
// 滑动缩小视图，当缩小到一定程度，触发回调事件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LQPanToScaleViewHandler)(void);
@interface UIView (LQPanScale)<UIGestureRecognizerDelegate>

- (void) panToScaleViewWithHandler:(LQPanToScaleViewHandler) handler ;
@end

NS_ASSUME_NONNULL_END
