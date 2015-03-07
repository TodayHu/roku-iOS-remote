//
//  AppInterfaceController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "AppInterfaceController.h"
#import "ApplicationRowController.h"
#import <QuartzCore/QuartzCore.h>

#import "RokuApp.h"

#define kRequestTypeKey             @"kRequestTypeKey"
#define kResponseTypeKey            @"response_type"
#define kResponseDataKey            @"response_data"
#define kRequestTypeApplications    @"kRequestTypeApplications"
#define kResponseTypeApplication    @"kResponseTypeApplication"

@interface AppInterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *applicationTable;
@property (nonatomic, strong) NSArray *applications;

@end


@implementation AppInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    [self loadApplications];
}

- (void)willActivate
{
    [super willActivate];
}


- (void)populateTable
{
    [self.applicationTable setNumberOfRows:[self.applications count] withRowType:@"AppRow"];
    
    
    [self.applications enumerateObjectsUsingBlock:^(RokuApp *app, NSUInteger index, BOOL *stop) {
       
        ApplicationRowController *row = [self.applicationTable rowControllerAtIndex:index];
        [row.appNameLabel setText:app.appDisplayName];
        [row.appIconImage setImage:app.appIconImage];
        
    }];
}


- (void)loadApplications
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
             _applications = [NSArray arrayWithArray:applications];
             
             [self populateTable];
         }
         
     }];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



