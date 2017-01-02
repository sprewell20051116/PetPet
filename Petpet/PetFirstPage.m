//
//  PetFirstPage.m
//  Petpet
//
//  Created by GIGIGUN on 31/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "PetFirstPage.h"

@interface PetFirstPage ()
@property (strong, nonatomic) IBOutlet UIButton *FBloginBtn;

@end

@implementation PetFirstPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _FBloginBtn.layer.masksToBounds = YES;
    _FBloginBtn.layer.cornerRadius = 5.0f;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FBLoginBtnClicked:(id)sender {
    
    [[FirebaseDatabaseModel getInstance] FBLoginWithPublicProfilefromViewController:self Success:^(FIRUser * _Nullable user) {
        NSLog(@"Success");
        
    } Failure:^(NSError * _Nullable error) {
        NSLog(@"Error");
    }];
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
