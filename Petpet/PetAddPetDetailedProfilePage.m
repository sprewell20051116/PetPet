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
@interface PetAddPetDetailedProfilePage ()
@property (strong, nonatomic) IBOutlet PetUserView *petProfileView;

@end

@implementation PetAddPetDetailedProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    _petProfileView.petAvatarImageView.image = _petImage;
    _petProfileView.userImageView.image = [UIImage imageWithContentsOfFile:[PetUserInfo getUserImageFilePath]];
    
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
