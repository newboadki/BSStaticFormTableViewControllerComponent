//
//  BSStaticTableViewInsertRowAction.m
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewInsertRowAction.h"

@implementation BSStaticTableViewInsertRowAction

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath
{
    self = [super init];
    
    if (self)
    {
        _indexPath = indexPath;
    }
    
    return self;
}

@end
