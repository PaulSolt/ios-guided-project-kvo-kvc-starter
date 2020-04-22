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
// Storing a unique value for this code file
void *KVOContext = &KVOContext; // 234939393838 (street address)

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
        
        // if _stopWatch is nil nothing will happen if we call a method
        // no-op= no operation
        [_stopwatch removeObserver:self forKeyPath:@"running" context:KVOContext];
        [_stopwatch removeObserver:self forKeyPath:@"elapsedTime" context:KVOContext];

        _stopwatch = stopwatch;
        
        // didSet
		// Setup KVO - Add Observers
        
        // nullable void * = nullable id (AnyObject?)
        [_stopwatch addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_stopwatch addObserver:self forKeyPath:@"elapsedTime" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
    if isDataValid() {
        return true
    }
    return false
}


// Review docs and implement observerValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) { // Verifies the message is indended for us
        NSLog(@"%@ = %@", keyPath, [object valueForKeyPath:keyPath]);
        
        // How can I update the UI based on changes to the stopwatch properties?
        if ([keyPath isEqualToString:@"running"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"elapsedTime"]) {
            [self updateViews];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
	// Stop observing KVO (otherwise it will crash randomly)
    self.stopwatch = nil; // clear our observers
    
}

@end
