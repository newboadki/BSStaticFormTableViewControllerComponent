//
//  BSTableViewExpandableCell.h
//  BSStaticFormTableViewController
//
//  Created by Borja Arias Drake on 13/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSTableViewExpandableCell <NSObject>

- (void)setUpForFoldedState;

- (void)setUpForUnFoldedState;

@end
