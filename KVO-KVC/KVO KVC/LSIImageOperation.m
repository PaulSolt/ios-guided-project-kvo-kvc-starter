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

@property (nonatomic) BOOL internalIsCanceled;
@property (nonatomic) BOOL internalIsReady;

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
    // TODO: Update isExecuting to YES
    self.internalIsExecuting = YES; // readonly, use our own property with dependent key
    
    // TODO: Deal with canceling
    NSLog(@"LSIImageOperation.start");
    // Use NSURLSession dataTask
    
    
    // TODO: Update isExecuting to NO (async)
    // TODO: Update isFinished to YES
    self.internalIsExecuting = NO;
    self.internalIsFinished = YES;
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
