//
//  BSAddEntryViewController.m
//  Expenses
//
//  Created by Borja Arias Drake on 25/06/2013.
//  Copyright (c) 2013 Borja Arias Drake. All rights reserved.
//

#import "BSStaticFormTableViewController.h"

#import "../../Headers/BSCells.h"
#import "../../Headers/BSTableViewCellActions.h"
#import "../../Headers/BSTableViewEvents.h"
#import "../../Headers/BSTableViewCellDescriptors.h"

@interface BSPendingTableViewActions : NSObject

@property (nonatomic, strong) NSMutableDictionary *actionsForIndexPath;

- (void)addAction:(BSStaticTableViewAbstractAction *)action forIndexPath:(NSIndexPath *)indexPath;

- (void)removeAction:(BSStaticTableViewAbstractAction *)action forIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)actionsForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BSPendingTableViewActions

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self)
    {
        _actionsForIndexPath = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}



#pragma mark - Public Interface

- (void)addAction:(BSStaticTableViewAbstractAction *)action forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *currentActionsForIndexPath = self.actionsForIndexPath[indexPath];
    
    if (![currentActionsForIndexPath containsObject:action])
    {
        if (!currentActionsForIndexPath)
        {
            currentActionsForIndexPath = [[NSMutableArray alloc] initWithObjects:action, nil];
            self.actionsForIndexPath[indexPath] = currentActionsForIndexPath;
        }
        else
        {
            [currentActionsForIndexPath addObject:action];
        }
    }
}


- (void)removeAction:(BSStaticTableViewAbstractAction *)action forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *currentActionsForIndexPath = self.actionsForIndexPath[indexPath];
    [currentActionsForIndexPath removeObject:action];
}


- (NSArray *)actionsForIndexPath:(NSIndexPath *)indexPath
{
    return self.actionsForIndexPath[indexPath];
}

@end




@interface BSStaticFormTableViewController ()

/*! List of index paths that have been added as a consequence of an event 
 on another row. These events are reversable, meaning that these rows can be removed.*/
@property (nonatomic, strong) NSMutableArray *unfoldedCells;

/*! List of all the cell actions that have not been executed yet. The main reason
 for this could be that the actions were raised when the target cells were not visible.
 Therefore, this pending actions get removed from this array once the cells appear.*/
@property (nonatomic, strong) BSPendingTableViewActions *pendingActions;

@end




@implementation BSStaticFormTableViewController



#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (self.isEditingEntry)
    {
        self.title = NSLocalizedString(@"Edit entry", @"");
    }
    else
    {
        self.title = NSLocalizedString(@"Add entry", @"");
    }
        
    // Create array for expandable cells
    self.unfoldedCells = [NSMutableArray array];
    
    // Create array for pending actions
    self.pendingActions = [[BSPendingTableViewActions alloc] init];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    for (UITableViewCell *cell in [self.tableView visibleCells])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        // Apply pending actions
        NSArray *pendingActions = [self.pendingActions actionsForIndexPath:indexPath];
        [self applyActionsInArray:pendingActions];        
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView willDisplayCell:(BSStaticTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSStaticTableViewCellInfo *cellInfo = [self.cellActionDataSource cellInfoForIndexPath:indexPath];
    
    // Safe Guard
    if (![cell isKindOfClass:[BSStaticTableViewCell class]])
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The cell needs to be an instance of BSEntryDetailCell" userInfo:nil];
    }
    
    cell.indexPath = indexPath;
    
    // Configure the cell from the cell info
    [cell configureWithCellInfo:cellInfo andModel:self.entryModel];
    
    // Update the cell value convertor
    cell.valueConvertor = [self.cellActionDataSource valueConvertorForCellAtIndexPath:indexPath];
    [cell updateValuesFromModel];
    
    // Apply pending actions
    NSArray *pendingActions = [self.pendingActions actionsForIndexPath:indexPath];
    [self applyActionsInArray:pendingActions];
    
    // Apply appearance
    [self.appearanceDelegate themeTableViewCell:cell];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.unfoldedCells containsObject:indexPath])
    {
        return 162.0f;
    }
    else
    {
        return 44.0f;
    }
}


- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - UITableView Data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.cellActionDataSource sectionsInfo] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BSStaticTableViewSectionInfo *sectionInfo = (BSStaticTableViewSectionInfo *)[self.cellActionDataSource sectionsInfo][section];
    return [sectionInfo.cellClassesInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *reuseIdentifier = [[[self.cellActionDataSource cellInfoForIndexPath:indexPath] cellClass] description];
    BSStaticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        Class cellClass = NSClassFromString(reuseIdentifier);
        cell = [[cellClass alloc] init];
        cell.delegate = self;
    }
    
    return cell;
}



#pragma mark - Actions

- (IBAction) addEntryPressed:(id)sender
{
    // do nothing by default
}

- (IBAction) cancelButtonPressed:(id)sender
{
    // do nothing by default
}

- (BOOL) saveModel:(NSError **)error
{
    // do nothing by default
    return NO;
}



#pragma mark - EntryDetailCellDelegateProtocol

- (void)cell:(UITableViewCell *)cell eventOccurred:(BSStaticTableViewCellAbstractEvent *)event
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath)
    {
        indexPath = event.indexPath;
    }
    NSArray *actions = [self.cellActionDataSource actionsForEvent:event inCellAtIndexPath:indexPath];
    [self applyActionsInArray:actions];
}



#pragma mark - Event handling helpers

- (void)applyActionsInArray:(NSArray *)actions
{
    for (BSStaticTableViewAbstractAction *action in actions)
    {
        if ([action isKindOfClass:[BSStaticTableViewCellAction class]])
        {
            [self applyTableViewCellAction:(BSStaticTableViewCellAction *)action];
        }
        else if ([action isKindOfClass:[BSStaticTableViewDismissYourselfAction class]])
        {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        else if ([action isKindOfClass:[BSStaticTableViewInsertRowAction class]])
        {
            [self applyInsertRowAction:(BSStaticTableViewInsertRowAction *)action];
        }
        else if ([action isKindOfClass:[BSStaticTableViewRemoveRowAction class]])
        {
            [self applyRemoveRowAction:(BSStaticTableViewRemoveRowAction *)action];
        }
        else if ([action isKindOfClass:[BSStaticTableViewSelectRowAction class]])
        {
            [self applySelectRowAction:(BSStaticTableViewSelectRowAction *)action];
        }
        else if ([action isKindOfClass:[BSStaticTableViewDeselectRowAction class]])
        {
            [self applyDeselectRowAction:(BSStaticTableViewDeselectRowAction *)action];
        }
        else if ([action isKindOfClass:[BSStaticTableViewReloadCellFromModel class]])
        {
            [self applyReloadRowFromModelAction:(BSStaticTableViewReloadCellFromModel *)action];
        }
        
        

    }
}

-(void)applyInsertRowAction:(BSStaticTableViewInsertRowAction *)action
{
    // Save that we inserted a cell at the index path
    NSIndexPath *ip = action.indexPathsToApplyActionTo.firstObject;
    [self.unfoldedCells addObject:ip];
    
    // Resign first responders
    for (UITableViewCell *c in self.tableView.visibleCells)
    {
        [c resignFirstResponder];
    }
    
    // insert the cell (data source already updated)
    [self updateUnfoldedCellsIndexpathsAtIndexPath:ip afterInsertion:YES]; // Needs to happen before, because deleteRowsAtIndexPaths reloads the table which calls height for cell at ip
    [self.tableView insertRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
    
}


-(void)applyRemoveRowAction:(BSStaticTableViewRemoveRowAction *)action
{
    // Remove the cell from the array
    NSIndexPath *ip = action.indexPathsToApplyActionTo.firstObject;
    [self.unfoldedCells removeObject:ip];
    
    // remove the cell (data source already updated)
    [self updateUnfoldedCellsIndexpathsAtIndexPath:ip afterInsertion:NO]; // Needs to happen before, because deleteRowsAtIndexPaths reloads the table which calls height for cell at ip
    [self.tableView deleteRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationFade];
    
}


- (void)applySelectRowAction:(BSStaticTableViewSelectRowAction *)action
{
    NSIndexPath *ip = action.indexPathsToApplyActionTo.firstObject;
    BSStaticTableViewCell *cellToPerformActionOn = (BSStaticTableViewCell *)[self.tableView visibleCells][ip.row];
    if (cellToPerformActionOn)
    {
        if ([cellToPerformActionOn conformsToProtocol:@protocol(BSTableViewSelectableCellProtocol)])
        {
            [cellToPerformActionOn performSelector:@selector(setUpForSelectedState)];
        }
    }
}

- (void)applyDeselectRowAction:(BSStaticTableViewDeselectRowAction *)action
{
    NSIndexPath *ip = action.indexPathsToApplyActionTo.firstObject;
    BSStaticTableViewCell *cellToPerformActionOn = (BSStaticTableViewCell *)[self.tableView cellForRowAtIndexPath:ip];
    if (cellToPerformActionOn)
    {
        if ([cellToPerformActionOn conformsToProtocol:@protocol(BSTableViewSelectableCellProtocol)])
        {
            [cellToPerformActionOn performSelector:@selector(setUpForDeselectedState)];
        }
    }
}


- (void)applyReloadRowFromModelAction:(BSStaticTableViewReloadCellFromModel *)action
{
    NSIndexPath *ip = action.indexPathsToApplyActionTo.firstObject;
    BSStaticTableViewCell *cellToPerformActionOn = (BSStaticTableViewCell *)[self.tableView visibleCells][ip.row];
    [cellToPerformActionOn updateValuesFromModel];
}


- (void)applyTableViewCellAction:(BSStaticTableViewCellAction *)action
{
    for (NSIndexPath *ip in action.indexPathsOfCellsToPerformActionOn)
    {
        BSStaticTableViewCell *cellToPerformActionOn = (BSStaticTableViewCell *)[self.tableView visibleCells][ip.row];
        if (cellToPerformActionOn)
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [cellToPerformActionOn performSelector:action.selector withObject:action.object];
            #pragma clang diagnostic pop
            //[self.pendingActions removeAction:action forIndexPath:ip];
        }
        else
        {
            [self.pendingActions addAction:action forIndexPath:ip];
        }
    }
}


- (void)updateUnfoldedCellsIndexpathsAtIndexPath:(NSIndexPath *)indexPath afterInsertion:(BOOL)isInsertion
{
    NSMutableArray *modifiedArray = [NSMutableArray array];
    
    for (NSIndexPath *ip in self.unfoldedCells)
    {
        if ( (indexPath.section == ip.section) && (indexPath.row < ip.row) )
        {
            NSInteger newRowIndex = (ip.row - 1); // default is deletion
            if (isInsertion)
            {
                newRowIndex = (ip.row + 1);
            }
            NSIndexPath *modifiedIndexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:ip.section];
            [modifiedArray addObject:modifiedIndexPath];
        }
        else
        {
            [modifiedArray addObject:ip];
        }
    }
    
    self.unfoldedCells = modifiedArray;
}


#pragma mark - BSStaticTableViewCellDelegateProtocol

- (void) textFieldShouldreturn {
    
}

@end