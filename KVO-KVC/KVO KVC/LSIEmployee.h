//
//  LSIEmployee.h
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIEmployee : NSObject

// Make name a computed property: "firstName lastName"
@property (nonatomic, readonly) NSString *name; // computed property!
@property (nonatomic, copy) NSString *firstName; // _firstName
@property (nonatomic, copy) NSString *lastName; // _lastName

@property (nonatomic, copy) NSString *jobTitle; // _jobTitle
@property (nonatomic) NSInteger salary; // _salary

@end

NS_ASSUME_NONNULL_END
