//
//  RokuWatchBaseInterfaceController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/7/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RokuWatchBaseInterfaceController.h"

#import "RokuWatchController.h"

@interface RokuWatchBaseInterfaceController()

@end


@implementation RokuWatchBaseInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self constructContextMenu];
}

- (void)constructContextMenu
{
    [self addMenuItemWithItemIcon:WKMenuItemIconPlay
                            title:@"Remote"
                           action:@selector(showRemoteInterface)];
    
    [self addMenuItemWithItemIcon:WKMenuItemIconMore
                            title:@"Apps"
                           action:@selector(showAppSelectionInterface)];
    
    [self addMenuItemWithItemIcon:WKMenuItemIconTrash
                            title:@"Settings"
                           action:@selector(showSettingsInterface)];
    
    [self addMenuItemWithItemIcon:WKMenuItemIconInfo
                            title:@"About"
                           action:@selector(showAboutInterface)];
}

#pragma mark - Actions

- (void)showRemoteInterface
{
    
}

- (void)showAppSelectionInterface
{
    [self presentControllerWithName:@"AppInterfaceController"
                            context:self.rokuController];
}

- (void)showSettingsInterface
{
    
}

- (void)showAboutInterface
{
    
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



