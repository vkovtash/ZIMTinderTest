//
//  UIView+ZIMHideAnimated.m
//  ZIMTinderTest
//
//  Created by kovtash on 08.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import "UIView+ZIMHideAnimated.h"


static const NSTimeInterval ZIMViewAnimationDuration = 0.5;
static NSString *const ZIMOpacityAnimationKey = @"ZIMOpacityAnimationKey";
static NSString *const ZIMTransformAnimationKey = @"ZIMTransformAnimationKey";


@implementation UIView (ZIMHideAnimated)

- (void)zim_setHidden:(BOOL)isHidded animated:(BOOL)animated completion:(void(^)(BOOL finished))completion {
    if (isHidded) {
        [self zim_hideAnimated:animated completion:completion];
    }
    else {
        [self zim_showAnimated:animated completion:completion];
    }
}

- (void)zim_showAnimated:(BOOL)animated completion:(void(^)(BOOL finished))completion {
    if (!self.isHidden) {
        return;
    }
    
    self.hidden = NO;
    
    if (!animated) {
        completion(YES);
        return;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        completion(YES);
        [self.layer removeAnimationForKey:ZIMOpacityAnimationKey];
        [self.layer removeAnimationForKey:ZIMTransformAnimationKey];
    }];
    
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:ZIMViewAnimationDuration];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    opacityAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 1.0)];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:opacityAnimation forKey:ZIMOpacityAnimationKey];
    [self.layer addAnimation:transformAnimation forKey:ZIMTransformAnimationKey];
    [CATransaction commit];
}

- (void)zim_hideAnimated:(BOOL)animated completion:(void(^)(BOOL finished))completion {
    if (self.isHidden) {
        return;
    }
    
    void (^animationCompletionBlock)(BOOL finished) = ^(BOOL finished) {
        self.hidden = YES;
        completion(finished);
    };
    
    if (!animated) {
        animationCompletionBlock(YES);
        return;
    }
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        animationCompletionBlock(YES);
        [self.layer removeAnimationForKey:ZIMOpacityAnimationKey];
        [self.layer removeAnimationForKey:ZIMTransformAnimationKey];
    }];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [CATransaction setAnimationDuration:ZIMViewAnimationDuration];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0);
    opacityAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 1.0)];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:opacityAnimation forKey:ZIMOpacityAnimationKey];
    [self.layer addAnimation:transformAnimation forKey:ZIMTransformAnimationKey];
    [CATransaction commit];
}

@end
