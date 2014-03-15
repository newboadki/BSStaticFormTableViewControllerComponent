//
//  BSEntryDateCell.h
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStaticTableViewCell.h"
#import "../Protocols/BSTableViewExpandableCell.h"

@interface BSEntryDateCell : BSStaticTableViewCell <BSTableViewExpandableCell>

@property (strong, nonatomic) UIDatePicker *datePicker;

- (IBAction) entryDatePickerValueChanged:(UIDatePicker *)picker;
- (IBAction) dateButtonPressed:(id)sender;

@end
