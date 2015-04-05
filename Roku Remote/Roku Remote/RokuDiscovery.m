//
//  RokuDiscovery.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RokuDiscovery.h"
#import "Roku.h"
#import "SSDPService.h"


@interface RokuDiscovery ()

@property (nonatomic, strong) id<RokuDiscoveryDelegate> delegate;

@property (nonatomic, strong) SSDPServiceBrowser *SSDPBrowser;

@property (nonatomic, strong) NSMutableArray *avaliableRokus;

@end

@implementation RokuDiscovery

+ (instancetype)startDiscoveryWithDelegate:(id<RokuDiscoveryDelegate>)delegate
{
    RokuDiscovery *instance = [RokuDiscovery new];
    
    if (instance)
    {
        instance.delegate = delegate;
        instance.avaliableRokus = [[NSMutableArray alloc] init];
        
        [instance startDiscovery];
    }
    
    return instance;
}

- (void)startDiscovery
{
    _SSDPBrowser = [[SSDPServiceBrowser alloc] initWithServiceType:@"roku:ecp"];
    
    [self.SSDPBrowser setDelegate:self];
    
    [self.SSDPBrowser startBrowsingForServices];
}

#pragma mark - SSDPBrowserDelegate Implementation

- (void) ssdpBrowser:(SSDPServiceBrowser *)browser didNotStartBrowsingForServices:(NSError *)error
{
    NSLog(@"Error starting discovery process");
}

- (void) ssdpBrowser:(SSDPServiceBrowser *)browser didFindService:(SSDPService *)service
{
    Roku *foundRoku = [Roku rokuWithURL:service.location
                                   port:[service.location.port integerValue]];
    
    if (![self hasNewlyFoundRokuAlreadyBeenFound:foundRoku])
    {
        [self.avaliableRokus addObject:foundRoku];
        [self.delegate didFindNewRoku];
    }
}

- (void) ssdpBrowser:(SSDPServiceBrowser *)browser didRemoveService:(SSDPService *)service
{
    Roku *foundRoku = [Roku rokuWithURL:service.location
                                   port:[service.location.port integerValue]];
    
    if ([self hasNewlyFoundRokuAlreadyBeenFound:foundRoku])
    {
        [self.avaliableRokus removeObject:foundRoku];
        [self.delegate rokuDisappeared];
    }
}

#pragma mark - Public

- (NSArray *)devices
{
    return self.avaliableRokus;
}

#pragma mark - Private

- (BOOL)hasNewlyFoundRokuAlreadyBeenFound:(Roku *)foundRoku
{
    for (Roku *roku in self.avaliableRokus)
    {
        if ([roku isEqual:foundRoku])
        {
            return true;
        }
    }
    return false;
}

@end
