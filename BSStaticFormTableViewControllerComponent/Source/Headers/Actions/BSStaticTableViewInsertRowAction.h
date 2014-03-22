//
//  BSStaticTableViewInsertRowAction.h
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewAbstractAction.h"

@interface BSStaticTableViewInsertRowAction : BSStaticTableViewAbstractAction

@property (nonatomic, strong) NSIndexPath *indexPath;

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

@end
