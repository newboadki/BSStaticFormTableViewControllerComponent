//
//  BSEntrySegmentedOptionCell.m
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSEntryDetailValuePickerCell.h"
#import "BSStaticTableViewCell+Protected.h" // from superclass
#import "../../Headers/BSTableViewEvents.h"


@implementation BSEntryDetailValuePickerCell

#pragma mark - Initializers

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, self.bounds.size.height, _pickerView.bounds.size.width, _pickerView.bounds.size.height);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;

        [self addSubview:_pickerView];
    }
    
    return self;
}



#pragma mark - from BSStaticTableViewCell

- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.label.text = cellInfo.displayPropertyName;
    self.modelProperty = cellInfo.propertyName;
    self.entryModel = model;

    [self setOptions:cellInfo.extraParams[@"options"]];
}

- (IBAction) controlPressed:(id)sender
{
    // The view controller is the only one that could know the state of the cell
    // because cells are reused so their values are not reliable unless they get set by the view controller
    BSStaticTableViewCellFoldingEvent *event =[[BSStaticTableViewCellFoldingEvent alloc] init];
    event.indexPath = self.indexPath;
    [self.delegate cell:self eventOccurred:event];
}


- (void)updateValuesFromModel
{
    id modelValue = [self.entryModel valueForKey:self.modelProperty];
    if (self.valueConvertor)
    {
        [self.pickerView selectRow:[[self.valueConvertor cellValueForModelValue:modelValue] intValue] inComponent:0 animated:NO];
        [self setDateInTitle:[self.valueConvertor cellStringValueValueForModelValue:modelValue]];
    }
    else
    {
        [self.pickerView selectRow:(int)modelValue inComponent:0 animated:NO];
        [self setDateInTitle:self.options[(int)modelValue]];
    }
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.options[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // Change the model
    if (self.valueConvertor)
    {
        id modelValue = [self.valueConvertor modelValueForCellValue:@(row)];
        [self.entryModel setValue:modelValue forKey:self.modelProperty];
        [self setDateInTitle:[self.valueConvertor cellStringValueValueForModelValue:modelValue]];
    }
    else
    {
        [self.entryModel setValue:@(row) forKey:self.modelProperty];
        [self setDateInTitle:self.options[row]];
    }    
    
    
    // Let delegate know
    BSStaticTableViewCellChangeOfValueEvent *event = [[BSStaticTableViewCellChangeOfValueEvent alloc] initWithNewValue:[self.entryModel valueForKey:self.modelProperty] forPropertyName:self.modelProperty];
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



#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.options count];
}



#pragma mark - BSTableViewExpandableCell

- (void)setUpForFoldedState
{
    // Color of the button when not selected
    UIButton *button = (UIButton *)self.control;
    
    // UIView returns a default color if no one set it
    [button setTitleColor:self.tintColor forState:UIControlStateNormal];
}


- (void)setUpForUnFoldedState
{
    // Color of the button when selected
    UIButton *button = (UIButton *)self.control;
    
    // The superclass defaults to a color if not set
    [button setTitleColor:self.selectedTintColor forState:UIControlStateNormal];
    [self.pickerView reloadAllComponents];
    [self updateValuesFromModel];
}


@end
