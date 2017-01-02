//
//  baseViewController.h
//  testAuthorize
//
//  Created by GIGIGUN on 17/12/2016.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface baseViewController : UIViewController

- (void) showPageWithStoryboardIDString : (NSString * _Nonnull) ViewControllerIDString
                          withAnimation : (BOOL) animation
                             completion : (void (^ __nullable)(void))completion;

- (void) showSimpleAlertWithTitleString : (NSString * _Nonnull) titleString
                          MessageString : (NSString * __nullable) messageStr
                              BtnString : (NSString * __nullable) btnString
                           andBtnAction : (void (^ __nullable)(UIAlertAction * __nullable action)) action;
@end
