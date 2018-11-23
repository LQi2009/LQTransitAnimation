//
//  UIView+LQPanScale.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/23.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "UIView+LQPanScale.h"

static CGPoint __startPoint ;
static CGFloat __viewScale ;
static LQPanToScaleViewHandler __actionHandler ;
@implementation UIView (LQPanScale)

- (void) panToScaleViewWithHandler:(LQPanToScaleViewHandler) handler {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    __actionHandler = handler ;
}

- (void) panGestureAction:(UIPanGestureRecognizer *) pan {
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            __startPoint = [pan locationInView:self];
            self.layer.cornerRadius = 8;
            self.layer.masksToBounds = YES;
            break;
        case UIGestureRecognizerStateChanged:{
            
            CGPoint point = [pan locationInView:self];
            __viewScale = 1 - (point.y - __startPoint.y) / CGRectGetHeight(self.frame) ;
            
            self.transform = CGAffineTransformMakeScale(__viewScale, __viewScale);
            if (__viewScale <= 0.9) {
                self.transform = CGAffineTransformIdentity ;
                if (__actionHandler) {
                    __actionHandler();
                }
            }
        }
            break;
        default:
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveLinear) animations:^{
                
                self.transform = CGAffineTransformIdentity ;
            } completion:^(BOOL finished) {
                self.layer.cornerRadius = 0;
            }];
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]] || [otherGestureRecognizer.view isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    return NO;
}
@end
