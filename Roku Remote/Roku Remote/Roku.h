//
//  Roku.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

// Roku Keypress definitions
#define kRokuKeyHome            @"Home"
#define kRokuKeyRev             @"Rev"
#define kRokuKeyFwd             @"Fwd"
#define kRokuKeyPlay            @"Play"
#define kRokuKeySelect          @"Select"
#define kRokuKeyLeft            @"Left"
#define kRokuKeyRight           @"Right"
#define kRokuKeyDown            @"Down"
#define kRokuKeyUp              @"Up"
#define kRokuKeyBack            @"Back"
#define kRokuKeyInstantReplay   @"InstantReplay"
#define kRokuKeyInfo            @"Info"
#define kRokuKeyBackspace       @"Backspace"
#define kRokuKeySearch          @"Search"
#define kRokuKeyEnter           @"Enter"


// Roku Routes
#define kRokuKeyPressURLRoute   @"keypress"


@interface Roku : NSObject

+ (instancetype)rokuWithURL:(NSURL *)url port:(NSUInteger)port;

- (BOOL)sendKeyEvent:(NSString *)keyEvent;

@end
