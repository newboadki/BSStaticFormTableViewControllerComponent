//
//  BSEntryDetailCell.m
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewCell.h"
#import "BSStaticTableViewCell+Protected.h"

@implementation BSStaticTableViewCell

- (id)init
{
    self = [super init];
    if (self) {
        [self setDefaults];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
    }
    return self;
}



- (void)setDefaults
{
    _defaultSelectedTintColor = [UIColor redColor];
}

- (UIColor *)selectedTintColor
{
    if (!_selectedTintColor)
    {
        return self.defaultSelectedTintColor;
    }
    
    return _selectedTintColor;
}


- (void) becomeFirstResponder
{
    [super becomeFirstResponder];
    [self.control becomeFirstResponder];
    
}


- (void) resignFirstResponder
{
    [super resignFirstResponder];
    [self.control resignFirstResponder];
}


- (void) reset
{

}


- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model
{
    @throw [NSException exceptionWithName:@"Abstract method" reason:@"Implement in subclasses" userInfo:nil];
}


- (void)updateValuesFromModel
{

}

@end
