//
//  Roku.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "Roku.h"
#import "RokuApp.h"
#import "RokuController.h"
#import "AFNetworking.h"
#import "XMLDictionary.h"

// Roku Routes
#define kRokuKeyPressURLRoute   @"keypress"
#define kRokuApplicationQuery   @"query/apps"
#define kRokuApplicationLaunch  @"launch/"

// Dictionary Keys
#define kAppArrayKey        @"app"

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

- (void)getApplicationsFromRokuWith:(RokuController *)controller
                         andHandler:(applicationsLoadedHandler)handler
{
    NSMutableArray *applications = [NSMutableArray new];
    
    NSString *getRequestURL = [NSString stringWithFormat:@"%@%@", self.rokuURL, kRokuApplicationQuery];
    
    self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    self.requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self.requestManager GET:getRequestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *responseDict = [NSDictionary dictionaryWithXMLData:responseObject];
         
         if ([responseDict isKindOfClass:[NSDictionary class]])
         {
             NSArray *appDictionary = [responseDict objectForKey:kAppArrayKey];
             
             for (NSDictionary *app in appDictionary)
             {
                 RokuApp *newApp = [RokuApp appWithDictionary:app
                                            andRokuController:controller];
                 [applications addObject:newApp];
             }
             
             handler([NSArray arrayWithArray:applications]);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error : %@", error);
         
         handler([NSArray new]);
     }];
}

- (void)launchApp:(RokuApp *)app
{
    NSString *getRequestURL = [NSString stringWithFormat:@"%@%@/%lu", self.rokuURL, kRokuApplicationLaunch, (unsigned long)app.appID];
    
    [self.requestManager POST:getRequestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
     }];
    
}

- (BOOL)sendKeyEvent:(NSString *)keyEvent
{
    // Build GET request string
    
    NSString *getRequestURL = [NSString stringWithFormat:@"%@%@/%@", self.rokuURL, kRokuKeyPressURLRoute, keyEvent];
    
    [self.requestManager POST:getRequestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Sent keypress: %@", keyEvent);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"Error : %@", [error localizedDescription]);
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
