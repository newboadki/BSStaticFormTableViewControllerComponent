//
//  BSStaticTableViewSelectRowAction.m
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 19/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewSelectRowAction.h"

@implementation BSStaticTableViewSelectRowAction

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
