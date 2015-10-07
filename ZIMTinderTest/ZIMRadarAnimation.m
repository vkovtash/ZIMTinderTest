//
//  ZIMRadarAnimation.m
//  ZIMTinderTest
//
//  Created by kovtash on 06.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import "ZIMRadarAnimation.h"


static NSString *const ZIMRadarAnimationKey = @"ZIMRadarAnimationKey";
static const CGFloat ZIMRadarLayerZPosition = -1000.f;

static void stopRadarAnimationInView(UIView *view) {
    //Should copy sublayers array to prevent accidentaly crashes
    for (CALayer *layer in [view.layer.sublayers copy]) {
        if ([layer animationForKey:ZIMRadarAnimationKey]) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
}


#pragma mark - ZIMRadarAnimation

@implementation ZIMRadarAnimation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self zim_privateDefaultConfig];
    }
    return self;
}

#pragma mark - Private Methods

- (void)zim_privateDefaultConfig {
    _circleCount = 2;
    _duration = 3;
    _fromScale = 1.;
    _toScale = 3.;
    _fromOpacity = 0.7;
    _toOpacity = 0.;
    _lineWidth = 2;
    _fillColor = [UIColor colorWithHue:0.615 saturation:0.55 brightness:0.85 alpha:1];
    _strokeColor = [UIColor colorWithHue:0.615 saturation:0.55 brightness:0.65 alpha:1];
}

#pragma mark - Public Methods

- (CAShapeLayer *)newShapeLayer {
    CAShapeLayer *shape = [CAShapeLayer new];
    shape.fillColor = self.fillColor.CGColor;
    shape.strokeColor = self.strokeColor.CGColor;
    shape.lineWidth = self.lineWidth;
    shape.zPosition = ZIMRadarLayerZPosition;
    return shape;
}

- (CABasicAnimation *)newPathAnimationInRect:(CGRect)rect {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    CGFloat fromScale = self.fromScale;
    CGFloat toScale = self.toScale;
    
    CGRect fromBounds = rect;
    fromBounds.size.width *= fromScale;
    fromBounds.size.height *= fromScale;
    fromBounds.origin.x = (rect.size.width - fromBounds.size.width) / 2;
    fromBounds.origin.y = (rect.size.height - fromBounds.size.height) / 2;
    
    CGRect toBounds = rect;
    toBounds.size.width *= toScale;
    toBounds.size.height *= toScale;
    toBounds.origin.x = (rect.size.width - toBounds.size.width) / 2;
    toBounds.origin.y = (rect.size.height - toBounds.size.height) / 2;
    
    pathAnimation.fromValue = (id)[UIBezierPath bezierPathWithOvalInRect:fromBounds].CGPath;
    pathAnimation.toValue = (id)[UIBezierPath bezierPathWithOvalInRect:toBounds].CGPath;
    return pathAnimation;
}

- (CABasicAnimation *)newOpacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(self.fromOpacity);
    opacityAnimation.toValue = @(self.toOpacity);
    return opacityAnimation;
}

- (void)addRadarLayerToView:(UIView *)view offsetFraction:(CGFloat)offsetFraction {
    CGRect rect = view.bounds;
    
    CAShapeLayer *radarLayer = [self newShapeLayer];
    radarLayer.bounds = rect;
    radarLayer.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
    radarLayer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [view.layer addSublayer:radarLayer];
    
    CABasicAnimation *pathAnimation = [self newPathAnimationInRect:rect];
    CABasicAnimation *opacityAnimation = [self newOpacityAnimation];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.repeatCount = CGFLOAT_MAX;
    group.animations = @[pathAnimation, opacityAnimation];
    group.beginTime = CACurrentMediaTime() + self.duration * offsetFraction;
    [radarLayer addAnimation:group forKey:ZIMRadarAnimationKey];
}

- (void)stopAnimationInView:(UIView *)view {
    stopRadarAnimationInView(view);
}

- (void)startAnimationInView:(UIView *)view {
    [self stopAnimationInView:view];
    
    CGFloat offsetStep = 1.f / self.circleCount;
    
    for (NSUInteger i = 0; i < self.circleCount; i++) {
        [self addRadarLayerToView:view offsetFraction:offsetStep * i];
    }
}

@end


#pragma mark - UIView(ZIMRadarAnimation)

@implementation UIView(ZIMRadarAnimation)

- (void)zim_startRadarAnimation:(ZIMRadarAnimation *)animaton {
    [animaton startAnimationInView:self];
}

- (void)zim_startRadarAnimation {
    [self zim_startRadarAnimation:[ZIMRadarAnimation new]];
}

- (void)zim_stopRadarAnimation {
    stopRadarAnimationInView(self);
}

@end
