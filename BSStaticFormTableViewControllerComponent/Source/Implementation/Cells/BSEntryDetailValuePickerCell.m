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


#pragma mark - from BSStaticTableViewCell

- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.label.text = cellInfo.displayPropertyName;
    self.modelProperty = cellInfo.propertyName;
    self.entryModel = model;

    [self setOptions:cellInfo.extraParams[@"options"]];
    UIPickerView *pickerView = (UIPickerView *)[self viewWithTag:333];
    pickerView.delegate = self; //why isn't IB doing this?
    pickerView.dataSource = self;
    [pickerView reloadAllComponents];
}


- (void)updateValuesFromModel
{
    UIPickerView *pickerView = (UIPickerView *)[self viewWithTag:333];
    id modelValue = [self.entryModel valueForKey:self.modelProperty];
    if (self.valueConvertor)
    {
        [pickerView selectRow:[[self.valueConvertor cellValueForModelValue:modelValue] intValue] inComponent:0 animated:NO];
    }
    else
    {
        [pickerView selectRow:(int)modelValue inComponent:0 animated:NO];
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
    }
    else
    {
        [self.entryModel setValue:@(row) forKey:self.modelProperty];
    }    
    
    
    // Let delegate know
    BSStaticTableViewCellChangeOfValueEvent *event = [[BSStaticTableViewCellChangeOfValueEvent alloc] initWithNewValue:[self.entryModel valueForKey:self.modelProperty] forPropertyName:self.modelProperty];
    event.indexPath = self.indexPath;
    [self.delegate cell:self eventOccurred:event];

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

@end
