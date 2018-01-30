//
//  AddWaiterViewController.m
//  StaffManagement
//
//  Created by Daniel Grosman on 2018-01-26.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import "AddWaiterViewController.h"
#import "AppDelegate.h"
#import "Waiter.h"
#import "Restaurant.h"
#import "RestaurantManager.h"


@interface AddWaiterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong,nonatomic) Restaurant *currentRestaurant;

@end

@implementation AddWaiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
}

- (IBAction)saveWaiter:(UIButton *)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSError *error = nil;
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
    Waiter *newWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    newWaiter.name = self.nameTextField.text;
    newWaiter.restaurant = self.currentRestaurant;
    [self.currentRestaurant addStaffObject:newWaiter];
    [appDelegate.managedObjectContext save:&error];
    [self.navigationController popToRootViewControllerAnimated:YES]; 
}


@end
