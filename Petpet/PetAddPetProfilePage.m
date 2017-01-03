//
//  PetAddPetProfilePage.m
//  Petpet
//
//  Created by GIGIGUN on 11/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import "PetAddPetProfilePage.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ADKHexPresentation.h"

@interface PetAddPetProfilePage ()
@property (strong, nonatomic) IBOutlet UILabel *BreedLab;
@property (strong, nonatomic) IBOutlet UIScrollView *petScroller;
@property (strong, nonatomic) IBOutlet UIView *petScrollContentView;
@property (strong, nonatomic) IBOutlet UIButton *nextStepBtn;
@end

@implementation PetAddPetProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"petScrollerFrame = %@" , NSStringFromCGRect(_petScroller.frame));
    
    
    _nextStepBtn.layer.masksToBounds = YES;
    _nextStepBtn.layer.cornerRadius = 5.0f;
    _nextStepBtn.layer.borderWidth = 1.0f;
    _nextStepBtn.layer.borderColor = [UIColor ADKColorWithHexString:@"#4A4A4A"].CGColor;
    _nextStepBtn.backgroundColor = [UIColor ADKColorWithHexString:@"#D45949"];
//    _nextStepBtn.enabled = NO;
    
    CGRect contentViewFrame = _petScroller.frame;
    contentViewFrame.size.width = contentViewFrame.size.width * 1.5;
    contentViewFrame.origin = CGPointZero;
    _petScrollContentView.frame = contentViewFrame;
    
    [_petScroller setContentSize:CGSizeMake(contentViewFrame.size.width, 0)];
    [_petScroller addSubview:_petScrollContentView];
    
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x <= (scrollView.frame.size.width / 3)) {
        _BreedLab.text = @"狗";
    } else {
        _BreedLab.text = @"貓";
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
