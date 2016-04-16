//
//  ExtendedIAPHelper.m
//  IAP-Example
//
//  Created by Nestor Bermudez Sarmiento on 4/15/16.
//  Copyright © 2016 Nestor Bermudez. All rights reserved.
//

#import "ExtendedIAPHelper.h"
#import "Constants.h"

@implementation ExtendedIAPHelper

+(ExtendedIAPHelper*) sharedInstance
{
    static dispatch_once_t once;
    static ExtendedIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kProductOne,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
