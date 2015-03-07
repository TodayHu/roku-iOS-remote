//
//  Roku.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "Roku.h"
#import "AFNetworking.h"

// Roku Routes
#define kRokuKeyPressURLRoute   @"keypress"

@interface Roku ()

@property (nonatomic, strong) NSURL *rokuURL;
@property (nonatomic, assign) NSUInteger rokuPort;
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end


@implementation Roku

+ (instancetype)rokuWithURL:(NSURL *)url port:(NSUInteger)port
{
    Roku *instance = [Roku new];
    
    if (instance)
    {
        instance.rokuURL = url;
        instance.rokuPort = port;
        instance.requestManager = [AFHTTPRequestOperationManager manager];
    }
    return instance;
}

#pragma mark - Public

- (NSURL *)rokuURL
{
    return _rokuURL;
}

#pragma mark - Roku API Implementation

- (BOOL)sendKeyEvent:(NSString *)keyEvent
{
    // Build GET request string
    
    NSString *getRequestURL = [NSString stringWithFormat:@"%@%@/%@", self.rokuURL, kRokuKeyPressURLRoute, keyEvent];
    
    [self.requestManager POST:getRequestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Sent keypress: %@", keyEvent);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error : %@", error);
    }];
    
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
