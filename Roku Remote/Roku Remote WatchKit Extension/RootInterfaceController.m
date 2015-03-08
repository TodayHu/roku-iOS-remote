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

- (IBAction)playKeyPressed:(id)sender;
- (IBAction)pauseKeyPressed:(id)sender;
- (IBAction)upKeyPressed:(id)sender;
- (IBAction)downKeyPressed:(id)sender;
- (IBAction)leftKeyPressed:(id)sender;
- (IBAction)rightKeyPressed:(id)sender;
- (IBAction)selectKeyPressed:(id)sender;

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

- (IBAction)playKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyPlay withCompletionHandler:^() {
        
    }];
}

- (IBAction)upKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyUp withCompletionHandler:^() {
        
    }];
}

- (IBAction)downKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyDown withCompletionHandler:^() {
        
    }];
}

- (IBAction)leftKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyLeft withCompletionHandler:^() {
        
    }];
}

- (IBAction)rightKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeyRight withCompletionHandler:^() {
        
    }];
}

- (IBAction)selectKeyPressed:(id)sender
{
    [self.rokuController sendKeyPress:kRokuKeySelect withCompletionHandler:^() {
        
    }];
}


- (void)didDeactivate
{
    [super didDeactivate];
}

@end
