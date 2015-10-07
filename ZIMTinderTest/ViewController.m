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


@interface ViewController () <FBSDKLoginButtonDelegate>

@end

@implementation ViewController

- (void)awakeFromNib {
}

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
    if (!error && result.token) {
        [self showProfilePictureAnimated:YES];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self hideProfilePictureAnimated:YES];
}

@end
