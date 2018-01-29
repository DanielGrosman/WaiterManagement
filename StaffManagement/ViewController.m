//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "AppDelegate.h"
#import "StaffManagement-Swift.h"

//static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController () <UITableViewDelegate>
@property IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *waiters;
@property (nonatomic) Restaurant *currentRestaurant;
@property (nonatomic) Waiter *waiter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadTableViewData];
}

-(void) loadTableViewData {
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    self.currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
//    [self reloadInputViews];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiters.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    self.waiter = self.waiters[indexPath.row];
    cell.textLabel.text = self.waiter.name;
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing == YES)
    {
        [self.tableView setEditing:true];
    } else {
        [self.tableView setEditing:false];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing) {
    return YES;
    }
    else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSError *error = nil;
        Waiter *waiter = self.waiters[indexPath.row];
        [appDelegate.managedObjectContext deleteObject:waiter];;
        [self.currentRestaurant removeStaffObject:waiter];
        [appDelegate.managedObjectContext save:&error];
        [self loadTableViewData];
    }
        [self.tableView reloadData];
}

#pragma mark - Prepare for Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"waiterShifts"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.waiter = self.waiters[indexPath.row];
        WaiterShiftViewController *vc = [segue destinationViewController];
        vc.waiter = self.waiter;
        vc.waiterName = self.waiter.name;
}
}

@end
