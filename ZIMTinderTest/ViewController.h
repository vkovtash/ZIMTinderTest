//
//  ViewController.h
//  ZIMTinderTest
//
//  Created by kovtash on 05.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class FBSDKProfilePictureView;

@interface ViewController : UIViewController <FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UIView *radarContainerView;
@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *facebookButton;
@property (readonly, nonatomic) BOOL isLoggedIn;

- (void)showProfilePictureAnimated:(BOOL)animated;
- (void)hideProfilePictureAnimated:(BOOL)animated;
@end
