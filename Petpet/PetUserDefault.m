//
//  PetUserDefault.m
//  Petpet
//
//  Created by GIGIGUN on 08/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import "PetUserDefault.h"

// user default key
static NSString * userDefaultReadTutorKey = @"userDefaultReadTutorKey";
static NSString * userDefaultUserNameKey = @"userDefaultUserNameKey";
static NSString * userDefaultUserImageFileURLKey = @"userDefaultUserImageFileURLKey";

@implementation PetUserDefault

+(void) setReadTutor
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSNumber numberWithBool:YES] forKey:userDefaultReadTutorKey];
}

+(BOOL) isReadTutor
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults valueForKey:userDefaultReadTutorKey]) {
        return YES;
    }
    return NO;
}

//
// Current User Name
//
+(void) setUserNameWithNameString : (NSString *) userNameString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userNameString forKey:userDefaultUserNameKey];
}

+(NSString *) getUserNameWithNameString : (NSString *) userNameString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:userDefaultUserNameKey];
}


//
// Current User Image file path
//
+(void) setUserImageFilePathString : (NSString *) userImageFilePath
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userImageFilePath forKey:userDefaultUserImageFileURLKey];
}

+(NSString *) getUserImageFilePathString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:userDefaultUserImageFileURLKey];
}

@end
