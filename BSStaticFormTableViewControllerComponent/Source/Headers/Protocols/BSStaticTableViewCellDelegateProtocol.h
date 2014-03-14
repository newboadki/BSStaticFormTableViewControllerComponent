//
//  BSStaticTableViewCellDelegateProtocol.h
//  BSStaticFormTableViewController
//
//  Created by Borja Arias Drake on 13/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Events/BSStaticTableViewCellAbstractEvent.h"

@protocol BSStaticTableViewCellDelegateProtocol <NSObject>
- (void) cell:(UITableViewCell *)cell eventOccurred:(BSStaticTableViewCellAbstractEvent *)event;
- (void) textFieldShouldreturn;
@end
