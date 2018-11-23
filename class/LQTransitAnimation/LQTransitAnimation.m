//
//  LQTransitAnimation.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "LQTransitAnimation.h"

@interface LQTransitAnimation ()

@property (nonatomic, strong) UIView *originView;
@property (nonatomic, assign) LQTransitionType transitionType;
@property (nonatomic, assign) LQTransitAnimationType animateType;
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> currentContext;

@end
@implementation LQTransitAnimation

+ (instancetype) transitionWithType:(LQTransitionType) type animateType:(LQTransitAnimationType)animte originView:(UIView *)originView {
    
    LQTransitAnimation *tr = [[LQTransitAnimation alloc]initWithTransitionType:type animateType:animte originView:originView];
    
    return tr;
}

- (instancetype)initWithTransitionType:(LQTransitionType) type animateType:(LQTransitAnimationType)animte originView:(UIView *)originView {
    self = [super init];
    if (self) {
        
        self.originView = originView;
        self.transitionType = type;
        self.animateType = animte;
        
        switch (animte) {
            case LQTransitAnimationTypeCircle:
                self.duration = 0.6;
                break;
            case LQTransitAnimationTypeScale:
                self.duration = 1.0;
                break;
            default:
                self.duration = 0.0;
                break;
        }
    }
    
    return self ;
}
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return self.duration ;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.currentContext = transitionContext ;
    
    switch (self.transitionType) {
        case LQTransitionTypePush:
            [self push];
            break;
        case LQTransitionTypePop:
            [self pop];
            break;
        default:
            break;
    }
}

- (void)animationEnded:(BOOL) transitionCompleted {
    
}

- (void) push {
    
    switch (self.animateType) {
        case LQTransitAnimationTypeScale:
            [self presenting:self.currentContext];
            break;
        case LQTransitAnimationTypeCircle:
            [self circleOpenAnimate:self.currentContext];
            break;
        default:
            break;
    }
}

- (void) pop {
    
    switch (self.animateType) {
        case LQTransitAnimationTypeScale:
            [self presented:self.currentContext];
            break;
        case LQTransitAnimationTypeCircle:
            [self circleCloseAnimate:self.currentContext];
            break;
        default:
            break;
    }
}
#pragma mark - LQTransitAnimationTypeScale
- (void) presenting:(id<UIViewControllerContextTransitioning>) context {
    
    UIViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [context viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [context viewForKey:UITransitionContextToViewKey];
    
    CGRect toFrame = [context finalFrameForViewController:toVC];
    
    if (fromView == nil || toView == nil) {
        return;
    }
    
    UIView *containerView = context.containerView;
    [containerView addSubview:toView];
    
    toView.layer.cornerRadius = self.originView.layer.cornerRadius;
    toView.layer.masksToBounds = self.originView.layer.masksToBounds;
    toView.frame = [containerView convertRect:self.originView.frame fromView:self.originView.superview] ;
    
    self.originView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:context] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        toView.transform = CGAffineTransformIdentity;
        toView.frame = toFrame;
    } completion:^(BOOL finished) {
        
        toView.layer.cornerRadius = 0;
        toView.layer.masksToBounds = NO;
        
        if (finished && context.transitionWasCancelled == NO) {
            [context completeTransition:YES];
        } else {

            [toView removeFromSuperview];
            [context completeTransition:NO];
        }
    }];
}

- (void) presented:(id<UIViewControllerContextTransitioning>) context {

    UIView *fromView = [context viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [context viewForKey:UITransitionContextToViewKey];
    
    if (fromView == nil || toView == nil) {
        return;
    }
    
    UIView *containerView = context.containerView;
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:fromView];
    
    fromView.layer.cornerRadius = 8;
    fromView.layer.masksToBounds = YES;
    
    CGRect toFrame = [containerView convertRect:self.originView.frame fromView:self.originView.superview];
    [UIView animateWithDuration:[self transitionDuration:context] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveLinear) animations:^{
        
        fromView.frame = toFrame;
    } completion:^(BOOL finished) {
        
        if (finished && context.transitionWasCancelled == NO) {
            self.originView.hidden = NO;
            [context completeTransition:YES];
        } else {
            [context completeTransition:NO];
        }
    }];
}

#pragma mark - LQTransitAnimationTypeCircle
- (void) circleOpenAnimate:(id<UIViewControllerContextTransitioning>) context {
    
    UIViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    
    UIView *containView = [context containerView];
    
    [containView addSubview:fromView];
    [containView addSubview:toVC.view];
    
    UIView *animateView = toVC.view;
    CAShapeLayer *mask = [CAShapeLayer layer];
    
    animateView.layer.mask = mask;
    
    CGPoint animatePoint = CGPointMake(CGRectGetWidth(animateView.frame)/2.0, CGRectGetHeight(animateView.frame)/2.0);
    CGRect animateRect = CGRectMake(animatePoint.x - 1, animatePoint.y - 1, 1, 1);
    
    CGFloat startRadius = 10;
    CGRect startRect = CGRectInset(animateRect, -startRadius, -startRadius);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    mask.path = startPath.CGPath;
    
    CGFloat endRadius = sqrt(pow(CGRectGetWidth(animateView.frame) - animatePoint.x, 2) + pow(CGRectGetHeight(animateView.frame) - animatePoint.x, 2));
    CGRect endRect = CGRectInset(animateRect, -endRadius, -endRadius);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];

    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"path"];
    animate.duration = [self transitionDuration:context];
    animate.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animate.toValue = (__bridge id _Nullable)(endPath.CGPath) ;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animate.removedOnCompletion = YES;
    animate.delegate = self;
    [mask addAnimation:animate forKey:@"path"];
}

- (void) circleCloseAnimate:(id<UIViewControllerContextTransitioning>) context {
    
    UIViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [context containerView];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    
    UIView *animateView = fromVC.view;
    CAShapeLayer *mask = [CAShapeLayer layer];
    
    animateView.layer.mask = mask;
    
    CGPoint animatePoint = CGPointMake(CGRectGetWidth(animateView.frame)/2.0, CGRectGetHeight(animateView.frame)/2.0);
    CGRect animateRect = CGRectMake(animatePoint.x - 1, animatePoint.y - 1, 1, 1);
    
    CGFloat startRadius = 10;
    CGRect startRect = CGRectInset(animateRect, -startRadius, -startRadius);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:startRect];
    mask.path = startPath.CGPath;
    
    CGFloat endRadius = sqrt(pow(CGRectGetWidth(animateView.frame) - animatePoint.x, 2) + pow(CGRectGetHeight(animateView.frame) - animatePoint.x, 2));
    CGRect endRect = CGRectInset(animateRect, -endRadius, -endRadius);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"path"];
    animate.duration = [self transitionDuration:context];
    
    animate.fromValue = (__bridge id _Nullable)(endPath.CGPath);
    animate.toValue = (__bridge id _Nullable)(startPath.CGPath) ;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animate.removedOnCompletion = YES;
    animate.delegate = self;
    [mask addAnimation:animate forKey:@"path"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    UIView *toView = [self.currentContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [self.currentContext viewForKey:UITransitionContextFromViewKey];
    
    toView.layer.mask = nil;
    fromView.layer.mask = nil;
    [self.currentContext completeTransition:YES];
}

@end
