//
//  LSIMyOperation.m
//  StopWatch
//
//  Created by Paul Solt on 5/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIMyOperation.h"

@interface LSIMyOperation ()

// 1. redeclare a readyonly property (and synthesize variable)
@property (readwrite, getter=isFinished) BOOL finished;

@end

@implementation LSIMyOperation

// 2. Synthesize it
@synthesize finished = _finished;

// 3. Make KVO method calls with custom setter

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

@end
