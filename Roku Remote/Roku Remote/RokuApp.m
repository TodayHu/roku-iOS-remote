//
//  RokuApps.m
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import "RokuApp.h"
#import "RokuController.h"
#import "Roku.h"

// Dictionary Keys
#define kAppTypeKey         @"__name"
#define kAppDisplayNameKey  @"__text"
#define kAppIDKey           @"_id"
#define kAppVersionKey      @"_version"
#define kAppImageKey        @"kAppImageKey"

#define kIconQueryRequest   @"query/icon/"


@interface RokuApp ()

@property (nonatomic, strong) RokuController *rokuController;

@end

@implementation RokuApp

+ (instancetype)appWithDictionary:(NSDictionary *)dictionary
                andRokuController:(RokuController *)controller
{
    RokuApp *instance = [RokuApp new];
    
    if (instance)
    {
        instance.rokuController = controller;
        [instance parseInformationFromDictionary:dictionary];
    }
    return instance;
}
         
         
- (void)parseInformationFromDictionary:(NSDictionary *)dictionary
{
    _appDisplayName = [dictionary objectForKey:kAppDisplayNameKey];
    _appID          = [[dictionary objectForKey:kAppIDKey] integerValue];
    _appVersion     = [dictionary objectForKey:kAppVersionKey];
    
    NSLog(@"sdfasdf %@", dictionary);
    [self loadApplicationIcon];
}

- (void)loadApplicationIcon
{
    NSString *getRequestURL = [NSString stringWithFormat:@"%@%@%lu", [self.rokuController.currentRoku.rokuURL absoluteString], kIconQueryRequest, (unsigned long)self.appID];
    
    NSMutableURLRequest *requestWithBodyParams = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:getRequestURL]];

    NSError *error;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:requestWithBodyParams returningResponse:nil error:&error];
    
    
    _appIconImage =  [UIImage imageWithData:imageData];
    
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    NSNumber *applicationID = [decoder decodeObjectForKey:kAppIDKey];

    self.appDisplayName = [decoder decodeObjectForKey:kAppDisplayNameKey];
    self.appID          = [applicationID integerValue];
    self.appIconImage   = [decoder decodeObjectForKey:kAppImageKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.appDisplayName forKey:kAppDisplayNameKey];
    [encoder encodeObject:[NSNumber numberWithInteger:self.appID] forKey:kAppIDKey];
    [encoder encodeObject:self.appIconImage forKey:kAppImageKey];
}

@end
