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

    NSLog(@"%@", craig);
    // Key Value Coding (dictionary)
    // "name"
    NSLog(@"%@", craig.name); // dot syntax: checked by compiler
    NSLog(@"%@", [craig name]); // method call: checked by compiler

    NSLog(@"%@", [craig valueForKey:@"name"]); // not checked by compiler for being a valid key path

    [craig setValue:@"Hair Force One" forKey:@"name"];
//    [craig setValue:@"Hair Force One" forKey:@"nameeee"];
    // @"nameee" crashes! this class is not key value coding-compliant for the key nameeee.'


    NSLog(@"%@", craig.name);
    
    // System will search for _likesLongWalksOnBeach and likesLongWalksOnBeach
    NSLog(@"Long walks: %@",[craig valueForKey:@"likesLongWalksOnBeach"]);
    
    NSLog(@"%@", self.hrController.allEmployees);
    
}


@end
