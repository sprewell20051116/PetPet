//
//  FirebaseDatabaseModel+FBLogin.m
//  testAuthorize
//
//  Created by GIGIGUN on 22/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "FirebaseDatabaseModel+FBLogin.h"

@implementation FirebaseDatabaseModel (FBLogin)

-(void) FBLoginWithPublicProfilefromViewController : (UIViewController* _Nonnull) viewController
                                           Success : (void (^ _Nonnull) (FIRUser * _Nullable user)) success
                                           Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure

{
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile"]
                 fromViewController:viewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
    {
                                
        if (error) {
            failure(error);
        } else if (result.isCancelled) {
            
        } else {
            FIRAuthCredential *credential = [FIRFacebookAuthProvider credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
            [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser * _Nullable user, NSError * _Nullable error)
            {
                NSLog(@"FIRUser login %@", user.uid);
                success(user);
            }];

        }
    }];
}


-(void) FBGetUserProfile : (void (^ _Nonnull) (id _Nullable userProfile)) success
                 Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure

{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                           parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             //             [resultDic setObject:@"Value" forKey:@"your key"];
             //             [resultDic setObject:[result valueForKey:@"name"] forKey:@"name"];
             NSLog(@"fetched user:%@", result);
             
             success(result);
         }];
    } else {
        
        failure([self getLoginError]);
        
    }
    
}



-(void) FBGetUserImageUrlWithSuccess : (void (^ _Nonnull) (id _Nullable userImageUrl)) success
                             Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure

{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/picture"
                                           parameters:@{@"height" : @100,
                                                        @"redirect" : @0,
                                                        @"type": @"large",
                                                        @"width" : @100}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
             if (error) {
                 
                 failure(error);
                 
             } else {
                 NSLog(@"fetched picture:%@", result);
                 success([[result valueForKey:@"data"] valueForKey:@"url"]);
             }
             
         }];
        
    } else {

        failure([self getLoginError]);
        
    }

}

-(BOOL) isCurrentFBlogin
{
    if ([FBSDKAccessToken currentAccessToken]) {
        return YES;
    } else {
        return NO;
    }
}


-(NSString *) saveFBUserImage : (UIImage*) userImage
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSData * binaryImageData = UIImagePNGRepresentation(userImage);
    NSString *filePath = [basePath stringByAppendingPathComponent:@"userImage.png"];
    
    [binaryImageData writeToFile:filePath atomically:YES];
    
    return filePath;
}

#pragma -private methods
-(NSError *) getLoginError
{
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    [details setValue:@"No login error" forKey:NSLocalizedDescriptionKey];
    // populate the error object with the details
    return [NSError errorWithDomain:@"login" code:200 userInfo:details];
}

@end
