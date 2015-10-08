//
//  UIView+ZIMHideAnimated.h
//  ZIMTinderTest
//
//  Created by kovtash on 08.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZIMHideAnimated)
- (void)zim_setHidden:(BOOL)isHidded animated:(BOOL)animated completion:(void(^)(BOOL finished))completion;
@end
