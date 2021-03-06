//
//  BSStaticTableViewAbstractAction.h
//  Expenses
//
//  Created by Borja Arias Drake on 12/11/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSStaticTableViewAbstractAction : NSObject

@property (nonatomic, strong) NSArray *indexPathsToApplyActionTo; // To apply action to

- (instancetype)initWithIndexPaths:(NSArray *)indexPaths;

@end
