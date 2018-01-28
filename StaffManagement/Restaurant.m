//
//  Restaurant.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant

@dynamic name;
@dynamic staff;


- (void)addStaffObject:(NSManagedObject *)value {
    [self.staff addObject:value];
}

- (void)removeStaffObject:(NSManagedObject *)value {
    [self.staff removeObject:value];
}


@end
