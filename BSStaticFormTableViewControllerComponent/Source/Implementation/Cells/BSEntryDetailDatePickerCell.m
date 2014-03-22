//
//  BSEntryDetailDatePickerCell.m
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSEntryDetailDatePickerCell.h"
#import "BSStaticTableViewCell+Protected.h" // from superclass
#import "../../Headers/BSTableViewEvents.h"


@implementation BSEntryDetailDatePickerCell

- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.modelProperty = cellInfo.propertyName;
    self.entryModel = model;
}


- (void)updateValuesFromModel
{
    UIDatePicker *datePicker = (UIDatePicker *)self.control;
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
        datePicker.date = [self.valueConvertor cellValueForModelValue:date];
    }
    else
    {
        datePicker.date = date;
    }
}


- (IBAction) entryDatePickerValueChanged:(UIDatePicker *)picker
{
    // Update the model
    if (self.valueConvertor)
    {
        [self.entryModel setValue:[self.valueConvertor modelValueForCellValue:picker.date] forKey:self.modelProperty];
    }
    else
    {
        [self.entryModel setValue:picker.date forKey:self.modelProperty];
    }
    
    // Notify
    BSStaticTableViewCellChangeOfValueEvent *event = [[BSStaticTableViewCellChangeOfValueEvent alloc] initWithNewValue:[self.entryModel valueForKey:self.modelProperty] forPropertyName:self.modelProperty];
    event.indexPath = self.indexPath;
    [self.delegate cell:self eventOccurred:event];

}

@end
