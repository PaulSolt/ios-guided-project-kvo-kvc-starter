//
//  LSIHRDepartment.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIHRController.h"
#import "LSIDepartment.h"

@interface LSIHRController ()

@property (nonatomic) NSMutableArray <LSIDepartment *> *internalDepartments;
@end


@implementation LSIHRController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalDepartments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addDepartment:(LSIDepartment *)department {
    [self.internalDepartments addObject:department];
}

- (NSArray<LSIDepartment *> *)departments {
    return [self.internalDepartments copy];
}

// NSMutableArray vs. NSArray
//- (NSArray<LSIEmployee *> *)allEmployees {
//	// Goal: To return all employees from all departments
//    NSMutableArray<LSIEmployee *> *allEmployees = [[NSMutableArray alloc] init];
//    for (LSIDepartment *department in self.departments) {
//        [allEmployees addObjectsFromArray:department.employees];
//    }
//    return allEmployees;
//}

- (NSArray<LSIEmployee *> *)allEmployees {
	// Goal: To return all employees from all departments
	NSArray<LSIEmployee *> *allEmployees = [[NSArray alloc] init];
    for (LSIDepartment *department in self.departments) {
		allEmployees = [allEmployees arrayByAddingObjectsFromArray:department.employees];
    }
    return allEmployees;
}

//// Don't keep reallocating space because we have lots of employees and departments
//- (NSArray<LSIEmployee *> *)allEmployees {
//	// Find out how many employees in company
//	// Allocate an array with that size
//	NSMutableArray *allEmployees = [[NSMutableArray alloc] initWithCapacity:150];
//	for (LSIDepartment *department in self.departments) {
//		[allEmployees addObjectsFromArray:department.employees];
//	}
//	return allEmployees;
//}

- (NSString *)description {
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendString:@"Departments:\n"];
    for (LSIDepartment *department in self.departments) {
        [output appendFormat:@"%@", department];
    }
    return output;
}


@end
