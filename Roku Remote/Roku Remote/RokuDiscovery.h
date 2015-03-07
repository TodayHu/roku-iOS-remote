//
//  RokuDiscovery.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSDPServiceBrowser.h"

@class Roku;

@protocol RokuDiscoveryDelegate <NSObject>

- (void)didFindNewRoku;
- (void)rokuDisappeared;

@end


@interface RokuDiscovery : NSObject <SSDPServiceBrowserDelegate>

+ (instancetype)startDiscoveryWithDelegate:(id<RokuDiscoveryDelegate>)delegate;

// Return an array of Roku objects
- (NSArray *)devices;

@end
