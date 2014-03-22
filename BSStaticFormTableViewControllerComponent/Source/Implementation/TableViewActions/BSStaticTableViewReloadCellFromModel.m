//
//  BSStaticTableViewReloadCellFromModel.m
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewReloadCellFromModel.h"

@implementation BSStaticTableViewReloadCellFromModel

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
