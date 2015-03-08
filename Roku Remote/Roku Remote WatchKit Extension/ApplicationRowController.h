//
//  ApplicationRowController.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

#import "RokuWatchBaseObject.h"

@interface ApplicationRowController : RokuWatchBaseObject

@property (nonatomic, weak) IBOutlet WKInterfaceImage *appIconImage;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *appNameLabel;

@end
