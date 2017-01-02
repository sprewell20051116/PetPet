//
//  PetFirstPage.m
//  Petpet
//
//  Created by GIGIGUN on 31/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "PetFirstPage.h"
#import "UIImageView+AFNetworking.h"
#import "UIView+ADKAnimationMacro.h"

@interface PetFirstPage ()
@property (strong, nonatomic) IBOutlet UIButton *FBloginBtn;
@property (strong, nonatomic) IBOutlet UIView *FBUserInfoView;
@property (strong, nonatomic) IBOutlet UIImageView *FBUserImageView;
@property (strong, nonatomic) IBOutlet UILabel *FBUserNameLab;

@end

@implementation PetFirstPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _FBloginBtn.layer.masksToBounds = YES;
    _FBloginBtn.layer.cornerRadius = 5.0f;
    
    _FBUserImageView.layer.masksToBounds = YES;
    _FBUserImageView.layer.cornerRadius = (_FBUserImageView.frame.size.height / 2);
    
    [self configUIwithLoginState];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FBLoginBtnClicked:(id)sender {
    
    [[FirebaseDatabaseModel getInstance] FBLoginWithPublicProfilefromViewController:self Success:^(FIRUser * _Nullable user) {
        
        NSLog(@"Success");
        //TODO: Check if database has DATA related to this userID
        [self configUIwithLoginState];
        
    } Failure:^(NSError * _Nullable error) {
        NSLog(@"%s Failed, %@", __PRETTY_FUNCTION__, error.localizedDescription);
    }];
}

- (void) configUIwithLoginState {
    
    if ([[FirebaseDatabaseModel getInstance] isCurrentFBlogin]) {
        
        [_FBUserInfoView setHidden:NO];

        [[FirebaseDatabaseModel getInstance] FBGetUserProfile:^(id  _Nullable userProfile) {
            
            NSLog(@"Success get user name = %@", [userProfile valueForKey:@"name"]);
            _FBUserNameLab.text = [userProfile valueForKey:@"name"];
            
            [[FirebaseDatabaseModel getInstance] FBGetUserImageUrlWithSuccess:^(id  _Nullable userImageUrl) {
                
                NSLog(@"Success get user image url = %@", userImageUrl);
                [_FBUserImageView setImageWithURL:[NSURL URLWithString:userImageUrl]];
                
            } Failure:^(NSError * _Nullable error) {
                //TODO: Error handler
                NSLog(@"%s Failed, %@", __PRETTY_FUNCTION__, error.localizedDescription);
            }];
            
        } Failure:^(NSError * _Nullable error) {
            //TODO: Error handler
            NSLog(@"%s Failed, %@", __PRETTY_FUNCTION__, error.localizedDescription);
        }];
    } else {
        [_FBUserInfoView setHidden:YES];
    }

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
