//
//  ZIMRadarView.m
//  ZIMTinderTest
//
//  Created by kovtash on 05.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import "ZIMRadarView.h"
#import "ZIMRadarAnimation.h"

@implementation ZIMRadarView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self zim_privateSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self zim_privateSetup];
    }
    return self;
}

- (void)zim_privateSetup {
    [self zim_startRadarAnimation];
}

@end
