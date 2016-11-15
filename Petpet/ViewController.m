//
//  ViewController.m
//  Petpet
//
//  Created by GIGIGUN on 13/11/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import Firebase;
@import FirebaseAuth;

@interface ViewController () <FBSDKLoginButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DidChangeToken:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
        NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
        NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
        NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    }

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    NSLog(@"Did complete with result !! loginbtn");
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                     .tokenString];
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  NSLog(@"sign in with credential");
                              }];
    
}

/*!
 @abstract Sent to the delegate when the button was used to logout.
 @param loginButton The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
    }
}


- (void) DidChangeToken:(NSNotification*) notification
{
    NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
    NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
    NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
    NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    NSLog(@"Get notification permissions %@", [[FBSDKAccessToken currentAccessToken] permissions]);
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 
                 NSLog(@"fetched user:%@", result);
                 
//                 
//                 // For more complex open graph stories, use `FBSDKShareAPI`
//                 // with `FBSDKShareOpenGraphContent`
//                 /* make the API call */
//                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                               initWithGraphPath:@"me/picture"
//                                               parameters:@{@"height" : @100, @"redirect" : @0, @"type": @"square", @"width" : @100}
//                                               HTTPMethod:@"GET"];
//                 
//                 
//                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                                       id result2,
//                                                       NSError *error) {
//                     // Handle the result
//                     NSLog(@"fetched user:%@", result2);
//                     
//                     // TODO: convert imageUrl to UIImage and base64 string
//                     
//                     NSDictionary *test = @{@"uid":idstr,@"name":namestr,@"provider":[NSString stringWithFormat:@"facebook"],@"url":[[result2 valueForKey:@"data"] valueForKey:@"url"]};
//                     
//                     _serverObj = [ServerModule getInstance];
//                     [_serverObj RegisterAccountWithParameters:test Success:^(id responseObj) {
//                         NSLog(@"responseObj = %@,result = %@",responseObj,[responseObj objectForKey:@"result"]);
//                         
//                         [HTFBModule SaveFBInfo:test];
//                         
//                         // [Casper] present main tabController
//                         [self presentWriteCommentView:nil];
//                         
//                     } Failure:^(NSError *error) {
//                         NSLog(@"RegisterAccountWithParameters error!!");
//                     }];
//                 }];
             }
         }];
    }
}

@end
