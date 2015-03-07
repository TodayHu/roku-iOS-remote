//
//  RokuController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RokuController.h"
#import "Roku.h"
#import "RokuApp.h"

#import "NSURL+Roku.h"

#define kPersistantRokuURLKey       @"kPersistantRokuURLKey"
#define kRequestTypeKey             @"kRequestTypeKey"
#define kRequestTypeApplications    @"kRequestTypeApplications"

#define kResponseTypeApplication    @"kResponseTypeApplication"


@interface RokuController ()

@property (nonatomic, strong) Roku *connectedRoku;
@property (nonatomic, strong) NSArray *rokuApplications;

@end


@implementation RokuController

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self reviveLastRoku];
    }
    return self;
}


#pragma mark - Public

- (Roku *)currentRoku
{
    return self.connectedRoku;
}

- (void)handleActionRequestFromWatch:(NSDictionary *)request withHandler:(void (^)(NSDictionary *))handler;
{
    NSString *requestType = [request objectForKey:kRequestTypeKey];
    
    if ([requestType isEqualToString:kRequestTypeApplications])
    {
        [self handleApplicationRequestFromWatchWithHandler:handler];
    }
}

#pragma mark - Watch Interface API

- (void)handleApplicationRequestFromWatchWithHandler:(void (^)(NSDictionary *))handler
{
    [self getRokuApplicationsWithCompletionHandler:^() {
        
        NSMutableArray *archivedApps = [NSMutableArray new];
        
        for (RokuApp *app in self.rokuApplications)
        {
            NSData *appArchivedData = [NSKeyedArchiver archivedDataWithRootObject:app];
            [archivedApps addObject:appArchivedData];
        }
        
        handler([NSDictionary dictionaryWithObjectsAndKeys: kResponseTypeApplication, @"response_type",
                                                            [NSArray arrayWithArray:archivedApps], @"response_data", nil]);
    }];
}


- (void)getRokuApplicationsWithCompletionHandler:(applicationsFetchedHandler)handler
{
    [self.currentRoku getApplicationsFromRokuWith:self andHandler:^(NSArray *applications) {
        _rokuApplications = applications;
        handler();
    }];
}

- (NSArray *)applications
{
    return self.rokuApplications;
}

#pragma mark - Private

- (void)setRokuAsDefaultRoku:(Roku *)roku
{
    if (roku)
    {
        NSURL *rokuURL = [roku rokuURL];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[rokuURL dictionaryRepresentation] forKey:kPersistantRokuURLKey];
        [defaults synchronize];
        
        self.connectedRoku = roku;
    }
}

- (void)reviveLastRoku
{
    // Check for previous roku
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSURL *roku = [NSURL urlFromDictionary:[defaults objectForKey:kPersistantRokuURLKey]];
    
    if (roku)
    {
        Roku *persistedRoku = [Roku rokuWithURL:roku port:[roku.port integerValue]];
        
        [self setRokuAsDefaultRoku:persistedRoku];
    }
}

@end
