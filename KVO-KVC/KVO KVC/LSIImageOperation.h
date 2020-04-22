//
//  LSIImageOperation.h
//  KVO KVC
//
//  Created by Paul Solt on 4/21/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIImageOperation : NSOperation

- (instancetype)initWithURL:(NSURL *)url;

@property (nonatomic, nonnull) NSURL *url;
@property (nonatomic, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
