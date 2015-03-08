//
//  RokuWatchController.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RokuWatchHelpers.h"

typedef void (^applicationsFetchedHandler)();
typedef void (^completionHandler)();

@interface RokuWatchController : NSObject

+(instancetype)watchController;

// Application Fetching
- (void)fetchRokuApplicationsWithCompletionHandler:(applicationsFetchedHandler)handler;
- (void)openApplicationAtIndex:(NSUInteger)index withCompletionHandler:(completionHandler)handler;
- (NSArray *)rokuApplications;

// Key Commands
- (void)sendKeyPress:(NSString *)key withCompletionHandler:(completionHandler)handler;

@end
