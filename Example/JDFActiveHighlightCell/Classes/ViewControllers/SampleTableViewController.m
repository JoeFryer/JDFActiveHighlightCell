//
//  SampleTableViewController.m
//  JDFActiveHighlightCell
//
//  Created by Joe Fryer on 15/06/2014.
//  Copyright (c) 2014 JoeFryer. All rights reserved.
//

#import "SampleTableViewController.h"

// Views
#import "JDFActiveHighlightTableViewCell.h"


// Constants
static NSString *const SampleTableViewControllerCellIdentifier = @"SampleTableViewControllerCellIdentifier";


@interface SampleTableViewController ()

@property (nonatomic, strong) NSArray *tableItems;

@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end


@implementation SampleTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Sample";
    
    self.tableItems = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4", @"Option 5", @"Option 6", @"Option 7", @"Option 8", @"Option 9", @"Option 10", @"Option 11", @"Option 12", @"Option 13", @"Option 14", @"Option 15"];
    
    [self.tableView registerClass:[JDFActiveHighlightTableViewCell class] forCellReuseIdentifier:SampleTableViewControllerCellIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableItem = self.tableItems[indexPath.row];
    
    JDFActiveHighlightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SampleTableViewControllerCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = tableItem;
//    cell.activeHighlightingEnabled = YES;
    
    if (indexPath.section == self.selectedIndex.section && indexPath.row == self.selectedIndex.row) {
        [cell showActiveHighlight];
    } else {
        [cell hideActiveHighlight];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath;
    [tableView reloadData];
}

@end
