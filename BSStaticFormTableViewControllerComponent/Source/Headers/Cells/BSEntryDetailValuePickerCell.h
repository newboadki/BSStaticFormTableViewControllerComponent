//
//  BSEntryDetailValuePickerCell.h
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 15/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStaticTableViewCell.h"
#import "../Protocols/BSTableViewExpandableCell.h"


@interface BSEntryDetailValuePickerCell : BSStaticTableViewCell <UIPickerViewDelegate, UIPickerViewDataSource, BSTableViewExpandableCell>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *options;

- (IBAction) controlPressed:(id)sender;

@end
