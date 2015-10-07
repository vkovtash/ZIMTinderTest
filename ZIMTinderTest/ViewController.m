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

@interface ViewController () <FBSDKLoginButtonDelegate>
@property (strong, nonatomic) FBSDKProfilePictureView *currentProfilePictureView;
@end

@implementation ViewController

- (void)awakeFromNib {
    self.profilePictureView.pictureMode = FBSDKProfilePictureModeSquare;
    self.facebookButton.readPermissions = @[@"public_profile"];
    self.facebookButton.delegate = self;
    self.facebookButton.loginBehavior = FBSDKLoginBehaviorSystemAccount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {

}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

@end
