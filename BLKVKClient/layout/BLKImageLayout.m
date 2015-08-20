//
//  BLKImageLayout.m
//  BLKVKClient
//
//  Created by black9 on 20/08/15.
//  Copyright © 2015 black9. All rights reserved.
//

#import "BLKImageLayout.h"

@implementation BLKImageLayout

#pragma mark - UICollectionViewLayout

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* layoutAttributes = [NSMutableArray array];
    
    NSArray* visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    
    for(NSIndexPath* indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    return layoutAttributes;
}
- (NSArray*)indexPathsOfItemsInRect:(CGRect)rect {
    return @[];
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
