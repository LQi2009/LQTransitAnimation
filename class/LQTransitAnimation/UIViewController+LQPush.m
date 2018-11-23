//
//  UIViewController+LQPush.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/23.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "UIViewController+LQPush.h"
#import "LQTransitAnimation.h"
#import <objc/runtime.h>

static const char LQPresentAnimateOrginViewKey = '1';

@implementation UIViewController (LQPush)

- (UIView *)originView {
    
    return objc_getAssociatedObject(self, &LQPresentAnimateOrginViewKey);
}

- (void)setOriginView:(UIView *)originView {
    
    objc_setAssociatedObject(self, &LQPresentAnimateOrginViewKey, originView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        return [LQTransitAnimation transitionWithType:(LQTransitionTypePush) animateType:(LQTransitAnimationTypeCircle) originView:self.originView];
    } else if (operation == UINavigationControllerOperationPop) {
        
        return [LQTransitAnimation transitionWithType:(LQTransitionTypePop) animateType:(LQTransitAnimationTypeCircle) originView:self.originView];
    }
    
    return nil;
}


@end
