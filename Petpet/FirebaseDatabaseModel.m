
//
//  FirebaseDatabaseModel.m
//  poetryapps
//
//  Created by GIGIGUN on 9/9/16.
//  Copyright © 2016 cc. All rights reserved.
//

#import "FirebaseDatabaseModel.h"


@interface FirebaseDatabaseModel()
@property (strong, nonatomic) UIImage *userImage;
@property(strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation FirebaseDatabaseModel

+ (instancetype) getInstance {
    static dispatch_once_t once;
    static FirebaseDatabaseModel *instance;
    dispatch_once(&once, ^{
        instance = [[FirebaseDatabaseModel alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.ref = [[FIRDatabase database] reference];
        // do more thing about init;

        
    }
    return self;
}

- (void) addRegisterDataWithRegisterIDString : (NSString *) registerString
                                     Success : (void (^)())success
                                     Failure : (void (^)(NSError *error))failure
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMdd-HHmmss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *userDic = @{@"userID" : [NSString stringWithFormat:@"%@", registerString],
                @"registerDate" : dateString,
                @"type" : @2}; //1 means facebook
    
    
    [[[_ref child:@"registerUsers"] childByAutoId] setValue:userDic
                         withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (error) {
            failure(error);
        } else {
            success();
        }
    }];
    
}

- (void) retreiveRegisterDataByQueryIDString : (NSString*) IDString
                                     Success : (void (^) (FIRDataSnapshot * data)) success
                                     Failure : (void (^)(NSError *error)) failure
{
    
    [[[[_ref child:@"registerUsers"] queryOrderedByChild:@"userID"] queryEqualToValue:IDString] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSLog(@"Snapshot: %@", snapshot);
        success(snapshot);
    }];
    
}

- (void) loginAsAnomymounSuccess : (void (^) (FIRUser * user)) success
                         Failure :(void (^)(NSError *error)) failure

{
    [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        if(error) {
            failure(error);
        } else {
            success(user);
        }
    }];

}

- (FIRUser *) getcurrentUser
{
    return [FIRAuth auth].currentUser;
}


- (void) deleteCurrentUserSuccess : (void (^) ()) success
                          Failure :(void (^)(NSError *error)) failure
{
    [[self getcurrentUser] deleteWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            // An error happened.
            failure(error);
        } else {
            // Account deleted.
            success();
        
        }
    }];
}


#pragma Firebase storage functions

-(NSString *) getFirebaseStorageURL
{
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GoogleService-Info" ofType:@"plist"]];
    if (dictionary) {
        return [NSString stringWithFormat:@"gs://%@", [dictionary objectForKey:@"STORAGE_BUCKET"]];
    }
    return nil;
}


-(void) uploadImage : (UIImage *) image
   FirebaseFileName : (NSString *) fileName
            Success : (void (^) (FIRStorageMetadata * _Nullable metadata)) success
            Failure : (void (^) (NSError *error)) failure
{
    // Do any additional setup after loading the view, typically from a nib.
    
    FIRStorage *storage = [FIRStorage storage];
    
    // Create a storage reference from our storage service
    
    FIRStorageReference *storageRef = [storage referenceForURL:[self getFirebaseStorageURL]];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // Create a reference to the file you want to upload
    NSString *imageChildName = [NSString stringWithFormat:@"images/%@.png", fileName];
    FIRStorageReference *riversRef = [storageRef child:imageChildName];
    
    [riversRef putData:imageData metadata:nil
            completion:^(FIRStorageMetadata * _Nullable metadata,
                         NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error uploading: %@", error);
                    failure (error);
                }
                NSLog(@"matadata = %@", metadata);
                success(metadata);
                
            }];
}

-(BOOL) isUserImageAvailable
{
    if (_userImage) {
        return YES;
    } else {
        return NO;
    }
}

-(UIImage *) getUserImage
{
    return _userImage;
}

-(void) setUserImage : (UIImage *) userImage
{
    _userImage = userImage;
}

#pragma ERROR
//- (id) endWorldHunger:(id)largeAmountsOfMonies error:(NSError**)error {
//    // begin feeding the world's children...
//    // it's all going well until....
//    if (ohNoImOutOfMonies) {
//        // sad, we can't solve world hunger, but we can let people know what went wrong!
//        // init dictionary to be used to populate error object
//        NSMutableDictionary* details = [NSMutableDictionary dictionary];
//        [details setValue:@"ran out of money" forKey:NSLocalizedDescriptionKey];
//        // populate the error object with the details
//        *error = [NSError errorWithDomain:@"world" code:200 userInfo:details];
//        // we couldn't feed the world's children...return nil..sniffle...sniffle
//        return nil;
//    }
//    // wohoo! We fed the world's children. The world is now in lots of debt. But who cares?
//    return YES;
//}

//
//
//
//- (void) setDataWithDic : (NSDictionary*) DataDic
//                Success : (void (^)())success
//                Failure : (void (^)(NSError *error))failure
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYYMMdd-HHmmss"];
//    NSString *DateString = [formatter stringFromDate:[NSDate date]];
//
//
//    [[[_ref child:@"emotionData"]
//      child:DateString] setValue:DataDic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
//        if (error) {
//            failure(error);
//        } else {
//            success();
//        }
//    }];
//
//}
//
//
//
//- (void) readValue
//{
//    [[_ref child:@"notificationHistory"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//
//        NSMutableArray *returnData = [NSMutableArray new];
//        
//        NSLog(@"snapshot = %@", snapshot);
//        NSLog(@"snapshot = %d", snapshot.childrenCount);
//        
//        for (FIRDataSnapshot* child in snapshot.children) {
//            NSLog(@"value = %@", child.value);
//            [returnData addObject:child.value];
//        }
//        
//        // ...
//    } withCancelBlock:^(NSError * _Nonnull error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
//}
//
//
//- (void) readNotificationHistoryWithSuccess : (void (^) (NSArray * HistoryData)) success
//                                    Failure : (void (^) (NSError * error)) failure
//{
//    [[_ref child:@"notificationHistory"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        
//        NSMutableArray *returnData = [NSMutableArray new];
//        
//        for (FIRDataSnapshot* child in snapshot.children) {
//            [returnData addObject:child.value];
//        }
//        success(returnData);
//        
//    } withCancelBlock:^(NSError * error) {
//        NSLog(@"%@", error.localizedDescription);
//        failure(error);
//    }];
//}





//-(NSDictionary *) setNotificationDicWithTitleString : (NSString *) titleString
//                                      andBodyString : (NSString *) bodyString
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYYMMdd-HHmmss"];
//    NSString *DateString = [formatter stringFromDate:[NSDate date]];
//
//    return @{@"Date" : DateString,
//             @"Type" : @"Common",
//             @"Title" : titleString,
//             @"Body" : bodyString,
//             @"Photo" : @"",
//             @"Sound" : @"",
//             @"Video" : @""};
//
//}
//


@end
