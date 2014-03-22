//
//  BSEntryDetailDescriptionAndButtonCell.m
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSEntryDetailDescriptionAndButtonCell.h"
#import "../../Headers/BSTableViewEvents.h"

@implementation BSEntryDetailDescriptionAndButtonCell


- (IBAction) buttonPressed:(id)sender
{
    BSStaticTableViewCellFoldingEvent *event =[[BSStaticTableViewCellFoldingEvent alloc] init];
    event.indexPath = self.indexPath;
    [self.delegate cell:self eventOccurred:event];
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
    
    if (self.valueConvertor)
    {
        [self setTitle:[self.valueConvertor cellStringValueValueForModelValue:modelValue]];
    }
    else
    {
        [self setTitle:[modelValue description]];
    }
}

- (void)setTitle:(NSString *)title
{
    UIButton *button = (UIButton *)self.control;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateSelected];
}


- (void) reset
{
    [self setTitle:[self.valueConvertor cellStringValueValueForModelValue:[NSDate date]]];
}


#pragma mark - BSTableViewExpandableCell

- (void)setUpForDeselectedState
{
    // Color of the button when not selected
    UIButton *button = (UIButton *)self.control;
    
    // UIView returns a default color if no one set it
    [button setTitleColor:self.tintColor forState:UIControlStateNormal];
}


- (void)setUpForSelectedState
{
    // Color of the button when selected
    UIButton *button = (UIButton *)self.control;
    
    // The superclass defaults to a color if not set
    [button setTitleColor:self.selectedTintColor forState:UIControlStateNormal];
}

@end
