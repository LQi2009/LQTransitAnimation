//
//  UIViewController+LQPush.h
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/23.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LQPush)<UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *originView;
@end

NS_ASSUME_NONNULL_END
