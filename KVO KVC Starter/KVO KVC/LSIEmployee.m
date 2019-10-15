//
//  LSIEmployee.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIEmployee.h"

@implementation LSIEmployee

- (instancetype)init {
	self = [super init];
	if (self) {
//		_salary = 60000; // this won't trigger a notification before the object is ready
//		self.salary = 60000; // don't use properties here because of side effects
	}
	return self;
}

// Overidding the Setter so we can customize
- (void)setSalary:(NSInteger)salary {
	// Save to firebase
	// Update the UI
	_salary = salary;	// MUST not forget to set the value in a setter!
}


- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

- (void)payRaise {
	
	// Key Value Observering: Notify me when a change happens to a variable
	// Key Value Coding: Compliant means we use properties with getter, setter, and a instance variable (And we always modify properties with our getter/setter methods)
	
	// What happens whe we don't use properties!
	_salary += 10000; // this is not KVC compliant change (observers will not get notified)
	
	
	// Why we always want to use properties
	self.salary += 10000; // This will trigger a KVO notification
	self.salary = self.salary + 10000;
	[self setSalary:[self salary] + 10000]; // method calling syntax
}

@end
