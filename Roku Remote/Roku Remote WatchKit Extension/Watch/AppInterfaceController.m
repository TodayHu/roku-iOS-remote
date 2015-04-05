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

#import "RokuWatchController.h"
#import "RokuApp.h"



@interface AppInterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *applicationTable;
@property (nonatomic, strong) NSArray *applications;

@end


@implementation AppInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    // Context should be an instance of RokuWatchController
    if ([context isKindOfClass:[RokuWatchController class]])
    {
        self.rokuController = context;
        
        [self.rokuController fetchRokuApplicationsWithCompletionHandler:^()
        {
            _applications = self.rokuController.rokuApplications;
            [self populateTable];
        }];
    }
}

- (void)willActivate
{
    [super willActivate];
}


#pragma mark - Table controller

- (void)populateTable
{
    [self.applicationTable setNumberOfRows:[self.applications count] withRowType:[AppInterfaceController applicationRowType]];
    
    [self.applications enumerateObjectsUsingBlock:^(RokuApp *app, NSUInteger index, BOOL *stop) {
        ApplicationRowController *row = [self.applicationTable rowControllerAtIndex:index];
        [row.appNameLabel setText:app.appDisplayName];
        [row.appIconImage setImage:app.appIconImage];
        
    }];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    [self.rokuController openApplicationAtIndex:rowIndex withCompletionHandler:^()
    {
       [self dismissController];
    }];
}

#pragma mark - Private

+ (NSString *)applicationRowType
{
    return @"AppRow";
}

- (void)didDeactivate
{
    [super didDeactivate];
}

@end



