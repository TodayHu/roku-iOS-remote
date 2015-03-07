//
//  NSURL+Roku.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "NSURL+Roku.h"

#define kURLDictionaryKey @"kURLDictionaryKey"

@implementation NSURL (Roku)

+ (NSURL *)urlFromDictionary:(NSDictionary *)dictionary
{
    return [NSURL URLWithString:[dictionary objectForKey:kURLDictionaryKey]];
}

- (NSDictionary *)dictionaryRepresentation
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.absoluteString, kURLDictionaryKey, nil];
}

@end
