//
//  RootInterfaceController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RootInterfaceController.h"
#import "RokuWatchController.h"
#import "RokuWatchHelpers.h"

@interface RootInterfaceController ()

- (IBAction)homeKeyPressed:(id)sender;

@end

@implementation RootInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    
    self.rokuController = [RokuWatchController watchController];
}

- (void)willActivate
{
    [super willActivate];
}

#pragma mark - IBAction

- (IBAction)homeKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyHome withCompletionHandler:^() {
        
    }];
}



- (void)didDeactivate
{
    [super didDeactivate];
}

@end
