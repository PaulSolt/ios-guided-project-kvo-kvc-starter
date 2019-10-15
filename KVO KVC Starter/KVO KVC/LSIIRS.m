//
//  LSIIRS.m
//  KVO KVC
//
//  Created by Paul Solt on 10/15/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIIRS.h"
#import "LSIEmployee.h"

@interface LSIIRS ()

// Private
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
	
	[employee addObserver:self forKeyPath:@"salary" options:0 context:NULL]; // QUESTION: nil vs. NULL
	
	[self.monitoredEmployees addObject:employee];
}

- (void)stopMonitoringEmployee:(LSIEmployee *)employee {
	if ([self.monitoredEmployees containsObject:employee]) {
		[employee removeObserver:self forKeyPath:@"salary" context:NULL]; // NOTE: Will crash if not observering!!!
		
		[self.monitoredEmployees removeObject:employee];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	
	if ([keyPath isEqualToString:@"salary"]) {
		LSIEmployee *employee = object;
		NSLog(@"IRS: %@'s %@ is %@", employee.name, keyPath, [employee valueForKeyPath:keyPath]);
	}
}

- (void)dealloc {
	printf("IRS: dealloc");
	// stop monitoring all employees
	for (LSIEmployee *employee in self.monitoredEmployees) {
		[self stopMonitoringEmployee:employee];
	}
}


@end
