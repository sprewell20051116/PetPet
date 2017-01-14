//
//  FirebaseDatabaseModel+FBLogin.h
//  testAuthorize
//
//  Created by GIGIGUN on 22/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "FirebaseDatabaseModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FirebaseDatabaseModel (FBLogin) 



-(BOOL) isCurrentFBlogin;
-(void) FBLoginWithPublicProfilefromViewController : (UIViewController* _Nonnull) viewController
                                           Success : (void (^ _Nonnull) (FIRUser * _Nullable user)) success
                                           Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure;

-(void) FBGetUserProfile : (void (^ _Nonnull) (id _Nullable userProfile)) success
                 Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure;

-(void) FBGetUserImageUrlWithSuccess : (void (^ _Nonnull) (id _Nullable userImageUrl)) success
                             Failure :(void (^ _Nonnull) (NSError * _Nullable error)) failure;

-(NSString *) saveFBUserImage : (UIImage*) userImage;
@end
