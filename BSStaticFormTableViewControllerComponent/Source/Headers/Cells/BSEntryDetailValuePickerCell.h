//
//  BSEntryDetailValuePickerCell.h
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 15/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSStaticTableViewCell.h"

@interface BSEntryDetailValuePickerCell : BSStaticTableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *options;

@end
