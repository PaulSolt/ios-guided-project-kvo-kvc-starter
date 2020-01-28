//
//  LSIEmployee.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIEmployee.h"

@interface LSIEmployee () {
    NSString *_privateVariable;
}

// Private property
@property (nonatomic, copy) NSString *privateName;

@end

@implementation LSIEmployee

- (instancetype)init {
    self = [super init];
    if (self) {
        _privateName = @"Hair Force One";
        _privateVariable = @"Secret Message";
    }
    return self;
}


// NSObject and we can override to provide implementation
// CustomStringConvertible in Swift 
// CustomDebugStringConvertible in Swift
- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

@end
