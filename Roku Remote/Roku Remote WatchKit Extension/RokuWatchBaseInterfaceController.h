//
//  RokuWatchBaseInterfaceController.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "RokuWatchHelpers.h"

@class RokuWatchController;

@interface RokuWatchBaseInterfaceController : WKInterfaceController

@property (nonatomic, strong) RokuWatchController *rokuController;

@end
