//
//  UIViewController+LQPresentAnimate.h
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LQPresentAnimate)<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *originView;
@end
