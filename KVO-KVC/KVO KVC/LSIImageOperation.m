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

@property (nonatomic) BOOL internalIsExecuting;
@property (nonatomic) BOOL internalIsFinished;

//@property (nonatomic) BOOL internalIsCanceled; // we don't need to manage, just check to make sure the work still should be done in start/main methods

//@property (nonatomic) BOOL internalIsReady; // we don't need to manage (based on dependent operations)

@end

@implementation LSIImageOperation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

/*  Objective-C NSOperation subclass should override isAsynchronous to return YES, then update the ready, executing and finished properties during the NSURLSessionDataTask's execution. These properties are observed by the NSOperationQueue machinery using KVO, and therefore your use of them must be KVO-compliant.
*/

// More advanced NSOperation does work async
- (void)start {
    self.internalIsExecuting = YES; // readonly, use our own property with dependent key
    
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
                self.internalIsExecuting = NO;
                self.internalIsFinished = YES;
                self.image = nil;
                return;
            }
            if (!data) {
                NSLog(@"Data is nil");
                
                // Don't forget to update the state if we fail
                self.internalIsExecuting = NO;
                self.internalIsFinished = YES;
                self.image = nil;
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
            self.image = image;
            
            self.internalIsExecuting = NO;
            self.internalIsFinished = YES;
        }];
        [task resume];
    }
}

// Override NSOperation properties

- (BOOL)isAsynchronous {
    return YES;
}

// Dependent keys for our KVO compliant properties

- (BOOL)isFinished {
    return self.internalIsFinished;
}

- (BOOL)isExecuting {
    return self.internalIsExecuting;
}

// Class method for dependent keys
+ (NSSet *)keyPathsForValuesAffectingFinished {
    return [NSSet setWithObject:@"internalIsFinished"];
}

+ (NSSet *)keyPathsForValuesAffectingExecuting {
    return [NSSet setWithObject:@"internalIsExecuting"];
}


// Basic NSOperation does all it's work in main
//- (void)main {
//    NSLog(@"LSIImageOperation.main Doing work!");
//    // once we reach the end, the work is done
//
//    NSData *data = [NSData dataWithContentsOfURL:self.url];
//    UIImage *image = [UIImage imageWithData:data];
//    NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
//    self.image = image;
//}


@end
