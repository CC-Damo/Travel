//
//  Step3Data.m
//  Travel
//
//  Created by Damien Delay on 04/09/2014.
//  Copyright (c) 2014 DDelay. All rights reserved.
//

#import "Step3Data.h"

@implementation Step3Data
@synthesize stopNo, title;

+ (id)sharedManager {
    static Step3Data *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        stopNo =@"";
        title  =@"";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
