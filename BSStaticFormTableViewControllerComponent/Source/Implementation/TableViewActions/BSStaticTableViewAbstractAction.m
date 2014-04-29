//
//  BSStaticTableViewAbstractAction.m
//  Expenses
//
//  Created by Borja Arias Drake on 12/11/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewAbstractAction.h"

@implementation BSStaticTableViewAbstractAction

- (instancetype)initWithIndexPaths:(NSArray *)indexPaths
{
    self = [super init];
    
    if (self)
    {
        _indexPathsToApplyActionTo = indexPaths;
    }
    
    return self;
}

@end
