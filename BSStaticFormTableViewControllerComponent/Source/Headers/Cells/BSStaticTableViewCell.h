//
//  BSEntryDetailCell.h
//  Expenses
//
//  Created by Borja Arias Drake on 10/08/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CellDescriptors/BSStaticTableViewCellInfo.h"
#import "../Events/BSStaticTableViewCellAbstractEvent.h"
#import "../BSStaticTableViewComponentConstants.h"
#import "../Protocols/BSStaticFormTableCellValueConvertorProtocol.h"
#import "../Protocols/BSTableViewExpandableCell.h"
#import "../Protocols/BSStaticTableViewCellDelegateProtocol.h"

@interface BSStaticTableViewCell : UITableViewCell

@property (strong, nonatomic) id entryModel;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSString *modelProperty;
@property (strong, nonatomic) id<BSStaticFormTableCellValueConvertorProtocol> valueConvertor;

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIControl *control;
@property (strong, nonatomic) IBOutlet id<BSStaticTableViewCellDelegateProtocol> delegate;


@property (strong, nonatomic) UIColor *selectedTintColor;

- (void) becomeFirstResponder;
- (void) resignFirstResponder;
- (void) reset;
- (void) configureWithCellInfo:(BSStaticTableViewCellInfo *)cellInfo andModel:(id)model;
- (void)updateValuesFromModel;

@end
