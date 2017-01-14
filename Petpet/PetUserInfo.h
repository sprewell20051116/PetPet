//
//  PetUserInfo.h
//  Petpet
//
//  Created by GIGIGUN on 08/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import <Foundation/Foundation.h>

#define userDefaultNoValue    @"NaN"
#define userDefaultUserIDKey  @"userDefaultUserIDKey"
#define userDefaultUserNameKey  @"userDefaultUserNameKey"
#define userDefaultUserImageFileURLKey  @"userDefaultUserImageFileURLKey"
#define userDefaultPetKey  @"userDefaultUserImageFileURLKey"
@interface PetUserInfo : NSObject
//+(void) setUserImageFilePathString : (NSString *) userImageFilePath;
//+(NSString *) getUserImageFilePathString;
+(void) setUserIDInfoWithDIc : (NSDictionary *) UserDic;
+(NSString *) getUserImageFilePath;
@end
