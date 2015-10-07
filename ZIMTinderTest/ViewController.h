//
//  ViewController.h
//  ZIMTinderTest
//
//  Created by kovtash on 05.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBSDKProfilePictureView;
@class FBSDKLoginButton;

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *radarContainerView;
@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *facebookButton;
@end
