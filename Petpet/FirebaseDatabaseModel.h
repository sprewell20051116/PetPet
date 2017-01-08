//
//  FirebaseDatabaseModel.h
//  poetryapps
//
//  Created by GIGIGUN on 9/9/16.
//  Copyright © 2016 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface FirebaseDatabaseModel : NSObject
+ (_Nonnull instancetype ) getInstance;

- (void) addRegisterDataWithRegisterIDString : (NSString * _Nonnull) registerString
                                     Success : (void (^ _Nullable)())success
                                     Failure : (void (^ _Nullable)(NSError * _Nullable error))failure;


- (void) retreiveRegisterDataByQueryIDString : (NSString * _Nonnull) IDString
                                     Success : (void (^ _Nullable) (FIRDataSnapshot * _Nullable data)) success
                                     Failure : (void (^ _Nullable)(NSError * _Nullable error)) failure;

- (void) loginAsAnomymounSuccess : (void (^ _Nullable) (FIRUser * _Nullable user)) success
                         Failure :(void (^ _Nullable)(NSError * _Nullable error)) failure;

- (FIRUser * _Nullable) getcurrentUser;

- (void) deleteCurrentUserSuccess : (void (^ _Nullable) ()) success
                          Failure :(void (^ _Nullable)(NSError * _Nullable error)) failure;

- (void) uploadImage : (UIImage * _Nonnull) image
   FirebaseFileName : (NSString * _Nonnull) fileName
            Success : (void (^ _Nullable) (FIRStorageMetadata * _Nullable metadata)) success
            Failure : (void (^ _Nullable) (NSError * _Nullable error)) failure;

@end
