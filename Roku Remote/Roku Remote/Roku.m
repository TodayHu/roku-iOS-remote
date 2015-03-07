//
//  Roku.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "Roku.h"

@interface Roku ()

@property (nonatomic, strong) NSURL *rokuURL;
@property (nonatomic, assign) NSUInteger rokuPort;

@end


@implementation Roku

+ (instancetype)rokuWithURL:(NSURL *)url port:(NSUInteger)port
{
    Roku *instance = [Roku new];
    
    if (instance)
    {
        instance.rokuURL = url;
        instance.rokuPort = port;
    }
    return instance;
}


#pragma mark - Roku API Implementation

- (BOOL)sendKeyEvent:(NSString *)keyEvent
{
    
    return true;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"Roku IP: %@", [self.rokuURL absoluteString]];
}

- (BOOL)isEqual:(id)other
{
    if ([other isKindOfClass:[Roku class]] && [other respondsToSelector:@selector(rokuURL)] && [other respondsToSelector:@selector(rokuPort)])
    {
        if ([self rokuURL] == [(Roku *)other rokuURL] && [self rokuPort] == [(Roku *)other rokuPort])
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
}

@end
