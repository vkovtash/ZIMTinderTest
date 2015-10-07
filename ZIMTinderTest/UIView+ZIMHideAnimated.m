//
//  UIView+ZIMHideAnimated.m
//  ZIMTinderTest
//
//  Created by kovtash on 08.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import "UIView+ZIMHideAnimated.h"

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
    
    void(^animationBlock)() = ^{
        self.hidden = NO;
        self.alpha = 1.;
    };
    
    if (animated) {
        self.alpha = 0.;
        [UIView animateWithDuration:0.25 animations:animationBlock completion:completion];
    }
    else {
        animationBlock();
        completion(YES);
    }
}

- (void)zim_hideAnimated:(BOOL)animated completion:(void(^)(BOOL finished))completion {
    if (self.isHidden) {
        return;
    }
    
    void(^animationBlock)() = ^{
        self.alpha = 0.;
    };
    
    void (^animationCompletionBlock)(BOOL finished) = ^(BOOL finished) {
        self.hidden = YES;
        self.alpha = 1.;
        completion(finished);
    };
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:animationBlock completion:animationCompletionBlock];
    }
    else {
        animationBlock();
        animationCompletionBlock(YES);
    }
}

@end
