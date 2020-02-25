//
//  LSIEmployee.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIEmployee.h"

@implementation LSIEmployee

- (void)boostSalary {
    // KVC: Key Value Coding - compliant, always use the property setter/getter
    self.salary = self.salary + 500;
//    _salary = _salary + 500;  // NOT KVC compliant
}

//- (void)setSalary:(NSInteger)salary {
//
//}

//- (NSInteger)salary {
//
//}


// Swift: CustomStringConvertible
//var description {
//    return "My custom string: \(name)"
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

@end
