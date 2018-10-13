//
//  BSEntryTextDetail.m
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSEntryTextDetail.h"
#import "BSStaticTableViewCell+Protected.h" // from superclass
#import <objc/runtime.h>

@interface BSEntryTextDetail ()
@property (strong, nonatomic) UIColor *defaultPositiveSignColor;
@property (strong, nonatomic) UIColor *defaultNegativeSignColor;
@end

@implementation BSEntryTextDetail

@synthesize entryModel = _entryModel;

- (void)setDefaults
{
    [super setDefaults];
    _defaultNegativeSignColor = [UIColor redColor];
    _defaultPositiveSignColor = [UIColor greenColor];
}

- (IBAction) textFieldChanged:(UITextField *)textField
{
    if (self.valueConvertor)
    {
        [self.entryModel setValue:[self.valueConvertor modelValueForCellValue:textField.text] forKey:self.modelProperty];
    }
    else
    {
        [self.entryModel setValue:textField.text forKey:self.modelProperty];
    }    
}


- (id) instanceOfClass:(Class)class withValueString:(NSString *)value
{
    if (class == [NSDecimalNumber class])
    {
        return [NSDecimalNumber decimalNumberWithString:value];
    }
    else if (class == [NSString class])
    {
        return value;
    }
    else
    {
        return nil;
    }
}


- (void) displayPlusSign
{
    UITextField *textField = (UITextField *)self.control;
    textField.textColor = self.positiveSignColor;
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self textFieldChanged:textField];
}


- (void) displayMinusSign
{
    UITextField *textField = (UITextField *)self.control;
    textField.textColor = self.negativeSignColor;
    [self textFieldChanged:textField];
}


#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate textFieldShouldreturn];
    return NO;
}

- (void) reset
{
    UITextField *textField = (UITextField *)self.control;
    textField.text = @"";
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    if (_keyboardType != keyboardType) {
        UITextField *textField = (UITextField *)self.control;
        textField.keyboardType = keyboardType;
    }
}


- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    self.modelProperty = cellInfo.propertyName;
    self.label.text = NSLocalizedString(cellInfo.displayPropertyName, @"");
    self.keyboardType = cellInfo.keyboardType;
    
    if (cellInfo.shouldBecomeFirstResponderWhenNotEditing)
    {
        [self becomeFirstResponder];
    }
    
    self.entryModel = model;
}


- (void)updateValuesFromModel
{
    UITextField *textField = (UITextField *)self.control;
    
    if (self.valueConvertor)
    {
        textField.text = [[self.valueConvertor cellValueForModelValue:[self.entryModel valueForKey:self.modelProperty]] description];
    }
    else
    {
        textField.text = [[self.entryModel valueForKey:self.modelProperty] description];
    }
}

#pragma mark - Accessors

- (UIColor *)positiveSignColor
{
    if (_positiveSignColor)
    {
        return _positiveSignColor;
    }
    else
    {
        return self.defaultPositiveSignColor;
    }
}

- (UIColor *)negativeSignColor
{
    if (_negativeSignColor)
    {
        return _negativeSignColor;
    }
    else
    {
        return self.defaultNegativeSignColor;
    }
}

@end
