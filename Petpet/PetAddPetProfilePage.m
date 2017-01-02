//
//  PetAddPetProfilePage.m
//  Petpet
//
//  Created by GIGIGUN on 11/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "PetAddPetProfilePage.h"


@interface PetAddPetProfilePage ()
@property (strong, nonatomic) IBOutlet UIScrollView *petScroller;
@property (strong, nonatomic) IBOutlet UIView *petScrollContentView;
@property (strong, nonatomic) IBOutlet UIButton *nextStepBtn;
@end

@implementation PetAddPetProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"petScrollerFrame = %@" , NSStringFromCGRect(_petScroller.frame));
    
    CGRect contentViewFrame = _petScroller.frame;
    contentViewFrame.size.width = contentViewFrame.size.width * 1.5;
    contentViewFrame.origin = CGPointZero;
    _petScrollContentView.frame = contentViewFrame;
    
    [_petScroller setContentSize:CGSizeMake(contentViewFrame.size.width, 0)];
    [_petScroller addSubview:_petScrollContentView];
    
    // Do any additional setup after loading the view.
    [_nextStepBtn setTitle:@"是狗！" forState:UIControlStateNormal];
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
