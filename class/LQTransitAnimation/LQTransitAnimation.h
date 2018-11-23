//
//  LQTransitAnimation.h
//  AnimationTest
//
//  Created by LiuQiqiang on 2018/11/21.
//  Copyright © 2018 LiuQiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 转场动画的类型
 
 LQTransitAnimationTypeCircle 圆形展开/关闭
 LQTransitAnimationTypeScale 类似App Store首页转场动画
*/
typedef enum : NSUInteger {

    LQTransitAnimationTypeCircle,
    LQTransitAnimationTypeScale,
} LQTransitAnimationType;

/** 转场操作
 
 LQTransitionTypePush push/present操作
 LQTransitionTypePop pop/dismiss操作
 */
typedef enum : NSUInteger {
    
    LQTransitionTypePush,
    LQTransitionTypePop,
} LQTransitionType;

NS_ASSUME_NONNULL_BEGIN

@interface LQTransitAnimation : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, assign) NSTimeInterval duration;
/**
 类方法创建动画实例

 @param type 转场类型
 @param animte 转场动画类型
 @param originView 转场时需携带的视图，使用 LQTransitAnimationTypeScale 需要赋值
 @return 转场动画实例
 */
+ (instancetype) transitionWithType:(LQTransitionType) type
                        animateType:(LQTransitAnimationType)animte
                         originView:(UIView * __nullable)originView ;
/**
 创建动画实例
 
 @param type 转场类型
 @param animte 转场动画类型
 @param originView 转场时需携带的视图，使用 LQTransitAnimationTypeScale 需要赋值
 @return 转场动画实例
 */
- (instancetype)initWithTransitionType:(LQTransitionType) type
                           animateType:(LQTransitAnimationType)animte
                            originView:(UIView * __nullable)originView  ;
@end

NS_ASSUME_NONNULL_END
