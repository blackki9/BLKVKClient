//
//  BLKSocialNetworkAdapter.h
//  BLKVKClient
//
//  Created by black9 on 21/08/15.
//  Copyright © 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BLKSocialNetworkAdapterError) {
    kInitSocialNetworkErrorCode = 1,
    kAuthSocialNetworkErrorCode,
    kFetchNewsFromSocialNetworkErrorCode
};

typedef void (^BLKSocialNetworkAdapterAuthCompleteBlock) (BOOL success, NSError* error);
typedef void (^BLKSocialNetworkAdapterInitCompleteBlock) (BOOL success, NSError* error);
typedef void (^BLKSocialNetworkAdapterFetchNewsCompletionBlock) (NSArray* news, NSError* error);

@interface BLKSocialNetworkAdapter : NSObject

+ (instancetype)sharedInstance;

- (void)initNetworkWithCompletion:(BLKSocialNetworkAdapterInitCompleteBlock)completionBlock;
- (void)handleOpenURL:(NSURL*)url sourceApplication:(NSString*)application;

- (void)authUserWithCompletionBlock:(BLKSocialNetworkAdapterAuthCompleteBlock)completionBlock;

- (void)fetchNewsWithCompletionBlock:(BLKSocialNetworkAdapterFetchNewsCompletionBlock)completionBlock;

@end
