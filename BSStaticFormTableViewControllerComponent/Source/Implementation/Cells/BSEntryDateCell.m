//
//  BSEntryDateCell.m
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSEntryDateCell.h"
#import "BSStaticTableViewCell+Protected.h" // from superclass
#import "../../Headers/BSTableViewEvents.h"
#import "BSStaticTableViewComponentConstants.h"


@interface BSEntryDateCell ()
@end

@implementation BSEntryDateCell

@synthesize entryModel = _entryModel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = CGRectMake(0, self.bounds.size.height, _datePicker.bounds.size.width, _datePicker.bounds.size.height);
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(entryDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        _datePicker.hidden = YES;
        [self addSubview:_datePicker];
        
    }
    
    return self;
}


- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.modelProperty = cellInfo.propertyName;
    self.label.text = NSLocalizedString(cellInfo.displayPropertyName, @"");
    self.entryModel = model;
}

- (void)updateValuesFromModel
{
    id modelValue = [self.entryModel valueForKey:self.modelProperty];
    NSDate* date = nil;
    
    if (modelValue)
    {
        date = modelValue;
    }
    else
    {
        date = [NSDate date];
    }
    
    if (self.valueConvertor)
    {
        self.datePicker.date = [self.valueConvertor cellValueForModelValue:date];
        [self setDateInTitle:[self.valueConvertor cellStringValueValueForModelValue:date]];
    }
    else
    {
        self.datePicker.date = date;
        [self setDateInTitle:[date description]];
    }
}



- (IBAction) entryDatePickerValueChanged:(UIDatePicker *)picker
{
    // Update the model
    if (self.valueConvertor)
    {
        [self.entryModel setValue:[self.valueConvertor modelValueForCellValue:picker.date] forKey:self.modelProperty];
        [self setDateInTitle:[self.valueConvertor cellStringValueValueForModelValue:picker.date]];
    }
    else
    {
        [self.entryModel setValue:picker.date forKey:self.modelProperty];
        [self setDateInTitle:[picker.date description]];
    }
}


- (IBAction) dateButtonPressed:(id)sender
{
    // The view controller is the only one that could know the state of the cell
    // because cells are reused so their values are not reliable unless they get set by the view controller
    BSStaticTableViewCellFoldingEvent *event =[[BSStaticTableViewCellFoldingEvent alloc] init];
    event.indexPath = self.indexPath;
    [self.delegate cell:self eventOccurred:event];
}


- (void)setDateInTitle:(NSString *)date
{
    UIButton *button = (UIButton *)self.control;
    [button setTitle:date forState:UIControlStateNormal];
    [button setTitle:date forState:UIControlStateHighlighted];
    [button setTitle:date forState:UIControlStateSelected];
}


- (void) reset
{
    [self setDateInTitle:[self.valueConvertor cellStringValueValueForModelValue:[NSDate date]]];
}

#pragma mark - BSTableViewExpandableCell

- (void)setUpForFoldedState
{
    // Color of the button when not selected
    UIButton *button = (UIButton *)self.control;

    // UIView returns a default color if no one set it
    [button setTitleColor:self.tintColor forState:UIControlStateNormal];
    
    self.datePicker.hidden = YES;
}


- (void)setUpForUnFoldedState
{
    // Color of the button when selected
    UIButton *button = (UIButton *)self.control;

    // The superclass defaults to a color if not set
    [button setTitleColor:self.selectedTintColor forState:UIControlStateNormal];
    
    self.datePicker.hidden = NO;
}


@end
