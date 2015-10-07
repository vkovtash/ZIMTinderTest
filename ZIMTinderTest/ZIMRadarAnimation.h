//
//  ZIMRadarAnimation.h
//  ZIMTinderTest
//
//  Created by kovtash on 06.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZIMRadarAnimation : NSObject
@property (assign, nonatomic) NSUInteger circleCount;
@property (assign, nonatomic) NSTimeInterval duration;
@property (assign, nonatomic) CGFloat fromScale;
@property (assign, nonatomic) CGFloat toScale;
@property (assign, nonatomic) CGFloat fromOpacity;
@property (assign, nonatomic) CGFloat toOpacity;
@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *strokeColor;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (void)startAnimationInView:(UIView *)view;
- (void)stopAnimationInView:(UIView *)view;

- (CAShapeLayer *)newShapeLayer;
- (CABasicAnimation *)newPathAnimationInRect:(CGRect)rect;
- (CABasicAnimation *)newOpacityAnimation;
@end


@interface UIView(ZIMRadarAnimation)
- (void)zim_startRadarAnimation;
- (void)zim_startRadarAnimation:(ZIMRadarAnimation *)animation;
- (void)zim_stopRadarAnimation;
@end
