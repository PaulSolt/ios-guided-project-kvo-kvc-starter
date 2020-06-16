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
//    return self.firstName + " " + self.lastName; // Swift
    NSString *name = self.firstName;
    // "Craig" " " + "" = "Craig "
    if (self.lastName && self.lastName.length != 0) { // don't append " " -> "Craig "
        name = [name stringByAppendingFormat:@" %@", self.lastName];
    }
    return name;
}

// Option 1: Override our setter on the firstName / lastName
//- (void)setFirstName:(NSString *)firstName {
//    // willChangeValue
//    [self willChangeValueForKey:@"name"];  // FIXME: use a constant for key path to prevent bugs
//
//    _firstName = firstName;
//
//    // didChangeValue
//    [self didChangeValueForKey:@"name"];
//}
//
//- (void)setLastName:(NSString *)lastName {
//    // willChangeValue
//    [self willChangeValueForKey:@"name"];  // FIXME: use a constant for key path to prevent bugs
//
//    _lastName = lastName;
//
//    // didChangeValue
//    [self didChangeValueForKey:@"name"];
//}


// Option 2: Add dependent keys
+ (NSSet *)keyPathsForValuesAffectingName {
    return [NSSet setWithObjects:@"lastName", @"firstName", nil];
}

// TODO: NSNumberFormatter with currencyStyle
- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

@end
