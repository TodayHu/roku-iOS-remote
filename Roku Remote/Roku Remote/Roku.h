//
//  Roku.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

// Roku Keypress definitions
#define kRokuKeyHome            @"home"
#define kRokuKeyRev             @"rev"
#define kRokuKeyFwd             @"fwd"
#define kRokuKeyPlay            @"play"
#define kRokuKeySelect          @"select"
#define kRokuKeyLeft            @"left"
#define kRokuKeyRight           @"right"
#define kRokuKeyDown            @"down"
#define kRokuKeyUp              @"up"
#define kRokuKeyBack            @"back"
#define kRokuKeyInstantReplay   @"instantReplay"
#define kRokuKeyInfo            @"info"
#define kRokuKeyBackspace       @"backspace"
#define kRokuKeySearch          @"search"
#define kRokuKeyEnter           @"enter"

typedef void (^applicationsLoadedHandler)(NSArray *);

@class RokuController;
@class RokuApp;

@interface Roku : NSObject

+ (instancetype)rokuWithURL:(NSURL *)url port:(NSUInteger)port;

- (void)getApplicationsFromRokuWith:(RokuController *)controller
                         andHandler:(applicationsLoadedHandler)handler;
- (BOOL)sendKeyEvent:(NSString *)keyEvent;
- (void)launchApp:(RokuApp *)app;

- (NSURL *)rokuURL;

@end
