//
//  NSURL+Roku.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Roku)

+ (NSURL *)urlFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryRepresentation;

@end
