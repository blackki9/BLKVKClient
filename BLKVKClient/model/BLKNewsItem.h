//
//  BLKNewsItem.h
//  BLKVKClient
//
//  Created by black9 on 21/08/15.
//  Copyright © 2015 black9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLKNewsItem : NSObject

@property (nonatomic, copy) NSString* newsText;
@property (nonatomic, strong) NSDate* newsDate;
@property (nonatomic, assign) NSUInteger likesAmount;
@property (nonatomic, assign) NSUInteger commentsAmount;
@property (nonatomic, assign) NSUInteger repostsAmount;
@property (nonatomic, strong) NSArray* photos;

- (instancetype)initWithInfo:(NSDictionary*)itemInfo;

@end
