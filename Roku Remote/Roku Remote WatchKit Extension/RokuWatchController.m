//
//  RokuWatchController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RokuWatchController.h"
#import <WatchKit/WatchKit.h>

#import "RokuApp.h"
#import "RokuWatchHelpers.h"

@interface RokuWatchController ()

@property (nonatomic, strong) NSArray *currentRokuApplications;

@end

@implementation RokuWatchController

+(instancetype)watchController
{
    RokuWatchController *instance = [RokuWatchController new];
    
    if (instance)
    {
        
    }
    
    return instance;
}

#pragma mark - Getters

- (NSArray *)rokuApplications
{
    return self.currentRokuApplications;
}


#pragma mark - Parent Application communications

- (void)sendKeyPress:(NSString *)key withCompletionHandler:(completionHandler)handler
{
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObjectsAndKeys:kRequestTypeKeyPress, kRequestTypeKey, key, kKeyType, nil];
    
    [WKInterfaceController openParentApplication:requestDictionary reply:^(NSDictionary *requestResponse, NSError *error)
     {
         handler();
     }];
}

- (void)fetchRokuApplicationsWithCompletionHandler:(applicationsFetchedHandler)handler
{
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObjectsAndKeys:kRequestTypeApplications, kRequestTypeKey, nil];
    
    [WKInterfaceController openParentApplication:requestDictionary reply:^(NSDictionary *requestResponse, NSError *error)
     {
         NSMutableArray *applications = [NSMutableArray new];
         
         NSString *responseType = [requestResponse objectForKey:kResponseTypeKey];
         
         if ([responseType isEqualToString:kResponseTypeApplication])
         {
             NSArray *applicationsData = [requestResponse objectForKey:kResponseDataKey];
             
             for (NSData *applicationData in applicationsData)
             {
                 RokuApp *app = [NSKeyedUnarchiver unarchiveObjectWithData:applicationData];
                 [applications addObject:app];
             }
             _currentRokuApplications = [NSArray arrayWithArray:applications];
             
             handler();
         }
     }];
}

- (void)openApplicationAtIndex:(NSUInteger)index withCompletionHandler:(completionHandler)handler
{
    RokuApp *appAtIndex = [self.rokuApplications objectAtIndex:index];
    
    NSDictionary *requestDictionary = [NSDictionary dictionaryWithObjectsAndKeys:kRequestTypeLaunchApp, kRequestTypeKey, [NSNumber numberWithInteger:appAtIndex.appID], kAppIDKey, nil];
    
    [WKInterfaceController openParentApplication:requestDictionary reply:^(NSDictionary *responseDict, NSError *error) {
        handler();
    }];
}

@end
