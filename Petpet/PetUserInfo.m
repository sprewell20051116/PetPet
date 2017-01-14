//
//  PetUserInfo.m
//  Petpet
//
//  Created by GIGIGUN on 08/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import "PetUserInfo.h"

//
// UserID ----- UserName
//          |-- UserImage
//          |-- Pets        --- PetsID (YYYYMMDDhhmm)
//
//



@implementation PetUserInfo

//
// Current User Name
//
//+(void) setUserNameWithNameString : (NSString *) userNameString
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setValue:userNameString forKey:userDefaultUserNameKey];
//}
//
//+(NSString *) getUserNameWithNameString : (NSString *) userNameString
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return [userDefaults valueForKey:userDefaultUserNameKey];
//}

//
// Current User Image file path
//
//+(void) setUserImageFilePathString : (NSString *) userImageFilePath
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setValue:userImageFilePath forKey:userDefaultUserImageFileURLKey];
//}
//
//+(NSString *) getUserImageFilePathString
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return [userDefaults valueForKey:userDefaultUserImageFileURLKey];
//}

+(void) setUserIDInfoWithDIc : (NSDictionary *) UserDic
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:UserDic forKey:userDefaultUserIDKey];
}

+(NSString *) getUserImageFilePath
{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        return [[userDefaults valueForKey:userDefaultUserIDKey] valueForKey:userDefaultUserImageFileURLKey];
}

@end
