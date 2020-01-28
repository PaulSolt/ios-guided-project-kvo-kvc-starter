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
    
    //NSLog(@"%@", self.hrController);
    
    // Key Value Coding: KVC
    // * Core Data
    // * Cocoa Bindings (UI + Model = SwiftUI)

    // @property NSString *name;  // Properties are automatically KVC

    // 1. Accessor for a property
        // - (NSString *)name;
    // 2. Setter for a property
        // - (void)setName:(NSString *)name
    // 3. Instance variable to set

    // Modify our Data using the self.name syntax (not _name)
    // 1. init/dealloc always use: _name =
    // 2. Normal methods always use: self.name =
    
    // Property accessor (method call or the property dot syntax)
    NSString *name = [craig name];  // craig.name; // Compile Time Checking for valid properties
    NSLog(@"Name: %@", name);

    // Dynamic method call - look up methods and call them via a NSString name

//    NSString *name2 = [craig valueForKey:@"name"];
//    NSString *name2 = [craig valueForKey:@"firstName"]; // No build issues, CRASHES at runtime!
    NSString *name2 = [craig valueForKey:@"privateName"]; // No build issues, accesses a private property
    NSLog(@"Name2: %@", name2);
    
    
}


@end
