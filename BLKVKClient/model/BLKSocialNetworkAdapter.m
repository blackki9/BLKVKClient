//
//  BLKSocialNetworkAdapter.m
//  BLKVKClient
//
//  Created by black9 on 21/08/15.
//  Copyright © 2015 black9. All rights reserved.
//

#import "BLKSocialNetworkAdapter.h"
#import <VK-ios-sdk/VKSdk.h>

static NSString* const BLKSocialNetworkAdapterErrorDomain = @"BLKSocialNetworkAdapterErrorDomain";


@interface BLKSocialNetworkAdapter () <VKSdkDelegate>

@property (nonatomic, copy) BLKSocialNetworkAdapterAuthCompleteBlock authCompletionBlock;
@property (nonatomic, strong) VKAccessToken* currenAccessToken;
@property (nonatomic, copy) BLKSocialNetworkAdapterFetchNewsCompletionBlock fetchNewsCompletionBlock;

@end

@implementation BLKSocialNetworkAdapter

#pragma mark - init

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BLKSocialNetworkAdapter* sharedInstance = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [BLKSocialNetworkAdapter new];
    });
    
    return sharedInstance;
}

- (void)initNetworkWithCompletion:(BLKSocialNetworkAdapterInitCompleteBlock)completionBlock {
    [VKSdk initializeWithDelegate:self andAppId:@""];
    if([VKSdk wakeUpSession]) {
        completionBlock(YES,nil);
    }
    else {
        NSError* initializeError = [NSError errorWithDomain:BLKSocialNetworkAdapterErrorDomain code:kInitSocialNetworkErrorCode userInfo:nil];
        completionBlock(NO,initializeError);
    }
}

- (void)handleOpenURL:(NSURL*)url sourceApplication:(NSString*)application {
    [VKSdk processOpenURL:url fromApplication:application];
}

#pragma mark - auth

- (void)authUserWithCompletionBlock:(BLKSocialNetworkAdapterAuthCompleteBlock)completionBlock {
    self.authCompletionBlock = completionBlock;
    [VKSdk authorize:@[] revokeAccess:YES forceOAuth:YES];
}

#pragma mark - news

- (void)fetchNewsWithCompletionBlock:(BLKSocialNetworkAdapterFetchNewsCompletionBlock)completionBlock {
    self.fetchNewsCompletionBlock = completionBlock;
    [[self fetchNewsRequest] executeWithResultBlock:^(VKResponse *response) {
        NSArray* news = [self parseNewsResponse:response];
        if(self.fetchNewsCompletionBlock) {
            self.fetchNewsCompletionBlock(news,nil);
        }
        self.fetchNewsCompletionBlock = nil;
    } errorBlock:^(NSError *error) {
        NSError* fetchNewsError = [NSError errorWithDomain:BLKSocialNetworkAdapterErrorDomain code:kFetchNewsFromSocialNetworkErrorCode userInfo:@{NSUnderlyingErrorKey:error}];
        if(self.fetchNewsCompletionBlock) {
            self.fetchNewsCompletionBlock(nil,fetchNewsError);
        }
        self.fetchNewsCompletionBlock = nil;
    }];
}
- (VKRequest*)fetchNewsRequest {
    VKRequest* fetchNewsRequest = [VKRequest requestWithMethod:@"newsfeed.get" andParameters:@{@"filters":@"post",@"count":@"10"} andHttpMethod:@"GET"];
    
    return fetchNewsRequest;
}
- (NSArray*)parseNewsResponse:(VKResponse*)response error:(NSError**)error {
    NSArray* newsInfo = [NSJSONSerialization JSONObjectWithData:response.json options:NSJSONReadingAllowFragments error:error];
    if(newsInfo) {
        [newsInfo enumerateObjectsUsingBlock:^(NSDictionary*  __nonnull news, NSUInteger idx, BOOL * __nonnull stop) {
            NSArray* newsItems = news[@"items"];
            NSArray* profiles = news[@"profiles"];
            NSMutableArray* parsedNews = [NSMutableArray array];
            
        }];
    }
    
    return @[];
}

#pragma mark - VKSdkDelegate

- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

- (void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    self.currenAccessToken = nil;
}

- (void)vkSdkUserDeniedAccess:(VKError *)authorizationError {
    if(self.authCompletionBlock) {
        NSError* authError = [NSError errorWithDomain:BLKSocialNetworkAdapterErrorDomain code:kAuthSocialNetworkErrorCode userInfo:@{NSLocalizedDescriptionKey:authorizationError.errorMessage}];
        self.authCompletionBlock(nil,authError);
        self.authCompletionBlock = nil;
    }
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    
}

- (void)vkSdkReceivedNewToken:(VKAccessToken *)newToken {
    if(self.authCompletionBlock) {
        self.authCompletionBlock(YES,nil);
        self.authCompletionBlock = nil;
    }
    self.currenAccessToken = newToken;
}


@end
