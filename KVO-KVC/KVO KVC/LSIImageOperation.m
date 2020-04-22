//
//  LSIImageOperation.m
//  KVO KVC
//
//  Created by Paul Solt on 4/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSIImageOperation.h"

// Class extension
@interface LSIImageOperation ()

// Need to redeclare as readwrite + override the setter to send KVO
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;

@end

@implementation LSIImageOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

/*  Objective-C NSOperation subclass should override isAsynchronous to return YES, then update the ready, executing and finished properties during the NSURLSessionDataTask's execution. These properties are observed by the NSOperationQueue machinery using KVO, and therefore your use of them must be KVO-compliant.
*/

// If we synthesize and make property readwrite, we still need to override setters to
// make KVO notifications for properties

- (void)setExecuting:(BOOL)executing {
    if (_executing != executing) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
        _executing = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
    }
}

- (void)setFinished:(BOOL)finished {
    if (_finished != finished) {
        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
        _finished = YES;
        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
    }
}

// More advanced NSOperation does work async
- (void)start {
    self.executing = YES; // readonly, use our own property with dependent key
    
    NSLog(@"LSIImageOperation.start");

    // Don't start work if we're canceled
    if (!self.isCancelled) {
        NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:self.url resolvingAgainstBaseURL:NO];
        urlComponents.scheme = @"https";
        NSURL *finalURL = urlComponents.URL;
        NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"URL: %@", finalURL);
            if (error) {
                NSLog(@"Error!: %@", error);
                
                // Don't forget to update the state if we fail
                self.executing = NO;
                self.finished = YES;
                self.image = nil;
                return;
            }
            if (!data) {
                NSLog(@"Data is nil");
                
                // Don't forget to update the state if we fail
                self.executing = NO;
                self.finished = YES;
                self.image = nil;
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
            self.image = image;
            
            self.executing = NO;
            self.finished = YES;
        }];
        [task resume];
    }
}

// Override NSOperation properties

- (BOOL)isAsynchronous {
    return YES;
}

@end
