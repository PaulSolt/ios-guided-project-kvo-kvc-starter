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
    
    NSLog(@"%@", craig.name); // Checked by the compiler (name property exists it compiles, else compiler error)

    NSLog(@"%@", [craig valueForKey:@"name"]);
    //    NSLog(@"%@", [craig valueForKey:@"nameEE"]); // CRASH: this class is not key value coding-compliant for the key nameEE (Storyboards)

    [craig setValue:@"Bob" forKey:@"name"]; // Setter to change Craig's name
    NSLog(@"%@", [craig valueForKey:@"name"]); // Getter to get Craig's name

    // .h (header) public
    // .m (implemention) private

    // Private API call (Apple prevents you from shipping apps on the App Store that call private APIs)

    NSLog(@"%@", [craig valueForKey:@"privateName"]);
    NSLog(@"%@", [craig valueForKey:@"privateVariable"]); // Objc will search for either propertyName or the _instanceVariable name
    NSLog(@"%@", [craig valueForKey:@"_privateVariable"]);

    // KeyPath: traverse the object heirarchy

    NSLog(@"Departments: %@", self.hrController.departments); // dot syntax
    NSLog(@"Departments: %@", [[self hrController] departments]); // message calling

    // [Departments]
    NSLog(@"Departments: %@", [self.hrController valueForKeyPath:@"departments"]);

    // [[Employees]]
    NSLog(@"Departments.employees: %@", [self.hrController valueForKeyPath:@"departments.employees"]);

    // [Employees]
    NSArray *allEmployees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"];
    NSLog(@"Departments.employees (union): %@", allEmployees);

//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (LSIDepartment *department in self.hrController.departments) {
//        for (LSIEmployee *employee in department.employees) {
//            if (![array containsObject:employee]) {
//                [array addObject:employee];
//            }
//        }
//    }
//    NSLog(@"All employees: %@", array);
    
    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"salary"]);  // map (Employee -> Salary)
    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"@max.salary"]);
    
    NSLog(@"Salaries: %@", [allEmployees valueForKeyPath:@"@avg.salary"]);

}


@end
