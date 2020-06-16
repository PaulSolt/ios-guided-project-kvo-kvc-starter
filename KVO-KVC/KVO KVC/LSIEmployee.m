//
//  LSIEmployee.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIEmployee.h"

@interface LSIEmployee () {
    // private properties
}

@end


@implementation LSIEmployee {
    // private properties
    NSString *_mySecret;
}

// Override getter to make name a computed property
- (NSString *)name {
    return self.firstName;
}


// TODO: NSNumberFormatter with currencyStyle
- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

@end
