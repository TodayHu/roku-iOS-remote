//
//  RokuApps.h
//  Roku Remote
//
//  Created by Tyler J Nettleton on 3/6/15.
//  Copyright (c) 2015 Tyler J Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RokuController;

@interface RokuApp : NSObject

@property (nonatomic, strong) NSString *appDisplayName;
@property (nonatomic, assign) NSUInteger appID;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic, strong) UIImage *appIconImage;

+ (instancetype)appWithDictionary:(NSDictionary *)dictionary
                andRokuController:(RokuController *)controller;

@end
