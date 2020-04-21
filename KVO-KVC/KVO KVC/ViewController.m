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
    LSIEmployee *philSchiller = [[LSIEmployee alloc] init];
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
    
    // KVC - Key Value Coding

    // 1. Property setter:
    //    - (void)setVariableName:(MyType *)variable
    // 2. Property getter:
    //    - (MyType *)variableName;
    // 3. Backing instance variable
    //    MyType *_variableName;

    // If we follow the convention we can call methods using a dynamic string name

    // KVO + KVC power Core Data, Storyboards, IBActions/IBOutlets

    // At compile time there is no type checking, name checking, spelling checking
    NSString *name = [craig valueForKey:@"name"]; // Sending a message with string value: @"name"
    //NSString *name = [craig valueForKey:@"firstName"]; // Crashes because firstName doesn't exist!

    NSLog(@"Name: %@", name);

    name = craig.name;   // dot syntax that calls the method [craig name]
    //name = craig.nname;   // Error: Fails to Compile! Properties are checked at compile time
    name = [craig name]; // method
    
    // You can change values using the key
    [craig setValue:@"Hair Force One" forKey:@"name"];
    NSLog(@"Name: %@", craig.name);

    [craig setValue:@2000000 forKey:@"salary"];
    NSLog(@"Salary: %ld", craig.salary);

    // Be careful with setting the wrong type on an object, it can have unpredictable results at
    // runtime
    [craig setValue:@2 forKey:@"name"]; // @2 -> NSNumber(2) -> description -> @"2" (does not crash)
    NSLog(@"Name: %@", craig.name);

    [craig setValue:@"Empty" forKey:@"salary"]; // NSString -> longValue -> default to 0
    NSInteger test = @"Empty".integerValue; // 0 if this isn't a number
    NSLog(@"test: %ld", test);
    NSLog(@"Salary: %ld", craig.salary);
}


@end
