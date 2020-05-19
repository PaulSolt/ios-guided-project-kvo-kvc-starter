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

// Public
@property (nonatomic, copy) NSString *name; // @"name"
@property (nonatomic, copy) NSString *jobTitle; // @"jobTitle"
@property (nonatomic) NSInteger salary; // @"salary"

@end

NS_ASSUME_NONNULL_END
