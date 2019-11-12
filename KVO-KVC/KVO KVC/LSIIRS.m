//
//  LSIIRS.m
//  KVO KVC
//
//  Created by Paul Solt on 11/12/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIIRS.h"
#import "LSIEmployee.h"

@interface LSIIRS ()

@property (nonatomic, strong) NSMutableArray *monitoredEmployees;

@end

@implementation LSIIRS

- (instancetype)init {
    self = [super init];
    if (self) {
        _monitoredEmployees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startMonitoringEmployee:(LSIEmployee *)employee {
	// Listen to changes to a property
	
	[employee addObserver:self forKeyPath:@"salary" options:0 context:NULL];
	
}

- (void)stopMonitoringEmployee:(LSIEmployee *)employee {
	[employee removeObserver:self forKeyPath:@"salary"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	LSIEmployee *employee = object;
	
	NSLog(@"IRS: %@'s %@ is now %@", employee.name, keyPath, [employee valueForKeyPath:keyPath]);
}

@end
