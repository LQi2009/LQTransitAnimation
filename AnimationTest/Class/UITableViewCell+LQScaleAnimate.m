//
//  UITableViewCell+LQScaleAnimate.m
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import "UITableViewCell+LQScaleAnimate.h"

@implementation UITableViewCell (LQScaleAnimate)


- (void) startAnimate {
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

- (void) endAnimate {
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}
@end
