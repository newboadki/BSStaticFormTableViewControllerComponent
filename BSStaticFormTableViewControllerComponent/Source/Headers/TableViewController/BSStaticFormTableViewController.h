//
//  BSAddEntryViewController.h
//  Expenses
//
//  Created by Borja Arias Drake on 25/06/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStaticTableViewCell.h"
#import "BSStaticFormTableViewCellActionDataSourceProtocol.h"
#import "../Protocols/BSStaticTableViewCellDelegateProtocol.h"
#import "../Protocols/BSStaticFormTableViewAppearanceDelegateProtocol.h"

@interface BSStaticFormTableViewController : UITableViewController <BSStaticTableViewCellDelegateProtocol>

@property (assign, nonatomic) BOOL isEditingEntry;
@property (strong, nonatomic) id entryModel;
@property (strong, nonatomic) id<BSStaticFormTableViewCellActionDataSourceProtocol> cellActionDataSource;
@property (weak, nonatomic) id<BSStaticFormTableViewAppearanceDelegateProtocol> appearanceDelegate;

- (IBAction) addEntryPressed:(id)sender;
- (IBAction) cancelButtonPressed:(id)sender;

@end
