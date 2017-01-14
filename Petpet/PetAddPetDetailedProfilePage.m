//
//  PetAddPetDetailedProfilePage.m
//  Petpet
//
//  Created by GIGIGUN on 11/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "PetAddPetDetailedProfilePage.h"
#import "PetUserInfo.h"
#import "PetUserView.h"
#import "FirebaseDatabaseModel.h"
#import "FirebaseDatabaseModel+FBLogin.h"
#import "UIImageView+AFNetworking.h"

@interface PetAddPetDetailedProfilePage ()
@property (strong, nonatomic) IBOutlet PetUserView *petProfileView;

@end

@implementation PetAddPetDetailedProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_petImage) {
        _petProfileView.petAvatarImageView.image = _petImage;
    } else {
        _petProfileView.petAvatarImageView.image = [UIImage imageNamed:@"Avatar"];
    }
    
    if ([[FirebaseDatabaseModel getInstance] isUserImageAvailable]) {
        _petProfileView.userImageView.image = [[FirebaseDatabaseModel getInstance] getUserImage];
    } else {
        
        // TODO: get facebook image url again.
        [[FirebaseDatabaseModel getInstance] FBGetUserImageUrlWithSuccess:^(id  _Nullable userImageUrl)
        {
            
            NSLog(@"Success get user image url = %@", userImageUrl);
            [_petProfileView.userImageView setImageWithURL:[NSURL URLWithString:userImageUrl]];
            
        } Failure:^(NSError * _Nullable error) {
            //TODO: Error handler
            NSLog(@"%s Failed, %@", __PRETTY_FUNCTION__, error.localizedDescription);
        }];
    }
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
