//
//  ViewController.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "ViewController.h"
#import "RokuDiscovery.h"
#import "RokuController.h"
#import "Roku.h"
#import "RokuApp.h"

@interface ViewController () <RokuDiscoveryDelegate>

@property (nonatomic, strong) RokuController *rokuController;
@property (nonatomic, strong) RokuDiscovery *rokuDiscovery;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rokuDiscovery = [RokuDiscovery startDiscoveryWithDelegate:self];
    
}

#pragma mark - Public setters
- (void)setRokuController:(RokuController *)controller
{
    _rokuController = controller;
}


#pragma mark - RokuDiscoveryDelegate

- (void)didFindNewRoku
{
    NSLog(@"Roku found %@", [self.rokuDiscovery devices]);
    Roku *roku = [[self.rokuDiscovery devices] objectAtIndex:0];
    [self.rokuController setRokuAsDefaultRoku:roku];
    
    [self.rokuController getRokuApplicationsWithCompletionHandler:^() {
        NSArray *applications = [self.rokuController applications];
        
        for (RokuApp *app in applications)
        {
            NSLog(@"App %@", app.appDisplayName);
        }
    }];

}

- (void)rokuDisappeared
{
    NSLog(@"Roku lost %@", [self.rokuDiscovery devices]);
}


#pragma mark - Private
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
