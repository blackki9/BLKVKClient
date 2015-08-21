//
//  BLKNewsItem.m
//  BLKVKClient
//
//  Created by black9 on 21/08/15.
//  Copyright © 2015 black9. All rights reserved.
//

#import "BLKNewsItem.h"

static NSString* const BLKNewsItemTextKey = @"text";
static NSString* const BLKNewsItemDateKey = @"date";
static NSString* const BLKNewsItemCountKey = @"count";
static NSString* const BLKNewsItemLikesKey = @"likes";
static NSString* const BLKNewsItemRepostsKey = @"resosts";
static NSString* const BLKNewsItemCommentsKey = @"comments";
static NSString* const BLNewsItemPhotosKey = @"photos";

@implementation BLKNewsItem

- (instancetype)initWithInfo:(NSDictionary*)itemInfo {
    self = [super init];
    if(self) {
        [self parseInfo:itemInfo];
    }
    
    return self;
}
- (void)parseInfo:(NSDictionary*)info {
  //  _newsText = info
}

@end
