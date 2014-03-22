//
//  BSEntryDetailDescriptionAndButtonCell.h
//  BSStaticFormTableViewControllerComponent
//
//  Created by Borja Arias Drake on 18/03/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#import "BSStaticTableViewCell.h"
#import "../Protocols/BSTableViewSelectableCellProtocol.h"

@interface BSEntryDetailDescriptionAndButtonCell : BSStaticTableViewCell <BSTableViewSelectableCellProtocol>

- (IBAction) buttonPressed:(id)sender;

@end
