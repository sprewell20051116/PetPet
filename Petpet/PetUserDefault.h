//
//  PetUserDefault.h
//  Petpet
//
//  Created by GIGIGUN on 08/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetUserDefault : NSObject

+(BOOL) isReadTutor;
+(void) setReadTutor;
+(void) setUserImageFilePathString : (NSString *) userImageFilePath;
+(NSString *) getUserImageFilePathString;

@end
