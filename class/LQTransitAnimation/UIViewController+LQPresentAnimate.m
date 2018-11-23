//
//  UIViewController+LQPresentAnimate.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "UIViewController+LQPresentAnimate.h"
#import "LQTransitAnimation.h"
#import <objc/runtime.h>

static const char LQPresentAnimateOrginViewKey = '1';

@implementation UIViewController (LQPresentAnimate)

- (UIView *)originView {
    
    return objc_getAssociatedObject(self, &LQPresentAnimateOrginViewKey);
}

- (void)setOriginView:(UIView *)originView {
    
    objc_setAssociatedObject(self, &LQPresentAnimateOrginViewKey, originView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [LQTransitAnimation transitionWithType:(LQTransitionTypePush) animateType:(LQTransitAnimationTypeScale) originView:self.originView];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [LQTransitAnimation transitionWithType:(LQTransitionTypePop) animateType:(LQTransitAnimationTypeScale) originView:self.originView];
}


@end

