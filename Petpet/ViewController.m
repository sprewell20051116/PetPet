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
@import FirebaseStorage;

#define FirebaseStoragePath @"gs://petpet-51b70.appspot.com"

@interface ViewController () <FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *testImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    loginButton.delegate = self;
//    [self.view addSubview:loginButton];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(DidChangeToken:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    [[FIRAuth auth] createUserWithEmail:@"sprewell20051116@gmail.com" password:@"casper" completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        NSLog(@"Try to auth email");
    }];
    
    
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Try to download");
        // [START downloadimage]
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"file:%@/myimage.png", documentsDirectory];

        
        FIRStorage *storage = [FIRStorage storage];
        FIRStorageReference *storageRef = [storage referenceForURL:FirebaseStoragePath];
        FIRStorageReference *riversRef = [storageRef child:@"images/rivers.jpg"];

        // Create a reference to the file you want to download
//        FIRStorageReference *islandRef = [storageRef child:@"images/island.jpg"];
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        [riversRef dataWithMaxSize:1 * 1024 * 1024 completion:^(NSData *data, NSError *error){
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                UIImage *islandImage = [UIImage imageWithData:data];
                _testImageView.image = islandImage;
            }
        }];
        
        
        // User is logged in, do work such as go to next view controller.
//        NSLog(@"Get notification appID %@", [[FBSDKAccessToken currentAccessToken] appID]);
//        NSLog(@"Get notification tokenString %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
//        NSLog(@"Get notification expirationDate %@", [[FBSDKAccessToken currentAccessToken] expirationDate]);
//        NSLog(@"Get notification userID %@", [[FBSDKAccessToken currentAccessToken] userID]);
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
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
  
             }
         }];
    }
}

-(void) uploadUserImageFile
{

    
    // Do any additional setup after loading the view, typically from a nib.
    
    FIRStorage *storage = [FIRStorage storage];
    
    // Create a storage reference from our storage service
    FIRStorageReference *storageRef = [storage referenceForURL:FirebaseStoragePath];
    
    // Create a reference to "mountains.jpg"
    //    FIRStorageReference *mountainsRef = [storageRef child:@"images/testImage.png"];
    
    // File located on disk
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"testImage"
                                                         ofType:@".png"];
    //    NSURL *localFile =
    
    NSLog(@"FilePath = %@", filePath);
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"list-gotit" ofType:@"png"];
    NSURL    *imageURL = [NSURL fileURLWithPath:filePath];
    NSString *absoluteURLString = [imageURL absoluteString];
    UIImage * myImage = [UIImage imageWithContentsOfFile: filePath];
    _testImageView.image = myImage;
    
    //    [html appendFormat:@"<img src=\"%@\" />", absoluteURLString];
    
    NSData *imageData = UIImagePNGRepresentation(myImage);
    
    // Create a reference to the file you want to upload
    FIRStorageReference *riversRef = [storageRef child:@"images/rivers.jpg"];
    
    
    [riversRef putData:imageData metadata:nil
            completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error uploading: %@", error);
                    //                                        _urlTextView.text = @"Upload Failed";
                    return;
                }
                NSLog(@"DONE!!!!");
                //                                    [self uploadSuccess:metadata storagePath:imagePath];
            }];


}

@end
