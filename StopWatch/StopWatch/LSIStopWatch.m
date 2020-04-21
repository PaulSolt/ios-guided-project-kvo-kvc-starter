//
//  LSIStopWatch.m
//  StopWatchDemo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIStopWatch.h"


@interface LSIStopWatch ()

@property (nonatomic, readwrite, getter=isRunning) BOOL running;
@property (nonatomic, readwrite) NSTimeInterval elapsedTime;

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSTimer *timer;

@property (nonatomic) NSTimeInterval previouslyAccumulatedTime;


@end

@implementation LSIStopWatch

// Always use _propertyName in your init/dealloc or getter/setter


- (void)start {
    self.startDate = [NSDate date];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(updateTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    
    // MUST Modify KVC compliant properties using self. syntax, not _running!!!!
    self.running = YES;
//    _running = YES;
    
}

- (void)stop {
    self.previouslyAccumulatedTime = self.elapsedTime;
    self.timer = nil;
    self.startDate = nil;
    self.running = NO;
}


- (void)reset {
    [self stop];
    self.elapsedTime = 0;
    self.previouslyAccumulatedTime = 0;
}

- (void)updateTimer:(NSTimer *)timer; {
	// If you pause/start the timer it will keep track of the original
	// time so it doesn't start from 0 each time
	
    self.elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startDate] + self.previouslyAccumulatedTime;

    // DON'T USE _elapsedTime or we don't get events to observe
//    _elapsedTime = [[NSDate date] timeIntervalSinceDate:self.startDate] + self.previouslyAccumulatedTime;
//    NSLog(@"elapsedTime: %0.2f", self.elapsedTime);
}


#pragma mark - Properties

- (void)setTimer:(NSTimer *)timer {
    if (timer != _timer) {
        [_timer invalidate]; // Make sure the previous timer stops
        _timer = timer;
    }
}


@end
