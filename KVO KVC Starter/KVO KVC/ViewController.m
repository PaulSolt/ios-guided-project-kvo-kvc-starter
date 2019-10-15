//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
    NSLog(@"%@", self.hrController);
	
	NSString *name = philSchiller.name; // use the property
	NSLog(@"Name1: %@", name);
	
	name = [philSchiller valueForKey:@"name"]; // - (NSString *)name { }
    NSLog(@"Name2: %@", name);
	
	// You can access values that are "private" if you know the name of the key
	// You can use this to reverse engineer iOS related things and call private APIs
	
	[philSchiller setValue:@"Philip" forKey:@"name"];
	name = [philSchiller valueForKey:@"name"]; // - (NSString *)name { }
    NSLog(@"Name3: %@", name);
	
	// This will crash if the types don't match!!!
//	[philSchiller setValue:philSchiller forKey:@"name"];
//	name = [philSchiller valueForKey:@"name"]; // - (NSString *)name { }
//    NSLog(@"Name4: %@", name);

	
	
	NSLog(@"AllEmployees: %@", self.hrController.allEmployees);
	
	NSLog(@"All: %@", [self.hrController valueForKey:@"allEmployees"]);
	
	NSLog(@"Departments: %@", [self.hrController valueForKeyPath:@"departments"]);
	
	// NSArray of NSArrays of LSIEmployee (NSArray <NSArray<LSIEmployee *> *> *)
	NSLog(@"departments.employees: %@", [self.hrController valueForKeyPath:@"departments.employees"]);
	
	// Combine into one array: NSArray<LSIEmployee *>
	NSLog(@"departments.employees: %@", [self.hrController valueForKeyPath:@"departments.@unionOfArrays.employees"]);
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;
	formatter.alwaysShowsDecimalSeparator = NO;	// TODO: why doesn't this work at removing ".00" ... clashing with numberStyle?
	
	NSLog(@"Highest paid: %@", [self.hrController highestPaidEmployee]);
	NSLog(@"Highest paid: %li", self.hrController.highestPaidEmployee.salary);
	
	// Boxing the number into NSNumber object
	NSLog(@"Phil's Salary is: %@", [formatter stringFromNumber:@(self.hrController.highestPaidEmployee.salary)]);
	
	
	NSLog(@"%li", self.hrController.highestSalary);
}

// Outlet

- (IBAction)givePhilARaisePressed:(id)sender {
	NSPredicate *nameIsPhilPredicate = [NSPredicate predicateWithFormat:@"name == %@", @"Philip"];
	
	LSIEmployee *phil = [[self.hrController.allEmployees filteredArrayUsingPredicate:nameIsPhilPredicate] firstObject];
	
	phil.salary += 7000000;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	formatter.numberStyle = NSNumberFormatterCurrencyStyle;

	NSLog(@"Phil's Salary: %@", [formatter stringFromNumber:@(phil.salary)]);
}


@end
