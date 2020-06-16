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

// deinit in Swift
- (void)dealloc {
    // We must remove our observer exactly once
    
    // Craig isn't an instance variable, we can't unobserve here ...
}

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.firstName = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.firstName = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.firstName = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.firstName = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.firstName = @"Joe";
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

    // 1. setter must be of form "setPropertyName"
    // 2. getter must be of form "propertyName"

    // If things are not named correctly, following the naming convention, your app will crash at run-time
    // There are no compile time checks ... super dynamic feature

    NSString *name = [craig valueForKey:@"firstName"]; // FIXME: Use a constant so you don't accidentally make typos all over your code
    NSLog(@"name: %@", name);

    // Property will automatically create a setter/getter that is KVC
    [craig setValue:@"Hair Force One" forKey:@"firstName"]; // will call the setName method
    NSLog(@"name: %@", craig.name);
    
    // We can set a "private" property using KVC
    [craig setValue:@"I love long walks on the beach" forKey:@"_mySecret"]; // _mySecret or mySecret

    NSString *secret = [craig valueForKey:@"_mySecret"];
    NSLog(@"secret: %@", secret);
    
    // KVO - Key Value Observing (Hook for logic or UI updates)

    // Listen to any changes to a value

    // KVO Compliant - NSOperation and NSOperationQueue

    [craig addObserver:self forKeyPath:@"name" options:0 context:nil];

    // Attempt to change name
    NSLog(@"Changing Craig's name");
    craig.firstName = @"Craig";
    craig.lastName = @"Federighi";
    
    // Future: Remove observer (you can only do this once or it will crash!!!)
    
    [craig removeObserver:self forKeyPath:@"name"]; // will crash if called multiple times, or wrong key path
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"observeValueForKeyPath");
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"%@ keypath has changed to value: %@", keyPath, [object valueForKey:keyPath]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
