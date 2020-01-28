//
//  ViewController.m
//  StopWatchDemo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIStopWatch.h"


// Create a KVOContext to identify the StopWatch observer
// void * = id = AnyObject (pointer to any class type)
void *KVOContext = &KVOContext; // 0x123 == 291 // just a number!

// KVO = Key Value Observing
// Listen for changes on a property
// Similar to Notification Center
// Delegate Pattern


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic) LSIStopWatch *stopwatch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stopwatch = [[LSIStopWatch alloc] init];
	[self.timeLabel setFont:[UIFont monospacedDigitSystemFontOfSize: self.timeLabel.font.pointSize  weight:UIFontWeightMedium]];
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.stopwatch reset];
}

- (IBAction)startStopButtonPressed:(id)sender {
    if (self.stopwatch.isRunning) {
        [self.stopwatch stop];
    } else {
        [self.stopwatch start];
    }
}

- (void)updateViews {
    if (self.stopwatch.isRunning) {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
    self.resetButton.enabled = self.stopwatch.elapsedTime > 0;
    
    self.timeLabel.text = [self stringFromTimeInterval:self.stopwatch.elapsedTime];
}


- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger timeIntervalAsInt = (NSInteger)interval;
    NSInteger tenths = (NSInteger)((interval - floor(interval)) * 10);
    NSInteger seconds = timeIntervalAsInt % 60;
    NSInteger minutes = (timeIntervalAsInt / 60) % 60;
    NSInteger hours = (timeIntervalAsInt / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%ld", (long)hours, (long)minutes, (long)seconds, (long)tenths];
}

- (void)setStopwatch:(LSIStopWatch *)stopwatch {
    
    if (stopwatch != _stopwatch) {
        
        // willSet
		// Cleanup KVO - Remove Observers

        // The first time we call this method, _stopwatch is nil
        if (_stopwatch) {
            [_stopwatch removeObserver:self forKeyPath:@"running" context:KVOContext];
            [_stopwatch removeObserver:self forKeyPath:@"elaspedTime" context:KVOContext];
        }
        
        _stopwatch = stopwatch;
        
        // didSet
		
        // Setup KVO - Add Observers
        // context = who is listening (unique to our class)
        
        // In dealloc when we set `self.stopwatch = nil` this will not run
        if (_stopwatch) {
            [_stopwatch addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionInitial context:KVOContext];
            [_stopwatch addObserver:self forKeyPath:@"elapsedTime" options:NSKeyValueObservingOptionInitial context:KVOContext];
        }
    }
    
}


// Review docs and implement observerValueForKeyPath

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) {
        
        if ([keyPath isEqualToString:@"running"]) {
            [self updateViews];
            printf("running.Update UI: %i\n", self.stopwatch.running);
        } else if ([keyPath isEqualToString:@"elapsedTime"]) {
            [self updateViews];
            // %0.2f = 0.00 (decimal place limit)
            printf("elapsedTime.Update UI: %0.2f\n", self.stopwatch.elapsedTime);
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)dealloc {
	// Stop observing KVO (otherwise it will crash randomly)
    self.stopwatch = nil;
}

@end
