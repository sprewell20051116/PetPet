//
//  PetAddCameraPage.m
//  Petpet
//
//  Created by GIGIGUN on 04/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import "PetAddCameraPage.h"
#import "FirebaseDatabaseModel.h"
#import <FastttCamera.h>

@interface PetAddCameraPage () <FastttCameraDelegate>

@property (strong, nonatomic) IBOutlet UIView *controlPanelView;
@property (nonatomic, strong) FastttCamera *fastCamera;
@property (strong, nonatomic) IBOutlet UIView *previewView;
@property (strong, nonatomic) IBOutlet UIButton *captureBtn;
@property (strong, nonatomic) IBOutlet UIImageView *captureResultImgView;
@property (strong, nonatomic) IBOutlet UIButton *retakeBtn;
@property (strong, nonatomic) IBOutlet UIButton *skipBtn;
@property (strong, nonatomic) IBOutlet UIButton *completeBtn;

@end

@implementation PetAddCameraPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _fastCamera = [FastttCamera new];
    self.fastCamera.delegate = self;
    
    [self hideStatusBarWithAnimation:NO];
    
    [self fastttAddChildViewController:self.fastCamera];
    self.fastCamera.view.frame = _previewView.frame;
    _captureResultImgView.frame= _previewView.frame;
    _captureResultImgView.hidden = YES;
    
    // init retakeBtn
    [self init_retakeBtn];

    [self setCurrentViewStateCapturing:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)captrueBtnClicked:(id)sender {
    [self.fastCamera takePicture];
}

- (void)cameraController:(FastttCamera *)cameraController
 didFinishCapturingImage:(FastttCapturedImage *)capturedImage
{

    
    /**
     *  Here, capturedImage.fullImage contains the full-resolution captured
     *  image, while capturedImage.rotatedPreviewImage contains the full-resolution
     *  image with its rotation adjusted to match the orientation in which the
     *  image was captured.
     */
    
}


- (void)cameraController:(FastttCamera *)cameraController
didFinishScalingCapturedImage:(FastttCapturedImage *)capturedImage
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSLog(@"%@", capturedImage.scaledImage);
    _captureResultImgView.image = capturedImage.scaledImage;
    _captureResultImgView.hidden = NO;

    [self.fastCamera stopRunning];
    [self setCurrentViewStateCapturing:NO];
    //TODO: animate _captureResultImgView
    
}


#pragma private function - 
-(void) init_retakeBtn
{
    //    _retakeBtn.frame = _captureBtn.frame;
    CGRect frame = _retakeBtn.frame;
    frame = _captureBtn.frame;
    frame.size = CGSizeMake(frame.size.height * 0.8f, frame.size.width * 0.8f);
    _retakeBtn.frame = frame;
    _retakeBtn.center = _captureBtn.center;
    [_controlPanelView addSubview:_retakeBtn];
}

-(void) setCurrentViewStateCapturing : (BOOL) isCapturiing
{
    if (isCapturiing) {
        [UIView animateWithDuration:0.3f animations:^{
       
            _captureBtn.alpha = 1.0;
            [_retakeBtn setUserInteractionEnabled:YES];
            _retakeBtn.alpha = 0.0;
            [_retakeBtn setUserInteractionEnabled:NO];
            [_skipBtn setAlpha:1.0];
            [_skipBtn setUserInteractionEnabled:YES];
        }];
        
        
    } else {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            _captureBtn.alpha = 0.0;
            [_retakeBtn setUserInteractionEnabled:NO];
            _retakeBtn.alpha = 1.0;
            [_retakeBtn setUserInteractionEnabled:YES];
            [_skipBtn setAlpha:0.0];
            [_skipBtn setUserInteractionEnabled:NO];
            
        }];

        
    }
}
- (IBAction)retakeBtnClicked:(id)sender {
    
    _captureResultImgView.hidden = NO;
    
    [self.fastCamera startRunning];
    [self setCurrentViewStateCapturing:YES];
    
}
- (IBAction)skipBtnClicked:(id)sender {
    
    
    // this is for test
    if (_captureResultImgView.image) {
        [[FirebaseDatabaseModel getInstance] uploadImage:_captureResultImgView.image FirebaseFileName:@"petAvatar" Success:^(FIRStorageMetadata * _Nullable metadata) {
            
        } Failure:^(NSError * _Nullable error) {
            
        }];
    }

    [self pushNavPageWithStoryboardIDString:@"PetAddPetDetailedProfilePage"];
}
- (IBAction)completeBtnClicked:(id)sender {
    
    if (_captureResultImgView.image) {
        [[FirebaseDatabaseModel getInstance] uploadImage:_captureResultImgView.image FirebaseFileName:@"petAvatar" Success:^(FIRStorageMetadata * _Nullable metadata) {
            
        } Failure:^(NSError * _Nullable error) {
            
        }];
    }
    [self pushNavPageWithStoryboardIDString:@"PetAddPetDetailedProfilePage"];
}

- (IBAction)photoPickerClicked:(id)sender {
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
