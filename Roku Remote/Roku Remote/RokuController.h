//
//  RokuController.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Roku;

typedef void (^watchRequestHandler)(NSDictionary*);

@interface RokuController : NSObject

- (Roku *)currentRoku;

- (void)setRokuAsDefaultRoku:(Roku *)roku;

- (void)handleActionRequestFromWatch:(NSDictionary *)request withHandler:(void (^)(NSDictionary *))handler;

@end
