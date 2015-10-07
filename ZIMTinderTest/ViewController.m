//
//  ViewController.m
//  ZIMTinderTest
//
//  Created by kovtash on 05.10.15.
//  Copyright © 2015 zim-team. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ZIMRadarAnimation.h"
#import "UIView+ZIMHideAnimated.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface ViewController () <FBSDKLoginButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePictureView.pictureMode = FBSDKProfilePictureModeSquare;
    self.facebookButton.readPermissions = @[@"public_profile"];
    self.facebookButton.delegate = self;
    self.facebookButton.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self showProfilePictureAnimated:NO];
    }
    else {
        [self hideProfilePictureAnimated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.radarContainerView zim_startRadarAnimation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.radarContainerView zim_stopRadarAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showProfilePictureAnimated:(BOOL)animated {
    [self.radarContainerView zim_setHidden:NO animated:animated completion:^(BOOL finished) {
        [self.radarContainerView zim_startRadarAnimation];
    }];
}

- (void)hideProfilePictureAnimated:(BOOL)animated {
    [self.radarContainerView zim_setHidden:YES animated:animated completion:^(BOOL finished) {
        [self.radarContainerView zim_stopRadarAnimation];
    }];
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (result && !result.isCancelled) {
        [hud hide:YES];
        [self showProfilePictureAnimated:YES];
        return;
    }
    
    if (result && result.isCancelled) {
        hud.labelText = @"Cancelled";
    }
    else {
        hud.labelText = @"Error";
    }
    
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:1.];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self hideProfilePictureAnimated:YES];
}

- (BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton {
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging in";
    hud.square = YES;
    return YES;
}

@end
