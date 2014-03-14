//
//  BSEntryDetailSingleButtonCell.m
//  Expenses
//
//  Created by Borja Arias Drake on 11/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSEntryDetailSingleButtonCell.h"
#import "BSStaticTableViewCell+Protected.h" // from superclass
#import "../../Headers/BSTableViewEvents.h"

@implementation BSEntryDetailSingleButtonCell

- (IBAction) deleteButtonPressed:(UIButton *)deleteButton
{
    BSStaticTableViewCellChangeOfValueEvent *event = [[BSStaticTableViewCellChangeOfValueEvent alloc] initWithNewValue:self.entryModel forPropertyName:@"deleteEntry"];
    event.indexPath = self.indexPath;

    [self.delegate cell:self eventOccurred:event];
}

- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.entryModel = model;
}

@end
