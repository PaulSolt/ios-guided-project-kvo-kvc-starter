//
//  LSIImageOperation.m
//  KVO KVC
//
//  Created by Paul Solt on 4/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSIImageOperation.h"

@implementation LSIImageOperation

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

//- (void)start {
//    NSLog(@"LSIImageOperation.start");
//}

- (void)main {
    NSLog(@"LSIImageOperation.main Doing work!");
    // once we reach the end, the work is done
    
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"image.size: %@", NSStringFromCGSize(image.size));
    self.image = image;
}


@end
