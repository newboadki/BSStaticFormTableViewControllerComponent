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
    [self setOptionImages:cellInfo.extraParams[@"optionImages"]];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // Change the model
    if (self.valueConvertor)
    {
        id modelValue = [self.valueConvertor modelValueForCellValue:self.options[row]];
        [self.entryModel setValue:modelValue forKey:self.modelProperty];
    }
    else
    {
        [self.entryModel setValue:self.options[row] forKey:self.modelProperty];
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


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.optionImages[row]];
    CGRect imageFrame = imageView.frame;
    imageFrame.origin.x += 70;
    imageView.frame = imageFrame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 40, 0, 100, imageView.frame.size.height)];


    label.text = self.options[row];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.control.frame.size.width, imageView.frame.size.height)];
    [customView addSubview:label];
    [customView addSubview:imageView];
    
    return customView;
}


@end
