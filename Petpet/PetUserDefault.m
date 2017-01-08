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

@end
