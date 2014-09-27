//
//  StopData.m
//  Travel
//
//  Created by Damien Delay on 05/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "StopData.h"

@implementation StopData
@synthesize stopNo;

+ (id)sharedManager {
    static StopData *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
- (id)init{
    if(self = [super init]){
        stopNo = @"";
    }
    return self;
}

- (void)dealloc{
    // Should never be called, but just here for clarity really.
}


@end
